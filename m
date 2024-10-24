Return-Path: <linux-kernel+bounces-379445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065359ADEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C37A1F234CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162401CDA3A;
	Thu, 24 Oct 2024 08:11:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883C1CCEE7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757512; cv=none; b=f3IiodbW7KlirepzznHyCaEumeX0RzzGlAI+UyokaC0TR8UdYjoc2vZ19vVQmDlQjEBRhT+JXJMozlKQ4GBsJuH8A3529x+4QqS9NkSybx+LlVLKNMdUJyuc5R9Q4uD9yuIL7Zwoh2cCtNwda/1qzhoQAAVDP/UKFtD3XI+CiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757512; c=relaxed/simple;
	bh=iEtDk6ICkLZjMb0ULHFCOjGx1/Kb0nchCQX0IFvx1SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTtPLTbcbhgm2DlFv7dkwWb8yVXVPUAwHEbUxrjcjyxQ9pQwk5rC6TSp58UWaswXbtmqPjZvqJmB/w2UFjMVlSCvI4F4ak/HtAEJcwfe7q9WctpYtdpdCsKVxqcJAKOTCe0FSNxsIDx4RM6MajuXeATFtXQCAHJWmai8SUD4cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3swS-00065c-Ug; Thu, 24 Oct 2024 10:11:36 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3swR-000AFt-14;
	Thu, 24 Oct 2024 10:11:35 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3swR-0002GS-0q;
	Thu, 24 Oct 2024 10:11:35 +0200
Message-ID: <83b9d2855f9513b2431fe31c43a992eb952f9b05.camel@pengutronix.de>
Subject: Re: [PATCH 02/10] dma-engine: sun4i: Add has_reset option to quirk
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Cs=F3k=E1s=2C?= Bence <csokas.bence@prolan.hu>, 
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Chen-Yu Tsai
	 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	 <samuel@sholland.org>
Date: Thu, 24 Oct 2024 10:11:35 +0200
In-Reply-To: <20241024064931.1144605-3-csokas.bence@prolan.hu>
References: <20241024064931.1144605-3-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-10-24 at 08:49 +0200, Cs=C3=B3k=C3=A1s, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> has this bit but in order to support suniv we need to add it. So add
> support for reset bit.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/dma/sun4i-dma.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 5efbed7c546f..0b99b3884971 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> =20
> @@ -159,6 +160,7 @@ struct sun4i_dma_config {
>  	u8 ddma_drq_sdram;
> =20
>  	u8 max_burst;
> +	bool has_reset;
>  };
> =20
>  struct sun4i_dma_pchan {
> @@ -208,6 +210,7 @@ struct sun4i_dma_dev {
>  	int				irq;
>  	spinlock_t			lock;
>  	const struct sun4i_dma_config *cfg;
> +	struct reset_control *rst;
>  };
> =20
>  static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
> @@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(priv->clk);
>  	}
> =20
> +	if (priv->cfg->has_reset) {
> +		priv->rst =3D devm_reset_control_get_exclusive(&pdev->dev,
> +							       NULL);

Aligning to open parenthesis will make checkpatch --strict happy.

> +		if (IS_ERR(priv->rst)) {
> +			dev_err(&pdev->dev, "Failed to get reset control\n");

Consider using dev_err_probe() here.

> +			return PTR_ERR(priv->rst);
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, priv);
>  	spin_lock_init(&priv->lock);
> =20
> @@ -1287,6 +1299,16 @@ static int sun4i_dma_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> +	/* Deassert the reset control */
> +	if (priv->rst) {
> +		ret =3D reset_control_deassert(priv->rst);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to deassert the reset control\n");
> +			goto err_clk_disable;
> +		}
> +	}

You can just call reset_control_deassert() unconditionally, it accepts
a NULL parameter:

  https://docs.kernel.org/driver-api/reset.html#c.reset_control_deassert


regards
Philipp

