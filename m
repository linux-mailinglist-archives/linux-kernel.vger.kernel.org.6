Return-Path: <linux-kernel+bounces-537319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227AAA48A75
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D9B3B6435
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69D26F460;
	Thu, 27 Feb 2025 21:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hJDpGEUN"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD5271261;
	Thu, 27 Feb 2025 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691619; cv=none; b=LqAVCzTfyVOcuX7T3jMfRZ+Ojd9G5lHXC4oRmzq8jmz6Hz9dA5lvhj9MJZjz8pziPQ3hCTeTLwY+ITsHi2AEpmuye5znPhZEb/JypjBhjcjhRZQgDtGmYpvf1Ela7TpFK5DG/6rZnPXEh8XbPU9XQ8EKCyqCNF7QcdOBHDlZhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691619; c=relaxed/simple;
	bh=SSGtiAcfTZwQOgLB4uP0lR/hufwOZD07tQNztO2uvDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ti4W91LeVUisjXuXHB51XYWZsCJUv/aE2bMAj1os/BA6GjlOc7ZJcDfv8xcdDhLbuGmXidd5oqJXJ79eAcFELExbxCZyyE4dhSbnyI/pTNndaSqPxcs+CRIYDYctgO+zFXSyqDMFakJtgR0aeOHi5ESwZ2sOU6Q+5RFvotmR3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hJDpGEUN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RLQWpl2467946
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 15:26:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740691592;
	bh=0r8/l5Fgxp0PXZ6/Mu485HSHaQHgeKJXEbg15BrArFI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hJDpGEUNg4W+3NQWWB/K6yz/EZCWgnI+ZHNdL0sKUnNnGRYa965r2mqnQadaaF78j
	 mCbFRWhXBtdpGlXjLYJqlQNphlGjBJSlUVHPxX/ZCXFnzZEjTAP/+AufezwnYii9+3
	 mtHVwWyPEUYQDw/npBw2t1duyRPc+1V/877kvay8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51RLQWSc000906
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 15:26:32 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 15:26:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 15:26:32 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RLQVoi003731;
	Thu, 27 Feb 2025 15:26:31 -0600
Message-ID: <f3e69904-92f0-4de8-bfef-a315a6554a1c@ti.com>
Date: Thu, 27 Feb 2025 15:26:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin <peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250227202206.2551305-1-c-vankar@ti.com>
 <20250227202206.2551305-2-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250227202206.2551305-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 2/27/25 2:22 PM, Chintan Vankar wrote:
> DT-binding of reg-mux is defined in such a way that one need to provide
> register offset and mask in a "mux-reg-masks" property and corresponding
> register value in "idle-states" property. This constraint forces to define
> these values in such a way that "mux-reg-masks" and "idle-states" must be
> in sync with each other. This implementation would be more complex if
> specific register or set of registers need to be configured which has
> large memory space. Introduce a new property "mux-reg-masks-state" which
> allow to specify offset, mask and value as a tuple in a single property.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   .../devicetree/bindings/mux/reg-mux.yaml      | 29 +++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> index dc4be092fc2f..a73c5efcf860 100644
> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> @@ -32,11 +32,36 @@ properties:
>           - description: pre-shifted bitfield mask
>       description: Each entry pair describes a single mux control.
>   
> -  idle-states: true
> +  idle-states:
> +    description: Each entry describes mux register state.
> +
> +  mux-reg-masks-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: register offset
> +        - description: pre-shifted bitfield mask
> +        - description: register value to be set
> +    description: This property is an extension of mux-reg-masks which
> +                 allows specifying register offset, mask and register
> +                 value to be set in a single property.
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - reg-mux
> +              - mmio-mux

These are the only two possible compatibles, is this "if" check needed?

> +    then:
> +      properties:
> +        mux-reg-masks: true
> +        mux-reg-masks-state: true

You need one, but cannot have both, right? There should be some
way to describe that.

Also an example added below would be good.

Andrew

> +      maxItems: 1
>   
>   required:
>     - compatible
> -  - mux-reg-masks
>     - '#mux-control-cells'
>   
>   additionalProperties: false

