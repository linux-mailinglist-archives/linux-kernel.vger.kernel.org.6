Return-Path: <linux-kernel+bounces-202660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3668FCF40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDE5298449
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26551ABCCC;
	Wed,  5 Jun 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WnB4isZm"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD29188CB1;
	Wed,  5 Jun 2024 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591968; cv=none; b=FDWdCmm/EpM/ek/Pu6/Ql7+BMCBhJE53fojx3m2M4BGzGDBG0H2tYjuPUY0IaUwN/AQ1T2MXVXiKh6D+9KGwZBIQfc72ICs+MGLX3fsnTOO4lUKHWZtLuaCS0af68D9XqlLZ9JS2wfcrMYlrhgexnTXnhJz6O5X8pwVgbJSnIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591968; c=relaxed/simple;
	bh=Sy7T7GzC2ZOWsY/UPrXngYcioAZUouVavGghEB3t+y8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWF7Rq3WybVy3zG2NngPv1WyXDK9d5iJxoeTyowZYFatDPW3OkRAVyLDPlsSj7/1KZuAxnYXNkaX7sD9an8xLSihJAOnvQrlW+7HCIrCRjEe66A23Kum3U6PkzhqHQ7lpHwUdSzEj1lylXZYB3IFkfFm8k81cQlkKhz/gjFKuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WnB4isZm; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455CqXsp119194;
	Wed, 5 Jun 2024 07:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717591953;
	bh=PZVe92Rj78eN1DbQzLm0zMnQYFdOj9DVODRU7I5SMuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WnB4isZmCxppFWtKWywfN/vCtH+mz0z5CKJINTCZX98cDRGKHU02w0GCW3z28rBxL
	 FBXA6rREkk1Gv5vLQJ/ymxZ0RXrD3/6KkbgUOv3y8KMud+gfBHTmIXDKKMYuejAhVX
	 2v4mDVxw8GXNNJrIg+bRz+MLxrbhqCX62U5IhOa4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455CqXlP113459
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 07:52:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 07:52:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 07:52:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455CqWSL115373;
	Wed, 5 Jun 2024 07:52:32 -0500
Date: Wed, 5 Jun 2024 07:52:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Jai Luthra <j-luthra@ti.com>
CC: Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>, Bryan Brattlof <bb@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
Message-ID: <20240605125232.5xql5nonllyslchc@saucy>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
 <20240604-mcasp_fifo_drop-v1-5-03ebe25f47db@ti.com>
 <20240605084713.GA10711@francesco-nb>
 <yd4doskkq443xkvc4ahnxexyi7f5oteoh5egiv3plcduyl7dfr@dgtdwd3dbdkg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <yd4doskkq443xkvc4ahnxexyi7f5oteoh5egiv3plcduyl7dfr@dgtdwd3dbdkg>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:28-20240605, Jai Luthra wrote:
> Hi Francesco,
> 
> Thanks for the review.
> 
> On Jun 05, 2024 at 10:47:13 +0200, Francesco Dolcini wrote:
> > Hello Jai, thanks for the patch.
> > 
> > On Tue, Jun 04, 2024 at 03:11:06PM +0530, Jai Luthra wrote:
> > > McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
> > > on the DMA IP. Drop these for better audio latency.
> > > 
> > > Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> > > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > > ---
> > >  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > > index 2038c5e04639..27e5220e1dc7 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > > @@ -1364,8 +1364,8 @@ &mcasp0 {
> > >  	       0 0 0 0
> > >  	>;
> > >  	tdm-slots = <2>;
> > > -	rx-num-evt = <32>;
> > > -	tx-num-evt = <32>;
> > > +	rx-num-evt = <0>;
> > > +	tx-num-evt = <0>;
> > 
> > From my understanding of the dt-binding having these properties set to
> > <0> is equivalent to not having those properties at all.
> > My suggestion would be to just remove those, therefore.
> > 
> 
> I was following the existing convention of setting it to 0 for 
> disabling, as done in k3-j721e-common-proc-board.dts
> 
> IMO it is better to keep it explicit, but I don't feel strongly against 
> dropping it either (as long as we do the same for j721e). Will defer the 
> decision to the tree maintainers.
> 

If they are equivalent, then just drop them.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

