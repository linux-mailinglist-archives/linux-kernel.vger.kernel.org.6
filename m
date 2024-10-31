Return-Path: <linux-kernel+bounces-390466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3439B7A45
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66D1B21A11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731C19C560;
	Thu, 31 Oct 2024 12:09:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E0719C543;
	Thu, 31 Oct 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376547; cv=none; b=cbc6pPFIeGkxH0V4ZQI3D2Mgw47tK2tnPF4pdDsMnX+I76KodYGxeT766fI64tA4jnSGRfC4vnw4krsbDL6NGwR9RIVClN7Fj8PwywTSOukAGAb2nWU79Z29bUIodVZvDGq9xMWznwBu84qj4kHw7AI4E6lUz/2eir0hi1WBQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376547; c=relaxed/simple;
	bh=Wv5hadH+e1F/HEWDsAPYpkLC0cTt41LyjpDp1vYyvMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgIOHdjOts0odt2W1bEBkoGqxtPDpFLepdHGbEN2MWcdh5+VQMlQzgXZLotjW17po/8rtkEoaFd1HNrP6eRyDWvwvHMle+LxU1seFlb4OD8xat7nBRex8kzOnIHRBTsTyEh5p6iSP0qmSUIlwPh6aqP5Xwv0shSZUnKE9vdmDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3A821063;
	Thu, 31 Oct 2024 05:09:33 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8228B3F66E;
	Thu, 31 Oct 2024 05:09:00 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:08:57 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>, Parthiban
 <parthiban@linumiz.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] clk: sunxi-ng: a100: enable MMC clock
 reparenting
Message-ID: <20241031120857.60bc0d94@donnerap.manchester.arm.com>
In-Reply-To: <20241031070232.1793078-9-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
	<20241031070232.1793078-9-masterr3c0rd@epochal.quest>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 04:02:21 -0300
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

> During testing, it was noted that MMC would fail to initialize, with
> "mmc: fatal err update clk timeout" being printed in the log. It was
> found that CLK_SET_RATE_NO_REPARENT was set on the MMC controllers, and
> that removing this allows MMC to initialize. Therefore, remove
> CLK_SET_RATE_NO_REPARENT from mmc0/1/2.

Well, while this change indeed prevented that error message you mentioned,
but the SD card still doesn't work for me: it probes and I can mount a
filesystem on it, but then it hangs, for instance when running an "ls" on
it. It could be my setup (lacking DT or device issue or missing kernel
config), though, and the eMMC works for me this way, but it would be good
to have that sorted. 

Also it would be good to know why CLK_SET_RATE_NO_REPARENT was put there
in the first place: I don't see it in any other MMC clocks in sunxi-ng, so
it wasn't just copied&pasted.
So was there a problem that this flag was supposed to fix? Is that
something that only applied to older kernels (back when the MMC patches
were first posted), and which has now been fixed/changed elsewhere?

I feel a bit uneasy of just removing this just because it works(TM),
especially if it doesn't really (SD card for me, for instance).

Cheers,
Andre

> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
> index bbaa82978716..a59e420b195d 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
> @@ -436,7 +436,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
>  					  24, 2,	/* mux */
>  					  BIT(31),	/* gate */
>  					  2,		/* post-div */
> -					  CLK_SET_RATE_NO_REPARENT);
> +					  0);
>  
>  static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
>  					  0, 4,		/* M */
> @@ -444,7 +444,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
>  					  24, 2,	/* mux */
>  					  BIT(31),	/* gate */
>  					  2,		/* post-div */
> -					  CLK_SET_RATE_NO_REPARENT);
> +					  0);
>  
>  static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
>  					  0, 4,		/* M */
> @@ -452,7 +452,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
>  					  24, 2,	/* mux */
>  					  BIT(31),	/* gate */
>  					  2,		/* post-div */
> -					  CLK_SET_RATE_NO_REPARENT);
> +					  0);
>  
>  static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
>  static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);


