Return-Path: <linux-kernel+bounces-279107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A394B906
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C121F222A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784A18953B;
	Thu,  8 Aug 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EBco8W3I"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1191188004;
	Thu,  8 Aug 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105797; cv=none; b=msAvshW6QvS+e4M9r/IGHYgtbPMEZbHutd1+S3CA4UCalqzPWh85aAphLgqNrwLabmWv+EImiZ3eXS4F5UaiAp6i+pcX7PCabChOKQDs1SolT0HkICiQWFILqElFM/jFf7lDYk/Y61NAuj2Vrlvgs0qCdV9hqfa4jXLx8CynE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105797; c=relaxed/simple;
	bh=5rAKlKGzGydrprOOzglAQhYQrMbE5Ti2sS1sDTFQXy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+t5yHb1HcsMqaYm7Hf4qm28oXZnSxFEBv/9cFRlNQfiS/Bv+zzlhu58xIUUHsbBmMDRvARBfI4717LzYjcMLEacCrFZgqs5Tn62zwooeObihHg9Jna359l93JsfwrXA3SU4mBRu3z8+3dwtxwwMLeECZKqzl9slUvxuRYIuc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EBco8W3I; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4788Tmf5016834;
	Thu, 8 Aug 2024 03:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723105788;
	bh=FKX809N1Z2e/jn5gGGfjwgllKlIy5ezWa1gnW+9XNvE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EBco8W3Iq3OgIyRR0lAG2WUQTE11ExL5NeX26j9zBZEQ4fMvvkspLLcfkePvtosTQ
	 rC60qoxsDie+PODgLYeBIplKiXrw4hJFo5J+GQOdB/HGsWuTx+TKS/lJ4N4A/PCpkM
	 gNFB5TXTWQr9Dgw6uzgTEE8gP6bILncaA7IzCaPk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4788TmPl119069
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 03:29:48 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 03:29:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 03:29:48 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4788TlBt090632;
	Thu, 8 Aug 2024 03:29:47 -0500
Date: Thu, 8 Aug 2024 13:59:46 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux
 for mmc1
Message-ID: <20240808082946.pkmztwz6dthhnm57@uda0497581>
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

Hi Bhavya,

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
> >   These pinmuxes are derived from pinmux file shared by EVM team during
> > wakeup/board bringup.

I think it'd be good to put this in the commit message as well for more
clarity.

Regards,
Manorit

> > 
> 
> Thank you for explaining.
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> 
> > Regards
> > 
> 
> -- 
> Thanking You
> Neha Malcom Francis

