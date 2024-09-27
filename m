Return-Path: <linux-kernel+bounces-341420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66686987FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970CD1C21630
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D0188CC5;
	Fri, 27 Sep 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiLIls2e"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C216EBE6;
	Fri, 27 Sep 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423956; cv=none; b=fPh+pWAIhi/DTuh8SWDxHDyV/Wkool7OH1JDgratEEHRS6u0G66vKMlfj7N84Hkx+N0+m84FExkY9M3rQdeOvaF/wyyHaoYKRbAc856qaLA58j7N4zkP4FZpTIvvvjmyefWe+Pwlyn0B5Zavy6OrShjmt6Xw7agCVbt2Q34h+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423956; c=relaxed/simple;
	bh=/Kcf/b+lxAS+6JG63ZN2/fBZp3TbJh5lzZtV7oWOqK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAlPHMRsq5p4wSrBZcyc5pds/BMiSLZrHpJGBSrxyY/MKiJQOuONW36apfx5NxuZhkGthf9B1SAU8fINGQFTP5dUHnHH3aJ06kfoQGpQg9y5lSHCLV3F6aILGl0EYn6/26cs38zzlR4S4lFmT1isxGFeIndrd2KGSfb48jMJcYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiLIls2e; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-72703dd2b86so167565a12.1;
        Fri, 27 Sep 2024 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727423954; x=1728028754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HwX6OI4gIIHbN/hK9fjNZGmVtettbN++9lE7NDiTf8=;
        b=YiLIls2e4TSgAhwABVhcbvWcvtK7wtIdMUip/PtlH08sbxcdo9iS42HGHS57YPUzgU
         2gpzaPSI5n3mxRM3SZ8ElxvunwrIiP0QOBf1diWtnoroSjP+k4GXBaHUxINC02OomhWG
         wKMFfwjeB/OI1hUMwi/3eM9k2B30B/WvCRyjvQ9WNMuMG2NwcDYTAU9HXzmPdT1hJbCs
         UJyW70kE347SBYF/vQD8KLQKBfcjln2Oz1tKgpMILqddFxlGPRzts1+n9fzgtEEjRU49
         to7VBPaMdnZ9rshSLZi5Hp7Zgszw/ap52+9SRa01Y2ndJ/z767S3golelCk2EGyEnqJp
         KqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423954; x=1728028754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HwX6OI4gIIHbN/hK9fjNZGmVtettbN++9lE7NDiTf8=;
        b=A4LGeNiQ9pkZ1Gpx0Z1jEf8WnNslNeDiq5DBQlFhKdwrBleRB19TaY2BcZL0gvxoL1
         B9/JgC2V3scpI6eX4gsRSTXxZ0P4TJbJt9Vn8tzxi8NUgVzZg0QmAsr3BsgGecJp1hxQ
         z5TWGakecjN6Gq/vJtlhniM2YWUeGe1cg6zTDbTi5fn/0+EK9J2E0i3STFz1snUT5Crw
         CB5lcoPaxVOTEfTzLCVLwJkqQ0OHJbbadyiwKsVPF9XSRwuE2tLGbWEsS5TpykclnsQ5
         xJncewP/JwTr4aDCOFXGQ7C9etfXQMrNhYP4a2nichbBAMVm8isoIC3V92kqYuKJ6L+T
         fG2w==
X-Forwarded-Encrypted: i=1; AJvYcCVDkG1nypUp+95FD6KWWEWl8hsgRDNCzUBKuLDcVCdhR3FvPXuUlqhzhnDc7JYzKWmSLk1DWEKWU5gX@vger.kernel.org, AJvYcCWVK1NIsqb84UqnolJCzOdO3GxfMsTaZmUs3HZGSfEpYlvnPWFC/5wM2j83+Fyks3N+MggC4pfDNKesVN8n@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQ5VBO3L295YLS/bm7Mi60vr3MfehIdqWHy/ZDsMZI+xmGDNC
	2duKAGg0mTGWVzR4Cs7VFmhCmlN9TRfQBxhOt5d+R3rSm38V8K0GRBo/FQvd
X-Google-Smtp-Source: AGHT+IE8JYRGGpZv4q306yHVh3sNMzBl8mIZYgoblrNJM7FaZO2kvA7WslMeA3lBcRj9DzjVCS+SCA==
X-Received: by 2002:a05:6a00:39a8:b0:714:1bcf:adbe with SMTP id d2e1a72fcca58-71b25dacbdemr1720656b3a.0.1727423954093;
        Fri, 27 Sep 2024 00:59:14 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265249b7sm1060789b3a.148.2024.09.27.00.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:59:13 -0700 (PDT)
Message-ID: <a06af01a-656b-4ef6-84a6-bc1c35d5bafa@gmail.com>
Date: Fri, 27 Sep 2024 15:59:08 +0800
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
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 2024/9/27 15:30, Krzysztof Kozlowski wrote:
> On 27/09/2024 09:01, Frank Wang wrote:
>> Hi Krzysztof,
>>
>> On 2024/9/26 22:19, Krzysztof Kozlowski wrote:
>>> On 26/09/2024 12:32, Frank Wang wrote:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - rockchip,rk3576-usb2phy
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 3
>>>> +          maxItems: 3
>>> Read one more time the example I gave you. Top-level constraints are
>>> saying max one clock.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Sorry for overlooking this, I will set both "clocks" and "clock-names"
>> to true, and add the else case below the above codes for the "old" SoCs.
>> Just like the below.
>>
>> -  clocks:
>> -    maxItems: 1
>> +  clocks: true
>>
>> -  clock-names:
>> -    const: phyclk
>> +  clock-names: true
> For the third time, read the code I gave you. Do you see something like
> this there? Why doing all the time something different than existing code?

Refer to the link you sent me that I must add minItems property for 
clocks, just like the below codes:

@@ -35,7 +35,8 @@ properties:
      const: 0

    clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3

That can pass dt_binding and dtb checking, however, "clocks" is the 
optional property for some old Rockchip PHYs,  I am not sure is it right 
to force set  minItems as 1 .
If just keep maxItems, the dt_binding checking is failure.


Best regards,
Frank

> Best regards,
> Krzysztof
>


