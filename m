Return-Path: <linux-kernel+bounces-284913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9E9506B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3113E1F2298D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBD19CD03;
	Tue, 13 Aug 2024 13:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3ED19B5A3;
	Tue, 13 Aug 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556312; cv=none; b=tJC9zH6kUGqVekN8EvQtHj/6B0aHDMyIrf7hvRhV/quFQS14P3/5cJYyiLlPX2AnyqPpvHbAW+lhj7ZkpG0vYyOB4+kNBejR4yd3KaIAU+Feg0PbtWrA0BYWVmDIhUiHxn/Jq+BYhH3J7DY/3CCYPuUy7Eqt46qKQySmvJR/8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556312; c=relaxed/simple;
	bh=99oLz2v7wwXeI48Q0L4uteHXS7e1R3xayA4koPcKQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2xboA4ugQ/TdySVbZLshynD0Ge+ijXnE1K3iPDdebrSo0kNlJTprm9TqTMA92AAZePOlJ8U+GIgD0VwIXGyaRoszOAGwEnNivyvfUW70Rg2aX0SARdz2PiDbSJfChUiptpwl8v1CGK3udXGuc6zhavD0hmlZOpkXNGKexK2hZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77EDF12FC;
	Tue, 13 Aug 2024 06:38:55 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101FA3F6A8;
	Tue, 13 Aug 2024 06:38:27 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:38:25 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Dhruva Gole <d-gole@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"saravanak@google.com" <saravanak@google.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Message-ID: <Zrth0Ypog2TXBlxf@pluto>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> > for scmi cpufreq
> > 
> > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> > > SCMI_PROTCOL_PERF protocol, but with different name, so two scmi
> > > devices will be created. But the fwnode->dev could only point to one
> > device.
> > >
> > > If scmi cpufreq device created earlier, the fwnode->dev will point to
> > > the scmi cpufreq device. Then the fw_devlink will link performance
> > > domain user device(consumer) to the scmi cpufreq device(supplier).
> > > But actually the performance domain user device, such as GPU,
> > should
> > > use the scmi perf device as supplier. Also if 'cpufreq.off=1' in
> > > bootargs, the GPU driver will defer probe always, because of the scmi
> > > cpufreq
> > 
> > The commit message itself seems very specific to some platform to me.
> > What about platforms that don't atall have a GPU? Why would they
> > care about this?
> 
> It is a generic issue if a platform has performance domain to serve
> scmi cpufreq and device performance level.
> 
> > 
> > > device not ready.
> > >
> > > Because for cpufreq, no need use fw_devlink. So bypass setting
> > fwnode
> > > for scmi cpufreq device.
> > >
> > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the
> > > scmi_device")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Use A!=B to replace !(A == B)
> > >  Add fixes tag
> > >  This might be a workaround, but since this is a fix, it is simple for
> > > backporting.
> > 
> > More than a workaround, it feels like a HACK to me.
> > 
> > >
> > > V1:
> > >
> > >
> > >
> > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > b/drivers/firmware/arm_scmi/bus.c index
> > 96b2e5f9a8ef..be91a82e0cda
> > > 100644
> > > --- a/drivers/firmware/arm_scmi/bus.c
> > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > @@ -395,7 +395,8 @@ __scmi_device_create(struct device_node
> > *np, struct device *parent,
> > >  	scmi_dev->id = id;
> > >  	scmi_dev->protocol_id = protocol;
> > >  	scmi_dev->dev.parent = parent;
> > > -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> > > +	if ((protocol != SCMI_PROTOCOL_PERF) || strcmp(name,
> > "cpufreq"))
> > > +		device_set_node(&scmi_dev->dev,
> > of_fwnode_handle(np));
> > 
> > I kind of disagree with the idea here to be specific about the
> > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus driver right?
> > Why bring in specific code into a bus driver? We will never fix the
> > actual root cause of the issue this way.
> 
> The root cause is fwnode devlink only supports one fwnode, one device.
> 1:1 match. But current arm scmi driver use one fwnode for two devices.
> 
> If your platform has scmi cpufreq and scmi device performance domain,
> you might see that some devices are consumer of scmi cpufreq, but actually
> they should be consumer of scmi device performance domain.
> 
> I not have a good idea that this is fw devlink design that only allows
> 1 fwnode has 1 device or not. If yes, that arm scmi should be fixed.
> If not, fw devlink should be updated.
> 
> The current patch is the simplest method for stable tree fixes as I
> could work out.

So this is the same root cause at the end of the issues you had with IMX
pinctrl coexistence...i.e. the SCMI stack creates scmi devices that
embeds the protocol node, BUT since you can have multiple device/drivers
doing different things on different resources within the same protocol
you can end with 2 devices having the same embedded device_node, since
we dont really have anything else to use as device_node, I rigth ?

Thanks,
Cristian

