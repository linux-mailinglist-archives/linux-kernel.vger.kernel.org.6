Return-Path: <linux-kernel+bounces-399239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D5B9BFC64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C41C21A69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F32940D;
	Thu,  7 Nov 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrWjbV5Z"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6380C02;
	Thu,  7 Nov 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945375; cv=none; b=OhLGDHehqnqep+GPpfVO/5C17Uehm52Tae1mWX0HZ5P5+TG3YgkTVNjIGUmnUKDhp60jkZZwYJNpqyKcfoa+/1Bb1Yefo4oxl0ZpCnxvh7nSI9TsSX6aZh5SORClNJ4Q4qQ1JPABhukIhjZeJRSj/XGNIzvAwj56THmFvkrMTnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945375; c=relaxed/simple;
	bh=Tc+qbROOF9FBTJbUdLKlSE5dyzIjPB+y2qE6X98QIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBU5Zk3BnzB45P27eLeWE91TLo1KX83fnZhDVWQmZyAJgZqECOZy8vOXLNpMIqwl8+PyZ6aggBEt4AqseLy32iXz3SS7bmfVW+S4OuMgSXLkLQlKY4HoQixGcmlzqn/DJmHTstdsdpsOxXWBXxM7YZ/Yhe6NGRg2hbuBBegjThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrWjbV5Z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so375195a12.1;
        Wed, 06 Nov 2024 18:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945373; x=1731550173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym9ZGogDAflbJuvwnxTT22F8uqrqymxKBz2B20yPLJM=;
        b=FrWjbV5ZFXKoQZL6Tbq++ix5EzUS0pprH8TGhT7On+yoFcKk7uuuOndsCAotZIZt4Q
         yIhuojBrGqprszkhq9Dgzj6Y9PZMXqZJaOzLjHR8BcvRRg8mD+qpFYJwPeHx/WmbAIGm
         9EyFRMYUuuJ0sbqh4ui6xSErVLGZmo4MRX6fU1mNiwI9B67yd3pX6jmdj7F+XPKBGYeT
         IVOgCc9olIjQyHlDW9/WLK/LQORrc7TZLJjaq/cmITka049wJwGku8nux5yJOEViyWXN
         JgI2NUsr4Qr+3y9bA3e/Xlv+EMICGOdkbROWYBjtuLUxvq1Quc8t4ZlV9nD/R1UCTMNA
         K0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945373; x=1731550173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym9ZGogDAflbJuvwnxTT22F8uqrqymxKBz2B20yPLJM=;
        b=hMHYj3mq+oAoFTi3YV3dpAREaYi+hD9lU2of3GF0gl4T/0/iuOhDvsvg0ssLDdQyt3
         2e3gSQVpvHZJPhQCk19lY0PTwvhZbgec6cI4L7TBmYZSsUY2qc6UYAvz1JRvefn5kAkq
         VDOPQc6FN5hH1K9OT5VNygSE4aMTqjuJ/J8VUiDK6W3snsgsS/9KymZHaa+x+Ma/3SMA
         amo+XpAEegLgoMLkNMf/sVX8frFg9TU/+XhwfdxKSFKGWwOqU8SPc/i/yetTLw7PEOEr
         bloRRmFn4xGzktoT7bx+kwiMcpfh1oxkeg+zO+QCtidt+wlth/8U7Af2hVdV6Z+tMn1L
         o1WA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZL6T+BHe2gKw1z9nNUleI+v9n8sw3mpndoGXp3bYID3ho7Gg1DNtsdbS0ixDdDkP6lMYFvSdYuUiCroDvEE=@vger.kernel.org, AJvYcCWJ/mk7XA44xF26DTtcocHEXtENQvYg1wQH3Ech9ESvBpcogqqIFM7I4f5/LDOTvpVefrtoHe0njn8CfU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/swd+Uh1R1V59ZCoOgkOz/kt+F5646UWR8Syxd+cuNilgXc0k
	BCUaKj+KgUBuJulRwaHpU5Tn5YajptDzzchRbHFv33LoFOxWg3X389cPpA==
X-Google-Smtp-Source: AGHT+IFaCGPSOWvlki0vXU6yv7DWewU62mvecXCmuZ9B27hlwcpB9u8kU32ziOaI5DGCp7BEqt/nzQ==
X-Received: by 2002:a17:90b:4c11:b0:2e2:e6bf:cd64 with SMTP id 98e67ed59e1d1-2e94c2a15e2mr30870329a91.5.1730945373244;
        Wed, 06 Nov 2024 18:09:33 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:32 -0800 (PST)
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
Subject: [PATCH 10/13] rust: helpers: Remove signal helper
Date: Thu,  7 Nov 2024 12:08:28 +1000
Message-ID: <20241107020831.1561063-11-alistair.francis@wdc.com>
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
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/helpers.c          | 1 -
 rust/helpers/signal.c           | 9 ---------
 4 files changed, 3 insertions(+), 10 deletions(-)
 delete mode 100644 rust/helpers/signal.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 9c40a867a64de..407dd091ddecd 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -18,3 +18,5 @@
 
 --allowlist-function refcount_inc
 --allowlist-function refcount_dec_and_test
+
+--allowlist-function signal_pending
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d389944186479..0c2964db04076 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7f9ffde471da3..2af11499da454 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,7 +11,6 @@
 #include "build_assert.c"
 #include "page.c"
 #include "refcount.c"
-#include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
deleted file mode 100644
index 63c407f80c26b..0000000000000
--- a/rust/helpers/signal.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/sched/signal.h>
-
-int rust_helper_signal_pending(struct task_struct *t)
-{
-	return signal_pending(t);
-}
-- 
2.47.0


