Return-Path: <linux-kernel+bounces-357310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB08996F81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52505280E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368021E3793;
	Wed,  9 Oct 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeCtMzlZ"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74361E32DC;
	Wed,  9 Oct 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486643; cv=none; b=q619XJ7CDqtWQhbWclXDa3WZev9p6C61mICT1+n33QB7HmQSyONh1z13ZOrdS/xQCnYkfV392TYJfl3PPntIL7/+zJGy/oZwoFbJ6zlKY6iDAs/G0EHGXQQ+XAyXrykIM7TAxE7TYlxvVTAVdptih6eomuyINP2LW/O2GY4YW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486643; c=relaxed/simple;
	bh=auOGwcwUNtWUimQtw+xEh2t7pxkqUiZdtGtpkjCvDx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiWbAZPruaKoljZ8Anks/Ll+cUNUInPF9janKwzLKkgvp/Yc2/UY9ISsCP/pIdWE8mTPts9ottFIqNQ61XLtLgiLFA5y2rUOepZZBvxoqlsVSl6ljm2DZnJUFadT8rwOm4PqhZrsdohnvPkYXcxBaeVNBMp5Q5FdvsSuk6zIUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeCtMzlZ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbbe3f6931so18500126d6.0;
        Wed, 09 Oct 2024 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728486640; x=1729091440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCdXhLxgbUayqOpJqsZSML6FXnMELs945wDi+0XzIdw=;
        b=SeCtMzlZoU1ZWd8+GFaebIip4mqGzt0KM+9pZvXYD9U2EIRkLiSf4rbDGQqHiLcUiO
         ZD61njWg4ouNKWbKHXrgIydNqgLpHeukHo8RpGTZIi/VHnzfqiRDrfiNTnLZt+b+Ir6+
         EOSXqmMCTZdFi3jfYA/B5S57Vu6/MIVsYpu2HwX7Ja+N8v96OMnZRddV5PMORJ/mEEeC
         6BOeZh1bgli/cziXQNwMQWYzKkKEwYVhfutvgdPzkg2pRi97i9mFi1p3y6zxglxNxHKw
         vCIvYSVMbHs40JWZnV/dmv7EyEBhSxFDP4LULx9vztI4CmGzPlgSya/1GAq66iqiYByc
         j0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486640; x=1729091440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCdXhLxgbUayqOpJqsZSML6FXnMELs945wDi+0XzIdw=;
        b=vzbL9Zo6sqAKJWJQiGkw18o7n8cyz9CbWscCe9b5I4NpNTFS2bg5P6DM6fv0IsYzJd
         WDcyttAmPOBEtfYRs1yEpIQjMSKwAflJp60KeuqDSbYfvy1u4/1+dGuJRh2ze3OjItu2
         Aggz8+7BU+XVNX4s75VMhpN0X2NQAONDQZQSIVR8zk+9ux00DjJbjhpcbh37PMeBFfbk
         NdwFQf0fKIzas6xiiOKy9MHDvaTG5qf60RzNLswNt0+H2Hfc87or0KWEtIMaO9eec7jR
         iBa4GxInpYuwxagryNysfMbuwdtu1AeTVcMQ+am/F2YmDPKAqJqjk976Aw13P7sUlQ0E
         vm7w==
X-Forwarded-Encrypted: i=1; AJvYcCXpa0ys5j6g4MZQQoRvD+n7Nem+WKZOxUXHQBHFj1Ciea+IWfpHgc1UNHE4nB6yVK8LS3Tq6/fa9II1XpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgJyHIZHNOBntW3Tx4bWmfCNxpX90rFFaVEEP8Qt/U8Ith2EU
	BWMOSs+qlD7LkoBchsd3zpbaZ2aZkBM0YOXU+mGCVPs3SrFfbEpRFcrqs0Q2
X-Google-Smtp-Source: AGHT+IF7X+U4DjPpVCM1oK0fo69qWsoASbXBtNY0ZPbRuz6rtomZNraffTcQeX/KsR/yufxV5l1vyg==
X-Received: by 2002:a05:6214:469c:b0:6cb:9c5a:7f41 with SMTP id 6a1803df08f44-6cbc932d71amr48878546d6.17.1728486640224;
        Wed, 09 Oct 2024 08:10:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:6bd1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4763b6asm46712606d6.131.2024.10.09.08.10.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 08:10:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Filipe Xavier <felipe_life@live.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: remove unnecessary #includes
Date: Wed,  9 Oct 2024 11:09:55 -0400
Message-ID: <20241009151017.26685-1-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
removed the need for these by automatically generating the exports; it
removed the explicit uses of EXPORT_SYMBOL_GPL but didn't remove the
header includes.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/exports.c           | 6 +++---
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
 11 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/rust/exports.c b/rust/exports.c
index e5695f3b45b7..fd278e272751 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -3,9 +3,9 @@
  * A hack to export Rust symbols for loadable modules without having to redo
  * the entire `include/linux/export.h` logic in Rust.
  *
- * This requires the Rust's new/future `v0` mangling scheme because the default
- * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
- * the `EXPORT_SYMBOL_*` macros).
+ * This requires Rust's new/future `v0` mangling scheme because the default one
+ * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
+ * `EXPORT_SYMBOL_*` macros).
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
  * accidentally exposed.
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


