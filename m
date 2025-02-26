Return-Path: <linux-kernel+bounces-533966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF3A460E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28E37ABF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16B21D3E6;
	Wed, 26 Feb 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwHN9ZBF"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA721D3EB;
	Wed, 26 Feb 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576487; cv=none; b=RAllw7c9JBNY+WCOPHCp+pO4gsjScrKY24kam571yarwnEgH5cLEWq+qZK5EHfX4JQdDMb/yohMAU/X3j2mNtOKRNSzDYl/dTtikiMpeWEH1/c8lVczx/OScWRSZJsoGpe5DLiEvdxgjEtd3vJnj7tZrM7V8axrp2SY3HzIdx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576487; c=relaxed/simple;
	bh=4SMErx1uI0VODG0W9bmD7QqNKwqgawcXT2PQw8koxuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAY4HKKxsK9t7krQKSQoQkUagLokmMK9ZRUtfSiGoLtDb+29MOUVCxP951oN+mfm6J9bPvf+ZLRHSXf30huHblORLUv4TUFkrCCnOLbEN5RUc58MXIRcqDu3NTqI5vnKjgKb4veGvw6Hmr9ZflKpqYklapFFKC2sBC3Z9YKPaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwHN9ZBF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22101839807so38249455ad.3;
        Wed, 26 Feb 2025 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740576485; x=1741181285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMjnClbcooN3I5ewM0eirgAPMoJHCUEMpPh0j1XhfpA=;
        b=XwHN9ZBFcOXWBlLMEU0C3rb/b5+97dygGC6HpznaSdFGtePD4oDlnwXjQx7kLT9trT
         McCQILo3W896dl5nAlD61++GytnipYIX4g7Op7hVoVUnG/qjSR0wvFxmChGrRbMiuczc
         em5tufIveeZEq1bf+TMvpnmVlndwPhgznKuktkvNp4ldoogT583MzA0WKiuqcdQ2is/Y
         zHnPdJ9Gys5JKI5xFQIyMK8jpmGLfI5Cn/fsoMe+cpeafb2dMLajs4t5h38zJ+YG2Lv+
         Jcqy5ErWVO30Ejv+NZkmdPFl/GvFfORE+63EO/sTUNdt9Q9atVs/N2uRTZVGr2KXVQal
         NlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576485; x=1741181285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMjnClbcooN3I5ewM0eirgAPMoJHCUEMpPh0j1XhfpA=;
        b=FKkkSf54L4Cqxjw3hf6xM6V7I/ObWGTn5rNJclzqQBRjocoW1ZtBuMNWXsXCo53VJf
         EPD4qBGXnJ9pjT5Do3N10kON8jkn4rlIbM48wh/2AFbKjy2yqyLyQTdhWouAHzkOl8Qe
         EiMss1UL/Rz/TKKd86Z8NHfYlMKD+LDUVMuyZdU4zil0i9Gch3Av276LOSr0Pmu6ekIg
         WU+IegJffJz/tTU2JZpsz4oaSMHe2KZGZ4oWIGXQqP7CYYVwLqczGW/o33MBU1+7lGJo
         iTbLrVI+D7TxRr2R1cBX3KahdEijU3OY+WV5IFBw9lN+2XyW38hX49NABGk0SNG0vOMP
         2xbA==
X-Forwarded-Encrypted: i=1; AJvYcCXWcda8eiR0DR0gNxUP4bhgtCwsYw1lXuOXEWCPAFXHQQCXoemagbnlzZdFBW0oIHjermdq3PTOLWZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YzecInGHBCw+395DGdySBUBam35PqJXP8w5J5oiAY7ap0JF5EZ7
	9Zec7kk1ccAuoE7ixPKS6NRoEBzyGXqFC3Jx/k189TiZRHXKD0aJM1iq6grFjq8=
X-Gm-Gg: ASbGncs8E30Rw7xJE8SSVVqv2ANfxkvHMoMLMCyySlVz1bM7ZPUzwo6zwvxO/U8ADD2
	q4rr5iPCYvv06Y3WPViBmta9qaMrK75WxRxgQ8f0O0wFiYGnbethAzaEjlWN2h75V50Gw+BHxXL
	dZAHRDr3N2TxH8DlFt5uqUfhcqS16Jz98LNR8JDx/+zLh6aXpMR/eREEhQe49HO4VC8ILArtnKK
	TYp8vvx71N5APVs3mFl5kDEHWelpFmfMHw8oWK7cTv3IA1t4Oe8yfBA3R+PgeFH1br6g/lYJWb7
	FPNsnihl4a3N2BV7kChJPAYTRC9wK7Kc+xkTyAq9d9iB9LEBtUu3Lhmc00tSP53WolUYTSHL
X-Google-Smtp-Source: AGHT+IGXCwstq/KHZvkH2IYKiTn+Do+Nf4hSI/Dsu8V1QhkCFotD8b+ZNhay2Dfwe1oDMqpqIpuKlw==
X-Received: by 2002:a05:6a21:348b:b0:1ee:6d23:20ab with SMTP id adf61e73a8af0-1f10ad33426mr5136409637.10.1740576485322;
        Wed, 26 Feb 2025 05:28:05 -0800 (PST)
Received: from ?IPV6:2804:14d:887:95a9:987e:93bb:37f9:580? ([2804:14d:887:95a9:987e:93bb:37f9:580])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9b7fsm3464473b3a.100.2025.02.26.05.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:28:04 -0800 (PST)
Message-ID: <0138cf8b-7458-466f-8d0c-55c9ccd0a932@gmail.com>
Date: Wed, 26 Feb 2025 10:28:00 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
To: Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250226010956.50566-1-leo.fthirata@gmail.com>
 <29ce9b9b-3993-4b88-a201-5d67050d53ae@mleia.com>
 <7ba7cf93-e40d-433d-bba5-c43ce8510ae9@kernel.org>
Content-Language: en-US
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
In-Reply-To: <7ba7cf93-e40d-433d-bba5-c43ce8510ae9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Krzysztof and Vladimir,

Thanks a lot for your time. I really appreciate your feedbacks.

On 26/02/2025 7:14 AM, Krzysztof Kozlowski wrote:
> On 26/02/2025 10:41, Vladimir Zapolskiy wrote:
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nxp,lpc3220-mic
>>> +      - nxp,lpc3220-sic
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  '#interrupt-cells':
>>> +    const: 2
>>> +
>>> +  interrupts:
>>> +    items:
>>> +      - description:
>>> +          IRQ number.
>>
>> For sake of better understanding SIC1 and SIC2 interrupt controllers
>> are chained to MIC, that's why there is 'interrupts' property present,
>> and here 0/1 interrupt values are for regular IRQ, 30/31 are for fast IRQ.
>>
>> Also please add here
>>
>>     minItems: 2
>>     maxItems: 2
>>
>> I believe that the 'interrupts' property can be just left without any
>> given description, or just give a simple description like
>>
>>     IRQ and FIQ outputs of sub interrupt controllers to the main interrupt controller
> If they are obvious, e.g. maxItems: 2 would be enough, but I understand
> that these are distinctive interrupts from dedicated blocks - 1 and 2 -
> so they should be listed.
> - description: IRQ/FIO of SIC1 (or whatever name is here better)
> - description: IRQ/FIO of SIC2
> 
> Best regards,
> Krzysztof

If I understood correctly, the first item of interrupts is dedicated to IRQ type 
and the second to FIQ type. Then, I was thinking about listing them like:

  - description: Regular interrupt request
  - description: Fast interrupt request

What do you guys think?

Best regards,
Leonardo Hirata

