Return-Path: <linux-kernel+bounces-399182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360B99BFBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68D51F22C79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D8944E;
	Thu,  7 Nov 2024 01:46:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138EA748F;
	Thu,  7 Nov 2024 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943998; cv=none; b=GVvz6UPwiTN05QNmKRMYmttai3UfUzSW6Cid+vJ/D1VrfJoyx7Eme0mefIPVo92r29LNFbpd6Owa8zepOmBv5riv3VRVpszUccwnEP3MKVR7MBxdTyKZXd9lTKAQiJ87sF0GPyhLVZU3X4nzM/lFlvm1snqBas/EKzWJTlHfk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943998; c=relaxed/simple;
	bh=FPys9W0Cs1vLNX6SPasi1XihbVH3pJbnC+cqw91U8n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srMp6UUlD7ZaRdseGlhkrPK1dX9FCQDmxtWN9lOTVvWr9SH+xll1dsgOsFrwJMcw3Exojswyyc6DEwBKm1OsHzcU0Aj2cWP1k2/x760VEFq1sQVjYj9bZ7IXkXylpDHJNegCGD+bk/PepvTW4r69VtUV3Tujx5xPDRUdJouj0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DBB4497;
	Wed,  6 Nov 2024 17:47:06 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F79D3F66E;
	Wed,  6 Nov 2024 17:46:33 -0800 (PST)
Date: Thu, 7 Nov 2024 01:46:10 +0000
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
Message-ID: <20241107014610.23a1666d@minigeek.lan>
In-Reply-To: <20241103020929.2298633f@minigeek.lan>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
	<20241031070232.1793078-9-masterr3c0rd@epochal.quest>
	<20241031120857.60bc0d94@donnerap.manchester.arm.com>
	<885047f813d0c55eae13f26b0bfe041d@epochal.quest>
	<20241103020929.2298633f@minigeek.lan>
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

On Sun, 3 Nov 2024 02:09:29 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

Hi,

> On Sat, 02 Nov 2024 18:44:41 -0300
> Cody Eksal <masterr3c0rd@epochal.quest> wrote:
> 
> Hi Cody,
> 
> thanks for staying on this issue!
> 
> > On 2024/10/31 9:08 am, Andre Przywara wrote:  
> > > Well, while this change indeed prevented that error message you mentioned,
> > > but the SD card still doesn't work for me: it probes and I can mount a
> > > filesystem on it, but then it hangs, for instance when running an "ls" on
> > > it. It could be my setup (lacking DT or device issue or missing kernel
> > > config), though, and the eMMC works for me this way, but it would be good
> > > to have that sorted.     
> > I'm investigating this now; it appears mmc2/eMMC is more consistent when
> > CLK_NO_REPARENT is set  
> 
> What do you mean with "more consistent", exactly?
> I still don't get why NO_REPARENT would help here in the first place:
> we have three clocks as potential parents: OSC24MHz, PLL_PERIPH0,
> PLL_PERIPH1. The first one is too slow for typical MMC rates, and
> PERIPH1 is typically disabled (it's the same rates as PERIPH0, so
> there is little need for it). So PERIPH0 is to clock to go, and I don't
> see what NO_REPARENT would change here.
> 
> So those are my observations:
> With NO_REPARENT (current mainline):
> - SD card fails to probe:
>   sunxi-mmc 4020000.mmc: fatal err update clk timeout
> - SD card is still parented to PERIPH0-2x (probably because U-Boot set
>   that up), but uses a divider of 256 for a clock rate of 4687500 Hz.
>   This probably leads to the failures.
> - eMMC works, but is parented to the 24MHz OSC, probably because U-Boot
>   did not touch it. The clock rate is 12MHz, the read speed is 10MB/s.
> With removing NO_REPARENT, so with this patch:
> - SD cards probes, I can mount a VFAT fs on it, and sometimes "ls"
>   that, but it hangs soon afterwards, for instance when trying to
>   benchmark it.

It turns out that this it due to a wrong DMA block size description in
the MMC driver: the A100/A133 only supports 8K blocks, not 64K as
currently advertised there. Patch for that here: [1]
With that patch I see the SD card fully working, and at the correct
speed, so this patch here is:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Please add a Fixes tag and Cc: stable to the tags, like this:

Fixes: fb038ce4db55 ("clk: sunxi-ng: add support for the Allwinner A100 CCU")
Cc: stable@vger.kernel.org

And make sure to also Cc: that address when sending that out. Or
Chen-Yu adds the tags while committing, and we send this separately to stable?

And maybe we can change the commit message to be a bit less vague, and
just say while it's unknown why the flag was there in the first place,
it doesn't make any sense and severely limits MMC transfer speeds.

Cheers,
Andre


[1] https://lore.kernel.org/linux-sunxi/20241107014240.24669-1-andre.przywara@arm.com/T/#u

> - SD clock is set up correctly: parent is PLL_PERIPH0-2x, rate is 50
>   MHz, correct for High Speed@4bit and its 25MB/s bus speed.
> - eMMC works fine, clock parent is PLL-PERIPH0-2x, rate is 100 MHz,
>   correct for HS-200 (100 MHz * 8 bit * 2(DDR)). The read speed is
>   72MB/s, which sounds alright, and might be a limitation of the flash
>   chip.
> 
> So NO_REPARENT is always worse for me.
> 
> > > Also it would be good to know why CLK_SET_RATE_NO_REPARENT was put there
> > > in the first place: I don't see it in any other MMC clocks in sunxi-ng, so
> > > it wasn't just copied&pasted.    
> > Seeing that mmc2 acts better with the flag, perhaps it was copy + pasted
> > from that config. Or perhaps the issues we're running into comes from
> > elsewhere in the chain. At the moment, that's only speculation, though;
> > I'm waiting on a device that has an SD card slot so I can perform more
> > testing myself and debug these issues.
> >   
> > > So was there a problem that this flag was supposed to fix? Is that
> > > something that only applied to older kernels (back when the MMC patches
> > > were first posted), and which has now been fixed/changed elsewhere?    
> > Yangtao Li/Frank Lee assumably no longer works at Allwinner, as the email
> > he used to submit this originally no longer exists, but I believe the same
> > Yangtao is now a maintainer of the Allwinner cpufreq subsystem, and is
> > CC'd on these patches. I'm sending this reply to him as well; perhaps he
> > may have some additional insight.
> >   
> > > I feel a bit uneasy of just removing this just because it works(TM),
> > > especially if it doesn't really (SD card for me, for instance).    
> > I agree; I was quickly preparing V2 to hopefully get this in before the
> > 6.13 window for the sunxi tree closed, and added this in last minute after
> > verifying it worked on my current device, which lacks an SD card slot.
> > 
> > This patch can be skipped for now, as it's apparent MMC0/1 require a little
> > more love before we can merge it in. I'll submit new patches in the future
> > once this is figured out.  
> 
> This patch would be a fix anyway (with a Fixes: tag), so we can push it
> still into 6.13, after -rc1, and it would be backported. So it's not as
> critical, timing-wise.
> 
> Cheers,
> Andre
> 
> > 
> > Thanks!
> > - Cody
> >   
> > > Cheers,
> > > Andre
> > >     
> > >> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > >> ---
> > >>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
> > >>  1 file changed, 3 insertions(+), 3 deletions(-)    
> >   
> 
> 


