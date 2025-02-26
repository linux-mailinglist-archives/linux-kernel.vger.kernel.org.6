Return-Path: <linux-kernel+bounces-533719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE3A45E14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33654168E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9321D3D9;
	Wed, 26 Feb 2025 12:01:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB3217F36
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571310; cv=none; b=L9Ox6TWDwhy4Kj0zPdS27VgpM8gYwYtSuUXndFI7X//rkTr2IDtEK6KHKVutrFvVctMhlN7es0CKseVruqNw/8a3+dSIxsB81mMw+pYdOSoIB/AxecTJcxdPVJra2a9z4v5qb4PWPtTUe46HTURH0ak/4lSLDqONc3awupxeMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571310; c=relaxed/simple;
	bh=uSX+HLNVKuz3OtxOWFNAhOjTNngq2uZA6QqEUZbceko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I6py2c/80Vfsjc4F1lgSpCYRCr/MMErOsStJXnjQOJ1ifZT6RzeFkapH4XyRgqNyUrXDPFiCzJi7sZWicf4DwBR1XZvdc8XqTm81Yp2aJ6MFHM9AGKXOcJImarsfVMBDoJSnR3iFpj2bKzp5kZRSH2zRlmP8/9Zi6YXQTyUQamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-e5-67bf02a658e0
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
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
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 07/25] mm: introduce luf_ugen to be used as a global timestamp
Date: Wed, 26 Feb 2025 21:01:14 +0900
Message-Id: <20250226120132.28469-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBqeuqVjMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV0bzqwusBe9EK570nmNsYLwh2MXI
	ySEhYCJxdf4zdhj71YmfLCA2m4C6xI0bP5lBbBEBM4mDrX+Aarg4mAWWMUnsPdHABpIQFqiT
	2LP4FFgzi4CqxNymD2ANvAKmEn9ftrNADJWXWL3hAFicE2jQv92/weqFBJIlWtb/ZgEZKiFw
	m01i3cKrrBANkhIHV9xgmcDIu4CRYRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYFgvq/0TvYPx
	04XgQ4wCHIxKPLwPzuxNF2JNLCuuzD3EKMHBrCTCy5m5J12INyWxsiq1KD++qDQntfgQozQH
	i5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDI8OV5vXM9kcfzHxh5eYz7bzQx/c1B14UPdHy
	O1zU5Szb3147U+poxKsk52+nkn4LH5vgYvWZ1WTC2mreHW9NStT2y16WFbBq7b67TWeOo+KT
	46lf510o0qtg22V6+8DXzF01pRc+Ti20ObTtQ7v8Ls29LTPyM3bsPpzzp1vTXnoBq9yDiKr5
	h5RYijMSDbWYi4oTAWFdUNZnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wemP0hZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBlNL+6wFrwTrTi
	Se85xgbGG4JdjJwcEgImEq9O/GQBsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	kISwQJ3EnsWn2EFsFgFViblNH8AaeAVMJf6+bGeBGCovsXrDAbA4J9Cgf7t/g9ULCSRLtKz/
	zTKBkWsBI8MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwCBdVvtn4g7GL5fdDzEKcDAq8fA+
	OLM3XYg1say4MvcQowQHs5IIL2fmnnQh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJ
	JanZqakFqUUwWSYOTqkGxjRprpfy61ZX31/ldHqa5/pFHmt0ktwKO+V/Lbr18tK1umbnHrkk
	7V9bNA27uQ+a626vie62fj2rvWnOgTV3L356YvDJtKRlcSP/vlyFDYf3az/l8FFk/d+doKbY
	IBM298bFD6GlLZv6uCbaS/9KNTzy59e/vcEVf0+pHA9s2V64IcKz4IHZdiWW4oxEQy3mouJE
	ABhXBHZOAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
needs to evaluate the temporal sequence of events to determine whether
tlb flush required has been done on each CPU.

To achieve that, this patch introduced a generation number, luf_ugen,
and a few APIs manipulating the number.  It's worth noting the number is
designed to wraparound so care must be taken when using it.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h | 34 ++++++++++++++++++++++++++++++++++
 mm/rmap.c          | 22 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d82feabbe44f8..74a37cb132caa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4240,4 +4240,38 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
 int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
+#if defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+/*
+ * luf_ugen will start with 2 so that 1 can be regarded as a passed one.
+ */
+#define LUF_UGEN_INIT 2
+
+static inline bool ugen_before(unsigned long a, unsigned long b)
+{
+	/*
+	 * Consider wraparound.
+	 */
+	return (long)(a - b) < 0;
+}
+
+static inline unsigned long next_ugen(unsigned long ugen)
+{
+	if (ugen + 1)
+		return ugen + 1;
+	/*
+	 * Avoid invalid ugen, zero.
+	 */
+	return ugen + 2;
+}
+
+static inline unsigned long prev_ugen(unsigned long ugen)
+{
+	if (ugen - 1)
+		return ugen - 1;
+	/*
+	 * Avoid invalid ugen, zero.
+	 */
+	return ugen - 2;
+}
+#endif
 #endif /* _LINUX_MM_H */
diff --git a/mm/rmap.c b/mm/rmap.c
index 546b7a6a30a44..8439dbb194c8c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -634,6 +634,28 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+/*
+ * This generation number is primarily used as a global timestamp to
+ * determine whether tlb flush required has been done on each CPU.  The
+ * function, ugen_before(), should be used to evaluate the temporal
+ * sequence of events because the number is designed to wraparound.
+ */
+static atomic_long_t __maybe_unused luf_ugen = ATOMIC_LONG_INIT(LUF_UGEN_INIT);
+
+/*
+ * Don't return invalid luf_ugen, zero.
+ */
+static unsigned long __maybe_unused new_luf_ugen(void)
+{
+	unsigned long ugen = atomic_long_inc_return(&luf_ugen);
+
+	if (!ugen)
+		ugen = atomic_long_inc_return(&luf_ugen);
+
+	return ugen;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
-- 
2.17.1


