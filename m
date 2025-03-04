Return-Path: <linux-kernel+bounces-543902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1249A4DB40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD3A16C4BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316E1FDE3A;
	Tue,  4 Mar 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jGigLBpi"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDE1FCCF7;
	Tue,  4 Mar 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085284; cv=none; b=YgrXZZGzwNYHx0z7JdOmSi1JdVU4OKxxyHX80x6/OE/jt6Gmq/8F1D6653DZu+8SRie+ll7m+7rZbzHJKEuf604eZSy2IYoI2AGfWjSUZjkAwuYmBgLtqMdH2ki+sGt+UEnuZqjsareH1x/kXBRE0HDg2Fa2Thho18mhtk0tOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085284; c=relaxed/simple;
	bh=vcHE78RP8631mAAX1Ns1wlDTk6LjjH9OTTfKNx2Yzjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rtfGvQ1UEqX+kQsngRZf/tIjbEYCU+5nj2C4T31qEHvYJz4XhH8mh1LUBJjZABEt4oavflD2ev6Qiu3+dDxVXRZbUwuHqFcx0nW5ul1+qb9Hri/Sg6SBBir/RV0uFOfSn8vzkCDhVU5kVhjPH8g/yvEnchmOJ74xC2q8tKJHJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jGigLBpi; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524Alss13572813
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 04:47:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741085274;
	bh=03U88wn9m25LsidUl5h8Lyie43sM2eRLpA4EVGWLTAI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jGigLBpiHjFHcLVpXentDdDGcO00cV2hEkiyu0JJxFqp39GCsoQoYWzxNAp3BXaZV
	 /ji2agfrUfNcC51XI6XHs3f5VAtv/g8XqrSJZpk/HvKBFjXDNyptvbpILLmGIeBI13
	 cvFMrBnvsxjoNJEojMn5MC9mupObA3vjQhCcUDV4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524AlsTK030411
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 04:47:54 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:47:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:47:53 -0600
Received: from [172.24.20.101] (lt5cd3168g9h.dhcp.ti.com [172.24.20.101])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524AlpVW026780;
	Tue, 4 Mar 2025 04:47:51 -0600
Message-ID: <c897fe01-9bcd-41ce-835b-38713a5e183d@ti.com>
Date: Tue, 4 Mar 2025 16:17:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20250304102306.2977836-1-c-vankar@ti.com>
 <20250304102306.2977836-2-c-vankar@ti.com>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250304102306.2977836-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello All,

On 3/4/2025 3:53 PM, Chintan Vankar wrote:
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
> 
> Link to v1:
> https://lore.kernel.org/r/20250227202206.2551305-2-c-vankar@ti.com/
> 
> Changes from v1 to v2:
> - Updated dt-bindings for the required conditions as suggested by Conor
>    Dooley and Andrew Davis.
> 
>   .../devicetree/bindings/mux/reg-mux.yaml      | 28 +++++++++++++++----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> index dc4be092fc2f..5255e4a06920 100644
> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> @@ -32,12 +32,30 @@ properties:
>           - description: pre-shifted bitfield mask
>       description: Each entry pair describes a single mux control.
>   
> -  idle-states: true
> +  idle-states:
> +    description: Each entry describes mux register state.
>   
> -required:
> -  - compatible
> -  - mux-reg-masks
> -  - '#mux-control-cells'

Accidentally, I have removed above "required:" section, will update it
when I post next version.

Regards,
Chintan.

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
> +  - not:
> +      required: [mux-reg-masks, mux-reg-masks-state]
> +
> +  - if:
> +      required:
> +        - mux-reg-masks-state
> +    then:
> +      properties:
> +        idle-states: false
>   
>   additionalProperties: false
>   

