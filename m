Return-Path: <linux-kernel+bounces-519029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04504A39745
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCDE3A166C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748622E418;
	Tue, 18 Feb 2025 09:36:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D722AE42
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871360; cv=none; b=uP4ww7DgkVK0skeZBUDeitdwEICYNWgDEZdXO3nr9bYxTfdDs3SiS5ZZK8mBUNSouhscqo68b4aByeP6r8f2Cl1aEROdYmdZZJbdij30Rju6hxMbCTfvD/fg/LD69KZKXZ6/jhmVsxrLdJm156lo/oO/GG0bnaW034YvNO7SQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871360; c=relaxed/simple;
	bh=uroR9tsECRwwrTrCr7ptIn53F42JTiUwXr1bXKvg5jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmU9NAE6Il4y2QgJT0FEzrZ+S6ZdSvwM7hfPCn5THDsfSVYQ+z57a5rSrrJjso6DuYQ7nVb/vd3Du5cNxZbcvEOkmIO4SvI/6oQ7nfyAWDRBgw5M9lMWGkLoFa/YzATQWxS3ubV0yh1i8akA5WgcXX9cdD/NQKrlPBBeRdJtESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkK1C-000388-9r; Tue, 18 Feb 2025 10:35:54 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkK1C-001Z42-07;
	Tue, 18 Feb 2025 10:35:54 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkK1B-0003co-37;
	Tue, 18 Feb 2025 10:35:53 +0100
Message-ID: <50c7055a676fb7f1bf27cb33a914df641c56dd15.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] imx_dsp_rproc: Use reset controller API to control
 the DSP
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org, 
	mathieu.poirier@linaro.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andersson@kernel.org, 
	linux-remoteproc@vger.kernel.org, iuliana.prodan@nxp.com, 
	laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, Frank.Li@nxp.com, 
	krzk@kernel.org
Date: Tue, 18 Feb 2025 10:35:53 +0100
In-Reply-To: <20250218085712.66690-6-daniel.baluta@nxp.com>
References: <20250218085712.66690-1-daniel.baluta@nxp.com>
	 <20250218085712.66690-6-daniel.baluta@nxp.com>
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

On Di, 2025-02-18 at 10:57 +0200, Daniel Baluta wrote:
> Use the reset controller API to control the DSP on i.MX8MP. This way
> we can have a better control of the resources and avoid using a syscon
> to access the audiomix bits.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
>  drivers/remoteproc/imx_rproc.h     |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_=
dsp_rproc.c
> index ea5024919c2f..2b97e4d0bb9e 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
> =20
>  #include "imx_rproc.h"
> @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
>   */
>  struct imx_dsp_rproc {
>  	struct regmap				*regmap;
> +	struct reset_control			*reset;
>  	struct rproc				*rproc;
>  	const struct imx_dsp_rproc_dcfg		*dsp_dcfg;
>  	struct clk_bulk_data			clks[DSP_RPROC_CLK_MAX];
> @@ -192,9 +194,7 @@ static int imx8mp_dsp_reset(struct imx_dsp_rproc *pri=
v)
>  	/* Keep reset asserted for 10 cycles */
>  	usleep_range(1, 2);
> =20
> -	regmap_update_bits(priv->regmap, IMX8M_AudioDSP_REG2,
> -			   IMX8M_AudioDSP_REG2_RUNSTALL,
> -			   IMX8M_AudioDSP_REG2_RUNSTALL);
> +	reset_control_assert(priv->reset);
> =20
>  	/* Take the DSP out of reset and keep stalled for FW loading */
>  	pwrctl =3D readl(dap + IMX8M_DAP_PWRCTL);
> @@ -231,13 +231,9 @@ static int imx8ulp_dsp_reset(struct imx_dsp_rproc *p=
riv)
> =20
>  /* Specific configuration for i.MX8MP */
>  static const struct imx_rproc_dcfg dsp_rproc_cfg_imx8mp =3D {
> -	.src_reg	=3D IMX8M_AudioDSP_REG2,
> -	.src_mask	=3D IMX8M_AudioDSP_REG2_RUNSTALL,
> -	.src_start	=3D 0,
> -	.src_stop	=3D IMX8M_AudioDSP_REG2_RUNSTALL,
>  	.att		=3D imx_dsp_rproc_att_imx8mp,
>  	.att_size	=3D ARRAY_SIZE(imx_dsp_rproc_att_imx8mp),
> -	.method		=3D IMX_RPROC_MMIO,
> +	.method		=3D IMX_RPROC_RESET_CONTROLLER,
>  };
> =20
>  static const struct imx_dsp_rproc_dcfg imx_dsp_rproc_cfg_imx8mp =3D {
> @@ -329,6 +325,9 @@ static int imx_dsp_rproc_start(struct rproc *rproc)
>  					  true,
>  					  rproc->bootaddr);
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		ret =3D reset_control_deassert(priv->reset);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -369,6 +368,9 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
>  					  false,
>  					  rproc->bootaddr);
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		ret =3D reset_control_assert(priv->reset);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -995,6 +997,13 @@ static int imx_dsp_rproc_detect_mode(struct imx_dsp_=
rproc *priv)
> =20
>  		priv->regmap =3D regmap;
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		priv->reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);

Is this optional on purpose? There is no mention of it in the commit
message. Where is this resets property documented in the dt-bindings?

regards
Philipp

