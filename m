Return-Path: <linux-kernel+bounces-352297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08D991D24
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1460C1C2170D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10154170858;
	Sun,  6 Oct 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/vNvUrC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1468153814
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202809; cv=none; b=BxGOvFDN/OpHh1qFDfXu/rl/jF3zFme6KrPVBni1Fvoz0Foa4QHVPIQAW9fGRIZx6vibp6vigi4D8LbuqMiB8NVyEqbKu89YosJa1z3/saphSe6XhLC2Q5+/57nDo3RJTZfSPhh4yEp+v6foCGg0hG5wOuxEPvcAoL0sMCLr45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202809; c=relaxed/simple;
	bh=xskBt4LRT3HhgA9irs479W8nOcSuA9XX1tFTBt6qcjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJnkaKt1RCGvBiRmLcGAphgkpPYcJq4wKwEvBarja7IwB2D/CaksDf0/iY7VHer87ufClKnXOVeGaa0nJF0RD9e7YQERgVx1jMpnspl3lMHsFqiHEQ8fvgC/XFlThEHf0nIR0IAMElvrFYaEPqV3Bewmk3LS+EQsvipUVUt5Ie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/vNvUrC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42f7e1fcb8dso5150055e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728202806; x=1728807606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wEIHDQplm4jDqTmGvJKy5HVY4XM91FFJ0wP6347TcVo=;
        b=q/vNvUrCG0hHmNxdos5Ynjk3aiKprHnl1s+cR5CWg29+9dJ+GEA16UJ4WaQ1/TXTdS
         g0bQfWh1f+6jvDImr/7/TtTYHavk5Wc8H1Hm8V2EZz0SOo4IOELaND2MCnfaqzbAzf5X
         FXbO4LT/t5OLnPu6/VCwaVIA31Pr4Omzwc9V2Pa+vCwCRv0EjaaMN5PF97E3MbURLqIX
         bvpy+FVOUH2Ywf5H0t5sJLiwNMezN5uw0xwRIncc9hz8y6+dcsX3zrk9DpLqijy4Wjr8
         BJkqj+hWKO6sBgJ6pBAFr3feCeuxcWyYcRCPnbu3WSVgIyGvjT5aItZD9woHVI/XYVWZ
         9P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202806; x=1728807606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEIHDQplm4jDqTmGvJKy5HVY4XM91FFJ0wP6347TcVo=;
        b=cCqNt8+TikPHOg6x8Ta3LGQX+/3yIrHfhfxM/ewGo/T/hU6sQs3XvvCxcLtlierWgg
         uA4J27JnXqNV2ln0+m0vKij78hzEZHHuucG2HFotxQfJg2a1FiFFO/L5a6f9amBZQTiX
         l+btMixHI/jHJSdMQkrYj6y6vIih12kZNnbISWoTKhc/TTch4yefCPHFae168YariD5N
         NuykRsObR9r54ntryyn7qcl8WQoEn3jT08bUhdERJseIhmhTf+sq0fzDo8sRDpW2pYUQ
         0Moec6LavpcCtr2/dqdkr0j1ujaj7OV7FWwVJaR8Qr121rvPmYq5ZVBxzXKr1JnwugsK
         rNqg==
X-Forwarded-Encrypted: i=1; AJvYcCW/zZih1J5Ci98PZ0O1R8m5va4M7xLs9Yxg0SyBGGOqWWvHrzoTPc+H3eBNAE2aUZ0EHG4ChWdQhz2EX5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRYewi1FTqJzUJMtYDw8itFDquM4shUo/C2VgWdpfUO8PDBOW
	0h9asGIxA3s2WsilZXJtmKu/DEuYJSPKmvy/u6LRYrNe4Ab7nXiix0qnpkjZa4o=
X-Google-Smtp-Source: AGHT+IHc7CjhXNjSnG2kfYIubtM/X8gwjZtBcZXhkF6l/K21ZWt6a99LhWB04H5/xjsH/rpQKfmsYg==
X-Received: by 2002:a05:600c:3b1a:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-42f85af0d24mr26199515e9.6.1728202805926;
        Sun, 06 Oct 2024 01:20:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4a89dsm58797815e9.41.2024.10.06.01.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 01:20:05 -0700 (PDT)
Message-ID: <127856ca-fb79-45f5-ad0a-8aa219bae85b@linaro.org>
Date: Sun, 6 Oct 2024 10:20:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to
 Frank Li
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev, York Sun <york.sun@nxp.com>
References: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
 <20241006080810.GAZwJFauv4TWAICuQg@fat_crate.local>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241006080810.GAZwJFauv4TWAICuQg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2024 10:08, Borislav Petkov wrote:
> On Thu, Oct 03, 2024 at 09:33:48PM +0200, Krzysztof Kozlowski wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 636a84ccb5f6..03474c934930 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8120,7 +8120,8 @@ S:	Maintained
>>  F:	drivers/edac/e7xxx_edac.c
>>  
>>  EDAC-FSL_DDR
>> -M:	York Sun <york.sun@nxp.com>
>> +M:	Frank Li <Frank.Li@nxp.com>
> 
> Let's start by making Frank a reviewer first. I wanna see how we can
> work together, how responsive he is, etc.
> 
> My experience so far is that most of those EDAC single driver
> "maintainers" become silent shortly after they get added so I'd like to
> avoid yet another such case.

Can you change it to R: when applying or you want v3?

Best regards,
Krzysztof


