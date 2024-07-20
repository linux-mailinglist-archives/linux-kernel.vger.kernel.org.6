Return-Path: <linux-kernel+bounces-258047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90419938297
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F971C2101B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD9148856;
	Sat, 20 Jul 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H9PJJ8SE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EB15AF1;
	Sat, 20 Jul 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721502272; cv=none; b=ir5mzbaIlCQofkiv4gfbyYAI7a3IcjC/PfacqbcVuC5+4Cf9G1wn1EgrsJNroJgahzmA2ncL9+E0TLsbsW1il4ZE9qEM/vSCkfDTXJuNkIqDWHcil/iIIui3fq5K4eQcnfNMzqZWnr40+bJYPTizUpf45f2PfB3KzyVReLprLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721502272; c=relaxed/simple;
	bh=u4p8Wez4OEif5XDMDZB/OcvVVhVm90vcRSauP7AF2Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3IfwA6RgnoCNi1CBOfWVB//3VjGWsayG7bSEEge5G3C0OvaZ0T/4O/TekJnDjZT4DJUxpGIdxoIHqaSmZRicYDlv74wezW1dUvs1c+YdUuLR+g/VBSqmwqM1KHoSqQqQSCzbMMxs08Rg+Q8wTtWNhIs9VF6SB0CEpmBsyQ3Ic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H9PJJ8SE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BE54p3YGClfJDDCL6XCD3gOyj0Z+zt+Mt1nuvA2yYII=; b=H9PJJ8SEpssxh8qxaXzQQJQPNs
	h+NH7LMZpcLixiZA0Oln9ee29DOLNnxGREM1xDuV/Is/xFP8aUyKKSVuj8+wOuy7gdKJzFlrjHzWW
	TJ91QRDnGok+vOpWIxoaiQ1GS5ll0UDgI4u0GR4L0PcGF3sA7qrInqQGuYTtoolK9VHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sVFNU-002uUn-Jo; Sat, 20 Jul 2024 21:04:20 +0200
Date: Sat, 20 Jul 2024 21:04:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v2 2/4] arm: dts: marvell: armada-38x: add
 description for usb phys
Message-ID: <2f91fb4e-df92-43f0-9c43-08862acbaba4@lunn.ch>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
 <20240716-a38x-utmi-phy-v2-2-dae3a9c6ca3e@solid-run.com>
 <44ce546d-c043-44ad-9e2c-eaf052e5531b@kernel.org>
 <2a7936ef-3a50-49df-b6a9-337b38d33c57@solid-run.com>
 <a88faea2-662c-4c19-96b5-bfa423cd826c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88faea2-662c-4c19-96b5-bfa423cd826c@kernel.org>

On Sat, Jul 20, 2024 at 08:23:09PM +0200, Krzysztof Kozlowski wrote:
> On 20/07/2024 15:19, Josua Mayer wrote:
> > Am 17.07.24 um 14:04 schrieb Krzysztof Kozlowski:
> >> On 16/07/2024 22:52, Josua Mayer wrote:
> >>> Armada 38x has 3x USB-2.0 utmi phys. They are almost identical to the 2x
> >>> utmi phys on armada 8k.
> >>>
> >>> Add descriptions for all 3 phy ports.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>> ---
> >>>  arch/arm/boot/dts/marvell/armada-38x.dtsi | 29 +++++++++++++++++++++++++++++
> >>>  1 file changed, 29 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/marvell/armada-38x.dtsi b/arch/arm/boot/dts/marvell/armada-38x.dtsi
> >>> index 446861b6b17b..701a1c0c19ad 100644
> >>> --- a/arch/arm/boot/dts/marvell/armada-38x.dtsi
> >>> +++ b/arch/arm/boot/dts/marvell/armada-38x.dtsi
> >>> @@ -392,6 +392,11 @@ comphy5: phy@5 {
> >>>  				};
> >>>  			};
> >>>  
> >>> +			syscon0: system-controller@18400 {
> >>> +				compatible = "syscon", "simple-mfd";
> >> That's not a valid pair. They cannot be alone.
> > Curious! I have seen it in armada-cp11x.dtsi.
> 
> Old code, I don't think anyone is working on armada and other Marvell
> chips, so by copying old code you will copy bugs or wrong designs. I can
> only suggest to work on recent platform where such oddities are fixed...

As you say, these are old platform. I'm not sure they are actually
buggy or wrong design, it is more that current day best practice is
different to the best practice back then. This was from before the
time linting tools and .yaml existed for DT.

The kirkwood-b3.dts i wrote in 2013 still works, my NAS box gets its
kernel updated about once a year, and a new disk about every 8
years. These systems can keep running for a long time. We have to
accept there will be legacy DT.

       Andrew

