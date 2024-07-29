Return-Path: <linux-kernel+bounces-265987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42593F8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659C1B20BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F85155337;
	Mon, 29 Jul 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJuDukL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BE14601E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264946; cv=none; b=K7BFsYjB0YkXT0COngOWegV/8lfDyZHXbrOX7jrDmk/N0osdR3S/B6UwiRTn0tIxqnmF6o9CEnbWJVl78m/jrgSLZKK6GmhtNJbtH5H7vHFimSZ27G9qp+hRSwCbZF/OI513g2XtUU9k3Ir22hzO3IFHTG+r81mwq3g6ZHVBQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264946; c=relaxed/simple;
	bh=l/1GqXYGzcJhXc0sYSrfsq2Iy6WJe4nNPGoPHeBpm0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u97K84XIYFq38UAMXv1BX9gSc1/7NqBDjPVzPU3P9ySxX9laPu8JZifPsFI+PXK3ZPqYSqxoKkpdqUTrfUEevJvLCDixFpcfFyDLuiG3d9tjEFh3l5ae4Y5o4Iz9fqnofJfBmKp0BARO+vHL4ipF1Vdsc/RpIAoYRyKzqNgkQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJuDukL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3683DC32786;
	Mon, 29 Jul 2024 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264945;
	bh=l/1GqXYGzcJhXc0sYSrfsq2Iy6WJe4nNPGoPHeBpm0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aJuDukL156iN3Ke2uJenSPPbfdL4svs0vx/6nOvFHXvaxspckME+4KwEDlogI9ieB
	 UYFcJx+wZ92CH2GegVwShojz5JgdaWDY83Z2FI/wVW9d6K97vjVBqPenPAp8Q6Pzx2
	 DNw+1yXsI6E4LjwfWWG74rDiZc5gSU96lj7K/Iva2loAuUPiIo2ulI5lwAYIZKyULc
	 ZH8sJVScQOust4zpOaIMmtwaG0vZAqL9BCdOMUoDbxkIg6MdbBYMQUfDQ0Uw6usxsK
	 Yix7K0Q9pSKsuiUUusN+eaMFHn6wNtk3B7SYMs5mxAr+RNFkzqHi0exzQQg3+W0VeV
	 covHpwxZrgj4A==
From: Pratyush Yadav <pratyush@kernel.org>
To: =?utf-8?Q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  "Tudor Ambarus" <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: sst: Factor out common write operation to
 `sst_nor_write_data()`
In-Reply-To: <20240710091401.1282824-1-csokas.bence@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6FzLA==?=
	Bence"'s message of "Wed, 10 Jul 2024 11:14:01 +0200")
References: <20240710091401.1282824-1-csokas.bence@prolan.hu>
Date: Mon, 29 Jul 2024 16:55:43 +0200
Message-ID: <mafs07cd42qog.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10 2024, Cs=C3=B3k=C3=A1s, Bence wrote:

> Writing to the Flash in `sst_nor_write()` is a 3-step process:
> first an optional one-byte write to get 2-byte-aligned, then the
> bulk of the data is written out in vendor-specific 2-byte writes.
> Finally, if there's a byte left over, another one-byte write.
> This was implemented 3 times in the body of `sst_nor_write()`.
> To reduce code duplication, factor out these sub-steps to their
> own function.
>
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>

Applied to spi-nor/next, thanks!

FYI, I spotted a couple small issues and fixed them up when applying.
See below...

> ---
>
> Notes:
>     RFC: I'm thinking of removing SPINOR_OP_BP in favor of
>     SPINOR_OP_PP (they have the same value). SPINOR_OP_PP
>     is the "standard" name for the elementary unit-sized
>     (1 byte, in the case of NOR) write operation. I find it
>     confusing to have two names for the same operation,
>     so in a followup I plan to remove the vendor-specific
>     name in favor of the standard one.
>
>  drivers/mtd/spi-nor/sst.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 180b7390690c..fec71689e644 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -167,6 +167,21 @@ static const struct flash_info sst_nor_parts[] =3D {
>  	}
>  };
>=20=20
> +static int sst_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
> +			const u_char *buf)

Whitespace issue, checkpatch complains on this. It should be aligned
with the opening parenthesis above.

> +{
> +	u8 op =3D (len =3D=3D 1) ? SPINOR_OP_BP : SPINOR_OP_AAI_WP;
> +	int ret;
> +
> +	nor->program_opcode =3D op;
> +	ret =3D spi_nor_write_data(nor, to, 1, buf);
> +	if (ret < 0)
> +		return ret;
> +	WARN(ret !=3D len, "While writing %i byte written %i bytes\n", len, ret=
);

I get a build warning because of incorrect format specifier. Should use
%zu since len is size_t.

> +
> +	return spi_nor_wait_till_ready(nor);
> +}
> +
>  static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  			 size_t *retlen, const u_char *buf)
>  {
[...]

--=20
Regards,
Pratyush Yadav

