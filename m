Return-Path: <linux-kernel+bounces-345691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4854398B9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E2CB20A60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA71A08B5;
	Tue,  1 Oct 2024 10:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B46193429
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778783; cv=none; b=EnYzIv64bdb79Ob/Td5EYuI+rPlBIlZQDo9mWiF/J1gXQXbJ0GwPd4FrB2QOF9hukqHxFVEIPf+xr3m3PefjuajtlRIBrGwTyF0t48oLyU8mtyRA42jpIsFZ41xowhvcpCuQslMY+iUdz6D3Qe1/o6VosHleD794aPm5AYk8Lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778783; c=relaxed/simple;
	bh=1+9qU1dmRsSbY8K7d//xOhQyUobepu7L+bzDYYZnbPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEFdvHy19VjHJ2CW9a1KDubeJrz6B4xTPb96AsDhIu3kMFj7JNTG8h7DA8T1RJYfObRxb6QztjE0ubQaKn73fhD3qOCtQABS8J+r6Qslps4gu3aNkmi05KBj/OrlUUXn42lk64W/mmgvVd+RF7v8uUfTTasAYLJQOBq1hbDM2gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1svaBS-0007b2-C6; Tue, 01 Oct 2024 12:32:46 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1svaBR-002qxB-M9; Tue, 01 Oct 2024 12:32:45 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1svaBR-004wOM-1s;
	Tue, 01 Oct 2024 12:32:45 +0200
Date: Tue, 1 Oct 2024 12:32:45 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <ZvvPzfUHUK9gbYMi@pengutronix.de>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <Zt7n0AxGEw-ZXbui@pengutronix.de>
 <AS8PR04MB85932B4E47EFC519B0EF6D9A95632@AS8PR04MB8593.eurprd04.prod.outlook.com>
 <Zu1kUDb5dfB5dRbe@pengutronix.de>
 <AM9PR04MB86042C9BF315EF130FF0408A95692@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <ZvUupApT8q_TRJds@pengutronix.de>
 <AS8PR04MB85935C0146A9393E6D75456A95772@AS8PR04MB8593.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB85935C0146A9393E6D75456A95772@AS8PR04MB8593.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2024 at 07:49:39AM +0000, Pankaj Gupta wrote:
> >> >Either compile the firmware into the kernel or the ELE driver as module.
> >>
> >> Cannot compile as part of Firmware.
> >> There are OTA scenarios where the latest FW, that is downloaded to 
> >> replace the image in RFS, and FW needs to be re-init with this new 
> >> image, by putting the Linux to power-down state.
> >
> >> ELE driver is compiled as module only, by default. But if someone like 
> >> to make it as in-line to kernel image, still it should work.
> 
> > I am also not very happy with the situation that we can't compile drivers
> into the kernel and just get the firmware later once it is available.
> 
> Driver is enabling the ROM API supports at probe time. 
> And, once the rootfs is available, and the Firmware image is loaded, then it
> will enable the complete set of FW API(s), along with ROM API(s).
> 
> Hence, Driver can be compiled into the kernel to enable ELE-ROM API(s).

I see what the code does, I just don't think that it's safe to assume
that the rootfs will be mounted after the 50*20ms timeout you use.

I also think that it's a valid usecase for builtin code to retry
firmware loading after the rootfs has been mounted. This should be
integrated into the firmware loading code though and not be done as a
driver specific hack.

Anyway, it won't be me who merges this code and I am just telling you
that you'll likely have a problem getting this upstream as is.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

