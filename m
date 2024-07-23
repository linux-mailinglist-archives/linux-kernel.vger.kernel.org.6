Return-Path: <linux-kernel+bounces-260465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2F93A9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59352831A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5641494B9;
	Tue, 23 Jul 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwSMX40Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7013D52B;
	Tue, 23 Jul 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776493; cv=none; b=f+SwDwk+tRhk0mllRSXGboIPAvZG2D4PocUJbyHhy+QetM4r5ZFcJjCH5EcooUSG+NAEkzt6zD4mqrcB0HQ+K8aCqA/JHANLAYTwKNQfly07Je1MXmfKYPKpwqGtovjrq4dXgV9RZcq8nOGx07zxxyX4pPRRvqxC5nW6e2dqMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776493; c=relaxed/simple;
	bh=1pFvVOYdC3aG8zafwOAeBQz7+yiKYaLx3PgD1yCE4yY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gisfKvS9oR6KGk9j/RCj0P9MehfFOTNaxYFw5xzPZc7lZ2hUtzGHAk2383oRnXz2+wf0lB1KhAEzMQYpVwJd1r/6kFYzpVBfcrLY3MWg35wESHzzZbTdiZ/aBqhWNjB6MQAej4pcW3nwnGfpjWDzjTazU1hiCjqQBzk+gY7MJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwSMX40Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F61C4AF0A;
	Tue, 23 Jul 2024 23:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721776492;
	bh=1pFvVOYdC3aG8zafwOAeBQz7+yiKYaLx3PgD1yCE4yY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UwSMX40ZQhju15eYYxKsc/VCfDx0/F18eNe3DNl8NKRZ8DFP3D6ambxC94LKSghnN
	 OGqcUCdjdWnnJT6r7y+lpTLYUA5l4lDga2ux7r8I0E/f4y08FzKn5odoh4JJQa3c/f
	 iQoS8lWPTKaGUCxbtvAP0piDmLjBIMqsdHdZRuoyFfUz0g+zLWy172iPIfsmGTTWMb
	 pfje9z1O/xAq1CXVKUxKnDZ5OreOM8B8kAILKcPk4elCtgvnGt56zeOl76xGbLdxJa
	 lsxltH3gxMBPtV7X+f5FO/1Rh6d25Oc8J07JzOanadkXnBwldHcWhpiM9CVJ+PWGme
	 vmvwybi3IV0ng==
Message-ID: <d02cd87b7a52067d6eb9b4ef3c5b7803.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240720120048.36758-3-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com> <20240720120048.36758-3-hpausten@protonmail.com>
Subject: Re: [PATCH 2/7] clk: clocking-wizard: use newer clk_hw API
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Tue, 23 Jul 2024 16:14:50 -0700
User-Agent: alot/0.10

General comment: do one thing in one patch, i.e. use clk_hw API and
don't also migrate to devm in one patch.

Quoting Harry Austen (2024-07-20 05:01:36)
> diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xil=
inx/clk-xlnx-clock-wizard.c
> index 0ca045849ea3e..30c5cc9dcd7e9 100644
> --- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>

What is this include for? __counted_by()?

>  #include <linux/err.h>
>  #include <linux/iopoll.h>
> =20
> @@ -121,24 +122,22 @@ enum clk_wzrd_int_clks {
>  /**
>   * struct clk_wzrd - Clock wizard private data structure
>   *
> - * @clk_data:          Clock data
> + * @clk_data:          Output clock data
>   * @nb:                        Notifier block
>   * @base:              Memory base
>   * @clk_in1:           Handle to input clock 'clk_in1'
>   * @axi_clk:           Handle to input clock 's_axi_aclk'
>   * @clks_internal:     Internal clocks
> - * @clkout:            Output clocks
>   * @speed_grade:       Speed grade of the device
>   * @suspended:         Flag indicating power state of the device
>   */
>  struct clk_wzrd {
> -       struct clk_onecell_data clk_data;
> +       struct clk_hw_onecell_data *clk_data;

It could be placed at the end and then one allocation could be used
instead of two.

>         struct notifier_block nb;
>         void __iomem *base;
>         struct clk *clk_in1;
>         struct clk *axi_clk;
> -       struct clk *clks_internal[wzrd_clk_int_max];
> -       struct clk *clkout[WZRD_NUM_OUTPUTS];
> +       struct clk_hw *clks_internal[wzrd_clk_int_max];
>         unsigned int speed_grade;
>         bool suspended;
>  };
> @@ -1108,35 +1110,32 @@ static int clk_wzrd_probe(struct platform_device =
*pdev)
>                 if (!div)
>                         div =3D 1;
> =20
> -               clk_mul_name =3D __clk_get_name(clk_wzrd->clks_internal[w=
zrd_clk_mul]);
> +               clk_mul_name =3D clk_hw_get_name(clk_wzrd->clks_internal[=
wzrd_clk_mul]);
>                 clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D
> -                       clk_register_fixed_factor(&pdev->dev, clk_name,
> -                                                 clk_mul_name, 0, 1, div=
);
> +                       clk_hw_register_fixed_factor(&pdev->dev, clk_name,
> +                                                    clk_mul_name, 0, 1, =
div);
>         } else {
>                 ctrl_reg =3D clk_wzrd->base + WZRD_CLK_CFG_REG(is_versal,=
 0);
> -               clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D clk_registe=
r_divider
> +               clk_wzrd->clks_internal[wzrd_clk_mul_div] =3D clk_hw_regi=
ster_divider

Are these going to be using devm so that on failure they get
unregistered?

>                         (&pdev->dev, clk_name,
> -                        __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_=
mul]),
> +                        clk_hw_get_name(clk_wzrd->clks_internal[wzrd_clk=
_mul]),
>                         flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
>                         CLK_DIVIDER_ALLOW_ZERO, &clkwzrd_lock);
>         }
>         if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
>                 dev_err(&pdev->dev, "unable to register divider clock\n");
> -               ret =3D PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]=
);
> -               goto err_rm_int_clk;
> +               return PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
>         }

