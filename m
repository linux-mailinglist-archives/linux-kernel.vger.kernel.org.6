Return-Path: <linux-kernel+bounces-221088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95190EC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5579F1F22DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761A1143C4E;
	Wed, 19 Jun 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vcY55Q7N"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BF143873;
	Wed, 19 Jun 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802175; cv=none; b=MKLano0x43GKybgfmKm61DFA5H7WTKCGqbqwcbv4V2gQzF684QEJKO9iWZ+U754IhYhU5cJsEb6RXrwe/zsJ4syZXGDX82VETysTWrk3DVpMiNsBQ0Qnwhm0cX8A4UQoNt5wR7pUWFQmnjEHds4vIk6GcbaX5eTuJjXaNFg/em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802175; c=relaxed/simple;
	bh=Jvol2e9lzek2jg8e0ND3FZQETfpH3FrvjCpbr4/IHBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/x/j+D6AqmknMOPFgUmYzyjonFvBOPF7SM3Zx7bjcm7Kjc5alnExI3KMn0o7jKLsPMCebIYZ17mddjWvj1EFCthQEPJah/eScHEOb99e2OFTNhHoQbzJWKWbOKsPNA1LwAgyWGiwNfywti2Bexj54Wdp7f/jRHYHAZIlImSmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vcY55Q7N; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JD2e2l124608;
	Wed, 19 Jun 2024 08:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718802161;
	bh=4INkyI/sA/RaVNPzbecxi0GUkLiFmY7SAMUpTE6Nhj0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vcY55Q7N6FUWYgG6ivM0o6CZAyEHiPcj3x1AKrhrCmCBhQrgmhoTpscniMlgAjKkw
	 OihOQdtdCzKcqj1Fn0Hhqx45J9GrkPE15uDLY4LfHe0G5dWpke0IEugAZmbZ4ourEZ
	 Zkn7cuCNkXQW1Vfna44ppsZvQZ4+o2Vo0KmsuDuA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JD2eK6040475
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 08:02:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 08:02:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 08:02:40 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JD2eDU124779;
	Wed, 19 Jun 2024 08:02:40 -0500
Date: Wed, 19 Jun 2024 08:02:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-pinctrl: Define a generic GPIO
 MUX Mode
Message-ID: <20240619130240.azkb4fwhrnwlsv45@uneasily>
References: <20240618173123.2592074-1-nm@ti.com>
 <20240618173123.2592074-2-nm@ti.com>
 <20240619045258.xy4pwqv6ut5wzk63@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240619045258.xy4pwqv6ut5wzk63@dhruva>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:22-20240619, Dhruva Gole wrote:
> Hi Nishanth,
> 
> On Jun 18, 2024 at 12:31:21 -0500, Nishanth Menon wrote:
> > Introduce a GPIO mux mode macro for easier readability. All K3 devices
> > use mux mode 7 to switch to GPIO mux.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-pinctrl.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > index 4cd2df467d0b..b1a0415e6611 100644
> > --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> > @@ -38,6 +38,8 @@
> >  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> >  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> >  
> > +#define PIN_GPIO_MUX_MODE	(7)
> > +
> 
> While I do agree that this is a standard thing, don't you think that
> updating it everywhere else (k3 DTs) makes sense? Having the number 7 in some
> places and others having PIN_GPIO_MUX_MODE will give rise to confusion I
> feel.
> 


Yes, thinking again, we will repeat using this for other SoCs as well for
gpio-ranges. I think it might be better if we did this instead:

/* Default mux configuration for gpio-ranges use with pinctrl */
#define PIN_GPIO_RANGE_IOPAD  (PIN_INPUT | 7)

* Clears up the understanding what the define is for.
* Consistent usage across K3 SoCs.
* Prevents mis-understanding where to use the macro.

Thoughts?
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

