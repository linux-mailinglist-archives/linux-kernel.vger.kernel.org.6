Return-Path: <linux-kernel+bounces-407416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571AB9C6D28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3FC1F23D71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EB1FDF8F;
	Wed, 13 Nov 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FDzap8zn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5682230984
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495071; cv=none; b=nMPLBkZb15TIf0Xj0G3MkbTPdMRxwd0QlbcG3Ph3qmBRHHVqDPPpyPFt/NB8hsKsXiQfKEuqaKScCFmlZJZObyWPVSy9wiQ8DInQEe/e+m+IIi6ql4WFuK/QGq5r+UIEsUvh7kV6bNRTpLVOv7IukfPxUpobnwP9qyN5oYTF+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495071; c=relaxed/simple;
	bh=stswml9YN9ctXU03Q+UU02ykU4gZ8JfMJThZTi1WTzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QmrAu2ORMihgnkwA9OfG9JTicEuy51Ekwj2alQSs7hpBYsc1wFZtXAeFWdDG4ddyLd9XNEuplwHYaDpshem3IP783VdSrI/YLv8WIyYxp6ARFcu7fb28R9MYTRyeEgHjUy3atvcMsa91gGQZsUMY/W5eBntAN1Xp5smiyOkerAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FDzap8zn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 722D3FF804;
	Wed, 13 Nov 2024 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731495067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eYWZPVVVV6V1rZ324Ef1ERBrFxYXBHi1oVVo68XQUI8=;
	b=FDzap8znhyS5/pEZwZ1oe8y2w5kclHAYObOp1VctjcT7Oc3+9MdSykiyVS0qfHRsg+RW2t
	4iCrj+4pfzTK1wXjiIjNGzNfCAVe8SA/l2RbegcQC1mEpbP0DbrtwFLitT8vMUYfP5cj36
	yyU6SwOaiGRwFpG0ckVliAhC+hN4dZ+GIneL9ky5uWQFJNYHAOHbgwxBlilGMHLsQ8xMnh
	neSLFCEWXcA05ja57KvGiLrc/I5jbRw5P1w+Ot4qJN+EGL5C2MNAa9Z8usPgSO1ht1VMQk
	eSwMfB97VuFtpq95xkacnNmEUAf8Kg30K/hBM8BCyzaz+4wfpujFr5lLXuQAsw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,  Krzysztof Kozlowski
 <krzk@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v3 1/7] memory: ti-aemif: Create aemif_check_cs_timings()
In-Reply-To: <20241113094938.44817-2-bastien.curutchet@bootlin.com> (Bastien
	Curutchet's message of "Wed, 13 Nov 2024 10:49:32 +0100")
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
	<20241113094938.44817-2-bastien.curutchet@bootlin.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 13 Nov 2024 11:51:06 +0100
Message-ID: <87ldxnqued.fsf@bootlin.com>
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

On 13/11/2024 at 10:49:32 +01, Bastien Curutchet <bastien.curutchet@bootlin=
.com> wrote:

> aemif_calc_rate() check the validity of a new computed timing against a
> 'max' value given as input. This isn't convenient if we want to check
> the CS timing configuration somewhere else in the code.
>
> Wrap the verification of all the chip select's timing configuration into a
> single function to ease its exportation in upcoming patches.
> Remove the 'max' input from aemif_calc_rate() as it's no longer used.

I would split this commit into two separate smaller chunks. First, you
use a timings structure (which is a good idea), and second you
extract/clarify the timing checks. This is two different "features" IMO.

> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  drivers/memory/ti-aemif.c | 89 ++++++++++++++++++++++++++++++---------
>  1 file changed, 69 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index d54dc3cfff73..eef086c8371b 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c
> @@ -107,6 +107,27 @@ struct aemif_cs_data {
>  	u8	asize;
>  };
>=20=20
> +/**
> + * struct aemif_cs_timings: structure to hold CS timing configuration
> + * values are expressed in number of clock cycles - 1
> + * @ta: minimum turn around time
> + * @rhold: read hold width
> + * @rstrobe: read strobe width
> + * @rsetup: read setup width
> + * @whold: write hold width
> + * @wstrobe: write strobe width
> + * @wsetup: write setup width
> + */
> +struct aemif_cs_timings {
> +	u32	ta;
> +	u32	rhold;
> +	u32	rstrobe;
> +	u32	rsetup;
> +	u32	whold;
> +	u32	wstrobe;
> +	u32	wsetup;
> +};
> +
>  /**
>   * struct aemif_device: structure to hold device data
>   * @base: base address of AEMIF registers
> @@ -125,18 +146,48 @@ struct aemif_device {
>  	struct aemif_cs_data cs_data[NUM_CS];
>  };
>=20=20
> +/**
> + * aemif_check_cs_timings - Check the validity of a CS timing configurat=
ion.
> + * @timings: timings configuration
> + *
> + * @return: 0 if the timing configuration is valid, negative errno
> otherwise.

I thinks errno is a bit connoted "userspace", here you return a
"negative error number".

> + */
> +static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
> +{
> +	if (timings->ta > TA_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rhold > RHOLD_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rstrobe > RSTROBE_MAX)
> +		return -EINVAL;
> +
> +	if (timings->rsetup > RSETUP_MAX)
> +		return -EINVAL;
> +
> +	if (timings->whold > WHOLD_MAX)
> +		return -EINVAL;
> +
> +	if (timings->wstrobe > WSTROBE_MAX)
> +		return -EINVAL;
> +
> +	if (timings->wsetup > WSETUP_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /**
>   * aemif_calc_rate - calculate timing data.
>   * @pdev: platform device to calculate for
>   * @wanted: The cycle time needed in nanoseconds.
>   * @clk: The input clock rate in kHz.
> - * @max: The maximum divider value that can be programmed.
>   *
>   * On success, returns the calculated timing value minus 1 for easy
>   * programming into AEMIF timing registers, else negative errno.
>   */
> -static int aemif_calc_rate(struct platform_device *pdev, int wanted,
> -			   unsigned long clk, int max)
> +static int aemif_calc_rate(struct platform_device *pdev, int wanted, uns=
igned long clk)
>  {
>  	int result;
>=20=20
> @@ -149,10 +200,6 @@ static int aemif_calc_rate(struct platform_device *p=
dev, int wanted,
>  	if (result < 0)
>  		result =3D 0;
>=20=20
> -	/* ... But configuring tighter timings is not an option. */
> -	else if (result > max)
> -		result =3D -EINVAL;
> -
>  	return result;
>  }
>=20=20
> @@ -174,30 +221,32 @@ static int aemif_config_abus(struct platform_device=
 *pdev, int csnum)
>  {
>  	struct aemif_device *aemif =3D platform_get_drvdata(pdev);
>  	struct aemif_cs_data *data =3D &aemif->cs_data[csnum];
> -	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
>  	unsigned long clk_rate =3D aemif->clk_rate;
> +	struct aemif_cs_timings timings;

This is a matter of taste, but even though you fully initialize the
structure below *today*, I'd be future-proof by resetting the structure
here:

	struct aemif_cs_timings timings =3D {};

>  	unsigned offset;
>  	u32 set, val;
> +	int ret;
>=20=20
>  	offset =3D A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
>=20=20
> -	ta	=3D aemif_calc_rate(pdev, data->ta, clk_rate, TA_MAX);
> -	rhold	=3D aemif_calc_rate(pdev, data->rhold, clk_rate, RHOLD_MAX);
> -	rstrobe	=3D aemif_calc_rate(pdev, data->rstrobe, clk_rate, RSTROBE_MAX);
> -	rsetup	=3D aemif_calc_rate(pdev, data->rsetup, clk_rate, RSETUP_MAX);
> -	whold	=3D aemif_calc_rate(pdev, data->whold, clk_rate, WHOLD_MAX);
> -	wstrobe	=3D aemif_calc_rate(pdev, data->wstrobe, clk_rate, WSTROBE_MAX);
> -	wsetup	=3D aemif_calc_rate(pdev, data->wsetup, clk_rate, WSETUP_MAX);
> +	timings.ta =3D aemif_calc_rate(pdev, data->ta, clk_rate);
> +	timings.rhold =3D aemif_calc_rate(pdev, data->rhold, clk_rate);
> +	timings.rstrobe =3D aemif_calc_rate(pdev, data->rstrobe, clk_rate);
> +	timings.rsetup =3D aemif_calc_rate(pdev, data->rsetup, clk_rate);
> +	timings.whold =3D aemif_calc_rate(pdev, data->whold, clk_rate);
> +	timings.wstrobe =3D aemif_calc_rate(pdev, data->wstrobe, clk_rate);
> +	timings.wsetup =3D aemif_calc_rate(pdev, data->wsetup, clk_rate);
>=20=20
> -	if (ta < 0 || rhold < 0 || rstrobe < 0 || rsetup < 0 ||
> -	    whold < 0 || wstrobe < 0 || wsetup < 0) {
> +	ret =3D aemif_check_cs_timings(&timings);
> +	if (ret) {
>  		dev_err(&pdev->dev, "%s: cannot get suitable timings\n",
>  			__func__);
> -		return -EINVAL;
> +		return ret;
>  	}
>=20=20
> -	set =3D TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
> -		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
> +	set =3D TA(timings.ta) |
> +		RHOLD(timings.rhold) | RSTROBE(timings.rstrobe) | RSETUP(timings.rsetu=
p) |
> +		WHOLD(timings.whold) | WSTROBE(timings.wstrobe) | WSETUP(timings.wsetu=
p);
>=20=20
>  	set |=3D (data->asize & ACR_ASIZE_MASK);
>  	if (data->enable_ew)

Otherwise lgtm.

Thanks,
Miqu=C3=A8l

