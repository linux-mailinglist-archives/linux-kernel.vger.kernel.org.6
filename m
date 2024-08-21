Return-Path: <linux-kernel+bounces-295301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4249C959978
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE21EB22251
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651319ABDB;
	Wed, 21 Aug 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JBep5QgK"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932020ABE8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234415; cv=none; b=auu2zsl9VuCnrjdvgAQQYJbjUBu4yzKQDEmLVIXW9KazlGrkE2TJcAivOjVfC+6Tm8WFhUaed6myrFWgPkKK+lrUMaH6L8emVdz2w8mfnUUipDG9XlAnzn5etSwQmblMcj18DEKEs9KD6Ggd0Zo5xFYbNvYQokM18aWmtMYiQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234415; c=relaxed/simple;
	bh=Ut4a4LJ6L9Qw6OqIXDADphCaoAOviJrYMlmLoagYFFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eujPqWM8Pk3IcAxo6D5H06+LS7Am914D1Qek/szHDbLB0xc2HBiWQ0NDdiJMs07M2CWTmVz8oX21j7vWfDfLszRZt7ptquiSpkpQX85QbQq1RAEJmoiqlGs7FET6981/aoPJULNKBbDpmfy1WCgLIwPn+O47SD62ZJikmaPATss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JBep5QgK; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709485aca4bso3305521a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724234413; x=1724839213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2vX0cAcL6u6kB8S2gDC6BZ0GpOYUqLhhMzp6ZJx/1c=;
        b=JBep5QgKW8UlEDkZj0mSBr30GHHb0qO0cUGj4DXL+SEE1rbbfZs8t+0mZHymKfcGTQ
         OSAlYfqrKpwgcdUWFtvZvJUa41nZ3SR1cvmKGfBjRuzH/viOR7B7rLT15mfdS02RIuJm
         anmivwOad3awtCyy4rXcMrSI/znvfxuLwCQtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234413; x=1724839213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2vX0cAcL6u6kB8S2gDC6BZ0GpOYUqLhhMzp6ZJx/1c=;
        b=f/JoN9KNjEvGnPRqJt6txtIxSO3o3fcsXiLV3QGi+8K3chrgZHjRRzhMxMczXUAmLa
         Bei8gt+o9pE254DfdnkwVkg0xFbOXfpkVjC5yEcN+M1Uz/K+ywOndJn2lceDWuSbqbpO
         +OU13f353YE+zJ9kVmEPRl2mA6s8Jxd9JleDoWrYVqpxsoPZ6iYdvb4pcAl7vleGiGlo
         yHnuglyjctKuuz6mjXk6MZR+lM8cUU0rbKWNqaItwbbKufobmGTUCIlPZt49bQ5MdGSK
         J3zKSVMbzzsN/gbe9pdWowAtHJRiEIvdk7QtprUr5VQaHM+DkxTh5JxIwNoUbACiSW8+
         P9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXhNEknWrG5g16hr3GFCFkK18/4IXPBPPC+0Tq3nnK0imA2t9o6Z8agi754YyumxPklTcBL5teRvYiEkNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcuaFMSk/7yBpuPP+FvCJdlQ7mziQrJDlvNzyAPUMg0mq49qt
	MExghUrBjv8Pa9b2B0+tDWcjfu8VSAoYN/CPJz7YEdmeKvenHTsDzZpkC1006A==
X-Google-Smtp-Source: AGHT+IEX3F+CPJJNzHCWZtEffTW2KurhONpiKwuAK9S/tJd6nVZvVtWPiQDzzrQnSsCU/tnc7BEIEQ==
X-Received: by 2002:a05:6870:910e:b0:270:14cc:656c with SMTP id 586e51a60fabf-2737eed86aemr2031331fac.6.1724234413128;
        Wed, 21 Aug 2024 03:00:13 -0700 (PDT)
Received: from [192.168.0.106] ([103.163.98.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm9617199b3a.65.2024.08.21.03.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 03:00:12 -0700 (PDT)
Message-ID: <abc3330a-58a2-4527-a101-81e2e6168abd@chromium.org>
Date: Wed, 21 Aug 2024 15:30:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: mediatek: dpi: Add power
 domains
To: Krzysztof Kozlowski <krzk@kernel.org>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240821092659.1226250-1-rohiagar@chromium.org>
 <20240821092659.1226250-2-rohiagar@chromium.org>
 <415a27c7-dfdf-4cc5-9aaa-1681dd32ddcb@kernel.org>
Content-Language: en-US
From: Rohit Agarwal <rohiagar@chromium.org>
In-Reply-To: <415a27c7-dfdf-4cc5-9aaa-1681dd32ddcb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 21/08/24 2:59 PM, Krzysztof Kozlowski wrote:
> On 21/08/2024 11:26, Rohit Agarwal wrote:
>> Add power domain binding to the mediatek DPI controller
>> for MT8186.
>> Also, add power domain binding for other SoCs like
>> MT6795 and MT8173 that already had power domain property.
>>
>> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
>> ---
>>   .../display/mediatek/mediatek,dpi.yaml        | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index 5ca7679d5427..864b781fdcea 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -62,6 +62,8 @@ properties:
>>         - const: default
>>         - const: sleep
>>   
>> +  power-domains: true
> Missing maxItems. I don't get why did you change this...
>
>> +
>>     port:
>>       $ref: /schemas/graph.yaml#/properties/port
>>       description:
>> @@ -76,6 +78,23 @@ required:
>>     - clock-names
>>     - port
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - mediatek,mt6795-dpi
>> +              - mediatek,mt8173-dpi
>> +              - mediatek,mt8186-dpi
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          maxItems: 1
> This part can be dropped. Just disallow it for other devices.
I was a bit confused here.

Can we add something like this?
if:
   not:
        (mt6795, mt8173, mt8186)
then:
     properties:
         power-domains: false

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>

