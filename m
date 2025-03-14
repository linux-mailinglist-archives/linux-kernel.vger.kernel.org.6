Return-Path: <linux-kernel+bounces-561392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F06A610C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B803517C90D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC21FECA9;
	Fri, 14 Mar 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjU5puaK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878D1FE463;
	Fri, 14 Mar 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954970; cv=none; b=Zq1XvHW+G0uAAjGF7dSpjgnmn3lVo3MWTzbvssr8bCC1aJQUHcluwroegavVPI1fhvpYY18VnpKPwNBmrt7ACshnQ4uobzmnbUfRdm1vx+QnMQGXkh3o+ZNgWd8K3/9sW83T+ZqtfHITn4X5FJpgLFR505mkG4KnMjUR45HUbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954970; c=relaxed/simple;
	bh=Pqk5m5XBKy+Hv73Zwq676K5PF8xzsJSlwBNzMnQ1mH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1aJJ8mZVLBT/uCiMTVISJsIynJPSTepD3mCuMxZzIuWpGz/dDo7n741mefhVt/ll+aZv4qnVDk/pDWwjxKJXzVTAbjllMEgUFvdOW+FufDg44Ea7PvFR5R7ZGuoDu6iL23kLnRhFhT9EAktfliockClQzHfcpezT9P8jmOLp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjU5puaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F2BC4CEE3;
	Fri, 14 Mar 2025 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741954969;
	bh=Pqk5m5XBKy+Hv73Zwq676K5PF8xzsJSlwBNzMnQ1mH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjU5puaKlKKJ/MZgOSRLqg77Egu8d+WLA7e3LDZMhjbIKvcKMmI3AXhgU2yEyO0WP
	 ceC0dpjUIJlGB++DhasLmTjVoA86vrnLXhP30XoFCOPwxL/gVOunshzassGHonQJby
	 Gog574BOfFRlkUhTdMbQ9FcDN/NRltlKE2LuUk3Fan42OsYEOSaO9wisHPlXHWzyGi
	 ItC7St2ZLlUa2jScuARt76YVoKoumKSEHNb5nS5ciw1jOE6OAyDJluZYXPdis1jSVv
	 e2r+NdOkwn4dyrrwB/FgeVlB9jnYRxYKZmJYcGRko1RrmuJ3KbbI/OEiSoV9MePmCj
	 VGdMqRO2vwY2Q==
Date: Fri, 14 Mar 2025 13:22:47 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>, 
	Simona Vetter <sima@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 21/33] rust: drm/kms: Add DriverPlane::atomic_check()
Message-ID: <20250314-unselfish-manipulative-parrot-0f403f@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-22-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="grcwfw23rs235645"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-22-lyude@redhat.com>


--grcwfw23rs235645
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v3 21/33] rust: drm/kms: Add DriverPlane::atomic_check()
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:59:37PM -0500, Lyude Paul wrote:
> Optional trait method for implementing a plane's atomic_check().
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V3:
> * Document ManuallyDrop uses better
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/drm/kms/plane.rs | 53 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
> index b090aebc35649..f3adc30c17489 100644
> --- a/rust/kernel/drm/kms/plane.rs
> +++ b/rust/kernel/drm/kms/plane.rs
> @@ -11,7 +11,7 @@
>      alloc::KBox,
>      bindings,
>      drm::{device::Device, fourcc::*},
> -    error::{to_result, Error},
> +    error::{from_result, to_result, Error},
>      init::Zeroable,
>      prelude::*,
>      private::Sealed,
> @@ -20,7 +20,7 @@
>  use core::{
>      cell::Cell,
>      marker::*,
> -    mem,
> +    mem::{self, ManuallyDrop},
>      ops::*,
>      pin::Pin,
>      ptr::{addr_of_mut, null, null_mut, NonNull},
> @@ -69,7 +69,11 @@ pub trait DriverPlane: Send + Sync + Sized {
>              cleanup_fb: None,
>              begin_fb_access: None,
>              end_fb_access: None,
> -            atomic_check: None,
> +            atomic_check: if Self::HAS_ATOMIC_CHECK {
> +                Some(atomic_check_callback::<Self>)
> +            } else {
> +                None
> +            },
>              atomic_update: if Self::HAS_ATOMIC_UPDATE {
>                  Some(atomic_update_callback::<Self>)
>              } else {
> @@ -117,6 +121,21 @@ fn atomic_update(
>      ) {
>          build_error::build_error("This should not be reachable")
>      }
> +
> +    /// The optional [`drm_plane_helper_funcs.atomic_check`] hook for th=
is plane.
> +    ///
> +    /// Drivers may use this to customize the atomic check phase of thei=
r [`Plane`] objects. The
> +    /// result of this function determines whether the atomic check pass=
ed or failed.
> +    ///
> +    /// [`drm_plane_helper_funcs.atomic_check`]: srctree/include/drm/drm=
_modeset_helper_vtables.h
> +    fn atomic_check(
> +        _plane: &Plane<Self>,
> +        _new_state: PlaneStateMutator<'_, PlaneState<Self::State>>,
> +        _old_state: &PlaneState<Self::State>,
> +        _state: &AtomicStateComposer<Self::Driver>,
> +    ) -> Result {
> +        build_error::build_error("This should not be reachable")
> +    }

I think it was the other way around for CRTCs between old_state and
new_state? I still believe we should get rid of both, but we need to be
consistent at least :)

Maxime

--grcwfw23rs235645
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QflgAKCRAnX84Zoj2+
dlmgAYCv/IqQx/4fwu6/QLutidlJcS4QIP6PwcZ7YhfyMMrxDOEfwYtyOmGtQU/r
nevoE08BgOsHvColnXcbK/ipTKsd+otfQ0Ej4/mpQsBfTBAz2LutE2JA9TTebLzd
uh7Y52/t0Q==
=kqb1
-----END PGP SIGNATURE-----

--grcwfw23rs235645--

