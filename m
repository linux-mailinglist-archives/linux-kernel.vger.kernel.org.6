Return-Path: <linux-kernel+bounces-346093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B198BF7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6811F246A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765F1CB50F;
	Tue,  1 Oct 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="spjDrQm6"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA91CB326;
	Tue,  1 Oct 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791987; cv=none; b=SiCD1WgpePmg74NwU4wUq7yotlYA0c07Saaa7YA6tsiPlKiJKsHsRSGzsNfVaAfTipHigUfkD+OBEiegD9Yn23d+4QRsCrTBMcXZoC5pC9fobGduOnW8nsMh//ldnlnPeTtD2+t7nm4zkXyxvvrMssUxYsflVFdEqQ/gXJ/l5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791987; c=relaxed/simple;
	bh=Bv1lZ9pYZX4a1F0IxYaJoGt/bx5QFgBAtiX+7uCGqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEHDnJaX+jX6oFf6X9/evRXnJ9/1T5oE3qkUCTrWOFWd2bFzJZRShl+6gqgUjWVNzDCB/p8xRC5SVAlWR9vno9gt5oMO1Nu17LprdDXE90+1EmLlhIPqUsQJxzt0mwzExIGxePeCCddsZsR5BGvmxd7FwUdxNFSCRazcpugWqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=spjDrQm6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 780F01F9BE;
	Tue,  1 Oct 2024 16:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727791981;
	bh=HkIi6vdWzZRL9mRqwCQESkyqXZUUQQRvVyjVDYHczpM=;
	h=Received:From:To:Subject;
	b=spjDrQm6RjfD+ES2VkYGpNMvdca/QmvzvP6MXC0fmwGxrAbgSdz7UwYAmX6PFx7zI
	 uwxc4Fn6lACjXQyDQNFDZ0Umt4t2ntYnTiXSN4hRiD8+bRTpDQuBmwDjRqVFOU53zY
	 36NNeUAVjrtPfve5B9OZt0bJr7ctLH465/OyEWTpRhyjPllzC3gT/FtlkZpN/aikkx
	 4FWoVuZ7a3rtzbrBl/7j86JepQDqqFCp1neXYIGPKOayaKUiKNQLArTCmjmfjfw3kj
	 VTsuL1y58XI26bRfZKKa8mZbcYN3HpISD93SZrx4JSVnHU3ujGO8xIiE6d9mi5gbkt
	 r76CSW6vPcPXA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 15CCF7F919; Tue,  1 Oct 2024 16:13:01 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:13:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc
 compatible
Message-ID: <ZvwDbch2H6ycTfEv@gaggiata.pivistrello.it>
References: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
 <a5890be6-914c-48cc-9abd-761961ccb7ca@kernel.org>
 <20241001130128.GA36341@francesco-nb>
 <3d9de1b8-488b-4df5-b984-7581b1d02241@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d9de1b8-488b-4df5-b984-7581b1d02241@kernel.org>

On Tue, Oct 01, 2024 at 03:59:39PM +0200, Krzysztof Kozlowski wrote:
> On 01/10/2024 15:01, Francesco Dolcini wrote:
> > On Tue, Oct 01, 2024 at 01:54:56PM +0200, Krzysztof Kozlowski wrote:
> >> On 01/10/2024 13:14, João Paulo Gonçalves wrote:
> >>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> >>>
> >>> With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
> >>> new compatible was introduced for TLA2024 ADC. Update the device
> >>> tree to use the correct compatible for the Verdin-AM62 hardware.
> >>>
> >>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> >>> ---
> >>>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> >>> index 5bef31b8577b..f201722d81b3 100644
> >>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> >>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> >>> @@ -1220,7 +1220,7 @@ sensor@48 {
> >>>  	};
> >>>
> >>>  	adc@49 {
> >>> -		compatible = "ti,ads1015";
> >>> +		compatible = "ti,tla2024";
> >>
> >> So it is not always TI, who breaks their users. :) (as pointed out in
> >> LPC DT BoF).
> > 
> > So, let's adjust what I said at that time, I think is important, and I
> > appreciate you giving me an excuse for doing that :-)
> > 
> > Lately as Toradex we are working a lot with TI, and one of the reasons is
> > that they have a great software support, backed-up by a great strategy
> > on the way they contribute to the various upstream projects they build
> > their SDK on top (Linux, U-Boot, and more).
> > 
> > With that is normal that while working so closely with them we find
> > issues, everybody have those, it's just that those are the one we
> > care the most at the moment :-). Not to mention that we started working
> > with TI a couple of years ago, so TI is still somehow "new" to us and we
> > are still "learning".
> > 
> > On this regards I was recently working on updating our BSP to the
> > latest SDK from TI, that is based on a v6.6 stable kernel and looking at
> > the patches we had to apply on top, the total counts of the patches we
> > do not have in mainline to support the board subject of this patch is
> > just _zero_. This to me is a great achievement.
> > 
> > Nishant: this is also for you, and feel free to "market" this
> > internally/externally :-)
> > 
> > 
> >> If you want to break users, sure, but at least explain in commit msg why.
> > 
> > Now, on this specific topic, the actual device that is assembled on this
> > board is a TI TLA2024, and it's like that since ever, the board never
> > changed. The current compatible is not matching what is assembled on
> > board. It works because the device is close enough to TI ADS1015.
> > 
> > With that said, I do not think this is breaking any actual compatibility
> > issue.
> > 
> >  - The old DTB will keep working with old and new kernel.
> 
> New DTB stops working with old kernel and this is what we talked about
> during LPC.

My mind at that time was really on using old DTB with a new kernel, not that
other way around.

In any case, I do not think that this comment applies on this specific case,
as I wrote you cannot really run this board on a kernel that does not support
the ti,tla2024 compatible.

> All out-of-tree users of this DTS, like other operating systems, will be
> affected as well probably.

Well, yes. From what I know those user do not exist and this is just
theoretical, but, I might be as well wrong and I see your point.

So, let me try to sum it up, I see 2 options:

 1 - we drop this change. this is fine for me.
 2 - we add a comment in the commit message that this is a breaking change, and
     while I am not aware of any impact with real software that is available today,
     I might have incomplete information.

Francesco


