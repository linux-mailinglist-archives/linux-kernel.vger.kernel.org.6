Return-Path: <linux-kernel+bounces-390453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47219B7A23
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9972F286008
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCBA19C57C;
	Thu, 31 Oct 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aX9P9aSx"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804919C57B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730375991; cv=none; b=S6gHHNCT8L6PAz/RsBGhvfL3LdGP0FA6+GW4zA59xdD9BISxokGgCqxvviWpOmLLeCe3j+3Paoe6VJj2j6+EgrvJivFrA4DBMtBb+Rq2COGNLgOh0Zsm1TnR74exNFlFNc1XNBvbkRrRqLWJQgciUj3hCEEX+EjGByibiirVzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730375991; c=relaxed/simple;
	bh=iK/xdl5TEMJC8zzGdUkSmByIVGGyGuPcv58w7uMiZ0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSSThgyPvqDfAUvm3+a3JJduVa2W5THJi0yrSwQsoQwXFpQv9bePJkOyRdLTjRPJKAcqMWcJIACukc4Tg/6avO35nYrQVsZX0QmHSQ/ly+kWBH3cU0uJB0srsISTpqpgnrycPbSrVyOsoHXJ81ryKdXR81xa7d1Rn/RpxS890zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aX9P9aSx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e151d73fso96356e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730375987; x=1730980787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZDHiI2bQmYIGIWgV0FNXS5KpNYpFDI1iWLEjkxYejQ=;
        b=aX9P9aSxbXYKOlGcQ8/yJq0n1YtwW5sBSXseMlYgoJo0O1a9rL/HT02M5oaKcpQZJN
         wboBUDD3X+zyMwNE59925+eBB6J//vvhvrYemMu6byOtY74n+y37xR2MW81fU1W+6us0
         cGrIzynsAiS0Wh+4A4fhz9kRX6q6pz2GnSiXdQwmSORVvqtf+wSm8ArZIXKipecdCA1R
         XgzDMLJPc6gzzOJAYW92AsS0b+xvcdawHGbD1X7jxk6hQ7FOWCeAI0OUIyCywPmM5ujz
         yiwCM2xcqSTU/iI4qRXp4gdhCF/8h3lBwvw8RDFzqySKEAsAAM4O2ZpNXSqhBnOgnwIn
         42kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730375987; x=1730980787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZDHiI2bQmYIGIWgV0FNXS5KpNYpFDI1iWLEjkxYejQ=;
        b=lSU9F+e20bfnva9Sb1H9CbVGS7yItLEDAJ6gmymDpb13j4u7qYN+Nn32zBCZ6bvDw/
         etUmSeVkH6B/z9hhX+g2ib2IoPG3DsCIEG5AI/uf1LiN7DMD5imwbJId2F39UdSFbkbP
         6NaaS9ITQfZNvbv/pkbh3Nqjczg1IvKV+3NNUiWwOCgIfJRPhTydbylVKUv6TSbZdwxR
         HMWAAtThsL1/c2DGQSH01EeB56pLIAEl2I4OGCJud7LDnj4pB2ZmXFHkkZduuliu+EcH
         KSI/0kZT7x7hy+3l84DDAexoqDJzuTAQHbmEyHCv/ivSwnn3oO3GVHrOTv9yl4PHXbFn
         lhGg==
X-Forwarded-Encrypted: i=1; AJvYcCWYpn6EXwLv6hJRHRmiurLITawIHR3RIz2CbDGH910DHIHEMfPbZdIJNBH9E5yqgyJ5l4wsMwvoFYE6KeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQmuSRjfL7lNgeV5LM0dKCXvovYn3zQIcK1UWQU0uh7ln9cHx
	xAy6YllHhe4JzKAYAoZEkp86zwxwdR1TGioDlsgCLPnZx4KA7dzk2/kst/7adXA=
X-Google-Smtp-Source: AGHT+IHj7Xs5nkmiifWpaojGq05sh/McD6Tj0j++Q+ojG1Exl9FTwAuminrKv0akgHFaBZ50hA1W/Q==
X-Received: by 2002:a05:6512:1386:b0:539:f67b:b859 with SMTP id 2adb3069b0e04-53b348cb00fmr3249913e87.4.1730375987313;
        Thu, 31 Oct 2024 04:59:47 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc305sm174599e87.227.2024.10.31.04.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:59:47 -0700 (PDT)
Message-ID: <e1c55403-55ee-4742-b7e6-8f0a4387ce9e@linaro.org>
Date: Thu, 31 Oct 2024 13:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, loic.poulain@linaro.org,
 rfoss@kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
 <rql2u5k3esavdmpdzgo4l4up4ir7yjpdzc3qlmsvjvqalqzvjc@xspprcohlout>
 <f06dea2e-893b-4de5-89a3-e25af56afb31@linaro.org>
 <7f5amyf7ljvtfjyksfe7cad25wu7qdg4e45mdite6bdxx63ge5@ov37ohc7qtai>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <7f5amyf7ljvtfjyksfe7cad25wu7qdg4e45mdite6bdxx63ge5@ov37ohc7qtai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andi,

On 10/31/24 13:41, Andi Shyti wrote:
> Hi Vladimir,
> 
> On Thu, Oct 31, 2024 at 01:13:24PM +0200, Vladimir Zapolskiy wrote:
>> Hi Andi,
>>
>> On 10/31/24 12:44, Andi Shyti wrote:
>>> Hi Jiapeng,
>>>
>>> On Tue, Oct 29, 2024 at 10:09:31AM +0800, Jiapeng Chong wrote:
>>>> Variable ret is not effectively used, so delete it.
>>>>
>>>> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
>>>>
>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
>>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>>
>>> thanks for your patch! Applied to i2c/i2c-host
>>>
>>> Thanks,
>>> Andi
>>>
>>
>> FWIW I've noticed that my Reviewed-by tag was added to the accepted change,
>> while it was the conditional one... Actually I don't know how to be aware
>> of such nuances, if only b4 tool is used, likely there is no way for it.
> 
> I thought the change that made your r-b conditional was the
> Fixes tag, right? That is added. Have I missed anything?

ah, no, it was about the copy-pasted commit message, which mentions a much
more popular 'ret' local variable.

> (I noticed later the v3, but it's basically identical to the one
> I pushed).
> 

Well, I believe my concern about a commit message has quite low significance,
so let it be kept as is, the most essential code change part is untouched.

>> Hopefully I'm not too picky with it.
> 
> Absolutely not! Please, keep pinging me if you see anything I
> might have missed.

Thank you!

--
Best wishes,
Vladmir


