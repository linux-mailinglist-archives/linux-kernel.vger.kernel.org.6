Return-Path: <linux-kernel+bounces-355236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D44B994D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E761F21E00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2107A1DED4B;
	Tue,  8 Oct 2024 13:06:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2301C9B99;
	Tue,  8 Oct 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392785; cv=none; b=E88ED1hqv7HOKsH4bGikS7FVShjV454xsNUeeFiDMVtqmq1nUGltAPJKRqkTwTjxZ0jXuoZlz/JQl8PyU/mmOKD7L76f01nIs3H8RTOYMWHYzGQqpZtp664f6xtKOhcELI1E58JZkgyGnUrTScjPuwAWDyHdidQKsKHSvy5APiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392785; c=relaxed/simple;
	bh=uLHvykvkchfdJn5jUpmEGCdPqI5Vu3BisOWgUgCdUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBbS+fkY6pXexkLGYW8S2f4Eoz32l25t2QcQphGb2iIDjmTn9WKjEwPetU4/nGmHOZTbMBsxD6K/nVJi0LsMfll+A8MD8E7VNy02w0l65fz4CxbYQW89IG5YfEaGMDa+fzBZxKxrqdfzCGTOTptzOY//habfBOBtHyQZXfDsz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 611CADA7;
	Tue,  8 Oct 2024 06:06:52 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85DC33F640;
	Tue,  8 Oct 2024 06:06:20 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:06:17 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
Message-ID: <ZwUuSTYkWrZYIcBM@bogus>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPLgcGeUcFPvjcz@pluto>
 <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>

Hi Florian,

Thanks for the detailed explanation.

On Mon, Oct 07, 2024 at 10:07:46AM -0700, Florian Fainelli wrote:
> Hi Cristian,
>
> On October 7, 2024 4:52:33 AM PDT, Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> > On Sat, Oct 05, 2024 at 09:33:17PM -0700, Florian Fainelli wrote:
> > > Broadcom STB platforms have for historical reasons included both
> > > "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
> > > string.
> >
> > Hi Florian,
> >
> > did not know this..
>
> It stems from us starting with a mailbox driver that did the SMC call, and
> later transitioning to the "smc" transport proper. Our boot loader provides
> the Device Tree blob to the kernel and we maintain backward/forward
> compatibility as much as possible.
>

IIUC, you need to support old kernel with SMC mailbox driver and new SMC
transport within the SCMI. Is that right understanding ?

> >
> > >
> > > After the commit cited in the Fixes tag and with a kernel
> > > configuration that enables both the SCMI and the Mailbox transports, we
> > > would probe the mailbox transport, but fail to complete since we would
> > > not have a mailbox driver available.
> > >
> > Not sure to have understood this...
> >
> > ...you mean you DO have the SMC/Mailbox SCMI transport drivers compiled
> > into the Kconfig AND you have BOTH the SMC AND Mailbox compatibles in
> > DT, BUT your platform does NOT physically have a mbox/shmem transport
> > and as a consequence, when MBOX probes (at first), you see an error from
> > the core like:
> >
> >    "arm-scmi: unable to communicate with SCMI"
> >
> > since it gets no reply from the SCMI server (being not connnected via
> > mbox) and it bails out .... am I right ?
>
> In an unmodified kernel where both the "mailbox" and "smc" transports are
> enabled, we get the "mailbox" driver to probe first since it matched the
> "arm,scmi" part of the compatible string and it is linked first into the
> kernel. Down the road though we will fail the initialization with:
>
> [    1.135363] arm-scmi arm-scmi.1.auto: Using scmi_mailbox_transport
> [    1.141901] arm-scmi arm-scmi.1.auto: SCMI max-rx-timeout: 30ms
> [    1.148113] arm-scmi arm-scmi.1.auto: failed to setup channel for
> protocol:0x10

IIUC, the DTB has mailbox nodes that are available but fail only in the setup
stage ? Or is it marked unavailable and we are missing some checks either
in SCMI or mailbox ?

IOW, have you already explored that this -EINVAL is correct return value
here and can't be changed to -ENODEV ? I might be not following the failure
path correctly here, but I assume it is
	scmi_chan_setup()
	info->desc->ops->chan_setup()
	mailbox_chan_setup()
	mbox_request_channel()

> [    1.155828] arm-scmi arm-scmi.1.auto: error -EINVAL: failed to setup
> channels
> [    1.163379] arm-scmi arm-scmi.1.auto: probe with driver arm-scmi failed
> with error -22
>
> Because the platform device is now bound, and there is no mechanism to
> return -ENODEV, we won't try another transport driver that would attempt to
> match the other compatibility strings. That makes sense because in general
> you specify the Device Tree precisely, and you also have a tailored kernel
> configuration. Right now this is only an issue using arm's
> multi_v7_defconfig and arm64's defconfig both of which that we intend to
> keep on using for CI purposes.
>
>
> >
> > If this is the case, without this patch, after this error and the mbox probe
> > failing, the SMC transport, instead, DO probe successfully at the end, right ?
>
> With my patch we probe the "smc" transport first and foremost and we
> successfully initialize it, therefore we do not even try the "mailbox"
> transport at all, which is intended.
>
> >
> > IOW, what is the impact without this patch, an error and a delay in the
> > probe sequence till it gets to the SMC transport probe 9as second
> > attempt) or worse ? (trying to understand here...)
>
> There is no recovery without the patch, we are not giving up the arm_scmi
> platform device because there is no mechanism to return -ENODEV and allow
> any of the subsequent transport drivers enabled to attempt to take over the
> platform device and probe it again.
>

OK this sounds like you have already explored returning -ENODEV is not
an option ? It is fair enough, but just want to understand correctly.
I still think I am missing something.

I understand the bootloader maintaining backward compatibility, but
just want to understand better. I also wonder if the old SMC mailbox driver
returns -EINVAL instead of -ENODEV ? Again it is based on my assumption
about your backward compatibility usecase.

--
Regards,
Sudeep

