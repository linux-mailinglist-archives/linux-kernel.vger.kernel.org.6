Return-Path: <linux-kernel+bounces-551535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F52A56DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D579C3B730D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27923E220;
	Fri,  7 Mar 2025 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmqZXY3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC921CC7B;
	Fri,  7 Mar 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365170; cv=none; b=Zol9zNNyuzLvbsW51PBy1NMne/3T83GLjf0MusiaqoMe4RBqZ/6v5sN+4wbIUGs0SjqoO1x/k4i97Cx73XsZfe/RafhBgEfg4UHSOf4VLAlpQHvyk/NBR10H+5cSc0ox8EQTqo4U+i61FO7Y4Vm1WhCmJ3bCspaNHUbGVwBXtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365170; c=relaxed/simple;
	bh=IYtqKF6RNYuUGwDssKjvbaMKZWh50JK81ILez6ZwBro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGV6CdBfYW7XToMk1plXembJZDMrpISdTQ55LiSP04a3jCHnPhGzfT+Hz+vbtt2hCVCROZFBbpbdnActzt6Lwzl6MG1Ao3E+faVoaJ8S51Tf5UWASOVvnuYfVfY2G54DoRz2EFqn/m1FK0EZV9/BrZ4riQHcBemNlPBcarErTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmqZXY3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87472C4CED1;
	Fri,  7 Mar 2025 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365170;
	bh=IYtqKF6RNYuUGwDssKjvbaMKZWh50JK81ILez6ZwBro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmqZXY3eAmBagMUhD/bF9pCoaMAre3597fTvRXSrgx4KDSzpE7OIrhKyPOsl9G1zE
	 mHIiqQa3IM0TYy7GRM4nhxbbpZEc+CuhqdCQpru3xe08YHQWWiYMMKRsD0YYO0szML
	 i8ho+W8Xm+/vmKubB9gMO7H3jKK+YCXJwnYSKeDSBMIJJ6gnHj+SeHS0Ia0I4u1Ny2
	 ONY5aGltXyKbwzcdExuTaaXPyVX5yDfQe1ncNqFXYUSQK15T/tGjgMsASAF2BEL2AH
	 tO9AbhOVMerxDn7HL3x7O1rzkoAcId7EgyftX2f8uMno4a25bkvjnwHaRE3tiAR4UF
	 JD7iZDmoKjlww==
Date: Fri, 7 Mar 2025 17:32:46 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>, 
	Simona Vetter <sima@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 01/33] rust: drm: Add a small handful of fourcc bindings
Message-ID: <20250307-hypersonic-beryl-buzzard-d06c5f@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mbognbzweqfbmz6c"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-2-lyude@redhat.com>


--mbognbzweqfbmz6c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v3 01/33] rust: drm: Add a small handful of fourcc bindings
MIME-Version: 1.0

Hi,

On Wed, Mar 05, 2025 at 05:59:17PM -0500, Lyude Paul wrote:
> This adds some very basic rust bindings for fourcc. We only have a single
> format code added for the moment, but this is enough to get a driver
> registered.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V3:
> * Drop FormatList and ModifierList
>   These aren't actually needed as pointed out by Louis Chauvet
> * Add a constant for FORMAT_MOD_INVALID
>   I realized that we actually need this because the format list isn't
>   terminated with a 0 like I thought, and we can't pick this up
>   automatically through bindgen
> * Split out the FormatInfo WIP
>   We'll want this someday, but not yet.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/drm/fourcc.rs | 21 +++++++++++++++++++++
>  rust/kernel/drm/mod.rs    |  1 +
>  2 files changed, 22 insertions(+)
>  create mode 100644 rust/kernel/drm/fourcc.rs
>=20
> diff --git a/rust/kernel/drm/fourcc.rs b/rust/kernel/drm/fourcc.rs
> new file mode 100644
> index 0000000000000..62203478b5955
> --- /dev/null
> +++ b/rust/kernel/drm/fourcc.rs
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! DRM fourcc bindings.
> +//!
> +//! C header: [`include/uapi/drm/drm_fourcc.h`](srctree/include/uapi/drm=
/drm_fourcc.h)
> +
> +/// Return a fourcc format code.
> +const fn fourcc_code(a: u8, b: u8, c: u8, d: u8) -> u32 {
> +    (a as u32) | (b as u32) << 8 | (c as u32) << 16 | (d as u32) << 24
> +}
> +
> +// TODO: We manually import this because we don't have a reasonable way =
of getting constants from
> +// function-like macros in bindgen yet.
> +#[allow(dead_code)]
> +pub(crate) const FORMAT_MOD_INVALID: u64 =3D 0xffffffffffffff;
> +
> +// TODO: We need to automate importing all of these. For the time being,=
 just add the single one
> +// that we need
> +
> +/// 32 bpp RGB
> +pub const XRGB888: u32 =3D fourcc_code(b'X', b'R', b'2', b'4');

It would be nice to keep the DRM prefix still. Fourccs aren't quite
standardized and the ones from v4l2 and DRM don't match for the same
formats.

The rest looks good to me

Maxime

--mbognbzweqfbmz6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8sfrgAKCRDj7w1vZxhR
xVjHAQD6iHjWhdGUo4ttrAjNAbZcn611frmBg/w0iAIZKE9PaQD/e87kUsZqmpF5
VaUSzEUHmsQFXkNdEd+Dl4HibbOOEQc=
=lIqa
-----END PGP SIGNATURE-----

--mbognbzweqfbmz6c--

