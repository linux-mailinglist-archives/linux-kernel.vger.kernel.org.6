Return-Path: <linux-kernel+bounces-522984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6AA3D0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846603BA970
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663391E376C;
	Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B025524F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029763; cv=none; b=JLHsJj3f6yE4Z4PEx2kjneOUy+K21WnI20lS6vuygrWOjy6k6+U0FKH12Sc34gfzUUky5RLdJMgl5zjy0DNVpuOIo9amQGVZDrQHXtmc5TlWL3O8mLTAIVytRbZDhxW3Sa1NxClj2sZAlH1xH/kV0ahXB9VDF8akkxTm50uSPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029763; c=relaxed/simple;
	bh=9VwKof6fdvIRikGVrT0fSu5yYaV9J0zhI9erH9jRXZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SkqlAV3QR6fmOXP25H43zdQHFXOHUJA+NEwYWwe3/eBGmfwDKdB8+z6j1zIXKwIZIcq74bbnZwrBrmv+7dKVyOHBqwTM7hQ2ud4Iwn7SUCE6d18RCDUyQ0ijm5BhKLBRtTkuVnuoafGe//r2eo48E/gEnm1oH9wn8Hzf9hy/OAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-b5-67b6bba69892
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
Subject: [RFC PATCH v12 02/26] arm64/tlbflush: add APIs manipulating tlb batch's arch data
Date: Thu, 20 Feb 2025 14:20:03 +0900
Message-Id: <20250220052027.58847-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDU6vE7aYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	G24vZC34y1dxu/U4cwPjUp4uRk4OCQETiR9bd7LD2Luv9YPZbALqEjdu/GQGsUUEzCQOtv4B
	izML3GWSONDPBmILC0RJNHf/ZwKxWQRUJTY2fmHtYuTg4BUwlWjpSYcYKS+xesMBsDGcQGN+
	zOgFaxUCKnm34BJQKxdQzWc2iWUnNzNDNEhKHFxxg2UCI+8CRoZVjEKZeWW5iZk5JnoZlXmZ
	FXrJ+bmbGIGBv6z2T/QOxk8Xgg8xCnAwKvHwzmjdli7EmlhWXJl7iFGCg1lJhLetfku6EG9K
	YmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkYzxvKM++ElBjNj
	XpUaXuO5yS+xOplHdsuJkuVicwxbnsve3N3ApRMYvynlfurFkNxHn9b8njqD45O9iE79idNB
	4pEtKQuWf9y9z9hour/aO5bo1jeHjGJMn7f7avWtiv7z6pDk6Yl9d924l/G+/cfqoHhmH/du
	NY/QiuuHorMXHmKpkm+pVFZiKc5INNRiLipOBABZvryXeAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0gyf9XBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgythweyFrwV++itutx5kbGJfydDFyckgImEjsvtbPDmKzCahL3LjxkxnEFhEw
	kzjY+gcszixwl0niQD8biC0sECXR3P2fCcRmEVCV2Nj4hbWLkYODV8BUoqUnHWKkvMTqDQfA
	xnACjfkxoxesVQio5N2CS0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzjZbV/
	Ju5g/HLZ/RCjAAejEg/vg8db04VYE8uKK3MPMUpwMCuJ8LbVb0kX4k1JrKxKLcqPLyrNSS0+
	xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYJQ3mfVKIE73q1qxlZOVgA3TM5+fvZyZ
	L0RMv0zmtj9wO3m+/cLPrzTF6j8wtG2euMkn8aThonNCKl8+Tv33UJLj2r7Te/5dN9hQUqCz
	IL/rddJfCY/+/nMPatevexe/xYzv9pLr3RG3r9eI2E1kzo/akz775payvNUVbFY+Fzh+sVxY
	8LP9pIgSS3FGoqEWc1FxIgDPhFPrXwIAAA==
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
 arch/arm64/include/asm/tlbflush.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 95fbc8c056079..a62e1ea61e4af 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -354,6 +354,33 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
+static inline bool arch_tlbbatch_need_fold(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm)
+{
+	/*
+	 * Nothing is needed in this architecture.
+	 */
+	return false;
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


