Return-Path: <linux-kernel+bounces-538512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC13A49989
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB993BDB44
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0F26D5CF;
	Fri, 28 Feb 2025 12:38:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4326B962
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746308; cv=none; b=Qia8NLUrBBvEHb+0BTO4HgrCuiC6bXt6QixRLO3YSa+xcD2GTu9mcKcjiuA/W3v4UlmIMtaRDysVE+XVqIT4gy0DQodc7lnhUGHPk4whWZo2BZlXpxE/8vjza3rUJYKUa0hNsz20FSBOglsP3z0h0lSE6jTGzA1INl12MAQAKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746308; c=relaxed/simple;
	bh=DZD875o1zR1JJ32xiqYTydGWJqFSjevYCUQv5vmvk8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VR1NhhLxkmrzHRfF8Za6LlpFkJwwP21+0oJWAlVx5kZ08w4+yFMOZH3jaAjFguOj7sG+vvQ3jFXn41uQPOO0c8tA4kRSe+tE/03E7LeGUzh6iGz89WlCTWtlxMv9FAH47bV1GWyzQvkto2ZbrgUwCPHVbFgPqY86YI2k6AIwaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd6-0000H9-Kc; Fri, 28 Feb 2025 13:38:12 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd5-003IOz-2H;
	Fri, 28 Feb 2025 13:38:11 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tnzd5-0007Cv-20;
	Fri, 28 Feb 2025 13:38:11 +0100
Message-ID: <c965906ea8797385399534e974cabdba5564ae0f.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stefan Eichenberger <eichest@gmail.com>, vkoul@kernel.org, 
	kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tharvey@gateworks.com, 
	hongxing.zhu@nxp.com, francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
	Eichenberger <stefan.eichenberger@toradex.com>
Date: Fri, 28 Feb 2025 13:38:11 +0100
In-Reply-To: <20250228103959.47419-2-eichest@gmail.com>
References: <20250228103959.47419-1-eichest@gmail.com>
	 <20250228103959.47419-2-eichest@gmail.com>
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

On Fr, 2025-02-28 at 11:38 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> Remove the switch statement and base perst release on whether it is
> found in the device tree. The probe function fails without the reset
> property, making it mandatory. Therefore, always release reset
> independent of the variant.
>=20
> This does not change the behavior of the driver but reduces driver
> complexity and allows for easier future modifications.
>=20
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/fre=
escale/phy-fsl-imx8m-pcie.c
> index e98361dcdeadf..00f957a42d9dc 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -141,15 +141,11 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
>  			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
>  	usleep_range(100, 200);
> =20
> -	switch (imx8_phy->drvdata->variant) {
> -	case IMX8MP:
> +	if (imx8_phy->perst)

This check is not necessary, reset_control_deassert(NULL) is a no-op:

>  		reset_control_deassert(imx8_phy->perst);

regards
Philipp

