Return-Path: <linux-kernel+bounces-335324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67897E41F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39EBB20D49
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261B7711B;
	Sun, 22 Sep 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuSSenUf"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F62CCC2;
	Sun, 22 Sep 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727046227; cv=none; b=TdYNi+RTI/sRoFT1HtdKPyqPHPwtdIKG+RxYit6b4cc5p3pM2DY+D7Mg+MyK1hoCKGTZozlA6h9mt+JHQoTwkP3hKJ3lBI137jerv/kZztgnBzRssnZKi8TFfCRLBIUO80v4pxzluC2uIiEhSghbdZfnOiOF9DPgPJBqJcURjDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727046227; c=relaxed/simple;
	bh=wwfVNmUoXYIZO2OGaY8HrUPJD64dGCIlWxNjBolaHW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV8z8+w8kMQlvzA+ky1/S6w5TPsXh9YHTBR5um+dPH7enRyghYgaxhimJUv+aG+HdSJ24D85dfVUz2nLsARLILh1Lx/DuZV/xlKpKUc5Mkp4Jp8aominciYARU40qWPbaG5Vw9+pmwkvnRtVU9fvbHXsAkPAvY2ynT6ECI/mKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuSSenUf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso48164575e9.1;
        Sun, 22 Sep 2024 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727046224; x=1727651024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMtXe+qwhue24/Vh2nNTzw9kAkSswIX5YjJHpwdrdMg=;
        b=KuSSenUfjYKtyuDKYwRVFh+BdphvEIzS8+1f3QpkqwDyi7U6xizEGdPsEnzh9Pf840
         fnChQXp3SKFFEWkJbeADn+4muQceIWYlbF4bXiHADbh/49Dpe8BPi3LXmdkGLXik2s8s
         rYoEdKqUiVqrUcIZm0WjxsDC5+GxvRF1/Gn2D//jVTe3OB3m1a7gYkxqmZOJRf7pmkan
         2RP5lI5n/ObWpKMDnMe1IsZu/6MMgS6yTKpdl9fqDynLa0D4dKC2K7N5exmzV2M6yJCG
         fRCXeF4QMbo/63Rv+2yZ3vs/gfwjxJb+r2fU+bhyw2dDKVEWrqeZ7bkyqQLKEBlOcIVn
         JWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727046224; x=1727651024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMtXe+qwhue24/Vh2nNTzw9kAkSswIX5YjJHpwdrdMg=;
        b=OVRaWcG2kP4AjUMiScQKy1FggbVjBCyOg6azJwBzeyyYj94LMTCoWwNRVz8YY6jy5f
         kbaCQ/YlC6/7SepTnTRSi7uvYcnHXuOWuZFT9WeLPVZvdfpr/gUllQVwbjkzUGZCz5od
         uiIPdmyxP7O+/QUjw2zwzCzVlr/kDmRE8s8h51VfMuSVer+Y5QkNvZbzienn0gbMpjQC
         tjYa7sUPWVsQ5G307kiMAHqTa4+EPM98M/pF4jrU7Qju/XaOgJoQO9QpCMzPNu09TCc8
         8QmaTOKDz8cieBh7vrzK8Hsfim5LHvTBg+KE5zsW6YB6nm+Q/x98VbUJ76EBSk7OM03c
         xkbg==
X-Forwarded-Encrypted: i=1; AJvYcCV/A2zUOjq1v5YqTcZcodIC2FiWiOCEFdz2IVpiba8Two2DeCYLgbybclBa4OrvC7PqBgT3kxkuHTAJxBIQ@vger.kernel.org, AJvYcCVYDnJxN+DDoIhsrbGAf2YfvL+HsJ6y2+MOGptCmc0mOfxYWRQOo9Tr4IvoGNUeS4ejMlluB595PjTO@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLHzWq/+viLXuUUEDJqqekzMPRz/39ii6BsYnyhL2P/gzsau5
	js0JcKHn9Vh5L83ZUPuIk8Yc7e4AYzTxu6BnRC3iK9AwOR+VYLEF
X-Google-Smtp-Source: AGHT+IHERED460bQf26PbmaFiMNdgb9tgvoFaNMY39SyzQWOQGcp5md0bmH5ap7eDnGkjMkPcyv6Zg==
X-Received: by 2002:a05:600c:190e:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42e7abe4184mr108137915e9.3.1727046223890;
        Sun, 22 Sep 2024 16:03:43 -0700 (PDT)
Received: from [192.168.1.130] ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e801d66f6sm61765435e9.29.2024.09.22.16.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 16:03:42 -0700 (PDT)
Message-ID: <48b93ab0-7285-4cdc-9bea-ac41a5dcdb2f@gmail.com>
Date: Mon, 23 Sep 2024 02:03:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: dsp: fix power domain count
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta
 <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
 <Zusguvhu+pld8UOi@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <Zusguvhu+pld8UOi@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/2024 9:49 PM, Frank Li wrote:
> On Wed, Sep 18, 2024 at 02:21:13PM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Per the current binding, QM/QXP DSPs are supposed
>> to have 4 power domains, while the rest just 1.
>> For QM/QXP, the 4 power domains are: DSP, DSP_RAM,
>> MU13A, MU13B.
>>
>> First off, drop MU13A from the count. This is attached
>> to the platform device of lsio_mu13. This decreases the
>> count to 3.
>>
>> Secondly, drop DSP and DSP_RAM from the count for QXP.
>> These are attached to the platform devices of the lpcgs
>> (used as clock providers for the DSP).
>>
>> With this in mind, the number of required power domains for
>> QXP is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).
>>
>> Additionally, two extra power domains may be required in the
>> case of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes
>> using the "-hifi4" compatibles these PDs are optional, while for
>> nodes using the "-dsp" compatibles these are mandatory.
>>
>> These changes reflect all of this information.
> Can you wrap message to 75 char?
Shall fix in V2.
>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
>>  1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
>> index 9af40da5688e..e2f016af1048 100644
>> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
>> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
>> @@ -51,8 +51,6 @@ properties:
>>      description:
>>        List of phandle and PM domain specifier as documented in
>>        Documentation/devicetree/bindings/power/power_domain.txt
>> -    minItems: 1
>> -    maxItems: 4
>>
>>    mboxes:
>>      description:
>> @@ -97,16 +95,55 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            enum:
>> -              - fsl,imx8qxp-dsp
>> -              - fsl,imx8qm-dsp
>> -              - fsl,imx8qxp-hifi4
>> -              - fsl,imx8qm-hifi4
>> +            const: fsl,imx8qxp-hifi4
>>      then:
>>        properties:
>>          power-domains:
>> -          minItems: 4
>> -    else:
>> +          maxItems: 3
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: fsl,imx8qxp-dsp
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 3
>> +          maxItems: 3
> I remember only need maxItems, if minItems == maxItems.
Might be off here but from my own testing and from looking at dtschema/fixups.py it would seem that's not really applicable to subschemas under "then"/"else" blocks.
>
> Frank
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: fsl,imx8qm-dsp
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 5
>> +          maxItems: 5
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: fsl,imx8qm-hifi4
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 3
>> +          maxItems: 5
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - fsl,imx8mp-dsp
>> +              - fsl,imx8mp-hifi4
>> +              - fsl,imx8ulp-dsp
>> +              - fsl,imx8ulp-hifi4
>> +    then:
>>        properties:
>>          power-domains:
>>            maxItems: 1
>> @@ -157,10 +194,9 @@ examples:
>>                   <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
>>                   <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
>>          clock-names = "ipg", "ocram", "core";
>> -        power-domains = <&pd IMX_SC_R_MU_13A>,
>> -                        <&pd IMX_SC_R_MU_13B>,
>> -                        <&pd IMX_SC_R_DSP>,
>> -                        <&pd IMX_SC_R_DSP_RAM>;
>> +        power-domains = <&pd IMX_SC_R_MU_13B>,
>> +                        <&pd IMX_SC_R_IRQSTR_DSP>,
>> +                        <&pd IMX_SC_R_MU_2A>;
>>          mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
>>          mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
>>          memory-region = <&dsp_reserved>;
>> --
>> 2.34.1
>>


