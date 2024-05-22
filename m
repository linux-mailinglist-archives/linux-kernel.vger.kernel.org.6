Return-Path: <linux-kernel+bounces-186624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CAF8CC684
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CDC28276A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EA6146013;
	Wed, 22 May 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRA6S2SN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3A145FF0;
	Wed, 22 May 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403422; cv=none; b=LT3x+fIIlSKpnQuEbXu0hILCGbIxG/2aePMVwDkxy1pIaMqGH79rt/F1BD5IFry6GeHpoqWSldYp3zEkaKI6sby9Q3apdFBpVO1cs6kLs7Hp1L88UI+Ky+LiUTxg2pzNmMQakDNEfOqUoo7q9HCn4p7rt/1171RtAi4r5bPwqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403422; c=relaxed/simple;
	bh=D3Mc9dD9ZOhKmY7p/6kIkyWB2rwy+XPsptNUB2wu9gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLKFyk1whc/aTO0T8dpN4wQZEZwg3wSoJ/GRsgdH9T/IjaGdnM8pqNWZNF1YwsordUSl2Mv6SHQkTmti2uOgeQqpXagZU0bUO2MDgVEeb+Fum3gFQE3YRDe32FIYGrm0EMwv8Y1C8qWfQeIa3RIGlwuTsi3Ptz0CYcEJsmQiyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRA6S2SN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so14454321a12.2;
        Wed, 22 May 2024 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403419; x=1717008219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X92RNyaocOQ9jeaX09e1iKmMV7MiGKGnZ+Dic7jjso=;
        b=QRA6S2SNdNnn0lxLV4MzSnum0OepHJyRWsIRb+FHziDL/dgMY9uRV2l+sPR1xAXpm6
         WynVzNaGscq/e2vJkut/pOqlshaYqfkHDePUloCx88eyHP1KxDREcgrw+UGic1lR8dlk
         y85Eq6pf4s4SFocLQKdDQB+qoZ2vdjjkONuDWWs6WlsgWvWMKcR5j66ZKZvDjwJHJBTT
         h/qsipIsF0FYq7z47VJzzfKYG069FQXy6XLNhkD25jmq2zt3qimKybOmjvH0L8+3DHQc
         atxm5/t64JQ6z72SEPrK9+s+1q7hsvkpCnkCeKlwH+eNOerDQatdW180veNR16tRVf1z
         +Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403419; x=1717008219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X92RNyaocOQ9jeaX09e1iKmMV7MiGKGnZ+Dic7jjso=;
        b=Jm6AGMa5D/vH1b5VpUVNNpZKdm/QbZIbng9YVIH7GakdO1K9DSLue+0RzZIfbbHW2l
         z2Qq9XIsfQaUjBFqxt0HE9fkGwsUDoZraKeTALo2pyW0YlhMF6Rqgf90Tqfu3ukbr5Td
         3JcrIkRNLTFqmxW2lPOpgTWdvRAntDwad4yXF0jMwXBcEPy4xmtj56DVKAzGD6zzB90D
         4ntAxRcde+hk9YEukX6v77JZYl/Y24RU4YsoDVgBugL045yNUdYJjY6r9Hpis4Sa2CZY
         z1Nh6psz0J0ZYxecyF6KvGl3xmzum1qb7A2jo7Cn8KjY2Ox3cuS+qlKohFN0IFJj9ljt
         07zg==
X-Forwarded-Encrypted: i=1; AJvYcCVa7zPyeE0O5fa+NiGoiyW8/WR0aG3QYraeavPc219oP7C3KIELojzc8WRGDoQ4vEoXiOPdWkwNWklKrIWNHrwOtNwsnzDJ6FYC4p6wyGjOL4Tk/VP273fS871DWyhXVrxltU9gTet6pQ==
X-Gm-Message-State: AOJu0YxU7zw0rSZO13MpOJe4zx1jKNCxLwPxtjYd86wJtEi9J5+0Y6r7
	bSHfrZ93ESb2L270egFX1zPKBNTnAdY8FOGdJMnNPcyCugRqfK1V
X-Google-Smtp-Source: AGHT+IGN0pFDJpoxG2Grv/YFh/MhqqsO4GibeJdmlSjDyMjLmGY31Vxcn3drvjikcwZeQyVyTrLosA==
X-Received: by 2002:a50:ab0d:0:b0:572:664c:83f2 with SMTP id 4fb4d7f45d1cf-57832bee6c5mr2410990a12.27.1716403419377;
        Wed, 22 May 2024 11:43:39 -0700 (PDT)
Received: from ?IPV6:2a02:2f00:503:7c00:503d:ca7a:1fd6:cd63? ([2a02:2f00:503:7c00:503d:ca7a:1fd6:cd63])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57421480d99sm16875505a12.8.2024.05.22.11.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:43:38 -0700 (PDT)
Message-ID: <6b9b959e-9a03-420c-9f61-adaae05bc5eb@gmail.com>
Date: Wed, 22 May 2024 21:43:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: add schema for imx8ulp SIM reset
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Liu Ying <victor.liu@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 laurentiu.mihalcea@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-2-laurentiumihalcea111@gmail.com>
 <20240517195943.GA2854624-robh@kernel.org>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20240517195943.GA2854624-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/17/2024 10:59 PM, Rob Herring wrote:
> On Thu, May 16, 2024 at 11:40:28PM +0300, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add schema for imx8ulp's SIM reset controller.
>>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  .../bindings/reset/nxp,imx8ulp-sim-reset.yaml | 43 +++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
>> new file mode 100644
>> index 000000000000..ec9a5c73e83c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/nxp,imx8ulp-sim-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP i.MX8ULP System Integration Module Reset Controller
>> +
>> +maintainers:
>> +  - Liu Ying <victor.liu@nxp.com>
>> +
>> +description: |
>> +  Some instances of i.MX8ULP's SIM may offer control over the
>> +  reset of some components of a certain domain (e.g: AVD-SIM).
>> +  As far as the DT is concerned, this means that the reset
>> +  controller needs to be a child of the SIM node.
>> +
>> +properties:
>> +  compatible:
>> +    const: nxp,imx8ulp-avd-sim-reset
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/imx8ulp-clock.h>
>> +    syscon@2da50000 {
>> +      compatible = "nxp,imx8ulp-avd-sim", "syscon";
>> +      reg = <0x2da50000 0x38>;
>> +      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
>> +
>> +      reset-controller {
>> +        compatible = "nxp,imx8ulp-avd-sim-reset";
>> +        #reset-cells = <1>;
>> +      };
>> +    };
> Why do you need a child node here? No DT resources or anything for this 
> 'sub-block'. Just put "#reset-cells" in the parent node.
You're right, we don't need the child here. In fact, the reset controller will never
get probed anyways since "simple-mfd" was removed from the compatible
list of the parent. Will remove it and turn the parent into a syscon + reset controller
in V2.
>
> (Note that examples for MFDs like this go in the MFD binding rather than 
> having incomplete examples here.)
>
> Rob
Noted, thank you!

