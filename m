Return-Path: <linux-kernel+bounces-186309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5748CC290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CB71C22C75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F9145B3E;
	Wed, 22 May 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1kGclyo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FD142621;
	Wed, 22 May 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386130; cv=none; b=hto83nu22Ut/I4LImq9vndOEu7pDpExhB9g+F9UWLMxw6dAoMYSiTOzw9rL2GLT23ijQp1ebZPt1Q7zMP4cST7XSKk13LohjH64h6TzyQ9U5rqf+WqUVczPceP/y5+AtocFSQqm2uMxjSzPtjdsf7dSBOmpz89w0+a3ZPsxUTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386130; c=relaxed/simple;
	bh=yWtD7LU9AB3Gr4Ry22fCWQp4b/WwuVx7H2lTfntgmkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjNGNNjKYtWp73MmVramXWlVIEAbaXALIfPW6WUy8YangQA/kADvPrfNoOyXtiZ+jL2Cy+lcy3YVdMmaxkn9QJcQg2Tb44o58dDaphWF8VL84ANA0lkB9u1qa/7dJdZML1eJxLYxsXu9xP2dN8QOKCawOZXPzsSk5H2cy6pGieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1kGclyo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso6722028e87.0;
        Wed, 22 May 2024 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716386126; x=1716990926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YaBKPvnOJzmUbDriM6HGEGAHRgnlTqVjaXWE1TlkEM=;
        b=L1kGclyob/dqB3opxGY/z1vIqZW8HfW6IdSeFzoFoCrhhUjrB5+qUNj4VkDkB3HVd7
         b6cp39DSg1K61CXm+AAzMVKHAZmYJfeL9DY/9AEt2Y54N7SssJ7XreKOzmwYTyyaFk4e
         vKLMRs/WSKsDyDj09FnbBmvPKXNHYoFePp0QJEIjpGUMsjj6S7TxsIY7u+GeC8Ej51C5
         YGLmHlHRCrcEeOHJTD0ABkkppNRQAWr4OFtMoK+9dLC55jksNGbECFnG4nNId+0OAmIU
         I5djIVu/kGBlNj1pmPbODvN0gdvs8TUJ+j2xwFDe4SNacn5h9UKmdfUpwr4HdijzedKO
         Kk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386126; x=1716990926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YaBKPvnOJzmUbDriM6HGEGAHRgnlTqVjaXWE1TlkEM=;
        b=KiVbd4NKji/Z6qEXqLXdfl+zg1Y58I385MhWtGvRCxqGr3Rd7vhylpxCe/9KCz7MFs
         w31Lx8ErIUQilfA0d7KMq6Yf07nGnX23jQ9XlESD3vFryN4cduYhJiICYCfewnsrOoQA
         GMHJXuIjM/JTuKHwRH+/IdX+rvEWTc837dxvrx5F5nyhGsXbAP/L+yqkkNbRlFo8v981
         +2AgLamIWFFeED6tAcPhwbW1EoYR78tDdq3ozNZzXTfiSY9Fe+n/sQO+mbkgCKZPxyQO
         DPBKqigZvcVhdaP2jDLqKgBIGLugiYELR5M79WhsB3c+lQe+8HqwnPHi7i3o12qTIszc
         /XLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9NfRKcezEAeO/wVWowGBB7bnzybdQHUFe5PJuYnesGJVWAdo1piIqgxCdjBs5DuSy6cWI7XCVEf/iOn/ze7IHm2X45p8o0by2PShzwwreTaK+6cUqtABgBFwJo2/4IEWkOjFdYRYX+iLU//7TWCF4NstKzOhpeypT8j9uK1sU3GdcO9jY
X-Gm-Message-State: AOJu0Yy5ntEMddQ2P12YF1WWD/Eb7xDvnB+DvP6xdPqJxCb30vYUfpxE
	t4ZULPmuMj5qjKdWANy+c3JdoXqEmS3Pi/sf7YEazumbA2F9RHf+
X-Google-Smtp-Source: AGHT+IFYqdG84I5n5HcpYSBsCPuvwJ923qQSxWRG46QsFjunGCiBYTTXJVQLt9pT91rp3cKva6gh8Q==
X-Received: by 2002:a05:6512:3f19:b0:518:c057:6ab1 with SMTP id 2adb3069b0e04-526c130bba8mr1350705e87.66.1716386126290;
        Wed, 22 May 2024 06:55:26 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2f1dsm4967366e87.264.2024.05.22.06.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:55:25 -0700 (PDT)
Message-ID: <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
Date: Wed, 22 May 2024 16:56:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Mighty <bavishimithil@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240522075245.388-1-bavishimithil@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 22/05/2024 10:52, Mighty wrote:
> From: Mithil Bavishi <bavishimithil@gmail.com>
> 
> Convert the OMAP4+ McPDM bindings to DT schema.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
> Changelog v5:
> - Add imports for constants
> - Add desc to ti,hwmods
> 
>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ---------
>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> deleted file mode 100644
> index ff98a0cb5..000000000
> --- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* Texas Instruments OMAP4+ McPDM
> -
> -Required properties:
> -- compatible: "ti,omap4-mcpdm"
> -- reg: Register location and size as an array:
> -       <MPU access base address, size>,
> -       <L3 interconnect address, size>;
> -- interrupts: Interrupt number for McPDM
> -- ti,hwmods: Name of the hwmod associated to the McPDM
> -- clocks:  phandle for the pdmclk provider, likely <&twl6040>
> -- clock-names: Must be "pdmclk"
> -
> -Example:
> -
> -mcpdm: mcpdm@40132000 {
> -	compatible = "ti,omap4-mcpdm";
> -	reg = <0x40132000 0x7f>, /* MPU private access */
> -	      <0x49032000 0x7f>; /* L3 Interconnect */
> -	interrupts = <0 112 0x4>;
> -	interrupt-parent = <&gic>;
> -	ti,hwmods = "mcpdm";
> -};
> -
> -In board DTS file the pdmclk needs to be added:
> -
> -&mcpdm {
> -	clocks = <&twl6040>;
> -	clock-names = "pdmclk";
> -	status = "okay";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> new file mode 100644
> index 000000000..966406078
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP McPDM
> +
> +maintainers:
> +  - Misael Lopez Cruz <misael.lopez@ti.com>
> +
> +description:
> +  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
> +
> +properties:
> +  compatible:
> +    const: ti,omap4-mcpdm
> +
> +  reg:
> +    items:
> +      - description: MPU access base address
> +      - description: L3 interconnect address
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [mcpdm]
> +    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pdmclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,hwmods
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pdm@40132000 {

The original label and name is preferred to be used.

> +      compatible = "ti,omap4-mcpdm";
> +      reg = <0x40132000 0x7f>, /* MPU private access */
> +            <0x49032000 0x7f>; /* L3 Interconnect */
> +      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-parent = <&gic>;
> +      ti,hwmods = "mcpdm";
> +      clocks = <&twl6040>;
> +      clock-names = "pdmclk";

The clocks cannot be added at the time when the node is defined, it is
board specific. This way you imply that it is OK to have it in main dtsi
file. It is not.

> +    };

-- 
Péter

