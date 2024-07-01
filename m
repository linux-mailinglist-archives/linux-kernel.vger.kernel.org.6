Return-Path: <linux-kernel+bounces-235849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8F91DA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEFB21C01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1413D24D;
	Mon,  1 Jul 2024 08:47:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242C84D3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823657; cv=none; b=o9Ye3MuNuo+hlfo5TEuOrDdWZVhswKGLKc+juocEJLVHMWt8JWAL2xw8fqPtmQ0b8y0N1X1129fF34PQPvT8J7AoP7W2NbRUQYuRIlzMGp+4zrply+2bXBqGWLS9/oIp03WInNsaWt8WJxjP2iD6i6s3MM66Qnamm2HlJQfd0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823657; c=relaxed/simple;
	bh=Kbav4cGKIbJm8iy3+dlxX1y2wXHK40wZlm2jEB8JAVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNy6GKqsYB2AfWXmTly4shcBEpYuUH4UkQYKmPM4D3RVE6X7A4cOZnYNRqQB/Y4yj6NQX51qPFXQ66LBCaja/7GKx/NgHcLM0ivTexwHrDTJeVBHtP1jP8AyHA5A4olTT3sBM9QqygU9WkIFugGM7j2fCevekunbv2oH9UZgR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sOCgq-0005pO-I7; Mon, 01 Jul 2024 10:47:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sOCgl-006KYd-QZ; Mon, 01 Jul 2024 10:47:07 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sOCgl-008Lyc-2K;
	Mon, 01 Jul 2024 10:47:07 +0200
Date: Mon, 1 Jul 2024 10:47:07 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <ZoJtC-fgyVWQO57C@pengutronix.de>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-4-a7d28dea5c4a@nxp.com>
 <ZnFF_Z48qzpNvPtj@pengutronix.de>
 <AM9PR04MB860446165A0826362E7AF58195D32@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB860446165A0826362E7AF58195D32@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2024 at 07:45:20AM +0000, Pankaj Gupta wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Tuesday, June 18, 2024 2:02 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-doc@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v3 4/5] firmware: imx: add driver for NXP EdgeLock
> > Enclave
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > Hi Pankaj,
> >
> > Here's some review feedback. I think it'll take some more rounds to get this
> > into shape.
> >
> > On Mon, Jun 17, 2024 at 12:59:42PM +0530, Pankaj Gupta wrote:
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
> > >  drivers/firmware/imx/ele_base_msg.c | 284 +++++++++++++++++++
> > > drivers/firmware/imx/ele_base_msg.h |  90 ++++++
> > >  drivers/firmware/imx/ele_common.c   | 233 ++++++++++++++++
> > >  drivers/firmware/imx/ele_common.h   |  45 +++
> > >  drivers/firmware/imx/se_ctrl.c      | 536
> > ++++++++++++++++++++++++++++++++++++
> > >  drivers/firmware/imx/se_ctrl.h      |  99 +++++++
> > >  include/linux/firmware/imx/se_api.h |  14 +
> > >  9 files changed, 1315 insertions(+)
> > >
> > > diff --git a/drivers/firmware/imx/Kconfig
> > > b/drivers/firmware/imx/Kconfig index 183613f82a11..56bdca9bd917 100644
> > > --- a/drivers/firmware/imx/Kconfig
> > > +++ b/drivers/firmware/imx/Kconfig
> > > @@ -22,3 +22,15 @@ config IMX_SCU
> > >
> > >         This driver manages the IPC interface between host CPU and the
> > >         SCU firmware running on M4.
> > > +
> > > +config IMX_SEC_ENCLAVE
> > > +     tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware
> > driver."
> > > +     depends on IMX_MBOX && ARCH_MXC && ARM64
> > > +     default m if ARCH_MXC
> > > +
> > > +     help
> > > +       It is possible to use APIs exposed by the iMX Secure Enclave HW IP
> > called:
> > > +          - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
> > > +          like base, HSM, V2X & SHE using the SAB protocol via the shared
> > Messaging
> > > +          Unit. This driver exposes these interfaces via a set of file descriptors
> > > +          allowing to configure shared memory, send and receive messages.
> > > diff --git a/drivers/firmware/imx/Makefile
> > > b/drivers/firmware/imx/Makefile index 8f9f04a513a8..aa9033e0e9e3
> > > 100644
> > > --- a/drivers/firmware/imx/Makefile
> > > +++ b/drivers/firmware/imx/Makefile
> > > @@ -1,3 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_IMX_DSP)                += imx-dsp.o
> > >  obj-$(CONFIG_IMX_SCU)                += imx-scu.o misc.o imx-scu-irq.o rm.o
> > imx-scu-soc.o
> > > +sec_enclave-objs             = se_ctrl.o ele_common.o ele_base_msg.o
> > > +obj-${CONFIG_IMX_SEC_ENCLAVE}        += sec_enclave.o
> > > diff --git a/drivers/firmware/imx/ele_base_msg.c
> > > b/drivers/firmware/imx/ele_base_msg.c
> > > new file mode 100644
> > > index 000000000000..5bfd9c7e3f7e
> > > --- /dev/null
> > > +++ b/drivers/firmware/imx/ele_base_msg.c
> > > @@ -0,0 +1,284 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/dma-mapping.h>
> > > +
> > > +#include "ele_base_msg.h"
> > > +#include "ele_common.h"
> > > +
> > > +int ele_get_info(struct device *dev, struct ele_dev_info *s_info) {
> >
> > I think all currently exported functions should take a struct se_if_priv
> > * as context pointer.
> > I can't find any place in which any of these functions is called differently than
> > with priv->dev.
> 
> All the API(s) that construct a message to be exchanged over the device-interface to FW,
> - will be the exported symbols in the next patch-set, to be used by other Linux kernel modules like: NVMEM driver, linux crypto framework, security/keys etc.
> - These other Linux layers have to choose from multiple similar devices per secure-enclave.
> 
> Kindly Consider these API(s), to be the EXPORT SYMBOLS, in later patches, when used outside of this driver.

In that case you could still add a function which translates a struct
device * into a struct se_if_priv *.

> >
> > > +     struct se_if_priv *priv = dev_get_drvdata(dev);

This function should also include some sanity checks. It's not good that
an exported function takes some struct device *, blindly assumes that
it is of type se_if_priv, and if not just crashes the Kernel.

> > > +static int imx_fetch_se_soc_info(struct se_if_priv *priv,
> > > +                              const struct imx_se_node_info_list
> > > +*info_list) {
> > > +     const struct imx_se_node_info *info;
> > > +     struct soc_device_attribute *attr;
> > > +     struct soc_device *sdev;
> > > +     u64 serial_num;
> > > +     u16 soc_rev;
> > > +     int err = 0;
> > > +
> > > +     info = priv->info;
> > > +
> > > +     /* This function should be called once.
> > > +      * Check if the soc_rev is zero to continue.
> > > +      */
> > > +     if (priv->soc_rev)
> > > +             return err;
> >
> > Just return 0 here. It takes one step less to understand what this is about.
> Replacing "err" with "ret", in better understanding.

What I meant that you should return the constant '0' here instead of the
content of a variable. It safes a reader from looking up the value of
the variable which means it's one step less for the brain to understand
the code.

> > > +
> > > +     if (info->se_fetch_soc_info) {
> > > +             err = info->se_fetch_soc_info(priv->dev, &soc_rev, &serial_num);
> > > +             if (err < 0) {
> > > +                     dev_err(priv->dev, "Failed to fetch SoC Info.");
> > > +                     return err;
> > > +             }
> > > +     } else {
> > > +             dev_err(priv->dev, "Failed to fetch SoC revision.");
> > > +             if (info->soc_register)
> > > +                     dev_err(priv->dev, "Failed to do SoC registration.");
> > > +             err = -EINVAL;
> > > +             return err;
> > > +     }
> >
> > i.MX93 doesn't have a info->se_fetch_soc_info. Does this mean it doesn't work
> > on this SoC?
> >
> Yes.

Will you fix this?

> > > +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +     if (!priv) {
> > > +             ret = -ENOMEM;
> > > +             goto exit;
> > > +     }
> > > +
> > > +     dev_set_drvdata(dev, priv);
> > > +
> > > +     /* Mailbox client configuration */
> > > +     priv->se_mb_cl.dev              = dev;
> > > +     priv->se_mb_cl.tx_block         = false;
> > > +     priv->se_mb_cl.knows_txdone     = true;
> > > +     priv->se_mb_cl.rx_callback      = se_if_rx_callback;
> > > +
> > > +     ret = se_if_request_channel(dev, &priv->tx_chan,
> > > +                     &priv->se_mb_cl, info->mbox_tx_name);
> > > +     if (ret)
> > > +             goto exit;
> > > +
> > > +     ret = se_if_request_channel(dev, &priv->rx_chan,
> > > +                     &priv->se_mb_cl, info->mbox_rx_name);
> > > +     if (ret)
> > > +             goto exit;
> > > +
> > > +     priv->dev = dev;
> > > +     priv->info = info;
> > > +
> > > +     mutex_init(&priv->se_if_lock);
> > > +     mutex_init(&priv->se_if_cmd_lock);
> > > +
> > > +     priv->cmd_receiver_dev = NULL;
> > > +     priv->waiting_rsp_dev = NULL;
> >
> > These are NULL already.
> For code readability, it is good to know when and with what value it is initialized.
> It will help review the 'if' condition based on these structure member variable.
> Will covert this information into comments.

We already know they are NULL because you used kzalloc to allocate the
struct. No need to comment that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

