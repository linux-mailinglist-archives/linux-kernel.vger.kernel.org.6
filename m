Return-Path: <linux-kernel+bounces-346943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5298CB44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07064285F14
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6872B6FB0;
	Wed,  2 Oct 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VnR6s7iz"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9146BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836135; cv=none; b=Iib8m6cZ497IGpVb0eXCd+4+vXjqvGoQdhd1KX1WKVeqNV0N91I/sUuEbtCI/98OwAJv9OWTrnlgrU2zxlVMb4o430/SbzGpOgZ4EonHtyVxhj6ZwH4QKfu9MsMpfTNqQxcCPNEm8gOduCYcO2+rAP3I3IXDnXY32p0Sjre3x/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836135; c=relaxed/simple;
	bh=WZf5sN/WQKskdtb8AJdISQGWX3yMwPGgium2PUAU77g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cz9V1FIg+UaZ2ITZ8aT+SYuDta/k8vyaqHykQa3BU71goxHI/m8crC7pnSx+P/qG6k0z5Z18jPBLfBfPC8+hoo0B3VlHDv6msOlQ9SvoKaLEJFFGW3HQABIE+HS0P8fF/sbvQKPrGOlDlwjTQwpxosxFJHqCwwQTLqBuca9oiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VnR6s7iz; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727836132; x=1728095332;
	bh=KBGWDqFgO70YMuq2MQkivUcqJyC4Hn0Tv20HjEnAjHU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VnR6s7izLNZOMJh8LzBtNPNMJu+0WvAqrDbYYfNACbCK/FyojvaMBvt90JRGjmUTF
	 tI7H40fJeXxDKvJcUdMWF6R8iyI3ZA++DzwfKiX3M0b4KvrqGjGJtz589wlO4nXl8W
	 p3QxUmm7crg+6CN+1TBqSweoSXnZAJkX8n9iRlJK7vGX9UsS9EOlae3gfrIb3sgqsE
	 2Jb+6AxRjQlWLb+dNti73VrpKfI8z35jEvN+Fsd2lzFDnL3vgmRgtb6M5j3lkFGrvk
	 O4+u5SGXJ7gPjireX5szcV7gH/ZXMDGyGChSFncNRJ4/ZPx5/epatYyC6BaA2KIOAI
	 6b8lQt0LuISdQ==
Date: Wed, 02 Oct 2024 02:28:48 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Patrick Miller <paddymills@proton.me>
Cc: Patrick Miller <paddymills@proton.me>
Subject: [PATCH v5 1/2] docs: rust: make section names plural
Message-ID: <20241002022749.390836-1-paddymills@proton.me>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: cc372f466e477aedaa985a1766d1317f7afc919e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------48448c36b2b2cb915c726d5e1c290852645cd300b290d3fdf1c45c0165a1ba7d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------48448c36b2b2cb915c726d5e1c290852645cd300b290d3fdf1c45c0165a1ba7d
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
Subject: [PATCH v5 1/2] docs: rust: make section names plural
Date: Tue,  1 Oct 2024 22:27:47 -0400
Message-ID: <20241002022749.390836-1-paddymills@proton.me>
X-Mailer: git-send-email 2.46.2
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
@@ -4
64,7 +464,7 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc
 
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
@@ -307,7 +307,7 @@ pub fn pinned_drop(args: TokenStream, in
put: TokenStream) -> TokenStream {
 /// literals (lifetimes and documentation strings are not supported). There is a difference in
 /// supported modifiers as well.
 ///
-/// # Example
+/// # Examples
 ///
 /// ```ignore
 /// use kernel::macro::paste;
-- 
2.46.2


--------48448c36b2b2cb915c726d5e1c290852645cd300b290d3fdf1c45c0165a1ba7d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmb8r+AJEJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAA1HAQDi+7Cl9x54SDjA1dSCZ5/DMS3Rtu9UDXI7J0Mjhu0HeAD/d42T
4/k/+HWQav5UaHndaWS9pJm5sY4IV1IQcPvIXwU=
=fc/g
-----END PGP SIGNATURE-----


--------48448c36b2b2cb915c726d5e1c290852645cd300b290d3fdf1c45c0165a1ba7d--


