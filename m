Return-Path: <linux-kernel+bounces-357467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE1997194
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF4D1C20CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362471E1337;
	Wed,  9 Oct 2024 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+n7rCwH"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA51922EB;
	Wed,  9 Oct 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491199; cv=none; b=WtemmVkXBOlEnRGA6e6csFrxiBpqGXnd+QoGxJF0SPJW8r/Oo7fvPmO5wqFFdfrhDN7EybxIcJmWMbh7+Mk5ThGJm8Y+hIiF6Looj+QkpuuqeIerlAHMmYxW+DT+QwQopUpmXI+oVM/ZJ9O9Lu4IOcckYGpuB2N7AxnYz6pYqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491199; c=relaxed/simple;
	bh=YmgM0zAd+zAe1mYwSmAv2k+//lbCqCcDivPxGZnrfnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUJA4NlL+194IWn3bTTlbrf1qjB1nXYR63iPN7sPjNMOM3iSxXeSQ53vIIqUP2/xU5JFYo4+Fb8N7JhWlbLe7t+ybZji4cqzn2gOys+1vbT0UKSQVMtIUXz2b6PlNjJPGDkhSV8ObocuumVAfwRuUXm5kURiNGHpyng4wfQDaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+n7rCwH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso427176d6.0;
        Wed, 09 Oct 2024 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728491196; x=1729095996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzd073SkOPBAyUAjLwTkVGhRj2/hIdOJ9upFoU+xYuE=;
        b=a+n7rCwHyiBG43369U3MwZ3fHPembv1bwQwJThvmbEWjCmyJydZp8UImdLD296k85y
         qNBJqwbn0Kc2Iq2gZFUkZSxfnibVcn20Ph0TiPyhoZGOIBeYcCjgl6VjR5R3hqLNCahr
         9l27K2ZyBcE7yB6dtuzcf5KYJzmRBTjFyR044+uehxN3lGKpzzHNdJEdEty88+NrTzk8
         4Ecvb3Szaz/RVkqmsxCh77FX+bZ04R0dd6+JjnGqrX5kYB/tuOgJadFx1ODimbmPd+os
         Ccb/6dVX6t6tCAjt79JRhigf3boUXjtklufoemrhVCnx/yvYZ/3UxQTkdhN13bmIRsaK
         6F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491196; x=1729095996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzd073SkOPBAyUAjLwTkVGhRj2/hIdOJ9upFoU+xYuE=;
        b=HmTnxrFjc7KYXg359rP1gw4V4torLt3Xivucevup3D7UT3SLG8zKNguEzjw6gmWV02
         oNq3TfOExKItIPga+Veu5ITR1yQkGP/XC3EXATyHAlRa1I9irggPH71eXQQKz1l5UvpP
         mxrQX00DLjCvsyv4nBwkDdHE2CGBy+iTn0hhN/s54kOQdR2Kc35/lf6+uuGMwJqOdi0o
         kHv8Tab3uamTzWTxe88/EQVkk6gmxtf7o5u+4tP2/7Tih2a5Aq+9Bn4009GJBZxitsL6
         SqN2dCiaNic8GNkd5HTz5cndPqVQfIUQmEkc3JM9zeCO4pT5DThPAXCVV2noM5RCoQsi
         BuDw==
X-Forwarded-Encrypted: i=1; AJvYcCX5DpKDnDOOtY8H/ShdyWiXZxFgA92tjbaZBxulkbhpwfPXWy/0tnTSm1PlKfRzKv5qcM3iZ/o3WtYUfTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8O5YF7BspDOQWI39sA42S5bCRB2/ORvcHFAFeRy1Ly8m8TEZ
	wszX5g3piWXxG/e4FT+pj2gQRNEu4oetG3o41j50nm+7ntyH5JWcGNNGF58f
X-Google-Smtp-Source: AGHT+IHjo+wclBT91JMpUfAdWEQBLtyYDAAtPa8NSsyCMnSt63IqkFiXSfE0zr/mJtujGYE2toVK4w==
X-Received: by 2002:a05:6214:5bc1:b0:6cb:8339:5f51 with SMTP id 6a1803df08f44-6cbc92afa7amr53120186d6.1.1728491196497;
        Wed, 09 Oct 2024 09:26:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:6bd1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc19857a7sm15890356d6.6.2024.10.09.09.26.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 09:26:36 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Fiona Behrens <me@kloenk.dev>,
	Filipe Xavier <felipe_life@live.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: remove unnecessary header includes
Date: Wed,  9 Oct 2024 12:25:30 -0400
Message-ID: <20241009162553.27845-2-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
References: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
removed the need for these by automatically generating the exports; it
removed the explicit uses of `EXPORT_SYMBOL_GPL` but didn't remove the
`#include <linux/export.h>`s.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
V1 -> V2: Split grammar improvement into separate patch.

 rust/helpers/build_bug.c | 1 -
 rust/helpers/err.c       | 1 -
 rust/helpers/kunit.c     | 1 -
 rust/helpers/mutex.c     | 1 -
 rust/helpers/refcount.c  | 1 -
 rust/helpers/signal.c    | 1 -
 rust/helpers/spinlock.c  | 1 -
 rust/helpers/task.c      | 1 -
 rust/helpers/wait.c      | 1 -
 rust/helpers/workqueue.c | 1 -
 10 files changed, 10 deletions(-)

diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
index e994f7b5928c..44e579488037 100644
--- a/rust/helpers/build_bug.c
+++ b/rust/helpers/build_bug.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/errname.h>
 
 const char *rust_helper_errname(int err)
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
index be3d45ef78a2..544c7cb86632 100644
--- a/rust/helpers/err.c
+++ b/rust/helpers/err.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/err.h>
-#include <linux/export.h>
 
 __force void *rust_helper_ERR_PTR(long err)
 {
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
index 9d725067eb3b..b85a4d394c11 100644
--- a/rust/helpers/kunit.c
+++ b/rust/helpers/kunit.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <kunit/test-bug.h>
-#include <linux/export.h>
 
 struct kunit *rust_helper_kunit_get_current_test(void)
 {
diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index a17ca8cdb50c..7e00680958ef 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/mutex.h>
 
 void rust_helper_mutex_lock(struct mutex *lock)
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index f47afc148ec3..d6adbd2e45a1 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/refcount.h>
 
 refcount_t rust_helper_REFCOUNT_INIT(int n)
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
index 63c407f80c26..1a6bbe9438e2 100644
--- a/rust/helpers/signal.c
+++ b/rust/helpers/signal.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/sched/signal.h>
 
 int rust_helper_signal_pending(struct task_struct *t)
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 775ed4d549ae..b7b0945e8b3c 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/spinlock.h>
 
 void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 7ac789232d11..190fdb2c8e2f 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/sched/task.h>
 
 struct task_struct *rust_helper_get_current(void)
diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
index c7336bbf2750..ae48e33d9da3 100644
--- a/rust/helpers/wait.c
+++ b/rust/helpers/wait.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/wait.h>
 
 void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
index f59427acc323..b2b82753509b 100644
--- a/rust/helpers/workqueue.c
+++ b/rust/helpers/workqueue.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/export.h>
 #include <linux/workqueue.h>
 
 void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
-- 
2.47.0


