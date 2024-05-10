Return-Path: <linux-kernel+bounces-175349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4D8C1E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A2B28413B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267815747E;
	Fri, 10 May 2024 06:52:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A547F9C9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323948; cv=none; b=rRTsdSyHhQH4b/tAThoj8j7dgsCf5VyHBwGRo6QiS4HCdg2nHd6fmFlViDkQWav49w5exeRFQ/cmAXoD5OrxZZRZonuwqDC5r2Il+YogTyUR9LZm5k1KBTGSqFFEUvfragEKyzasIQsXQyvwy8Z5bsS5Hlz2K0AM49Dp4txEWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323948; c=relaxed/simple;
	bh=rQZiU0CNXQyRU5Wz05SQq2QflCX9irEmFt30HXPbKHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BUNDEqk2Q/oEGdeTJXkjLoRmKli5LjGOBjzjHF3yI4qLz9d27K9L2rh+Eif2xzKnkpPzWXgxnk7xAQmmeWrz+QwwSmwVvjUgMzTHWXqotLb/n1eX9v93ZvBOVqIzh5DSCCkx4JUHkimRhjknQBn2hl6P8WzDwcvxAoDRO1X/pTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-c9-663dc4216273
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
Subject: [PATCH v10 02/12] arm64: tlbflush: add APIs manipulating tlb batch's arch data
Date: Fri, 10 May 2024 15:51:56 +0900
Message-Id: <20240510065206.76078-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnka7iEds0g93/JS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	gYZ9LAWLeSuutqo2MP7m6mLk5JAQMJFYeO0ME4z9/8wkZhCbTUBd4saNn2C2iICZxMHWP+wg
	NrPAXSaJA/1sILawQLjE820/wHpZBFQl7r1tAYvzCphKLL89CWqmvMTqDQfA5nACzfmwbAZY
	XAiopuPBRMYuRi6gmvdsEit2d7JANEhKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZlXmZFXrJ
	+bmbGIGBv6z2T/QOxk8Xgg8xCnAwKvHw7thskybEmlhWXJl7iFGCg1lJhLeqxjpNiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6MM8zM/a6H6lXJ2/woC
	tGZMUhG1/XxQfvuGp203Jep17GRLzl2a+XZXtDOLuld4aOCljftcdjFeU0qRPVDWlvB+2zNR
	wxb7Y9ETyztmPZN5eJuRk/9XRP6/53r755smqZX2BGo/9tjHYbx4lsj8Jy9n5pnuvBq2UPpO
	Imfs5YPHt83er3Awa7kSS3FGoqEWc1FxIgDhDmkHeAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbN4N4bfos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZRxo2MdSsJi34mqragPjb64uRk4OCQETif9nJjGD2GwC6hI3bvwEs0UEzCQO
	tv5hB7GZBe4ySRzoZwOxhQXCJZ5v+8EEYrMIqErce9sCFucVMJVYfnsSE8RMeYnVGw6AzeEE
	mvNh2QywuBBQTceDiYwTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzjZbV/Ju5g
	/HLZ/RCjAAejEg/vjs02aUKsiWXFlbmHGCU4mJVEeKtqrNOEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGB+8UK0JK5gwZdb0TcdLI2xl9t4y2LzKyu1P
	5zIdeYWcHVsWHb45UcZu8pkI3+epxvMrPS85p199qzXjcrHitZ7jk9a6Hniy/8iFeQcnC9a8
	TrDSFrnpIXDuGMOWCULrjqks/8gt0Lx4wpEvH1ce+MHiWq8Rsn3pfa2lX5fEPdmdZn7U3yLl
	gNQGJZbijERDLeai4kQAKk35H18CAAA=
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


