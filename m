Return-Path: <linux-kernel+bounces-198711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A008D7C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E06C1F22D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C10243ADC;
	Mon,  3 Jun 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaH5Gd7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EF3FBB7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399556; cv=none; b=VqSmujUQVpBRinpjEnOmBvou6pngljMTd+HSqekkyLh6Ye4VxTvZKOzj5MCYVncVPl200ukyPGaM7WX92zuwJPLtIeaUm3gnYNFxmLkrM4RyTQUz8Ncs1YzW/zdFVdtXkssOOd9Tcu5k/r5Il0JFOTJ6XCsvB+TFnZ9GVzxc+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399556; c=relaxed/simple;
	bh=fEr+RytRIwgb/dvHPPXLkBVdzxQTfCtF/89gxECoHJ4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=TRjkn401F3oqJOtYW/fKxfKqmXJ5mvFdM6ywebCsXwe8vAJ9+jSywSnZM3hwOD1GgGnxTM9aqFp9eaYsTo4euEHo5vD7r4w+2cjsTE6P09oFX4458RKsL6USKeWbbCMzqYbVOP0yIdq9/Xam8CTe5uHkTcr0qdABVvPuE5cX/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaH5Gd7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C6C2BD10;
	Mon,  3 Jun 2024 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717399555;
	bh=fEr+RytRIwgb/dvHPPXLkBVdzxQTfCtF/89gxECoHJ4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=NaH5Gd7KT62gYBVqbgKqORFkGKaQUYYE1wWSR/XUDsxkXAFnN6L5wOwaX+0O5OKnb
	 JnUgBMjbL7hm/8N0EaDhWRXlLDBq4r79XakcmJ2kM2th9eHiBMA3jZCTjtdgtH7foC
	 DaQeAAJkoNDTGscVVzADdhlGQuUo1ilyMNBP7D4+Jdt57BfPBuY6ER8Q5hOUA8GeDc
	 YajMHlvyXB3wtcYMkItOyrEVFtCih6AZX6Z0UGGSaYxrzrVv5OZScqCpsqEKC6HPS7
	 bK7EKaeGrcoLMbJJ+3FJeOqs34Tj5qvj8aJVPZf+4knIg/6LQei+WwsjNvAPNhp2IN
	 IYrlOLYucE08g==
Content-Type: multipart/signed;
 boundary=62dfc1cd91faea84d32d705095127aab3d83287f351da8bd6655d6784688;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 03 Jun 2024 09:25:42 +0200
Message-Id: <D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.16.0
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
In-Reply-To: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--62dfc1cd91faea84d32d705095127aab3d83287f351da8bd6655d6784688
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri May 24, 2024 at 12:48 PM CEST, Esben Haabendal wrote:
> Macronix engineers apparantly do not understand the purpose of having
> an ID actually identify the chip and its capabilities. Sigh.
>
> The original Macronix SPI NOR flash that identifies itself as 0xC22016
> with RDID was MX25L3205D. This chip does not support SFDP, but does
> support the 2READ command (1-2-2).
>
> When Macronix announced EoL for MX25L3205D, the recommended
> replacement part was MX25L3206E, which conveniently also identifies
> itself as 0xC22016. It does not support 2READ, but supports DREAD
> (1-1-2) instead, and supports SFDP for discovering this.
>
> When Macronix announced EoL for MX25L3206E, the recommended
> replacement part was MX25L3233F, which also identifies itself as
> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
> and 4READ (1-4-4). This also support SFDP.

Thanks for collecting all this info!

> So far, all of these chips have been handled the same way by the Linux
> driver. The SFDP information have not been read, and no dual and quad
> read modes have been enabled.
>
> The trouble begins when we want to enable the faster read modes. The
> RDID command only return the same 3 bytes for all 3 chips, so that
> doesn't really help.
>
> But we can take advantage of the fact that only the old MX25L3205D
> chip does not support SFDP, so by triggering the old initialization
> mechanism where we try to read and parse SFDP, but has a fall-back
> configuration in place, we can configure all 3 chips to their optimal
> configurations.

You are (mis)using the quad info bits to trigger an sfdp read,
correct? In that case, I'd rather see a new flag in .no_sfdp_flags
to explicitly trigger the SFDP read. Then your new flash would only
need this flag and doesn't require the shenanigans with the fixup,
right?

> With this, MX25L3205D will get the faster 2READ command enabled,
> speading up reads. This should be safe.
>
> MX25L3206E will get the faster DREAD command enabled. This should also
> be safe.
>
> MX25L3233F will get all of DREAD, 2READ, QREAD and 4READ enabled. In
> order for this to actually work, the WP#/SIO2 and HOLD#/SIO3 pins must
> be correctly wired to the SPI controller.

That should already be taken care of with the spi-{tx,rx}-bus-width.

-michael

> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
> I only have access to boards with MX25L3233F flashes, so haven't been
> able to test the backwards compatibility. If anybody has boards with
> MX25L3205D and/or MX25L3206E, please help test this patch. Keep an eye
> for read performance regression.
>
> It is worth nothing that both MX25L3205D and MX25L3206E are
> end-of-life, and is unavailable from Macronix, so any new boards
> featuring a Macronix flash with this ID will likely be using
> MX25L3233F.
> ---
>  drivers/mtd/spi-nor/macronix.c | 60 ++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macroni=
x.c
> index ea6be95e75a5..c1e64ee3baa3 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,63 @@
> =20
>  #include "core.h"
> =20
> +/*
> + * There is a whole sequence of chips from Macronix that uses the same d=
evice
> + * id. These are recommended as EoL replacement parts by Macronix, altho=
ugh they
> + * are only partly software compatible.
> + *
> + * Recommended replacement for MX25L3205D was MX25L3206E.
> + * Recommended replacement for MX25L3206E was MX25L3233F.
> + *
> + * MX25L3205D does not support RDSFDP. The other two does.
> + *
> + * MX25L3205D supports 1-2-2 (2READ) command.
> + * MX25L3206E supports 1-1-2 (DREAD) command.
> + * MX25L3233F supports 1-1-2 (DREAD), 1-2-2 (2READ), 1-1-4 (QREAD), and =
1-4-4
> + * (4READ) commands.
> + *
> + * In order to trigger reading optional SFDP configuration, the
> + * SPI_NOR_DUAL_READ|SPI_NOR_QUAD_READ flags are set, seemingly enabling=
 1-1-2
> + * and 1-1-4 for MX25L3205D. The other chips supporting RDSFDP will have=
 the
> + * correct read commands configured based on SFDP information.
> + *
> + * As none of the other will enable 1-1-4 and NOT 1-4-4, so we identify
> + * MX25L3205D when we see that.
> + */
> +static int
> +mx25l3205d_late_init(struct spi_nor *nor)
> +{
> +	struct spi_nor_flash_parameter *params =3D nor->params;
> +
> +	/*                          DREAD  2READ  QREAD  4READ
> +	 *                          1-1-2  1-2-2  1-1-4  1-4-4
> +	 * Before SFDP parse          1      0      1      0
> +	 * 3206e after SFDP parse     1      0      0      0
> +	 * 3233f after SFDP parse     1      1      1      1
> +	 * 3205d after this func      0      1      0      0
> +	 */
> +	if ((params->hwcaps.mask & SNOR_HWCAPS_READ_1_1_4) &&
> +	    !(params->hwcaps.mask & SNOR_HWCAPS_READ_1_4_4)) {
> +		/* Should be MX25L3205D */
> +		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_1_1_2;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_2],
> +					  0, 0, 0, 0);
> +		params->hwcaps.mask &=3D ~SNOR_HWCAPS_READ_1_1_4;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_4],
> +					  0, 0, 0, 0);
> +		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_2_2;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_2_2],
> +					  0, 4, SPINOR_OP_READ_1_2_2,
> +					  SNOR_PROTO_1_2_2);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct spi_nor_fixups mx25l3205d_fixups =3D {
> +	.late_init =3D mx25l3205d_late_init,
> +};
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -61,7 +118,8 @@ static const struct flash_info macronix_nor_parts[] =
=3D {
>  		.id =3D SNOR_ID(0xc2, 0x20, 0x16),
>  		.name =3D "mx25l3205d",
>  		.size =3D SZ_4M,
> -		.no_sfdp_flags =3D SECT_4K,
> +		.no_sfdp_flags =3D SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixups =3D &mx25l3205d_fixups
>  	}, {
>  		.id =3D SNOR_ID(0xc2, 0x20, 0x17),
>  		.name =3D "mx25l6405d",
>
> ---
> base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> change-id: 20240524-macronix-mx25l3205d-fixups-882e92eed7d7
>
> Best regards,


--62dfc1cd91faea84d32d705095127aab3d83287f351da8bd6655d6784688
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZl1v9xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gMxwGAvrjWMLnmjxWYUHiaiERNrQqk9PERyYF8
ZttkIypS4wKL0tvNNNDWENLL9KwJu/yJAYCbHkiwVlZGfD+dI9XKXdXXu/SMT363
c1pHCkOvDZ82nN21GLn+EMMOYVTEswg+beg=
=u1Gm
-----END PGP SIGNATURE-----

--62dfc1cd91faea84d32d705095127aab3d83287f351da8bd6655d6784688--

