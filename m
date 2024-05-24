Return-Path: <linux-kernel+bounces-188184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B168CDEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D96D28311D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE86FC3;
	Fri, 24 May 2024 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IMeW20Eq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4A36D;
	Fri, 24 May 2024 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511439; cv=none; b=kh9jbQRikINPampx8e+aZa0zIYUWKuvHJjIsBiu+D2KCvHNis5pVgrsdJW+jr6lW4VMxFkMVJ/KsPSuCun7gX8j3oh+MU+UunVdvk6cPh+R680ICE3Y6va3GUxS4/oVI8bfu9oN92U7Uc6ze78L8Qq9SrTjCO2Y/IQpXlRFPxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511439; c=relaxed/simple;
	bh=wMezvM8py8OBv6OqV71f6d++eMzHpNIb5ooJ3D4l04M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9RIZX6i+pH+gDFha9wwXaEBeJaWUcrGKUmO7NeJPVMEwzI+cp23orl7P32skm7Q+Iiyz5bJ7lMfueeE9vIpJVTkIiOnH2fNh2Ec76Kwc9IDSR8EmLeuSO7WrL8M1FZrBWk9AXBlVPgOvpSnepNpzDxj64u0Jp6olYCstXLtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IMeW20Eq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O0hlt3031521;
	Thu, 23 May 2024 19:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716511427;
	bh=f9Rks1hSMkKic3ENAndAYZu6kxKlZUtbmXsvFhAsljE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IMeW20EqN/K57dTKjbNbPz7KGYFBAa0FeZ/M6YYqlxnKbLQtsPUCFmnIpPYSFtn4K
	 8972P/eNNqifKzueyRF2gSYx03kQ6IoCBMSWlupRdZqnDW3GQasmSBaeZcGrqlSX29
	 MZI6waBQcEXbRn0xD7XhsKkGVnAb5P/s8fU2ZjfA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O0hlEO036817
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 19:43:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 19:43:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 19:43:46 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O0hkoA018783;
	Thu, 23 May 2024 19:43:46 -0500
Date: Thu, 23 May 2024 19:43:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
Message-ID: <20240524004346.szrp7iiec2nhgvle@denatured>
References: <20240523080225.1288617-1-msp@baylibre.com>
 <20240523080225.1288617-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240523080225.1288617-2-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:02-20240523, Markus Schneider-Pargmann wrote:
> Add a property with an array of phandles to devices that have pins that
> are capable to wakeup the SoC from Partial-IO. In Partial-IO everything
> is powered off including the DDR. Only pins belonging to a couple of
> devices are active and wakeup the system on activity.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> index 7f06b1080244..c8ed0dd4fee4 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
> @@ -61,6 +61,12 @@ properties:
>    mboxes:
>      minItems: 2
>  
> +  ti,partial-io-wakeup-sources:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandles to devicetree nodes that can wakeup the SoC from the
> +      Partial IO poweroff mode.

I think the description needs a bunch of improvement here.

Can I use no board peripherals to be the phandle? say a GPIO expander
irq? This is not clear from the patch how peripherals and pins are
related?

We also need to warn readers that this capability is firmware driven and
not available on all SoC variants.

> +
>    ti,host-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

