Return-Path: <linux-kernel+bounces-393578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93D9BA294
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2323A1C21A91
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC311ABEAC;
	Sat,  2 Nov 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="YRNtUsgb"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9F1AAE1E;
	Sat,  2 Nov 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730583885; cv=none; b=SPRoTispT+Uog0KVlvjGsfLy34XfvGkjzPqjADma/FtUQLJfPCNJfsQmIG0zBrBlW73NaEfTEY7a47kOhXY4I/fZyOE+keEkFNPk29ozt0nofWAP3SSC5QMuL2gDuNhZ0qv7XDTYaQhgtzLILIOURNUAshe5rehqWpCzPjVfX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730583885; c=relaxed/simple;
	bh=Lu/8kzBZcinrEdsRMpHobonycBFaKkQUKqIBgEOAOog=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PXlGZelTe0mkyKzXYvfBRt+OLMBUaZi/jZJNj9gKq43/pCbaK1ObZyRYiMRX+i4TLbYwvjF+nC9db8yRE3EcZb8+FUnSt+nRWTgpGndkMw4ZVQ16R5QpeF2z/gDSAPkm5O2zCDR5JE4+J9pOlcJm5SwwwGZwqgSWC+bQbOHZSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=YRNtUsgb; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730583882;
	bh=Lu/8kzBZcinrEdsRMpHobonycBFaKkQUKqIBgEOAOog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YRNtUsgbeXSuR+N83j0SDxH5tvMaogSfMyQ3WPAd0pjOdHFX8tQXrlutFALSolz2h
	 CHmTkNr9obUuqNG5umh/Mg63FdHkf2uVBKvCMKTYp5CO9vuKJEVSuslYcDxZvdYYWx
	 nlIg6qiGrFKDEFUkTPnm5vj8T77TP3q79P0irGaOew4T/VrY8qd5lPGxTKj92ICOnI
	 99YnuppdjAhXOYkKmsArBCttjrHFm6qMO9YWzUYYavigE+phV0zYwPi/a+LzwzEWrN
	 z+tbRwvQnjY8nZ3ANlo4sH2y/ZiHJe6ajESDpoe4G9YFeYghB05vXyCm2fPBslErNM
	 kd2lc5J4rc6Ow==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 Nov 2024 18:44:41 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Andre Przywara <andre.przywara@arm.com>, Yangtao Li
 <tiny.windzz@gmail.com>
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
In-Reply-To: <20241031120857.60bc0d94@donnerap.manchester.arm.com>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-9-masterr3c0rd@epochal.quest>
 <20241031120857.60bc0d94@donnerap.manchester.arm.com>
Message-ID: <885047f813d0c55eae13f26b0bfe041d@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024/10/31 9:08 am, Andre Przywara wrote:
> Well, while this change indeed prevented that error message you mentioned,
> but the SD card still doesn't work for me: it probes and I can mount a
> filesystem on it, but then it hangs, for instance when running an "ls" on
> it. It could be my setup (lacking DT or device issue or missing kernel
> config), though, and the eMMC works for me this way, but it would be good
> to have that sorted. 
I'm investigating this now; it appears mmc2/eMMC is more consistent when
CLK_NO_REPARENT is set

> Also it would be good to know why CLK_SET_RATE_NO_REPARENT was put there
> in the first place: I don't see it in any other MMC clocks in sunxi-ng, so
> it wasn't just copied&pasted.
Seeing that mmc2 acts better with the flag, perhaps it was copy + pasted
from that config. Or perhaps the issues we're running into comes from
elsewhere in the chain. At the moment, that's only speculation, though;
I'm waiting on a device that has an SD card slot so I can perform more
testing myself and debug these issues.

> So was there a problem that this flag was supposed to fix? Is that
> something that only applied to older kernels (back when the MMC patches
> were first posted), and which has now been fixed/changed elsewhere?
Yangtao Li/Frank Lee assumably no longer works at Allwinner, as the email
he used to submit this originally no longer exists, but I believe the same
Yangtao is now a maintainer of the Allwinner cpufreq subsystem, and is
CC'd on these patches. I'm sending this reply to him as well; perhaps he
may have some additional insight.

> I feel a bit uneasy of just removing this just because it works(TM),
> especially if it doesn't really (SD card for me, for instance).
I agree; I was quickly preparing V2 to hopefully get this in before the
6.13 window for the sunxi tree closed, and added this in last minute after
verifying it worked on my current device, which lacks an SD card slot.

This patch can be skipped for now, as it's apparent MMC0/1 require a little
more love before we can merge it in. I'll submit new patches in the future
once this is figured out.

Thanks!
- Cody

> Cheers,
> Andre
> 
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)

