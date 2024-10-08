Return-Path: <linux-kernel+bounces-355186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A32B9949E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9E1C2103B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38E1DE89F;
	Tue,  8 Oct 2024 12:27:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD8EEC8;
	Tue,  8 Oct 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390420; cv=none; b=n8dGd2F4D6ewbI/Hf2ytyf5Lic/C5q8cwW15g6Cdfafym/Ro92vHcnhh1x33cXSH2acsoCZU81RX1o9fWVZPQuaNJmIZIsZLfWb9rwXnMmKwJUrJSk2NDpk+reQCq65aK3KujCuEwR0w4vR3NgLLuczvsFzSTrcyN3B2jIwWnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390420; c=relaxed/simple;
	bh=5Nl+OeJMY5uGxZFls6uVPJ503vuF3Ttr1J15r5Ex7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNvqy+PnShiLKpZGR8bG629YH0u0Xwuo/Z1Fq0QQo8bLg1q8FoW2/uZ1MhldjIaJB7dKTqeeCSWeYE3SUI6xYSdFRejb6l6+PJ9LfCx12JQWX4lfkQARYLKl2g+JQuvihVR8dlFO0voIUcTa8kDFuKjdTFSNq70QHy4oIjjiKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF169DA7;
	Tue,  8 Oct 2024 05:27:27 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47DC43F73F;
	Tue,  8 Oct 2024 05:26:56 -0700 (PDT)
Date: Tue, 8 Oct 2024 13:26:53 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
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
Message-ID: <ZwUlDT_YupBSZjMJ@pluto>
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

OK.

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

Ah ok so the issue derives from the fact that you have a single
compatible line with 2 not compatbles that are not really "compatible"
from the SCMI core point of view...

...also I suppose that if we "somehow" would trigger a
device_release_drievr(), what will happen is that it will match probably
again in the same order at the next attempt (beside being an ugly thing)

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

Ok...so it is a workaround hack indeed....but it seems NOT to have bad
side effects and there is definitely no cleaner way to make it bind
properly...beside fixing your DTs for the future...

Thanks,
Cristian

