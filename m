Return-Path: <linux-kernel+bounces-533743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB91A45E31
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A6A189A86B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF9821E08B;
	Wed, 26 Feb 2025 12:03:52 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5321A425
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571432; cv=none; b=moT7d4Vn8ogtWtJR1cBw2FCLUHIT/KViLmZWhKvDfu0XBnU/7dq6F0ZUNnY9HFVeA7cTp2tGidRP4twYe02vR3XYMlKVfjRwn9eP7m6oymObypwjSVetNdPAV0QJZcp/6Qwb2Go3DN5R3znf34qf72a3Ysy1ywdKeibLS7qE540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571432; c=relaxed/simple;
	bh=AI8KzdVgDo3mMhBeNPeH68ATHjEiC1BiJojhkl0I6w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=anLH+X6syu+XhJR+VDSswCfzrzr0JlIu2wgtSEWZEYz48EWJ+EhVNbCqpdunOMiqNXnuhE+yBLKoH52C0QLVjv8sHvMDNb3Yu8C1nhhS6CBBI6xIIBnXXW7CGUWd2Xud2qQ03KnhO8VrxDdhDBIu3/3g3Mee48sqbdiQsVABPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-14-67bf032243b6
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
Subject: [RFC PATCH v12 based on v6.14-rc4 07/25] mm: introduce luf_ugen to be used as a global timestamp
Date: Wed, 26 Feb 2025 21:03:18 +0900
Message-Id: <20250226120336.29565-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsXC9ZZnoa4S8/50g55+DYs569ewWXze8I/N
	4uv6X8wWTz/1sVhc3jWHzeLemv+sFud3rWW12LF0H5PFpQMLmCyO9x5gsph/7zObxeZNU5kt
	jk+Zymjx+8ccNgc+j++tfSweO2fdZfdYsKnUY/MKLY9NqzrZPDZ9msTu8e7cOXaPEzN+s3i8
	33eVzWPrLzuPxqnX2Dw+b5IL4InisklJzcksSy3St0vgyphw4yVTwTvRinszt7I3MN4Q7GLk
	5JAQMJE4NecpSxcjB5i9/3Y1SJhNQF3ixo2fzCC2iICZxMHWP+xdjFwczALLmCT2nmhgA0kI
	C2RKvOvewQ5iswioSpy8f5YdZA6vgKnExK2SEOPlJVZvOAA2hxNozqdpx8BahQSSJXb+/sME
	MlNC4DGbxNTWXWwQDZISB1fcYJnAyLuAkWEVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmBIL6v9
	E72D8dOF4EOMAhyMSjy8D87sTRdiTSwrrsw9xCjBwawkwsuZuSddiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA+Oahx8ZVkjfP87m9y1v38kXD7bw3Gy/
	rmDtPnvejXMfeMtWqfoIvlnZemk73/eJ3uvntWwT6d/t9TWm6syeisqvKt/XGrQHLj1bdMen
	7kTHfG23LcuK9G1EFFwP+ei6lnZ+e1ayOf7xqoOdr8Quz4lMaZyjsf9HQoTZch+zV/78Xy71
	7u9kviSpxFKckWioxVxUnAgA1zaIxGUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYPYyeYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyJtx4yVTwTrTi
	3syt7A2MNwS7GDk4JARMJPbfru5i5ORgE1CXuHHjJzOILSJgJnGw9Q97FyMXB7PAMiaJvSca
	2EASwgKZEu+6d7CD2CwCqhIn759lB5nDK2AqMXGrJEhYQkBeYvWGA2BzOIHmfJp2DKxVSCBZ
	YufvP0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzQZbV/Ju5g/HLZ/RCjAAej
	Eg/vgzN704VYE8uKK3MPMUpwMCuJ8HJm7kkX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpog
	JJCeWJKanZpakFoEk2Xi4JRqYKw5f6xrl+mxn51MLNXMB6+b73u+Te+MwY/F2pKOi5bnz798
	MyvNfoLhtPia193Tzs0SrP6YebGw0t3wZm764Wu/n2wNVTopOeMay4vTSn2fKzcvFnvh+C7l
	wI52WUbtBaFPArZkuinznXnhLy751laTSX7XoVgX3/xn2k19IUnsXdsX+tjzVCmxFGckGmox
	FxUnAgD9F61dTAIAAA==
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
index 7b1068ddcbb70..8c3481402d8cb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4155,4 +4155,38 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
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
index 2de01de164ef0..ed345503e4f88 100644
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


