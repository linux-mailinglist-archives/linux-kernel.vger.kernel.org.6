Return-Path: <linux-kernel+bounces-214791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2739089F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9621C25249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E544F19645D;
	Fri, 14 Jun 2024 10:31:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978B1946D4;
	Fri, 14 Jun 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361109; cv=none; b=IU33O5AHfcKI4kZiyeP53fFYNWduMJkNnchoRT3ho7x7LEAdPfM2qO/1kKLbxw+20ngsTGD179slun4fiUJBEj8V4RFN4nQfMkvAOZaJ5Evju/VBuwj88bUYhRbjUiYlbPxgjn+jpOTuCoi0BJ1F3Qa9Tjd94bx4Kgaa3SuOQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361109; c=relaxed/simple;
	bh=fCD5BzlfvdbD3VwAFQXtMi9z1gSgn4XeQTakGTYn6mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8OJTX4wxROhUbtsBfSRfuthd/Y2B9fXCm0ckUzPp546kj7y/wOKQgwO2ybkIiDcp0+0rYlZIvf9rrCnPXadZDrZcrCEpfZnv8SG0IJmKypbryPCgA7zkKQ+dbQK+LScxXCHuMNL1XaArRxWAdUNz5WQDDCEspgcKL4T7gOo9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6911480;
	Fri, 14 Jun 2024 03:32:12 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EC633F5A1;
	Fri, 14 Jun 2024 03:31:45 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:31:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Message-ID: <ZmwcD-v6dCmObP_2@pluto>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>
 <ZmwLLoh1dbykOZZq@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmwLLoh1dbykOZZq@bogus>

On Fri, Jun 14, 2024 at 10:19:42AM +0100, Sudeep Holla wrote:
> On Fri, May 10, 2024 at 11:19:48AM +0800, Peng Fan (OSS) wrote:
> 
> There was some coding style error reported(unbalanced {}) which made me
> look at the code again. I don't think we need to splat out error.
> 
> > @@ -300,8 +326,30 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> >  static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
> >  {
> >  	struct scmi_mailbox *smbox = cinfo->transport_info;
> > +	struct device *cdev = cinfo->dev;
> > +	struct mbox_chan *intr;
> > +	int ret;
> >  
> >  	shmem_clear_channel(smbox->shmem);
> > +
> > +	if (!shmem_channel_intr_enabled(smbox->shmem))
> > +		return;
> > +
> > +	if (smbox->chan_platform_receiver)
> > +		intr = smbox->chan_platform_receiver;
> > +	else if (smbox->chan)
> > +		intr = smbox->chan;
> > +	else {
> > +		dev_err(cdev, "Channel INTR wrongly set?\n");
> > +		return;
> > +	}
> > 
> 
> If it is OK I would like to fix it up with below change.
> 

Hi,

> Regards,
> Sudeep
> 
> -->8
> 
> diff --git i/drivers/firmware/arm_scmi/mailbox.c w/drivers/firmware/arm_scmi/mailbox.c
> index adb69a6a0223..3bb3fba8f478 100644
> --- i/drivers/firmware/arm_scmi/mailbox.c
> +++ w/drivers/firmware/arm_scmi/mailbox.c
> @@ -326,30 +326,25 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>  static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
>  {
>         struct scmi_mailbox *smbox = cinfo->transport_info;
> -       struct device *cdev = cinfo->dev;
> -       struct mbox_chan *intr;
> +       struct mbox_chan *intr_chan = NULL;
>         int ret;
> 
>         shmem_clear_channel(smbox->shmem);
> 
> -       if (!shmem_channel_intr_enabled(smbox->shmem))
> -               return;
> -
>         if (smbox->chan_platform_receiver)
> -               intr = smbox->chan_platform_receiver;
> +               intr_chan = smbox->chan_platform_receiver;
>         else if (smbox->chan)
> -               intr = smbox->chan;
> -       else {
> -               dev_err(cdev, "Channel INTR wrongly set?\n");
> +               intr_chan = smbox->chan;
> +
> +       if (!(intr_chan && shmem_channel_intr_enabled(smbox->shmem)))
>                 return;
> -       }

Fine with dropping the dev_err() but is not this cumulative negated-if a
bit cryptic...also you can bail out early straight away as before when
platform has not required any P2A completion irq...I mean something like

	
       struct mbox_chan *intr_chan = NULL;

       shmem_clear_channel(smbox->shmem);
       if (!shmem_channel_intr_enabled(smbox->shmem))
		return;

       if (smbox->chan_platform_receiver)
		intr_chan = smbox->chan_platform_receiver;
       else if (smbox->chan)
		intr_chan = smbox->chan;

       if (!intr_chan)
	       return;

(or just a dangling else return;)


.. no strongs opinion here really, though.

Thanks,
Cristian

