Return-Path: <linux-kernel+bounces-569065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F32A69E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B70C19C48D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F81E5B9F;
	Thu, 20 Mar 2025 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="t9wMwqMe"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199F1EBFE8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436557; cv=none; b=U88wQLpKGTsOAHzr45YCRAtWC2YhwHt7awLrwEiZOInLp8bwNgIVaCmdYHFvrFzeKgvdQp8/bPoyah1eXSJIY2Yg3sBHw99MRpagrWL9Ao2ggnAst1ukT/cgvE/39bzmcN21iaNpkvDZNJEwmDH5Wg6LRs06SC4cneMsTLKHjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436557; c=relaxed/simple;
	bh=9ChsMWB9R6IufCAvO0z106+Ye1dl3VW0wCDjtZrHUvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgPEh/O9lbW8xxgKVGGIeOCn5lAaDqBVeRdjGo+HAmgufejuJwV/n6/A4xHTlWUV/HiPvf9kjduXkI493/O3AzYKb8zQ7DiqWA7o/t46aAszbmrK3AZK71F4cAsMtB0IZEc7yM/Da9mxM27/zzvoE0lj5VEkU6/BhNYbgpUfO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=t9wMwqMe; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53a91756e5so211149276.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436555; x=1743041355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5xpeMoSol4YYbgPmXkzSJh9NDUviiNm/ZDSdPgH23k=;
        b=t9wMwqMeBqTFWtWspbXuKsj6FnyKl2FzIxiMoIOEe717JrvO9raPY7+hCVR49HSMM+
         pQY7/SyrN79cIUr3FuZaeDysam8Mhbjy6sFGpkdHkhkG+hg4+bjEgz+atF9p5KmA0rAL
         irnC755Al0guS7ouaXKf6rJTEdDy8ufRBpPJapON93IKl36UJsqeB8Z/b9dtdFgESntq
         SJosK2b9JDj/Drf/hY70L6Tr3PoCj+WQdK8h0F/FZK0BKzLr06iAKWcD/pFuEaXJWuD7
         szboXkfe5ENObtLCVzZ0Ez4D8kXOwttc8wAPgWVwh8M3IA3SXypHWnFjH/dBIzNA6mSo
         Y1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436555; x=1743041355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5xpeMoSol4YYbgPmXkzSJh9NDUviiNm/ZDSdPgH23k=;
        b=E3JbSX5Mhwl5pN9xZwH3LD9180TtkuFC5JWEQCwkdbT1z7/CB3dKkRZElmK37Ypo0k
         E/P59ae3u2MjgGUNSCKO7UYi/GX2q3mzQZH4hP/9xmZcd2zjysz93rlGlIG2D0EpfTu6
         SVh1tl2XMho5l8XGiX74UNiXOYZhPIHinuuOW2g/khmUyKfvoxwl9RS5oH3kPpwYUafj
         qgJ0fomyI9lw/G5e6v7ZQc82SbnPDLssj7ME7+8qnse7HuYFAi8pJp/uESjVsLmpznOg
         TQnMyOCap2sTkNlegzPmMTonkCEetSn6hugF+4C5lvGvxVg1ETjIkHWOaBXhINQQnS4D
         jrDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUPAZMEQrUXP1/9ZK8CSHfFJ1iW718ATQBXSokYkN+j9N6JTnre2zN+juPIXSY6dg6U9OjPdBBYgx7/L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKpGzet5sswZCh/EQ59uZpUYE0txwZUS9aBedYJZXxX4ZVckn
	WDMvp0VawayCndnOY6EYxf+IHcujxj15IwlZXHoP+8kiqCJ6JG/Y1aqN1ivF+as=
X-Gm-Gg: ASbGncuIjEHbdEM5aKC6lr4azbvGNrhTBzPAB7NtDphsVjykPYbLJccKxslQ64bXebq
	tCGW/FcjKQDUgLGoy7pasoDhIQ0xkn9/sXssHGs6mPHw4SleOx4GqnfSinA51lqwOuko/ijy2WT
	WaDbqotyXPoLgeOO5aUDAY6g6Mlj/WkavAZw+mFRitKkigHU3/+N65CQdKw+DVwYabRMav2X4RU
	RYjWkO2QoR+ik5+hcixhQDb/5Tu7Gds84++Sy2tlj9CTklPgm6HNf9z5LgubYc7vescgbs7H3wu
	uxPT4sim7XYINT3P8ziqkrG8JfwLgBxywXpU8ZbHbUf3FBwjSIyxCNU6twnyH0/HhecET4QRz9F
	OM96bUUFG0Jz9LaTufdoz8kkHA324Xj2q7fOYhHCG
X-Google-Smtp-Source: AGHT+IFsawTTSu4ze6h4UmYPI+M13Ve2gYZXnqPXGv43VUQkqO8yiFuERTKF/hryshNtllUUXhNsZQ==
X-Received: by 2002:a05:690c:490f:b0:6f9:9e25:e992 with SMTP id 00721157ae682-7009bf86581mr76597567b3.10.1742436555463;
        Wed, 19 Mar 2025 19:09:15 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:09:15 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/17] rust: jump_label: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:33 -0400
Message-ID: <20250320020740.1631171-15-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` with
`&raw const place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const` is similar to `&` making
it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/jump_label.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 4e974c768dbd..ca10abae0eee 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -20,8 +20,8 @@
 #[macro_export]
 macro_rules! static_branch_unlikely {
     ($key:path, $keytyp:ty, $field:ident) => {{
-        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
-        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $keytyp = &raw const $key;
+        let _key: *const $crate::bindings::static_key_false = &raw const (*_key).$field;
         let _key: *const $crate::bindings::static_key = _key.cast();
 
         #[cfg(not(CONFIG_JUMP_LABEL))]


