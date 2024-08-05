Return-Path: <linux-kernel+bounces-274655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101E947B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708F11C21138
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63515AAB1;
	Mon,  5 Aug 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WTwm6+d"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4F154C0E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861813; cv=none; b=b5UFMOVx3xdkPmhmYWyRKgOTtJ36Qvk0ulT4LBdgfQ0JHMZCARI9F2gOauqIcruItDLoYtnPojO4bfXeusOioMyjcO1QvBtBknfcFXLGs7SISNTdAgX1+Zsx/jwYPzANarM+3V/n4VotP15p2Kq0NL8a4Ys91qdu4/nlDxd1iJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861813; c=relaxed/simple;
	bh=ZVFQG2gxWg1NatGs5Nwt/qB0cd6FIdYnaGBnC6i3SLs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qoi9HTPS5HgSh8+RnNGGx7XCrB74Xj2pPfIJthIYhxoUV6nBFgyT+nfT6/ug79sSqmsLJYgVeEcspvON7MdjtQNSbB9qk2TW9rJQqDmuxInIUqKtjofvV3yelXIgV57EYROvC2v7XA+/qRlUonY7cP8sA/o8S7O4dr9D6Sb4Xog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WTwm6+d; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e3938a37so16681481276.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722861810; x=1723466610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LrC8PMqmgoYq1tMdewJcFduXfqGeN4f8xWTu+1cWz7M=;
        b=1WTwm6+dwC3R5C6IBY9WIeeDs8wGBYms8s/+lZky/QMmf/1kJdrlqVHXOhhx6qdPlb
         HTdKoIx1c3KsKTN0qbT3CyqDDCURqw5UakmaGl8kMBApAdR6BWztXN3em1rBBU9kU+Ik
         JhbfyT1tZilIZm3I78rVoT0k8nlCA5iNRUvqSUsF1ZQuFjNJkWhKU76/nIojuuQwZ2Al
         Hn3rcQgDvWKoPsi8u5XoMrC3wqIj/3W2TfCN8nhbjP+6S9kFcPdtqYnEnSsS2jKQ7XV1
         f4muLbu6BIjT7+qOZ25bGojWNJZXkc9TYKjrw0bIT/UwmSArgKsdW5DhGq7w1GGbqyV5
         LsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722861810; x=1723466610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrC8PMqmgoYq1tMdewJcFduXfqGeN4f8xWTu+1cWz7M=;
        b=Yr38STdnY+fGZ4O1UqEHAoXPGb+AV0KIPKtTIzGZefu3EzksxvkJmYjcQtbsuEwQCq
         h8POEscpibxzxF6PXKn7IkkrGfIIcD0F5snyYSYEw5F0Ah+mZOB2dUN0L8wKVRrE0UOF
         Y11Hl/8CMXdYDfT+K2/wRltqYJDbC1LQTO8nVUuopBs2VQ3gspBY6M080zw0Ss5MoWle
         0uDjUQzp9wroYZoN15v6o0QRtUn51wyoXCbhhJMLNd8L9SAx86ghvptTLjxT8AYwMRnG
         D41x06OUkHXlafi9Ef0EUT9xNPy9pumDEb9sUy+wLNe8JpXEdQsJmkAxSGOeua6nV6/H
         P6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUnr/HTkB1MoRd8eKm4E1xvJS1OOyYnSQarYEuuUjvllcj61YNaGcfkr+AKMmPnaAvhD4dInYWQY0mdknUjkEUWwYp5U/a3xQT8yZDV
X-Gm-Message-State: AOJu0YzQdWQZyTxA6TPwOCZP3oY2x7H5NnxQuQvMsTUtIwYaS9EKNGSJ
	bb/5ayUx2Lo+Bt1BkS99dJNgEWEuyIZCKPgQacZm6TqT32cJ2qyUIjpL8c3XfhG9lRuRmAyp4w=
	=
X-Google-Smtp-Source: AGHT+IGqkRac4PWjShJ8ZuJcg3lK53X4rsTvmZrworTa4PKf1hQ7xcsnsuhYAGll2uBuhCm9g3UE71/Pzw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:575f:bb7d:b516:3c23])
 (user=elver job=sendgmr) by 2002:a05:6902:100c:b0:dfa:8ed1:8f1b with SMTP id
 3f1490d57ef6-e0bde22affamr334185276.1.1722861809962; Mon, 05 Aug 2024
 05:43:29 -0700 (PDT)
Date: Mon,  5 Aug 2024 14:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805124203.2692278-1-elver@google.com>
Subject: [PATCH] kfence: introduce burst mode
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Introduce burst mode, which can be configured with kfence.burst=$count,
where the burst count denotes the additional successive slab allocations
to be allocated through KFENCE for each sample interval.

The idea is that this can give developers an additional knob to make
KFENCE more aggressive when debugging specific issues of systems where
either rebooting or recompiling the kernel with KASAN is not possible.

Experiment: To assess the effectiveness of the new option, we randomly
picked a recent out-of-bounds [1] and use-after-free bug [2], each with
a reproducer provided by syzbot, that initially detected these bugs with
KASAN. We then tried to reproduce the bugs with KFENCE below.

[1] Fixed by: 7c55b78818cf ("jfs: xattr: fix buffer overflow for invalid xattr")
    https://syzkaller.appspot.com/bug?id=9d1b59d4718239da6f6069d3891863c25f9f24a2
[2] Fixed by: f8ad00f3fb2a ("l2tp: fix possible UAF when cleaning up tunnels")
    https://syzkaller.appspot.com/bug?id=4f34adc84f4a3b080187c390eeef60611fd450e1

The following KFENCE configs were compared. A pool size of 1023 objects
was used for all configurations.

	Baseline
		kfence.sample_interval=100
		kfence.skip_covered_thresh=75
		kfence.burst=0

	Aggressive
		kfence.sample_interval=1
		kfence.skip_covered_thresh=10
		kfence.burst=0

	AggressiveBurst
		kfence.sample_interval=1
		kfence.skip_covered_thresh=10
		kfence.burst=1000

Each reproducer was run 10 times (after a fresh reboot), with the
following detection counts for each KFENCE config:

                    | Detection Count out of 10 |
                    |    OOB [1]  |    UAF [2]  |
  ------------------+-------------+-------------+
  Default           |     0/10    |     0/10    |
  Aggressive        |     0/10    |     0/10    |
  AggressiveBurst   |     8/10    |     8/10    |

With the Default and even the Aggressive configs the results are
unsurprising, given KFENCE has not been designed for deterministic bug
detection of small test cases.

However, when enabling burst mode with relatively large burst count,
KFENCE can start to detect heap memory-safety bugs even in simpler test
cases with high probability (in the above cases with ~80% probability).

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kfence.rst |  7 +++++++
 include/linux/kfence.h             |  2 +-
 mm/kfence/core.c                   | 14 ++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 936f6aaa75c8..541899353865 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -53,6 +53,13 @@ configurable via the Kconfig option ``CONFIG_KFENCE_DEFERRABLE``.
    The KUnit test suite is very likely to fail when using a deferrable timer
    since it currently causes very unpredictable sample intervals.
 
+By default KFENCE will only sample 1 heap allocation within each sample
+interval. *Burst mode* allows to sample successive heap allocations, where the
+kernel boot parameter ``kfence.burst`` can be set to a non-zero value which
+denotes the *additional* successive allocations within a sample interval;
+setting ``kfence.burst=N`` means that ``1 + N`` successive allocations are
+attempted through KFENCE for each sample interval.
+
 The KFENCE memory pool is of fixed size, and if the pool is exhausted, no
 further KFENCE allocations occur. With ``CONFIG_KFENCE_NUM_OBJECTS`` (default
 255), the number of available guarded objects can be controlled. Each object
diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 88100cc9caba..0ad1ddbb8b99 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -124,7 +124,7 @@ static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp
 	if (!static_branch_likely(&kfence_allocation_key))
 		return NULL;
 #endif
-	if (likely(atomic_read(&kfence_allocation_gate)))
+	if (likely(atomic_read(&kfence_allocation_gate) > 0))
 		return NULL;
 	return __kfence_alloc(s, size, flags);
 }
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index c5cb54fc696d..c3ef7eb8d4dc 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -99,6 +99,10 @@ module_param_cb(sample_interval, &sample_interval_param_ops, &kfence_sample_inte
 static unsigned long kfence_skip_covered_thresh __read_mostly = 75;
 module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644);
 
+/* Allocation burst count: number of excess KFENCE allocations per sample. */
+static unsigned int kfence_burst __read_mostly;
+module_param_named(burst, kfence_burst, uint, 0644);
+
 /* If true, use a deferrable timer. */
 static bool kfence_deferrable __read_mostly = IS_ENABLED(CONFIG_KFENCE_DEFERRABLE);
 module_param_named(deferrable, kfence_deferrable, bool, 0444);
@@ -827,12 +831,12 @@ static void toggle_allocation_gate(struct work_struct *work)
 	if (!READ_ONCE(kfence_enabled))
 		return;
 
-	atomic_set(&kfence_allocation_gate, 0);
+	atomic_set(&kfence_allocation_gate, -kfence_burst);
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 	/* Enable static key, and await allocation to happen. */
 	static_branch_enable(&kfence_allocation_key);
 
-	wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
+	wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate) > 0);
 
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
@@ -1052,6 +1056,7 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	unsigned long stack_entries[KFENCE_STACK_DEPTH];
 	size_t num_stack_entries;
 	u32 alloc_stack_hash;
+	int allocation_gate;
 
 	/*
 	 * Perform size check before switching kfence_allocation_gate, so that
@@ -1080,14 +1085,15 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (s->flags & SLAB_SKIP_KFENCE)
 		return NULL;
 
-	if (atomic_inc_return(&kfence_allocation_gate) > 1)
+	allocation_gate = atomic_inc_return(&kfence_allocation_gate);
+	if (allocation_gate > 1)
 		return NULL;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 	/*
 	 * waitqueue_active() is fully ordered after the update of
 	 * kfence_allocation_gate per atomic_inc_return().
 	 */
-	if (waitqueue_active(&allocation_wait)) {
+	if (allocation_gate == 1 && waitqueue_active(&allocation_wait)) {
 		/*
 		 * Calling wake_up() here may deadlock when allocations happen
 		 * from within timer code. Use an irq_work to defer it.
-- 
2.46.0.rc2.264.g509ed76dc8-goog


