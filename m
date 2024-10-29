Return-Path: <linux-kernel+bounces-386924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621A9B49C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A171F23649
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802BB66E;
	Tue, 29 Oct 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZe3t6QT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B49C2C6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205323; cv=none; b=X0HyCj1oHjFTAA3C9COADQ0P2Tj/hOaWYatY96BHl3ALbZC/f4x+p1NKQ6W4wXeVUPVYi606v74PFesi2rsrU4NeQmaEqjN5y2MGXUm3y0d2kW+xImDQqZhZm6emEBYQr0iRpolFnCYkwMO48wTybv0SWyCbYPEW9/6UFdffae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205323; c=relaxed/simple;
	bh=VYEVVYxya7tsBuiNON2JCJUXnez95Gkwg+EOPKTtkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd1wvVsL/Kw3QUjks16msGrVKgPqGqp7vEV3f49fthAdL2p8u8NXIX+z3ypb6FcRyXiRgerQZ1fpy7ttW6b1QJwtek7IQqG1GNk43i18ePi+ApQ8QieyxDfTEhdAOn1qfZ1UDq5K7y1zKA1HkcgPc421wbxjajDxezMhEoqEUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZe3t6QT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E02C4CEE3;
	Tue, 29 Oct 2024 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730205323;
	bh=VYEVVYxya7tsBuiNON2JCJUXnez95Gkwg+EOPKTtkLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZe3t6QTWz+JAqnlpd8jmd8zDtGX0S7amn0IaWFq4YBXYEM5Lt+ZH9Bv5idlSYQHt
	 pCx7oMtoIcWMaiXa06hlz4xeXlHLZCt95f2uYgOxSQHjeCPEjXfWeuULAMfhcrU+3G
	 Ge15tafb+7sWydGnqlCMAWv3OHVWFWgFE2DoCFdKh0kjZYDrBuquKPbGGMocaZ8+oy
	 ghlkhAk2mQa2Ar4eUYZOSQtpx6HDmvLh1g6ChOCuw9IVs4vpHJP9NroSdvP0bRRbjU
	 UHnLqlm4jbFjVHhvMofHRFDwV7gPpdhhEzHwvx4e0BEBju9jBkpq7i+XFqxSFLqPQX
	 M6ZkJnDs1IC7Q==
Date: Tue, 29 Oct 2024 13:35:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 00/10] clockevents: Rearrange cpuhotplug operations
Message-ID: <ZyDWhyHzyujyo2Qw@localhost.localdomain>
References: <20241017165041.6954-1-frederic@kernel.org>
 <87wmhx6grp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmhx6grp.ffs@tglx>

Le Thu, Oct 24, 2024 at 10:34:34AM +0200, Thomas Gleixner a écrit :
> On Thu, Oct 17 2024 at 18:50, Frederic Weisbecker wrote:
> > Some recent RCU issues triggered with offline ticks uncovered
> > hotplug behaviour differences between oneshot and periodic ticks.
> > The former is disabled on the dying CPU but not the latter. Also
> > the clockevents hotplug code is quite chaotic. This is a proposal to
> > fix the situation.
> 
> I like it very much!
> 
> > Frederic Weisbecker (10):
> >   clockevents: Improve clockevents_notify_released() comment
> >   clockevents: Shutdown and unregister current clockevents at
> >     CPUHP_AP_TICK_DYING
> 
> This has a build fail.

Right.

> 
> >   tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING
> >   arm/twd: Remove clockevents shutdown call on offlining
> 
> The ARM prefix preference is:
> 
>     ARM: smp_twd:
> 
> >   clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call
> >     on offlining
> >   clocksource/driver/arm_global_timer: Remove clockevents shutdown call
> >     on offlining
> >   drivers/clocksource/exynos_mct: Remove clockevents shutdown call on
> >     offlining
> >   clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on
> >     offlining
> >   clocksource/drivers/qcom: Remove clockevents shutdown call on
> >     offlining
> >   drivers/clocksource/timer-tegra: Remove clockevents shutdown call on
> >     offlining
> 
> Can you please make the subsystem prefixes for the clocksource drivers
> consistent 'clocksource/drivers/foo:' ?

Sure, fixing that.

Thanks!

> 
> Thanks,
> 
>         tglx

