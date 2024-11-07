Return-Path: <linux-kernel+bounces-399235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4769BFC60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1DE1F21717
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC918BB8E;
	Thu,  7 Nov 2024 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6uvb3dX"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB818B47E;
	Thu,  7 Nov 2024 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945354; cv=none; b=EXelTV1B7Z7QQjwww/w6iVo65qRbiXphpAM7PI3bVAh0UnmvL1HCoArsQvl0WDvabi8GLzgssEbvhyLBP3i0XbAsx38m6QO+U5Qg4PmnYfqQuCeJ6TPqRkHTrI8NU9MzJrDWi5vSMeE2ueQexFWIAc3LFG2N19tjYh3V75g9EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945354; c=relaxed/simple;
	bh=OBqPs2vruTM3OL96Dshim5lAbj5UwzFAi7bwkUS4e7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJM0/lCsCVXtM5SLewkc1F+/xu3Cw/AiKfJjj1RET5gVf2fEJYIHFnYZc7EH4vCZ8sRVO+OBQlS7UjYxuC+uy+3qK+EgmDAtH2UR9W+xc1Ri+Q85HNnX0whSpmtuY6yzaL0ApawgKvyLr0xUUpkthN4obGk68M0pX5EpnaZyf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6uvb3dX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so368059a91.1;
        Wed, 06 Nov 2024 18:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945352; x=1731550152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nx9ez4yVW8aC5Yu+EVh1rahutankVFO3Y6fA2Tk+j4=;
        b=B6uvb3dXLORpQ169ecrnBX6ZNV7evXKWWoyvcstP4WpDcjb3teTW4g0bjDIT34bgEW
         p5k97dTwkCH3d4mEisfoWAUnV49iMK8UVgtf2KQRcDRxjM1/BYUC44p49Q2GR/Bt+9ea
         Su1i030pGHY1S2TjykqQZzAT9sdwer2kQt1VTwar4olZSmMPFB8v+SuKZVWl2rlPf5b3
         +oMTGbvU9fw1np9MFgXUBHW1jC2w5PGt8S/M0pHTqfr5sf3W0egWDgKYWjbgCFf+I5Kv
         pola4+4moxkeRmGPqCdRssPQwz6KDiOT5ZSomziFphtUiMf1rEfm5B6HMcNh/JKia+4B
         JAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945352; x=1731550152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nx9ez4yVW8aC5Yu+EVh1rahutankVFO3Y6fA2Tk+j4=;
        b=jWExabSIJWj3J5Imac0f0KsLHseTGQh+b3cuNIYbPoOqwFS0Ly2GJE83bnO5myFD/1
         IbXT6vsajxv/SyB+d0dx0khki3bxrCJUTa6OvHxq6VygPNm1LF2MMvWOTdgYAz4Gfmx6
         rPU4WJpHry5aKGihgJELduXP9QAxHluG5wK6MADZSVzOkqXD3s87RdJ0bVJSTz8zG4Kh
         EzyowvB8Dg1Vb7Tbf9SMXH0eKzZ1665UQPT4+Bk8AUlmfOFNHbyMU0kpQrpgzJXW3B0o
         1kC4YgA5AH7mO88CQ8AuZVx3Yf3bZv0w5Yn5yOBQ42d9CFN6s0NhUIh00HPItyr+ZMyH
         5Ksg==
X-Forwarded-Encrypted: i=1; AJvYcCVF5duUAqIU5Eaoo0llkpxiKnn+lwoBxJD400JREIBhcYHcKdW8wpg8UL1YA5kVsbxbLXALArQfrLO+ylN3ewY=@vger.kernel.org, AJvYcCWy1rm0Wm4nSRL/Jl71nzvS6BtOprVDXYtDsYFNIo93QjLrivA0+UMjHCOLQ/AMXOTbx5EDFBiUBA+HQWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nZEHOL6U9huAyBOWZkj0qXFuaajkPaTlGqDtSBt/4C48Lgpj
	K2UrDYVGbVzu0ZjU6eF0ML4lv6u6emzMX93+NCVozIEJhsjbugLYlo65Og==
X-Google-Smtp-Source: AGHT+IGwkX9VXHWg5JhZIquh8ttvWcnn6ztjmcv84kBdIPJPBZSErxpXSOaLsm6/3r6YBiW3J8K9eQ==
X-Received: by 2002:a17:90b:380f:b0:2e2:c40c:6e8a with SMTP id 98e67ed59e1d1-2e9a7657c1bmr255975a91.26.1730945352034;
        Wed, 06 Nov 2024 18:09:12 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:11 -0800 (PST)
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
Subject: [PATCH 06/13] rust: helpers: Remove mutex helper
Date: Thu,  7 Nov 2024 12:08:24 +1000
Message-ID: <20241107020831.1561063-7-alistair.francis@wdc.com>
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

This doesn't seem to be required at all.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/helpers/helpers.c |  1 -
 rust/helpers/mutex.c   | 15 ---------------
 2 files changed, 16 deletions(-)
 delete mode 100644 rust/helpers/mutex.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 875e1fed81c24..61ace53675c04 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,7 +9,6 @@
 
 #include "bug.c"
 #include "build_assert.c"
-#include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
 #include "refcount.c"
diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
deleted file mode 100644
index a17ca8cdb50ca..0000000000000
--- a/rust/helpers/mutex.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/mutex.h>
-
-void rust_helper_mutex_lock(struct mutex *lock)
-{
-	mutex_lock(lock);
-}
-
-void rust_helper___mutex_init(struct mutex *mutex, const char *name,
-			      struct lock_class_key *key)
-{
-	__mutex_init(mutex, name, key);
-}
-- 
2.47.0


