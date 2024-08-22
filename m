Return-Path: <linux-kernel+bounces-297670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C095BC35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80925B29D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC141CDA37;
	Thu, 22 Aug 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9zM2Pwh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8241CCED2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345093; cv=none; b=kdgSAGbu/tllzycpszBGFZphqoM+hzTp1c7aMbpxJo5+zrlmzMVlujj54QeImcQfDjPXo9A80cGmq2gB1m2mvLSEwuGaNXkP8XqHtymg+pjt9OFCwJBQV1FnrLGKMI1c7n/+nmvh4gMMLVjO85AOwmzhcM8RNO2NvQrm+gt27Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345093; c=relaxed/simple;
	bh=eetgk0xjeiZwykHbHzB49rFPe5JDRDuO3poVAEw45q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rmzLJfxAt1Jhjc3ACF/5eAAcaG9UVMUr8Ib/GJ2a8PR9QdUKp7Xp9XEIwb3JvwofHl2wKjtY2DJWOLXpwofU1XT4eYyPKXoFfJkgQb/gGgSgPMqIREU0OiQ1rLW/pknbjHPFCVfCbT5yfLiW8eFNcBAdcnvubyhYVGOh6LdP3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9zM2Pwh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86696b29d8so7724566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345090; x=1724949890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVi2Mh/4egq1ay696jM8IMQlXhQ1UWi7W7AhMeHZVJ8=;
        b=H9zM2PwhQyOJQITMlctKIIb1Wt16N4U+wVIakmL1bYBVcIvyo92SIZQd55uX6WJstJ
         vwHTwgjGWWkBXdmFwTd/0EMsZEhUzHxNNs0TkiJj+egR428WsjuguDwdDmifTEagP5Yv
         mOtoRlJb+xGRit01k+yIPIKG0UayuObyhSI80QSGLtF3BDgkJSNg07WhsmvRe4yLkrHv
         8cEltZzYbOp1PortFo9rdbYjmVUOcSLZKCYnY46qgxlgOnDTi15ifsx90Vd4PLm3LV4O
         e1znZVChvXbdvgAzWz+x14wWIoz8AAOC++1cWPPpKigpuebSs57Nk2xA0yE7lJQQCoIk
         WDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345090; x=1724949890;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVi2Mh/4egq1ay696jM8IMQlXhQ1UWi7W7AhMeHZVJ8=;
        b=uYHhXkDlUwFPXlJSQF/GRqcaI9frcQ/qSzgsjACoPt7x+HyiRkC7EUbxsbqzouPY9y
         FZbOiwoHWHLRPIQedSneypq+ot+VspQidiyj5GfWVMzaCHC1OKgoL2KbZYjWSPyf0tNT
         29fvd1wtoMxGGKOSPghjJ7aWF3eWJ1LcfHqUNdaJq+bkjeIZbNiaK2sojisR4Mnl2MfF
         URKU+B+0oX8LQLJ965MP2Y9Wq6ZY5JF7wNDXR8y750CeEMdJtzDe+Ceudvc7I50NMZAC
         Fsg6/Z6d1kLJR8XpcoRwvH1VGn8SsFDPo32+7/vbHmZ9rlyv73EKQXWVQr8WslkMl6M3
         GXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP6edZgVGMPrFhZI5XBdD6vrcF063/dc8Xjn3kosxQp4D5lrJHmpzHkluvtdtc7KmEYWReN3RMwx3uLcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqBA+UXBev3qt5Np6ubVH19K1bgRKjf6btUCqfUweu7bkvqTUK
	cK7v5CyMwANerrqYBpnO9iK0lkBE1K1Hut4JdPKaFoQdQohgQiqeOhsiJtUyZiU=
X-Google-Smtp-Source: AGHT+IGIqv7Nz6bY9CZnyOfYtb0TqWlTqflok9MaYqR8Jb1tYOgVpnVaF56xWOH7t7a+/6MlNXRZTg==
X-Received: by 2002:a17:907:7252:b0:a80:a37f:c303 with SMTP id a640c23a62f3a-a866f303b0fmr312455566b.4.1724345090196;
        Thu, 22 Aug 2024 09:44:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f437930sm140842066b.107.2024.08.22.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:44:49 -0700 (PDT)
Message-ID: <dd1383fd-39d2-47e9-b559-21f20c995310@linaro.org>
Date: Thu, 22 Aug 2024 18:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: pmic_glink: simplify locking with guard()
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822163345.223787-1-krzysztof.kozlowski@linaro.org>
 <20240822163345.223787-2-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240822163345.223787-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 18:33, Krzysztof Kozlowski wrote:
> Simplify error handling over locks with guard().  In few places this
> elimiates error gotos and local variables.  Switch to guard() everywhere
> in the code for consistency, even if it does not bring benefit in such
> places.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 

...

>  
>  static void pmic_glink_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct pmic_glink *pg;
>  
> -	mutex_lock(&__pmic_glink_lock);
> +	guard(mutex)(&__pmic_glink_lock);
>  	pg = __pmic_glink;
>  	if (!pg)
> -		goto out_unlock;
> +		return;
>  
> -	mutex_lock(&pg->state_lock);
> +	guard(mutex)(&pg->state_lock);
>  	pg->ept = NULL;
>  	pmic_glink_state_notify_clients(pg);
> -	mutex_unlock(&pg->state_lock);
> -out_unlock:
> -	mutex_unlock(&__pmic_glink_lock);

I am really sorry, I thought I built it with W=1, but turns out I did
not. Code needs a fix, I will send a v2.

Best regards,
Krzysztof


