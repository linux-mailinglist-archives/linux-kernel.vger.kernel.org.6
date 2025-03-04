Return-Path: <linux-kernel+bounces-545753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B4A4F108
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B63B0678
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DC280A26;
	Tue,  4 Mar 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="S+swz2W2"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7927814D;
	Tue,  4 Mar 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129055; cv=none; b=Aw6FLw9NkyJ8RPkcGke1jI8xjJdxjvFJL+Twpt2yzp+CBiQx7f4YuSJBQ30DKaHcARtvxl9cIXjLgMSZRbC52YCc19+3E1cOdvkcnI2pD4UTAPi+iyddbixg876gJDUij6QgueljrnAGBTa0BMuB4NJ53oXeRhwrW6PIDa8nMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129055; c=relaxed/simple;
	bh=ur4bm/o7t4I5Vmru/60aH0m5azy3/QGR0m985nMHRT4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GO6GbOtvTjEUyTbtD15cxC5Ljvk3c3hREzRN/y2gOXvUrvbWobq7E/xhbZzL2C6dAiv5YF4BRaNEOgPUt1qWXiDoWop9evW/WQyFFw6ugMuvKjU+C+oEl8t0Wh/M7ZcaL+jgNd2Izs0YWnWQ3s/d2G/hG9yIyptHS3/ZSqg2/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=S+swz2W2; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741129052; x=1741388252;
	bh=ur4bm/o7t4I5Vmru/60aH0m5azy3/QGR0m985nMHRT4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=S+swz2W2cFy1z++sC2pB8avOEXf1SdCvDJwVP+pP5lfLJkF1KoRHy75qWoUSrAxns
	 wq40gp3igzoA+e+lxhP/PIDMVaEZ9Zr/C+cSFIwUMlZsjEnvaSLqlR8lFSt/nQ3UBZ
	 tT2Bd+GK/6Vo24NtyS2fC/lGNC+QDY7BQ3CasF1hsV3qsmN29z4Q3XKc7jLdd3SfYE
	 uwFpThOXEvu8uqzuYvuoVrZ5UcIXQEgR8+VRKmJc6Yvvn1sWChM90F6tTD9SegG8Fx
	 bYY3K6UV3Df/avqCMwqL06Cr8Zqa4Bw2O3ZrvRtq2GkIWbb1glIYL81oE6j3+9io6U
	 8+67yIBXOmV6g==
Date: Tue, 04 Mar 2025 22:57:25 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] rust: pin-init: allow doctests to refer to the pin-init crate
Message-ID: <20250304225536.2033853-6-benno.lossin@proton.me>
In-Reply-To: <20250304225536.2033853-1-benno.lossin@proton.me>
References: <20250304225536.2033853-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6b06502375095d79f7aafa8454d77ded4b501024
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The next commit will name the pin-init crate from proc macros via
`::pin_init`. For this to work within tests of the pin-init crate
itself, it needs to be able to refer to itself via that name. Thus add
the required code for the name to be available.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/src/lib.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index cb015b118283..356fc959bcb9 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -282,6 +282,9 @@
 #[cfg(any(feature =3D "std", feature =3D "alloc"))]
 pub use alloc::InPlaceInit;
=20
+#[allow(unused_extern_crates)]
+extern crate self as pin_init;
+
 /// Used to specify the pinning information of the fields of a struct.
 ///
 /// This is somewhat similar in purpose as
--=20
2.48.1



