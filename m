Return-Path: <linux-kernel+bounces-522982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5A2A3D0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F95A3BAA11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64AD1E3DDB;
	Thu, 20 Feb 2025 05:36:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC01DE8A2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029763; cv=none; b=bX39BYk1xtVG16Juenwc/YKjwgjM4KAWmz5zeChbuBeWwWMosFskWacPeoa5Uec3FFkIXugNFaANWTV2AJ6+GoOMrmKQCk+Nht/XUX3o8C4/qBN4s77bf8zH5qKdXPwu3vBJaJMljIQKJOi29ZOgKcG2O/kwzMYr2O944QJAxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029763; c=relaxed/simple;
	bh=Y2sfbC4g4I7ryoAy/dwLz8LbdSA4fxJRetZmoammRF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=J3aPUhLBystTSOBm9sF+PzlG8Hl/ZgcyTEtVQdmU23rhc8rbDl9g+m/SifNlY9B9ncFZP3TWoriR2B63EyhB0xqmRnARHO2RK/12a2ATyi4rjTS0ggD4tOHGS5D4yB1sbnV5AggF88ktuSMw31Rd2yV6Ptcvg6tmAh8zWLFDlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-d0-67b6bba63805
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
Subject: [RFC PATCH v12 07/26] mm: introduce luf_ugen to be used as a global timestamp
Date: Thu, 20 Feb 2025 14:20:08 +0900
Message-Id: <20250220052027.58847-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6y3dvSDdZuU7WYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	PbsvsBXcEKm4PHkHSwPjaYEuRk4OCQETia3zj7DC2AveHWUEsdkE1CVu3PjJDGKLCJhJHGz9
	ww5iMwvcZZI40M8GYgsLhElcvX4PrIZFQFXi5px9YDW8AqYSzT/vsUDMlJdYveEAWA0n0Jwf
	M3rBeoWAat4tuMTUxcgFVPOeTWLvmQnMEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVe
	ZoVecn7uJkZg6C+r/RO9g/HTheBDjAIcjEo8vDNat6ULsSaWFVfmHmKU4GBWEuFtq9+SLsSb
	klhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoHRWkWcZQ/z1K3b
	Ct17P9uv/y4+12zX8/SHrS8C98anT2o/d4vR8J/mi5USYus2HxSw/TdhhU7lsidJheu3Wz/8
	UB+324vZpCvwxNqaSc8VrnL53/Buv7wkr+yRv6nRtq6mp/1JVydeja7+J74rbOMFJff2sKWv
	1r88dWjpmowLpz2r9Zf+3SW8SomlOCPRUIu5qDgRAPjD1ol5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g47nEhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyujZfYGt4IZIxeXJO1gaGE8LdDFyckgImEgseHeUEcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLBAmcfX6PbAaFgFViZtz9oHV8AqYSjT/vMcCMVNeYvWGA2A1
	nEBzfszoBesVAqp5t+AS0wRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECA3lZ7Z+J
	Oxi/XHY/xCjAwajEw/vg8dZ0IdbEsuLK3EOMEhzMSiK8bfVb0oV4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYW/d2RHkca+B9vJFh53KuN8mTdZ89zMzL
	ffNLI+Dor52v2Rhtzm6fuVwy99qCTT6F68QVG9aYGk9+e5wl+lNu2VUJrdN/73efdPK6WZox
	YYH6w6279jZP63dWlda+EOl/ZorP4Rdv9Mo6D9XcOfz5aLa5x0rlW9opqxhN3YTyJ+bUur7h
	ZPD1V2Ipzkg01GIuKk4EAAldmBBgAgAA
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
index fecd47239fa99..53a5f1cb21e0d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4161,4 +4161,38 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
 }
 #endif
 
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


