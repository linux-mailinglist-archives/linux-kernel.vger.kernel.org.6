Return-Path: <linux-kernel+bounces-360763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E18999F35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A871F238BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CC720B216;
	Fri, 11 Oct 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Z6lvzrqv"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1120ADD9;
	Fri, 11 Oct 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636231; cv=none; b=Fmd/X+CH5Nsi9cDwUAHSFFdOZVM5HNQZee0bJjTbH5e4jsRlimjTM2KXpuG2CD7fLLwNANQg2MqZ+kuQzh7gi8qh66r7jmNmXrqjUezi+ryko44d75B591RO5lFZwpcpxfNN0BYLW6g9we58RFGBlOLReGST2ZEl+dEm/X0bJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636231; c=relaxed/simple;
	bh=m4iic7uKAXnsL6uCrTkkS8/BqTZS/Mc3ys/B02K28sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRmwCPfqXlTbp1okYQVXBhs/bsw6cQlasgmImcK0y/SsaWYfSuyb7qO06ZbXtDS1JT2CoipmqCmAMM4BkHb6EXx2mJ11SbCSiY0UlWRZfBZhukDPNE9++wsTHXQHrpPkNhc2GL6YmOSWi3vHAPGheWxozOFHk8JVylpVqKpx9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Z6lvzrqv; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=reuDQlwZETnYSzS/i7ijoLlelnSTU2XRw/IvwMzVWMQ=; b=Z6lvzrqv5WpV5ajzRR/JH6hisw
	dg1veub6KgDb9AV1WD8qUiRRk8EiTl51ZC5GVO0zbAgcMvBZwYGufCH2haBjfbx/CM3DDq7sr9dQs
	07dztG9S5r4ggIjCqSXp8S9FiuyBDR2hNeXLh/wYw316xmyA2z65xRvwEyn5khM781blw10YTfgn5
	UoshcCss63COWkW1F4SMHNCXXgofjrBecZF4GJoptW7KsLoKsJSazL5L15CPDnI/PoPzdthOYzc0v
	7RbJalfaxHxJ357BL4Z23cvP/x8uJGcXo1lYSesI6xw9aLk6FCXSNll8MMPEKutfzxnQEV8Cj3X0O
	k2L2tMpA==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1szBFP-0005Ig-7T; Fri, 11 Oct 2024 10:43:43 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>,
 Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC variant
Date: Fri, 11 Oct 2024 10:43:42 +0200
Message-ID: <1999678.yKVeVyVuyW@diego>
In-Reply-To: <D4SU6WHZCN34.2XL5W4D2T188G@cknow.org>
References:
 <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
 <20da65423e77e13511cc7c7bb39e0246@manjaro.org>
 <D4SU6WHZCN34.2XL5W4D2T188G@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 11. Oktober 2024, 10:33:56 CEST schrieb Diederik de Haas:
> Hi Dragan,
> 
> On Fri Oct 11, 2024 at 10:23 AM CEST, Dragan Simic wrote:
> > On 2024-10-11 10:00, Diederik de Haas wrote:
> > > On Fri Oct 11, 2024 at 9:40 AM CEST, Dragan Simic wrote:
> > >> Following the hierarchical representation of the SoC data that's been 
> > >> already
> > >> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move 
> > >> RK3399
> > >> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the 
> > >> Rockchip
> > >> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
> > >> ...
> > >> The RK3399S variant is used in the Pine64 PinePhone Pro only, [1] 
> > >> whose board
> > >> dts file included the necessary adjustments to the CPU DVFS OPPs.  
> > >> This commit
> > >> effectively moves those adjustments into the separate RK3399S SoC dtsi 
> > >> file,
> > >> following the above-mentioned "encapsulation" approach.
> > >> ...
> > >> ---
> > >> ...
> > >>  .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
> > >>  arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123 
> > >> ++++++++++++++++++
> > >>  2 files changed, 124 insertions(+), 22 deletions(-)
> > >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> > >> 
> > >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
> > >> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > >> index 1a44582a49fb..eee6cfb6de01 100644
> > >> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > >> @@ -13,7 +13,7 @@
> > >>  #include <dt-bindings/input/gpio-keys.h>
> > >>  #include <dt-bindings/input/linux-event-codes.h>
> > >>  #include <dt-bindings/leds/common.h>
> > >> -#include "rk3399.dtsi"
> > >> +#include "rk3399-s.dtsi"
> > >> 
> > >>  / {
> > >>  	model = "Pine64 PinePhone Pro";
> > >> @@ -456,27 +456,6 @@ mpu6500@68 {
> > >>  	};
> > >>  };
> > >> 
> > >> -&cluster0_opp {
> > >> -	opp04 {
> > >> -		status = "disabled";
> > >> -	};
> > >> -
> > >> -	opp05 {
> > >> -		status = "disabled";
> > >> -	};
> > >> -};
> > >> -
> > >> -&cluster1_opp {
> > >> -	opp06 {
> > >> -		opp-hz = /bits/ 64 <1500000000>;
> > >> -		opp-microvolt = <1100000 1100000 1150000>;
> > >> -	};
> > >> -
> > >> -	opp07 {
> > >> -		status = "disabled";
> > >> -	};
> > >> -};
> > >> -
> > >>  &io_domains {
> > >>  	bt656-supply = <&vcc1v8_dvp>;
> > >>  	audio-supply = <&vcca1v8_codec>;
> > >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi 
> > >> b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> > >> new file mode 100644
> > >> index 000000000000..e54f451af9f3
> > >> --- /dev/null
> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
> > >> @@ -0,0 +1,123 @@
> > >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > >> +/*
> > >> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> > >> + */
> > >> +
> > >> +#include "rk3399-base.dtsi"
> > >> +
> > >> +/ {
> > >> +	cluster0_opp: opp-table-0 {
> > >> +		compatible = "operating-points-v2";
> > >> +		opp-shared;
> > >> +
> > >> +		opp00 {
> > >> +			opp-hz = /bits/ 64 <408000000>;
> > >> +			opp-microvolt = <825000 825000 1250000>;
> > >> +			clock-latency-ns = <40000>;
> > >> +		};
> > >> +		opp01 {
> > >> +			opp-hz = /bits/ 64 <600000000>;
> > >> +			opp-microvolt = <825000 825000 1250000>;
> > >> +		};
> > >> +		opp02 {
> > >> +			opp-hz = /bits/ 64 <816000000>;
> > >> +			opp-microvolt = <850000 850000 1250000>;
> > >> +		};
> > > 
> > > Is there a reason why there isn't a line separator between the various
> > > opp nodes? Normally there is one between nodes.
> > > Note that in rk3588-opp.dtsi there are no separator lines between the
> > > opp nodes, while they do exist between other nodes.
> > > And in rk356x.dtsi the opp nodes do have a separator line.
> >
> > That has also bothered me. :)  I already had a look around in various
> > dts(i) files long time ago and there seems to be no preferred layout.

I guess "with" lines in between is sort-of preferred in general.
I sometime add them in new board-dts when applying and noticing them,
but also sometimes miss them.

I guess empty lines are helpful when the nodes are "not the same",
but I guess for OPPs it doesn't matter so much, as the individual nodes
are all the same.


But in the end, I guess just follow the other OPPs in rk3399 for now ;-)
[as this patch does]

> I'm inclined to say the opp ones are the odd ones.
> 
> > In this particular case, it's better to have no separator lines because
> > that's what we already have lacking in rk3399.dtsi, rk3399-t.dtsi, etc.,
> > so running something like "diff rk3399.dtsi rk3399-s.dtsi" makes it easy
> > to see what actually differs in the RK3399 SoC variants, without having
> > to filter out any whitespace differences.
> 
> Besides that inconsistencies always seem to 'trigger' me, I especially
> noticed it as this patch changed it from having separator lines to
> having no separator lines.
> 
> Cheers,
>   Diederik
> 





