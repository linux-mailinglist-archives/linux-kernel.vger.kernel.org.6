Return-Path: <linux-kernel+bounces-399242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFBD9BFC67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284C5B233D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD92194096;
	Thu,  7 Nov 2024 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKCS0T+v"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD4199B8;
	Thu,  7 Nov 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945391; cv=none; b=Hh1cwaN175/InnjNlWtDIc+ancF0S7LDhtTVhryZvgNqlCDtHIy35fPcs5gkBzrsxVuRAGXruU6SHaOcdGes8W5bOHJ5jN4eOgkQX42ImAW7eQEclf5wqdM+B9ACvExI6KYED2tbdsOHmmsq8EhntU2ps3zPXLRANgShRiAw1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945391; c=relaxed/simple;
	bh=syE8cZwDU96+7tIa5CPui+HF8wNNyg1P41xkOrVboHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHfbYrVgkTfz4/X67azZ23FZ27jypAoIEkFRqfOkiRkIIa7FkDT2fqk7w6eQtD0ctAyNn7LtzMXD0A3VfTT/0POz/RLcdLytyKK+N2cwB3c9tazQz7nXUXgBE0MWGCKY8kiQziI7COIcKllO+/vZhT1rcufyCrbBBV5p7ifPfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKCS0T+v; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so384677a91.0;
        Wed, 06 Nov 2024 18:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945389; x=1731550189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgxYLjSSYW2Ak/A3hPz/wNZip7cxIocJdeeQ6JKJEJQ=;
        b=eKCS0T+veHRI39dL6gRAnI4x7lGmxDS8UinJg2+ur3Gp3Oh6MXXnT4fB7I9XpdFbyq
         arI6+RMCKc7nEOKR9Y40xgf63NpvZSAFO7/nIhoI0QBZhNa0Mt9fqgHtCNMreALihnai
         JuIug68yZeWZd5W1DRYMsIfNdk0zYV6MO05NaRWueT9qp2HFgjzs6Lr6TgGRAvHMnNVG
         VKGnbCK+AydoXzmDLkQk1x4dHv8i/Zkx91devN/vTVPE9bTzWBgUhM9HUZXo6OYwnaJV
         YIiCaZIJFppXOqSNfFelGRevz87pY7yMtq7Tb5ginx6Xdzdp+VqLvuoglROSACIkA8PS
         XtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945389; x=1731550189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgxYLjSSYW2Ak/A3hPz/wNZip7cxIocJdeeQ6JKJEJQ=;
        b=wx8sVS2NrzvDKY3rtMVGoZ0T5wvE6COfUTkDctPWPAObMa4ITW2BYXDrXQCX67MNv3
         1kXTnl0ctmkjzO7HOgCA24xbAYbRYsqlVr1PJj+ZnO1xzG7PYk6pdvNrFYpPf2PJYyTh
         4PmJbcDTpRHAW/at3dtVW7vT7WUn8fUXg8mc5eNUKCjgfmyAUhkS0oceH7pnGhCCoVew
         Qv5Q4dPEQvRcTRIdTBfN7+qg+A68x1AwahIhu9ZxsPxnocEBhhLqP/5+uETo5oTPKFdH
         NpYPLtQR5nWhkRE9XnyO9QvYII6v1mNfgwI4n3fcbXzlI+YaMyKEq352D7N0I9ep58qi
         j7jw==
X-Forwarded-Encrypted: i=1; AJvYcCUKZK59ofWNL9NFrFcEeB/1S5v7VgjqaKXoZ0pWRhVRmYKKQXPwQoweiH4mM4q12OmmCv7ZAGKe0ZUK4FQ/pVY=@vger.kernel.org, AJvYcCVObjkFGhinJL4JouaOL60Lpy1z4ZpqemxW+MsYghlIKn5WfN4/gsfIZw0etSMkSV8h9gJBmPehXH1zq0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtF4aMrEQJT8SV3xt8hTrxKwFaKHdj1ftchIR+Ro27fmVBqA5
	2XzR6Lo8H20jhL2isBGnNHn1wv5NEU66rjHkJtCOe76AlO13RONH
X-Google-Smtp-Source: AGHT+IGeEkEOkIG/ktoKXUPcn2vTiYDT5t2Eh92LTMLlT9gT9dApjI9vpL+haMX7DpUkGaUHqrXYaA==
X-Received: by 2002:a17:90b:3c0e:b0:2e2:b719:d582 with SMTP id 98e67ed59e1d1-2e9a4da8cdcmr2448298a91.14.1730945388846;
        Wed, 06 Nov 2024 18:09:48 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 13/13] rust: helpers: Remove uaccess helpers
Date: Thu,  7 Nov 2024 12:08:31 +1000
Message-ID: <20241107020831.1561063-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  6 ++----
 rust/helpers/uaccess.c          | 15 ---------------
 4 files changed, 6 insertions(+), 19 deletions(-)
 delete mode 100644 rust/helpers/uaccess.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 396e2eac88e5c..4807fecb2f192 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -26,3 +26,6 @@
 
 --allowlist-function get_task_struct
 --allowlist-function put_task_struct
+
+--allowlist-function copy_from_user
+--allowlist-function copy_to_user
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1d1d921fd55e9..600ac0046a95f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -23,6 +23,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2af11499da454..e4e42e0ef946a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
- * cannot be called either. This file explicitly creates functions ("helpers")
- * that wrap those so that they can be called from Rust.
+ * Non-trivial C macros cannot be used in Rust. This file explicitly creates
+ * functions ("helpers") that wrap those so that they can be called from Rust.
  *
  * Sorted alphabetically.
  */
@@ -14,6 +13,5 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
-#include "uaccess.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
deleted file mode 100644
index f49076f813cd6..0000000000000
--- a/rust/helpers/uaccess.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/uaccess.h>
-
-unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
-					 unsigned long n)
-{
-	return copy_from_user(to, from, n);
-}
-
-unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
-				       unsigned long n)
-{
-	return copy_to_user(to, from, n);
-}
-- 
2.47.0


