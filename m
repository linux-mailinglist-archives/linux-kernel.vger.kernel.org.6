Return-Path: <linux-kernel+bounces-249354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9892EA80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B31F2333C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E21649C6;
	Thu, 11 Jul 2024 14:19:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E031B15AD99;
	Thu, 11 Jul 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707545; cv=none; b=Yu5fOrrtTaG4RX0SVKQAExk3zgkfvVT2ZigkpBsJzOe6dLDr8xnUFYLlJOaYg9q/qJqZYQ69AUH3xyxHxPmQM1IkmiUjpTYpiKnfMmk1qDWu59l63lTJYgsQXGFxTuLDwLYSTkvVFgWyT8j8ry7CpYgMU1jKSVrVabVrW/SXIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707545; c=relaxed/simple;
	bh=UqPbGCUYjGyEh6y/xNgn0aI3KQYasiL1GulTu/YZe4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpbN1unLQITe/YEnJayy2ysGLbupB4qyuNVxGD8LIEF1Y0ayrN6XIfnEFx3TLmC/z4k4XFLWOT1uflszNwfoDdWs7bNjENfNmO70i7a2QgTnQ+RH2EizQaKZj5Y+TFleBvtyKzsArDCCqdnf/IZ2KrxJrq2LNDqQkNmZujZzw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835D3FEC;
	Thu, 11 Jul 2024 07:19:28 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B61A3F766;
	Thu, 11 Jul 2024 07:19:00 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:18:58 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Message-ID: <Zo_p0jMOh3cimNig@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-4-cristian.marussi@arm.com>
 <PAXPR04MB845936D3FE063B7009B3F45088A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845936D3FE063B7009B3F45088A52@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jul 11, 2024 at 12:54:51PM +0000, Peng Fan wrote:
> > Subject: [PATCH v2 3/8] firmware: arm_scmi: Add support for
> > standalone transport drivers
> > 

Hi Peng,

> > Extend the core SCMI stack with structures and methods to allow for
> > transports to be split out as standalone drivers, while still supporting
> > old style transports, defined as built into the SCMI core stack.
> > 
> > No functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > NOTE: old style transport support will be removed later in this series.
> > 
> > v1 --> v2
> > - fixed comit message
> > ---
> >  drivers/firmware/arm_scmi/common.h | 84
> > ++++++++++++++++++++++++++++++
> > drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-
> >  drivers/firmware/arm_scmi/msg.c    |  5 ++
> >  drivers/firmware/arm_scmi/shmem.c  |  5 ++
> >  4 files changed, 136 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h
> > b/drivers/firmware/arm_scmi/common.h
> > index 8e5751aaa600..4af06810eb39 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -349,6 +349,8 @@ struct scmi_shared_mem_operations {
> >  				     bool tx, struct resource *res);  };
> > 
> > +const struct scmi_shared_mem_operations
> > +*scmi_shared_mem_operations_get(void);
> > +
> >  /* declarations for message passing transports */  struct
> > scmi_msg_payld;
> > 
> > @@ -376,6 +378,88 @@ struct scmi_message_operations {
> >  				   size_t max_len, struct scmi_xfer
> > *xfer);  };
> > 
> > +const struct scmi_message_operations
> > +*scmi_message_operations_get(void);
> > +
> > +/**
> > + * struct scmi_transport_core_operations  - Transpoert core
> > operations
> > + *
> > + * @bad_message_trace: An helper to report a
> > malformed/unexpected
> > +message
> > + * @rx_callback: Callback to report received messages
> > + * @shmem: Datagram operations for shared memory based
> > transports
> > + * @msg: Datagram operations for message based transports  */
> > struct
> > +scmi_transport_core_operations {
> > +	void (*bad_message_trace)(struct scmi_chan_info *cinfo,
> > +				  u32 msg_hdr, enum scmi_bad_msg
> > err);
> > +	void (*rx_callback)(struct scmi_chan_info *cinfo, u32 msg_hdr,
> > +			    void *priv);
> > +	const struct scmi_shared_mem_operations *shmem;
> > +	const struct scmi_message_operations *msg; };
> > +
> > +/**
> > + * struct scmi_transport  - A structure representing a configured
> > +transport
> > + *
> > + * @supplier: Device representimng the transport and acting as a
> > supplier for
> > + *	      the core SCMI stack
> > + * @desc: Transport descriptor
> > + * @core_ops: A pointer to a pointer used by the core SCMI stack to
> > make the
> > + *	      core transport operations accessible to the transports.
> > + */
> > +struct scmi_transport {
> > +	struct device *supplier;
> > +	const struct scmi_desc *desc;
> > +	struct scmi_transport_core_operations **core_ops; };
> > +
> > +#define DEFINE_SCMI_TRANSPORT_DRIVER(__trans, __match_table,
> > __core_ptr)\
> > +static int __trans##_probe(struct platform_device *pdev)		\
> > +{
> > 	\
> > +	struct scmi_transport *scmi_trans;
> > 	\
> > +	struct platform_device *scmi_pdev;
> > 	\
> > +	struct device *dev = &pdev->dev;				\
> > +
> > 	\
> > +	scmi_trans = devm_kzalloc(dev, sizeof(*scmi_trans),
> > GFP_KERNEL);\
> > +	if (!scmi_trans)						\
> > +		return -ENOMEM;
> > 		\
> > +
> > 	\
> > +	scmi_pdev = devm_kzalloc(dev, sizeof(*scmi_pdev),
> > GFP_KERNEL);	\
> > +	if (!scmi_pdev)
> > 	\
> > +		return -ENOMEM;
> > 		\
> > +
> > 	\
> > +	scmi_trans->supplier = dev;
> > 	\
> > +	scmi_trans->desc = &__trans##_desc;
> > 	\
> > +	scmi_trans->core_ops = __core_ptr;
> > 	\
> > +
> > 	\
> > +	scmi_pdev->name = "arm-scmi";
> > 	\
> > +	scmi_pdev->id = PLATFORM_DEVID_AUTO;
> > 		\
> > +	scmi_pdev->dev.platform_data = scmi_trans;
> > 	\
> > +
> > 	\
> > +	device_set_of_node_from_dev(&scmi_pdev->dev, dev);
> > 	\
> > +
> > 	\
> > +	dev_set_drvdata(dev, scmi_pdev);
> > 	\
> > +
> > 	\
> > +	return platform_device_register(scmi_pdev);
> > 	\
> > +}
> > 	\
> > +
> > 	\
> > +static void __trans##_remove(struct platform_device *pdev)
> > 	\
> > +{
> > 	\
> > +	struct platform_device *scmi_pdev;
> > 	\
> > +
> > 	\
> > +	scmi_pdev = dev_get_drvdata(&pdev->dev);
> > 	\
> > +
> > 	\
> > +	platform_device_unregister(scmi_pdev);
> > 	\
> > +}
> > 	\
> > +
> > 	\
> > +static struct platform_driver __trans##_driver = {			\
> > +	.driver = {
> > 	\
> > +		   .name = #__trans "_transport",			\
> > +		   .of_match_table = __match_table,
> > 	\
> > +		   },
> > 	\
> > +	.probe = __trans##_probe,
> > 	\
> > +	.remove_new = __trans##_remove,
> > 		\
> > +}
> > +
> >  extern const struct scmi_shared_mem_operations scmi_shmem_ops;
> > extern const struct scmi_message_operations scmi_msg_ops;
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c
> > b/drivers/firmware/arm_scmi/driver.c
> > index 6b6957f4743f..a1892d4d8c69 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -194,6 +194,11 @@ struct scmi_info {
> >  #define bus_nb_to_scmi_info(nb)	container_of(nb, struct
> > scmi_info, bus_nb)
> >  #define req_nb_to_scmi_info(nb)	container_of(nb, struct
> > scmi_info, dev_req_nb)
> > 
> > +static struct scmi_transport_core_operations scmi_trans_core_ops = {
> > +	.bad_message_trace = scmi_bad_message_trace,
> > +	.rx_callback = scmi_rx_callback,
> > +};
> > +
> >  static unsigned long
> >  scmi_vendor_protocol_signature(unsigned int protocol_id, char
> > *vendor_id,
> >  			       char *sub_vendor_id, u32 impl_ver) @@
> > -2950,6 +2955,28 @@ static int scmi_debugfs_raw_mode_setup(struct
> > scmi_info *info)
> >  	return ret;
> >  }
> > 
> > +static const struct scmi_desc *scmi_transport_lookup(struct device
> > +*dev) {
> > +	struct scmi_transport *trans;
> > +
> > +	trans = dev_get_platdata(dev);
> > +	if (!trans || !trans->desc || !trans->supplier || !trans-
> > >core_ops)
> > +		return NULL;
> > +
> > +	if (!device_link_add(dev, trans->supplier,
> > DL_FLAG_AUTOREMOVE_CONSUMER)) {
> 
> Just wonder why this is needed?

Oh, that is absolutely needed, because it unleashes the power of device_link ! 
(..and I jus discovered this myself only recently :P ...)..if I got your
question right....

...and that, together with the AUTOREMOVE_CONSUMER flag, means in other words
that the transport device is linked as a supplier to the consumer SCMI core
stack devices, and as a consequence you are absolutely free to abruptly
unload/unbind the transport driver at any time and be sure that before that
can happen the full SCMI stack will be FULLY UNBOUND too...so stopping any
SCMI communication before the transport module is unloaded/unbound....

...and this, more importantly, happens without ME having to write ANY line of
code :P....just thanks to the device_link core magic...

...or at least this is my understanding and 

> > +		dev_err(dev,
> > +			"Adding link to supplier transport device
> > failed\n");
> > +		return NULL;
> > +	}
> > +
> > +	/* Provide core transport ops */
> > +	*trans->core_ops = &scmi_trans_core_ops;
> > +
> > +	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
> > +
> > +	return trans->desc;
> > +}
> > +
> >  static int scmi_probe(struct platform_device *pdev)  {
> >  	int ret;
> > @@ -2962,8 +2989,14 @@ static int scmi_probe(struct
> > platform_device *pdev)
> >  	struct device_node *child, *np = dev->of_node;
> > 
> >  	desc = of_device_get_match_data(dev);
> > -	if (!desc)
> > -		return -EINVAL;
> > +	if (!desc) {
> > +		desc = scmi_transport_lookup(dev);
> 
> from the code, It is not actually a lookup operation.
> How about scmi_transport_setup?
> 

Oh, yes...funny thing is that it is how exactly I DID called this
function initially....then I spotted that there was already a similar
__scmi_trancport_setup() helper in the legacy code that I removed, so I
tried to use another more distinct name....I could go back to
scmi_transport_setup indeed..

Thanks,
Cristian

