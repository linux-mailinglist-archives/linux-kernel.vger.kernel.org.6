Return-Path: <linux-kernel+bounces-200506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473AC8FB0F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC57B283276
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381181459E4;
	Tue,  4 Jun 2024 11:21:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6111442E3;
	Tue,  4 Jun 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500085; cv=none; b=CblJZe8LrYLTAup8MbQqG2wbhJlTXUdaLr5s1juWrquvZLqVcEdRScJGDe4pp3o5umK7mISOuntWHyKBwU5hUCqUazuImCve2DADfTEOKZ3ihI1ZKdTY4zJmY9PjyAUge2CaoMYUuQjmZuaVxHd3+udNnEbidOEtPGswCKnsZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500085; c=relaxed/simple;
	bh=n2DjVH55KPo3LX7oc8Z3hPYuIC6julgAjXCiT8JJBJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoJE+9YFGp5Ft+WeF4F+x9tfR61EWCPcQSgZ5LEY9XCBD9WgZ42V17MBAgZcldfXcLQvm1CPaI4t1fhGCaIObjnransOyEZYuMmSILolL7Gin1pZDGWMtFOqaT4dtookReBJ5lOsKFot1W+URQz9vNSbQucfyUnoFWHwkvDcJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E4C1042;
	Tue,  4 Jun 2024 04:21:46 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F7003F762;
	Tue,  4 Jun 2024 04:21:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:21:19 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Message-ID: <Zl74r6xoBb3Sc74d@pluto>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>
 <Zl3rFTKrctdWcDBZ@pluto>
 <DU0PR04MB9417CED7DDF04A348792A7E788F82@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417CED7DDF04A348792A7E788F82@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Jun 04, 2024 at 01:06:08AM +0000, Peng Fan wrote:
> Hi Cristian,
> 
> > Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A
> > channel completion
> > 
> > On Fri, May 10, 2024 at 11:19:48AM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX95 System Manager firmware is fully interrupt driven. The
> > > notification channel needs completion interrupt to drive its
> > > notification queue. Without completion interrupt, the notification will work
> > abnormal.
> > >
> > 
> > Hi Peng,
> > 
> > Thanks to have addressed also the case of mailbox controllers with
> > unidirectional channels for P2A completion, but I have a further observation
> > down below, which I missed last time.
> > 
> > > - Add an optional unidirectional mailbox channel. If the channel flag has
> > >   INTR set, and the completion interrupt channel is provided, issue the
> > >   mbox message to Platform after the channel is freed.
> > > - Support bidirectional channel completion interrupt.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/firmware/arm_scmi/common.h  |  1 +
> > > drivers/firmware/arm_scmi/mailbox.c | 60
> > +++++++++++++++++++++++++++++++++----
> > >  drivers/firmware/arm_scmi/shmem.c   |  5 ++++
> > >  3 files changed, 60 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/common.h
> > > b/drivers/firmware/arm_scmi/common.h
> > > index b5ac25dbc1ca..4b8c5250cdb5 100644
> > > --- a/drivers/firmware/arm_scmi/common.h
> > > +++ b/drivers/firmware/arm_scmi/common.h
> > > @@ -326,6 +326,7 @@ void shmem_clear_channel(struct
> > scmi_shared_mem
> > > __iomem *shmem);  bool shmem_poll_done(struct scmi_shared_mem
> > __iomem *shmem,
> > >  		     struct scmi_xfer *xfer);
> > >  bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
> > > +bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem
> > > +*shmem);
> > >
> > >  /* declarations for message passing transports */  struct
> > > scmi_msg_payld; diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > > b/drivers/firmware/arm_scmi/mailbox.c
> > > index 615a3b2ad83d..adb69a6a0223 100644
> > > --- a/drivers/firmware/arm_scmi/mailbox.c
> > > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > > @@ -21,6 +21,7 @@
> > >   * @cl: Mailbox Client
> > >   * @chan: Transmit/Receive mailbox uni/bi-directional channel
> > >   * @chan_receiver: Optional Receiver mailbox unidirectional channel
> > > + * @chan_platform_receiver: Optional Platform Receiver mailbox
> > > + unidirectional channel
> > >   * @cinfo: SCMI channel info
> > >   * @shmem: Transmit/Receive shared memory area
> > >   */
> > > @@ -28,6 +29,7 @@ struct scmi_mailbox {
> > >  	struct mbox_client cl;
> > >  	struct mbox_chan *chan;
> > >  	struct mbox_chan *chan_receiver;
> > > +	struct mbox_chan *chan_platform_receiver;
> > >  	struct scmi_chan_info *cinfo;
> > >  	struct scmi_shared_mem __iomem *shmem;  }; @@ -91,6 +93,8
> > @@ static
> > > bool mailbox_chan_available(struct device_node *of_node, int idx)
> > >   *		 for replies on the a2p channel. Set as zero if not present.
> > >   * @p2a_chan: A reference to the optional p2a channel.
> > >   *	      Set as zero if not present.
> > > + * @p2a_rx_chan: A reference to the optional p2a completion channel.
> > > + *	      Set as zero if not present.
> > >   *
> > >   * At first, validate the transport configuration as described in terms of
> > >   * 'mboxes' and 'shmem', then determin which mailbox channel indexes
> > > are @@ -98,8 +102,8 @@ static bool mailbox_chan_available(struct
> > device_node *of_node, int idx)
> > >   *
> > >   * Return: 0 on Success or error
> > >   */
> > > -static int mailbox_chan_validate(struct device *cdev,
> > > -				 int *a2p_rx_chan, int *p2a_chan)
> > > +static int mailbox_chan_validate(struct device *cdev, int *a2p_rx_chan,
> > > +				 int *p2a_chan, int *p2a_rx_chan)
> > >  {
> > >  	int num_mb, num_sh, ret = 0;
> > >  	struct device_node *np = cdev->of_node; @@ -109,8 +113,9 @@
> > static
> > > int mailbox_chan_validate(struct device *cdev,
> > >  	dev_dbg(cdev, "Found %d mboxes and %d shmems !\n", num_mb,
> > num_sh);
> > >
> > >  	/* Bail out if mboxes and shmem descriptors are inconsistent */
> > > -	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 3 ||
> > > -	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh !=
> > 2)) {
> > > +	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 4 ||
> > > +	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2)
> > ||
> > > +	    (num_mb == 4 && num_sh != 2)) {
> > >  		dev_warn(cdev,
> > >  			 "Invalid channel descriptor for '%s' - mbs:%d
> > shm:%d\n",
> > >  			 of_node_full_name(np), num_mb, num_sh); @@ -
> > 139,6 +144,7 @@
> > > static int mailbox_chan_validate(struct device *cdev,
> > >  		case 1:
> > >  			*a2p_rx_chan = 0;
> > >  			*p2a_chan = 0;
> > > +			*p2a_rx_chan = 0;
> > >  			break;
> > >  		case 2:
> > >  			if (num_sh == 2) {
> > > @@ -148,10 +154,17 @@ static int mailbox_chan_validate(struct device
> > *cdev,
> > >  				*a2p_rx_chan = 1;
> > >  				*p2a_chan = 0;
> > >  			}
> > > +			*p2a_rx_chan = 0;
> > >  			break;
> > >  		case 3:
> > >  			*a2p_rx_chan = 1;
> > >  			*p2a_chan = 2;
> > > +			*p2a_rx_chan = 0;
> > > +			break;
> > > +		case 4:
> > > +			*a2p_rx_chan = 1;
> > > +			*p2a_chan = 2;
> > > +			*p2a_rx_chan = 3;
> > >  			break;
> > >  		}
> > >  	}
> > > @@ -166,12 +179,12 @@ static int mailbox_chan_setup(struct
> > scmi_chan_info *cinfo, struct device *dev,
> > >  	struct device *cdev = cinfo->dev;
> > >  	struct scmi_mailbox *smbox;
> > >  	struct device_node *shmem;
> > > -	int ret, a2p_rx_chan, p2a_chan, idx = tx ? 0 : 1;
> > > +	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
> > >  	struct mbox_client *cl;
> > >  	resource_size_t size;
> > >  	struct resource res;
> > >
> > > -	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan);
> > > +	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan,
> > > +&p2a_rx_chan);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > @@ -229,6 +242,17 @@ static int mailbox_chan_setup(struct
> > scmi_chan_info *cinfo, struct device *dev,
> > >  		}
> > >  	}
> > >
> > > +	if (!tx && p2a_rx_chan) {
> > > +		smbox->chan_platform_receiver = mbox_request_channel(cl,
> > p2a_rx_chan);
> > > +		if (IS_ERR(smbox->chan_platform_receiver)) {
> > > +			ret = PTR_ERR(smbox->chan_platform_receiver);
> > > +			if (ret != -EPROBE_DEFER)
> > > +				dev_err(cdev, "failed to request SCMI P2A
> > Receiver mailbox\n");
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +
> > >  	cinfo->transport_info = smbox;
> > >  	smbox->cinfo = cinfo;
> > >
> > > @@ -243,9 +267,11 @@ static int mailbox_chan_free(int id, void *p, void
> > *data)
> > >  	if (smbox && !IS_ERR(smbox->chan)) {
> > >  		mbox_free_channel(smbox->chan);
> > >  		mbox_free_channel(smbox->chan_receiver);
> > > +		mbox_free_channel(smbox->chan_platform_receiver);
> > >  		cinfo->transport_info = NULL;
> > >  		smbox->chan = NULL;
> > >  		smbox->chan_receiver = NULL;
> > > +		smbox->chan_platform_receiver = NULL;
> > >  		smbox->cinfo = NULL;
> > >  	}
> > >
> > > @@ -300,8 +326,30 @@ static void mailbox_fetch_notification(struct
> > > scmi_chan_info *cinfo,  static void mailbox_clear_channel(struct
> > > scmi_chan_info *cinfo)  {
> > >  	struct scmi_mailbox *smbox = cinfo->transport_info;
> > > +	struct device *cdev = cinfo->dev;
> > > +	struct mbox_chan *intr;
> > > +	int ret;
> > >
> > >  	shmem_clear_channel(smbox->shmem);
> > > +
> > > +	if (!shmem_channel_intr_enabled(smbox->shmem))
> > > +		return;
> > > +
> > > +	if (smbox->chan_platform_receiver)
> > > +		intr = smbox->chan_platform_receiver;
> > > +	else if (smbox->chan)
> > > +		intr = smbox->chan;
> > > +	else {
> > > +		dev_err(cdev, "Channel INTR wrongly set?\n");
> > > +		return;
> > > +	}
> > > +
> > > +	ret = mbox_send_message(intr, NULL);
> > > +	/* mbox_send_message returns non-negative value on success, so
> > reset */
> > > +	if (ret > 0)
> > > +		ret = 0;
> > > +
> > > +	mbox_client_txdone(intr, ret);
> > 
> > Looking at mbox_client_txdone() implementation this call is allowed only if
> > the txdone_method is TXDONE_BY_ACK, which in turn depend on the type of
> > underlying mbox controller that you are using AND/OR the SCMI client
> > configuration (knows_tx_done), so I dont think you can call this
> > unconditionally without the risk of hitting the related dev_err() in
> > mbox_client_txdone if the underlying mbox controller was instead supposed
> > to issue an mbox_chan_txdone() on its own.
> > 
> > IOW, if the mbox controller is operating in TXDONE_BY_IRQ mode or in
> > TXDONE_BY_POLL (and that would be the case if polling is used since the RX
> > channel does NOT set the client flag cl->knows_txdone to true, so
> > TXDONE_BY_ACK is not used as an override) this should hit the dev_err()
> > mentioned above...
> > 
> > dont you see any error ?
> 
> No error in my side.
> 
> > 
> > which mailbox controller do you use ?
> 
> drivers/mailbox/imx-mu.c. The tx channel is IMX_MU_TYPE_TXDB_V2
> > 
> > does your mailbox controller NOT set txdone_irq and NEITHER txdone_poll ?
> > (so defaulting to TDONE_BY_ACK in your case ?)
> 
> Use TXDONE_BY_ACK, no irq and no poll.
> 

Ok that explains the fact you dont see any errors in your setup.

> i.MX Message Unit(MU) supports many types, but for the i.MX SCMI MU,
> we are using GIR(General Interrupt request) to the other side. 
> And GIR will not trigger interrupt on the local side.
> That means Linux write GIRA will trigger interrupt on M33 side, but no
> interrupt in linux side. M33 write GIRB will trigger interrupt on
> Linux side, but no interrupt in M33 side.
> 

Yes the problem I mentioned will be visible ONLY if txdone_irq OR
txdone_poll are explicitly set AND the FW asked for a completion
interrupt on P2A; and I have seen similar issues if you have a controller
with a TxAck IRQ on A2P and you try to use it (which is not needed
really in SCMI).

Having said that, given that your case is the only case at the moment,
and you see no issues, I'd say to just merge your patch as it is now and
then I will eventually push a proper fix for both problems.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

