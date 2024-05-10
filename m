Return-Path: <linux-kernel+bounces-175350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815F8C1E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A85E2B2176E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330715E81C;
	Fri, 10 May 2024 06:52:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59B1487F7
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323949; cv=none; b=A0ifBAypLnmP68sCxNUo36v7GucUKbBCvc+QrAb+x5iF+NLauJfMY953jSCi6gxkCzglxlyedYHnB8Y72z0RWULKlVOp3oRJZre+haRXNsbYu8vZ6HNMdB7RNZ5KmbcC1BI+F6r6RiKvn2u1MCT6PsvxDBDVKbcuDdv3PfOYj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323949; c=relaxed/simple;
	bh=6cD35mEyKwclK8bRNTmdyMxP37PfjcwjlbBbEy4ouTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=THPlFykpc+BpxpiEbkQ0JBKmdT6jpxSAm3WfB3eb6ADMkDOTcdvBrcfXaEys6k7lz30HTKt+6nSNSLFFY3Td6BILZdMEKBCvyPGOUnetfJ9MPywMSd6TWNs1hToqUgxHr8yZu5C7+DnIOnOCsQBmpjFV3Z4c8aguSUIPrZdmGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-c4-663dc4212db8
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
Subject: [PATCH v10 01/12] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Fri, 10 May 2024 15:51:55 +0900
Message-Id: <20240510065206.76078-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoa7iEds0gyXrJC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	yf4NTAVvBCrOPJ3H3sA4h6+LkZNDQsBE4serPkYYe+WfVewgNpuAusSNGz+ZQWwRATOJg61/
	wOLMAneZJA70s3UxcnAIC/hL3DnAChJmEVCV6Jn3H8zmFTCV2PrvAjPESHmJ1RsOgNmcQGM+
	LJvBBGILAdV0PJgItJYLqOYzm8TS9d1MEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVe
	ZoVecn7uJkZg4C+r/RO9g/HTheBDjAIcjEo8vDs226QJsSaWFVfmHmKU4GBWEuGtqrFOE+JN
	SaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBYca0w+sEKkTpO
	w3Vc07iOhc1evMD/jf9krhcvdJ6dYjsn1/Q5SKL19iLOJd2/7vRVn9Y9MjX27Lxiw6ux28W4
	3r/iWt+alCYWtsv+6nwzP/WrP5u1zI05Hq2NlgqYcWE7k9bvoD72op3qNzY/4te+lKg179Ma
	vwsSXWky2anGG50Cbp+7VqGnxFKckWioxVxUnAgA+SxPCngCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbNoG8Wr8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mk72b2AqeCNQcebpPPYGxjl8XYycHBICJhIr/6xiB7HZBNQlbtz4yQxiiwiY
	SRxs/QMWZxa4yyRxoJ+ti5GDQ1jAX+LOAVaQMIuAqkTPvP9gNq+AqcTWfxeYIUbKS6zecADM
	5gQa82HZDCYQWwiopuPBRMYJjFwLGBlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbxsto/
	E3cwfrnsfohRgINRiYd3x2abNCHWxLLiytxDjBIczEoivFU11mlCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjAdD91Z9u/mx0/1X8I/jh7y7GsNDhR3v
	pGTVrdj47sfC1WpNtzXjCv4snDaldsakQ6vk3EJzTj7nygovndrk9n77XcHg95LLP7ce73r3
	q+Lrmnsqh+YUPZ1Ut+ygosDqz/ueTDyhZBOzxK9vltMMLT2BJXWh4fHLivsPbr849+Idh61W
	OXbdS/iUWIozEg21mIuKEwE4VGM2XwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read-only and were unmapped, since
the contents of the folios wouldn't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that needs to recognize
read-only tlb entries by separating tlb batch arch data into two, one is
for read-only entries and the other is for writable ones, and merging
those two when needed.

It also optimizes tlb shootdown by skipping CPUs that have already
performed tlb flush needed since.  To support it, added APIs
manipulating arch data for x86.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..a14f77c5cdde 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -293,6 +294,23 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)
-- 
2.17.1


