Return-Path: <linux-kernel+bounces-192323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF28D1B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA71F22A01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC57416D9AE;
	Tue, 28 May 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sNggamer"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9616D4EB;
	Tue, 28 May 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900165; cv=none; b=FVFMZ9abeormi3uFjMAqo79lAgQD9PKcMcEi/7Orfu+6SQg6OQm8cVKThdzJTbrgX1DmqdKkMUAlNiWv6wDG/SwNr0kDPVSk0DuREQ32HXIztAb+nam9XQ+z7hDfoLzmNjG8drXuj0Q32vw8kC/Rq3JEPHNEPIOu/8eE3d49eVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900165; c=relaxed/simple;
	bh=5umDUPMvgm0DNRjpvDjL7qTM2FRL1kwjct86Mu+/3J8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf2AxZTDmTa37BWzWG4hi2bnmNO9OYJeZbF3Ky+AgJ7f8WQ4WPEif0c+0ViU4YozAKbFT5vKGnlTosYORY6Qk9ZSN9WW4+vy9kjGH433FhN+jTq2BDHl0u91CC1hcvs1tvFJA9ILuXtk5SJZO8fP9wMf8GC7CuPvSQouKRa0t3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sNggamer; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SCgb6o083110;
	Tue, 28 May 2024 07:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716900157;
	bh=7bVlkZjcF40aNAZ1/MndlKZbBfsTrd7yFW9m/hzm7+E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=sNggamerhYncz4Ms/y8MkI7F77SlPsnQpXOB5d4m0QBJRf1lxFjy/y+QRWXEwAdQG
	 0SX3ZSINc5TiMrisskBngGc4C2vcavsPO+AGOswvlkv64zhckBd8KnZfmMqGXPHEQH
	 o+cBFx/835QyVpxE9vcmc7CYUybwbKmLtdtQ4kbo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SCgb7k077069
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:42:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:42:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:42:37 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SCgaH4050275;
	Tue, 28 May 2024 07:42:36 -0500
Date: Tue, 28 May 2024 18:12:35 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: ti: k3-j722s: Add lane mux for Serdes1
Message-ID: <4df26738-c86f-4180-889c-afa45ac4777f@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-6-s-vadapalli@ti.com>
 <1e6242a1-2dc5-4f88-9cbb-eb14a27cccc4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e6242a1-2dc5-4f88-9cbb-eb14a27cccc4@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:23:32PM +0300, Roger Quadros wrote:
> 
> 
> On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> > The Serdes1 instance of Serdes on J722S SoC can be muxed between PCIe0
> 
> Please use SERDES insted of Serdes or serdes as it is an abbreviation.

Ok.

> 
> > and SGMII1. Update the "serdes_ln_ctrl" node adding support for the lane
> > mux of Serdes1. Additionally, set the default muxing for Serdes1 Lane0 to
> > PCIe0.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > Current patch is v1. No changelog.
> > 

[...]

> > @@ -96,8 +96,9 @@ usb1: usb@31200000{
> >  &main_conf {
> >  	serdes_ln_ctrl: mux-controller@4080 {
> >  		compatible = "reg-mux";
> > -		reg = <0x4080 0x4>;
> > +		reg = <0x4080 0x14>;
> >  		#mux-control-cells = <1>;
> > -		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
> > +		mux-reg-masks = <0x0 0x3>, /* SERDES0 lane0 select */
> > +				<0x10 0x3>; /* SERDES1 lane0 select */
> 
> Why not introduce this right in the patch where you add serdes_ln_ctrl mux node?

I was preserving patch authorship from the v2 series. I will combine
this in the v4 with a Co-developed-by tag.

Regards,
Siddharth.

