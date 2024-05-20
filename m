Return-Path: <linux-kernel+bounces-183339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6208C97D0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E16280EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9309474;
	Mon, 20 May 2024 02:17:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E814C2ED
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171476; cv=none; b=i+yLlgosCMgz3CwEf2wRkHAyFUybMpmg/5UB0yBtzGoZcg2okv8aVV7QwqupQhDx+zJ7RxLsxT+lMSgp/TbyVxMY8e/uz5uAMMd2DynAmXQIbgUiLdtcNLWppztov1v3EzTqCRwGOEkMZ0fEg8L3rfTMJLJLWyyZzdWO5wNRVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171476; c=relaxed/simple;
	bh=rQZiU0CNXQyRU5Wz05SQq2QflCX9irEmFt30HXPbKHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nT1UYCjVtYLR/H6rpKCGmyoDG7XdIBNrP5ZPfMAedmM9d39aY0ZP4BGj9oIZiK9MfwTgzzD3og28keE7zYNMv6GODvDMdDrZpFbYmmWjoqoNQ9oFtUcZwcdsV8RAX8/+74MrPgTB4BCDVSYbF43LoaL/IWXYWAwot9h0dc9rXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-9f-664ab2c844b4
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RESEND PATCH v10 02/12] arm64: tlbflush: add APIs manipulating tlb batch's arch data
Date: Mon, 20 May 2024 11:17:24 +0900
Message-Id: <20240520021734.21527-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnke6JTV5pBq0LLC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	gYZ9LAWLeSuutqo2MP7m6mLk5JAQMJG4//sYUxcjB5g9d0Y9SJhNQF3ixo2fzCC2iICZxMHW
	P+wgNrPAXSaJA/1sILawQJxE67XvYDaLgKrEq3cnwep5BUwlpnx5xQgxXl5i9YYDYHFOoDkz
	Vu1kAbGFgGp+HP0K1MsFVPOeTeLgzJUsEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVe
	ZoVecn7uJkZg2C+r/RO9g/HTheBDjAIcjEo8vDseeaYJsSaWFVfmHmKU4GBWEuHdtAUoxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgdHwpBVvvddEGzm/
	1glcCSf62V6VLy/l6VSzSeuUbtx69lE5W/AW0+QpVybZzp4VFHPg3pVPn6xu39bJ3xlf+Pwh
	w+67udLfGeRXq4t8MuvRM7D9zBw3dyEL2+YcbyOzhrfuKhtuMSQlKPtPaT2cN3mbiqNQLI/T
	wVcLWr2dBfd/Dk2ut9rfq8RSnJFoqMVcVJwIALG4RNt3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrHtik1eaQecafYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZRxo2MdSsJi34mqragPjb64uRg4OCQETibkz6rsYOTnYBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONDPBmILC8RJtF77DmazCKhKvHp3EqyeV8BUYsqXV4wgtoSAvMTqDQfA
	4pxAc2as2skCYgsB1fw4+pVtAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBvKz2
	z8QdjF8uux9iFOBgVOLh3XDbM02INbGsuDL3EKMEB7OSCO+mLUAh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxtrTk2zis81l7UP2SM7PVYqRCBQR7v7g
	8vtI0wqJPaUBunM3iH1+ddwi+fgyifLcipiQ/c7dnRbtG2tZGj0NZD82T9v2e5Kfhfn7Hje2
	Z049Mwz0Elx4+PVUhWoznsw7It8TJXApR6L+o0+RgV7tjaUT0pr3vYldJvn0QXTZkUvv2ur5
	+xKUWIozEg21mIuKEwHkHhI9XgIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that requires to manipulate tlb
batch's arch data.  Even though arm64 does nothing for tlb things, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index a75de2665d84..b8c7fbc1c68e 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -347,6 +347,24 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* Kernel can consider tlb batch always has been done. */
+	return true;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


