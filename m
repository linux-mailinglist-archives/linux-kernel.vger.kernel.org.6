Return-Path: <linux-kernel+bounces-218237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C3C90BB96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68140285D71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC8190485;
	Mon, 17 Jun 2024 19:57:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686818C321
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654270; cv=none; b=a01iw9jdpnIpf8dduTQBuwn+laOqA9ZpuV8c1NOB85j112rWVMMnyEaRamT9dbuBhSMMsctgqnBZqoDUUAGlSAltZ2dHbqHCpxbO3WDXuvGCy/p7Sd+NjMHrtDe73p5RYbDzwR3lUblIH0OCVJwqtPGq4Akgcl8P7OAtZy1bDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654270; c=relaxed/simple;
	bh=KI/Vs+OzdclbQ+l93+Oju2kPh/pOfc8V8i1zsn3rIjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itqTITwRrm4gVJmDLmQW4VndfD5EJLzeOKRF+12cSWE3SPOMXpWNV/SX9iUMy+1sZAJB1fm+E3R02cGlMZ3Q3l94vMdE4sPv8wwxGriDUGfo6SPCEAqx1vqDe5ScCK0HB5/e1935iBTubF58vbet6czM8gw8NZArHkr12jcSPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sJIU0-0006BX-5F; Mon, 17 Jun 2024 21:57:40 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sJITz-0033XS-J5; Mon, 17 Jun 2024 21:57:39 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sJITz-00GGNG-1b;
	Mon, 17 Jun 2024 21:57:39 +0200
Date: Mon, 17 Jun 2024 21:57:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <ZnCVMwkfrn8wF9cF@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
 <Zm26aJaz7Z7LAXNT@pengutronix.de>
 <Zm3dTuXuVEF9MhDS@pengutronix.de>
 <Zm6BGJxu4bLVszFD@pengutronix.de>
 <20240617181413.12178f95@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617181413.12178f95@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2024 at 06:14:13PM +0200, Kory Maincent wrote:
> >  +------------------------------------------+--------+----------------------------+
> >  | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGES``   | nested | array of power
> > limit ranges|
> > +-+----------------------------------------+--------+----------------------------+
> > | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_ENTRY`` | nested | one power
> > limit range  |
> > +-+-+--------------------------------------+--------+----------------------------+
> > | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MIN``  | u32    | minimum power value
> > (mW)   |
> > +-+-+--------------------------------------+--------+----------------------------+
> > | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MAX``  | u32    | maximum power value
> > (mW)   |
> > +-+-+--------------------------------------+--------+----------------------------+
> 
> Not sure the ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_ENTRY bring anything
> interesting.
> 
>  +--------------------------------------------+--------+----------------------------+
>  | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGES`` | nested | array of power limit ranges|
>  +-+------------------------------------------+--------+----------------------------+
>  | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MIN``  | u32    | minimum power value (mW)   |
>  +-+------------------------------------------+--------+----------------------------+
>  | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MAX``  | u32    | maximum power value (mW)   |
>  +-+------------------------------------------+--------+----------------------------+

Ack. Good point.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

