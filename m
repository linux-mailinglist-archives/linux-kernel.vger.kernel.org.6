Return-Path: <linux-kernel+bounces-292277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A5956D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC1E1F223A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB816C692;
	Mon, 19 Aug 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="t6lMb7s/"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407E1EB3E;
	Mon, 19 Aug 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078018; cv=none; b=sqk544vC4zQLy15FT//TJPg5lYDZSfL7kMru3M1+UR/zACg3cmX5RS4f4WQnsIYaxCerGIIUDlmgam0247pD6bFh/Jla/qxNR26mGExzqP80HyopCjc0ePtlwHBYW5+cDx9wzF1hjQekqpuR93jkamtWc81TsnriGyvypriUVaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078018; c=relaxed/simple;
	bh=H+ZIKiMh674Bjzw07BrdT0R3OoZs01VKiKWa0fM7Bbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9MV0YLz9HhQ8bg/lrpxylJOgGv32VgLH/4co/qUsyK7Q5z8LSsIkUcPXfoISOZW1gHpSSEu4r6PZanyP0g2p0uP7pVB8sWrA+zgeqEagCW8IlX0wuF1IcqL/BXYQU+chVOBevCarnfYB3j/eKT63rZkw9Fl6ayql6g2dBiKjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=t6lMb7s/; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72A0B1487C4C;
	Mon, 19 Aug 2024 16:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724078007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iQVOt1llIIcq5WnSoYkc52Dl6PKByIIU7aUlvEKpzvE=;
	b=t6lMb7s/zGX10EiHF2Li7uk4xcylapG8vYpyB59LnJ5kmHXoX5BBuvRepIWzFtaWGaOWjZ
	Cbs86csBU7GRG5eyhgULso93l4KSubNUbFAWRTLXGEh2TIT6CvrRMCZUyWRkH8/T5VBITe
	mcQslqX/urGyCTYhBTvsz7ux5t1pnmFf65fD7d79U7HFDP1px8QvCjBlZnC7/nmYlMYhoi
	RYF83LTHnv1PChD4hag71zMFOQ/izaYQrcRL8C3/hEyS+fzS4BSs8R37apskpWnvKh5LXO
	SZXOgc9KrJ9/AKJwRYfVWsXK7TO4NF9t9g3Df+BIZ840b4abKddSn1fH+bf90g==
Date: Mon, 19 Aug 2024 16:33:19 +0200
From: Alexander Dahl <ada@thorsis.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org
Cc: Boris Brezillon <bbrezillon@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: get, prepare, enable a clock not in DT?
Message-ID: <20240819-education-prong-3da4b83d42ed@thorsis.com>
Mail-Followup-To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Boris Brezillon <bbrezillon@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

Am Fri, Aug 16, 2024 at 04:34:48PM +0200 schrieb Alexander Dahl:
> Hello everyone,
> 
> while further investigating timeout issues with the at91 otpc
> controller on sam9x60 [1] I came to the conclusion the main RC
> oscillator on that SoC must be enabled for that driver to work.
> (Verified that by poking single bits in registers through devmem
> already.)
> 
> Fortunately the necessary clk is already registered from the SoC code
> in drivers/clk/at91/sam9x60.c [2] and I can see the clock in sysfs clk
> summary:
> 
>     root@DistroKit:~ head -n4 /sys/kernel/debug/clk/clk_summary 
>                                      enable  prepare  protect                                duty  hardware                            connection
>        clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>     ---------------------------------------------------------------------------------------------------------------------------------------------
>      main_rc_osc                         0       0        0        12000000    50000000   0     50000      Y   deviceless                      no_connection_id         
> 
> That clock has no parent and is not found anywhere in devicetree, nor
> is it handled by the two clock-producers on that platform, so
> from within mchp_otpc_probe() I just tried this:
> 
>     otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");
> 
> However that returns with -ENOENT, so I assume I can not reference the
> clock just by name?  Same result with this:
> 
>     otpc->clk = devm_clk_get_enabled(NULL, "main_rc_osc");
> 
> How do I get a pointer to that clk then to enable it?  Docs [3] where
> not as useful as I hoped for, neither was clk.h header docs. :-/

Tried this today:

    otpc->clk = __clk_lookup("main_rc_osc");

However calling that from platform driver code smells suspicious and I
get a linker error when building anyways.

Found no other possibility to get a grip on that clock from driver
code.  Do we need to hook that main_rc_osc into dt somehow so it can be
enabled from driver code?

Adding Boris, Alexandre, and Nicolas to Cc, because they were involved
in the at91 clk drivers in the past.  O:-)

Greets
Alex

> From what I understood from header docs reading 'device for clock
> "consumer"' I must pass the device from which I call that clk_get() as
> first parameter, so this would be the otpc device then, right?  What's
> that second parameter clock consumer id then?  Are these terms
> explained somewhere?
> 
> Greets
> Alex
> 
> [1] <20240813-payable-ecology-8a9e739704bb@thorsis.com>
> [2] https://elixir.bootlin.com/linux/v6.10.4/source/drivers/clk/at91/sam9x60.c#L217
> [3] https://kernel.org/doc/html/latest/driver-api/clk.html
> 
> 

