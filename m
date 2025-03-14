Return-Path: <linux-kernel+bounces-561373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CAA61093
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B55A3BC7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F651FDA76;
	Fri, 14 Mar 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc2saaN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C9192D6B;
	Fri, 14 Mar 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953735; cv=none; b=SsAC9FpL2OU+B9BtJnECfmBpc4LURTw8VvqZ+JJH/RQteS7Xno2fiiPzVJp+AGKtjpBNJDNJ/Af3T7d8GMnfePLdm3EtCnFdrT9MXb7TTTOTZ0gUX+XFmiuv490plvCvKY56jzIX17xz81n+osIuuBgzv4sNS8+LDg7D29wVCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953735; c=relaxed/simple;
	bh=DxlDbkBzr4znIgU6IscNEeJX4PHbICaYy1q6UNsHLFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/cD72T39somM5iKk71+FQ2mO6aggM0yYAX4YA0tyTMg62aIzAzVoUKWW76WjFsRTvdvtCjHS5safd88zuyLYNFPc9Ip6196B3rivotkC14rzrDUEQr/tSITc9m2SnFnDEY3OawAI9fu0W7QbA4iTs/wO0D2bZgQrCMh1d2oTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc2saaN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F47FC4CEE3;
	Fri, 14 Mar 2025 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953735;
	bh=DxlDbkBzr4znIgU6IscNEeJX4PHbICaYy1q6UNsHLFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oc2saaN9Xikyg6AgWau8kme9n7KeZo3balbPNV47lmtT5xJE2Dej//U4hWAFKAwtV
	 63Ah7SuEHDObq+Dd4HWyEomOCXa6h5BkXOn4Qm7j9hx66ARWs18VglMXwoiHA16L07
	 yToKkSAb+D6Y39WM9PPBJ+6nV+IcJwDDcxPweQShyIFfr6tsXargeIITqvjoYaWmI2
	 Ey3vG/bS7tG9nCq4qrXj/f/5Vc4149b0BSJBU1wRka4MOX0TB02nWrbw8d7Wb8IAe/
	 0zYrT/gj5j4ALMH28t5acAX8C+K1YEfLQkaKCIyiC8BFBujzV6FQn17YSop9s9FBSe
	 IXRLfa+tdvRSQ==
Date: Fri, 14 Mar 2025 13:02:12 +0100
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
Subject: Re: [RFC v3 10/33] rust: drm/kms: Add
 ConnectorGuard::add_modes_noedid()
Message-ID: <20250314-observant-cyber-chowchow-bfe5f9@houat>
References: <20250305230406.567126-1-lyude@redhat.com>
 <20250305230406.567126-11-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pez3lnltw5krpfnp"
Content-Disposition: inline
In-Reply-To: <20250305230406.567126-11-lyude@redhat.com>


--pez3lnltw5krpfnp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v3 10/33] rust: drm/kms: Add
 ConnectorGuard::add_modes_noedid()
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:59:26PM -0500, Lyude Paul wrote:
> A simple binding for drm_add_modes_noedid() using the ConnectorGuard type
> we just added.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/bindings/bindings_helper.h  |  1 +
>  rust/kernel/drm/kms/connector.rs | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 27828dd36d4f2..846eb6eb8fc4c 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_fbdev_dma.h>
> diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/conne=
ctor.rs
> index 14de3b0529f89..855a47b189a91 100644
> --- a/rust/kernel/drm/kms/connector.rs
> +++ b/rust/kernel/drm/kms/connector.rs
> @@ -446,6 +446,17 @@ fn deref(&self) -> &Self::Target {
>      }
>  }
> =20
> +impl<'a, T: DriverConnector> ConnectorGuard<'a, T> {
> +    /// Add modes for a [`ConnectorGuard`] without an EDID.
> +    ///
> +    /// Add the specified modes to the connector's mode list up to the g=
iven maximum resultion.
> +    /// Returns how many modes were added.
> +    pub fn add_modes_noedid(&self, (max_h, max_v): (i32, i32)) -> i32 {

Why do we need a tuple of i32 there instead of two u32/usize parameter?

And the return type should be unsigned as well.

Maxime

--pez3lnltw5krpfnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9QawwAKCRAnX84Zoj2+
drIUAX44y6dqTjQt0FYqsmifts7sm6UEPpSeSxEgUIguEk9jAk+VzWO5ipvtIhGC
p9swKBoBgIJvQe6kLXZhdsL+wjDcJsDiP+y3OAp4lU/Rnn3rwCDMbZHxH4mKP/+Q
cUHYplPjHg==
=AXEJ
-----END PGP SIGNATURE-----

--pez3lnltw5krpfnp--

