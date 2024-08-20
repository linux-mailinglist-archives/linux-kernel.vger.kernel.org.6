Return-Path: <linux-kernel+bounces-293651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC29582B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8DA1C245C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9F18C352;
	Tue, 20 Aug 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr/tUIfG"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DD18C329
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146598; cv=none; b=QvhLNwkYGaKAiUBS06gSdyr0Cz1MZ1w4rrjCNiryzYYm/5cveP6PPzi0AN0sQAckLpJ4iU2Fg0zmv3geEMF0FDO2yuVOA6SNWjJtdC5KbV/0IpvBFB72zmsuWt7pz8OsQV24w+DovAYOaiTbVhJhvnkVEr4mWf6EQkfTiXCmiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146598; c=relaxed/simple;
	bh=OwJHO7CCk3YXOcUKiTlow/r4ZvKcTPS0dmo7ZnCI+z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AM+/h7k25RMf/J1XrmdMmohjZtXx594pm8jvfOrxPK0Uvk4wayDnQcczm0o0zsNPn8EUG7PuGyst9ZChALFoNLwsK+CCl+tqyFuK2craTGIAPgNwrS4sZ6Pq/WgVjJ5E3l4Bcm74LlIbgHWdH+cX5DWMhC2Ukez9krlkSVlBJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jr/tUIfG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so3084915e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146594; x=1724751394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oh0SiCCRVNkThGzWkOpREBCDmzitzKj5qRB113MeOTM=;
        b=Jr/tUIfG3BNitTPjwkLHivwRdEOmGIgVNurzCNmM0bYNjzEYEpkytc8UzQ6ubmWszD
         ksaD0551658336jPXaFcmKjFccTRe1r2VkRBnZqfhI0kEcPOK0Hotp60cm6cnXXmDGTu
         l0/8PF6NfilWEcUbzLTXnSHYbYNp0GrdTKHqW4RQnZ5Th3JFOh9VfPIBnhtJYjGcnbsJ
         PGPiySWGG9cij18dN03iSBZkL2cXKFYt/uSCpcBgxH15zfpzCLVO8K//TaSUvMYoph6D
         9INpNfrLaC1OK5tNmHLP1ghLn0CYGeua6ZYSMCGbw7ik3eeGJEF8/0POHteBoW4bdvxT
         eODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146594; x=1724751394;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oh0SiCCRVNkThGzWkOpREBCDmzitzKj5qRB113MeOTM=;
        b=aGvv4for4arwRCGev7qKkb6byaYXsPMTa4XwcbAHqJ0f+CaLD4OCltzNx+8+vDHCz3
         ybfOwJhOCPSR8hkTIMTRxlNR3OhJkb3ywCcuLaeIdZF1z2Z+uAqXCOeUEDiloa61kei0
         GW/xYd/PN3M+LSpOpQ7rMtIob6vgE24k/3eKRn0ZlfIkzvmPl/FTw17fJwU4ONWtrDiC
         NYPckUSxxuojAwVGHYlgHoooH7wzCZR3nZ9SrtLP67DEkVBrv21UTcXZFd44Cv4hf5Ee
         F+Of3W1KXYagMJ/uXZUYXFA4lw9WS20z/M+SozMiFOO/uuUVuMXukcp2kre0pi7gnV6i
         sMNw==
X-Forwarded-Encrypted: i=1; AJvYcCWIPb8Ail2qEgdgHCgGz01tpBWYQ1fOeXGFJpbOcUMJ97F3MS8J5dRY7R0v3YuI/FHMXnKhmQzqyRWafixZwxaLM0SkmGlI74AiEPAr
X-Gm-Message-State: AOJu0Ywq9f2cQT2PwjyhqG6gwc1ZyT+X/Dvqk1R+G+0mBCiqf8rLhz1h
	Xxr9ImJxfRrsIiItxS1fFhCTXLPZtP/35Ef3jM9qdnNI89xaP1P+sTp7l0v5aWQ=
X-Google-Smtp-Source: AGHT+IGzF/Okm6Ghf1kqeMKmTX9uOzrXJ80ZSsdv2qOhMTATHO8y5ZCZAHUD0wqAoOeps9n3qCGCjw==
X-Received: by 2002:adf:e3cf:0:b0:368:747c:5a04 with SMTP id ffacd0b85a97d-37194649c71mr8556205f8f.25.1724146594391;
        Tue, 20 Aug 2024 02:36:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849b08sm12584740f8f.43.2024.08.20.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:36:33 -0700 (PDT)
Message-ID: <e006aa3d-3ec1-415f-a8d2-8aee6847a698@linaro.org>
Date: Tue, 20 Aug 2024 11:36:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling
 to simplify error paths
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
 <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
 <20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
 <20240819171313.00004677@Huawei.com> <20240819171954.0000600d@Huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240819171954.0000600d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 18:19, Jonathan Cameron wrote:
> On Mon, 19 Aug 2024 17:13:13 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Fri, 16 Aug 2024 17:09:29 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> Obtain the device node reference with scoped/cleanup.h to reduce error
>>> handling and make the code a bit simpler.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>> The original code looks suspect. See below.
> 
> Whilst here...  Why not do similar for state_node to avoid
> the delayed return check.
> Existing code
> 	{
> 		state_node = of_get_cpu_state_node(cpu_node, i - 1);
> 		if (!state_node)
> 			break;

I don't see how __free() helps here. You can return regardless of __free().

> 
> 		ret = sbi_dt_parse_state_node(state_node, &states[i]);
> 		of_node_put(state_node);

... and this code is quite easy to read: you get reference and
immediately release it.

> 
> 		if (ret)
> 			//another bug here on holding cpu_node btw.
> 			return ret;
> 		pr_debug("sbi-state %#x index %d\n", states[i], i);
> 	}
> //I think only path to this is is early break above.
> 	if (i != state_count) {
> 		ret = -ENODEV;
> 		goto fail;
> 	}
> Can be something like
> 
> 	{
> 		struct device_node *state_node __free(device_node) =
> 			= of_get-cpu_State_nod(cpu_node, i - 1);
> 	
> 		if (!state_node)
> 			return -ENODEV;
> 
> 		ret = sbi_dt_parse_state_node(state_node, &states[i]);
> 		if (ret)
> 			return ret;
> 
> 		pr_debug("sbi-state %#x index %d\n", states[i], i);
> 	}
> 		

Maybe I miss something, but I do not see how the __free() simplifies
here anything.

Best regards,
Krzysztof


