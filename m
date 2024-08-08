Return-Path: <linux-kernel+bounces-279314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E694BBB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B42281894
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FA18A950;
	Thu,  8 Aug 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HBG9tYpv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11C18A6CD;
	Thu,  8 Aug 2024 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114393; cv=none; b=K41CAssStfad5ZoFgMTvI/SGDFSjAoVZKFQ/7BBq2NyOfNyF49gAWCgz2+NpZYz58BIq7mJ+cu0QB9WwRNyvQWvKmMuAalrcBtNyTwUHgXbul9LmTxSziUlvi0CFtgIPLWjUUvkJiBLewxtown2A6caTzjq839aX7E0trXgDYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114393; c=relaxed/simple;
	bh=wz6VfZxt63c9DtHqIc2OsLJG6x/b0G4bHEdbEZmRaos=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKPhMhDmL6rRDtyS6WF501xc1f/eSgDU93Lsdm3ATsxR6GZZn5y8zpZUNYnfniQL+eotCcmhMkM5TUQckHwWTvXardQcdppeNtRxHeL5shFqaqEBZPlsenPHR+j76Fhm5Djjq5zKmhUci+8TzLq3+WAxIqMDHC3HNK6sJ2aIsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HBG9tYpv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478Ar68p125594;
	Thu, 8 Aug 2024 05:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723114386;
	bh=dWxdi8HTTXFR+eyz0Ut/74IaZvXdRjO+e8qgAdYq/GA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HBG9tYpv7bUVZkRJPIE5onpJYl+f92Y4q6kykZFaDDPfL9phjG2G6nGsRdHhZiuD9
	 ZdSMYRGocW/40Wjor/Tm6Xi/jeHt8m0MzI2kDqNtZo2eXJYJDdwpxqrddQgcWdfVuR
	 D6TehEWHGSDxFulpSj9BODwyKx+bOM5/UWf0J4C4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478Ar6au073671
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 05:53:06 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 05:53:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 05:53:06 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478Ar6Ix063841;
	Thu, 8 Aug 2024 05:53:06 -0500
Date: Thu, 8 Aug 2024 05:53:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
        <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux
 for mmc1
Message-ID: <20240808105306.clwdgrfulqhsyeyt@studied>
References: <20240807101624.2713490-1-b-kapoor@ti.com>
 <8fa39624-9a92-404d-8651-9ade5700a7d3@ti.com>
 <1319a6ac-6784-45d6-8a0e-170e40d3aa18@ti.com>
 <2279305f-2efa-4320-866a-fc4340d2e70c@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2279305f-2efa-4320-866a-fc4340d2e70c@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:19-20240808, Neha Malcom Francis wrote:
> Hi Bhavya
> 
> On 08/08/24 13:08, Bhavya Kapoor wrote:
> > Hi Neha,
> > 
> > On 08/08/24 11:51 am, Neha Malcom Francis wrote:
> > > Hi Bhavya
> > > 
> > > On 07/08/24 15:46, Bhavya Kapoor wrote:
> > > > mmc1 was not functional since pin mux for clklb was not present.
> > > > Thus, add clklb pin mux to get MMC working.
> > > > 
> > > > Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support
> > > > for AM68 SK base board")
> > > > Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> > > > ---
> > > > 
> > > > rebased to next-20240807
> > > > 
> > > >   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > > > b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > > > index 90dbe31c5b81..d5ceab79536c 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> > > > @@ -204,6 +204,7 @@ main_mmc1_pins_default: main-mmc1-default-pins {
> > > >           pinctrl-single,pins = <
> > > >               J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
> > > >               J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
> > > > +            J721S2_IOPAD(0x100, PIN_INPUT, 0) /* (###) MMC1_CLKLB */
> > > >               J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
> > > >               J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
> > > >               J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
> > > 
> > > How is this different from the P23 pinmux for MMC1_CLK? Could you
> > > explain what CLKLB is, since it doesn't have a ball number I'm
> > > finding it difficult to understand what it is?
> > > 
> > This pin needs to be setup so that MMC_CLK is looped back at pad level
> > for highspeed SDIO operations (has been same across K3 family). MMC0/1
> > has this pin configured as INPUT by reset default as these have boot
> > media
> > 

Please update the commit message with the explanation of what CLKLB pin
is. the "reset default" is a bit confusing description.


> >   These pinmuxes are derived from pinmux file shared by EVM team during
> > wakeup/board bringup.
> > 
> 
> Thank you for explaining.
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> 



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

