Return-Path: <linux-kernel+bounces-283549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2494F63A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AA11F22C56
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471218953F;
	Mon, 12 Aug 2024 18:01:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B2C156;
	Mon, 12 Aug 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485688; cv=none; b=d29HvTd+rG52lntczYyk8cH8e7otxdPbifhygh43sgIqQrh8Ansoep/2mPkqfq7RP+y1XwH2ir2zo6b9fQFV8okNvmf3gaVg8rlkISi2Y02Sp1t9D8E+4ZYNIWllLPBnABMSJHXSO6mgdm2KdTmFoOr0A+I4PXMedGiqGFih17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485688; c=relaxed/simple;
	bh=u9nLf9o/DevNMh9gjHsIwOxbwLt6bcfwClJj0cF42rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iff5bE7jvnqdaeqar3yJF2BAVmW0mrcri6C3c4SwvVHmgpYGCd7WqOqmimsyB3ZvQ74R+h8/78YO7vC6ztwJI9HIYQ5pQiLe6UBN12ZO2j7/bnWKqldf0Yn71Gj7KjjRlU6Vjj1ksqzvg/4efZ5+IEBHO+a6vGE6yFE/n6FT6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD11FEC;
	Mon, 12 Aug 2024 11:01:44 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02883F6A8;
	Mon, 12 Aug 2024 11:01:16 -0700 (PDT)
Date: Mon, 12 Aug 2024 19:01:04 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, arm-scmi@vger.kernel.org,
	james.quinlan@broadcom.com, justin.chen@broadcom.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
Message-ID: <ZrpNy67GEFpF4p5l@pluto>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
 <ZrpD9rEyw37DV1J1@pluto>
 <40cd771e-5dab-498b-b77d-e0de4281fce9@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40cd771e-5dab-498b-b77d-e0de4281fce9@broadcom.com>

On Mon, Aug 12, 2024 at 10:46:31AM -0700, Florian Fainelli wrote:
> On 8/12/24 10:18, Cristian Marussi wrote:
> > On Sat, Aug 10, 2024 at 02:46:21PM -0700, Florian Fainelli wrote:
> > > Some shared memory areas might only support a certain access width,
> > > (e.g.: 32 bits accesses only). Update the shmem layer to support
> > > reading from and writing to such shared memory area using the specified
> > > I/O width in the Device Tree. The various transport layers making use of
> > > the shmem.c code are updated accordingly to pass the I/O width to the
> > > routines that need it.
> > 
> > Hi Florian,
> > 
> > I only glanced quicky through the series...a few remarks below.
> > 
> > > 
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > ---
> > >   drivers/firmware/arm_scmi/common.h            | 14 +++-
> > >   .../arm_scmi/scmi_transport_mailbox.c         | 12 ++-
> > >   .../firmware/arm_scmi/scmi_transport_optee.c  |  7 +-
> > >   .../firmware/arm_scmi/scmi_transport_smc.c    | 10 ++-
> > >   drivers/firmware/arm_scmi/shmem.c             | 77 ++++++++++++++++---
> > >   5 files changed, 96 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > > index 69928bbd01c2..97dae844a190 100644
> > > --- a/drivers/firmware/arm_scmi/common.h
> > > +++ b/drivers/firmware/arm_scmi/common.h
> > > @@ -170,6 +170,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
> > >    *		       This can be dynamically set by transports at run-time
> > >    *		       inside their provided .chan_setup().
> > >    * @transport_info: Transport layer related information
> > > + * @shmem_io_width: I/O width in bytes of the shared memory area
> > >    */
> > >   struct scmi_chan_info {
> > >   	int id;
> > > @@ -178,6 +179,7 @@ struct scmi_chan_info {
> > >   	struct scmi_handle *handle;
> > >   	bool no_completion_irq;
> > >   	void *transport_info;
> > > +	u32 shmem_io_width;
> > >   };
> > 
> > As you said you dont need this if you embed it inside the
> > transpor_info...but...
> > >   /**
> > > @@ -336,13 +338,16 @@ struct scmi_shared_mem;
> > >   struct scmi_shared_mem_operations {
> > >   	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
> > >   			   struct scmi_xfer *xfer,
> > > -			   struct scmi_chan_info *cinfo);
> > > +			   struct scmi_chan_info *cinfo,
> > > +			   u32 shmem_io_width);
> > 
> > ...maybe also you dont need this additional parameters if you setup
> > upfront the shmem ops to operate ONLY on the configured size...
> > 
> > ...I mean all of this seems to be a one-shot setup procedure so it
> > would be sensible to just configuire the shmem ops pointers once-for all
> > to ONLY use the proper size helper method...since mixed-size usage at
> > runtime seems NOT be an option given how the binding is used...
> > 
> > ...but I can see that in this case you will need to change a bit
> > how the scmi_shared_mem_operations are setup...since now they are a
> > const global and initialized fully at driver init in
> > 
> > 	scmi_trans_core_ops.shmem = scmi_shared_mem_operations_get();
> > 
> > ..so, in case you want to setup only once the properly sized helpers at
> > run-time, all of this should happen instead at probe-time and you should
> > have a per-probe-instance scmni_trans_core_ops struct since you could have
> > multiple SCMI nodes using multiple shmem transports with different size...
> > (in theory...)
> 
> Indeed, let me ponder about that for a s
> 
> > 
> > >   	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
> > >   	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
> > > -			       struct scmi_xfer *xfer);
> > > +			       struct scmi_xfer *xfer,
> > > +			       u32 shmem_io_width);
> > >   	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
> > > -				   size_t max_len, struct scmi_xfer *xfer);
> > > +				   size_t max_len, struct scmi_xfer *xfer,
> > > +				   u32 shmem_io_width);
> > >   	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
> > >   	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
> > >   			  struct scmi_xfer *xfer);
> > > @@ -350,7 +355,8 @@ struct scmi_shared_mem_operations {
> > >   	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
> > >   	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
> > >   				     struct device *dev,
> > > -				     bool tx, struct resource *res);
> > > +				     bool tx, struct resource *res,
> > > +				     u32 *shmem_io_width);
> > >   };
> > >   const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
> > > diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> > > index dc5ca894d5eb..6bd876875655 100644
> > > --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> > > +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
> > > @@ -33,6 +33,7 @@ struct scmi_mailbox {
> > >   	struct mbox_chan *chan_platform_receiver;
> > >   	struct scmi_chan_info *cinfo;
> > >   	struct scmi_shared_mem __iomem *shmem;
> > > +	u32 shmem_io_width;
> > >   };
> > >   #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
> > > @@ -43,7 +44,8 @@ static void tx_prepare(struct mbox_client *cl, void *m)
> > >   {
> > >   	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
> > > -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
> > > +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
> > > +				smbox->shmem_io_width);
> > >   }
> > >   static void rx_callback(struct mbox_client *cl, void *m)
> > > @@ -197,7 +199,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> > >   	if (!smbox)
> > >   		return -ENOMEM;
> > > -	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
> > > +	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL,
> > > +						&smbox->shmem_io_width);
> > >   	if (IS_ERR(smbox->shmem))
> > >   		return PTR_ERR(smbox->shmem);
> > > @@ -298,7 +301,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
> > >   {
> > >   	struct scmi_mailbox *smbox = cinfo->transport_info;
> > > -	core->shmem->fetch_response(smbox->shmem, xfer);
> > > +	core->shmem->fetch_response(smbox->shmem, xfer, smbox->shmem_io_width);
> > >   }
> > >   static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> > > @@ -306,7 +309,8 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> > >   {
> > >   	struct scmi_mailbox *smbox = cinfo->transport_info;
> > > -	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
> > > +	core->shmem->fetch_notification(smbox->shmem, max_len, xfer,
> > > +					smbox->shmem_io_width);
> > >   }
> > >   static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
> > > diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> > > index 08911f40d1ff..9f6804647b29 100644
> > > --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
> > > +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
> > > @@ -350,7 +350,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
> > >   static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
> > >   			      struct scmi_optee_channel *channel)
> > >   {
> > > -	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
> > > +	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
> > > +						      NULL);
> > >   	if (IS_ERR(channel->req.shmem))
> > >   		return PTR_ERR(channel->req.shmem);
> > > @@ -465,7 +466,7 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
> > >   		ret = invoke_process_msg_channel(channel,
> > >   						 core->msg->command_size(xfer));
> > >   	} else {
> > > -		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
> > > +		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo, 0);
> > >   		ret = invoke_process_smt_channel(channel);
> > >   	}
> > > @@ -484,7 +485,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
> > >   		core->msg->fetch_response(channel->req.msg,
> > >   					  channel->rx_len, xfer);
> > >   	else
> > > -		core->shmem->fetch_response(channel->req.shmem, xfer);
> > > +		core->shmem->fetch_response(channel->req.shmem, xfer, 0);
> > >   }
> > >   static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> > > diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> > > index c6c69a17a9cc..4e7b2ac1c7e8 100644
> > > --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
> > > +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
> > > @@ -60,6 +60,7 @@ struct scmi_smc {
> > >   	int irq;
> > >   	struct scmi_chan_info *cinfo;
> > >   	struct scmi_shared_mem __iomem *shmem;
> > > +	u32 shmem_io_width;
> > >   	/* Protect access to shmem area */
> > >   	struct mutex shmem_lock;
> > >   #define INFLIGHT_NONE	MSG_TOKEN_MAX
> > > @@ -144,7 +145,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
> > >   	if (!scmi_info)
> > >   		return -ENOMEM;
> > > -	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
> > > +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res,
> > > +						    &scmi_info->shmem_io_width);
> > >   	if (IS_ERR(scmi_info->shmem))
> > >   		return PTR_ERR(scmi_info->shmem);
> > > @@ -229,7 +231,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> > >   	 */
> > >   	smc_channel_lock_acquire(scmi_info, xfer);
> > > -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
> > > +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
> > > +				scmi_info->shmem_io_width);
> > >   	if (scmi_info->cap_id != ULONG_MAX)
> > >   		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
> > > @@ -253,7 +256,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
> > >   {
> > >   	struct scmi_smc *scmi_info = cinfo->transport_info;
> > > -	core->shmem->fetch_response(scmi_info->shmem, xfer);
> > > +	core->shmem->fetch_response(scmi_info->shmem, xfer,
> > > +				    scmi_info->shmem_io_width);
> > >   }
> > >   static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
> > > diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
> > > index 01d8a9398fe8..192262d63baa 100644
> > > --- a/drivers/firmware/arm_scmi/shmem.c
> > > +++ b/drivers/firmware/arm_scmi/shmem.c
> > > @@ -34,9 +34,20 @@ struct scmi_shared_mem {
> > >   	u8 msg_payload[];
> > >   };
> > > +#define __shmem_copy_toio_tpl(s)			\
> > > +	for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
> > > +		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
> > > +			   shmem->msg_payload + i);
> > > +
> > > +#define __shmem_copy_fromio_tpl(s)			\
> > > +	for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)		\
> > > +		((u##s *)(xfer->rx.buf))[i / shmem_io_width] = 			\
> > > +			 ioread##s(shmem->msg_payload + shmem_io_width + i);
> > > +
> > >   static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
> > >   			     struct scmi_xfer *xfer,
> > > -			     struct scmi_chan_info *cinfo)
> > > +			     struct scmi_chan_info *cinfo,
> > > +			     u32 shmem_io_width)
> > >   {
> > >   	ktime_t stop;
> > > @@ -72,8 +83,25 @@ static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
> > >   		  &shmem->flags);
> > >   	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
> > >   	iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
> > 
> > what about these (and other) header reads if reg-io-width is defined as < 32 ?
> > Should not these accesses be size-wise too ? or I am missing smth ...
> 
> Good question, I suppose it depends whether 'reg-io-width' means that this
> must be the strict access width we use, or if this is the minimum access
> width supported. If the former, then yes, we do have to make a whole lot of
> changes to support the only access width being supported, if the latter,
> then we ought to be OK, because doing a 32-bit access should drive more byte
> enables at the bus level, yet still return the expected data.
> 
> A minimum or only supported access width of 64-bit would be quite
> interesting, and not somewhat compatible with how SCMI is defined, so maybe
> that one should not be supported at all, even if this is how
> memcpy_{to,from}_io() decides to operate on parts of the memory that are
> 8bytes aligned.
> 
> > (...and if yes I would once more say that all of this should be setup once for
> > all at setup time and not checked against a parameter at run time for each access...)
> > 
> > > -	if (xfer->tx.buf)
> > > -		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
> > > +	if (xfer->tx.buf) {
> > > +		switch (shmem_io_width) {
> > > +		case 1:
> > > +			__shmem_copy_toio_tpl(8);
> > > +			break;
> > > +		case 2:
> > > +			__shmem_copy_toio_tpl(16);
> > > +			break;
> > > +		case 4:
> > > +			__shmem_copy_toio_tpl(32);
> > > +			break;
> > > +		case 8:
> > > +			__shmem_copy_toio_tpl(64);
> > > +			break;
> > > +		default:
> > > +			memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
> > > +			break;
> > 
> > ...as said above, this switch could be avoided by setting up the
> > transport access size once for all at setup time with properly
> > sized-helpers...
> > 
> > 
> > > +		}
> > > +	}
> > >   }
> > >   static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
> > > @@ -81,8 +109,34 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
> > >   	return ioread32(&shmem->msg_header);
> > >   }
> > > +static void __shmem_fetch_resp_notif_data(struct scmi_xfer *xfer,
> > > +					  struct scmi_shared_mem __iomem *shmem,
> > > +					  u32 shmem_io_width)
> > > +{
> > > +	/* Take a copy to the rx buffer.. */
> > > +	switch (shmem_io_width) {
> > > +	case 1:
> > > +		__shmem_copy_fromio_tpl(8);
> > > +		break;
> > > +	case 2:
> > > +		__shmem_copy_fromio_tpl(16);
> > > +		break;
> > > +	case 4:
> > > +		__shmem_copy_fromio_tpl(32);
> > > +		break;
> > > +	case 8:
> > > +		__shmem_copy_fromio_tpl(32);
> > > +		break;
> > > +	default:
> > > +		memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4,
> > > +			      xfer->rx.len);
> > > +		break;
> > > +	}
> > > +}
> > > +
> > >   static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
> > > -				 struct scmi_xfer *xfer)
> > > +				 struct scmi_xfer *xfer,
> > > +				 u32 shmem_io_width)
> > >   {
> > >   	size_t len = ioread32(&shmem->length);
> > > @@ -90,20 +144,19 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
> > >   	/* Skip the length of header and status in shmem area i.e 8 bytes */
> > >   	xfer->rx.len = min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
> > > -	/* Take a copy to the rx buffer.. */
> > > -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
> > > +	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
> > >   }
> > >   static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
> > > -				     size_t max_len, struct scmi_xfer *xfer)
> > > +				     size_t max_len, struct scmi_xfer *xfer,
> > > +				     u32 shmem_io_width)
> > >   {
> > >   	size_t len = ioread32(&shmem->length);
> > >   	/* Skip only the length of header in shmem area i.e 4 bytes */
> > >   	xfer->rx.len = min_t(size_t, max_len, len > 4 ? len - 4 : 0);
> > > -	/* Take a copy to the rx buffer.. */
> > > -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
> > > +	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
> > >   }
> > >   static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
> > > @@ -139,7 +192,8 @@ static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
> > >   static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
> > >   				       struct device *dev, bool tx,
> > > -				       struct resource *res)
> > > +				       struct resource *res,
> > > +				       u32 *shmem_io_width)
> > >   {
> > >   	struct device_node *shmem __free(device_node);
> > >   	const char *desc = tx ? "Tx" : "Rx";
> > > @@ -173,6 +227,9 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
> > >   		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
> > >   	}
> > > +	if (shmem_io_width)
> > > +		of_property_read_u32(shmem, "reg-io-width", shmem_io_width);
> > > +
> > 
> > 
> > ...this and all the subsequent setup could be moved inside a modified
> > shared_mem_operations_get(dev) while moving its callsite from driver_init into
> > driver_probe (probably) insside @scmi_transport_setup....but it will require
> > a non-trivial amount of changes in the transport to avoid the global core-> ptr.
> 
> OK, I will think about more about what needs to be done here, but in
> general, do you agree this is an acceptable approach to support "odd" SRAMs?

Yes, but one question comes up in my mind upfront (maybe similar to Rob remarks):
is this not, in theory, something general that should be somehow addressed transparently
by the core SRAM code when dealing with such odd SRAM, since SCMI is
indeed only onne of the possible users ?
(not saying to do this in this series that deals with SCMI related issues....)

Anyway, I'll have a though too about the SCMI core transport possible changes that I
mentiond above, soon-ish... (I tried something already today, hoping to solve it quickly
...with poor results :D)

Thanks,
Cristian

