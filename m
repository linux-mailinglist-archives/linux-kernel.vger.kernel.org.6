Return-Path: <linux-kernel+bounces-446427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAD89F2438
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE4518866B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF818E03A;
	Sun, 15 Dec 2024 13:40:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DF71714B7;
	Sun, 15 Dec 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270047; cv=none; b=iSjDvnSKiOb9e5pwzSDVWAn+oZ74xS6T/Aa60tS9GCDkI7rlo6PgD0N3WDB7W0m7aabvMHpo627oKZ6ztOgnbs7D+LCdR0B2sSr2v/VsNhtWYFgUSEmyGtvCZjijSs6mPJqjdHqGtQuZv1aLCx+bHWJCAuX6XfRCWJxNR/07wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270047; c=relaxed/simple;
	bh=Clhigu/Q4gCmERhzrswzfgXprFlUs+6+4e/00LAi3G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qc99dl6JhAc2hdX8t856RzJRKkda9GGTW6CDWQ9PkAQECh39t9JDeQsnuPPSxz9Tsxu2gH3C5yvPskQlI5LVtoa6pfhvIcfyNntQ8ZJItfd9g6uX2C+1uZaNV14ycixt8+3CmzVW1uBA/p3dEheY1wTmgALdwNp5oTd7huJgRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8414611FB;
	Sun, 15 Dec 2024 05:41:05 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 730863F720;
	Sun, 15 Dec 2024 05:40:35 -0800 (PST)
Date: Sun, 15 Dec 2024 13:39:50 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, Roman Beranek
 <me@crly.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: allwinner: a64: fix video output on Pinebook
Message-ID: <20241215133950.27e5877a@minigeek.lan>
In-Reply-To: <20241215053639.738890-1-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
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

On Sat, 14 Dec 2024 21:34:56 -0800
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

Hi Vasily,

thanks for tracking this issue down and sending the fixes!

> Since commit ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux"),
> TCON0 clock parent is always set to PLL_MIPI, but unfortunately it breaks
> video output on Pinebook.
> 
> I did an experiment: I manually configured PLL_MIPI and PLL_VIDEO0_2X
> to the same clock rate and flipped the switch with devmem. Experiment clearly
> showed that whenever PLL_MIPI is selected as TCON0 clock parent, the video
> output stops working.

That is good info, together with what Roman reported in that patch
mentioned above it seems to confirm that the parent clock selection
also determines the output path of TCON0.
Since there does not seem to be another register or switch setting
the path (ignoring the pinmux), I think a DT solution is appropriate
here, and assigned-clock-parents is the right way to go.

So the patch series looks good to me in general, but we thought that of
Roman's series as well, so I would really like to see a Tested-by: from
a Pinephone user and ideally a confirmation from Roman that this still
works for him.

Also I second Dragan's comments about copying the rationale into at
least the commit messages (if not in comments). Having explanations
in the cover letter is good, but having it in the git repo is much
better - as the cover letter will only be in the email archives.

Cheers,
Andre
 
> 
> To fix the issue, I partially reverted mentioned commit and added explicit
> TCON0 clock parent assignment to device tree. By default, it will be
> PLL_MIPI, and the only users with RGB output - Pinebook and Teres-I will
> override it in their dts.
> 
> Vasily Khoruzhick (3):
>   dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
>   arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0
>   clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts |  2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts  |  2 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         |  2 ++
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c                 | 11 -----------
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h                 |  2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h            |  2 ++
>  6 files changed, 8 insertions(+), 13 deletions(-)
> 


