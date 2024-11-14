Return-Path: <linux-kernel+bounces-409763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FD9C9115
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582021F23668
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194A18C907;
	Thu, 14 Nov 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vltc1sae"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C37189916
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606398; cv=none; b=HumjYe9UTZaiea+AxP+F6VgzmoKwdBz7wl5I5B201YwiW7lahDiGAdPJkxiwN6hehedC2UTBtNvKnCkXL8bZ9FCXlL1Oi5k1iJHLtrc0nPJmlO20XvjjPTKfFmHeymrqNr0U0XtDvOvGYGeCis53ZjDGSR/kgYfS9XAxsm7y+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606398; c=relaxed/simple;
	bh=NA58fS6XQUw8rJ0uXmi3pOsMcJtgXs+JY7KMogQcHgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNKQvNWfRUb+BGaRIEfes2JQ4a/TQWFUpANcTEfWoyfb7ah9ym6KK5vgnS0RuPxoNp/vG9DktbKVHEo0SNO832/P2/L/8Of6y/gMegTbnUFMzwtVmP8Vu0cKBclYhvoJ966J0GlG5iKzP2bOkiYFeHhyEcvFupeZ2APoVCK6wLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vltc1sae; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso974014e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731606395; x=1732211195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydOqmQuZhEKXboyqXYbz+toDadk8akjp3SATfp/BUmo=;
        b=Vltc1saeUSrpfn5e8nht4n2o3bLYELL4pq3xfym1qsl4FZHkJT3NOuWGWEVRh9T1lY
         3IFQ8hgSMJWbI++5crOE41cdhDonFcMc9l7AAEnnKbXzoJ2BS6wxoM0XPFERycuMdu3f
         PR4Vi/9PLV3AUIwBCWDdbYMTyWNZdvFX3a5ndW+2q+3os2LtfrPYVQD/Bq+UjNz3DQ3l
         jNQ6c1EI9nEA2/u7SITOloV3rNn5xD084Qe2T+8qXcKUVJquOC8HaZCdKCa7m+Y7hieF
         MYwL6+SUI+Evez/idnmUSqIdMzSFdqsCsqaWvtqgurhSEWlfUbxela4x74gH8gvPOSjP
         mzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606395; x=1732211195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydOqmQuZhEKXboyqXYbz+toDadk8akjp3SATfp/BUmo=;
        b=HiXmgpmGbm1lsvFWjmwV9DEQhIJPyC/u8gYR0+BRKMQHaQK6Q19HlEr/dafHIyC1ba
         WtiJGW/ovOMTJrVUhNVL19EVyu/oeKqKUegQWZKbNy+Md8pBzpPUPrinCAEjHSgw+6nl
         pVnNDdvc5SAXtZ33h3vpzTudFitLwHU/DUFOH29E4CLlEx14rzQXIb/chKPCCDGFpNvX
         YOVEPhhVJhq1Gz2nJn9HFMhE9YAhhfsvVYh6PDPxeev5lTom+d266Co2ht6HdKsEAR3Y
         51SnP4SWRBaBNcWDzfyqFSSMFKnh9b4+AfbYnyKry4RLmVTUD/LVqqMfIC6uxC84ZR5c
         fzBg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgQi2durnxs3qmLdZDIwqMCH0XlaBxo6G03jWDFopKD5YOEsHbwpNRmpEsYX9opsosn/44QiPP2C/m6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1I3pYbWSEgaQvZKRz0YHk9gpVFrzxdM2mfEq26vidsWXOLpD
	TcJJbNrB4SObHtT0QCku23RI3H2Xem0LVg+dIlpDWEYRV+/GcutibWtQaL+3Ab8=
X-Google-Smtp-Source: AGHT+IHgHYVE/h0+RXbygc5S4IcTDZXFm8VE/7Twx1yEeqJNVircTeGt6suoOYGUYTN6B7LNlvX5Qg==
X-Received: by 2002:a05:6512:220c:b0:539:fb56:7790 with SMTP id 2adb3069b0e04-53d862bd3f7mr12847708e87.6.1731606394599;
        Thu, 14 Nov 2024 09:46:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432dac0aef0sm27975175e9.28.2024.11.14.09.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:46:33 -0800 (PST)
Message-ID: <1bc55c9c-f5ff-46c7-b2f3-65c275c52bcb@linaro.org>
Date: Thu, 14 Nov 2024 18:46:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/thermal: Fix common realloc mistake
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114084039.42149-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241114084039.42149-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 09:40, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> If the 'realloc' fails, the thermal zones pointer is set to NULL. This
> makes all thermal zones references which were previously successfully
> initialized to be lost.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---

Applied, thanks !


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

