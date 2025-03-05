Return-Path: <linux-kernel+bounces-547851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F1A50E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2847A340B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF14266565;
	Wed,  5 Mar 2025 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLIGTT6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90B2E3373;
	Wed,  5 Mar 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212668; cv=none; b=VJaaftsgoAzuF+ctJ38/ptu6Joq/HFvQtO2g3i3caA1c4ejznqD1Zo/QeyOE23nbZJKsrvKW6TOEY5hvD/2lEO8DX8kLR1e/ta7GCAOHUSyDaby3xcb2qLmOrN6GaW/+JZBL367+45CNfRJPqltH89ub7QwukQ+ndgmZaaQ45V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212668; c=relaxed/simple;
	bh=y6Ws4y70AqcP1/f67iogQtv83NKMfTTp5b+XJn86ADU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=RgdTwT2bbxhAVjuNGz+XMJf186lepfZ9Zs52OA6sON9U0maN9QYXuW+cS1H4eVNIdVtSgFAsI5IkmGttI9p8x1ttQRPpV1BLJj/elhVzcrLCtpdkkSZbMUQVFc5MI2RsykPytVVWGCOuGiZShfsU+TcWumYxSAyjkmq7tRvL5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLIGTT6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10BDC4CED1;
	Wed,  5 Mar 2025 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212668;
	bh=y6Ws4y70AqcP1/f67iogQtv83NKMfTTp5b+XJn86ADU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uLIGTT6ix0ytcNmFy0dOGwGhLC1am2boVh5F9hgPpTDAAK9HuP3BXUAVe7vPTVPYy
	 aegKx0eanzBcLdr07sOfMAD61JvuBTvlDSm0cedec7kQn9JOA8BvC9CpZsYU8eeJNP
	 9gVjPHoDjkIfAs08a+8jw9T54iUbEqV1h519k+Xur07Qc0YENUop7qT1Zi0JREWGau
	 LPrFDelNuAutQPb7A/Ah8ig73GVnpjxAdAX1SQOQWJUdRUea9ZV51Npoet1jzBf1gT
	 DOFJCFvVKMMv+Zd6lnh3c1/DjSpkXRo2fjJJynV8LTuUjTa0LN8nHAMYWfcoyUZxe8
	 VT1c99Zb4ouPQ==
Message-ID: <f17372963b92074144b07d34f3e91ba7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250305-spmi-v1-2-c98f561fa99f@gmail.com>
References: <20250305-spmi-v1-0-c98f561fa99f@gmail.com> <20250305-spmi-v1-2-c98f561fa99f@gmail.com>
Subject: Re: [PATCH 2/3] spmi: add a spmi driver for Apple SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sasha Finkelstein <fnkl.kernel@gmail.com>, Jean-Francois Bortolotti <jeff@borto.fr>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Conor Dooley <conor+dt@kernel.org>, Janne Grunau <j@jannau.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>, Sven Peter <sven@svenpeter.dev>, fnkl.kernel@gmail.com
Date: Wed, 05 Mar 2025 14:11:05 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Sasha Finkelstein via B4 Relay (2025-03-05 12:26:40)
> From: Jean-Francois Bortolotti <jeff@borto.fr>
>=20

Please write some commit text explaining why this driver is important to
review. Maybe it's necessary for something to work?

> diff --git a/drivers/spmi/spmi-apple-controller.c b/drivers/spmi/spmi-app=
le-controller.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..194fa5dd7c2c6fc4ecfbee0db=
7930b0c73b02550
> --- /dev/null
> +++ b/drivers/spmi/spmi-apple-controller.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple SoC SPMI device driver
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Inspired by:
> + *             OpenBSD support Copyright (c) 2021 Mark Kettenis <ketteni=
s@openbsd.org>
> + *             Correllium support Copyright (C) 2021 Corellium LLC
> + *             hisi-spmi-controller.c
> + *             spmi-pmic-ard.c Copyright (c) 2021, The Linux Foundation.

spmi-pmic-arb?

> + */
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>

Are these includes used? I think you need mod_devicetable.h

> +#include <linux/platform_device.h>
> +#include <linux/spmi.h>
> +
> +/* SPMI Controller Registers */
> +#define SPMI_STATUS_REG 0
> +#define SPMI_CMD_REG 0x4
> +#define SPMI_RSP_REG 0x8
> +
> +#define SPMI_RX_FIFO_EMPTY BIT(24)
> +
> +#define REG_POLL_INTERVAL 10000
> +#define REG_POLL_TIMEOUT (REG_POLL_INTERVAL * 5)
> +
> +struct apple_spmi {
> +       void __iomem *regs;
> +};
> +
> +#define poll_reg(spmi, reg, val, cond) \
> +       readl_relaxed_poll_timeout((spmi)->regs + (reg), (val), (cond), \
> +                                  REG_POLL_INTERVAL, REG_POLL_TIMEOUT)
> +
> +static inline u32 read_reg(struct apple_spmi *spmi, int offset)
> +{
> +       return readl_relaxed(spmi->regs + offset);
> +}
> +
> +static inline void write_reg(u32 value, struct apple_spmi *spmi, int off=
set)
> +{
> +       writel_relaxed(value, spmi->regs + offset);
> +}

I'm not a huge fan of these wrappers but OK. Why relaxed accessors?

> +
> +static int spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
> +                        u16 saddr, u8 *__buf, size_t bc)

Drop the underscore because the variable 'buf' is never used.

> +{
> +       struct apple_spmi *spmi =3D spmi_controller_get_drvdata(ctrl);
> +       u32 spmi_cmd =3D opc | sid << 8 | saddr << 16 | (bc - 1) | (1 << =
15);

Can this be some function like apple_spmi_pack_cmd()? I suspect 'bc' is
byte_count? Usually we just call that 'len'.

> +       u32 rsp;
> +       u32 status;
> +       size_t len_to_read =3D 0;

len_to_read would imply that it is non-zero to start. Maybe 'len_read'
past tense, or decrement 'bc'.

> +       u8 i;
> +       int ret;
> +
> +       write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +
> +       /* Wait for Rx FIFO to have something */
> +       ret =3D poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_R=
X_FIFO_EMPTY));
> +       if (ret) {
> +               dev_err(&ctrl->dev,
> +                       "%s:Failed to wait for RX FIFO not empty\n", __fu=
nc__);
> +               return ret;
> +       }

This chunk is the same. Maybe have apple_spmi_wait_for_rx_fifo() that
does everything including the error message?

> +
> +       /* Discard SPMI reply status */
> +       read_reg(spmi, SPMI_RSP_REG);
> +
> +       /* Read SPMI data reply */
> +       while (len_to_read < bc) {
> +               rsp =3D read_reg(spmi, SPMI_RSP_REG);
> +               i =3D 0;
> +               while ((len_to_read < bc) && (i < 4)) {
> +                       __buf[len_to_read++] =3D ((0xff << (8 * i)) & rsp=
) >>
> +                                              (8 * i);
> +                       i +=3D 1;
> +               }

Is this ioread32_rep()?

> +       }
> +
> +       return 0;
> +}
> +
> +static int spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
> +                         u16 saddr, const u8 *__buf, size_t bc)
> +{
> +       struct apple_spmi *spmi =3D spmi_controller_get_drvdata(ctrl);
> +       u32 spmi_cmd =3D opc | sid << 8 | saddr << 16 | (bc - 1) | (1 << =
15);
> +       u32 status;
> +       size_t i =3D 0, j;
> +       int ret;
> +
> +       write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +
> +       while (i < bc) {
> +               j =3D 0;
> +               spmi_cmd =3D 0;
> +               while ((j < 4) & (i < bc))
> +                       spmi_cmd |=3D __buf[i++] << (j++ * 8);

Is this iowrite32_rep()? Perhaps unaligned sizes have to be dealt with,
but otherwise I suspect it would be more efficient to use
iowrite32_rep() until the number of bytes is less than 4 and then do the
one extra pack.

> +
> +               write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +       }
> +
> +       /* Wait for Rx FIFO to have something */
> +       ret =3D poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_R=
X_FIFO_EMPTY));
> +       if (ret) {
> +               dev_err(&ctrl->dev,
> +                       "%s:Failed to wait for RX FIFO not empty\n", __fu=
nc__);
                             ^
Please put a space after  ---|

> +               return ret;
> +       }
> +
> +       /* Discard */
> +       read_reg(spmi, SPMI_RSP_REG);
> +
> +       return 0;
> +}
> +
> +static int spmi_controller_probe(struct platform_device *pdev)
> +{
> +       struct apple_spmi *spmi;
> +       struct spmi_controller *ctrl;
> +       int ret;
> +
> +       ctrl =3D devm_spmi_controller_alloc(&pdev->dev, sizeof(*spmi));
> +       if (IS_ERR(ctrl)) {
> +               dev_err_probe(&pdev->dev, PTR_ERR(ctrl),
> +                             "Can't allocate spmi_controller data\n");

This is likely redundant given that the spmi core API prints errors. I
could see a patch that moves to dev_err_probe() there.

> +               return -ENOMEM;
> +       }
> +
> +       spmi =3D spmi_controller_get_drvdata(ctrl);
> +
> +       spmi->regs =3D devm_platform_ioremap_resource(pdev, 0);

This already prints an error message so the dev_err_probe() later is
redundant. Please remove.

> +       if (IS_ERR(spmi->regs)) {
> +               dev_err_probe(&pdev->dev, PTR_ERR(spmi->regs),
> +                             "Can't get ioremap regs\n");
> +               return PTR_ERR(spmi->regs);
> +       }
> +
> +       ctrl->dev.of_node =3D of_node_get(pdev->dev.of_node);

Drop the of_node_get(), especially because it never gets put.

> +
> +       ctrl->read_cmd =3D spmi_read_cmd;
> +       ctrl->write_cmd =3D spmi_write_cmd;
> +
> +       ret =3D devm_spmi_controller_add(&pdev->dev, ctrl);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "spmi_controller_add failed with error %d!\n", re=
t);

Use 'return dev_err_probe()'?

> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id spmi_controller_match_table[] =3D {
> +       { .compatible =3D "apple,spmi", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
> +
> +static struct platform_driver spmi_controller_driver =3D {

How about apple_spmi_driver?

> +       .probe          =3D spmi_controller_probe,

And apple_spmi_probe?

> +       .driver         =3D {
> +               .name   =3D "apple-spmi",
> +               .of_match_table =3D spmi_controller_match_table,

And apple_spmi_match_table?

> +       },
> +};
> +module_platform_driver(spmi_controller_driver);

