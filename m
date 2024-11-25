Return-Path: <linux-kernel+bounces-421486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556289D8BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC45E162120
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7269B1B6D14;
	Mon, 25 Nov 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwfhPBJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA27EED6;
	Mon, 25 Nov 2024 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558078; cv=none; b=MAFkS+0sOSjSGzxxlhAOa0lB1Ts51ucAZmPLjv6n98DWcGbYQ4Q0X+DC76vpE7Ci0+oyu+XHQDl5b2Y0OyJnpGj7/4HGpPxiJwtQpwlDY96WXDpRoGbf4E4Dsrh5J0Vm27MyYUJgzXbXdH6XQFpB8nq+SKLayJbosWXf4RX6aQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558078; c=relaxed/simple;
	bh=5Os1CtXeWVGndeC088niVFcHT0wfA4RjZ+xJ14vRQGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apDE/SUBDtHCOqAIdIHFrWPLYcGABfyzSeBmV6Nm5dQK3DRPvTvEcXaHHXI0tPFxSJavPFdyb+r262GtbVI7Lb6zcGdu/EmLTxqv6H2mid2HV0fPMY2tcyK8RzwKxkbgDVDnqgdDoZXXE3z5+no300+WxfpRu6GR7+uZCFGRaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwfhPBJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA40C4CECE;
	Mon, 25 Nov 2024 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732558078;
	bh=5Os1CtXeWVGndeC088niVFcHT0wfA4RjZ+xJ14vRQGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwfhPBJJgvB7xS6b5s55iDllSNGt9l7+3hN0+bdX3KxJiYMGgh/D2GiH36H4AKU5J
	 7wfMx95K6CpnOCVnayR5tzVi3+zwELaz70jWqVY2kogw6bx+nZoaBScvf41L/SDYV8
	 zZr9YDmxtvMHwTw5sgb+fhRK4+w8gfHagRGm2JiRQ6cxl56o/ARjSMbRZmUdMjBqGd
	 77dENqigKWTLDalxfaQbWbyR/uF5MZHQH9kGMNjXjonM+plmAuJOIDnk8zs+AvEfJT
	 0GCCOkVB0J4CbBP8eU7e0PU+c0Q1H4yOsgL0U7Su95N+Jlxa1YhuOl2tS/+rlUZI0Q
	 yxndvrNvpLhUA==
Date: Mon, 25 Nov 2024 18:07:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: gpu: add reset control property
Message-ID: <20241125-dress-disliking-2bf22dd4450e@spud>
References: <20241125-pvr-reset-v1-0-b437b8052948@linumiz.com>
 <20241125-pvr-reset-v1-1-b437b8052948@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="htTo0QmNln1WJxdc"
Content-Disposition: inline
In-Reply-To: <20241125-pvr-reset-v1-1-b437b8052948@linumiz.com>


--htTo0QmNln1WJxdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:07:03PM +0530, Parthiban Nallathambi wrote:
> GE8300 in Allwinner A133 have reset control from the ccu.
> Add the resets property as optional one to control it.

There's no specific compatible here for an a133, but the binding
requires one. Where is your dts patch?

>=20
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 256e252f8087..bb607d4b1e07 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -37,6 +37,9 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.39.2
>=20

--htTo0QmNln1WJxdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0S8+QAKCRB4tDGHoIJi
0p+mAQDx5d12rMbMXydhrghbCQ4c30npjJldAlAKMg27Ax3QpQD/asjiM8qdq71W
MYJgRLx0hjp+ev0I3SYPVMVq6rO72ws=
=IZw0
-----END PGP SIGNATURE-----

--htTo0QmNln1WJxdc--

