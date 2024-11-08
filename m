Return-Path: <linux-kernel+bounces-400966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FF9C1479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E12A1C20D66
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93B199385;
	Fri,  8 Nov 2024 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQTZCL1F"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C31991DA;
	Fri,  8 Nov 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035485; cv=none; b=cxO9165wPIt1n6QVNgs9J6yHOG42oUrt9nfXWYe3hScsc13k5gvtUbWkfyJje3/osXHJKXCs0THlXaS/KiPSL6VJyhjUwsnP3FvNiN7FcVc9Mq7vghmFMQ8k7zUBm6XbfzHmMg/WBEk6kh/sS896RdrVHtptyZovk6nNSgpT3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035485; c=relaxed/simple;
	bh=g19ESF38XnPNOgAGwCMocaUk/c09aizfAjeVo3XURuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCXfCJ0P7/VV/4XJQevHONMet27UPvvPr3jVkrMMZv6eC1+w8A1mDR5TCGI909FPjDzx7ZjDdDl1tJXbkTRH7lhI00emiJP4SvzrwukkxjvzcpgGG4y1Rf3hFdbXA3j8tnZraU5JpAsnGBJff2RakpZQ0oD+APFl1K04f4MXDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQTZCL1F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7240fa50694so754502b3a.1;
        Thu, 07 Nov 2024 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035483; x=1731640283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p13tT/thphBZ+1rHR3C3p72SA4taa7/M0quBz0qbaQ=;
        b=OQTZCL1FPM+VeIMRi7h0BglM9XA/WyQvO+p+xH+DozZW7dzrTR9rLdPLf7eLjFZ5Vw
         4g82cYl/VN+ixm1QNxsQydo1KhEVKNbq1kf4vmoOGrrRJ7MGhWMC7qYiqCsi6Dwoonzd
         i/b/GhuguZYFQsZqiXPHLJGNdmJQnr5nNgb8oXA/p56NQQRcno38WBgOruDmN0J3MRNL
         3EY82pnCqJXCdDMWgoC4eVFBny8ujK3M1Jt/n3Iu0yJWkDmH9EPPUSiKeOEjR0AypLxg
         uUrXvEHsxa3FSo8O1blf2Yvd/22aW3vJVMSiucc5SaMoL6C6Rkc/KfD61oCTTv8omJ8J
         EJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035483; x=1731640283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5p13tT/thphBZ+1rHR3C3p72SA4taa7/M0quBz0qbaQ=;
        b=HRXi0utd3fkTAPtj/2U8VmyyjeQpK895iHYlcYbEPUpFiRdRu5rOiWVIoffmtMODUX
         b84zKd+CGpEktX89un7xfXhuJ+jHyR5mHpVD1IHJNtajEI8AZLZ4MgEbkcyWteYxFPYc
         931Evbxh8ntak7xQq8NoTLPakTJ28lxKxo52DTGprSZi39Xf9b3ODyOFttc8Vte/Hy6j
         mEWEKgVG5W9b4qHxOSOVntM/1jMA1anmz/SiYGUasHgXpymxgBMj9wNCUMQU3Hl4WBjr
         TSK8ESiq3nReR4OFzGhGnBryn1d0S77yoO4msiDYRrSWclWlsxoeXMtSC7owiH2N7RXi
         eu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxhNYqpnCUGGbiQnnbHmPexZMUPvAXeLXMGgMh6KAWQEZEo4Ybi/NyFdvxW9Q1mLtvh5NeGauJesxDTLg=@vger.kernel.org, AJvYcCXxFtspPqONWf5fgmn8Jr7UEBvsNqNgFoQoy/HTf1gDjAwTKVtTELc5NYmKMqVIs33pttuQgqHe3n8P396IxWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/abG9nmCXIqJREOrlf0E9/tTI5l4aJ56p0yCK/gPqq+4/GGo
	sZhkTeyVH86o9Cc0ftIckuH2IG6wq8qjzoOF51HLU/yljuP/sYvr
X-Google-Smtp-Source: AGHT+IF9Nt8wFTnf1z18NanbCXUbHNaI7X9rfNZcbQStZX/zykuP7aqknZr8bwt6fX9Sr//WwdVgXw==
X-Received: by 2002:a05:6a20:6a23:b0:1db:92a9:4cd8 with SMTP id adf61e73a8af0-1dc228df523mr2026274637.6.1731035483359;
        Thu, 07 Nov 2024 19:11:23 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:11:22 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 11/11] rust: helpers: Remove uaccess helpers
Date: Fri,  8 Nov 2024 13:10:12 +1000
Message-ID: <20241108031012.335203-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
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
index 8bc291a7a799..ec48ad2e8c78 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -27,3 +27,6 @@
 
 --allowlist-function get_task_struct
 --allowlist-function put_task_struct
+
+--allowlist-function copy_from_user
+--allowlist-function copy_to_user
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index eec195a21fb8..a850c21c432c 100644
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
index ebe3a85c7210..42c28222f6c2 100644
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
@@ -16,7 +15,6 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
-#include "uaccess.c"
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
deleted file mode 100644
index f49076f813cd..000000000000
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


