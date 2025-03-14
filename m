Return-Path: <linux-kernel+bounces-561331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29882A6102A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3201A189B412
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121B1FF7B4;
	Fri, 14 Mar 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdrlzM/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A351F4275;
	Fri, 14 Mar 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952262; cv=none; b=LJFLDNxPl4TfWrNFAxyrOErJ6L14NT0noOOCF/aJ7QBuE3U6PwLRAdKF+/FkKYgLdwdB+keIjoOPxH1+ZEDeLiakY4NR3Ye3SovHa8T2gN4DtC1v/8qdlg6dd7zATLZ0b5m07GuNgpv0LZRKyRF5kdb9L+RbWKcJ9YvB+rBYmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952262; c=relaxed/simple;
	bh=/ducklgq3qbSOMbklVlJ6IhWYbVozO9MW5vXqgwzMz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brlUdpqvpvAnBlJ3IDVlSmggrrthlZMujP2EdNbI0X1cV6iWX5fpGU02RxE/WxWKqCFTBLymvwNM6P//+OuDAI6ktwM5Vo7cpOOeSWKm84d0IHiuRXgG99o4etIIfPTxi0mfvPJiCCQl4iajUbXjUnQo+yX/n8Yk6rMtNQV6oVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdrlzM/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D1AC4CEEB;
	Fri, 14 Mar 2025 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952261;
	bh=/ducklgq3qbSOMbklVlJ6IhWYbVozO9MW5vXqgwzMz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdrlzM/KyasdCQ1zX4PQ2FgwFqa/9SAz4YDqQ4dQe6ZAPufzBE7OwknbsqhB62YUs
	 J5myiyorEy8FraM1qP86aosDXhhH2crWP+DDN21vvXBkuwARlw8+u42FB/AnyiyA7f
	 NjIYnjuGkrkGF/a99wrZjCrdFMaWcFUGWw7KYDjv14kQa4HNBv0kfk9/K2mL5sOyJg
	 EF27jhioS2M+d8lfruZlytqR1RgppsVi13MgQfhxAFV5lNbEr8RBLaDyiVyqAkXZFg
	 Kjmmb62JmiqxOsjxz6Skq0y9c+hwcLkKTkgVOZapogydbuvYCAURiRP/3XGPUpxoL7
	 xcIVkJrFfNjjg==
Date: Fri, 14 Mar 2025 12:37:38 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, mcanal@igalia.com, Alice Ryhl <aliceryhl@google.com>, 
	Simona Vetter <sima@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Asahi Lina <lina@asahilina.net>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 05/33] rust: drm/kms: Add drm_plane bindings
Message-ID: <20250314-tunneling-brown-hornet-a6c584@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-6-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="duvbmloyjxh2mbgy"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-6-lyude@redhat.com>


--duvbmloyjxh2mbgy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v3 05/33] rust: drm/kms: Add drm_plane bindings
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:59:21PM -0500, Lyude Paul wrote:
> The next step is adding a set of basic bindings to create a plane, which
> has to happen before we can create a CRTC (since we need to be able to at
> least specify a primary plane for a CRTC upon creation). This mostly
> follows the same general pattern as connectors (AsRawPlane,
> AsRawPlaneState, etc.).
>=20
> There is one major difference with planes vs. other types of atomic mode
> objects: drm_plane_state isn't the only base plane struct used in DRM
> drivers, as some drivers will use helpers like drm_shadow_plane_state whi=
ch
> have a drm_plane_state embedded within them.

It's one of the things where I also think you could have broken down the
patch some more. drm_shadow_plane_state, while useful, is not central
and could be handled later on. Both would ease the review, and we could
merge the "central" plane support without it if we disagree only on that
part for example.


> Since we'll eventually be adding bindings for shadow planes, we introduce=
 a
> PlaneStateHelper trait - which represents any data type which can be used
> as the main wrapping structure around a drm_plane_state - and we implement
> this trait for PlaneState<T>. This trait can be used in our C callbacks to
> allow for drivers to use different wrapping structures without needing to
> implement a separate set of FFI callbacks for each type. Currently planes
> are the only type I'm aware of which do this.

And I don't think it's any different to any other driver structure. It
looks like most of the users except two don't have any additional data
so can't we do something like

struct ShadowPlaneState<T: Default> {
	...,

	data: T,
}

And just put that into PlaneState just like any other driver?

Maxime

--duvbmloyjxh2mbgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QU/QAKCRAnX84Zoj2+
dpDKAX49Gw6qHl6j7xEXXRSEwjih+jxSiFoh9OJ48hfFg08oCXGyiMh3sDuHbUPp
Q4QU9lYBgKIW9H+1CKLusAv0dhXRvGYLWEYZnQYF7y9MXRSvwLSONAJsWF2efxZB
uGElPX8uFw==
=o7sn
-----END PGP SIGNATURE-----

--duvbmloyjxh2mbgy--

