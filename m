Return-Path: <linux-kernel+bounces-263432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613793D5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E4A1C23545
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C38178CC8;
	Fri, 26 Jul 2024 15:14:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF91EA6F;
	Fri, 26 Jul 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006877; cv=none; b=C1nOYgkYSmJM/mQLYXd0AmU9AKN+9otGzmfSM+9FGi0ErQF/V2YcyN99jtqLQl8aDkHSRhaw1+lqW0Cau/uJa3YV/+FDcbfupDbi8GjuNtRkxDzyDDnkGFh44okUT5VfMQdLxiGz5Yt0axBlN8yyIxAX+QrgNyS0vbxKvP1BZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006877; c=relaxed/simple;
	bh=Xh55UptQAeIB5r4FSAoqi6SxFLRUWkIF5Nc69lddWKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2ZS91jjnD6F4Cam/toAoF4gu4I7TVD1MxEn0p2RPPyyYvbwach31VfSkczvNCPtNt/QWW7R88UnShigtiIdKpXU+kryVlGvxMIqW3N4Ij+3bULjVIuy3Mwq2EV6qmJtiXrtzpU2TtVfJI+pHm6IK054Wy7dTeAIOiCDkzD7sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 704FA1007;
	Fri, 26 Jul 2024 08:14:59 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A66513F73F;
	Fri, 26 Jul 2024 08:14:31 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:14:29 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne CARRIERE <etienne.carriere@st.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"quic_sibis@quicinc.com" <quic_sibis@quicinc.com>,
	"quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"ptosi@google.com" <ptosi@google.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 0/8] Make SCMI transport as standalone drivers
Message-ID: <ZqO9VdIh7sXLSqhY@pluto>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <PAXPR04MB84592E272D5C16813529815588A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zo_qly7DOJkb05B_@pluto>
 <PAXPR10MB4687398182E577AD00B447FBFDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR10MB4687398182E577AD00B447FBFDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>

On Tue, Jul 23, 2024 at 01:36:55PM +0000, Etienne CARRIERE wrote:
> Hi Cristian, Peng,
> 

Hi Etienne,

Thanks for giving this a go on your setup.

> On Thursday, July 11, 2024, Cristian Marussi worte:
> > On Thu, Jul 11, 2024 at 01:26:16PM +0000, Peng Fan wrote:
> > > > Subject: [PATCH 0/8] Make SCMI transport as standalone drivers
> > >
> > > You may need use V2 here :)
> > 
> > ...oh damn :P
> > 
> > > >
> > > > Hi all,
> > > >
> > > > Till now the SCMI transport layer was being built embedded into in the
> > > > core SCMI stack.
> > > >
> > > > Some of these transports, despite being currently part of the main
> > > > SCMI module, are indeed also registered with different subsystems like
> > > > optee or virtio, and actively probed also by those: this led to a few
> > > > awkward and convoluted tricks to properly handle such interactions at
> > > > boot time in the SCMI stack.
> > > >
> > > > Moreover some partner expressed the desire to be able to fully
> > > > modularize the transports components.
> > > >
> > > > This series aim to make all such transports as standalone drivers that
> > > > can be optionally loaded as modules.
> > > >
> > > > In order to do this, at first some new mechanism is introduced to
> > > > support this new capability while maintaining, in parallel, the old
> > > > legacy embedded transports; then each transport, one by one, is
> > > > transitioned to be a standalone driver and finally the old legacy
> > > > support for embedded transport is removed.
> > > >
> > > > Patch [1/8] is a mostly unrelated (but much needed) clean-up from
> > > > Peng, which I included in this series to avoid conflicts at merge.
> > > >
> > > > Patch [2/8] simply collects the existing datagram manipulation helpers
> > > > in a pair of function pointers structures, in preparation for later reworks.
> > > >
> > > > Patch [3/8] adds the bulk of the new logic to the core SCMI stack and
> > > > then each existing transport is transitioned to be a standalone driver in
> > > > patches 4,5,6,7 while shuffling around the compatibles. (no DT change
> > > > is needed of curse for backward compatibility) While doing this I kept
> > > > the module authorship in line with the main
> > > > author(S) as spitted out by git-blame.
> > > >
> > > > Finally patch [8/8] removes all the legacy dead code from the core
> > > > SCMI stack.
> > > >
> > > > No new symbol EXPORT has been added.
> > > >
> > > > The new transport drivers have been tested, as built-in and LKM, as
> > > > follows:
> > > >
> > > > - mailbox on JUNO
> > > > - virtio on emulation
> > > > - optee on QEMU/optee using Linaro setup
> > > >
> > > > Exercised using the regular SCMI drivers stack and the SCMI ACS suite,
> > > > testing commands, replies, delayed responses and notification.
> > > >
> > > > Multiple virtual SCMI instances support has been tested too.
> > > >
> > > > SMC has NOT been tested/exercised at run-time, only compile-tested.
> > > > (due to lack of hardware)
> > > >
> > > > Note that in this new setup, all the probe deferral and retries between
> > > > the SCMI core stack and the transports has been removed, since no
> > > > more needed.
> > > >
> > > > Moreover the new drivers have been tested also with a fully
> > > > modularized SCMI stack, i.e.:
> > > >
> > > >   scmi-core.ko + scmi-module.ko + scmi_transport_*.ko [ + vendor
> > > > modules ]
> > > >
> > > > ToBeDone:
> > > >  - completely remove any dependency at build time at the Kconfig level
> > > > between
> > > >    the SCMI core and the transport drivers: so that the transports will be
> > > >    dependent only on the related subsystems (optee/virtio/mailbox/smc)
> > > >    (easy to be done but maybe it is not worth...)
> > > >  - integrate per-platform transport configuration capabilities
> > > >    (max_rx_timeout_ms & friends..)
> > > >
> > > > Based on sudeep/for-next/scmi/updates.
> > > >
> > > > Any feedback, and especially testing (:D) is welcome.
> > > >
> > >
> > > For the v2 patchset:
> > > Tested-by: Peng Fan <peng.fan@nxp.com>  #i.MX95-19x19-EVK
> > >
> > 
> > Thanks a lot for the review and testing,
> > 
> > Cristian
> 
> 
> I've tested this v2 on stm32mp157c-scmi.dts. Using built-in modules
> works perfectly.  I've tweaked my platform setup to test the .ko and
> modprobe part. It works ok for the probe part but I faced kernel oops
> when unloading scmi-module after transport is loaded, used, then unoaded.
> The issue I saw is around calls to info->desc->ops->chan_free in
> scmi_cleanup_channels(). I wonder if there are some ops that were not
> unregistered when transport driver is unloaded.
> 

You are right, I could reproduce your oops in my QEMU/optee setup.

There was a bug in chan_free for optee that pre-dated this series....it
is exposed when unloading the scmi-module....I'll post a fix for this
as the initial patch of this series V3.

Moreover even once that was fixed, there was another bug in the
optee_remove of this new transport driver since I was calling the
platform_driver_unregister() too late (after the check for channel
empty)...as a result when you unload the scmi_transport_optee BEFORE the
scmi-module (which is another valid unload sequence option) the core
SCMI stack was NOT unbound like for the other transports.

Last but not least, I spotted another issue for all of these transport
drivers (and related WARN) when finally unloading the scmi-core module
(the last one to go) due to a missing device_release...this was easily
fixed just by using other platform drivers core helpers...so I
refactored more the DEFINE_SCMI_TRANSPORT_DRIVER macros internals...

Next week, on top of -rc1, I'll post a v3 with all the fixes I
mentioned.

Thanks,
Cristian

