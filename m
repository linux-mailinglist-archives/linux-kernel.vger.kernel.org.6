Return-Path: <linux-kernel+bounces-399240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82F9BFC65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2671C22A65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACF192B84;
	Thu,  7 Nov 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmzdGher"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209D380C02;
	Thu,  7 Nov 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945380; cv=none; b=pKdqxkVYDBtCxvUX702nrXcl4xwvVvp448ZYRPmTCbY5n7ahVmfcneWESClI+7jMtHQGbebb+YZz8YmzzdMR7pJc4l7XVbv2w+yjWvXSEjLsz2DOtnqoBV25L+g37bQJpNi+848XnfcUcfrg8beL6CQI50XdeyHzKr1e+fvyuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945380; c=relaxed/simple;
	bh=bamIKhQGaYDy9tVbD7L6kZBTFXDMpDQUiSo7PCsaEVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRLyNPMRs6i1LRYo9sumBEIyQ4xe7csWNyKgBeNztXLjjfOIa+qSCClwde2+rtUzl+5Wfledj3FkoO88oJhQQ0wBE9ixvaD/4WdDgvFSIITR2UxHu43xou9o4ARUMEh8JFkig4FAGxvpKE5gTPTzxy2Jh6e56i90ykB2WEQldto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmzdGher; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so363716a91.2;
        Wed, 06 Nov 2024 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945378; x=1731550178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRzuDEr7A4idPLy7mCCT05NiWbGj2K8HCIaGJ4K0ZiM=;
        b=lmzdGher0rkFBEUHzOu12sbbxs/gi6GCcHLvjmZ0WK+e6BtyiXjZX9cV6lZkBwZBkW
         ZpEHmXTs2dlzwFw5FJGRiZu1ocrXd+qugL3IGc1Je4c4YjZIbRjBzCj3AfK+ZB66YcNY
         h7AHnrOyMEVV+9oNRSnT45wDOTqHblXdXPN+9dU5kY4UzFg9eh3zFXiUQYxYf8YkZelN
         l0W9qzt/IYwXjaZCgKtueB8pRtFAt0cU/ia9b3w8jJPfAO2pJl4IHupeXq8Kvy8RI0R1
         qQwTU2AjiP3o2n6MXrvuP8bKMJzHHdgKoR4HTfzEjeM9qtVsnmqk0H/RJBfTdhBIwG42
         vOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945378; x=1731550178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRzuDEr7A4idPLy7mCCT05NiWbGj2K8HCIaGJ4K0ZiM=;
        b=xT/tUNHUQe50Ew0fmG0s5LXFWIamwlqLaGLvLkDSsoU7rFNAYywI/kTQdKZyFTofvQ
         7EazyOzgyb/Osght9Fm6Mi8shmPl+raKwsYOCRL6UMB+HWTU1tFjTfJGdm1DJjTU8Yl6
         wyB+maROpT0/Lc6TIosnjjZNVAGINhgNl6NSwMDoniDl9T9Cm3AMAVcMqv0J1P6KM7aI
         9Vt1O3SGagfkiiYc9Qk8eU1G0Kk4DIYz9gmQ1LWs8h038VlJbxK/6lAUAINtS9s+cqm5
         K90zFCizNEH8lLOPMHI4tjBh/bBuUkIZEAkZYU5xCAxKtBzHJxmPJOVe9x+jDjl4evsU
         p04Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4uhPW+OJ59NST7d9bAxU/QuhqY5+5C/ZCF2d7+me/mvkJIS1DiL5m4iVed7yrCwTW2r4H0C3qtKfkkoU=@vger.kernel.org, AJvYcCXJJ7pphBAC1kSl6kCIlE3RqZqpJRmIRvyEP0Iwqpbg6B1Frkwr7C9z7AeHPEl0UuXvWu87LesrJ2T4ZlRV+uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58MUutCiqCTclZgowlxaC6b5xj771kM/SA0lOrZ8E833U1M/v
	RMFEEJy4XyncMQ4CVZC6LjbsIjCk+KG6/botTYQLRY0DffwzNJApBv9L0w==
X-Google-Smtp-Source: AGHT+IH9EkHWCEqxJIu4iMLeVR6O1tdOgBpUGX3NHXc2bMxEN2D2DyVLDXTNvkYt1Mo6/2fGRSqmzA==
X-Received: by 2002:a17:90a:e154:b0:2e2:e148:3d30 with SMTP id 98e67ed59e1d1-2e8f107354amr47474173a91.23.1730945378421;
        Wed, 06 Nov 2024 18:09:38 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:09:38 -0800 (PST)
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
Subject: [PATCH 11/13] rust: helpers: Remove some spinlock helpers
Date: Thu,  7 Nov 2024 12:08:29 +1000
Message-ID: <20241107020831.1561063-12-alistair.francis@wdc.com>
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
 rust/bindgen_static_functions |  3 +++
 rust/helpers/spinlock.c       | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 407dd091ddecd..0bbc358d03e61 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -20,3 +20,6 @@
 --allowlist-function refcount_dec_and_test
 
 --allowlist-function signal_pending
+
+--allowlist-function spin_lock
+--allowlist-function spin_unlock
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index acc1376b833c7..fe85d6fd66016 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -12,13 +12,3 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-
-void rust_helper_spin_lock(spinlock_t *lock)
-{
-	spin_lock(lock);
-}
-
-void rust_helper_spin_unlock(spinlock_t *lock)
-{
-	spin_unlock(lock);
-}
-- 
2.47.0


