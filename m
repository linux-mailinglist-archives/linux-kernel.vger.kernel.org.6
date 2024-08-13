Return-Path: <linux-kernel+bounces-284823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D202C950583
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFEE1F214F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E0199EB4;
	Tue, 13 Aug 2024 12:48:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341B14A600;
	Tue, 13 Aug 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553293; cv=none; b=IcTgTjhvg+Kq9f7H9OlPM4cuGEuEVueToiuxJ6RXqCP5ugwBpIrlYqkYthiYtfrx6GG5qGvFqo13qHhEWtsnzPz4tCAewQtwcI25e8zz7PJDrZCJVEEF5Ty95f3s7HnSyZdhskrXItMpoPG/TrD+C5KQO6Rkjm+t1QoenxAWqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553293; c=relaxed/simple;
	bh=JhUsQsbJXb7Rn+lVSQsIVMGLXR+BKkqxIsMwBU2yHSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ4DEMWGS5F51MsnJ1AR4Y0LEe+H8GnsA9NXx/kidu0zKXcg4t3qjclBVluZ7w/UEYzhlaVQ7ysV9dA87KHKah86sKjio8+BveIpvUxm39PiegCtk3sd+CwzdcCt47pfuIJyJnq5jxjTsb1LC2+eEdE3vSR4C8pGrQ9STL5gXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0797612FC;
	Tue, 13 Aug 2024 05:48:36 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4973F73B;
	Tue, 13 Aug 2024 05:48:08 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:47:56 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, saravanak@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Message-ID: <ZrtVrG-B5TqmTQUa@pluto>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813085703.zz6ltcxmrrbdgt77@lcpd911>

On Tue, Aug 13, 2024 at 02:27:03PM +0530, Dhruva Gole wrote:
> On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 

Hi Peng, Dhruva

> > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > SCMI_PROTCOL_PERF protocol, but with different name, so two scmi devices
> > will be created. But the fwnode->dev could only point to one device.
> > 
> > If scmi cpufreq device created earlier, the fwnode->dev will point to
> > the scmi cpufreq device. Then the fw_devlink will link performance
> > domain user device(consumer) to the scmi cpufreq device(supplier).
> > But actually the performance domain user device, such as GPU, should use
> > the scmi perf device as supplier. Also if 'cpufreq.off=1' in bootargs,
> > the GPU driver will defer probe always, because of the scmi cpufreq
> 
> The commit message itself seems very specific to some platform to me.
> What about platforms that don't atall have a GPU? Why would they care
> about this?
> 

+1

If you faced a problem on specific platform and a specific config the aim
here should be to solve it generally...not to just hack something around
to fix your specific case while potentially breaking future users
(evenm if now cpufreq does not need it...)

> > device not ready.
> > 
> > Because for cpufreq, no need use fw_devlink. So bypass setting fwnode
> > for scmi cpufreq device.
> > 
> > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the scmi_device")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V2:
> >  Use A!=B to replace !(A == B)
> >  Add fixes tag
> >  This might be a workaround, but since this is a fix, it is simple for
> >  backporting.
> 
> More than a workaround, it feels like a HACK to me.
> 

+1 ... exactly... I did not have time to dig into this but I would like
to understand better the implications of this, in order to avoid to
inadvertently fix one issue and create a few more :P

...as an example, for starters, killing devlink straigh away will most
probably kill also the auto-unbinding of the stack when a supplier is removed...

> > 
> > V1:
> >  https://lore.kernel.org/all/20240717093515.327647-1-peng.fan@oss.nxp.com/
> > 
> >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> > index 96b2e5f9a8ef..be91a82e0cda 100644
> > --- a/drivers/firmware/arm_scmi/bus.c
> > +++ b/drivers/firmware/arm_scmi/bus.c
> > @@ -395,7 +395,8 @@ __scmi_device_create(struct device_node *np, struct device *parent,
> >  	scmi_dev->id = id;
> >  	scmi_dev->protocol_id = protocol;
> >  	scmi_dev->dev.parent = parent;
> > -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> > +	if ((protocol != SCMI_PROTOCOL_PERF) || strcmp(name, "cpufreq"))
> > +		device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> 
> I kind of disagree with the idea here to be specific about the
> PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus driver right?
> Why bring in specific code into a bus driver? We will never fix the
> actual root cause of the issue this way.
> 

+1 again

Whatevier solution we will adopt ahs to be general...like enabling SCMI
drivers to flag a particular condition/need so the core can take
countermeasures...beside being in the bus code, we cannot really think
of just keep blacklisting here all the combination we dont like...

Thanks,
Cristian


