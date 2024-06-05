Return-Path: <linux-kernel+bounces-202047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C288FC71E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D043281DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF418F2CB;
	Wed,  5 Jun 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gcEbUftW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5591946A0;
	Wed,  5 Jun 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577929; cv=none; b=fy8/Qk1DByfl1heLMAkBgti4exikwwKgAKtWZG6gpetBjiWML4dOebpAN07WUcbQD3y25gzrndMHYdd4L2qGuV06JP9isPKPQ2UZ0r+zc8/iUXra7QVw/Lw7Pea55YMWmLcK5OmyqlzGM/DiE72dBqYRyVtO1YFnEOEP9XFLqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577929; c=relaxed/simple;
	bh=E9bKa5eaXN9IXwj+pyk09iQ4ho8MGyNTSWvYxyoPiwc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5aWCZseeQj02U8GUyxFeE9AAf9VHHlNtaESVTYRpJAqdht2iPl6eIoPG9wnH3AB11gf+rw3FvJV3lckrieoikN4SL5FA27OVKDy3YQBhD8KXs5oR4Ww8xSrcEVMwZ4OwHXPD75QaLOwRemzveMMpNNTx12j/fRvvNjnvSZU100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gcEbUftW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4558wOIi111622;
	Wed, 5 Jun 2024 03:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717577904;
	bh=6K8uQ9T4YbTy8mI8o3mLebwVWauesYOJt0ObeTW3U8c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=gcEbUftWNntXi2Bchuf924ZczCygS1yC9Ua8AJgPrsIzs0aGSRDayVCLI83vQuAW5
	 9JGQuoCA/DjwG0QpDYyHOnusWtflhW1LvhCRBe3l2tIg4LOt/wsiMh/8+WB1kWmg9N
	 pW2Q3UiudId8V/5E8mn348GHynCZFbIspP+c/YvU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4558wOmA095199
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 03:58:24 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 03:58:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 03:58:24 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4558wNiU007448;
	Wed, 5 Jun 2024 03:58:23 -0500
Date: Wed, 5 Jun 2024 14:28:22 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
Message-ID: <yd4doskkq443xkvc4ahnxexyi7f5oteoh5egiv3plcduyl7dfr@dgtdwd3dbdkg>
References: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
 <20240604-mcasp_fifo_drop-v1-5-03ebe25f47db@ti.com>
 <20240605084713.GA10711@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605084713.GA10711@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

Thanks for the review.

On Jun 05, 2024 at 10:47:13 +0200, Francesco Dolcini wrote:
> Hello Jai, thanks for the patch.
> 
> On Tue, Jun 04, 2024 at 03:11:06PM +0530, Jai Luthra wrote:
> > McASP AFIFOs are not necessary with UDMA-P/BCDMA as there is buffering
> > on the DMA IP. Drop these for better audio latency.
> > 
> > Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > index 2038c5e04639..27e5220e1dc7 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > @@ -1364,8 +1364,8 @@ &mcasp0 {
> >  	       0 0 0 0
> >  	>;
> >  	tdm-slots = <2>;
> > -	rx-num-evt = <32>;
> > -	tx-num-evt = <32>;
> > +	rx-num-evt = <0>;
> > +	tx-num-evt = <0>;
> 
> From my understanding of the dt-binding having these properties set to
> <0> is equivalent to not having those properties at all.
> My suggestion would be to just remove those, therefore.
> 

I was following the existing convention of setting it to 0 for 
disabling, as done in k3-j721e-common-proc-board.dts

IMO it is better to keep it explicit, but I don't feel strongly against 
dropping it either (as long as we do the same for j721e). Will defer the 
decision to the tree maintainers.

> With that said, in any case, whatever you do my suggested change or 
> not,
> 
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Francesco
> 

-- 
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

