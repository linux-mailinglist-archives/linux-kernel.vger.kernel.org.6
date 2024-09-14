Return-Path: <linux-kernel+bounces-329561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5029792EA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F109B1F21DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCE1D12FE;
	Sat, 14 Sep 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="k20dK9Ve"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEF1758B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337816; cv=none; b=tWop79Y6d5hh7aCEH7a+ZLJ4/7IyidbiZOq+XgerpAmAbrRRXsp61Zw4h+YCEpVYUBJfALUptExMcmf0CaV2aBH8GWwfJZx3NK3bzUxrNZwpUM1zos6zSMLQvSSC7+m57RoLSoWrjhbK6TPM/H5/f76T+KerzVxBuzMBp1AJuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337816; c=relaxed/simple;
	bh=BgsGnxvet2+gN6DH8JKOPSGzcf2huUfEnnNLFrzpFbE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY8nJ2CA1iJe7ZEkKiLd8aQo8JGQRAYlPJh5Qp1PWf9+dzSdC1+aajKBs/J6/0dR+yLdCoNFIEupOY391RKFpyukMALjU1tYGUtx3YMcfBMYbtTvolNQEGRplvs9hcnOg1EWCE/0Fz0N+A/N6Kufw6ZoVy0IGkGxT1j8HZbWBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=k20dK9Ve; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726337806; x=1726597006;
	bh=4Z/zNpRWUAHAN0n9gNoJ1GGQwLlmBKdUuu429m0YRdM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k20dK9VeRxgukkX07CH2RdQ04pvptvHv1nz0ACtgxWWd+ZqiwkK1CFfWZEIT2yeXo
	 FPGVLuIK0ignBnoUQLsMdPTq4J+/Yb9NSpKY2re/WaOGg8S2Cte+sKTrz59kkzhCHt
	 GvO+oPdM5zDN4romvolq/ixMg8H6+S8YNXTHJ+P6AmRSoHlQa6FQ1ibY8hy7AxzBGC
	 Kk6OdnU2O35417mOBHlfMA9K3OL5E21t4zrNfxlbaOYWa/fDGsg/CfycBVDCvsI1KI
	 H9xp1OTKss8VMKHeL45uP5P1UIP2fnqpoeoN9DDOUW2FGn3jV+fkOmA7JAep4TfgtA
	 rJ5wm/vvv5K+Q==
Date: Sat, 14 Sep 2024 18:16:41 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Patrick Miller <paddymills@proton.me>
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v4 1/2] docs: rust: make section names plural
Message-ID: <20240914181618.837227-1-paddymills@proton.me>
In-Reply-To: <20240912195629.227696-1-paddymills@proton.me>
References: <20240912195629.227696-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 10d2905e834928946bee038f6ffd11edc47085ef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------23753c95b9ccd3160450a4cbf1a53e3e4e2c25d6673940a59af2c788844b671c"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------23753c95b9ccd3160450a4cbf1a53e3e4e2c25d6673940a59af2c788844b671c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Patrick Miller <paddymills@proton.me>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v4 1/2] docs: rust: make section names plural
Date: Sat, 14 Sep 2024 14:16:16 -0400
Message-ID: <20240914181618.837227-1-paddymills@proton.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912195629.227696-1-paddymills@proton.me>
References: 
MIME-Version: 1.0

Fixes existing rust documentation section headers to be use plural names.

Signed-off-by: Patrick Miller <paddymills@proton.me>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110

---
 rust/kernel/init.rs     | 2 +-
 rust/kernel/list/arc.rs | 2 +-
 rust/kernel/sync/arc.rs | 2 +-
 rust/macros/lib.rs      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a17ac8762d8f..98889ddf9828 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -746,7 +746,7 @@ macro_rules! try_init {
 /// Asserts that a field on a struct using `#[pin_data]` is marked with `#[pin]` ie. that it is
 /// structurally pinned.
 ///
-/// # Example
+/// # Examples
 ///
 /// This will succeed:
 /// ```
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index d801b9dc6291..611ce07cd290 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ 
-464,7 +464,7 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
 
 /// A utility for tracking whether a [`ListArc`] exists using an atomic.
 ///
-/// # Invariant
+/// # Invariants
 ///
 /// If the boolean is `false`, then there is no [`ListArc`] for this value.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3021f30fd822..3d3c100b0c0d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -436,7 +436,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// There are no mutable references to the underlying [`Arc`], and it remains valid for the
 /// lifetime of the [`ArcBorrow`] instance.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```
 /// use kernel::sync::{Arc, ArcBorrow};
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index a626b1145e5c..3879e1162866 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -307,7 +307,7 @@ pub fn pinned_drop(args: TokenStream, 
input: TokenStream) -> TokenStream {
 /// literals (lifetimes and documentation strings are not supported). There is a difference in
 /// supported modifiers as well.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```ignore
 /// use kernel::macro::paste;
-- 
2.46.0


--------23753c95b9ccd3160450a4cbf1a53e3e4e2c25d6673940a59af2c788844b671c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmbl0wgJEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAACdeAP9dcoOzo89NLPj9ZfXq20zFXBWK/OgsVHfel3FBqNMNHQD6Ap8n
yIuOt0cFJo6TNYFbidlDfoytD8/QdH+X2jIeGQk=
=qSkH
-----END PGP SIGNATURE-----


--------23753c95b9ccd3160450a4cbf1a53e3e4e2c25d6673940a59af2c788844b671c--


