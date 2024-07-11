Return-Path: <linux-kernel+bounces-249358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F220892EA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861F31F232B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33D01662E2;
	Thu, 11 Jul 2024 14:20:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A015ECCA;
	Thu, 11 Jul 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707649; cv=none; b=JPHeHSi29KbC+L0hcISvPzKIUKMdRSQPTkYjt7EoHAsP2S+Gr0pHjKmMsPSaaeaEj4B6KEcZWW+QBLuAmFJqMqD3eOyehfspD1X09OYwv7H/87YrMQHEUBWLyftNUVDugMz7aqStv2+TdGOq2KxJpKlHj1kbkwdrUvXovqI5P4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707649; c=relaxed/simple;
	bh=pquOPkCraFMTEeTmUKF4GVnjPOMtCd1vv88fzoBbSas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AczJMlsyLKyFDpG0H8XS1Q9l+YUzfqek3Oyz5GlZglL4XQn2rjUZITpkv4tEE1Pe9Vjo/Dz0Ft2+PMIv3e1PmrjlAU+7onHrdfCbOQpEfLR1qF/zGN2AttkJNJa8DyEWeAPYN2p7Wcg2xSlzgQ+jEfd9Jwcc+YOifxoD1lti4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1F14FEC;
	Thu, 11 Jul 2024 07:21:11 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 377EE3F766;
	Thu, 11 Jul 2024 07:20:44 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:20:41 +0100
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
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>,
	Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a
 standalone driver
Message-ID: <Zo_qOcRa11INO8cs@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-7-cristian.marussi@arm.com>
 <PAXPR04MB8459B0299D11F08605C20BB988A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459B0299D11F08605C20BB988A52@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Jul 11, 2024 at 12:57:46PM +0000, Peng Fan wrote:
> > Subject: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a
> > standalone driver
> > 
> > Make SCMI OPTEE transport a standalone driver that can be optionally
> > loaded as a module.
> > 
> > CC: Etienne Carriere <etienne.carriere@foss.st.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - handle platform_driver_register() failures
> > ---
> >  drivers/firmware/arm_scmi/Kconfig             |  6 +-
> >  drivers/firmware/arm_scmi/Makefile            |  2 +-
> >  drivers/firmware/arm_scmi/common.h            |  3 -
> >  drivers/firmware/arm_scmi/driver.c            |  3 -
> >  .../{optee.c => scmi_transport_optee.c}       | 91 ++++++++++---------
> >  5 files changed, 52 insertions(+), 53 deletions(-)  rename
> > drivers/firmware/arm_scmi/{optee.c => scmi_transport_optee.c} (90%)
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig
> > b/drivers/firmware/arm_scmi/Kconfig
> > index a4d44ef8bf45..def7e3f09356 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -89,8 +89,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX
> >  	  will be called scmi_transport_mailbox.
> > 
> >  config ARM_SCMI_TRANSPORT_OPTEE
> > -	bool "SCMI transport based on OP-TEE service"
> > -	depends on OPTEE=y || OPTEE=ARM_SCMI_PROTOCOL
> > +	tristate "SCMI transport based on OP-TEE service"
> > +	depends on OPTEE
> >  	select ARM_SCMI_HAVE_TRANSPORT
> >  	select ARM_SCMI_HAVE_SHMEM
> >  	select ARM_SCMI_HAVE_MSG
> > @@ -100,6 +100,8 @@ config ARM_SCMI_TRANSPORT_OPTEE
> > 
> >  	  If you want the ARM SCMI PROTOCOL stack to include
> > support for a
> >  	  transport based on OP-TEE SCMI service, answer Y.
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called scmi_transport_optee.
> > 
> >  config ARM_SCMI_TRANSPORT_SMC
> >  	tristate "SCMI transport based on SMC"
> > diff --git a/drivers/firmware/arm_scmi/Makefile
> > b/drivers/firmware/arm_scmi/Makefile
> > index 6868a47fa4ab..b04119ce972f 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -7,13 +7,13 @@ scmi-driver-
> > $(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
> > -scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> > scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o
> > system.o voltage.o powercap.o  scmi-protocols-y += pinctrl.o  scmi-
> > module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
> > 
> >  obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) +=
> > scmi_transport_smc.o
> >  obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) +=
> > scmi_transport_mailbox.o
> > +obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) +=
> > scmi_transport_optee.o
> > 
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o diff --git
> > a/drivers/firmware/arm_scmi/common.h
> > b/drivers/firmware/arm_scmi/common.h
> > index edb786cde25c..0ce1d804b3fc 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -289,9 +289,6 @@ int
> > scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info
> > *cinfo,  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO  extern const
> > struct scmi_desc scmi_virtio_desc;  #endif -#ifdef
> > CONFIG_ARM_SCMI_TRANSPORT_OPTEE -extern const struct
> > scmi_desc scmi_optee_desc; -#endif
> > 
> >  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
> > void *priv);
> > 
> > diff --git a/drivers/firmware/arm_scmi/driver.c
> > b/drivers/firmware/arm_scmi/driver.c
> > index b14c5326930a..67b416c7f2f5 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -3251,9 +3251,6 @@ ATTRIBUTE_GROUPS(versions);
> > 
> >  /* Each compatible listed below must have descriptor associated with
> > it */  static const struct of_device_id scmi_of_match[] = { -#ifdef
> > CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> > -	{ .compatible = "linaro,scmi-optee", .data =
> > &scmi_optee_desc },
> > -#endif
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> > #endif diff --git a/drivers/firmware/arm_scmi/optee.c
> > b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> > similarity index 90%
> > rename from drivers/firmware/arm_scmi/optee.c rename to
> > drivers/firmware/arm_scmi/scmi_transport_optee.c
> > index 99f3b0bfb956..7a16c8d3e213 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright (C) 2019-2021 Linaro Ltd.
> > + * Copyright (C) 2019-2024 Linaro Ltd.
> 
> This should be kept unchanged?

Not sure, like I said previously, how to go about years.
Thanks,
Cristian

