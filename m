Return-Path: <linux-kernel+bounces-286342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05859519DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1ABB21746
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEE1AED49;
	Wed, 14 Aug 2024 11:27:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C333D8;
	Wed, 14 Aug 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634854; cv=none; b=pjj3ah8TH6T6h1zPkEvgTSXcFjR7MgRGtjFZgh6YAZ7bJI+C6weFovI1rkU/f1gnHA7sVmrQE+9aXYgCAF5Khv1+DYH/ojpoAu2vu6sayBbO9JPt7otq7j7jjqcIW59YXTQiXivTgzC5BHHNkZQjwWpDEPA6itSn63sXQVjzyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634854; c=relaxed/simple;
	bh=YrXX5aL97URluVR68CHSDpKAfPKvvSr1NsrLx43z5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP6ImemJZ4cS17BYJxHflcwyU0wddGASQrfD6pHljnppyuWEPUt6IuQ/p324NLT/vOaZJZytYXiOiEWNeQ0dFi8XH5L/Y3c/Xd1wuG9hg0H4qrWv1ZwPlH1LU5nLwjX+sYeaP/ErHdTUyiAlDaARw/vzs3z44ya1as2zi5dplvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48738DA7;
	Wed, 14 Aug 2024 04:27:51 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FBD23F58B;
	Wed, 14 Aug 2024 04:27:23 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:27:10 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Dhruva Gole <d-gole@ti.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Message-ID: <ZryUgTOVr_haiHuh@pluto>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
 <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrth0Ypog2TXBlxf@pluto>
 <PAXPR04MB8459B2CF515DC89DE98A1B7C88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrt3P1FH13edqjoC@pluto>
 <PAXPR04MB8459D35BF6FD55B38350E67388862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB8459AF9F24D0449A26B2646C88872@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAGETcx8m48cy-EzP6_uoGN7KWsQw=CfZWQ-hNUzz_7LZ0voG8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8m48cy-EzP6_uoGN7KWsQw=CfZWQ-hNUzz_7LZ0voG8A@mail.gmail.com>

On Tue, Aug 13, 2024 at 11:51:24PM -0700, Saravana Kannan wrote:
> On Tue, Aug 13, 2024 at 8:36 PM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> > > for scmi cpufreq
> > >

Hi,

> > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> > > for
> > > > scmi cpufreq
> > > >
> > > > On Tue, Aug 13, 2024 at 01:52:30PM +0000, Peng Fan wrote:
> > > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > > fwnode
> > > > > > for scmi cpufreq
> > > > > >
> > > > > > On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > > > > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > > > > fwnode
> > > > > > > > for scmi cpufreq
> > > > > > > >
> > > > > > > > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > > >
> > > > > > > > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both
> > > use
> > > > > > > > > SCMI_PROTCOL_PERF protocol, but with different name, so
> > > > two
> > > > > > scmi
> > > > > > > > > devices will be created. But the fwnode->dev could only
> > > > > > > > > point to one
> > > > > > > > device.
> > > > > > > > >
> > > > > > > > > If scmi cpufreq device created earlier, the fwnode->dev will
> > > > > > > > > point to the scmi cpufreq device. Then the fw_devlink will
> > > > > > > > > link performance domain user device(consumer) to the scmi
> > > > > > > > > cpufreq
> > > > > > device(supplier).
> > > > > > > > > But actually the performance domain user device, such as
> > > > > > > > > GPU,
> > > > > > > > should
> > > > > > > > > use the scmi perf device as supplier. Also if 'cpufreq.off=1'
> > > > > > > > > in bootargs, the GPU driver will defer probe always, because
> > > > > > > > > of the scmi cpufreq
> > > > > > > >
> > > > > > > > The commit message itself seems very specific to some
> > > platform
> > > > > > > > to
> > > > > > me.
> > > > > > > > What about platforms that don't atall have a GPU? Why
> > > would
> > > > > > they
> > > > > > > > care about this?
> > > > > > >
> > > > > > > It is a generic issue if a platform has performance domain to
> > > > > > > serve scmi cpufreq and device performance level.
> > > > > > >
> > > > > > > >
> > > > > > > > > device not ready.
> > > > > > > > >
> > > > > > > > > Because for cpufreq, no need use fw_devlink. So bypass
> > > > setting
> > > > > > > > fwnode
> > > > > > > > > for scmi cpufreq device.
> > > > > > > > >
> > > > > > > > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for
> > > > the
> > > > > > > > > scmi_device")
> > > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > V2:
> > > > > > > > >  Use A!=B to replace !(A == B)  Add fixes tag  This might be
> > > > > > > > > a workaround, but since this is a fix, it is simple for
> > > > > > > > > backporting.
> > > > > > > >
> > > > > > > > More than a workaround, it feels like a HACK to me.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > V1:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > > > > > > > b/drivers/firmware/arm_scmi/bus.c index
> > > > > > > > 96b2e5f9a8ef..be91a82e0cda
> > > > > > > > > 100644
> > > > > > > > > --- a/drivers/firmware/arm_scmi/bus.c
> > > > > > > > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > > > > > > > @@ -395,7 +395,8 @@ __scmi_device_create(struct
> > > > > > device_node
> > > > > > > > *np, struct device *parent,
> > > > > > > > >   scmi_dev->id = id;
> > > > > > > > >   scmi_dev->protocol_id = protocol;
> > > > > > > > >   scmi_dev->dev.parent = parent;
> > > > > > > > > - device_set_node(&scmi_dev->dev,
> > > > of_fwnode_handle(np));
> > > > > > > > > + if ((protocol != SCMI_PROTOCOL_PERF) ||
> > > > strcmp(name,
> > > > > > > > "cpufreq"))
> > > > > > > > > +         device_set_node(&scmi_dev->dev,
> > > > > > > > of_fwnode_handle(np));
> > > > > > > >
> > > > > > > > I kind of disagree with the idea here to be specific about the
> > > > > > > > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus
> > > > driver
> > > > > > right?
> > > > > > > > Why bring in specific code into a bus driver? We will never
> > > > > > > > fix the actual root cause of the issue this way.
> > > > > > >
> > > > > > > The root cause is fwnode devlink only supports one fwnode, one
> > > > > > device.
> > > > > > > 1:1 match. But current arm scmi driver use one fwnode for two
> > > > > > devices.
> > > > > > >
> > > > > > > If your platform has scmi cpufreq and scmi device performance
> > > > > > domain,
> > > > > > > you might see that some devices are consumer of scmi cpufreq,
> > > > but
> > > > > > > actually they should be consumer of scmi device performance
> > > > > > domain.
> > > > > > >
> > > > > > > I not have a good idea that this is fw devlink design that only
> > > > > > > allows
> > > > > > > 1 fwnode has 1 device or not. If yes, that arm scmi should be
> > > fixed.
> > > > > > > If not, fw devlink should be updated.
> > > > > > >
> > > > > > > The current patch is the simplest method for stable tree fixes
> > > > > > > as I could work out.
> > > > > >
> > > > > > So this is the same root cause at the end of the issues you had
> > > > > > with IMX pinctrl coexistence...i.e. the SCMI stack creates scmi
> > > > > > devices that embeds the protocol node, BUT since you can have
> > > > > > multiple device/drivers doing different things on different
> > > > > > resources within the same protocol you can end with 2 devices
> > > > > > having the same embedded device_node, since we dont really
> > > have
> > > > > > anything else to
> > > > use
> > > > > > as device_node, I rigth ?
> > > > >
> > > > > I think, yes. And you remind me that with PINCTRL_SCMI and
> > > > > CONFIG_PINCTRL_IMX_SCMI both enabled, the scmi pinctrl node
> > > will
> > > > only
> > > > > take one to set the fwnode device pointer depends on the order to
> > > > run
> > > > > __scmi_device_create.
> > > > >
> > > > > So not only perf, pinctrl also has issue here, fwnode devlink will
> > > > > not work properly for pinctrl/perf.
> > > >
> > > > ...mmm ... the standard generic Pinctrl driver and the IMX Pintrcl are
> > > > mutually exclusive in the code (@probe time) itself as far as I can
> > > > remember about what you did, so why devlink should have that issue
> > > > there ?
> > > > Have you seen any issue in this regards while having loaded
> > > > pinctrl_scmi and pinctrl_imx_scmi ?
> > >
> > > No. it works well in my setup. I am just worried that there might be
> > > issues because fwnode only has one dev pointer, see device_add.
> > >
> > > >
> > > > I want to have a better look next days about this devlink issue that
> > > > you reported...it still not clear to me...from device_link_add() docs,
> > > > it seems indeed that it will return the old existing link if a link
> > > > exist already between that same supplier/consumer devices
> > > pair....but
> > > > from the code (at first sight) it seems that the check is made agains
> > > > the devices not their embeded device_nodes, but here (and in
> > > > pinctrl/imx case) you will have 2 distinct consumer devices (with
> > > same
> > > > device_node)...I may have missed something in your exaplanation....
> > >
> > > It might be false alarm for pinctrl, but it is true issue for perf.
> >
> > Just give a recheck. Pinctrl has same issue. With PINCTRL_SCMI
> > and PINCTRL_IMX_SCMI both enabled, two scmi devices
> > will be created. So it depends on device creation order, 1st
> > created device will be used as supplier.
> >
> > On i.MX, there is no issue with both enabled, it is because
> > the imx scmi device is created first. If the generic pinctrl scmi
> > device created first, imx will have issue.
> >
> > In the end, this is generic fw_devlink limitation or arm scmi driver
> > issue.
> 
> +1 to what Cristian and Dhruva said in other parts of this thread.
> 
> This patch itself is definitely a hack.
> 
> The problem isn't so much that fw_devlink doesn't want to support
> multiple devices getting instantiated from one DT node. The problem is
> that there's no way to know which of the multiple devices is the real
> supplier just by looking at the information in devicetree/firmware
> (the fw in fw_devlink). And keep in mind that one of the main
> requirements of fw_devlink is to work before any driver is loaded and
> not depend on drivers for correctness of the dependency information
> because it needs to work on a fully modular kernel too. So, fw_devlink
> just picks the first device that's instantiated from a DT node.
> 
> I really hate folks creating multiple devices from one DT node. One IP
> block can support multiple things, there's no need to instantiate
> multiple devices for it. The same driver could have just as easily
> registered with multiple frameworks. So, ideally I'd want us to fix
> this issue in the SCMI framework code. In the case where the same SCMI
> node is creating two devices, can they both probe successfully? If
> yes, why are we not using a child node or a separate node for this
> second device? If it's always one or the other, why are we creating
> two devices? Can you please point to specific upstream DT examples for
> me to get a better handle on what's going on?
> 
> Btw, there is the deferred_probe_timeout command line option that can
> be used so that fw_devlink stops enforcing dependencies where there
> are no supplier drivers for a device after a timeout. It's not ideal,
> but it's something to unblock you.
> 
> The best fw_devlink could do is just not enforce any dependencies if
> there is more than one device instantiated for a given supplier DT
> node.
> 

So I'll try to describe in the following how the SCMI stack is
designed and behaves as it stands now....probably not exactly in a
concise way ... :P

The protocol-nodes in the DT are used to describe the presence and
sometime additional properties of an SCMI Protocol like Clock,
Peformance, Pinctrl etc, beside being used in phandles to refer to
specific per-protocol resources from other drivers.
(arch/arm64/boot/dts/arm/juno-scmi.dtsi to see how protocol nodes
 are referred )

Note also that the SCNI protocol is extensible and growing, we have 10
stanard protocols currently and potentially a number of additional vendor
protocols numbers that can be defined in the future.

The core SCMI stack knows how to build,send and track the proper SCMI
messages for all of these SCMI protocols and their well defined SCMI
commands, and exposes a common API (include/linux/scmi_protocol.h) in the
classic "file-operations" style for the driver-users that wants to use
such SCMI facilities.

As an example, clk-scmi is one of this SCMI drivers: it plugs on one side
on the standard CLK frameowrk and then registers also as an SCMI driver
with the SCMI stack, so that it can access and use the related specific
scmi_clk_ops to map common operations like clocks enable/disable into an
SCMI message exchange.

When the SCMI core stack comes up it queries the SCMI/fw upfront via the
dedicated Base protocol to discover, amongst other stuff, the list of
supported protocols by the current platorm.

An SCMI driver like clk-scmi needs some sort of device to drive: the
driver itself declares the protocol(CLK) that he wants to use and a name,
and the SCMI bus will create a device accordingly, using the related
protocol device_node and the name choosen (so that multiple devices
can exist with different names for different drivers but using the same
protocol)

Then, the clk-scmi driver at probe time, after a successufl match on
protocol/name, will obtain the related clk_scmi ops from the core
stack together with an opaque handle for that instance of the SCMI
stack: this first SCMI/clk user will trigger the specific core protocol
initialization code to be run.

The clk-scmi driver can then issue any CLK related ops he wants
during its lifetime.

Protocols are initialized on first use: when a SCMI driver appears that
wants to use protocol-X ops, protocol-X will be initialized...any
subsequent driver appearing that wants to use protocol-X will use the
same initialized protocol stack.

...BUT you can have possibly multiple drivers willing to use the same
protocol, probably on a disjoint set of resources in that protocol:
an example of this is the Sensor protocol which is used by scmi-hwmon
for a few classic sensors, BUT also by scmi-iio for another class of
distinct sensors (and plugging into a different subsystem): such drivers
will both use Sensor protocol and both will have a device created an
"hwmon"/sensor vs "iio"/sensor...

...the problem is, as it start to become apparent, I have ONLY one single
DT node to represent the protocol which I can use to embed in the
created devices...

In this scenario I would like to have multiple distinct DT nodes describing
the same protocol so that I can instantiate different devices using the same
protocol but using a distinct device_node...just I am not sure how to create
such a duplicate node out of thin-air in a non-dirty way...moreover I am not
even sure this is doable, since I fear that such a solution will even more
break the stack, since how the phandle references across the DT are even
supposed to work if I magically create a duplicate of a device_node
urelated to any real DT...

...sorry for my ignorance in this area, any advice will be very much welcome.

Thanks,
Cristian

