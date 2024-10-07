Return-Path: <linux-kernel+bounces-354018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80B99365E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF9284587
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634C61DE2B7;
	Mon,  7 Oct 2024 18:38:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570C1D968B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326325; cv=none; b=HjEHjcFmtCFZcJYanrg088FQSXJb0Ed9c/pG5/3i83rb6BDRvXQqjM0dRm0ThbXcRi8qoJZIS8g8fkOmSr4xS8s403lN4dSKLkf/dUTbgDixNns4B+AnO0RDAf3Ejk69wdQdYioatimGM19US0Vn707HU+aUD/vlzJ6EwDgIpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326325; c=relaxed/simple;
	bh=9jIL+IjkLa+hMpPrfFmcBtuUIwPdDGjfk1jAeg8yMbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieo/nQE+iB1GKwPg4zoTG3wv1vLedTwFr3fHKO3rfmPIrxQW2CdIYfSSdWg2cEPz8YDTPQ8yVR/3Wj2B43Ms3yRC2RbyECCvgmtlZCEXqBeIWLgTvSg8U73PBxDkgiy28DRH6ei4WNjjiJHLhrcBIgdWc6X15U1Nrg1xTmeRFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sxscl-0001Nm-Un; Mon, 07 Oct 2024 20:38:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sxsck-000BlJ-KA; Mon, 07 Oct 2024 20:38:26 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sxsck-00GK17-1h;
	Mon, 07 Oct 2024 20:38:26 +0200
Date: Mon, 7 Oct 2024 20:38:26 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phy: disable eee due to errata on various
 KSZ switches
Message-ID: <ZwQqokf15iMEIrAf@pengutronix.de>
References: <20241007174211.3511506-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007174211.3511506-1-tharvey@gateworks.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2024 at 10:42:11AM -0700, Tim Harvey wrote:
> The well-known errata regarding EEE not being functional on various KSZ
> switches has been refactored a few times. Recently the refactoring has
> excluded several switches that the errata should also apply to.
> 
> Disable EEE for additional switches with this errata.
> 
> The original workaround for the errata was applied with a register
> write to manually disable the EEE feature in MMD 7:60 which was being
> applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> 
> Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
> fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
> remove KSZ9477 PHY errata handling") which moved the errata from the
> switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> however that PHY code was dead code because an entry was never added
> for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.
> 
> This was apparently realized much later and commit ("54a4e5c16382 net:
> phy: micrel: add Microchip KSZ 9477 to the device table") added the
> PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
> applied to PHY_ID_KSZ9477 it's not completely clear what switches
> that relates to.
> 
> Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
> after suspend/resume") breaks this again for all but KSZ9897 by only
> applying the errata for that PHY ID.
> 
> The most recent time this was affected was with commit ("08c6d8bae48c
> net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
> removes the blatant register write to MMD 7:60 and replaces it by
> setting phydev->eee_broken_modes = -1 so that the generic phy-c45 code
> disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).
> 
> Fixes: 08c6d8bae48c ("net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v3: added missing fixes tag
> v2: added fixes tag and history of issue
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b074b4bb0629..d2bd82a1067c 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2578,11 +2578,19 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
>  		if (!port)
>  			return MICREL_KSZ8_P1_ERRATA;
>  		break;
> +	case KSZ8795_CHIP_ID:
> +	case KSZ8794_CHIP_ID:
> +	case KSZ8765_CHIP_ID:
> +		/* KSZ87xx DS80000687C Module 2 */
> +	case KSZ9896_CHIP_ID:
> +		/* KSZ9896 Errata DS80000757A Module 2 */
> +	case KSZ9897_CHIP_ID:
> +		/* KSZ9897 Errata DS00002394C Module 4 */
> +	case KSZ9567_CHIP_ID:
> +		/* KSZ9567 Errata DS80000756A Module 4 */
>  	case KSZ9477_CHIP_ID:
> -		/* KSZ9477 Errata DS80000754C
> -		 *
> -		 * Module 4: Energy Efficient Ethernet (EEE) feature select must
> -		 * be manually disabled
> +		/* KSZ9477 Errata DS80000754C Module 4 */
> +		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
>  		 *   The EEE feature is enabled by default, but it is not fully
>  		 *   operational. It must be manually disabled through register
>  		 *   controls. If not disabled, the PHY ports can auto-negotiate
> -- 

Similar fix is already present in net:
0411f73c13afc ("net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.")

But your patch provides some quirks for KSZ87xx  and some extra comments
which are nice to have too. Can you please rebase your patch on top of
latest net.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

