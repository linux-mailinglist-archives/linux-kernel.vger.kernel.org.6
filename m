Return-Path: <linux-kernel+bounces-399233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC59BFC5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22143B22AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542216F84F;
	Thu,  7 Nov 2024 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoUdwzwm"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B915C138;
	Thu,  7 Nov 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945343; cv=none; b=HHp8sjII1jecPv557bLfCr1qbN6nzY7gblJoteFixElY3gvX4Srw49eXDJcxxCNujrBsHMnugJlfyLMbaJXz/ERzGDR244iwXnk+U6SRaUsR2XqgzUgCgM4zHehYmdTxWoQM67ezV/c5i/2Q1CA3GZlUn6AuLoZ8TWpagHstDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945343; c=relaxed/simple;
	bh=pfNDrAMVomEUvW+LbVJP1x7ST16tFeEZjpxTr+Y9JDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrfkkC8aS7EidZSMrIauTKqpH3UUzfpVjV4YBqF6wDMzGWrcAXokl8E29Ir79X6SvP0RJFt92tZ9ThrurGKUrz4m5iJIe/74eTA+HbAiZz/bB8t8/PHTpEV9ZN2aflIFJX/afvasJOCle6zd9fNwt4K4I/L8ghIUo3J0VdpwD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoUdwzwm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so1259363a91.0;
        Wed, 06 Nov 2024 18:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945341; x=1731550141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf0pvGrDPvRarrQBRRieA1xBLh/1KQSgL6QjimbV8ss=;
        b=NoUdwzwmynpKd35IgKIXkltbEYz8sRAxIo/Fq32iLBv5Ij1mqRT/rNb9HmBL7/19Pl
         YnD80k2S/edGQEyNn1VELleVHzZ8d+YiLSoxyRGGH2tAVGZyTY3Ue4lgSoBnZbWrEEA/
         4ogk4ddmSulUudmOJ5Uht6L0ksMslvefvIhJfXkVJE/ViegTF1U40SjeuP8AiTt+M6IH
         Gw4tfKBZM+gk1+eOy6mUQMic/8mI8XwU+Xw2CTTFY/auA9tTKa+37QZ0MzKA5hUj3jUD
         6TBwNLnCJlJr5T2s/MyHe0eI/8ZTYp7TXM7xBCRlsMUqAeQnDB+V8MChhId0pi/L6weW
         jBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945341; x=1731550141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rf0pvGrDPvRarrQBRRieA1xBLh/1KQSgL6QjimbV8ss=;
        b=wUeV5gxp2k2GhgTXCoilWTdoP8wpK/u1oyczpNwdn6d6LtkuStbr3BZ89SRh8wCim2
         NOMkP1uIVF815UmItpJr3nn5JzrZjfkQOEIL1hv/eMrq8caCtCMEkxBTzpcMBAfZjYW0
         1xvAfFsTYaKtr1Z3z/Ojn+IDfRPHa3oUpppnp0BCnl78xvxn/ApzpnOZ06YxQKxSlHFW
         JAhDeGyrRyg7c8yxvyVzawwgfoCUAwg71NEPT+HYwGYdwI6+BZqogQmreRYfmQt3UXbx
         YBDbioq7a9b7bivUafiKQnqCCY8u/8AZA9R9n1RDj9lalC6cGr1465Bx8jc18nVEVP6i
         JlIg==
X-Forwarded-Encrypted: i=1; AJvYcCX8fiyTneMR+AuIqrqTVPbAsQwknFGH8wsDYkvkjAlS93NZuCoosrmJf8bsomAvwtinnx9JhFsULvM+pegXUHE=@vger.kernel.org, AJvYcCXyR+b2rNKb0PrsfeVTDprAiAeYjCA7ardbNCpdk47TcpK32fauBWGh3AWlKIDbuAX9Zc4Vflc42yGQ0lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5sc/2xf5dhkHX5fFjtomNfjecx3x6cybPMUKqFsaOpARuXy5
	O3qMgRfx7oaQUIMS0O+I9A3X84vQTzu0lyOx5VG79P+oe2//3fj1
X-Google-Smtp-Source: AGHT+IHHcmX79oI8Xych7iPIxgGCKaQ61oMoset3klp7hllqm6olOIaLUlRHUoSwv8YOau99JwYvXQ==
X-Received: by 2002:a17:90b:4d0a:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e9a4d265b5mr2301560a91.2.1730945341540;
        Wed, 06 Nov 2024 18:09:01 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:01 -0800 (PST)
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
Subject: [PATCH 04/13] rust: helpers: Remove err helper
Date: Thu,  7 Nov 2024 12:08:22 +1000
Message-ID: <20241107020831.1561063-5-alistair.francis@wdc.com>
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
 rust/bindgen_static_functions |  4 ++++
 rust/helpers/err.c            | 19 -------------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 4 insertions(+), 20 deletions(-)
 delete mode 100644 rust/helpers/err.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 42e45ce342211..0269efa83c618 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -5,3 +5,7 @@
 
 --allowlist-function blk_mq_rq_to_pdu
 --allowlist-function blk_mq_rq_from_pdu
+
+--allowlist-function ERR_PTR
+--allowlist-function IS_ERR
+--allowlist-function PTR_ERR
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
deleted file mode 100644
index be3d45ef78a25..0000000000000
--- a/rust/helpers/err.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/err.h>
-#include <linux/export.h>
-
-__force void *rust_helper_ERR_PTR(long err)
-{
-	return ERR_PTR(err);
-}
-
-bool rust_helper_IS_ERR(__force const void *ptr)
-{
-	return IS_ERR(ptr);
-}
-
-long rust_helper_PTR_ERR(__force const void *ptr)
-{
-	return PTR_ERR(ptr);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0f0c16c1e8149..40e51daef412e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,7 +9,6 @@
 
 #include "bug.c"
 #include "build_assert.c"
-#include "err.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
-- 
2.47.0


