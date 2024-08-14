Return-Path: <linux-kernel+bounces-285955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8C9514CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC69B23D67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6513C83D;
	Wed, 14 Aug 2024 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgVzP/p+"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862F13BC2F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618326; cv=none; b=kf3JaP8t87Pk0L+dkh/G40bj9N+wetvdf1NhbN7Q/JKChhey3Gf3Zn6RhyOqzcTDqW8H4Co/wbrenY5d28QMJgyq/+6Rx2o1f8CccHED+GNFxx6/4FvNQyl8A2xSAI3jsVIjCZDk5tuyS9bNaMM6byqiBHWqgRpKtEPsl3uM/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618326; c=relaxed/simple;
	bh=7DQ5W3it8yogtO0qaAAZXi7rH39bt5KHJZCm+Qcmpes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuyHeXRU0UVsQ3SchSg5oFXUBm+ME8GcPI/hAFJf4RN+WJFd3AbemFIO5Ai3R/fCe6410v4ERUTbbbVY+q7cxIQFTlO35OJjmgUNQzdjdc4xi56mC4uGtpEKVldEWOH+MewzLRL7CgiWEO3qw2rIwfmvbvYTWQ6iinnvSErGpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgVzP/p+; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-494556dfa3aso1856435137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723618324; x=1724223124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDFkKnkxkffF4GbjGBKIQ42AmEF5jCkew9Z8TFYCfDk=;
        b=KgVzP/p+RyX/H8l0LQXPHvdOynzMWX0MRAgDHGsNQ0Zh2rYQ2pi8wX1L0YMSta4z9g
         uc5HfIcHQCrCKLb2Irnp/hHbULr6deIIUJX9T2e9G6iNtKTXJp0K2ujGPZi70096+btE
         YqPu7Qx3O63Q2E/msEwg9hsJRFunc2oJvCRMEmKR52wRvZ4WIY67PzzwYSjX0zbobhvK
         +Lkw95OK6vvdKUFI7qiJ+szIrCSZbPijmca6GNgn5bd56uG1R4/cvH9IcPohwt7CQw84
         3533FAKPjFiJlewwesshNhdJnOTPD1P1iPoiNCDaz6n/m1t6eXuOmJgt+Ah/0QxtuAd6
         3exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618324; x=1724223124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDFkKnkxkffF4GbjGBKIQ42AmEF5jCkew9Z8TFYCfDk=;
        b=DI76qvk+fK2fdWQOfobSYw/M945WbN181Fm9lQ9CxjfsKEPNEENSx+v82SO5g6N4Z4
         TNDDJ1S/kGy6mvF5SDaC8IyHRfnUDqPStgwpkirfg0fyRBTwXzovS4lfhNIBoxmtNVkx
         qSVim78C8nFZSEO0S3YB3HQ+rHn31++6vSknGN5oo/e2PmTUa96eJWulO5Km62CsPJv7
         U/iaaGrAV6ds5+po+KE6l/Ty3k3d5XO5cSc7u0fMyv8LqGcoJAkrlMx4+TmyV3o7nB40
         6xc2WUDXuV753tZDq1elaWhXglBI4b73W80yw178JXwLSbkFR6q1m89V+dU9f48r++2B
         vauQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoA6Ji3VdY7LPNBaNAIizz2X+uFmAC09geBVkgNyTIfRxPuSumLosCJT2fhv1maYlJEIovruf6BcEjNe2i9aRh6uDaI5Zaipy5OLg6
X-Gm-Message-State: AOJu0YzpR8hnJp+rlpCTASCgOCLh1603HyGNGYajWxrOnhbt/EXwRUVX
	UieNPkDv+ZQibCXdLHvY4o3NKOOV9sYwqdBWLrfvfR8WrN34Ox0rgFurR5W+8jRcHyUGCZL2dw5
	FDWg13QHZjHbc/DeBSyAnHtWe8eAUqQgLYPXt
X-Google-Smtp-Source: AGHT+IEh2AD60IlWWwt0Rst+hAGvHMa/HKt0IntFX+Xh1uL+fqGkkjledxaZ0E8L4tdEyFJVMPCR3BMsnLwmtKQIDMk=
X-Received: by 2002:a05:6102:3e94:b0:48f:40c1:3cd0 with SMTP id
 ada2fe7eead31-497598e7ee0mr2168902137.12.1723618323764; Tue, 13 Aug 2024
 23:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
 <20240813085703.zz6ltcxmrrbdgt77@lcpd911> <PAXPR04MB84597171A959F40CD9A77C7B88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrth0Ypog2TXBlxf@pluto> <PAXPR04MB8459B2CF515DC89DE98A1B7C88862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zrt3P1FH13edqjoC@pluto> <PAXPR04MB8459D35BF6FD55B38350E67388862@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB8459AF9F24D0449A26B2646C88872@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459AF9F24D0449A26B2646C88872@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Aug 2024 23:51:24 -0700
Message-ID: <CAGETcx8m48cy-EzP6_uoGN7KWsQw=CfZWQ-hNUzz_7LZ0voG8A@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi cpufreq
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Dhruva Gole <d-gole@ti.com>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:36=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: RE: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> > for scmi cpufreq
> >
> > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode
> > for
> > > scmi cpufreq
> > >
> > > On Tue, Aug 13, 2024 at 01:52:30PM +0000, Peng Fan wrote:
> > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > fwnode
> > > > > for scmi cpufreq
> > > > >
> > > > > On Tue, Aug 13, 2024 at 10:25:31AM +0000, Peng Fan wrote:
> > > > > > > Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set
> > > > > fwnode
> > > > > > > for scmi cpufreq
> > > > > > >
> > > > > > > On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > >
> > > > > > > > Two drivers scmi_cpufreq.c and scmi_perf_domain.c both
> > use
> > > > > > > > SCMI_PROTCOL_PERF protocol, but with different name, so
> > > two
> > > > > scmi
> > > > > > > > devices will be created. But the fwnode->dev could only
> > > > > > > > point to one
> > > > > > > device.
> > > > > > > >
> > > > > > > > If scmi cpufreq device created earlier, the fwnode->dev wil=
l
> > > > > > > > point to the scmi cpufreq device. Then the fw_devlink will
> > > > > > > > link performance domain user device(consumer) to the scmi
> > > > > > > > cpufreq
> > > > > device(supplier).
> > > > > > > > But actually the performance domain user device, such as
> > > > > > > > GPU,
> > > > > > > should
> > > > > > > > use the scmi perf device as supplier. Also if 'cpufreq.off=
=3D1'
> > > > > > > > in bootargs, the GPU driver will defer probe always, becaus=
e
> > > > > > > > of the scmi cpufreq
> > > > > > >
> > > > > > > The commit message itself seems very specific to some
> > platform
> > > > > > > to
> > > > > me.
> > > > > > > What about platforms that don't atall have a GPU? Why
> > would
> > > > > they
> > > > > > > care about this?
> > > > > >
> > > > > > It is a generic issue if a platform has performance domain to
> > > > > > serve scmi cpufreq and device performance level.
> > > > > >
> > > > > > >
> > > > > > > > device not ready.
> > > > > > > >
> > > > > > > > Because for cpufreq, no need use fw_devlink. So bypass
> > > setting
> > > > > > > fwnode
> > > > > > > > for scmi cpufreq device.
> > > > > > > >
> > > > > > > > Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for
> > > the
> > > > > > > > scmi_device")
> > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > V2:
> > > > > > > >  Use A!=3DB to replace !(A =3D=3D B)  Add fixes tag  This m=
ight be
> > > > > > > > a workaround, but since this is a fix, it is simple for
> > > > > > > > backporting.
> > > > > > >
> > > > > > > More than a workaround, it feels like a HACK to me.
> > > > > > >
> > > > > > > >
> > > > > > > > V1:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >  drivers/firmware/arm_scmi/bus.c | 3 ++-
> > > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/firmware/arm_scmi/bus.c
> > > > > > > > b/drivers/firmware/arm_scmi/bus.c index
> > > > > > > 96b2e5f9a8ef..be91a82e0cda
> > > > > > > > 100644
> > > > > > > > --- a/drivers/firmware/arm_scmi/bus.c
> > > > > > > > +++ b/drivers/firmware/arm_scmi/bus.c
> > > > > > > > @@ -395,7 +395,8 @@ __scmi_device_create(struct
> > > > > device_node
> > > > > > > *np, struct device *parent,
> > > > > > > >   scmi_dev->id =3D id;
> > > > > > > >   scmi_dev->protocol_id =3D protocol;
> > > > > > > >   scmi_dev->dev.parent =3D parent;
> > > > > > > > - device_set_node(&scmi_dev->dev,
> > > of_fwnode_handle(np));
> > > > > > > > + if ((protocol !=3D SCMI_PROTOCOL_PERF) ||
> > > strcmp(name,
> > > > > > > "cpufreq"))
> > > > > > > > +         device_set_node(&scmi_dev->dev,
> > > > > > > of_fwnode_handle(np));
> > > > > > >
> > > > > > > I kind of disagree with the idea here to be specific about th=
e
> > > > > > > PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus
> > > driver
> > > > > right?
> > > > > > > Why bring in specific code into a bus driver? We will never
> > > > > > > fix the actual root cause of the issue this way.
> > > > > >
> > > > > > The root cause is fwnode devlink only supports one fwnode, one
> > > > > device.
> > > > > > 1:1 match. But current arm scmi driver use one fwnode for two
> > > > > devices.
> > > > > >
> > > > > > If your platform has scmi cpufreq and scmi device performance
> > > > > domain,
> > > > > > you might see that some devices are consumer of scmi cpufreq,
> > > but
> > > > > > actually they should be consumer of scmi device performance
> > > > > domain.
> > > > > >
> > > > > > I not have a good idea that this is fw devlink design that only
> > > > > > allows
> > > > > > 1 fwnode has 1 device or not. If yes, that arm scmi should be
> > fixed.
> > > > > > If not, fw devlink should be updated.
> > > > > >
> > > > > > The current patch is the simplest method for stable tree fixes
> > > > > > as I could work out.
> > > > >
> > > > > So this is the same root cause at the end of the issues you had
> > > > > with IMX pinctrl coexistence...i.e. the SCMI stack creates scmi
> > > > > devices that embeds the protocol node, BUT since you can have
> > > > > multiple device/drivers doing different things on different
> > > > > resources within the same protocol you can end with 2 devices
> > > > > having the same embedded device_node, since we dont really
> > have
> > > > > anything else to
> > > use
> > > > > as device_node, I rigth ?
> > > >
> > > > I think, yes. And you remind me that with PINCTRL_SCMI and
> > > > CONFIG_PINCTRL_IMX_SCMI both enabled, the scmi pinctrl node
> > will
> > > only
> > > > take one to set the fwnode device pointer depends on the order to
> > > run
> > > > __scmi_device_create.
> > > >
> > > > So not only perf, pinctrl also has issue here, fwnode devlink will
> > > > not work properly for pinctrl/perf.
> > >
> > > ...mmm ... the standard generic Pinctrl driver and the IMX Pintrcl ar=
e
> > > mutually exclusive in the code (@probe time) itself as far as I can
> > > remember about what you did, so why devlink should have that issue
> > > there ?
> > > Have you seen any issue in this regards while having loaded
> > > pinctrl_scmi and pinctrl_imx_scmi ?
> >
> > No. it works well in my setup. I am just worried that there might be
> > issues because fwnode only has one dev pointer, see device_add.
> >
> > >
> > > I want to have a better look next days about this devlink issue that
> > > you reported...it still not clear to me...from device_link_add() docs=
,
> > > it seems indeed that it will return the old existing link if a link
> > > exist already between that same supplier/consumer devices
> > pair....but
> > > from the code (at first sight) it seems that the check is made agains
> > > the devices not their embeded device_nodes, but here (and in
> > > pinctrl/imx case) you will have 2 distinct consumer devices (with
> > same
> > > device_node)...I may have missed something in your exaplanation....
> >
> > It might be false alarm for pinctrl, but it is true issue for perf.
>
> Just give a recheck. Pinctrl has same issue. With PINCTRL_SCMI
> and PINCTRL_IMX_SCMI both enabled, two scmi devices
> will be created. So it depends on device creation order, 1st
> created device will be used as supplier.
>
> On i.MX, there is no issue with both enabled, it is because
> the imx scmi device is created first. If the generic pinctrl scmi
> device created first, imx will have issue.
>
> In the end, this is generic fw_devlink limitation or arm scmi driver
> issue.

+1 to what Cristian and Dhruva said in other parts of this thread.

This patch itself is definitely a hack.

The problem isn't so much that fw_devlink doesn't want to support
multiple devices getting instantiated from one DT node. The problem is
that there's no way to know which of the multiple devices is the real
supplier just by looking at the information in devicetree/firmware
(the fw in fw_devlink). And keep in mind that one of the main
requirements of fw_devlink is to work before any driver is loaded and
not depend on drivers for correctness of the dependency information
because it needs to work on a fully modular kernel too. So, fw_devlink
just picks the first device that's instantiated from a DT node.

I really hate folks creating multiple devices from one DT node. One IP
block can support multiple things, there's no need to instantiate
multiple devices for it. The same driver could have just as easily
registered with multiple frameworks. So, ideally I'd want us to fix
this issue in the SCMI framework code. In the case where the same SCMI
node is creating two devices, can they both probe successfully? If
yes, why are we not using a child node or a separate node for this
second device? If it's always one or the other, why are we creating
two devices? Can you please point to specific upstream DT examples for
me to get a better handle on what's going on?

Btw, there is the deferred_probe_timeout command line option that can
be used so that fw_devlink stops enforcing dependencies where there
are no supplier drivers for a device after a timeout. It's not ideal,
but it's something to unblock you.

The best fw_devlink could do is just not enforce any dependencies if
there is more than one device instantiated for a given supplier DT
node.

-Saravana

