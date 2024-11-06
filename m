Return-Path: <linux-kernel+bounces-398947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2B9BF85B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645231F228BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186AF20CCC8;
	Wed,  6 Nov 2024 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhV8oxBg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120720C489
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927585; cv=none; b=poiKlyIoP4UIjNC7NUw5JRd3MBJC4aOUt7ecnwHBdd+qBAfUkcI937SHvWGQATPm97bSzX4YRl82P1X8fPVOEEbucHLlD2myGG43M5CdvaxmG5L5XZNncg+YwhM1hSYIcISvN+5oOey5xwOk8G3dK8JuMZM2o7p25weVQc+/81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927585; c=relaxed/simple;
	bh=2Be2vptfkRRusVApOXjRb/TOfYhZr3S2q2yLZnErf24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ENtlaGhueS4Y5c6aVjggT0/yN/oRN0C65cMVvpU7G7wpNwcgbBFklUZ7d5ZBF/I5YHGKv1Dkjtv33AS9/7o9GDdpcXdpJkLlRYDAygpbFcIwOUTSycPeIi/uDF/uhKX9Bz5NiUYnpPN4KWk9fXvdYi+cHhA5UZ3nDByjVe6ZSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhV8oxBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730927582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6CaKWX2sAhCDPrXFOg5z+X6ACDdnGEgP4/mWIeAlabk=;
	b=RhV8oxBgAooD3tW3ZOPDTlYm6CqgNZ+9tGhLw/LPRMEVAc8Afbdx19gb2Yy+gkplnHSBm/
	UQ2DC18iQVp4BQq2aKh2Og9TfVt0Jgy/udiBru0LfJkQPv6pJIPzYnnHHiz56IEbP8Q3x6
	mjvrbnMdG9kvDpo8VKRyqzAxw/ZRQbI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-pg-M9TUrP3K8DYQtVkkOdQ-1; Wed,
 06 Nov 2024 16:12:59 -0500
X-MC-Unique: pg-M9TUrP3K8DYQtVkkOdQ-1
X-Mimecast-MFC-AGG-ID: pg-M9TUrP3K8DYQtVkkOdQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D972195608B;
	Wed,  6 Nov 2024 21:12:57 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.235])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA52E1956088;
	Wed,  6 Nov 2024 21:12:51 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: boqun.feng@gmail.com,
	miguel.ojeda.sandonis@gmail.com,
	tglx@linutronix.de,
	williams@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	jlelli@redhat.com
Subject: [PATCH v2] rust: Fix build error
Date: Wed,  6 Nov 2024 22:12:15 +0100
Message-ID: <20241106211215.2005909-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On a PREEMPT_RT build, spin locks have been mapped to rt_mutex types, so
avoid the raw_spinlock_init call for RT.

When CONFIG_DEBUG_SPINLOCK=y and CONFIG_PREEMPT_RT=y the following build
error occurs:

https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/

Fixes: 876346536c1b ("rust: kbuild: split up helpers.c")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
V1 -> V2: Cleaned up style and addressed review comments
 include/linux/spinlock_rt.h | 15 +++++++--------
 rust/helpers/spinlock.c     |  8 ++++++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f9f14e135be7..f6499c37157d 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -16,22 +16,21 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 }
 #endif
 
-#define spin_lock_init(slock)					\
+#define __spin_lock_init(slock, name, key, percpu)		\
 do {								\
-	static struct lock_class_key __key;			\
-								\
 	rt_mutex_base_init(&(slock)->lock);			\
-	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+	__rt_spin_lock_init(slock, name, key, percpu);		\
 } while (0)
 
-#define local_spin_lock_init(slock)				\
+#define _spin_lock_init(slock, percpu)				\
 do {								\
 	static struct lock_class_key __key;			\
-								\
-	rt_mutex_base_init(&(slock)->lock);			\
-	__rt_spin_lock_init(slock, #slock, &__key, true);	\
+	__spin_lock_init(slock, #slock, &__key, percpu);	\
 } while (0)
 
+#define spin_lock_init(slock)		_spin_lock_init(slock, false)
+#define local_spin_lock_init(slock)	_spin_lock_init(slock, true)
+
 extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
 extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
 extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index b7b0945e8b3c..5971fdf6f755 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -6,10 +6,14 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 				  struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
+# if defined(CONFIG_PREEMPT_RT)
+	__spin_lock_init(lock, name, key, false);
+# else /*!CONFIG_PREEMPT_RT */
 	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
-#else
+# endif /* CONFIG_PREEMPT_RT */
+#else /* !CONFIG_DEBUG_SPINLOCK */
 	spin_lock_init(lock);
-#endif
+#endif /* CONFIG_DEBUG_SPINLOCK */
 }
 
 void rust_helper_spin_lock(spinlock_t *lock)
-- 
2.47.0


