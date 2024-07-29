Return-Path: <linux-kernel+bounces-265939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160D93F7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B51C22075
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7311815697B;
	Mon, 29 Jul 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFQG6SaD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E5156676
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262980; cv=none; b=UIyfLuK7o1iFmx4BXLQEsj7v15pWhziibha/JgQ/gHvh5QcAfzNZ5c8h1pRBGK8CC/MDBHT/4NberGiahxVX8tUMbPpNeu4XIPf0erWzzogj3hNrjUnZSJCIC6bW8yGbfs5ncOIkldBQEWJ7xXDjvEjl8dsXxLK2tb7AMvN/4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262980; c=relaxed/simple;
	bh=lzT2BdaEVnJIsuBgTyZNaaAeirv9EKd/rwlbRbDIHew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f2JbWsnnQAk2KG8zerRP3v2Ve3/l62rKHTxPa+fyVJ2qOe1asFzIhZ5bLVYDQn6y6WUPt31ocsGhtK7IXuFvjKNKTE5Gq8i0e/qkm0DC1lAo6AUobermPpm0ssbWEKgADFGsgFca7WnYodiUdzNq2JW+DnCV/Sfrn3Q149HzpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFQG6SaD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so50751537b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722262978; x=1722867778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKAVwhluDEm83CnDhzk3R+pdR/lsoORRqAVOgXJ4jh4=;
        b=UFQG6SaDekdFnJL/AxTKqVEUqoUepDDTihXEGiXvLCbsVj6+7QHs8IA+1+U5/EWoD0
         PMZq3TBa4TYRM5G1MZ+X8ynf6iRQoOgxGCkar8eG10NVxi50+/Jq4xtdVLYUOTaZurJN
         aNnYI+xuNwB/ZN97BI0nKCz8ZqjAWihC6rLOWWm/lfJlZMUHXMZPwZw0n503x8Ez2lq+
         trD4UV9oVlmutU8tsRJPzUWiyqnGHJaKomhk9mMp/DA5aAVSWYsNZ4OtQVrkEsfFSqLO
         Gyw7OJ42/IOrGGubfPlvvOphMrzgyLlDV05YRPs9TWyoOM9sACK/W2mK10fi+PWNOZvf
         s0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262978; x=1722867778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKAVwhluDEm83CnDhzk3R+pdR/lsoORRqAVOgXJ4jh4=;
        b=nr4KiT0dNhCa7eD4PXU57bzXBA+fT/m8aJKUg/820VZh8UOhTq7E4iEoiG95xWxkIT
         syTCE+pquDajAk6rajXg09BqoqBbidizk7k18WeTSfGPziSJVt6kSMRBdJF8R4cyHZeD
         eTmmuUyTKvXbxSR2PC+a+CuA19WILd2fTv3e8PNN3ICWuQ4d4ZyRgmV9CaKK3Fy6lFYi
         zKjhYhxh4lwycvj/Nvzba/C7PMu1rV8ri/2gJlQ9uC8I6yfjQgsPwRtWiqHri0Pu763s
         H+o2bxnG63OpbWTtNtl0Ht4jzJpMnuguJuqYgbeEaV2Mz/qEWckvdqGEAT2swBcAaaIJ
         ffEw==
X-Forwarded-Encrypted: i=1; AJvYcCUzyzapeP4laB6y1nFj96EWPO8Ri+710hfXAGVtiJrJEuU+yuxfpooMooUXRTxJWOVg136ykEuaiNhILNDz8t6tQazIKGzJVm2riPCy
X-Gm-Message-State: AOJu0YwGa1WsKraTo0Jjr0XWSNIPOHxJZgNAYgYVlZTwb1RkQNSG4+ey
	c+Yq3oS7nmYkx+zFnZ8RPsOcu6MLPbLvHVPj6PyunK+ruuOOSwH8p8zhoERw06y0qajnkEON5EZ
	0owyn8Pv3jg+6ug==
X-Google-Smtp-Source: AGHT+IES8X6bJl34RB7/iH9nf005G+uCe4wkhWz68+bWS+v9+Z5RHQiBNeaLAB9MUHbBbeqJZvyE/AaYzy1ExB0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:f92:b0:627:a961:caee with SMTP
 id 00721157ae682-67a09d60c54mr199477b3.4.1722262978117; Mon, 29 Jul 2024
 07:22:58 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:22:49 +0000
In-Reply-To: <20240729-shadow-call-stack-v4-0-2a664b082ea4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240729-shadow-call-stack-v4-0-2a664b082ea4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=lzT2BdaEVnJIsuBgTyZNaaAeirv9EKd/rwlbRbDIHew=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmp6W7eiaZvCQ+157eE1D82eHE/On4FxAJi9TFh
 2gSPdxHnaOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqeluwAKCRAEWL7uWMY5
 RvNGD/9piCtWh6KnJP50UfDUlhig5/folfeGSnk9rzankoYjvKtyl0HhguuVvUw4QT9UszFFu1Q
 2M2lyfik1kJ+DzHxopKFnQsIdYOezvQTD5qkAJ4irtNLyQifk5UNzE7kFmXIa7j5OxxzZ/bnoVN
 WtWowt9kC2yLhoQ2ngDP1Q0pqjSOe9yZq+JU00vftaYuLBmCktu2lK9gbe9Wzg0DqVEI3ckIVoP
 PTrY81o8h1U8Op9QkNBRlBmpYT7alkzPOuSu0f3LEeH/UdctAZTu2OsJ/rktV6GbPEEXioIwxS1
 SO+NpdC0UxWgnYRee7bl8fOJR638kikf7jt0xXuJljniqcc+EwnT+fJdXhmOMt0/Pw3NpeeL8I2
 5o8QUYqxmFP295BxKYXZ+5OzEBQn4DxQtS6uEqMvfHN17JvPfB5Dp2mQFrsQibZefgNRRuTZEqA
 qS6bJqymXak1+F8JDKe4oBB+FG2nddilV23LAuvfap3inFqv9TBgLrPOwVz8OFeYubTdY9blD/j
 o0yxn1DW04FUnofOMJU/q1ngTnU2f+YPbfJ5HwxOJJA++7qMe9pfvgk5hpQTSODwqxTu3u2PcDx
 JKHu+O1sMRW2Og5zjy83aRyemBkOdk0wnOpJyoejJNqSjY2bvEwnLBSbIycvdYtqpxRZ0xv0qXg 9QsENNi+fHInv8g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240729-shadow-call-stack-v4-1-2a664b082ea4@google.com>
Subject: [PATCH v4 1/2] rust: SHADOW_CALL_STACK is incompatible with Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mark Brown <broonie@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When using the shadow call stack sanitizer, all code must be compiled
with the -ffixed-x18 flag, but this flag is not currently being passed
to Rust. This results in crashes that are extremely difficult to debug.

To ensure that nobody else has to go through the same debugging session
that I had to, prevent configurations that enable both SHADOW_CALL_STACK
and RUST.

It is rather common for people to backport 724a75ac9542 ("arm64: rust:
Enable Rust support for AArch64"), so I recommend applying this fix all
the way back to 6.1.

Cc: <stable@vger.kernel.org> # 6.1 and later
Fixes: 724a75ac9542 ("arm64: rust: Enable Rust support for AArch64")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index b0238c4b6e79..914edf51b068 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1909,6 +1909,7 @@ config RUST
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
+	depends on !SHADOW_CALL_STACK
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	help
 	  Enables Rust support in the kernel.

-- 
2.46.0.rc1.232.g9752f9e123-goog


