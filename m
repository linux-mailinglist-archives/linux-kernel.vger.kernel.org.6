Return-Path: <linux-kernel+bounces-404629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140529C45E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75BE284393
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E1156C72;
	Mon, 11 Nov 2024 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A37qSliz"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C3132132
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353536; cv=none; b=rB3Ibgp5Q/P1BUy3lOCVMDS+b3Ix4tLjGHLhAXHj0jSt7//O5Zt1h8NYIJsgcIS/ekDp7TtdNhCCEibVjC/KRAIis1guIEdFpGyNfzL60UghM16/CpTSXfMuToJj+OMtWCvoj7lz7qGXcBX5YwAj/DxVRE9CZ7kOqBs9Ud/oOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353536; c=relaxed/simple;
	bh=3PAVG6UWTwjw5RQHETs+Pc8aGoU1rcVLr1CHFDPk6S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CgJXlQmwOJfNmLdnhYVgiiCnXd7qrdh3686vIlXe0XOD8HadEz+ovQW3UwbE4LYtx7UmzDfWTknkr0+0LeIOPy3+4KkU+BPFfbxeB2eK+niYthgzIvzQt4xFfVj0d+Ooc8+GK0HcRfgqam3YxP4gy5jiekzEfibViAuVVwzL6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A37qSliz; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB2391C0003;
	Mon, 11 Nov 2024 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731353531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGFoL8GPN97aScIvx4frLGVFiInxEXUkie6Iu4YEKqA=;
	b=A37qSliz/4dvnRXOM94JvGMkgKahiGnxzTrNawpwjjYv/Dua5RC/s/yz5wNwWmQiKnu4R7
	1naQGK7kTgFly4hghfdukaLF4uSL9AaoOiSnq309FGtot4FoKgxBsBDHKbSTvb2EQxkLDU
	Mqy3OhUXvx906Iz89YuNHyQTLaSupkebR2CTahsT4keEsPV3pr37hCxnT4KrPkuUjLzXYR
	wKvlJChrbQ8ntJog2iP2HTWWbs+ffst3wKwrvFPAw7VUy5H39uYg8gb8gucAXHpbyTCK2H
	mscodQLkm7Wv9fO7FbLKbRXqAW7JmmYCGM057v9d8GuuXz7V05/efFgGDLdUsw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v2 6/6] mtd: rawnand: davinci: Implement
 setup_interface() operation
In-Reply-To: <20241106085507.76425-7-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 6 Nov 2024 09:55:07 +0100")
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
	<20241106085507.76425-7-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 20:32:09 +0100
Message-ID: <87frnxr2h2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Bastien,

On 06/11/2024 at 09:55:07 +01, Bastien Curutchet <bastien.curutchet@bootlin=
.com> wrote:

> The setup_interface() operation isn't implemented. It forces the driver
> to use the ONFI mode 0, though it could use more optimal modes.
>
> Implement the setup_interface() operation. It uses the
> aemif_set_cs_timings() function from the AEMIF driver to update the
> chip select timings. The calculation of the register's contents is
> directly extracted from =C2=A720.3.2.3 of the DaVinci TRM [1]
>
> These timings are previously set by the AEMIF driver itself from
> device-tree properties. Therefore, IMHO, failing to update them in the
> setup_interface() isn't critical, which is why 0 is returned even when
> timings aren't updated.

Did you experience failures? Because I'd be more conservative and error
out loudly when something is wrong. In general it is a safest approach
on the long term. Here maybe you have good reasons to do differently, in
this case I am all ears.

> MAX_TH_PS and MAX_TSU_PS are the worst case timings based on the
> Keystone2 and DaVinci datasheets.
>
> [1] : https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf
>
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/mtd/nand/raw/davinci_nand.c | 78 +++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/d=
avinci_nand.c
> index 563045c7ce08..2d0c564c8d17 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/memory/ti-aemif.h>
>  #include <linux/module.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -44,6 +45,9 @@
>  #define	MASK_ALE		0x08
>  #define	MASK_CLE		0x10
>=20=20
> +#define MAX_TSU_PS		3000	/* Input setup time in ps */
> +#define MAX_TH_PS		1600	/* Input hold time in ps */
> +
>  struct davinci_nand_pdata {
>  	uint32_t		mask_ale;
>  	uint32_t		mask_cle;
> @@ -120,6 +124,7 @@ struct davinci_nand_info {
>  	uint32_t		core_chipsel;
>=20=20
>  	struct clk		*clk;
> +	struct aemif_device	*aemif;
>  };
>=20=20
>  static DEFINE_SPINLOCK(davinci_nand_lock);
> @@ -767,9 +772,81 @@ static int davinci_nand_exec_op(struct nand_chip *ch=
ip,
>  	return 0;
>  }
>=20=20
> +#define TO_CYCLES(ps, period_ns) (DIV_ROUND_UP((ps) / 1000, (period_ns)))
> +
> +static int davinci_nand_setup_interface(struct nand_chip *chip, int chip=
nr,
> +					const struct nand_interface_config *conf)
> +{
> +	struct davinci_nand_info *info =3D to_davinci_nand(nand_to_mtd(chip));
> +	const struct nand_sdr_timings *sdr;
> +	struct aemif_cs_timings timings;
> +	s32 cfg, min, cyc_ns;
> +
> +	cyc_ns =3D 1000000000 / clk_get_rate(info->clk);
> +
> +	sdr =3D nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	cfg =3D TO_CYCLES(sdr->tCLR_min, cyc_ns) - 1;
> +	timings.rsetup =3D cfg > 0 ? cfg : 0;
> +
> +	cfg =3D max_t(s32, TO_CYCLES(sdr->tREA_max + MAX_TSU_PS, cyc_ns),
> +		    TO_CYCLES(sdr->tRP_min, cyc_ns)) - 1;
> +	timings.rstrobe =3D cfg > 0 ? cfg : 0;
> +
> +	min =3D TO_CYCLES(sdr->tCEA_max + MAX_TSU_PS, cyc_ns) - 2;
> +	while ((s32)(timings.rsetup + timings.rstrobe) < min)
> +		timings.rstrobe++;

I see a lot of while loops which just stop if you reach a min/max, I
believe a slightly more robust approach should be attempted, and
returning errors when these limits are crossed would be probably
beneficial on the long term?

> +
> +	cfg =3D TO_CYCLES((s32)(MAX_TH_PS - sdr->tCHZ_max), cyc_ns) - 1;
> +	timings.rhold =3D cfg > 0 ? cfg : 0;
> +
> +	min =3D TO_CYCLES(sdr->tRC_min, cyc_ns) - 3;
> +	while ((s32)(timings.rsetup + timings.rstrobe + timings.rhold) < min)
> +		timings.rhold++;
> +
> +	cfg =3D TO_CYCLES((s32)(sdr->tRHZ_max - (timings.rhold + 1) * cyc_ns * =
1000), cyc_ns);
> +	cfg =3D max_t(s32, cfg, TO_CYCLES(sdr->tCHZ_max, cyc_ns)) - 1;
> +	timings.ta =3D cfg > 0 ? cfg : 0;
> +
> +	cfg =3D TO_CYCLES(sdr->tWP_min, cyc_ns) - 1;
> +	timings.wstrobe =3D cfg > 0 ? cfg : 0;
> +
> +	cfg =3D max_t(s32, TO_CYCLES(sdr->tCLS_min, cyc_ns), TO_CYCLES(sdr->tAL=
S_min, cyc_ns));
> +	cfg =3D max_t(s32, cfg, TO_CYCLES(sdr->tCS_min, cyc_ns)) - 1;
> +	timings.wsetup =3D cfg > 0 ? cfg : 0;
> +
> +	min =3D TO_CYCLES(sdr->tDS_min, cyc_ns) - 2;
> +	while ((s32)(timings.wsetup + timings.wstrobe) < min)
> +		timings.wstrobe++;
> +
> +	cfg =3D max_t(s32, TO_CYCLES(sdr->tCLH_min, cyc_ns), TO_CYCLES(sdr->tAL=
H_min, cyc_ns));
> +	cfg =3D max_t(s32, cfg, TO_CYCLES(sdr->tCH_min, cyc_ns));
> +	cfg =3D max_t(s32, cfg, TO_CYCLES(sdr->tDH_min, cyc_ns)) - 1;
> +	timings.whold =3D cfg > 0 ? cfg : 0;
> +
> +	min =3D TO_CYCLES(sdr->tWC_min, cyc_ns) - 2;
> +	while ((s32)(timings.wsetup + timings.wstrobe + timings.whold) < min)
> +		timings.whold++;
> +
> +	dev_dbg(&info->pdev->dev, "RSETUP %x RSTROBE %x RHOLD %x\n",
> +		timings.rsetup, timings.rstrobe, timings.rhold);
> +	dev_dbg(&info->pdev->dev, "TA %x\n", timings.ta);
> +	dev_dbg(&info->pdev->dev, "WSETUP %x WSTROBE %x WHOLD %x\n",
> +		timings.wsetup, timings.wstrobe, timings.whold);
> +

Here you probably want to exit in the NAND_DATA_IFACE_CHECK_ONLY case.

> +	if (aemif_set_cs_timings(info->aemif, info->core_chipsel, &timings) < 0)
> +		dev_info(&info->pdev->dev,
> +			 "Failed to dynamically update the CS timings, keep them unchanged");
> +
> +	return 0;
> +}
> +

Thanks,
Miqu=C3=A8l

