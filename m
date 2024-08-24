Return-Path: <linux-kernel+bounces-300142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9895DF4F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECCC1F21C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD855897;
	Sat, 24 Aug 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ohikOQgc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B13D967;
	Sat, 24 Aug 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522318; cv=none; b=aUJmwEdowzAjE7nwxnVQtvU+t+K6pSn5Oytf6p9bO5x2GWQzGG5jnkJ9EJ8cAUcXk7RkhKuco7W9Bw1GWAFjmIDkso5cRkge84HO7Alyu9JF1LQ4q3HV5y9tVI72lRwe07NoBCBaXMsSCtY7cng6emZu8tHgj9bWrBdjgaPQ84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522318; c=relaxed/simple;
	bh=gyAB2OnqZQk8uIF9hjIvzHTJlMaHiLGsGtYGAbzP9DE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfgpVcwX/+XEtV53jAG9w+aPSzRSqxpo3YW8JbQBxLuOR3Nt63LNlB24Iv7w7w69s4D+nrIlPQN3gfXAAxDYw2BBqGQb4oifnSnAfCOS9Gn1gkYi2NVNUgclSfWQhm8UtXQpaCR+yNSQz27UbZsv3uy/G2S+vVSeKTBIJF0hZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ohikOQgc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OHwQFG071000;
	Sat, 24 Aug 2024 12:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724522306;
	bh=on/ZzRw/xn/2GSN5coKpbAHLHOWoJoO+eh8Q2GeR7PI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ohikOQgcKV4RU/q1pfW6srQ6kxl4AIXk/VNVXCOMyydc3ZPkvUOW4fBeyEjCjpuBH
	 nFdsu9ayr4qFdNdy+J7DphxHtRAlui3WuU1TkXlm0UFOr1m69KJ572k2LYBm2R/eEG
	 84cgWanQO2WDLgEDOBz1sUVQSG2dYn0X41jHrkHk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OHwQSe048173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 12:58:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 12:58:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 12:58:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OHwP1b041790;
	Sat, 24 Aug 2024 12:58:25 -0500
Date: Sat, 24 Aug 2024 12:58:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240824175825.bedufmhfkx4btv5n@anything>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:37-20240814, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Expand bindings to cover both the MCU and the main usage of the AM654
> system controller.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> index e79803e586ca..cb9da3ec39a8 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml

As per linux-next, this file does not exist? looks like you might need
to rebase on latest next?

> @@ -29,11 +29,30 @@ properties:
>  
>    ranges: true
>  
> +  dss-oldi-io-ctrl@41e0:
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,am654-dss-oldi-io-ctrl
> +          - const: syscon
> +
> +  clock-controller@4140:
> +    type: object
> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +    description:
> +      Clock provider for TI EHRPWM nodes.
> +
>  patternProperties:
>    "^phy@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
>  
> +  "^clock@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

