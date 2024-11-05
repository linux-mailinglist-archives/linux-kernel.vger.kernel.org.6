Return-Path: <linux-kernel+bounces-396906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D69BD409
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539CD1C21854
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703691E6306;
	Tue,  5 Nov 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8G1C9oo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B981E0E18;
	Tue,  5 Nov 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829838; cv=none; b=sCPn0TeRisnVXXRRQIkyX9o9MdQS6EGHFTqv2b2S+qOFEpyHjbNddtmg6137Gayex3xIgcw3CP41C9NauOt7P2btAjPvl5LdL4wOi38wCTuEmrxBtyT6jeaQMPoDO+hl0mXWLzDB7recjYOwZURjQs02xvx5HSBPKASoZk/RE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829838; c=relaxed/simple;
	bh=8+cIHaDK/PkRLZQNzEkaeipacB3Q8GDm8j9Yz0buIQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keGwRvBRQ5oM/BquI5Apd98VhgopenJfFmNwhsYa2vganXzX0VWQ6FGHEzfZc80nYdZVvlcRUGrWHhYNejzOizKR3A/n6j0vjUBoQZrOg4UA1SAWKbW1gtYDEybiyRxakx41KpRhf6Y/BuTiFoK5nFTMLlPrzEocEvlgQooIp50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8G1C9oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6341C4CECF;
	Tue,  5 Nov 2024 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730829838;
	bh=8+cIHaDK/PkRLZQNzEkaeipacB3Q8GDm8j9Yz0buIQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8G1C9oo+hPHLWRYPvwmxqqVWfHAG4XeiZuNblLd111x+Q1yzSS+pJOqgM8/6hOP2
	 O6thypMRrVz2WVEA24bcBHBMuR9V1vAzyt0HK6k8y+1ektuHJ9JSNhqxgTE9U5PZWX
	 Rh0lHZ1hOHE+03rczdO2u4fjZGRbJcAa1Tq/pUWbtbNWyqkQ3n4RlUO+hQOtnYFJxS
	 eVBZNlk8JwRT59FtFGMvz5eObS/DEFzf1JAMQd0jAXIZnCYN6zwNjZAqlxfVa+I+yP
	 YBKoHvubYo0TbL/ynmb06QAsnQbzrqFKBJOeHXxUsdMR1UnPIrVs0u4tybuS9zIUZ1
	 UxJlWTmX1IUSg==
Date: Tue, 5 Nov 2024 18:03:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: Frank Binns <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Randolph Sapp <rs@ti.com>,
	Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH 08/21] dt-bindings: gpu: img: Add BXS-4-64 devicetree
 bindings
Message-ID: <20241105-sulfite-justness-d7b7fb98905c@spud>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQXEB5mU2yf0jpDO"
Content-Disposition: inline
In-Reply-To: <20241105-sets-bxs-4-64-patch-v1-v1-8-4ed30e865892@imgtec.com>


--xQXEB5mU2yf0jpDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 03:58:14PM +0000, Matt Coster wrote:
> +    / {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <3>;
> +
> +        gpu@4e20000000 {
> +            compatible =3D "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img=
-rogue";
> +            reg =3D /bits/ 64 <0x4e20000000 0x80000>;

Can you format this normally please? Drop the #address/size-cells down
to 1 if you're against having 0x0s.

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


> +            clocks =3D <&k3_clks 130 1>;
> +            clock-names =3D "core";
> +            interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +            power-domains =3D <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>,
> +                            <&k3_pds 373 TI_SCI_PD_EXCLUSIVE>;
> +            power-domain-names =3D "a", "b";
> +            dma-coherent;
> +        };
> +    };
>=20
> --=20
> 2.47.0
>=20

--xQXEB5mU2yf0jpDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZypeCAAKCRB4tDGHoIJi
0rKRAQCPc+IctwmoZoddo4GAQ3JphX1ttBvWgJigLa3DJ8BDkgEA3T1r9hN1I0La
vZrB0DbYFGc/m61hAVWkIrElbvEhwwo=
=3MKw
-----END PGP SIGNATURE-----

--xQXEB5mU2yf0jpDO--

