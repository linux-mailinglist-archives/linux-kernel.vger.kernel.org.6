Return-Path: <linux-kernel+bounces-386309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B89B41C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CC81C21AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D96200C8F;
	Tue, 29 Oct 2024 05:16:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BF3207
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178980; cv=none; b=VFaFKriCTwVrzB05WDKwzOKYs+NNAHPgHZ0HZvjg3NSPE+g+s1hJ1kG03VAvDas5/PTgNnW4acY14YPcal6P39nk5poyC30eXWIhy6mlcMb/uoFORpC9RGHnqvMogsEOiK/bhPrPnRK+UfKUtWnq9JttyI4hBbFRY7A4h6AjM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178980; c=relaxed/simple;
	bh=Ifevp/n7QpjieQO7uR7ym1dIBjDmXe4TQ4LiKcCQMBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEA08U/WJNwB+MUMTqsiM9Svlo8G1rC+BMrKiT4jWUtEWOCCYIbsF/Mo4cYOgfCJEkI7DpBo6W2zzfeLzqD0zo+cK9kWUwYsBM8ZL2L/App+ruJeE73cqsg/0YoFDFXQPvHtI5tAFAf7fcZW3eBnO1K9wMSlxzrZ3dheRprFxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t5eaE-0001SP-6u; Tue, 29 Oct 2024 06:15:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5eaC-000yOw-1t;
	Tue, 29 Oct 2024 06:15:56 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5eaC-002T0Z-1J;
	Tue, 29 Oct 2024 06:15:56 +0100
Date: Tue, 29 Oct 2024 06:15:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
	Woojung.Huh@microchip.com, robh+dt@kernel.org, pabeni@redhat.com,
	edumazet@google.com, f.fainelli@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	kuba@kernel.org, linux@armlinux.org.uk, kernel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 5/5] net: dsa: microchip: add support for
 side MDIO interface in LAN937x
Message-ID: <ZyBvjGrSb0uKELwm@pengutronix.de>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-6-o.rempel@pengutronix.de>
 <6eeb92d0791a1c0c77d57c74c85990d1cdeb355d.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6eeb92d0791a1c0c77d57c74c85990d1cdeb355d.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Arun,

On Tue, Oct 29, 2024 at 03:39:33AM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> 
> On Sat, 2024-10-26 at 08:35 +0200, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > diff --git a/drivers/net/dsa/microchip/lan937x_main.c
> > b/drivers/net/dsa/microchip/lan937x_main.c
> > index 824d9309a3d35..7dfd21d0d2843 100644
> > --- a/drivers/net/dsa/microchip/lan937x_main.c
> > +++ b/drivers/net/dsa/microchip/lan937x_main.c
> > @@ -18,6 +18,47 @@
> >  #include "ksz9477.h"
> >  #include "lan937x.h"
> > 
> > +static const u8 lan9370_phy_addr[] = {
> > +       [0] = 2, /* Port 1, T1 AFE0 */
> > +       [1] = 3, /* Port 2, T1 AFE1 */
> > +       [2] = 5, /* Port 3, T1 AFE3 */
> > +       [3] = 6, /* Port 4, T1 AFE4 */
> > +       [4] = U8_MAX, /* Port 5, RGMII 2 */
> > +};
> > +
> 
> Is it intentional to not to add support for lan9371 variant switch?

I forgot about this one, will add it too.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

