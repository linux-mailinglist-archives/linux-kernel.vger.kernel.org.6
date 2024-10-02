Return-Path: <linux-kernel+bounces-347617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131AF98D7CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3899283491
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB61D049A;
	Wed,  2 Oct 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hLiA9pLp"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE91CFECF;
	Wed,  2 Oct 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877196; cv=none; b=swuoeflU28hscjMq9Grm5rimSXO5zZmDiRn1cIz6QVt7U0dgE6nlmIfc5XLCltxLR+iAjSaTX7P0goNB/3igYWW2SZJuCTLQ9gX9DjQF0D/e5toMcOJcDTFc0eC6n0kQp973XJATE7W0T4v6FCIvWAq8Sm6PwNzsncj7gj9ZUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877196; c=relaxed/simple;
	bh=Dvtls3LmStEhPYmbSurL6kU70esmzQDeAiUtPfW3f8I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuPoizqEvsoknnNZpA4tDsSS7/BXxwZQIy45SsH+LfakS71rWKP6UXaxspx4X62n+6YOP/0nAM+FvQMO/u+7eAuW+xTSU+W0iI7VwGcIxlxRRhGxeOC2xqRo5EViQjkkJcAhYEivMJhfQpmy2/yHKCMhfge+6MpK5t3cwRjUFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hLiA9pLp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 492Dqkei105058;
	Wed, 2 Oct 2024 08:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727877166;
	bh=kdaxm034HK1IrO7lNPdA+4dHoE23nmXi05U5LcLMGtU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hLiA9pLp4+KXTM46PEUNulfU7lyWEPYE4JxtQNqWKiy0RJQSTwfpq9LmSHmBJnKWx
	 gBJ199kh4WRLYtS/Y2HaRkqmuPEIzPdQ+RLdNrZ7OSVxBNQesjbed9kXRvovC+9VZS
	 19dt2T6otsumyYc+ItntFHbanYffULcJ8hXfMPwM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 492Dqk9s083322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Oct 2024 08:52:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Oct 2024 08:52:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Oct 2024 08:52:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 492DqkSj090517;
	Wed, 2 Oct 2024 08:52:46 -0500
Date: Wed, 2 Oct 2024 08:52:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc
 compatible
Message-ID: <20241002135246.dvzciibdcdb2r4ni@education>
References: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
 <a5890be6-914c-48cc-9abd-761961ccb7ca@kernel.org>
 <20241001130128.GA36341@francesco-nb>
 <3d9de1b8-488b-4df5-b984-7581b1d02241@kernel.org>
 <ZvwDbch2H6ycTfEv@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvwDbch2H6ycTfEv@gaggiata.pivistrello.it>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:13-20241001, Francesco Dolcini wrote:
> On Tue, Oct 01, 2024 at 03:59:39PM +0200, Krzysztof Kozlowski wrote:
> > On 01/10/2024 15:01, Francesco Dolcini wrote:
> > > On Tue, Oct 01, 2024 at 01:54:56PM +0200, Krzysztof Kozlowski wrote:
> > >> On 01/10/2024 13:14, João Paulo Gonçalves wrote:
> > >>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > >>>
> > >>> With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
> > >>> new compatible was introduced for TLA2024 ADC. Update the device
> > >>> tree to use the correct compatible for the Verdin-AM62 hardware.
> > >>>
> > >>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > >>> ---
> > >>>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > >>> index 5bef31b8577b..f201722d81b3 100644
> > >>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > >>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > >>> @@ -1220,7 +1220,7 @@ sensor@48 {
> > >>>  	};
> > >>>
> > >>>  	adc@49 {
> > >>> -		compatible = "ti,ads1015";
> > >>> +		compatible = "ti,tla2024";
> > >>
> > >> So it is not always TI, who breaks their users. :) (as pointed out in
> > >> LPC DT BoF).
> > > 
> > > So, let's adjust what I said at that time, I think is important, and I
> > > appreciate you giving me an excuse for doing that :-)
> > > 
> > > Lately as Toradex we are working a lot with TI, and one of the reasons is
> > > that they have a great software support, backed-up by a great strategy
> > > on the way they contribute to the various upstream projects they build
> > > their SDK on top (Linux, U-Boot, and more).
> > > 
> > > With that is normal that while working so closely with them we find
> > > issues, everybody have those, it's just that those are the one we
> > > care the most at the moment :-). Not to mention that we started working
> > > with TI a couple of years ago, so TI is still somehow "new" to us and we
> > > are still "learning".
> > > 
> > > On this regards I was recently working on updating our BSP to the
> > > latest SDK from TI, that is based on a v6.6 stable kernel and looking at
> > > the patches we had to apply on top, the total counts of the patches we
> > > do not have in mainline to support the board subject of this patch is
> > > just _zero_. This to me is a great achievement.
> > > 
> > > Nishant: this is also for you, and feel free to "market" this
> > > internally/externally :-)
> > > 
> > > 
> > >> If you want to break users, sure, but at least explain in commit msg why.
> > > 
> > > Now, on this specific topic, the actual device that is assembled on this
> > > board is a TI TLA2024, and it's like that since ever, the board never
> > > changed. The current compatible is not matching what is assembled on
> > > board. It works because the device is close enough to TI ADS1015.
> > > 
> > > With that said, I do not think this is breaking any actual compatibility
> > > issue.
> > > 
> > >  - The old DTB will keep working with old and new kernel.
> > 
> > New DTB stops working with old kernel and this is what we talked about
> > during LPC.
> 
> My mind at that time was really on using old DTB with a new kernel, not that
> other way around.
> 
> In any case, I do not think that this comment applies on this specific case,
> as I wrote you cannot really run this board on a kernel that does not support
> the ti,tla2024 compatible.
> 
> > All out-of-tree users of this DTS, like other operating systems, will be
> > affected as well probably.
> 
> Well, yes. From what I know those user do not exist and this is just
> theoretical, but, I might be as well wrong and I see your point.
> 
> So, let me try to sum it up, I see 2 options:
> 
>  1 - we drop this change. this is fine for me.
>  2 - we add a comment in the commit message that this is a breaking change, and
>      while I am not aware of any impact with real software that is available today,
>      I might have incomplete information.

From the discussion:
a) old dtb will continue to work on new kernel (using the older driver
   compatible)
b) new dtb will work on new kernel
c) new dtb with older kernel depends on the kernel support for the
   driver. Looking at compatible in drivers/iio/adc/ti-ads1015.c and
   commit f1c9ce0ced2d, I see the oldest kernel is around v5.18 or .19 kernel
   when at least this file was not yet in mainline.

So, it sounds like a fixes to indicate the correct compatible to me at
least.

I suggest (2) and update the commit message to indicate backward and
forward compatibility aspect - I do not see either broken here.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

