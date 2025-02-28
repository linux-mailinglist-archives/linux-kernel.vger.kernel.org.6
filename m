Return-Path: <linux-kernel+bounces-538620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D709BA49B01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A543AE96A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603726D5CE;
	Fri, 28 Feb 2025 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dI3nKdmt"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A21B960;
	Fri, 28 Feb 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750825; cv=none; b=TwURfDKd0T3yJ1c4Ln+rOP9ZqscJUxaOQxqKdO5QgCQ01M/hjK2MmG3ZIpUdrGCXNqn6kTN6xFYu6JuNUU2byT2epqK+uSTfYzrrIce7wU7KIkW7ZyoSzktvLwudV4pzfT91IP43E+1ln8h+IhpsTOtw/3slKG8HG8Q5PvTDVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750825; c=relaxed/simple;
	bh=LbJAvDX1wJVlI8bkMn6KwzTkcXK+mgmgPtIetF/Xvmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTwBpH9K11WbOY4g8OH60ajevdOXox0Yod4lY66/SX2AfG2vhLzP3ORfpNTlqFQNigF5O1tPErg2wdNnYe/hSCHusSwo3f0DK9nS6FJxaNcMZ2+EOFqnHA25WwQndkJlHe8pCHEeBBYzu5m4y8OIwVfI/rg6zwqOSS2aZmI35kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dI3nKdmt; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51SDrPWX2066472
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 07:53:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740750805;
	bh=WazccXwMSXcNHgQGS2K75mUfu12ocGCld1cYtSPawdo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dI3nKdmtlYhflNq2aSAika4XzI51SZpqAznSBVM4M4ryK+8PrgEN8pYPoiielo0mM
	 NUFBCOGHkp/HzHO4xfDbsXBq2gS1v4A1UDfSyyyRcoyeIw9FJxxpgFdecqFr4nVMnv
	 D8jEzkjUshjgHcMxFUMb0wSVmB4fZUyddF8U01XA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51SDrPVL008551
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Feb 2025 07:53:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 07:53:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 07:53:24 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51SDrOXK072506;
	Fri, 28 Feb 2025 07:53:24 -0600
Date: Fri, 28 Feb 2025 07:53:24 -0600
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Jayesh Choudhary <j-choudhary@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx
Message-ID: <20250228135324.jy3qumbg4rg2kdih@factsheet>
References: <20250206153911.414702-1-francesco@dolcini.it>
 <20250207014239.xzm6rfnusckql2uo@litigator>
 <Z6XFPYaj069fvW1h@gaggiata.pivistrello.it>
 <20250228124347.GA20656@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250228124347.GA20656@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 13:43-20250228, Francesco Dolcini wrote:
> On Fri, Feb 07, 2025 at 09:33:01AM +0100, Francesco Dolcini wrote:
> > On Thu, Feb 06, 2025 at 07:42:39PM -0600, Nishanth Menon wrote:
> > > On 16:39-20250206, Francesco Dolcini wrote:
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > 
> > > > On AM62P-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> > > > external peripherals when configured through CTRL_MMR, so add the
> > > > clock nodes.
> > > > 
> > > > Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62px/clocks.html
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > > index 420c77c8e9e5..4b47b0774330 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> > > > @@ -42,6 +42,26 @@ &inta_main_dmss {
> > > >  	ti,interrupt-ranges = <5 69 35>;
> > > >  };
> > > >  
> > > > +&main_conf {
> > > 
> > > 	Why not add it to main_conf section it self in the file?
> > 
> > The reason is that main_conf is defined in k3-am62p-j722s-common-main.dtsi,
> > that is shared between am62p and j722s.
> > 
> > On j722s the audio refclk is added in k3-j722s-main.dtsi the same way as I did
> > here, so I cannot move this to k3-am62p-j722s-common-main.dtsi without updating
> > also k3-j722s-main.dtsi.
> > 
> > I looked into the differences of j722s and am62p, and from my understanding,
> > from the audio refclk point of view, they are identical (same IP, same reg, same
> > clocks and same IDs), so this should naturally be moved to
> > k3-am62p-j722s-common-main.dtsi as you are suggesting.
> > 
> > ... however, for some reason I am not aware of, on k3-j722s-main.dtsi a different
> > parent clock is used, and I cannot understand the reason. The actual parent clocks
> > in this patch are just the same we already have everywhere apart on j722s. I tried
> > to look at the history of this and it seems that on the TI downstream kernel branch
> > this is defined in the board dts file (!) and this confused me even more.
> > 
> > So, not wanting to break stuff I was not able to understand I came up with this
> > proposal.
> > 
> > An alternative could be to override the "unexpected" clocks from
> > k3-j722s-main.dtsi to the board dts file, and have the "standard" clocks, as
> > proposed in this patch and already used on all the other AM62 variants, in
> > k3-am62p-j722s-common-main.dtsi.
> > 
> > +Jayesh that is the author of this specific change in k3-j722s-main.dtsi.
> 
> Jayesh, Nishanth, any comment on this?
> 
> Should I proceed with this last option ?
> 
>    An alternative could be to override the "unexpected" clocks from
>    k3-j722s-main.dtsi to the board dts file, and have the "standard" clocks, as
>    proposed in this patch and already used on all the other AM62 variants, in
>    k3-am62p-j722s-common-main.dtsi.
> 

no, with your explanation it is clear that your patch matches with the
strategy we are using currently.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

