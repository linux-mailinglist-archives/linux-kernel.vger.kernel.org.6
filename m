Return-Path: <linux-kernel+bounces-174790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186868C1505
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74A528219D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B77E59A;
	Thu,  9 May 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErY7zMum"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8E1DFC5;
	Thu,  9 May 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280490; cv=none; b=fyNaP5BtQd2dCwXzSSzaP5nqGMiKUV/LL8XvG9C5+6iRy/Tk2nW8w65nHnKr4nMVI0VPR5XUeKD/BHE0i9yhvpbKeiI324jHA0xvxEBkqXxAw857fSngXbxuuvg9cMs/ikAs6DvLkNkePqtovPcQCfW+rgW5basPlbuxJVOUSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280490; c=relaxed/simple;
	bh=tqQE8DbEcNTGyVwC9ZlW1KXdlFxeZtTQjFzsbunffK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob5LePanO0Pi+ZD7Hm8+b3tdnCqjm8BaOcJxWTvshwHxTgaz1GFR04+qjv7qd7/ydxTtjHDG29f8hva7aE/SmJFttbF/M+Hfo35fVqJh2WaZckZ410bRN0Lnr94MUahN2xmtBxtaNvRxP58DOifrF5ChU/loC4LLglcafAuLrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErY7zMum; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34da35cd01cso1025795f8f.2;
        Thu, 09 May 2024 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715280487; x=1715885287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYTxoAU9R8PdCA3DTF+Msdy/qnJrq3ZddQpwOU9eM8s=;
        b=ErY7zMumbS+8UTZSZ1B4ljxiOXJhg3jpMahuJiRmMrF7AyDV5h2zDcD9CJe9YDb4ub
         e6rE+99sc2ZJ1LVn0sGQdFKutVgNQliko06IDzKAJHyh66Y430J/9T3a7gKhwBKEZ9B2
         ZTGwqPBtxbroP41USy9VYtPvI3lWP1z43+yb7vTTOYUOvW2OMFl01f/LDE+pl1kgc6bB
         mVzKQ8Dy9UdzeeqFlWvYE2MfAdlCCVueFE5QPH2y+6nSnnhVb5PhKRA1pBiqKYXde3EA
         fdK0kw4O1c8cweLMNWhsWASs5YyFk5OL+5LYFKXhChbji9PQxVv1iZ42jlxX6M3E0cW3
         BzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280487; x=1715885287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYTxoAU9R8PdCA3DTF+Msdy/qnJrq3ZddQpwOU9eM8s=;
        b=C4Vn/5PNh/mXVDdC0rnQ81kyKQMBPIvExITTsx3x4bPr1HitwcQT3PWOIAKcX0DI9i
         qau3DEcMIzQbOASD1hSvXmJpRgY7QVlSK/feXSWx5dcbXfTc8wEX5x3qMV6qYXBnV5Uy
         ytxm3x3Yn20FBgRSmF7TecDKfz2JUbSXqaXIJxamvpCi/90VdDasDNvUXgDZZYkAfuq+
         fhL/GEJ6Fn0pjXeAQRJclXrgkyr+lS0CDHcIBYwvokBB8zrKeKSWdtKDXlejGEbyjIUl
         yxOI1IfgNr6ytdtXXrNw7NhlRlWQUZgO0KEqWimon+4dgy0iVqHzL8Jt9JmcWeJlpv0Z
         QsVg==
X-Forwarded-Encrypted: i=1; AJvYcCWuxefx6DYkZXxQeM+4dazfDl0AGx1Dt6L0b1BOiUD7frbhbE+KXuGCW7DJ9447d4cBFSoV3cwEVLlb78FTi10ScQjGj5GC9JaLNTKEqrNRXLPX9RglRTlW/4cBSAa66WbaiRh2iqXmDA==
X-Gm-Message-State: AOJu0YyMuZG902mRiAORrQIvlLnKuzvWPjbFwMyCzg+q0ertj+GyLV+S
	Llo4Kl6zV+9dDEvcg0GuCjhxaao3+5hJ05Hvc3bzUiIEv1foTZ3XUFGtrR3I
X-Google-Smtp-Source: AGHT+IEZrPYMQWA87qEgbWGVE9lGIcF3sO7Q+rX+visOsuQ4eN6ZgNF/ss1X+uJz5qD/wFXiBH5o2w==
X-Received: by 2002:a05:6000:a88:b0:34c:e62a:db70 with SMTP id ffacd0b85a97d-3504aa63447mr418641f8f.67.1715280486648;
        Thu, 09 May 2024 11:48:06 -0700 (PDT)
Received: from ?IPV6:2a02:2f00:503:7c00:1884:a725:4a68:962c? ([2a02:2f00:503:7c00:1884:a725:4a68:962c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacf47sm2374485f8f.78.2024.05.09.11.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:48:06 -0700 (PDT)
Message-ID: <799c3c81-fc33-4f76-bd0b-287e8b8a6f5a@gmail.com>
Date: Thu, 9 May 2024 21:48:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: mfd: add schema for 8ulp AVD-SIM
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Liu Ying <victor.liu@nxp.com>,
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
 <20240418203720.8492-3-laurentiumihalcea111@gmail.com>
 <20240422142906.GB1207218-robh@kernel.org>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20240422142906.GB1207218-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/2024 5:29 PM, Rob Herring wrote:
> On Thu, Apr 18, 2024 at 11:37:19PM +0300, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add schema for i.MX8ULP's AVD-SIM module.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  .../bindings/mfd/fsl,imx8ulp-avd-sim.yaml     | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
>> new file mode 100644
>> index 000000000000..4020c6e37f80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/fsl,imx8ulp-avd-sim.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/fsl,imx8ulp-avd-sim.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP i.MX8ULP Audio-Video Domain System Integration Module
>> +
>> +maintainers:
>> +  - Liu Ying <victor.liu@nxp.com>
>> +
>> +description: |
>> +  The AVD-SIM module provides configuration options for components of AVD.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: fsl,imx8ulp-avd-sim
>> +      - const: syscon
>> +      - const: simple-mfd
> 'simple-mfd' means you have child nodes, but you have none defined.

Thanks for the clarification! These were intentionally omitted since they're
not needed for the DSP.

>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
> If you do add child nodes, 'simple-mfd' also means there is not any 
> dependency on the parent node such as needing this clock to be enabled 
> for the child nodes.
>
> Rob

The plan was to add the children later on as required.
Given the children would in fact depend on the parent's clock being
enabled, I wonder if just removing 'simple-mfd' from the compatible
list would do the trick?


