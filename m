Return-Path: <linux-kernel+bounces-244468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DA92A4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88D81F21C88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831013CFBD;
	Mon,  8 Jul 2024 14:27:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFA4C9B;
	Mon,  8 Jul 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448861; cv=none; b=RcnHPIVgkqs7pwdGg9U1ceaQ8hcho/A0p+AAh+zV70C6jBIWdmKk+VVGh+SSiTK9necj/XKBABGldI8RFGzDnUECB0+hb64wHYCbnfldtKaH2HTv9VvmoaZ9EP8GC+eNdvHBynnmFIsxwqOkANUgrnf2KDFB3e/LRZR7VufY6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448861; c=relaxed/simple;
	bh=9VwKescOrYZcc+z0dhLoM7lX2qmvFfOjgdxFqVQhWUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVCWK5eumx7IbWRxj2himYRSMjtDJbPv7XisKiTplD66dd2RMIAo8puqB5ZBFUewX19as+EkISEt9Y4DhikShYd3OOess+wFfizlryPn3AaYvLCMpw1mm56HJwsEaCpxJe09vcM19WY/wAmEwOqRoqzRsMxLrSQnMeoqT8Sr8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A641042;
	Mon,  8 Jul 2024 07:28:03 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E1BA3F766;
	Mon,  8 Jul 2024 07:27:36 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:27:34 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
Message-ID: <Zov3VppLHotmIO3l@pluto>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-6-cristian.marussi@arm.com>
 <ffb76411-7119-4024-acaa-3cf40f81ed95@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb76411-7119-4024-acaa-3cf40f81ed95@quicinc.com>

On Sun, Jul 07, 2024 at 09:52:49AM -0700, Nikunj Kela wrote:
> 
> On 7/6/2024 5:20 PM, Cristian Marussi wrote:
> > Make SCMI SMC transport a standalone driver that can be optionally
> > loaded as a module.
> >
> > CC: Peng Fan <peng.fan@nxp.com>
> > CC: Nikunj Kela <quic_nkela@quicinc.com>
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/Kconfig             |  4 ++-
> >  drivers/firmware/arm_scmi/Makefile            |  2 +-
> >  drivers/firmware/arm_scmi/common.h            |  3 --
> >  drivers/firmware/arm_scmi/driver.c            |  5 ---
> >  .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 31 +++++++++++++++----
> >  5 files changed, 29 insertions(+), 16 deletions(-)
> >  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (89%)
> >
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index 135e34aefd70..a4d44ef8bf45 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -102,7 +102,7 @@ config ARM_SCMI_TRANSPORT_OPTEE
> >  	  transport based on OP-TEE SCMI service, answer Y.
> >  
> >  config ARM_SCMI_TRANSPORT_SMC
> > -	bool "SCMI transport based on SMC"
> > +	tristate "SCMI transport based on SMC"
> >  	depends on HAVE_ARM_SMCCC_DISCOVERY
> >  	select ARM_SCMI_HAVE_TRANSPORT
> >  	select ARM_SCMI_HAVE_SHMEM
> > @@ -112,6 +112,8 @@ config ARM_SCMI_TRANSPORT_SMC
> >  
> >  	  If you want the ARM SCMI PROTOCOL stack to include support for a
> >  	  transport based on SMC, answer Y.
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called scmi_transport_smc.
> >  
> >  config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
> >  	bool "Enable atomic mode support for SCMI SMC transport"
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > index 121612d75f0b..6868a47fa4ab 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -5,7 +5,6 @@ scmi-core-objs := $(scmi-bus-y)
> >  scmi-driver-y = driver.o notify.o
> >  scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
> > -scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
> >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> > @@ -13,6 +12,7 @@ scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o vol
> >  scmi-protocols-y += pinctrl.o
> >  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
> >  
> > +obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
> >  obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
> >  
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index c03f30db92e0..b5bd27eccf24 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
> >  int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
> >  					    struct scmi_xfer *xfer,
> >  					    unsigned int timeout_ms);
> > -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> > -extern const struct scmi_desc scmi_smc_desc;
> > -#endif
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >  extern const struct scmi_desc scmi_virtio_desc;
> >  #endif
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index 96cf8ab4421e..b14c5326930a 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -3254,11 +3254,6 @@ static const struct of_device_id scmi_of_match[] = {
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
> >  	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
> >  #endif
> > -#ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
> > -	{ .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
> > -	{ .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
> > -	{ .compatible = "qcom,scmi-smc", .data = &scmi_smc_desc},
> > -#endif
> >  #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
> >  	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
> >  #endif
> > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> > similarity index 89%
> > rename from drivers/firmware/arm_scmi/smc.c
> > rename to drivers/firmware/arm_scmi/scmi_transport_smc.c
> > index cb26b8aee01d..44da1a8d5387 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> > @@ -3,7 +3,7 @@
> >   * System Control and Management Interface (SCMI) Message SMC/HVC
> >   * Transport driver
> >   *
> > - * Copyright 2020 NXP
> > + * Copyright 2020-2024 NXP
> >   */
> >  
> >  #include <linux/arm-smccc.h>
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/limits.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/processor.h>
> >  #include <linux/slab.h>
> >  
> > @@ -69,12 +70,14 @@ struct scmi_smc {
> >  	unsigned long cap_id;
> >  };
> >  
> > +static struct scmi_transport_core_operations *core;
> > +
> >  static irqreturn_t smc_msg_done_isr(int irq, void *data)
> >  {
> >  	struct scmi_smc *scmi_info = data;
> >  
> > -	scmi_rx_callback(scmi_info->cinfo,
> > -			 scmi_shmem_ops.read_header(scmi_info->shmem), NULL);
> > +	core->rx_callback(scmi_info->cinfo,
> > +			  core->shmem->read_header(scmi_info->shmem), NULL);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > @@ -142,7 +145,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> >  	if (!scmi_info)
> >  		return -ENOMEM;
> >  
> > -	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
> > +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx);
> >  	if (IS_ERR(scmi_info->shmem))
> >  		return PTR_ERR(scmi_info->shmem);
> >  
> > @@ -226,7 +229,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >  	 */
> >  	smc_channel_lock_acquire(scmi_info, xfer);
> >  
> > -	scmi_shmem_ops.tx_prepare(scmi_info->shmem, xfer, cinfo);
> > +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
> >  
> >  	if (scmi_info->cap_id != ULONG_MAX)
> >  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
> > @@ -250,7 +253,7 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
> >  {
> >  	struct scmi_smc *scmi_info = cinfo->transport_info;
> >  
> > -	scmi_shmem_ops.fetch_response(scmi_info->shmem, xfer);
> > +	core->shmem->fetch_response(scmi_info->shmem, xfer);
> >  }
> >  
> >  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> > @@ -286,3 +289,19 @@ const struct scmi_desc scmi_smc_desc = {
> >  	.sync_cmds_completed_on_ret = true,
> >  	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE),
> >  };
> > +
> > +static const struct of_device_id scmi_of_match[] = {
> > +	{ .compatible = "arm,scmi-smc" },
> > +	{ .compatible = "arm,scmi-smc-param" },
> > +	{ .compatible = "qcom,scmi-smc" },
> > +	{ /* Sentinel */ },
> > +};
> > +
> 
> Hi Cristian,
> 

Hi Nikunj,

thanks for having a look first of all !

> Would it make sense to associate scmi descriptor(scmi_smc_desc) with
> compatible as driver/platform data so we have flexibility to replicate
> it and modify parameters such as max_timeout_ms etc. for our platform?
> 

Mmmm...not sure to have understood, because the scmi_smc_desc is
effecetively passed from this driver to the core via a bit of
(questionable) magic in the mega-macro

DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_of_match, &core);

...and it will end-up being set into the dev.platform_data and then
retrieved by the core SCMI stack driver in scmi_probe...

...OR...do you mean being able to somehow define 3 different
scmi_smc_desc* and then associate them to the different compatibles
and then, depending on which compatible is matched by this isame driver
at probe time, passing the related platform-specific desc to the core...

...in this latter case I suppose I can do it by playing with the macros
defs but maybe it is also the case to start thinking about splitting out
configuration stuff from the transport descriptor...

I'll give it a go at passing the data around, and see how it plays out
if you confirm that this is what you meant...

Thanks,
Cristian

