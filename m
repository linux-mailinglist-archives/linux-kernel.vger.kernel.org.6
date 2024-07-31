Return-Path: <linux-kernel+bounces-269920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3D9438C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0180283F79
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676516D9A8;
	Wed, 31 Jul 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT98GRI5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69FF14B097;
	Wed, 31 Jul 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464640; cv=none; b=RmGKBkkj9cGKwNOpk0QdLTFWzg2uJ56pT3+hsE1s2Gs+TRlgXQCIfYwOG7JI1STrs6KWOxQ8O4sbx+MJymYy5a4sNxSxFn35fQ2isMUB3zCjab4iFOJLOixvzMgslDTeRrK6iMpvNi7EwsJaJLbYp1SH4HgXeqIY/g1G9SnHR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464640; c=relaxed/simple;
	bh=QsT31Zg0FepZe7IrujgLwIvh6PObB4FX6lPGNIPazLE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=E44KyQ+ZiPVQ4alA2wcBJrtgeGD/ew8ApzF2doGqy0cORd1K3SYJZFSPD+NePmIWrBAKW2kYsqVdvbbZgD8TTnQYswh/1h4UfS/P6qRqms13DS1oKGSbvTDrhuVo9he2s8chPGT4TuKYstTtJzhxVSwSYgkbKY3rQHZpidxXAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT98GRI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A75CC116B1;
	Wed, 31 Jul 2024 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722464639;
	bh=QsT31Zg0FepZe7IrujgLwIvh6PObB4FX6lPGNIPazLE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IT98GRI5DTAD2bVKJCrGZBoyuLtacyei+1w/E3Pg+poMCdhSWavI4gTkaW8Rgi9aL
	 QA/a4RVFEklRBcrPHQeiXuWTWCZY8lTCgQLIIvOMVcvhHGOD1dDUAN+pl5aYkZ+yEj
	 +qtJCcYqud8+dEpyo4CvtPw2/vRPk2PI0iIE1on+OtGYWwg6C/0/jZephUzpF40rel
	 v8fbzYhdbCrmJhaJMJHQEgKN1FszJxBp5HFESKHXsvC1P1iYb0rrhrHJL46u2fL7ds
	 IM1VCxOfBzbvtyxK5uAhoKrmm6cJotHHyPSgSDE5Mp48isy4gO9b+uKP/79NFJp6jC
	 0Hjx/b6SAMlOw==
Message-ID: <08ed1ae35b69e11e69ce178af41c77b0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240730-clk-u64-v3-2-4d2b19edaa6e@nxp.com>
References: <20240730-clk-u64-v3-0-4d2b19edaa6e@nxp.com> <20240730-clk-u64-v3-2-4d2b19edaa6e@nxp.com>
Subject: Re: [PATCH v3 2/2] clk: clk-conf: support assigned-clock-rates-u64
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Date: Wed, 31 Jul 2024 15:23:57 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-07-30 01:57:55)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 System Management Control Firmware(SCMI) manages the clock
> function, it exposes PLL VCO which could support up to 5GHz rate that
> exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
> to set rate that exceeds UINT32_MAX.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-conf.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 058420562020..684e0c0738b3 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -81,11 +81,44 @@ static int __set_clk_parents(struct device_node *node=
, bool clk_supplier)
>  static int __set_clk_rates(struct device_node *node, bool clk_supplier)
>  {
>         struct of_phandle_args clkspec;
> -       int rc, index =3D 0;
> +       int rc, count, index;
>         struct clk *clk;
> -       u32 rate;
> +       u32 *rates __free(kfree);
> +       bool rate_64 =3D false;
> +
> +       count =3D of_property_count_u64_elems(node, "assigned-clock-rates=
-u64");
> +       if (count <=3D 0) {
> +               count =3D of_property_count_u32_elems(node, "assigned-clo=
ck-rates");
> +               if (count <=3D 0)
> +                       return 0;
> +
> +               rates =3D kcalloc(count, sizeof(u32), GFP_KERNEL);
> +               if (!rates)
> +                       return -ENOMEM;
> +               rc =3D of_property_read_variable_u32_array(node,
> +                                                        "assigned-clock-=
rates",
> +                                                        rates,
> +                                                        1, count);
> +       } else {
> +               rates =3D kcalloc(count, sizeof(u64), GFP_KERNEL);
> +               if (!rates)
> +                       return -ENOMEM;
> +               rc =3D of_property_read_variable_u64_array(node,
> +                                                        "assigned-clock-=
rates-u64",
> +                                                        (u64 *)rates,
> +                                                        1, count);
> +               rate_64 =3D true;
> +       }

Can this be less indented somehow?

	u64 *rates_64 __free(kfree) =3D NULL;
	u32 *rates __free(kfree) =3D NULL;
	int count_64, count;

	count =3D of_property_count_u32_elems(node, "assigned-clock-rates");
	count_64 =3D of_property_count_u64_elems(node, "assigned-clock-rates-u64");
	if (count_64 > 0) {
		count =3D count_64;
		rates_64 =3D kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
		if (!rates_64)
			return -ENOMEM;

		rc =3D of_property_read_u64_array(node,
						"assigned-clock-rates-u64",
						rates_64, count);
	} else if (count > 0) {
		rates =3D kcalloc(count, sizeof(*rates), GFP_KERNEL));
		if (!rates)
			return -ENOMEM;

		rc =3D of_property_read_u32_array(node, "assigned-clock-rates",
						rates, count);
	} else {
		return 0;
	}
=09
	if (rc)
		return rc;

	for (index =3D 0; index < count; index++) {
		unsigned long rate;

		if (rates_64)
			rate =3D rates_64[index];
		else
			rate =3D rates[index];

> +
> +
> +       for (index =3D 0; index < count; index++) {
> +               unsigned long rate;
> +
> +               if (rate_64)
> +                       rate =3D ((u64 *)rates)[index];

Please no casts.

> +               else
> +                       rate =3D rates[index];
>

