Return-Path: <linux-kernel+bounces-428747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A69E12D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B12826CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C80115AAC1;
	Tue,  3 Dec 2024 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iecH5QRe"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A26FC3;
	Tue,  3 Dec 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203160; cv=none; b=guZOutZkRao1oddLgqmE31+JzhVLZX+2UDUfwivv6qP7Z7zXGa0cKrKzElNMpuUVF7RK5DQrerP4EDzc/L+g18PE+rMk0IF4Luuj4p8x0ZzayYbniTWM+PpXhpD3+NSfwLwbah7F09Zptx5mRPpKISDVX3eMhrSwxM9J0+aRqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203160; c=relaxed/simple;
	bh=DhhPSHB9fE89Kk23/L85z71d0bKmztN78SWqE3eklfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwZ0RkebmIMnwup/0X4nKvCsv3hAIyO1oE/aNI5c4cA3XdgUBPOpDRANRL/vJk2/AKvssWrNCP9BMf/mGOx0OzkBpBRzum+SPqOOeaPWroacXf45gfgUmNM89wAMLSkzlJm4zNAeeOoxTHp6EORsHq/N5PvEofkMnKcKLyEY6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iecH5QRe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7256a7a3d98so2099539b3a.3;
        Mon, 02 Dec 2024 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733203158; x=1733807958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDQRt9CHdpZ9I0oXQCgclITdxLKu1aJE48MT6i5aHRw=;
        b=iecH5QRerI+0aUsCLxlkNcjq9M3uo1YuVaSq6wOcLUOMZsbbDz+2t/kNTgCI/V/4Ex
         mdLcqpozlkLqiwSK3p+o9rVARpp45IsYGIsqwX9WvR2qhRMv/uBRT0nRuFrC6knVC/Ux
         g6+jEBQYcfuqGTNf1fNJEKNMYa4b2hnLHNG2uFAL4NRroJyEfZ7gyQ7eTFIVMuSIlDHn
         PPp+9lfBYIb/8plCN2zrr3l+07mOW5ClH/nfiNW3oNjPGy2r7cA5rYOGPkWMx5/vaLi0
         TSoXpH+LNLJ4tcve/hHGIpCuuLREIVN+T6MunWhl7CiUnQSLWv+gugCHaW/jYjz+/JWg
         6wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733203158; x=1733807958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDQRt9CHdpZ9I0oXQCgclITdxLKu1aJE48MT6i5aHRw=;
        b=HL/UaD8vyTvQcetHC6epTvJdPkGGBPZhpPJyPxaydjsBHai6s7UCX1veP7GEbavQ7a
         N81XDVgKGvw+h8JJSFgt443fQR7uwvdX7hvoiB7LGNlRrSva+Uaf2WxcIcAY9UfxRdHg
         0BmrHJfFS4wk6lhxTlrdC/rMt9H1M9+KcWbm+pfRWY5HV5TPwmiu5nsKpQPOqaEv8u8x
         Br2m1uEfJy/5lr05sM4zCqTg1ATINV5yvi0I8zogLkyprCQv4JEIQK2McrRWrDOO5K/h
         F4p/vzBSrqDeZwPiWD4+c2rqt3b3cR/pC4eZwj1W5ZErvD3HeUdm32uBD9I/LcZ8TYiX
         E2eA==
X-Forwarded-Encrypted: i=1; AJvYcCUZPDnQ7Zk0Gjnh3IWEqnC14Oo9OdBYVND+2X9kdtBh23g9Ae6D+ehx+qKy/RB9BRHMrQgSAka5Ib7WWfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jYjRwuvoWK2rMXhAR4kvmTedMfFmY5TGewvSROSrlWjBoG4H
	hHP1KnT+AH5F4nDf/TLBh2aA7TBmgq9L/BeWmx1l/CBUftWi+8bj
X-Gm-Gg: ASbGncuUU7qBxTVfdZA8QXfYDwBeWeEtu/v2SdWxTs2WJoQJE4eq/XVsOKtKYy+2wHh
	QLoW4+uuxzs7S6TRp1rWRY6fVIkWhgz1ufh+JERiEl2PreAFcc56kGmHe86/n5A16HZlIqUxkU1
	DMBjF6qPDcan66WaZood+1DbWMObDn4N8AEU4AY3WXee16Yvi/ZwsUtLvTiK7yxDECTt+m/qRtm
	CJT7MvomF1zXGW2A9gmrnPpzbJSe9liPq2p+aPWMt1gIsZp2/wN8UK/lekI
X-Google-Smtp-Source: AGHT+IF8MseDyGUJEDK31r2/QuX21EyDXOW33DCLUI8ET2/oml+vRvK6/33zDgJBj2BP1YSGsCe1+A==
X-Received: by 2002:a05:6a21:99a7:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e1653b7b73mr1932049637.16.1733203158513;
        Mon, 02 Dec 2024 21:19:18 -0800 (PST)
Received: from lordgoatius.hsd1.or.comcast.net ([2601:1c1:8502:a6c0::ed0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c5533sm85926545ad.256.2024.12.02.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:19:18 -0800 (PST)
From: jtostler1@gmail.com
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jimmy Ostler <jtostler1@gmail.com>
Subject: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
Date: Mon,  2 Dec 2024 21:18:43 -0800
Message-ID: <20241203051843.291729-1-jtostler1@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jimmy Ostler <jtostler1@gmail.com>

Added a rustdoc example and Kunit test to the `ArrayLayout` struct's
`ArrayLayout::new()` function.

Kunit tests ran using `./tools/testing/kunit/kunit.py run \
--make_options LLVM=1 \
--kconfig_add CONFIG_RUST=y` passed.

Generated documentation looked as expected.

Signed-off-by: Jimmy Ostler <jtostler1@gmail.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1131
---
 rust/kernel/alloc/layout.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
index 4b3cd7fdc816..4265f92f8af0 100644
--- a/rust/kernel/alloc/layout.rs
+++ b/rust/kernel/alloc/layout.rs
@@ -7,6 +7,7 @@
 use core::{alloc::Layout, marker::PhantomData};
 
 /// Error when constructing an [`ArrayLayout`].
+#[derive(Debug)]
 pub struct LayoutError;
 
 /// A layout for an array `[T; n]`.
@@ -43,6 +44,19 @@ pub const fn empty() -> Self {
     /// # Errors
     ///
     /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
+    ///
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use kernel::alloc::layout::ArrayLayout;
+    ///
+    /// let layout = ArrayLayout::<i32>::new(15);
+    /// assert_eq!(layout.expect("len * size_of::<i32>() does not overflow").len(), 15);
+    ///
+    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize);
+    /// assert!(layout.is_err());
+    /// ```
     pub const fn new(len: usize) -> Result<Self, LayoutError> {
         match len.checked_mul(core::mem::size_of::<T>()) {
             Some(size) if size <= ISIZE_MAX => {

base-commit: 1dc707e647bc919834eff9636c8d00b78c782545
-- 
2.47.1


