Return-Path: <linux-kernel+bounces-418617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651649D637C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7860E16090E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19A1DFD9C;
	Fri, 22 Nov 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NE18bxZ3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB141DF980
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297466; cv=none; b=BwMmsZjnskFIj5eWIdWkqB8tZe86sgZQR6W4iQeCoMgQPTgfWqWXuQ9ec9LXRA9syF4cRxB1Jn752OrHv8/C7jbA4YfgBEL82LCXrQZS6LbCxSG1k9MjSbcYjBVkc60So9UN9kNw4L8PpS5DoLXT7nE1eQkQwt0klG8wdTSTspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297466; c=relaxed/simple;
	bh=k7XVWO+ifuhDdi8vJciW98Mi6w3bYz7XzJuPxA4RXq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MA6k+mysqipZp+nqLFcSB/In/wcA1D9Yx5cACFi6/2mhajTubuZbX2VazkdhvE4YNynuwue9tj+pi1CAC6xmnLMdV4cT6i67PvYjqC20gwQ9e7SJWJFBQmQxMP+jwUPBpQXdW3VvNOpsQH/FBhJDOtZeboa8BssYcF3Q7lA51Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NE18bxZ3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3892eb6b1dso4102124276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732297463; x=1732902263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmMtuCkRvyQ52Tg7fGJRZ5Y2Wsu/zSjhmlAZ0eI81A0=;
        b=NE18bxZ3SiWHy1uXcS2KdDV59pW2dQ3S0oPJ1RNuHargB8iNUIx8ZPFkZs2ARBzynf
         kz3ebCliRBNRTMHHsl5YSTD4wUJfhp620IHWszhiXaUlImZTmCGwGD9Kpbb9Cb51FTK5
         SQA+eCcqaCMcC2GjyHdUHfe0NV26EAv5pKHzSjFg/0r7Ne4BKye/Ec2HAbbo+0aWoP4q
         8v0pYg8YGRShPN1qG/8SCJrAkYgA147MCV/F7GI8L7pUnNtyVwXEo2QDd8mdHKDxcN86
         V3kVEE0hznYfW1DZoqFyJufH6dnxrNvh+LuRDdYrUIUunu4nKh1K+N5bnWbun5tMLMgK
         iTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297463; x=1732902263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmMtuCkRvyQ52Tg7fGJRZ5Y2Wsu/zSjhmlAZ0eI81A0=;
        b=uaM6V6IxihkakHwYLF+hEiZ+rK+jrCYEKCkyFO8JsT0Gm64LOH5jFj7dEehmcAh1kn
         X3TfutOPwRn2JazVxO5A0a1OHxKRRHPmc1Rdui8RtPKWwJgM3SSFyZpgHb8Fqxqr9EFb
         BQcIDQ6IoPZ7wOmJb8zeXZ0e/Mr987W19mSCbgWBbr+GpU94K+gt+BIJnxlqoFPN3Du5
         4iYFYvOaZBp7DhTFUu3ANz2UGlMl0DnGByi0+IoLd2S4Jn7SSGPVTt2uj1SBcieGkSNz
         dr6JyKCtE+Ja/3JGk9BdV+SFHqJukAW4TKpGi7gX/oIoMijJzEDHlvizEMFHRyR9YN5U
         mMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfKh1AOZQojk6H15ezSXrZ62xrsQwSAlt3PGqRCL60KbmGnuME5mCT6zLMPb6AZ8J0nKDQCP0ykhit+5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2htvgHMqrmkl3cEh7y/g+AYgnaDIl1WuMzspGymtRAQpogYL
	591AaKtq1zx55isKVH/IxXsudVCQpqhCwdTxDA+Hm0GGp+/ODTnMK1VhOWpyY72S9kBfy+RecwE
	/9A==
X-Google-Smtp-Source: AGHT+IEV9E/JH5zB3aH55fu2gyNobb2STJxxHLoQPN4QfW7QVDU8lvjjtSetWq5+AkJvlm8IMcLFXFtwqtU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:8f07:6a96:7af9:8fe6])
 (user=surenb job=sendgmr) by 2002:a05:6902:1745:b0:e33:111b:c6a4 with SMTP id
 3f1490d57ef6-e38f8acbe09mr1492276.1.1732297463091; Fri, 22 Nov 2024 09:44:23
 -0800 (PST)
Date: Fri, 22 Nov 2024 09:44:16 -0800
In-Reply-To: <20241122174416.1367052-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122174416.1367052-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122174416.1367052-3-surenb@google.com>
Subject: [PATCH v3 3/3] mm: introduce mmap_lock_speculate_{try_begin|retry}
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
Changes since v2 [1]
- Added SOB, per Liam Howlett

[1] https://lore.kernel.org/all/20241121162826.987947-3-surenb@google.com/

 include/linux/mmap_lock.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9715326f5a85..8ac3041df053 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,6 +71,7 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
 	seqcount_init(&mm->mm_lock_seq);
@@ -87,11 +88,39 @@ static inline void mm_lock_seqcount_end(struct mm_struct *mm)
 	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
 
-#else
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	/*
+	 * Since mmap_lock is a sleeping lock, and waiting for it to become
+	 * unlocked is more or less equivalent with taking it ourselves, don't
+	 * bother with the speculative path if mmap_lock is already write-locked
+	 * and take the slow path, which takes the lock.
+	 */
+	return raw_seqcount_try_begin(&mm->mm_lock_seq, *seq);
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return do_read_seqcount_retry(&mm->mm_lock_seq, seq);
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
 static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
 static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
-#endif
+
+static inline bool mmap_lock_speculate_try_begin(struct mm_struct *mm, unsigned int *seq)
+{
+	return false;
+}
+
+static inline bool mmap_lock_speculate_retry(struct mm_struct *mm, unsigned int seq)
+{
+	return true;
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
-- 
2.47.0.371.ga323438b13-goog


