Return-Path: <linux-kernel+bounces-232499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E491A9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31531C219E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0032197A7A;
	Thu, 27 Jun 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eGZ99MzZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8192196C7B;
	Thu, 27 Jun 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499551; cv=none; b=leFdeGVQmyJav9fAKLWgTdzGiAqVbrNu75GpfqVdv3ZqbHzvXjRL0WpbsKRXRNNochKPjnlhEydHxXp+1vaaCSvotwxylCps90nFkYKWSu/t6IvY3HLxZEGKDy107ZViQT98a3XJ10Bn6nJ2OkH13BuSeYdaedQQx7IIF2+Cm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499551; c=relaxed/simple;
	bh=CtqW3q5biGefz7yaUtcdMR8iS0RTtEpLeLIczVBR3Mo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYqiOKYFcFcu6bmiUX6o+mEWO6ZR2bQFqXsull4qP0JvONouq7nYOglwoXhtusZ9+snIQGXsXWIEPICVc22RVij4DimV4l/prkY2U1MSFe1lH98O4KeEwepbNcWkIEcPK1ey9lz9iNiavxjqrr3jOGfZJoxQJRYV6wpxcqYCICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eGZ99MzZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45REjdLQ130477;
	Thu, 27 Jun 2024 09:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719499539;
	bh=sQAMxxrxIA84+xnythMxxyEkzToYYrkOJbvTqGj5a8Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=eGZ99MzZnpnHJxBJenpGYnbUGOkekXBV2uPlGiGUyLr0GZDvCN04mCGaAhgmAlblJ
	 tIFBgVjxh18gn+U+pNrrGcN23tFWp7573wwGBlECZO1rCZy5ah1Ho80YaGsRvUSORN
	 ViINhOvXK6BA2g3buWzU4uXfSYCFJj3OIqksKy3A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45REjdKN022651
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 09:45:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 09:45:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 09:45:39 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45REjc7d066715;
	Thu, 27 Jun 2024 09:45:38 -0500
Date: Thu, 27 Jun 2024 09:45:38 -0500
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
Message-ID: <20240627144538.mp7n2l7kupi7gt4l@straddle>
References: <20240625153319.795665-1-danishanwar@ti.com>
 <20240625153319.795665-3-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240625153319.795665-3-danishanwar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:03-20240625, MD Danish Anwar wrote:
> Add documentation for pa-stats node which is syscon regmap for
> PA_STATS registers. This will be used to dump statistics maintained by
> ICSSG firmware.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> index c402cb2928e8..3cb1471cc6b6 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> @@ -278,6 +278,26 @@ patternProperties:
>  
>      additionalProperties: false
>  
> +  ^pa-stats@[a-f0-9]+$:
> +    description: |
> +      PA-STATS sub-module represented as a SysCon. PA_STATS is a set of
> +      registers where different statistics related to ICSSG, are dumped by
> +      ICSSG firmware. This syscon sub-module will help the device to
> +      access/read/write those statistics.
> +
> +    type: object
> +
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,pruss-pa-st
> +          - const: syscon
> +
> +      reg:
> +        maxItems: 1
> +

Is this a patch in a driver series? I do not see the driver part..
if this is a memory map, why doesn't bus model work?


>    interrupt-controller@[a-f0-9]+$:
>      description: |
>        PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

