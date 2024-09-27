Return-Path: <linux-kernel+bounces-341644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C999882F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787731F2232D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3218A95F;
	Fri, 27 Sep 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkFeqHgO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93018951F;
	Fri, 27 Sep 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727434763; cv=none; b=irgfswQt6PHt8s9b6NYPNC8GywLLYd45CSxYiJ7VzAiqdjJmWksK6m+0wdq462cDWiytKrzlasXxcukvlb0aeLlpYDtFa9LWI1Y0P88lBgHTXlQNu4Y0HxXYWaLCZBQTs/guoSqJ5YLwMLNrnh5B2VibkuZ27UHmI7pAmymwYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727434763; c=relaxed/simple;
	bh=n1kiuobhp7nO7fCIfJA7iEh5eDophUx5d0KHYqiFbEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdtQE4JlG0/eR4Mo4KMKkytaYBBLedRvHP8ZqCISTpVzH2jxDkh0QLBCQVlw3IyJIATKvEP0mt9W8yWcuUmHpKjJgLg4zsQw1se8TlJNB0FAP8cS/r/IJFYt6dSjVbgErl9pcUAzOm+p0Ud6f8yUOyA+QolinHfNKxo74BgegH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkFeqHgO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b2ee7629fso1407705ad.3;
        Fri, 27 Sep 2024 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727434761; x=1728039561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DObtMepEvbntbYxpIRGYmA2PApftPcBR1DNFAq+0tiU=;
        b=EkFeqHgOHCgJaF9fzxBId9deBoyFaOQ3XB4C0AHQC6ir+GNgvxCp6J8z8Xc7YrHI5u
         OfALhQ3fID6oLhAeo5Smbr4isZDiZzbxVi1NZTp8L+fK09ty6ZlfUN7A8S971sot7Wj7
         bDbLwm6fY2zwx64eaqPJokAj27XtApyphJ7L8Q9snEJJDiX2qLVJbn3Pl9Ww+H6tjIub
         ExGYCfFFoVCIDfkkDZrZ0V43xenx22ELMv4ghsNfAamNxDeX5wURTZPFk3/pUPu43M/m
         gwkZ51tjwb77jmWFl+9dL+JgIzKf36k3zo74GhdidvCHvX8zFGIzaA2BSMvUg5V5jcwt
         iyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727434761; x=1728039561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DObtMepEvbntbYxpIRGYmA2PApftPcBR1DNFAq+0tiU=;
        b=dmnZie7P+n9lHOXzoZdhVBGOOjQNZumsh9XUFlMhXNlMjKjvuLqKLbZHLXV56CrExl
         cv9PnUCQY+5X6AFARHUU5RLMXKVdx3Zq9oNPtk1J6mE2EYdrDjxZdbMx/QiSfzVEMxQK
         30XtI7Ei6J+AY9kSBvrImNuUvFVCxLcbjzojEHwtCNAqKqXBg+HCFF72UbC72pifITIw
         LLGxS8iUlWI+/x9aj5UshoBoGKbHB/vwoSbT1tIYeOQmUQ3UkEnn5O73aYH0n2R5m2it
         eI4H79HN++5vZszyijtZIqCO0wdf6GEODYsILbAm6V/l6GocF6lGEDIPnsy59Wy5pxXM
         qm+w==
X-Forwarded-Encrypted: i=1; AJvYcCVJrQHV4NV2rWL5JfYyza/qF8QNusAdh70QAxwKk+rLz/YWy+Rns+mPq4i35KVf3UkZk3dF2SLT9dSlwjsD@vger.kernel.org, AJvYcCXu5pHGsIUJmqdnEflrmA34CSwkQm79TXKoPAwNWzPayTAx72Ts024T/8lUxd7yiZrICvdMvVFWnmZk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxng87ZbDi3Txh1d0gUt9RH0II4Nc8t79F3nz2CHS6vvl7+/tTt
	WstGLscnvrfbn8h6UN2Nmp97h6mjsXXsUFgmEXiaUyF0UyoeL2LXAnJhT1zE
X-Google-Smtp-Source: AGHT+IHYLP9kUGQWnN2G8U5PQVJytgo7cazkgDwW/mKcpQ1mFG2jLNZxG0CwjnvcSkfgmE0hIzd/hQ==
X-Received: by 2002:a17:903:191:b0:20b:9aa:efca with SMTP id d9443c01a7336-20b36adbadamr18954335ad.9.1727434761087;
        Fri, 27 Sep 2024 03:59:21 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d60eb3sm11688325ad.44.2024.09.27.03.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 03:59:20 -0700 (PDT)
Message-ID: <f5e547ac-cb5b-492d-8cfd-d77d3e9bbf9d@gmail.com>
Date: Fri, 27 Sep 2024 18:59:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240926103223.29538-1-frawang.cn@gmail.com>
 <ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org>
 <7944f4dd-96f0-40df-8c91-523409e3cb20@gmail.com>
 <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
 <a06af01a-656b-4ef6-84a6-bc1c35d5bafa@gmail.com>
 <2815219e-3a20-4a5b-8573-d8a4ad2df1c9@kernel.org>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <2815219e-3a20-4a5b-8573-d8a4ad2df1c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 2024/9/27 17:52, Krzysztof Kozlowski wrote:
> On 27/09/2024 09:59, Frank Wang wrote:
>>>> -  clocks:
>>>> -    maxItems: 1
>>>> +  clocks: true
>>>>
>>>> -  clock-names:
>>>> -    const: phyclk
>>>> +  clock-names: true
>>> For the third time, read the code I gave you. Do you see something like
>>> this there? Why doing all the time something different than existing code?
>> Refer to the link you sent me that I must add minItems property for
>> clocks, just like the below codes:
>>
>> @@ -35,7 +35,8 @@ properties:
>>        const: 0
>>
>>      clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
> Yes, for all variable properties, so also names.
>
>> That can pass dt_binding and dtb checking, however, "clocks" is the
>> optional property for some old Rockchip PHYs,  I am not sure is it right
>> to force set  minItems as 1 .
>> If just keep maxItems, the dt_binding checking is failure.
> Please specify the question you want to ask.
>

Please ignore my last garbled email as mailbox client issue.

Q1: The "clocks" is an optional property for some old Rockchip PHYs, so 
set "minItems: 1" likes the below, is this a suitable setting?

     clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3

Q2: Do you want me to amend the code to like this?

    clocks:
     minItems: 1
     maxItems: 3

    clock-names:
     minItems: 1
     maxItems: 3

allOf:

[...]

   - if:
       properties:
         compatible:
           contains:
             enum:
               - rockchip,px30-usb2phy
               - rockchip,rk3128-usb2phy
               - rockchip,rk3228-usb2phy
               - rockchip,rk3308-usb2phy
               - rockchip,rk3328-usb2phy
               - rockchip,rk3366-usb2phy
               - rockchip,rk3399-usb2phy
               - rockchip,rk3568-usb2phy
               - rockchip,rk3588-usb2phy
               - rockchip,rv1108-usb2phy
     then:
       properties:
         clocks:
           maxItems: 1
         clock-names:
           const: phyclk

   - if:
       properties:
         compatible:
           contains:
             enum:
               - rockchip,rk3576-usb2phy
     then:
       properties:
         clocks:
           minItems: 3
           maxItems: 3
         clock-names:
           items:
             - const: phyclk
             - const: aclk
             - const: aclk_slv

BR.
Frank

> Best regards,
> Krzysztof
>


