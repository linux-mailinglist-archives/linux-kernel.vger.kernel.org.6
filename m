Return-Path: <linux-kernel+bounces-397951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38F9BE2DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410A71F219D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30351DA63C;
	Wed,  6 Nov 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="P8IrTqVC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F218C00E;
	Wed,  6 Nov 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886105; cv=none; b=AQ2GY97/kBapabAas8859C7jG0QiffFH2yR6xqyUbxz9FMhfJHVpVhms+fGDFKn3i0Qnsu6Qyj/wVUkNfbKw8ZPTAAx68MOR77Enj0qAYr02V2vXg/EI9H6zWVZmTq3g0hCLDWG+TBbtzY47lyzkoabpQx/UJo1J54XBrC86Fms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886105; c=relaxed/simple;
	bh=Z5roYg9oRz3yI9LK5xYLrK5CwmwJFt3kt0HhvBbnyRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMczB4N0zMIRy2iUy0sUSk/PypdsP+QojtyEbkumwHjZfr6esjSGuzgYQbTBp3jHqPK9oEXnd4PhTdfVkN6ZnWgdQ8ibGlJoA2b7vXOCX8qn+ESNCqsnNECSyv57I2O5hTK8zoGGV9LUAAsAfx0hrw9IQxrGHaziKxR6E0/jILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=P8IrTqVC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R33AHOEKuWVl8dftmRKyPE5U6BtAYCDsZvIA1WDMh7s=; b=P8IrTqVCjorN7eadZJASD5gDV+
	DkgY0GG4hZ4lNvGNzMranIQVOzUUk17FfkTOySdqpwtT0VB/ElK2uHdIseXsi7JazCi9gvjRaMGUH
	ZvbopYu7W+ndp1Mdx1LHimV2R//HGArXbV45ZVybT9wm5NBZWFz4NZQkOP5nD0pW0Kw//PRtmeOhq
	8JrBEUhzc3tV/pPX4da5cKaI04Ne5SKcOEiTkROu9S+HIs0U5a8Smmd6/Bb8zyaL5Pix4j/lqcAsw
	haN4uGgxT/K8U1tTeTur/kQx0hkI3+wr/0K5UULXuJzRY0uvUTtgHFDJpLNy+LBs2ZSJ6htduGd8B
	cvIMtT1A==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8cXh-00062B-Pe; Wed, 06 Nov 2024 10:41:37 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alchark@gmail.com
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC
 dtsi
Date: Wed, 06 Nov 2024 10:41:36 +0100
Message-ID: <3252308.5fSG56mABF@diego>
In-Reply-To: <f6bb3387-4396-45d4-9cb4-594d58095510@cherry.de>
References:
 <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
 <f6bb3387-4396-45d4-9cb4-594d58095510@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 6. November 2024, 10:32:06 CET schrieb Quentin Schulz:
> Hi Dragan,
> 
> On 11/6/24 9:33 AM, Dragan Simic wrote:
> > Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in the
> > SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may be
> > useful if there are any OP1-based boards whose associated voltage regulators
> > are unable to deliver the exact voltages; otherwise, it causes no functional
> > changes to the resulting OPP voltages at runtime.
> > 
> > These changes cannot cause stability issues or any kind of damage, because
> > it's perfectly safe to use the highest voltage from an OPP group for each OPP
> > in the same group.  The only possible negative effect of using higher voltages
> > is wasted energy in form of some additionally generated heat.
> > 
> > Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Well, I merely highlighted that the voltage was different on OP1 
> compared to RK3399 for the 600MHz OPP :)
> 
> So... If there's ONE SoC I'm pretty sure is working as expected it's the 
> OP1 fitted on the Gru Chromebooks with the ChromiumOS kernel fork 
> (though yes, I believe all Gru CB are EoL since August 2023). In the 6.1 
> kernel fork, there's also no range: 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-6.1/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi

yeah, this somehow goes quite a bit into the "stuff that doesn't need to
change" area. On the one hand it does make "some" sense to unify things
if we're using ranges everywhere else.

On the other hand, as Quentin noted below, all existing OP1 devices seem
to run just fine, and there won't be any more entering the kernel.

So what do we realisitically gain here, except hiding existing git-history
under another layer?

> So not sure we need to handle theoretical cases here. Will let 
> maintainers decide on that one. FWIW, there are two other OP1 devices, 
> the RockPi4A+ and RockPi4B+ which do not change the OPP either.


Heiko



