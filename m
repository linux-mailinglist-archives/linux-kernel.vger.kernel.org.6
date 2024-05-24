Return-Path: <linux-kernel+bounces-188696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732478CE575
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA081F21B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B5186658;
	Fri, 24 May 2024 12:44:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B086655
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554645; cv=none; b=TiS7IX46z4Osu4PzhaLUJqr2eBmK6b7L25QF7gb5Cj/86TAMEsFRMD5r+deWHkGkOAA97SpN4e7ETKGcEQrtH9K4cGY/BPczfw2xtSNvGRx5WfWI+XB4scOh1xCxvwLeblkgupUfi7DuOdBLmaT9sGAsI92tLtJe0Dw/f8g9vew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554645; c=relaxed/simple;
	bh=flVEgoKN1tPvevHbNX6zdPufBNG427EtPA4EnS2rUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aerg7epPu3/YrL7IUTXp2Pk66LWaXY2OHyeGDqGI/UP92cvaq69d7VeWo8P+S8cwmkI1f5UvnVzpdiFRJTRI84dtJq7r8cUO29YZ2YoLZ31zLxO3DLa1dT4tYle3MZRMojMkAY0FptrqwoE3gR0Eo5wmBRa1JTGfESkfvoW56O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sAUGz-0002rp-6u; Fri, 24 May 2024 14:43:49 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sAUGy-002nP0-8I; Fri, 24 May 2024 14:43:48 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sAUGy-00BiUO-0U;
	Fri, 24 May 2024 14:43:48 +0200
Date: Fri, 24 May 2024 14:43:48 +0200
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
Subject: Re: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
Message-ID: <ZlCLhPzLD6ox7iB3@pengutronix.de>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
 <ZlBOeAnkrn4ki7Wv@pengutronix.de>
 <AM9PR04MB8604C000F464CF1F5788901995F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604C000F464CF1F5788901995F52@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, May 24, 2024 at 12:03:35PM +0000, Pankaj Gupta wrote:
> 
> 
> > -----Original Message-----
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Friday, May 24, 2024 1:53 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>;
> > Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 5/5] firmware: imx: adds miscdev
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> >
> >
> > On Thu, May 23, 2024 at 04:19:36PM +0530, Pankaj Gupta wrote:
> > > +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > > +                          void *tx_msg, int tx_msg_sz) {
> > > +     struct se_if_priv *priv = dev_ctx->priv;
> > > +     struct se_msg_hdr *header;
> > > +     int err;
> > > +
> > > +     header = (struct se_msg_hdr *) tx_msg;
> > > +
> > > +     /*
> > > +      * Check that the size passed as argument matches the size
> > > +      * carried in the message.
> > > +      */
> > > +     err = header->size << 2;
> > > +
> > > +     if (err != tx_msg_sz) {
> > > +             err = -EINVAL;
> > > +             dev_err(priv->dev,
> > > +                     "%s: User buffer too small\n",
> > > +                             dev_ctx->miscdev.name);
> > > +             goto exit;
> > > +     }
> > > +     /* Check the message is valid according to tags */
> > > +     if (header->tag == priv->cmd_tag) {
> > > +             mutex_lock(&priv->se_if_cmd_lock);
> >
> > Grabbing a mutex in a character devices write fop and releasing it in the read
> > fop is really calling for undesired race conditions.
> 
> Condition is:
> - Only one command is allowed to be in flight, at a time per interface.
>    -- Second command is not allowed, when one command is in flight.
> - Duration of the flight is till the time the response is not received from the FW.
> 
> Command lock is grabbed and then released in process context only.
> 
> >
> > If sending a command and receiving the response shall be an atomic operation
> > then you should really consider turning this into an ioctl and just not
> > implement read/write on the character device. With this you'll be able to get
> > rid of several oddities in this drivers locking.
> >
> 
> It is not an atomic operation. It can be pre-empted.

I didn't mean atomic in the sense of being non preemptable.

> But it cannot be pre-empted to send another command on the same interface.
> 
> As only one command is allowed to be executed at one point in time, through an interface.

I meant atomic in the sense that only one command may be in flight: Send
a message and do not allow to send another message until the answer to
the first one is received.

Using an ioctl you can just use imx_ele_msg_send_rcv() which takes a
mutex during the whole send/receive process and have no need for such a
strange locking construct.

> > > +     /*
> > > +      * We may need to copy the output data to user before
> > > +      * delivering the completion message.
> > > +      */
> > > +     while (!list_empty(&dev_ctx->pending_out)) {
> > > +             b_desc = list_first_entry_or_null(&dev_ctx->pending_out,
> > > +                                               struct se_buf_desc,
> > > +                                               link);
> > > +             if (!b_desc)
> > > +                     continue;
> >
> > b_desc will never be NULL because otherwise you wouldn't be in the loop
> > anymore. The usual way to iterate over a list is to use list_for_each_entry() or
> > list_for_each_entry_safe() in case you delete entries in the loop body.
> >
> 
> Will remove the NULL check.
>         if (!b_desc)
>                continue;

Please don't. Use list_for_each_entry_safe() which is the normal way to
iterate over a list.

> > > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > > +                             u64 arg) {
> > > +     struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
> > > +     struct imx_se_node_info *if_node_info;
> > > +     struct se_ioctl_get_if_info info;
> > > +     int err = 0;
> > > +
> > > +     if_node_info = (struct imx_se_node_info *)priv->info;
> >
> > priv->info is of type const void *. You are casting away the the 'const'
> > here. Either it is const, then it should stay const, or not, in which case it
> > shouldn't be declared const. Also why isn't priv->info of type struct
> > imx_se_node_info * in the first place?
> 
> This struct definition is local to the file se_ctrl.c.
> Declaration of imx_se_node_info, is fixed by adding const in the whole file.

Add a

struct imx_se_node_info;

to se_ctrl.h and you're done.

> 
> > > +             err = -EFAULT;
> > > +             goto exit;
> > > +     } else {
> > > +             /* No specific requirement for this buffer. */
> > > +             shared_mem = &dev_ctx->non_secure_mem;
> > > +     }
> > > +
> > > +     /* Check there is enough space in the shared memory. */
> > > +     if (shared_mem->size < shared_mem->pos
> > > +                     || io.length >= shared_mem->size - shared_mem->pos) {
> > > +             dev_err(dev_ctx->priv->dev,
> > > +                     "%s: Not enough space in shared memory\n",
> > > +                             dev_ctx->miscdev.name);
> > > +             err = -ENOMEM;
> > > +             goto exit;
> > > +     }
> > > +
> > > +     /* Allocate space in shared memory. 8 bytes aligned. */
> > > +     pos = shared_mem->pos;
> > > +     shared_mem->pos += round_up(io.length, 8u);
> >
> > You are checking if there's enough space in the shared memory without taking
> > this round_up into account.
> 
> Yes. It is initializing the local variable 'pos', with last store value of shared_mem->pos.

Your check is:

	if (shared_mem->size < shared_mem->pos || io.length >= shared_mem->size - shared_mem->pos)

Afterwards you do a:

	shared_mem->pos += round_up(io.length, 8u);

This invalidates the check. You have to honor the potential padding in
your check as well.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

