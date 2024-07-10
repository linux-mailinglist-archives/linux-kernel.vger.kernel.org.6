Return-Path: <linux-kernel+bounces-247631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E792D233
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D9F2880CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B71922FE;
	Wed, 10 Jul 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQNUs39L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232E83CD4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616677; cv=none; b=XiW4rQrIsocMY/Y8am21If/xLBfVxqgfN1ChV/JK7cMcsEt2YZqUAYyshDEiWmtFUPsujmfPyUZji8ol2LV46o1FqU3MT9UTLh0GZ+T/C6eIbRaaH0zinUkxG8/dzJO/a/gNM24cgnlRC46gy9KnePK6/PowUG7H+AjXzS3MwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616677; c=relaxed/simple;
	bh=onzmcxaR9WVaOaR53OrVwg2UDI/A4ORQ6Oxc7wv+1zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iRDe9WFRjrlnW5RkHxTTAX+drqOBZAv+wqzgZ3UuLNHHMLSlSxYHH86+4o8zrjhboZ0K05Rz+WmzTl43fNJRVzQIDr9Cbivf1xcbOl+RTORVRS95qCZE6EvzaPKysqXXkmygDYN543LkZ/W7w0fuvNaW7DOvbRKfoV3OFPqhmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQNUs39L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B3C32781;
	Wed, 10 Jul 2024 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616676;
	bh=onzmcxaR9WVaOaR53OrVwg2UDI/A4ORQ6Oxc7wv+1zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cQNUs39L19kCh4XO/FzWZc1h22oxZNouZMR1RCYXBJkZk0u63HGcCrWbxNqoHq1Jo
	 XGVOicyiwQkh7Vo7bOKGOducpHEL3O12/LQ34XchU+HDdmMrtHpQAEo9zvK50nVM75
	 CXQ90vwrLqmx/92r7pEb7/I09cX2RfO2DIzLP4eA8skI99YxByD/dFycO9onzRVxEx
	 dHoCTAp4HKEbw3xaMZbyzVMN5XKWwF5u60JCNC6LvuzM6SkkyquFxVraYG39CCd70h
	 OcnPbliyXZgVfh/uBpy9TU278Q+1/jBxg1p4P7ZS1bI59RE0U5lx2X4K+l8upfnmQN
	 VeUj3YuO1s6zw==
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
Date: Wed, 10 Jul 2024 15:04:34 +0200
Message-ID: <mafs07cdto0t9.fsf@kernel.org>
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

Even though the operations have the same opcode, I see them as different
operations. One is a byte program: it can only write one byte at a time.
The other is a page program: it can write up to one page (256 bytes
usually) at a time.

So I would actually find it more confusing if you use page program in a
situation where the operation is actually a byte program, and attempting
to program the whole page will fail.

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
> +{
> +	u8 op =3D (len =3D=3D 1) ? SPINOR_OP_BP : SPINOR_OP_AAI_WP;

Hmm, this looks a bit hacky. But the whole sst_nor_writa() is kinda
hacky anyway so it is fine I guess... LGTM otherwise.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Not directly related to this patch, but when reviewing this patch I
noticed another small improvement you can make. since you are already
looking at this code. (to be clear, this is not needed for this patch to
get merged, this can be a follow up patch).

sst_nor_write() looks like:

	/* Write out most of the data here. */
	for (; actual < len - 1; actual +=3D 2) {
        	[...]
	}
	nor->sst_write_second =3D false;

	ret =3D spi_nor_write_disable(nor);
	if (ret)
		goto out;

	ret =3D spi_nor_wait_till_ready(nor);
	if (ret)
		goto out;

	/* Write out trailing byte if it exists. */
	if (actual !=3D len) {
		ret =3D spi_nor_write_enable(nor);
                [...]

		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
                [...]

		ret =3D spi_nor_wait_till_ready(nor);
		if (ret)
			goto out;


		ret =3D spi_nor_write_disable(nor);
	}

Here, we do a write disable. Then if a one-byte write is needed, do a
write enable again, write the data and write disable.

Do we really need to toggle write enable between these? If not, it can
be simplified to only do the write disable after all bytes have been
written.

[...]

--=20
Regards,
Pratyush Yadav

