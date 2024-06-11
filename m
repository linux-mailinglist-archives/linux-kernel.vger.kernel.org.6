Return-Path: <linux-kernel+bounces-209118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDE902D93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B0286E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55F2AE8C;
	Tue, 11 Jun 2024 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCXwHRst"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B4EDF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065325; cv=none; b=V0bSvTCfH61AQsU3Hk54Y2Cb5gyAmPX56LidRkfsPj3+WriNn+N6/CXdRBQiYHpTZS5vXCHdThSv/NTs9xIjc80YPWBRToi27f44mywRy0Adzp+AETpYO0sVM7s9WjfO0PhAK4dHzPRf590eByCj/3qgu4zlrvI617g9L+gxSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065325; c=relaxed/simple;
	bh=hrTHF1LPFXBYPkOeqn+Sm4a6LUN1ZOrT0EeRBRT4T7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ana5MK3v8Ab2sUnpVyQKTWygw/IPO888hG/cpirN/JqsOA71p8Ewe+0lsBQ3QUvauWrpdifHoOzm57lnJ6C9LbjDzVZ/IXHuu7lkLyfwK42GKCHjX6dE9MEChwTukI5Dr+JTurgk0/kOKXSrzpYq1GilAanx74BvR729+jkLcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCXwHRst; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d032a07a9so9229117b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718065322; x=1718670122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j3rWVw+E6yiyAll83pvyiHc59e6Q6WaEN3pW8ayg5o=;
        b=aCXwHRstM3P/cvDYwPBZtBQ8cHq5tbnCdkCqDPQ68M+15HsxXC8nKWh0FS/L2WiH74
         c0h1HyItpdC/y5wDhpHydJo2OKmF8Qkp8CCKe9d6xbsCNaUyiL9jhBLRrO04BgFBDJ+4
         G2mf7pOjglTa8c8nvmH6LHA+uFfmitFw2b/dFPgKXn+7W6tkqGYdvLkWMhZbG2grC1OO
         9u/vZxx6PTSWRNIreMu7N6OPVL4sP+hrFzN7n8ifRDaEu/ixgiSy5ZMtZj/GGQSa7M5W
         53Umnw2azVkhyMfnXpHPhqY93pIox+gzSQCz0Qt8ifQQHjulRtXVbIbjGySsefGmmX1W
         LZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718065322; x=1718670122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j3rWVw+E6yiyAll83pvyiHc59e6Q6WaEN3pW8ayg5o=;
        b=NVlV4yXA2wgkNKzdh9WS4lzzAgkufrLqKPfORyQqZ+TTK51nBGqHrwD+CF6HYfYobl
         dUJMoNiz95dyZf/Cmua/nkAjkKCpSxWG2/CjUKfMYdBIO/FE7Af9uS3VZpACTvP4xcD2
         BX0NF7xmoPde1pcNpDSgPOURwNNBXk7TPveKk61PMIIXwb7xcqJEX+Cv/wMjerCF8leC
         QB09B+KPgD/lvROqKHZXO2xR7MnTYMB2/ecqPLPdtY45QSTQajUJyX9cXNKU/OYwu5mP
         Bu3FNg8x6SBKmcdO8TY+3wlY98qnBnN5auZWaD5Rtve9Yn0mCTO9A5Q6r1jduBhw0qzf
         2asg==
X-Forwarded-Encrypted: i=1; AJvYcCX992o6zaYi9msgVDReYs63nLOpulmq2W7jWtFAFF0Ej/YIHJ9BGgbu1KmYtyGieYavUydLyWJPDCUyB85OTUGE3DqPlQIW5Z+LpqPe
X-Gm-Message-State: AOJu0YzOKUiUST8Ye3U20+rRD6b73HtLKa71GaC0ZnPpZnlx1cNZcBka
	cTrtX1RLAmNg5epwMSc5nG1ZZnytJEODVu0NDmGMX5iJR3iX6V/HOpKzG25+niV0Wm2bW/jbTFK
	89D+CySgmWa++95ATSQ==
X-Google-Smtp-Source: AGHT+IEvrN0k+l/fqR0GYBVcFmKI7zO7AJD796Zxk8tVrT0hIaj/Sm704UQ/Nq6b1QsHmo+//ovsajrvliWZ5C+2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:4485:b0:62d:fbf:920a with SMTP
 id 00721157ae682-62d0fbf9666mr11256657b3.10.1718065322252; Mon, 10 Jun 2024
 17:22:02 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:21:40 +0000
In-Reply-To: <20240611002145.2078921-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611002145.2078921-5-jthoughton@google.com>
Subject: [PATCH v5 4/9] mm: Add test_clear_young_fast_only MMU notifier
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This new notifier is for multi-gen LRU specifically, as it wants to be
able to get and clear age information from secondary MMUs only if it can
be done "fast".

By having this notifier specifically created for MGLRU, what "fast"
means comes down to what is "fast" enough to improve MGLRU's ability to
reclaim most of the time.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/mmu_notifier.h | 50 ++++++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 26 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d39ebb10caeb..2655d841a409 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -61,6 +61,15 @@ enum mmu_notifier_event {
 
 #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
 
+/*
+ * Bits in the return value for test_clear_young_fast_only.
+ *
+ * MMU_NOTIFIER_FAST_YOUNG: notifier succeeded, secondary MMU reports young.
+ * MMU_NOTIFIER_FAST_FAILED: notifier failed.
+ */
+#define MMU_NOTIFIER_FAST_YOUNG (1 << 0)
+#define MMU_NOTIFIER_FAST_FAILED (1 << 1)
+
 struct mmu_notifier_ops {
 	/*
 	 * Called either by mmu_notifier_unregister or when the mm is
@@ -122,6 +131,24 @@ struct mmu_notifier_ops {
 			  struct mm_struct *mm,
 			  unsigned long address);
 
+	/*
+	 * test_clear_young_fast_only is called to check (and optionally clear)
+	 * the young/accessed bitflag in the secondary pte such that the
+	 * secondary MMU must implement it in a way that will not significantly
+	 * disrupt other MMU operations. In other words, speed is more
+	 * important than accuracy.
+	 *
+	 * Returns MMU_NOTIFIER_FAST_YOUNG if the secondary pte(s) were young.
+	 * Returns MMU_NOTIFIER_FAST_FAILED if the secondary MMU could not do
+	 *   an accurate fast-only test and/or clear of the young/accessed
+	 *   flag.
+	 */
+	int (*test_clear_young_fast_only)(struct mmu_notifier *subscription,
+					  struct mm_struct *mm,
+					  unsigned long start,
+					  unsigned long end,
+					  bool clear);
+
 	/*
 	 * invalidate_range_start() and invalidate_range_end() must be
 	 * paired and are called only when the mmap_lock and/or the
@@ -383,6 +410,10 @@ extern int __mmu_notifier_clear_young(struct mm_struct *mm,
 				      unsigned long end);
 extern int __mmu_notifier_test_young(struct mm_struct *mm,
 				     unsigned long address);
+extern int __mmu_notifier_test_clear_young_fast_only(struct mm_struct *mm,
+						     unsigned long start,
+						     unsigned long end,
+						     bool clear);
 extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
 extern void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *r);
 extern void __mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
@@ -428,6 +459,17 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mmu_notifier_test_clear_young_fast_only(struct mm_struct *mm,
+							  unsigned long start,
+							  unsigned long end,
+							  bool clear)
+{
+	if (mm_has_notifiers(mm))
+		return __mmu_notifier_test_clear_young_fast_only(mm, start, end,
+								 clear);
+	return 0;
+}
+
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
@@ -612,6 +654,14 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mmu_notifier_test_clear_young_fast_only(struct mm_struct *mm,
+							  unsigned long start,
+							  unsigned long end,
+							  bool clear)
+{
+	return 0;
+}
+
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 8982e6139d07..7b77ad6cf833 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -424,6 +424,32 @@ int __mmu_notifier_test_young(struct mm_struct *mm,
 	return young;
 }
 
+int __mmu_notifier_test_clear_young_fast_only(struct mm_struct *mm,
+					      unsigned long start,
+					      unsigned long end,
+					      bool clear)
+{
+	struct mmu_notifier *subscription;
+	int ret = 0, id;
+
+	id = srcu_read_lock(&srcu);
+	hlist_for_each_entry_rcu(subscription,
+				 &mm->notifier_subscriptions->list, hlist,
+				 srcu_read_lock_held(&srcu)) {
+		if (subscription->ops->test_clear_young_fast_only) {
+			ret = subscription->ops->test_clear_young_fast_only(
+					subscription, mm, start, end, clear);
+			if (ret & MMU_NOTIFIER_FAST_FAILED)
+				break;
+			if (!clear && (ret & MMU_NOTIFIER_FAST_YOUNG))
+				break;
+		}
+	}
+	srcu_read_unlock(&srcu, id);
+
+	return ret;
+}
+
 static int mn_itree_invalidate(struct mmu_notifier_subscriptions *subscriptions,
 			       const struct mmu_notifier_range *range)
 {
-- 
2.45.2.505.gda0bf45e8d-goog


