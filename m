Return-Path: <linux-kernel+bounces-317720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46396E2B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771EE1C2594C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB114188A2F;
	Thu,  5 Sep 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8rlVhPV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093812C7FB;
	Thu,  5 Sep 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563168; cv=none; b=D7n5IsGJQA48HwOcnM10yqqEQDSJ5stycZKI71x+QVO8duPZmDweMkm5FySDx3Tq/69YIMVhJE5Creb3s7dQfhrWzuIpoK62QvCgZ620AjkGgLkfmOfz0JxJusjqd8afXBN8+7n9LtKbRXX1xoAMFTVd1puZtRrylKnsrXcsOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563168; c=relaxed/simple;
	bh=p1NL4lA6aQW0dc7CsvZOuEyngKVleWJuJw8cqJv4U98=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bU2eI2uqD9vsatdKZd3ouCHVkmeTKwrBmVUoR7mkXDJAwWFcSjApwJGUyCCyci8++m2z7z/GpXHFwis+6uOr19aGiSLjJt7LJGp8YCy13RCMf4rUrixtJ6eaE7nEEKYEgmzsnqAm1sS6MxGOsBpy+7LXRUFUi6kFNhFNfBKHfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8rlVhPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B77C4CEC3;
	Thu,  5 Sep 2024 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563167;
	bh=p1NL4lA6aQW0dc7CsvZOuEyngKVleWJuJw8cqJv4U98=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=c8rlVhPVwANDway5HZx0uUdFWaP58i+hiQySG8m7Hpl2FNwo9V8oay7ADf0a65JOl
	 U9vC1F42lXWdWjmmlIq5wlAB2jNsyIZfUHRkafTpqYskJYDHh+Nz37uy/nnsKrMGVy
	 RPmzEkMtT6ZgQtXuDjLOvftbmafahfqKfbxD9+zsP0VdKbzshtxxWJ5i7RvU18+nPC
	 qwurTeTzMnB7l3+PMxDCWJYsZBKPoG6NB/wdvi5VtlEVCnM0Ao0Ks6chQqBYKS3sL/
	 5LdYLyTFH1MwWiAbqUT2+p44QUjyeO6BfJ5o9PZuMyKoK5BHZYNI/eEDl4dh76oPtJ
	 VYrC0ADWQQrXw==
Message-ID: <0161bb1640489c7a677ac26967b65ee1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240831111056.3864-7-hpausten@protonmail.com>
References: <20240831111056.3864-1-hpausten@protonmail.com> <20240831111056.3864-7-hpausten@protonmail.com>
Subject: Re: [PATCH 6/6] clk: clocking-wizard: move dynamic reconfig setup behind flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Thu, 05 Sep 2024 12:06:05 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-08-31 04:13:26)
> diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xil=
inx/clk-xlnx-clock-wizard.c
> index 1a65a7d153c35..967eacc28050d 100644
> --- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> @@ -1146,20 +1146,6 @@ static int clk_wzrd_probe(struct platform_device *=
pdev)
>         if (IS_ERR(clk_wzrd->base))
>                 return PTR_ERR(clk_wzrd->base);
> =20
> -       ret =3D of_property_read_u32(np, "xlnx,speed-grade", &clk_wzrd->s=
peed_grade);
> -       if (!ret) {
> -               if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade > =
3) {
> -                       dev_warn(&pdev->dev, "invalid speed grade '%d'\n",
> -                                clk_wzrd->speed_grade);
> -                       clk_wzrd->speed_grade =3D 0;
> -               }
> -       }
> -
> -       clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
> -       if (IS_ERR(clk_wzrd->clk_in1))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_in=
1),
> -                                    "clk_in1 not found\n");
> -
>         clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_acl=
k");
>         if (IS_ERR(clk_wzrd->axi_clk))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_cl=
k),
> @@ -1170,31 +1156,48 @@ static int clk_wzrd_probe(struct platform_device =
*pdev)
>                 return -EINVAL;
>         }
> =20
> -       ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs);
> -       if (ret)
> -               return ret;
> -
> -       clk_wzrd->clk_data.num =3D nr_outputs;
> -       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell=
_get, &clk_wzrd->clk_data);
> -       if (ret) {
> -               dev_err(&pdev->dev, "unable to register clock provider\n"=
);
> -               return ret;
> -       }
> +       if (of_property_read_bool(np, "xlnx,dynamic-reconfig")) {

Is this going to break the existing DTBs? Before the property existed,
the driver seems to have always tried to read xlnx,speed-grade and then
setup a notifier, etc. Why would xlnx,speed-grade be set if
xlnx,dynamic-reconfig wasn't set?

The binding has implicitly had xlnx,dynamic-reconfig set before this
patch, and we should strive to maintain that. Perhaps the property
should be inverted, i.e. xlnx,static-config, and the absence of that
property can imply the reconfig property.

