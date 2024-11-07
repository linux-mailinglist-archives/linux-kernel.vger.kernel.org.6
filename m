Return-Path: <linux-kernel+bounces-399241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF959BFC66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AF31F22ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810E193070;
	Thu,  7 Nov 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWwlcjj3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576779F6;
	Thu,  7 Nov 2024 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945385; cv=none; b=ouLg6I7SSUJCYsQ5PAX7k6+UAwVJqxt5QIh01v5qkIqXsFZ48L2PiiKsMS/qY8aGhIN6RouWpkYQqrGvgtlkK0n2gTj8r/wKhYxFOGTiTTjuKyome99Ji++rXEMyMDRD5gVtW7hSYT1vYTlHOxapyXeNRw8/wJFH7MmotZXjWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945385; c=relaxed/simple;
	bh=VwwQiqx75FPKc+KrOJumAj/W+xlGINorBGM0WEBiXm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6ukUiVQbqj3Ft009s82TvDq8xz3w+TTLH32C4kfCz+FJiqePIFmFsgRQ11HoyqoD3RxKZ/mfWqUzOehkqiv1w7M8b2/1Gqngbh+OyXa7wiqGQCgbdzgd6A8geGWBP73VgskgzgAR2sOg56ioieFHyjgV6wcyxKi49QVnF32taA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWwlcjj3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e91403950dso346672a91.3;
        Wed, 06 Nov 2024 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945384; x=1731550184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxjO5kT9xqDjdNWGFnRQbGm5wL4XmvNh1k+h89GT8J8=;
        b=AWwlcjj36KJWo+uO8YaL2SXQQRqH8ex0nJIbbHnHT72DLIazfEACcIVBoQgiy5k+rV
         cTxCqD5ErYwiMLSB0Z4l2cjX09HPKZaYBG7tn605Ij+b9PiPfeShpMn32xHeaC9gCV9r
         Zwk+AXXnshUuep6amlOcuPuEr22U/YVmqBF5t9WfVtRgFHO7kmJy51BsShAToLkUkna9
         uAwLWqOlieYNsSZdsioHKn2aoG3WW0wcVm32uI2ETQWeXq3Yvg+HlJheGUAqFm6UMKco
         BJ6/gs3b2EJC7Fe8aE4wcJ3TEKPHZUzcgP7yXeDqPFjiRH9iBXya4hqXXe+4+6EOKYDw
         BlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945384; x=1731550184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxjO5kT9xqDjdNWGFnRQbGm5wL4XmvNh1k+h89GT8J8=;
        b=rEz0jAwrEOtU6Hs42c79iTiBvWxrYGRyVj+w4nsMLDr9z3S9XaYkaHaODJFH6nm9vP
         UYR40QT7zBDjuSM1JNScVCUVYxgPvltRu2ncmPlFIS2AAarLt8IMkJ7HuMFjzmsAdYJG
         3wZRyERfBQmi7vhUKEngWNlZ49teYQLD0cuBrtWPmTfm4HHLBd7TiNgpyyssfYVFyAkJ
         UsDGJQm18Yan5lyDO4VLUJBwUuDIzVez6/ByzxtlF47SclgZHbLgEUgPciFQPNXdJ9U3
         cVRcHO2B6yhxJhI4mWgKMPAdfX9IjJUBwBZd0d+AnXnf8j8WB5oina1mfcHTPwLsu0O8
         +pGg==
X-Forwarded-Encrypted: i=1; AJvYcCVq7IjF2sJkw6q4K10SLJSJk9R8xZjO7DfK4rXtInWDGR5+LNDCP08L1T4dDTejBmwjN0fE9rBiJkz3SNW2BZQ=@vger.kernel.org, AJvYcCX+E3nMlvkbT1dUmiidt8T9tKyGlQoyvTDIJ/ODTcAZH+COS3bgCVbvwMaL4QsCBcEGt9bAvy7bcwxsY1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNaWRLrc2dOqIzsW7EZPvEfr2U9QgIsg4CEOq9CghnRch4Gz/
	o+hz1XXPa+JQq2EjfJYV7TWxVUWD5bpLQYxo0MMvB9FlqNMv/PPV
X-Google-Smtp-Source: AGHT+IG5JhKhTZ2nL5vGnmSxNlVOw/ax+JU8vxj3OAVEHgqORyHBkKgFJUYthcI4/2ECoHVfHP8FSg==
X-Received: by 2002:a17:90a:604b:b0:2e2:bb17:a322 with SMTP id 98e67ed59e1d1-2e8f11da738mr42285982a91.35.1730945383594;
        Wed, 06 Nov 2024 18:09:43 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:43 -0800 (PST)
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
Subject: [PATCH 12/13] rust: helpers: Remove some task helpers
Date: Thu,  7 Nov 2024 12:08:30 +1000
Message-ID: <20241107020831.1561063-13-alistair.francis@wdc.com>
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

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions   |  3 +++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/task.c             | 10 ----------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 0bbc358d03e61..396e2eac88e5c 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -23,3 +23,6 @@
 
 --allowlist-function spin_lock
 --allowlist-function spin_unlock
+
+--allowlist-function get_task_struct
+--allowlist-function put_task_struct
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0c2964db04076..1d1d921fd55e9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index 7ac789232d11c..a3feb47a6c73f 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -7,13 +7,3 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-
-void rust_helper_get_task_struct(struct task_struct *t)
-{
-	get_task_struct(t);
-}
-
-void rust_helper_put_task_struct(struct task_struct *t)
-{
-	put_task_struct(t);
-}
-- 
2.47.0


