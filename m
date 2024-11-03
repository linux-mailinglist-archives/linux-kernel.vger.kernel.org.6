Return-Path: <linux-kernel+bounces-393642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C369BA386
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB460B21F05
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075F70804;
	Sun,  3 Nov 2024 02:09:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E72AD04;
	Sun,  3 Nov 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730599789; cv=none; b=A2vzBSF5JvKz1pcKSWm7MURLucHxQyPU5AwOc8H2tM8NB5jsaFL1QtLEVQ49es9MYFYQoVULcjWhUydwY7Kf/vgw1QvEwaQTrVOjmE9B0B+SXfe2OZp5VFfOGjT5gWbmuhZz2C8mK+z9M5clGAkPfjKR+/G9GREBfsFBG7Pyh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730599789; c=relaxed/simple;
	bh=1i+WSntf5AeLdt8tSgoioRD9HFRDhZ7A7TSO8/A7f08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT+40u+IzS1+ZGAs7UKBfJslT0kFMsw+ZjgrAYgSeO1DzQViKxVKzDoptu+wIjbmHBKLNqq1gyPf6KwIOYnWU9GsKKU1YhvWlwPXIRCe+78wu+Hz2uTVpNzcjR5NAqV8CVmLesfxaZRJybdeUMZcXGZj5m+Tm/PrFG413YninLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7C45497;
	Sat,  2 Nov 2024 19:10:15 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0EF3F528;
	Sat,  2 Nov 2024 19:09:43 -0700 (PDT)
Date: Sun, 3 Nov 2024 02:09:29 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime
 Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Parthiban <parthiban@linumiz.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] clk: sunxi-ng: a100: enable MMC clock
 reparenting
Message-ID: <20241103020929.2298633f@minigeek.lan>
In-Reply-To: <885047f813d0c55eae13f26b0bfe041d@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
	<20241031070232.1793078-9-masterr3c0rd@epochal.quest>
	<20241031120857.60bc0d94@donnerap.manchester.arm.com>
	<885047f813d0c55eae13f26b0bfe041d@epochal.quest>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 02 Nov 2024 18:44:41 -0300
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

Hi Cody,

thanks for staying on this issue!

> On 2024/10/31 9:08 am, Andre Przywara wrote:
> > Well, while this change indeed prevented that error message you mentioned,
> > but the SD card still doesn't work for me: it probes and I can mount a
> > filesystem on it, but then it hangs, for instance when running an "ls" on
> > it. It could be my setup (lacking DT or device issue or missing kernel
> > config), though, and the eMMC works for me this way, but it would be good
> > to have that sorted.   
> I'm investigating this now; it appears mmc2/eMMC is more consistent when
> CLK_NO_REPARENT is set

What do you mean with "more consistent", exactly?
I still don't get why NO_REPARENT would help here in the first place:
we have three clocks as potential parents: OSC24MHz, PLL_PERIPH0,
PLL_PERIPH1. The first one is too slow for typical MMC rates, and
PERIPH1 is typically disabled (it's the same rates as PERIPH0, so
there is little need for it). So PERIPH0 is to clock to go, and I don't
see what NO_REPARENT would change here.

So those are my observations:
With NO_REPARENT (current mainline):
- SD card fails to probe:
  sunxi-mmc 4020000.mmc: fatal err update clk timeout
- SD card is still parented to PERIPH0-2x (probably because U-Boot set
  that up), but uses a divider of 256 for a clock rate of 4687500 Hz.
  This probably leads to the failures.
- eMMC works, but is parented to the 24MHz OSC, probably because U-Boot
  did not touch it. The clock rate is 12MHz, the read speed is 10MB/s.
With removing NO_REPARENT, so with this patch:
- SD cards probes, I can mount a VFAT fs on it, and sometimes "ls"
  that, but it hangs soon afterwards, for instance when trying to
  benchmark it.
- SD clock is set up correctly: parent is PLL_PERIPH0-2x, rate is 50
  MHz, correct for High Speed@4bit and its 25MB/s bus speed.
- eMMC works fine, clock parent is PLL-PERIPH0-2x, rate is 100 MHz,
  correct for HS-200 (100 MHz * 8 bit * 2(DDR)). The read speed is
  72MB/s, which sounds alright, and might be a limitation of the flash
  chip.

So NO_REPARENT is always worse for me.

> > Also it would be good to know why CLK_SET_RATE_NO_REPARENT was put there
> > in the first place: I don't see it in any other MMC clocks in sunxi-ng, so
> > it wasn't just copied&pasted.  
> Seeing that mmc2 acts better with the flag, perhaps it was copy + pasted
> from that config. Or perhaps the issues we're running into comes from
> elsewhere in the chain. At the moment, that's only speculation, though;
> I'm waiting on a device that has an SD card slot so I can perform more
> testing myself and debug these issues.
> 
> > So was there a problem that this flag was supposed to fix? Is that
> > something that only applied to older kernels (back when the MMC patches
> > were first posted), and which has now been fixed/changed elsewhere?  
> Yangtao Li/Frank Lee assumably no longer works at Allwinner, as the email
> he used to submit this originally no longer exists, but I believe the same
> Yangtao is now a maintainer of the Allwinner cpufreq subsystem, and is
> CC'd on these patches. I'm sending this reply to him as well; perhaps he
> may have some additional insight.
> 
> > I feel a bit uneasy of just removing this just because it works(TM),
> > especially if it doesn't really (SD card for me, for instance).  
> I agree; I was quickly preparing V2 to hopefully get this in before the
> 6.13 window for the sunxi tree closed, and added this in last minute after
> verifying it worked on my current device, which lacks an SD card slot.
> 
> This patch can be skipped for now, as it's apparent MMC0/1 require a little
> more love before we can merge it in. I'll submit new patches in the future
> once this is figured out.

This patch would be a fix anyway (with a Fixes: tag), so we can push it
still into 6.13, after -rc1, and it would be backported. So it's not as
critical, timing-wise.

Cheers,
Andre

> 
> Thanks!
> - Cody
> 
> > Cheers,
> > Andre
> >   
> >> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)  
> 


