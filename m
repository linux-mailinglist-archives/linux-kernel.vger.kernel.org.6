Return-Path: <linux-kernel+bounces-246156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94EB92BE52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F71F257BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68619D099;
	Tue,  9 Jul 2024 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dbo32DBy"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD718C34F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538915; cv=none; b=iCZEN5nwdVxRczTKi4eSUU1GbhmKZ6yjoAL7VwF4EEKjNS/C0n2L3cYCz/Z521B9gHW5reZd98fMJi/zFT7lZZ0cNS+MPE5s3x4w0ueKuzHjq3UOoDwBRaGa/PJhvrzmJYTKY2DrOBgALZ3HCf6gcY73vONd1LtMbfXXfdANgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538915; c=relaxed/simple;
	bh=pUVev29WhcEhgGm1elSQHnizmrZu4fP1GBI4M6iwq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs9MrAgsRJWNKUq8UfHrQsbYvw2vuTm5NAE0NYoUmW6tI2YnnkSPH+jTd1ovsARGuA7fePgfB0xvKdzcM2wDgMCMFeEeaRWRe2OXgvTYmJKLYyYUw7K+APMd+wJwhwObAdRD29TxfuvVHjd2V8nLa1cifM/c89q1Qaw5OMP4Ops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dbo32DBy; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso5070637e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720538910; x=1721143710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMOSbzRuI/wP8g2RSEEFBMHO9y92zSvonnYkHnjB1vo=;
        b=Dbo32DBy9/I7QybbVHpRUl9MG71X0fuIIEXlKg92uJEJqCQmQ1ek7Ob4U9MNVixa33
         uLge2+FynV3N05KKRL2P8f61J4OeCXOFzDuGn2Q61krEA8IC1EWCsQWZJXJ6A9zSlpdQ
         9kp6UmMmc/avFeXLjfUy3qShH2a12WiS6bHxgT5rN5Wh/BWRqnNg9nAa71cCDlw/SuNg
         iuisJwSbPonpYiPSGvNtuaWB/DRvFJgQfcbZvw7tsXnC0BaphNPjsKJI2bm37Nh/VtOG
         z9rHzagrs6ReGGO9NgEKNuY6bbWxfn16WZ7Ee/rvfG+nfnucLhcfJSql043Ov0ZJZaxr
         Fb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538910; x=1721143710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMOSbzRuI/wP8g2RSEEFBMHO9y92zSvonnYkHnjB1vo=;
        b=TPKLnJtd6+5JwlLX9+w8ccYdddzfVOHr02oC39rG2r6LeItdD5c3/Es2+m2Y8Vf94R
         mGcOuJuy9Wjjv7P1R5ALM49NdLAqXRfNswXWFOy7tPlE72mK0E5jJBxEOeuKkX6XIcWa
         logrjYojtWzEg6L4phS/qufTE6akWm5gzDIayDQRk9+wANmFadV4IQJ1F32hY2xjD8rq
         Fcb9nyAQHxpAG2uoQmP72JVIFS5m1acxMPwAPXyN/bp/UJ4riOiCiXT7lGEPfcNGz1bz
         dVZhLE2KGNCOUcUUePlI1TlqtbAytaqK6/yScAouG6wd5KpCNTVmuIvmxy40bF4XM7nx
         gzBw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Qz0PjI6TK0nOCubOuljPGP33F/SzTb8Gurgu0UfEzY+NgWs1uPFSsGBcWMoAWfTYD1Ke+pyhHzJQFpytYNK6z5kt3l9Fb8tH4Nbg
X-Gm-Message-State: AOJu0YwC3tGJnW+eQt8tteQONRFJ8EMGAtkFCzfFfXIiqnhSboMptHG0
	NhP075ZgxyA4FPa7D6ou2IVMe44Xam97RIzk+X7YXP/ZwHtJvSReEwuCgQu1jFI=
X-Google-Smtp-Source: AGHT+IFgDSwXDcR641XU+jvAZ04BkLSldWISaOxKmLROroPi2YBGbkMFd54rHfiW2wRLpQGilsILaw==
X-Received: by 2002:a2e:9c96:0:b0:2eb:d816:7a67 with SMTP id 38308e7fff4ca-2eeb30de2a7mr19395541fa.16.1720538910340;
        Tue, 09 Jul 2024 08:28:30 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cdfab11csm2833723f8f.102.2024.07.09.08.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:28:29 -0700 (PDT)
Message-ID: <4c989886-1fea-4975-853c-a9b34d9d8b2b@linaro.org>
Date: Tue, 9 Jul 2024 17:28:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: Drop 'trips' node as required
To: "Rob Herring (Arm)" <robh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709150154.3272825-1-robh@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240709150154.3272825-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 17:01, Rob Herring (Arm) wrote:
> It is possible to have thermal zones which don't have any trip points.
> These zones in effect simply represent a temperature sensor without any
> action associated with it. While the schema has always required a
> 'trips' node, users have existed for a long time without it. Update the
> schema to match reality.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


