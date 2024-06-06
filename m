Return-Path: <linux-kernel+bounces-204392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794518FE820
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0955B2897E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B53195FC9;
	Thu,  6 Jun 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM/kYm/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E1195995
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681525; cv=none; b=HpqAdtGJjCmr2vA5krrfmMrvi1Tzt8Wxv0iSU7w+D57U6GplOcRPSJhGyeTyPvGV09jjo1uMuCZE+ZFNLrv/DG84g9AA/EuGrk7MiA6gNMuMa4GcWbqfNTmbhR7sCQzb5kR/mUv0VdHboSIBP3cYlFVzFhUoBR4eo4/GKdfpzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681525; c=relaxed/simple;
	bh=RabUCoQbg8d0SmOaAZkfQWlRTkdI/BRDQ5JH4zGLsU8=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=O+x60te9xxxuL5RaM7PlO8cBqHR9GfSSyQZBK8X//Lw43zcPnWHkumFKfZiljyKctC3FexPxI26Zf5fPPLH5hKmDt8d39GXzUXQGUGu1IU588cD189i6IDoMbxd53WzzqbFnt8+t/+4obKRwK4y9joK7k6HBD/ciWG/YNxIzh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM/kYm/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B083C2BD10;
	Thu,  6 Jun 2024 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681524;
	bh=RabUCoQbg8d0SmOaAZkfQWlRTkdI/BRDQ5JH4zGLsU8=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=sM/kYm/UmKCqEWhz9SVw/B4ILwiXoakHZuJL59GXp8JmSio7E9b5ZY582HXeXkbi6
	 1pUuryZorn3aNFdkqCF12ZsRDE5FHpZN6xiPAeFYakUirFHYehesJdjFq+e2Rs2bJG
	 Bd4xM1qw43tq3Jtk2Tt9cXVxfr4KRcvCp0Xo2uodQqiJzVyzPXO1WHiIYSmVOZrCKJ
	 cYBq3/A1hObLhwJl0mRny+cvj9Pps6nhNmxq6O2mcbXyl/ZNWtwdT34m75XXEqFM2k
	 e9FOpXNU1EzQA0paWTizjxGe1GJk7tKdCI9WwVMxKmYzDQm7xoIdH87L16Z7fSSnZz
	 X69FGa83YklTQ==
Content-Type: multipart/signed;
 boundary=479d9d31d50b1e2e2050036af42fee8ce0912e5ec1a0f68f2ab9c35385aa;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 06 Jun 2024 15:45:20 +0200
Message-Id: <D1SZA4ZDM06P.CJC0EQ9ULA04@kernel.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Esben Haabendal"
 <esben@geanix.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com> <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org> <8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
In-Reply-To: <8513a828-6669-4bf3-91d3-799771866f32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--479d9d31d50b1e2e2050036af42fee8ce0912e5ec1a0f68f2ab9c35385aa
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> >> + */
> >> +static int
> >> +mx25l3205d_late_init(struct spi_nor *nor)
> >> +{
> >> +	struct spi_nor_flash_parameter *params =3D nor->params;
> >> +
> >> +	/*                          DREAD  2READ  QREAD  4READ
> >> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
> >> +	 * Before SFDP parse          1      0      1      0
> >> +	 * 3206e after SFDP parse     1      0      0      0
> >> +	 * 3233f after SFDP parse     1      1      1      1
> >> +	 * 3205d after this func      0      1      0      0
> >> +	 */
> >> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
> >> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
> >> +		/* Should be MX25L3205D */
> >> +		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_1_1_2;
> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
> >> +					  0, 0, 0, 0);
> >> +		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_1_1_4;
> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
> >> +					  0, 0, 0, 0);
> >> +		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_2_2;
> >> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
> >> +					  0, 4, SPINOR_OP_READ_1_2_2,
> >> +					  SNOR_PROTO_1_2_2);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct spi_nor_fixups mx25l3205d_fixups =3D {
> >> +	.late_init =3D mx25l3205d_late_init,
> >> +};
> >> +
> >>  static int
> >>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
> >>  			    const struct sfdp_parameter_header *bfpt_header,
> >> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[]=
 =3D {
> >>  		.id =3D SNOR_ID(0xc2, 0x20, 0x16),
> >>  		.name =3D "mx25l3205d",
> >>  		.size =3D SZ_4M,
> >> -		.no_sfdp_flags =3D SECT_4K,
> >> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> >> +		.fixups =3D &mx25l3205d_fixups
> >>  	}, {
> >>  		.id =3D SNOR_ID(0xc2, 0x20, 0x17),
> >>  		.name =3D "mx25l6405d",
> >>
>
> If all support 1-1-2, (seems MX25L3205D doesn't), then we may have a
> change to don't update the core.
>
> Frankly I don't care too much about what happens in the manufacturer
> drivers, but I do care about the core and to not extend it with . This
> patch is not too heavy to be unmaintainable and shows clear where the
> problem is, we can keep this as well.

It's a horrible hack. For example I'm working on a patch to clean up
the spi_nor_set_read_settings() handling. So just throwing any code
into vendor drivers doesn't make it any better in terms of
maintainability. I'd need to touch all the code anyway. In fact it
makes it even worse, because it looks like the manufacturer drivers
are just a dumping ground for bad things. Thus, I'd really have it
handled in a correct way inside the core.

Also, this is not device specific. Let there be two different
flashes with the same ID, but one support SFDP and one doesn't.
Right now, you have to have any of the magic flags (dual, quad,
etc) set to trigger an SFDP parsing. If the flash without SFDP
doesn't support any of these, like in this case, we are screwed.
Hence we might need such a flag also for other flashes.

> Other option that I'd like you to consider is whether we just remove
> support for MX25L3205D, thus the entry altogether, and instead rely on
> SFDP to set everything.

Well, this will break boards with this flash :) And we don't know if
there are any.

-michael

--479d9d31d50b1e2e2050036af42fee8ce0912e5ec1a0f68f2ab9c35385aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZmG9cRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/grRgF+Ju8AIIr0YhhI6wK7vFUrv1TIIvNnMZRo
2eP5r1ZrYb43Tt9ShCcjpqMu98HIjwPVAXwOYh+E6vTynjxye7akY9WaDu1x6oDk
+qvFE+kgUdpUFnzjF0Kg3Csc3MUnvLogIS4=
=5qOF
-----END PGP SIGNATURE-----

--479d9d31d50b1e2e2050036af42fee8ce0912e5ec1a0f68f2ab9c35385aa--

