Return-Path: <linux-kernel+bounces-263413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8B93D57D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830151C2324E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3322F1E;
	Fri, 26 Jul 2024 14:59:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA881CD06;
	Fri, 26 Jul 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005995; cv=none; b=kwJJIG8Y88OWypmGTm39J8YBL+13iVgUePdWXIblT76JdA+JL7GJkWFml2gS5V4nFiLmnOKOY9WnowIn7ZNHFnNJHu+T1gpZyGTUx61z1wh6HMBX3WzohUgs/6wfz98DtwqHKWLKNXzwfXy5Y7C8F80IwVs6MFtKBVocsJh0sEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005995; c=relaxed/simple;
	bh=Z+IXqHPvu0QjnxMwJZmPnfBlEEwxqkA0soVAPOmSrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfAyomb3p4dpKmziPXs3ddDa+kHSLGr4M+oFhorlhckh+OYLiy6reaYmiGgG25BYWKzWUKOsFLDATrESHmVHH0uQL1SujaBz0LJ1pp8xkPyC8IgcLaJktFW6a4B5XXLHE2i02tQfOTvEIORWLE8p2ekyDeg7DL6C5u361y4WuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CD41007;
	Fri, 26 Jul 2024 08:00:18 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02BE3F73F;
	Fri, 26 Jul 2024 07:59:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:59:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 3/8] firmware: arm_scmi: Add support for standalone
 transport drivers
Message-ID: <ZqO54KACyHUUYEXj@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-4-cristian.marussi@arm.com>
 <PAXPR10MB4687B74810CA8EDB5BFC4781FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687B74810CA8EDB5BFC4781FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Jul 23, 2024 at 01:39:41PM +0000, Etienne CARRIERE wrote:
> Hi Cristian,
> 
> Few nitpicking comments.
> 
> On Wednesday, July 10, 2024, Cristian Marussi wrote:  
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
> >  drivers/firmware/arm_scmi/common.h | 84 ++++++++++++++++++++++++++++++
> >  drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-
> >  drivers/firmware/arm_scmi/msg.c    |  5 ++
> >  drivers/firmware/arm_scmi/shmem.c  |  5 ++
> >  4 files changed, 136 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 8e5751aaa600..4af06810eb39 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -349,6 +349,8 @@ struct scmi_shared_mem_operations {
> >                                       bool tx, struct resource *res);
> >  };
> >  
> > +const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
> > +
> >  /* declarations for message passing transports */
> >  struct scmi_msg_payld;
> >  
> > @@ -376,6 +378,88 @@ struct scmi_message_operations {
> >                                     size_t max_len, struct scmi_xfer *xfer);
> >  };
> >  
> > +const struct scmi_message_operations *scmi_message_operations_get(void);
> > +
> > +/**
> > + * struct scmi_transport_core_operations  - Transpoert core operations
> > + *
> > + * @bad_message_trace: An helper to report a malformed/unexpected message
> > + * @rx_callback: Callback to report received messages
> > + * @shmem: Datagram operations for shared memory based transports
> > + * @msg: Datagram operations for message based transports
> > + */
> > +struct scmi_transport_core_operations {
> > +       void (*bad_message_trace)(struct scmi_chan_info *cinfo,
> > +                                 u32 msg_hdr, enum scmi_bad_msg err);
> > +       void (*rx_callback)(struct scmi_chan_info *cinfo, u32 msg_hdr,
> > +                           void *priv);
> > +       const struct scmi_shared_mem_operations *shmem;
> > +       const struct scmi_message_operations *msg;
> > +};
> > +
> > +/**
> > + * struct scmi_transport  - A structure representing a configured transport
> > + *
> > + * @supplier: Device representimng the transport and acting as a supplier for
> 
> typo: s/representimng/representing/
> 

Fixed in V3. (...still to be posted)

> > + *           the core SCMI stack
> > + * @desc: Transport descriptor
> > + * @core_ops: A pointer to a pointer used by the core SCMI stack to make the
> > + *           core transport operations accessible to the transports.
> > + */
> > +struct scmi_transport {
> > +       struct device *supplier;
> > +       const struct scmi_desc *desc;
> > +       struct scmi_transport_core_operations **core_ops;
> > +};
> > +
> > +#define DEFINE_SCMI_TRANSPORT_DRIVER(__trans, __match_table, __core_ptr)\
> > +static int __trans##_probe(struct platform_device *pdev)               \
> > +{                                                                      \
> > +       struct scmi_transport *scmi_trans;                              \
> > +       struct platform_device *scmi_pdev;                              \
> > +       struct device *dev = &pdev->dev;                                \
> > +                                                                       \
> > +       scmi_trans = devm_kzalloc(dev, sizeof(*scmi_trans), GFP_KERNEL);\
> > +       if (!scmi_trans)                                                \
> > +               return -ENOMEM;                                         \
> > +                                                                       \
> > +       scmi_pdev = devm_kzalloc(dev, sizeof(*scmi_pdev), GFP_KERNEL);  \
> > +       if (!scmi_pdev)                                                 \
> > +               return -ENOMEM;                                         \
> > +                                                                       \
> > +       scmi_trans->supplier = dev;                                     \
> > +       scmi_trans->desc = &__trans##_desc;                             \
> 
> It's a bit weird the scmi_desc shall be specifically labeled __trans##_desc
> in the transport driver source file while match table and transport core
> operations instances references are passed as arguments. I think it's 
> worth having the scmi_desc label also passed as an argument to
> DEFINE_SCMI_TRANSPORT_DRIVER() macro.

Yes, I agree, I was unsure about this so I have reworked all of these in
V3 to pass as explicit parameter the driver name and desc name.

> 
> > +       scmi_trans->core_ops = __core_ptr;                              \
> > +                                                                       \
> > +       scmi_pdev->name = "arm-scmi";                                   \
> > +       scmi_pdev->id = PLATFORM_DEVID_AUTO;                            \
> > +       scmi_pdev->dev.platform_data = scmi_trans;                      \
> > +                                                                       \
> > +       device_set_of_node_from_dev(&scmi_pdev->dev, dev);              \
> > +                                                                       \
> > +       dev_set_drvdata(dev, scmi_pdev);                                \
> > +                                                                       \
> > +       return platform_device_register(scmi_pdev);                     \
> > +}                                                                      \
> > +                                                                       \
> > +static void __trans##_remove(struct platform_device *pdev)             \
> > +{                                                                      \
> > +       struct platform_device *scmi_pdev;                              \
> > +                                                                       \
> > +       scmi_pdev = dev_get_drvdata(&pdev->dev);                        \
> > +                                                                       \
> > +       platform_device_unregister(scmi_pdev);                          \
> > +}                                                                      \
> > +                                                                       \
> > +static struct platform_driver __trans##_driver = {                     \
> 
> Same here. I think __trans##_driver label should be also explicitly
> passed as an argument to DEFINE_SCMI_TRANSPORT_DRIVER().
> 

Fixed in V3.

Thanks,
Cristian

