Return-Path: <linux-kernel+bounces-188687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45998CE555
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A47628174A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24B86655;
	Fri, 24 May 2024 12:26:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF368127E0B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553571; cv=none; b=qfHcgKJ3Gq4CI3LNLNyDt9izMmrQJ8V9SazntBdU5c4DUXf5/URzfpaCMTWv2mUKIlTcUpK5ow5B7qEdGBHAen3DhIuhzqnA0g9oRFwRsOhy692h3nuePgfbI5lt9f1rLkZ81mYO22xocww3tFqpJQScSeqxNd90tURtRBD+GJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553571; c=relaxed/simple;
	bh=BR6wg9i/0mbzIcyzWHdONHm37dg16V5vztgEDpsM3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3q+kKQkEtGnP/ovGRwmOxOZUMtSCfErqDxGR4huV4aM+cFUjyFbxASgGvXW39c53kK/3rZUb0uAeWeBvexhBBd1OnVcOHoykORcPJvxHVCZVMmgqPkh3oVngahCT2dl1fGZNVN77nPfroSNMgDM/nhowBDI7l5A6oKrhWYO2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sATzb-0001Lx-DC; Fri, 24 May 2024 14:25:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sATza-002nB5-Jm; Fri, 24 May 2024 14:25:50 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sATza-00BiEV-1d;
	Fri, 24 May 2024 14:25:50 +0200
Date: Fri, 24 May 2024 14:25:50 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <ZlCHTqJ0Umgh3LCw@pengutronix.de>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-4-5a6fd189a539@nxp.com>
 <ZlBtNSeh2VyZsVxq@pengutronix.de>
 <AM9PR04MB860424A71753DBB56D2CEF5895F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB860424A71753DBB56D2CEF5895F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, May 24, 2024 at 12:08:14PM +0000, Pankaj Gupta wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Friday, May 24, 2024 4:04 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 4/5] firmware: imx: add driver for NXP EdgeLock
> > Enclave
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > On Thu, May 23, 2024 at 04:19:35PM +0530, Pankaj Gupta wrote:
> > > NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE), are
> > > embedded in the SoC to support the features like HSM, SHE & V2X, using
> > > message based communication interface.
> > >
> > > The secure enclave FW communicates on a dedicated messaging unit(MU)
> > > based interface(s) with application core, where kernel is running.
> > > It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.
> > >
> > > This patch adds the driver for communication interface to
> > > secure-enclave, for exchanging messages with NXP secure enclave HW
> > > IP(s) like EdgeLock Enclave (ELE) from Kernel-space, used by kernel
> > > management layers like
> > > - DM-Crypt.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > ---
> > >  drivers/firmware/imx/Kconfig        |  12 +
> > >  drivers/firmware/imx/Makefile       |   2 +
> > >  drivers/firmware/imx/ele_base_msg.c | 286 +++++++++++++++++++
> > > drivers/firmware/imx/ele_base_msg.h |  92 +++++++
> > >  drivers/firmware/imx/ele_common.c   | 239 ++++++++++++++++
> > >  drivers/firmware/imx/ele_common.h   |  43 +++
> > >  drivers/firmware/imx/se_ctrl.c      | 531
> > ++++++++++++++++++++++++++++++++++++
> > >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> > >  include/linux/firmware/imx/se_api.h |  14 +
> > >  9 files changed, 1318 insertions(+)
> > >
> >
> > > +static int se_probe_if_cleanup(struct platform_device *pdev) {
> > > +     struct device *dev = &pdev->dev;
> > > +     struct se_if_priv *priv;
> > > +     int ret = 0;
> > > +
> > > +     priv = dev_get_drvdata(dev);
> > > +     if (!priv) {
> > > +             ret = 0;
> > > +             dev_dbg(dev, "SE-MU Priv data is NULL;");
> > > +             return ret;
> > > +     }
> > > +
> > > +     if (priv->tx_chan)
> > > +             mbox_free_channel(priv->tx_chan);
> > > +     if (priv->rx_chan)
> > > +             mbox_free_channel(priv->rx_chan);
> > > +
> > > +     /* free the buffer in se remove, previously allocated
> > > +      * in se probe to store encrypted IMEM
> > > +      */
> > > +     if (priv->imem.buf) {
> > > +             dmam_free_coherent(dev,
> > > +                                ELE_IMEM_SIZE,
> > > +                                priv->imem.buf,
> > > +                                priv->imem.phyaddr);
> > > +             priv->imem.buf = NULL;
> > > +     }
> > > +
> > > +     if (priv->flags & RESERVED_DMA_POOL) {
> > > +             of_reserved_mem_device_release(dev);
> >
> > You can call this unconditionally, no need to keep track if you called
> > of_reserved_mem_device_init() successfully.
> 
> But it will not be called for each SoC.
> The memory is not reserved for i.MX95 platforms.
> This is required.

Again: You can call this unconditionally. Look at the code,
of_reserved_mem_device_release() won't do anything if you haven't called
of_reserved_mem_device_init() before.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

