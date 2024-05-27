Return-Path: <linux-kernel+bounces-190261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D58CFC24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE301C21C97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F0131E5D;
	Mon, 27 May 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BBqy+7X0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CF200A9;
	Mon, 27 May 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799729; cv=none; b=JlWnRRIwQIkikCEFk0dTOafOE/9MW7kwqxHfCEaEG/r+lSuAteY9DtwJcqXCVREQmbmndY5/aNEPFCw4WYdyNGFDfR8zvTEA2wYEUPz+/ryKDH+AxF3cf1A16Zq61QMowGq3eLX1FyM2KPWAV9jRGCM0PhRXACm/Nebfue0mCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799729; c=relaxed/simple;
	bh=lCInwPQGWV6yvJqm1FwlYPN27CMsPkkVuOOZC8ux+ck=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppytsxSUg9YXMNRlXNIFKv2D2XGa+8NkGDo+ciGBatRF6XdbKLJCuLHH8ybB6XnN+3BbhqBr96YNO0XIBwrsZ641J5YBoV7UClNzS0Ex8GGKNNGVheJ7muYuVWqgLGqD0hI8taf7CzFUgY7STKamSkatEZmCH7Co5Qme3izc/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BBqy+7X0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44R8mZue108920;
	Mon, 27 May 2024 03:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716799715;
	bh=7nE114znKj/m87TzZii91ejlqNlEWTc9hbUbC+MFft0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BBqy+7X0l448A95WqwpfQFuTWH765TC4VXanbGFEh/2kjl7PBHa1Ig5M1CMPV/xLB
	 bG61jCK6ovLMy7f3Aob/hOfQFGBWSLcOyiFaM2xSJ8rjbBvC0qB/ED7vtH0qI7uWQS
	 j6DUPP7GsZHEZvMJOzSOH9CvYVXnMUp36dacesy4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44R8mZFU117210
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 03:48:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 03:48:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 03:48:35 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44R8mYwX058361;
	Mon, 27 May 2024 03:48:35 -0500
Date: Mon, 27 May 2024 14:18:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-am62p: Add partial-io wakeup
 sources
Message-ID: <20240527084834.b6uf6jimbpazsvfq@dhruva>
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-7-msp@baylibre.com>
 <20240524055458.bc7hwwifcurwt7oe@catty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240524055458.bc7hwwifcurwt7oe@catty>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On May 24, 2024 at 00:54:58 -0500, Nishanth Menon wrote:
> On 10:02-20240523, Markus Schneider-Pargmann wrote:
> > From: Vibhore Vardhan <vibhore@ti.com>
> > 
> > In Partial-IO mode there are a number of possible wakeup sources. Add
> > the list of phandles to these wakeup sources. Based on the patch for
> > AM62a.
> > 
> > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62p.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> > index 94babc412575..4d43cc972056 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> > @@ -123,3 +123,7 @@ cbass_wakeup: bus@b00000 {
> >  #include "k3-am62p-main.dtsi"
> >  #include "k3-am62p-mcu.dtsi"
> >  #include "k3-am62p-wakeup.dtsi"
> > +
> > +&dmsc {
> > +	ti,partial-io-wakeup-sources = <&mcu_mcan0>, <&mcu_mcan1>, <&mcu_uart0>, <&wkup_uart0>;
> > +};
> 
> NOTE: https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#supported-low-power-modes
> table of SoCs supported do not provide J722s or AM62p in
> the list. I suspect it is an oversight, but seems to be a mismatch atm.

Yes, you are right. We will fix this in the documentation soon.
AM62P will be added to that list. J722s does not have lpm support.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

