Return-Path: <linux-kernel+bounces-290106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DD954F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4164F2855E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE791AD9E2;
	Fri, 16 Aug 2024 17:02:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6D1C0DD9;
	Fri, 16 Aug 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827758; cv=none; b=sUBkNq2GVvTQbgLipLPUGTz2HVny/J8h57rp1TaiTBC+LiVrKxslGTdje6I2429VuWmQ4p4V32tTRGYo0C9mwU4K7RB4EFuKt5WkeIwpvfht54nqOhKZJxvgWGO3fskQ6wfgIqkheld0O8hsKZzsGRML9wYOHxltOeZ7SM7n444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827758; c=relaxed/simple;
	bh=Ot/n5s06qw38mDDK49PTu1SLslBITdduMt3qnpRD3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYgIsMTjpc0vADY68KonFli3L/XtRhXt5J3reL0BzdYMWjPUt+ldl2r5HfByevHGKBYQH0zzEK83yJBHSaCjmcsUTjOoxNo74vNO+DeqLIRA0vYJPpWTQ9KSSbUnizifLhAivv7JNLln4Bc48A9lsPgR8hvQ6prZ/mS2AtxeBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2BB13D5;
	Fri, 16 Aug 2024 10:03:01 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59FC53F58B;
	Fri, 16 Aug 2024 10:02:33 -0700 (PDT)
Date: Fri, 16 Aug 2024 18:02:30 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <Zr-GJts3Gu6GEkhC@pluto>
References: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
 <20240813180747.1439034-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813180747.1439034-3-florian.fainelli@broadcom.com>

On Tue, Aug 13, 2024 at 11:07:47AM -0700, Florian Fainelli wrote:
> Some shared memory areas might only support a certain access width,
> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> on ARM64 by making both 8-bit and 64-bit accesses to such memory.
> 
> Update the shmem layer to support reading from and writing to such
> shared memory area using the specified I/O width in the Device Tree. The
> various transport layers making use of the shmem.c code are updated
> accordingly to pass the I/O accessors that they store.
> 

Hi Florian,

I gave it ago at this on a JUNO regarding the mailbox/shmem transport
without any issue. I'll have a go later on an OPTEE/shmem scenario too.

This looks fundamentally good to me, since you moved all ops setup at
setup time and you keep the pointers per-channel instead of global...

A few remarks down below.

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/firmware/arm_scmi/common.h            | 32 +++++++-
>  .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
>  .../firmware/arm_scmi/scmi_transport_optee.c  | 10 ++-
>  .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
>  drivers/firmware/arm_scmi/shmem.c             | 81 +++++++++++++++++--
>  5 files changed, 126 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 69928bbd01c2..73bb496fac01 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -316,6 +316,26 @@ enum scmi_bad_msg {
>  	MSG_MBOX_SPURIOUS = -5,
>  };
>  
> +/* Used for compactness and signature validation of the function pointers being
> + * passed.
> + */
> +typedef void (*shmem_copy_toio_t)(volatile void __iomem *to, const void *from,
> +				  size_t count);
> +typedef void (*shmem_copy_fromio_t)(void *to, const volatile void __iomem *from,
> +				    size_t count);
> +
> +/**
> + * struct scmi_shmem_io_ops  - I/O operations to read from/write to
> + * Shared Memory
> + *
> + * @toio: Copy data to the shared memory area
> + * @fromio: Copy data from the shared memory area
> + */
> +struct scmi_shmem_io_ops {
> +	shmem_copy_fromio_t fromio;
> +	shmem_copy_toio_t toio;
> +};
> +
>  /* shmem related declarations */
>  struct scmi_shared_mem;
>  
> @@ -336,13 +356,16 @@ struct scmi_shared_mem;
>  struct scmi_shared_mem_operations {
>  	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
>  			   struct scmi_xfer *xfer,
> -			   struct scmi_chan_info *cinfo);
> +			   struct scmi_chan_info *cinfo,
> +			   shmem_copy_toio_t toio);
>  	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
>  
>  	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
> -			       struct scmi_xfer *xfer);
> +			       struct scmi_xfer *xfer,
> +			       shmem_copy_fromio_t fromio);
>  	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
> -				   size_t max_len, struct scmi_xfer *xfer);
> +				   size_t max_len, struct scmi_xfer *xfer,
> +				   shmem_copy_fromio_t fromio);
>  	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
>  	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
>  			  struct scmi_xfer *xfer);
> @@ -350,7 +373,8 @@ struct scmi_shared_mem_operations {
>  	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
>  	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
>  				     struct device *dev,
> -				     bool tx, struct resource *res);
> +				     bool tx, struct resource *res,
> +				     struct scmi_shmem_io_ops **ops);
>  };
>  
>  const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
> diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> index dc5ca894d5eb..2a624870954d 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> @@ -25,6 +25,7 @@
>   * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
>   * @cinfo: SCMI channel info
>   * @shmem: Transmit/Receive shared memory area
> + * @shmem_io_ops: Transport specific I/O operations

Fix the doxy param name...it s op_ops now.

>   */
>  struct scmi_mailbox {
>  	struct mbox_client cl;
> @@ -33,6 +34,7 @@ struct scmi_mailbox {
>  	struct mbox_chan *chan_platform_receiver;
>  	struct scmi_chan_info *cinfo;
>  	struct scmi_shared_mem __iomem *shmem;
> +	struct scmi_shmem_io_ops *io_ops;
>  };
>  
>  #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
> @@ -43,7 +45,8 @@ static void tx_prepare(struct mbox_client *cl, void *m)
>  {
>  	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
>  
> -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
> +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
> +				smbox->io_ops->toio);
>  }
>  
>  static void rx_callback(struct mbox_client *cl, void *m)
> @@ -197,7 +200,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!smbox)
>  		return -ENOMEM;
>  
> -	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
> +	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL,
> +						&smbox->io_ops);
>  	if (IS_ERR(smbox->shmem))
>  		return PTR_ERR(smbox->shmem);
>  
> @@ -298,7 +302,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_mailbox *smbox = cinfo->transport_info;
>  
> -	core->shmem->fetch_response(smbox->shmem, xfer);
> +	core->shmem->fetch_response(smbox->shmem, xfer, smbox->io_ops->fromio);
>  }
>  
>  static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> @@ -306,7 +310,8 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_mailbox *smbox = cinfo->transport_info;
>  
> -	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
> +	core->shmem->fetch_notification(smbox->shmem, max_len, xfer,
> +					smbox->io_ops->fromio);
>  }
>  
>  static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
> diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> index 08911f40d1ff..fba312128426 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> @@ -128,6 +128,7 @@ struct scmi_optee_channel {
>  		struct scmi_shared_mem __iomem *shmem;
>  		struct scmi_msg_payld *msg;
>  	} req;
> +	struct scmi_shmem_io_ops *io_ops;

Describe this in the doxy....

>  	struct tee_shm *tee_shm;
>  	struct list_head link;
>  };
> @@ -350,7 +351,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
>  static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>  			      struct scmi_optee_channel *channel)
>  {
> -	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
> +	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
> +						      &channel->io_ops);
>  	if (IS_ERR(channel->req.shmem))
>  		return PTR_ERR(channel->req.shmem);
>  
> @@ -465,7 +467,8 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
>  		ret = invoke_process_msg_channel(channel,
>  						 core->msg->command_size(xfer));
>  	} else {
> -		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
> +		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo,
> +					channel->io_ops->toio);
>  		ret = invoke_process_smt_channel(channel);
>  	}
>  
> @@ -484,7 +487,8 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
>  		core->msg->fetch_response(channel->req.msg,
>  					  channel->rx_len, xfer);
>  	else
> -		core->shmem->fetch_response(channel->req.shmem, xfer);
> +		core->shmem->fetch_response(channel->req.shmem, xfer,
> +					    channel->io_ops->fromio);
>  }
>  
>  static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> index c6c69a17a9cc..1de06c2fc63a 100644
> --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> @@ -45,6 +45,7 @@
>   * @irq: An optional IRQ for completion
>   * @cinfo: SCMI channel info
>   * @shmem: Transmit/Receive shared memory area
> + * @shmem_io_ops: Transport specific I/O operations

Fix doxy param name 

>   * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
>   *		Used when NOT operating in atomic mode.
>   * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
> @@ -60,6 +61,7 @@ struct scmi_smc {
>  	int irq;
>  	struct scmi_chan_info *cinfo;
>  	struct scmi_shared_mem __iomem *shmem;
> +	struct scmi_shmem_io_ops *io_ops;
>  	/* Protect access to shmem area */
>  	struct mutex shmem_lock;
>  #define INFLIGHT_NONE	MSG_TOKEN_MAX
> @@ -144,7 +146,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  	if (!scmi_info)
>  		return -ENOMEM;
>  
> -	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res,
> +						    &scmi_info->io_ops);
>  	if (IS_ERR(scmi_info->shmem))
>  		return PTR_ERR(scmi_info->shmem);
>  
> @@ -229,7 +232,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  	 */
>  	smc_channel_lock_acquire(scmi_info, xfer);
>  
> -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
> +				scmi_info->io_ops->toio);
>  
>  	if (scmi_info->cap_id != ULONG_MAX)
>  		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
> @@ -253,7 +257,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
>  {
>  	struct scmi_smc *scmi_info = cinfo->transport_info;
>  
> -	core->shmem->fetch_response(scmi_info->shmem, xfer);
> +	core->shmem->fetch_response(scmi_info->shmem, xfer,
> +				    scmi_info->io_ops->fromio);
>  }
>  
>  static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
> index 01d8a9398fe8..139bbbc4b2ee 100644
> --- a/drivers/firmware/arm_scmi/shmem.c
> +++ b/drivers/firmware/arm_scmi/shmem.c
> @@ -34,9 +34,62 @@ struct scmi_shared_mem {
>  	u8 msg_payload[];
>  };
>  
> +#define SHMEM_IO_OPS(w, s, amt)						\
> +static inline void shmem_memcpy_fromio##s(void *to,			\
> +					  const volatile void __iomem *from, \
> +					  size_t count)			\
> +{									\
> +	while (count) {							\
> +		*(u##s *)to = __raw_read##w(from);			\
> +		from += amt;						\
> +		to += amt;						\
> +		count -= amt;						\
> +	}								\
> +}			

... I may be missing a lot here...bear with me...so...

... AFAIU, as suggested by Peng, you moved away from iowrite##s and ioread##s
in favour of __raw_write/read##w so as to avoid the implicit barriers on each
loop iteration...(I suppose..)

...but should we place some sort of final io barrier (similarly to iowrite)
at the end of the loop ?

> +static inline void shmem_memcpy_toio##s(volatile void __iomem *to,	\
> +					const void *from,		\
> +					size_t count)			\
> +{									\
> +	while (count) {							\
> +		__raw_write##w(*(u##s *)from, to);			\
> +		from += amt;						\
> +		to += amt;						\
> +		count -= amt;						\
> +	}								\
> +}		

...same concern here

> +static struct scmi_shmem_io_ops shmem_io_ops##s = {			\
> +	.fromio	= shmem_memcpy_fromio##s,				\
> +	.toio	= shmem_memcpy_toio##s,					\
> +};
> +

There are a bunch of warn/errs from checkpatch --strict, beside the volatile
here and on the previous typedefs, also about args reuse and trailing semicolon
in these macros...

Thanks,
Cristian

