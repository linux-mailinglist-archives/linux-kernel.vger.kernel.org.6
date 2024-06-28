Return-Path: <linux-kernel+bounces-233449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26591B735
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2CB2114C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B06F30D;
	Fri, 28 Jun 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LtuqRWhC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86942D299;
	Fri, 28 Jun 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556477; cv=none; b=d3hCrSpuyNDwooxu0B17ESpICEyQdko4kQ/ooTGyIhugtMtN4PRcrO6Oiyn/Adz+vUy0bcZk3GX/QNJwddSChs9sCONRwbMGej8DQhUH+NpdUn13ox5kNVsupUmR7uXbPxg2ArRCN7vhh9DdgC1TCLa2hTh6tIoZyh/AjfCc+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556477; c=relaxed/simple;
	bh=QX5i1Jlu4f0foxdkyYDl96KkxCMyShmnwCTqq26tLck=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrjjFLrgsxQ1ePAUPPQQ1a8fHWCIuxtEGG0/rH5nq5hT8X0+JrG8PjXZ5+KHLGLXoBADrLORfo9UrZXDzi5DfreRSNZDCwzmhBUoRWDOGsjYK4LYYXM6MfLlVu+lQDYQfnolqfci2/ROfxNR/eunM9eeGAOl6gDROi9fMszy5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LtuqRWhC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S6YOZC121275;
	Fri, 28 Jun 2024 01:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719556464;
	bh=Zbl6+jdr0qBzglazNEyciK6UzROimMizMiToNMNclqI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LtuqRWhC+8ImISBfsAdkO+zr3RLMpQC+6Iq4+9OT6/farzfqPMvKkDkGsq3VlW0vw
	 24KAXg5Vxxxbw10dxrb98+eCmc1spDh5K/kz0SVnEPmvjUI8AkLUyPO5sx/mxXiiLn
	 QUvb9KJ0QlElZDvFoph3fLR3RsAvMeEnObAvU/p8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S6YOBI042515
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 01:34:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 01:34:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 01:34:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S6YNwS082302;
	Fri, 28 Jun 2024 01:34:23 -0500
Date: Fri, 28 Jun 2024 01:34:23 -0500
From: Nishanth Menon <nm@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: soc: ti: pruss: Add documentation
 for PA_STATS support
Message-ID: <20240628063423.cprgwhatogc2dapo@stuffing>
References: <20240625153319.795665-1-danishanwar@ti.com>
 <20240625153319.795665-3-danishanwar@ti.com>
 <20240627144538.mp7n2l7kupi7gt4l@straddle>
 <cca91f88-d7cd-42e3-a4f3-065d536e623b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cca91f88-d7cd-42e3-a4f3-065d536e623b@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:56-20240628, MD Danish Anwar wrote:
> 
> 
> On 27/06/24 8:15 pm, Nishanth Menon wrote:
> > On 21:03-20240625, MD Danish Anwar wrote:
> >> Add documentation for pa-stats node which is syscon regmap for
> >> PA_STATS registers. This will be used to dump statistics maintained by
> >> ICSSG firmware.
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >> index c402cb2928e8..3cb1471cc6b6 100644
> >> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >> @@ -278,6 +278,26 @@ patternProperties:
> >>  
> >>      additionalProperties: false
> >>  
> >> +  ^pa-stats@[a-f0-9]+$:
> >> +    description: |
> >> +      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
> >> +      registers where different statistics related to ICSSG, are dumped by
> >> +      ICSSG firmware. This syscon sub-module will help the device to
> >> +      access/read/write those statistics.
> >> +
> >> +    type: object
> >> +
> >> +    additionalProperties: false
> >> +
> >> +    properties:
> >> +      compatible:
> >> +        items:
> >> +          - const: ti,pruss-pa-st
> >> +          - const: syscon
> >> +
> >> +      reg:
> >> +        maxItems: 1
> >> +
> > 
> > Is this a patch in a driver series? I do not see the driver part..
> 
> No Nishant, this is not a part of driver series. This binding patch is
> related to [1] which is merged to net-next. The regmap will not be used
> by drivers/soc/ti driver instead once both binding are in, the driver
> changes will be needed in drivers/net/ethernet/ti/icssg/icssg_prueth.c
> as there is no driver changes needed in drivers/soc/ti, I posted this
> patch as stand alone. Considering this binding and [1] they both go to
> different tree, I decided to get the bindings in first and in next
> kernel cycle when they both are part of mainline linux, I can post the
> driver changes.

This is indicating some strong coupling that is sounding a bit
suspicious. Please add in the full series so that folks can see the
inter dependencies.

> 
> > if this is a memory map, why doesn't bus model work?
> > 
> 
> I am just trying to maintain consistency here. pa-stats sub-module is
> similar to mii-g-rt and mii-rt. I am adding pa-stats in the same way as
> mii-g-rt and mii-rt.
> 
> All these three modules are eventually mapping a memory region so that
> the icssg driver can use them and read / configure registers.

Sounds like mapping a bus is more appropriate? I dont seem to see it
though.

> 
> > 
> >>    interrupt-controller@[a-f0-9]+$:
> >>      description: |
> >>        PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
> >> -- 
> >> 2.34.1
> >>
> > 
> 
> [1] https://lore.kernel.org/all/20240529115225.630535-1-danishanwar@ti.com/
> 
> -- 
> Thanks and Regards,
> Danish

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

