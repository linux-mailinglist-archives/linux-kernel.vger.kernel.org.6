Return-Path: <linux-kernel+bounces-562894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B979A63444
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5257818950BB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEA199921;
	Sun, 16 Mar 2025 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="v9QkjAhr"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CC198A36
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106048; cv=none; b=g0F2WGqejQKsg44kBcAgkWkb9K7yd7DxhUB61mstIj5GOz78vlPVZfJJTc74wGNn/3HUO3u61w7VHyA6vZvusVlDUwaTcCN86+xZ1n/MnGgivyY5Y37eQvuL9+BoRU1cHXuuTNYRaNApPidBJQKnKX8e4ZgvKKFW8mhcBadH+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106048; c=relaxed/simple;
	bh=DCCZ3zSHAje0FWAK8UKvdqHAHS2xwd6Ei/WwMlNchpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBUmoi/CAoOHD0p5lIh+F3hjkZYLbHTy3+QWEb7Q/G6vpMUuBKE5du91NAOvOs3kID5SE+GUvE+OjSGytNphj0jFT7+f7s5wRSPlvdfAgEl9x/iJiG8SQ3182z/MtjOPe+PkxAmsKC5egl9lSzxIEBwE2FGX0pa61TruyUkL9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=v9QkjAhr; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2890266276.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106046; x=1742710846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgXYCZoIbp3+FQSUFxgLFXAA6h9RyUssleXI5NM4+uk=;
        b=v9QkjAhrRPErcO5472Th54wIuu2Wru7bUTQJGZasm7OrPwRxpmuvOtJitzSxPMst7s
         EmNWry2wG+wJ0aVXIhZwWqYkCm6qrRpIUZ8vdYXMmQCYEUDEfz+GB0YVSW+gf0m3wzOI
         wwhoVDZROE7LgTJE4GsJsl2YZozKYKz0THCt5H2Rhnn9SPC9F1m9GGTEsBQe7ohVJtMf
         +M5BfbRf02rhE2kMNm/f27K3dVs+odRElOKXJv2/pjnHWLobExqFRAseltodeXTx0R8D
         q6XzaOO3Npk6S9ApCGQrOftSN1CoGLFNK2ybpCmrGCACvYK9Cy4KKW7UOEjD55d7qH7z
         p6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106046; x=1742710846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgXYCZoIbp3+FQSUFxgLFXAA6h9RyUssleXI5NM4+uk=;
        b=LRZLJCuQA0Nl9zA86vyPg+gElw/6c1rvxZP+0yjED/Tq/cXr6V6Y1ZAfHE9xoiJe2c
         xyvi2NygrL2hxrBNYR8x8gkdy4wkBXbKU33mwnXKpaIBTgTo8WILQBjqJ/bYHpBc7ssY
         Qlm2hW0WssnjhRp58XoK+kwybdwaA23XTExvQQaljlpzdbnmIqZtnH3u2ek5gdr5KMKI
         318ZR9PgLbx9El9lrBssvAWLZjgCkomLsbEV/Ay4m7XRjVDLCFFCq64yg0q32oPixIRn
         XkhRuUZ1dpi2o0DvbRFyIe0B6x5ynzcHOl3qCNZ0YEcdOe92Bqhe3y9NtAW0LShfM9mG
         5o8w==
X-Forwarded-Encrypted: i=1; AJvYcCU/aDaTswJvF5qHMPvedIjJ4ErGfkJtCYgmbNKYqqLA9yMdjchqB0e3J0tAQ1D00ZpPpRA2T2DwuHgcles=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYc1PufGOH5xUcrW/bjr9HM9SHYNKJtTQN/TVsrsnldx7EeTRr
	/W5/QlT1ywBCF/ka+pdqfbTJjT6NU1bPjRi3V2gpm6RV/4ArtgMaZy6ZqsoccqM=
X-Gm-Gg: ASbGncuszBz6Yx7zcSPRZoJ4kPUDlV7wXmZJlyCcjFZzDknE815atwoO0CDMEWnbkPg
	pEjfpzeabGl2HZAokYbjU4RAZVdOw52bjkyEwUS6JWmt9VuPBT54DvRHWF3fULOa3QSTfWRSI7c
	5YjkVoBPGWyKWT8bkOQMqYu0NIl/62B1snkBh2q08XOOWZNS0qCugnK4pyC9VuMg6B7m2uI3rcZ
	b8hPcOl1XT2eikU/9N+pLnt6G/zDbgMsW+CdiohhodBr7GBCazQEiWjTd6ifl8kvr0f/csItRIZ
	XM03cg+NHOLBlc9fcVTsgkxa1g+b1DVAy0Z8fSVIvZ73bKm6seHz3o5Y0iYOYGJvXtP9sCTRFBS
	7/E6O8OMBqXjdhL06T5kDXY5ovipfwI8DWn63x5/I
X-Google-Smtp-Source: AGHT+IEx3oMNZnBzMXazeUa5U7og3XXby62pIZ4BVRtR8qqnmhOeVv1VgBmfkomrXokKtJVLbNQXTg==
X-Received: by 2002:a05:6902:2788:b0:e63:c936:c07f with SMTP id 3f1490d57ef6-e63f870c83dmr9695475276.2.1742106046218;
        Sat, 15 Mar 2025 23:20:46 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:45 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/16] rust: net: phy: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:20 -0400
Message-ID: <20250316061429.817126-12-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..757db052cc09 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use core::marker::PhantomData;
 
 pub mod reg;
 
@@ -285,7 +285,7 @@ impl AsRef<kernel::device::Device> for Device {
     fn as_ref(&self) -> &kernel::device::Device {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
-        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+        unsafe { kernel::device::Device::as_ref(&raw mut (*phydev).mdio.dev) }
     }
 }
 
-- 
2.48.1


