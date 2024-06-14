Return-Path: <linux-kernel+bounces-214828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6365908AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448D1B24EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969E194AC2;
	Fri, 14 Jun 2024 11:19:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530413B2AD;
	Fri, 14 Jun 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718363997; cv=none; b=hW0WhBqsu7CfXb6LeeAYLhWVq3YONQEUWEd6wYvlAVV1o+b7d5NpfEY4BZO1/2QmoHF12T6UAIu0KDknq16W6SZbjsmi+irGyzo1KXug+GoipEqRYhue0XiZRiyfSkG4ip+jqYRYDmUCfmKCy9G7dcvJBnFX3OqjZAyBKu1D3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718363997; c=relaxed/simple;
	bh=cFyihkIH027mZr4iPADM0XrNS9KyPSmcplzZr3uL4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Lq6BZgFGAIAdnDrQWt1QM4BZBhHtPQqDn5VATChQz6lzEgBc8g371Hge47p6jMiXt2lghF0AtMzk8ZFGnZ0Jg6ki/3wiCLSWwX91EDt1SWikUjl0OTpLHGcULNAbHrMEYNg8SzwALOtTvSAPXplb2WlQqGwvBbT/TpJpdCF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC3DFEC;
	Fri, 14 Jun 2024 04:20:19 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68D153F5A1;
	Fri, 14 Jun 2024 04:19:53 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:19:51 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: mailbox: support P2A channel
 completion
Message-ID: <ZmwnV_M3WX-4gJiH@bogus>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-2-e994cf14ef86@nxp.com>
 <ZmwLLoh1dbykOZZq@bogus>
 <ZmwcD-v6dCmObP_2@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmwcD-v6dCmObP_2@pluto>

On Fri, Jun 14, 2024 at 11:31:43AM +0100, Cristian Marussi wrote:
> On Fri, Jun 14, 2024 at 10:19:42AM +0100, Sudeep Holla wrote:
> > 
> > diff --git i/drivers/firmware/arm_scmi/mailbox.c w/drivers/firmware/arm_scmi/mailbox.c
> > index adb69a6a0223..3bb3fba8f478 100644
> > --- i/drivers/firmware/arm_scmi/mailbox.c
> > +++ w/drivers/firmware/arm_scmi/mailbox.c
> > @@ -326,30 +326,25 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
> >  static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
> >  {
> >         struct scmi_mailbox *smbox = cinfo->transport_info;
> > -       struct device *cdev = cinfo->dev;
> > -       struct mbox_chan *intr;
> > +       struct mbox_chan *intr_chan = NULL;
> >         int ret;
> > 
> >         shmem_clear_channel(smbox->shmem);
> > 
> > -       if (!shmem_channel_intr_enabled(smbox->shmem))
> > -               return;
> > -
> >         if (smbox->chan_platform_receiver)
> > -               intr = smbox->chan_platform_receiver;
> > +               intr_chan = smbox->chan_platform_receiver;
> >         else if (smbox->chan)
> > -               intr = smbox->chan;
> > -       else {
> > -               dev_err(cdev, "Channel INTR wrongly set?\n");
> > +               intr_chan = smbox->chan;
> > +
> > +       if (!(intr_chan && shmem_channel_intr_enabled(smbox->shmem)))
> >                 return;
> > -       }
> 
> Fine with dropping the dev_err() but is not this cumulative negated-if a
> bit cryptic...also you can bail out early straight away as before when
> platform has not required any P2A completion irq...I mean something like
>

Agreed, updated now.

-- 
Regards,
Sudeep

