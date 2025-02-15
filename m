Return-Path: <linux-kernel+bounces-516415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6AA37104
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776597A4192
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C11FC7F6;
	Sat, 15 Feb 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EstX1456"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB01199B9;
	Sat, 15 Feb 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739658693; cv=none; b=eOxxNBU53Rh9j5OtB8e5LqJBiBaQzaop5TgJnmdtZlrPeqXMlm7NhoC9w9J+RALvYu22ABwynBREUnpPM9YHE+VdF7DKMyDh0VDVkNjB3m5ebbDKcyesCAldB/HW0ikKN/Su5cdtlYrVqtRa5UzfF/So+W9+21+NhmRVqAucDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739658693; c=relaxed/simple;
	bh=zbhIo0xDzOZCTqwo4a9BF95ysjJWi4vttC5VSmsk5TM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HxTc6RiwpWFfKF2ryxV3AS66rgN8cpAPc0JTVfvF0JqiOVm8i33Ny/LcvdAIzbmYtqoT1KHBeYk0JisaggP7pMnNrHfOvaSFnHpCWcK48hxXZH7ZvDQTgKDA2CQBRBmc6SG8b3HXWVB6WEMKPtrK+7wm3eUbdAEowPdwvg9QLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EstX1456; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gx6ah36rjngmvit33r3cdufykm.protonmail; t=1739658688; x=1739917888;
	bh=ZQRmFVQtyeskggtP6Qj6Zx0oQ2+VkautJ0NT3svSj+w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=EstX1456v6ehayDBu5AiNB8e4s3g9JpDn0+HTTWoi/sNE+k4W6NYnSrqAIEIbQUj+
	 TAhFfsf7UWy9bwrLVIrpa1s8+zndxWmymCrjoTSpxZj7jm0jiS2DeVsXnKiSBl2fda
	 ID/aZhXWrRBfVwoct3APjYo3JllV/41GjAhS+5UZwmD/awLZ0x9cTndT6zhFAjBV8k
	 Lzanjj3ELN9tza3l6s0ICz1GKArnDwhGhXDuZ97oSxaGF+Duo1pr54muA2gsNvhCcB
	 EtX8aczLjMQqArNAryD+UYW8+W4DdM92MdMPTqc3Eahkh97NKQYxSJWk1t8tO3vuft
	 RXjLF8/wx40dg==
Date: Sat, 15 Feb 2025 22:31:20 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] rust: fix clippy::too-long-first-doc-paragraph
Message-ID: <20250215223106.2346285-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a3ae3af5ebe8b7d59018f5f505a45767c59e37ab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When running `make LLVM=3D1 CLIPPY=3D1` on my machine, I get this error:

    error: first doc comment paragraph is too long
      --> rust/kernel/driver.rs:13:1
       |
    13 | / /// The [`RegistrationOps`] trait serves as generic interface fo=
r subsystems (e.g., PCI, Platform,
    14 | | /// Amba, etc.) to provide the corresponding subsystem specific =
implementation to register /
    15 | | /// unregister a driver of the particular type (`RegType`).
    16 | | ///
    17 | | /// For instance, the PCI subsystem would set `RegType` to `bind=
ings::pci_driver` and call
       | |_
       |
       =3D help: for further information visit https://rust-lang.github.io/=
rust-clippy/master/index.html#too_long_first_doc_paragraph
       =3D note: `-D clippy::too-long-first-doc-paragraph` implied by `-D w=
arnings`
       =3D help: to override `-D warnings` add `#[allow(clippy::too_long_fi=
rst_doc_paragraph)]`

Thus add a short one-line description.

Fixes: ea7e18289f44 ("rust: implement generic driver registration")
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
The error also occurs in v6.14-rc1, so it must have slipped through our
testing, which I find a bit strange. Also nobody reported it for rc1, so
maybe this is only something that I encountered?
---
 rust/kernel/driver.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 2a16d5e64e6c..65c9c1776556 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -10,6 +10,8 @@
 use core::pin::Pin;
 use macros::{pin_data, pinned_drop};
=20
+/// Generic interface for subsystem driver registrations.
+///
 /// The [`RegistrationOps`] trait serves as generic interface for subsyste=
ms (e.g., PCI, Platform,
 /// Amba, etc.) to provide the corresponding subsystem specific implementa=
tion to register /
 /// unregister a driver of the particular type (`RegType`).

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
--=20
2.46.0



