Return-Path: <linux-kernel+bounces-272111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3194572A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0931C233DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252722EF2;
	Fri,  2 Aug 2024 04:45:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCD1EB485
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573952; cv=none; b=VZnjvx/TTSf2ySGQK5M83LcKQOupIPhO0hTJJgaktQvTiHZwk7/LagnzZtRBszibGzxgWjBbP6vFjJLD15EU9U0WYM2qhR9EZqZTsX3u8lyfCuGAxQZip4IgyNIL3nTR76IWwZMAqZOKGpBJ05KQSyeSWZzB0OyIbIzMuZ5s5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573952; c=relaxed/simple;
	bh=TOfvi9DcyV77mbc0cSrZEXJm3tNE359EeCSgdMdrXrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDeIA+F6Y0SK27mwszC95bUKFaed7awTNiF+aAmCPKfcH1RXYmq4Tqj7d8Ix+9YjGDbMO+XhprdUJ2AmXAR1J01LZl39pVhlgFJcyBO20r+gKROfvBXXJWjq2tsayhLTm6Rs9YfP9kKvD0qOFYrt8sf5ur2hVf9mw5HesofAaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkAW-0003fb-NJ; Fri, 02 Aug 2024 06:45:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkAU-003vXU-Qa; Fri, 02 Aug 2024 06:45:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZkAU-00EnjA-2F;
	Fri, 02 Aug 2024 06:45:30 +0200
Date: Fri, 2 Aug 2024 06:45:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix Wake-on-LAN check to not
 return an error
Message-ID: <ZqxkagBDD18Z0-g_@pengutronix.de>
References: <20240802000510.7088-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802000510.7088-1-Tristram.Ha@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2024 at 05:05:10PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The wol variable in ksz_port_set_mac_address() is declared with random
> data, but the code in ksz_get_wol call may not be executed so the
> WAKE_MAGIC check may be invalid resulting in an error message when
> setting a MAC address after starting the DSA driver.
> 
> Fixes: 3b454b6390c3 ("net: dsa: microchip: ksz9477: Add Wake on Magic Packet support")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b074b4bb0629..2725c5bc311c 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3764,6 +3764,12 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
>  		return -EBUSY;
>  	}
>  
> +	/* Need to initialize variable as the code to fill in settings may
> +	 * not be executed.
> +	 */
> +	wol.supported = 0;
> +	wol.wolopts = 0;
> +
>  	ksz_get_wol(ds, dp->index, &wol);
>  	if (wol.wolopts & WAKE_MAGIC) {
>  		dev_err(ds->dev,

Only wol.wolopts need to be cleared. wol.supported can be dropped.

With this change:
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

