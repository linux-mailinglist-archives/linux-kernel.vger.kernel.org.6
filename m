Return-Path: <linux-kernel+bounces-183342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C658C97D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CD81C204FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DAEACE;
	Mon, 20 May 2024 02:17:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E87BC8CE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171477; cv=none; b=ACSupKbKJ+rVZvcqfDkWL0aN+gqCQC8n9SAqQNb938coRyh+9unVfGmdVAXa+97BYXQZ19oBjOZscWT8MG1JYjg1nPGL4K0VRgv4qIB5vxuX0wWCJMKJ2zN3oJi487NmjlDfJkUim9MkJNrs3ph2Px6pGPVFsF2hq253+6d9WWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171477; c=relaxed/simple;
	bh=6cD35mEyKwclK8bRNTmdyMxP37PfjcwjlbBbEy4ouTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ayqXzyuOb7VBFuk856JelhmYMt9LLgCBqIHPym8EO9bbK1QiNqjdiLz+V484PXbPm5tkn3rvD9/Mq/xzL8nvzbPvvjWDSDY5UPZleOZrgqnoWBorksOKciPms52MJ8UiB5jyiNLSCUC7VUUMcL0EVIWQtyVexfT5RaY+ckO1muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-9a-664ab2c8f665
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
Subject: [RESEND PATCH v10 01/12] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Mon, 20 May 2024 11:17:23 +0900
Message-Id: <20240520021734.21527-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoe6JTV5pBlP3WlrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	k/0bmAreCFSceTqPvYFxDl8XIyeHhICJxLfry5hh7Dv7V7GD2GwC6hI3bvwEi4sImEkcbP0D
	FmcWuMskcaCfrYuRg0NYIEyia68kSJhFQFXi595/7CBhXgFTiT0nlSEmykus3nAAbAon0JQZ
	q3aygNhCQCU/jn4FmsIFVPOeTeLd/C4WiAZJiYMrbrBMYORdwMiwilEoM68sNzEzx0QvozIv
	s0IvOT93EyMw7JfV/onewfjpQvAhRgEORiUe3h2PPNOEWBPLiitzDzFKcDArifBu2gIU4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwLh88623XLuf1xx+
	4nCgb8Zh2+6ieEm1B7kiuyeuc/+d+z8/7JJ8Q+duthmZ+aLBV988WFP8T7D4OrOS+j0nnbLX
	6yLcdE/tOhPe/cXKct5bE0Mf7v7drku2aEVbiNmuv5F3mpv7+LcFh1ZdaZnuFlQseI2TrYxb
	qTb5R37So2eJu38LWj090KLEUpyRaKjFXFScCAC3hbI8dwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrHtik1eawap7OhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyjjZv4Gp4I1AxZmn89gbGOfwdTFyckgImEjc2b+KHcRmE1CXuHHjJzOILSJg
	JnGw9Q9YnFngLpPEgX62LkYODmGBMImuvZIgYRYBVYmfe/+xg4R5BUwl9pxUhpgoL7F6wwGw
	KZxAU2as2skCYgsBlfw4+pVtAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIFBvKz2
	z8QdjF8uux9iFOBgVOLh3XDbM02INbGsuDL3EKMEB7OSCO+mLUAh3pTEyqrUovz4otKc1OJD
	jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxrx9Rwvbpp6yK+u6cTZo77fTcRGJemr6
	F3U46vztUzd/qX3Z+HGV6pMryQ/fskm937CFtzHfKl4+8gRPd2im8Gv+unOOX+78boi3Yiwp
	kdr78+/N/cEHf0rvi26Iu1b22/nEQ+ZN36OYkit5O35FzjcqUy3dZChcmLX3z3KZg5F+OxJX
	XlSfqsRSnJFoqMVcVJwIABWbBh5eAgAA
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


