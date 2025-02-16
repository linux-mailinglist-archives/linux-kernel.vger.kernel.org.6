Return-Path: <linux-kernel+bounces-516821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA040A377D9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EF7188E5AB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C151A5BA0;
	Sun, 16 Feb 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Z2Z3AP3K"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D19C543
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739741931; cv=none; b=gwi7nfe+8qcUuLC48cW8E6FE0suVr5Pwnxg1aQJYZKAMdlht3Fst9HRXwB2LIhDAJC8+9LghBJaXDvLt/UhSbTpKrSXxoaFd6w4oNGMZEn2/ANwv71k7L0E8e5Zz9MYc2w9aRRDgwdg/9tUC/enyJu+wN0FbPTrfxQhJlGJSLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739741931; c=relaxed/simple;
	bh=+Ni/cbdvLNsXLYycv03iKBsNIIXYUQIw2xgCwJLFXvs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkzoR8U0F4dNcOgPhZSyOAeZBlapcI79KeyCshwgbQayKKmHcUKFlje0aAkdUA717a1cXdgA3Z5dnfTJLX0cxGplOTE81hsaU+9coMWg+WQ02jxxvQDVxgsSM+wipNI3mGo0gCWWr6Z1E7gwygX+cF5Pjs+cZDVSfeeHLHABirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Z2Z3AP3K; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739741927; x=1740001127;
	bh=5ELk2lVUz97BFlrB3c4vK8tkED+9lY8y4Q7J+oz0fRk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Z2Z3AP3KreEJdtEyUfBoKF84iD/nZMYNbahQozlBurZBVnUga2ZU5Zq4Q6wSHEPQ9
	 qhEMOKuh9Lld5m+k14mG/ZPJD6odovQmpy2IROcOEfaAch1F/Sh04quj9UH7BzMKIR
	 toRsp8HwCtSL8nochi/H0E7L+ODr36beHoLYvnciP57qSX8p6+q43Faqfm4pHNLlrb
	 m5MZBNNIC3O9Lbyma1KjIw8lcCG1T381ynFrQ7eDbKMB295VEngxFVCtVtOU77jkOo
	 alHYEJO+p3Z4vdrUlfRCpPqQ0dboFfkpK4NmSmdhqz8zWW2HmCitRiIK8YotUIIKvu
	 eIJ7x5wG3jt+Q==
Date: Sun, 16 Feb 2025 21:38:42 +0000
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 2/2] rust: enable `too-long-first-doc-paragraph` clippy lint
Message-ID: <20250216213827.3752586-2-benno.lossin@proton.me>
In-Reply-To: <20250216213827.3752586-1-benno.lossin@proton.me>
References: <20250216213827.3752586-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 761a114e7622dc67df67fca1e4562a4aee9940b6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Introduced in Rust 1.82.0 [1], this lint ensures that the first line of
documentation is short. That is because those lines get rendered in the
html version of the docs directly next to the items and should therefore
be short.
Additionally, a short first sentence might help developers remember the
rest of the documentation if they have read it already before.

Reviewers have pointed this out manually on several occasions, thus
enable the lint.

Here is an example error fixed in the previous commit:

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
       | |_^
       |
       =3D help: for further information visit https://rust-lang.github.io/=
rust-clippy/master/index.html#too_long_first_doc_paragraph
       =3D note: `-D clippy::too-long-first-doc-paragraph` implied by `-D w=
arnings`
       =3D help: to override `-D warnings` add `#[allow(clippy::too_long_fi=
rst_doc_paragraph)]`

    error: aborting due to 1 previous error

The exact length can be configured in the .clippy.toml if we need to do
so.

Link: https://github.com/rust-lang/rust-clippy/issues/12989 [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9e0d63d9d94b..d00cbeb63714 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags :=3D --edition=3D2021 \
 =09=09=09    -Wclippy::undocumented_unsafe_blocks \
 =09=09=09    -Wclippy::unnecessary_safety_comment \
 =09=09=09    -Wclippy::unnecessary_safety_doc \
+=09=09=09    -Wclippy::too-long-first-doc-paragraph \
 =09=09=09    -Wrustdoc::missing_crate_level_docs \
 =09=09=09    -Wrustdoc::unescaped_backticks
=20
--=20
2.47.2



