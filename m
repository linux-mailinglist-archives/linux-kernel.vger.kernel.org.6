Return-Path: <linux-kernel+bounces-260473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37BC93A9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7938C1F22521
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C61494D5;
	Tue, 23 Jul 2024 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3yvualI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F7148312;
	Tue, 23 Jul 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777394; cv=none; b=fKjYpEw/Pe6yf+5r042eLGwE5JJgwoh54hg5YOfKvc0fsGbDmfNIzMQh0uycCqAO22GDc4lsENZiGSrk3J1TSYKXolxUnN+omUg0L7RXIzuKk1leaOTsQXxBPTXILgB7Rk3NcsRYSKcBKd3xDmaHNXY97MY0A8ZJJwkvRzzhpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777394; c=relaxed/simple;
	bh=Tm9Wg4ZYS3BsEa6Y5aXqKa97xN1rGipxkXVPFSQTkWQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PDhiIxdOClvCsO6/7LntbF+RosKiM6auijsWwtNN9xqoaovgfUnoUfwJiUw/Pm/+orxZcYCd9OMO0+W6xcnfbCzb4fofTm7s6rw+CW4jd6pi1tZvcKOo6Y53zg6LyHVxR79NdWtfomyGgXx/jxd/LMsEB8Bd/6+v6FLdxBQtHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3yvualI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9694C4AF09;
	Tue, 23 Jul 2024 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721777394;
	bh=Tm9Wg4ZYS3BsEa6Y5aXqKa97xN1rGipxkXVPFSQTkWQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=P3yvualILhDdNmqGdpBTQFFuhBysGCft6KZ3Quq9gft47GW1p4JEOfBnPtrTPdljv
	 62CBE5z/NBOEW1CTWT7iCqEVzwkPEI4kuDeMhMGDYU8NMf2A5fPvfj4T3xlSVJgusR
	 19eM3gEaAoFuaHCI+Yal6FwnSivXjNWGtsCvmxVGpa8KzvBQb9pMBmIAtsI8aOXz/g
	 n4d8KrXVTMJMB/QRXS6Mpw6kPRumXJ6CJvKtomAQtUsB282vDfA0kLXu4ZxsFkny3h
	 qUWcg9Gvh/GBATnwPv308a3mkyKMqNYL05LiKm21A6TM4tARBYmMBNiFh4UeKMbhC+
	 Q4yT3Fu7jxqhA==
Message-ID: <1cacce63c7263a3532cca148ad2c567f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240720120048.36758-6-hpausten@protonmail.com>
References: <20240720120048.36758-1-hpausten@protonmail.com> <20240720120048.36758-6-hpausten@protonmail.com>
Subject: Re: [PATCH 5/7] clk: clocking-wizard: add user clock monitor support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Tue, 23 Jul 2024 16:29:51 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-07-20 05:01:53)
> Xilinx clocking wizard IP core supports monitoring of up to four
> optional user clock inputs, with a corresponding interrupt for
> notification in change of clock state (stop, underrun, overrun or
> glitch). Give userspace access to this monitor logic through use of the
> UIO framework.
>=20
> Use presence of the user monitor interrupt description in devicetree to
> indicate whether or not the UIO device should be registered. Also, this
> functionality is only supported from v6.0 onwards, so add indication of
> support to the device match data, in order to be tied to the utilised
> compatible string.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
> diff --git a/drivers/clk/xilinx/Kconfig b/drivers/clk/xilinx/Kconfig
> index 051756953558b..907a435694687 100644
> --- a/drivers/clk/xilinx/Kconfig
> +++ b/drivers/clk/xilinx/Kconfig
> @@ -21,6 +21,7 @@ config COMMON_CLK_XLNX_CLKWZRD
>         tristate "Xilinx Clocking Wizard"
>         depends on OF
>         depends on HAS_IOMEM
> +       depends on UIO

If I have a pre-v6.0 device I probably don't want UIO though. Perhaps
you should use the auxiliary bus framework to register a device that is
otherwise unused and then have the uio driver live in drivers/uio and
match that device made here. I think you can have 'imply UIO' if you
like to put a weak Kconfig dependency.

>         help
>           Support for the Xilinx Clocking Wizard IP core clock generator.
>           Adds support for clocking wizard and compatible.
> diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xil=
inx/clk-xlnx-clock-wizard.c
> index 7b262d73310fe..2d419e8ad4419 100644
> --- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> @@ -1165,6 +1209,17 @@ static int clk_wzrd_probe(struct platform_device *=
pdev)
>                 return -EINVAL;
>         }
> =20
> +       data =3D device_get_match_data(&pdev->dev);
> +       if (data && data->supports_monitor) {
> +               irq =3D platform_get_irq(pdev, 0);
> +               if (irq > 0) {
> +                       ret =3D clk_wzrd_setup_monitor(&pdev->dev, irq,
> +                                                    platform_get_resourc=
e(pdev, IORESOURCE_IO, 0));

Any reason this can't be

		ret =3D clk_wzrd_setup_monitor(pdev);
		if (ret)
			return ret;

and then all the surrounding code be moved into the function, including
the dev_err_probe()?

> +                       if (ret)
> +                               return dev_err_probe(&pdev->dev, ret, "fa=
iled to setup monitor\n");
> +               }
> +       }
> +
>         ret =3D of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);

