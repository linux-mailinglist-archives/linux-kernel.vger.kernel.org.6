Return-Path: <linux-kernel+bounces-446175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242E9F20AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DA0166F61
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C21B0F33;
	Sat, 14 Dec 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tB6w25kT"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A89DDA9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734207851; cv=none; b=XS/YTwKE9RBCsxUfTECpSyseTsBpf7ciqwoyEi7EkZAMRaAury4ZrpYaBeI+k9jG4VEmX0MNZ0ybvqjaga/n8GHCiuBdZl5ZbY4A9nV0o51GxAybMY2apr0VCtBEkLoe5Q5yIyllb9omftEYTYlqxX6sS9hLP5e8bJCvOLHrk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734207851; c=relaxed/simple;
	bh=zofDod8j+ztP7THAIYRKQRjOLssFMAflJyxP2FRPQZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqCZbujaXdDlhMkZ+kBHBoWiCTxEUo1z893fRQqZow/Q3vL+lEUEat3m+TnK97UBmKuk1la/Gb3fTZSO1SEw9s8s02NjQfK6pi88nbmF0DtZJNzcR23WVJuQTCZahnkYQ63LC9SYjBbJZc/4AhQnEHPOAmE0GtN7xRq5363/7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tB6w25kT; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so758266fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 12:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734207848; x=1734812648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrkjOPWzOWxIOLJtRQcSvC8VCKadtMcoPJW8JEroxUE=;
        b=tB6w25kTXyEjVAJFv7LAnx5MscDaMuvhklAmSGFOW4xfo8yQZ9FINMBXbbvVDRaBOH
         lwI/v4RadsGLa0mTjYJfh3k8KUH3zOeryJQRe0h3K27bjNByC6QnxhI5zpjP77q04vf9
         bQaBg7v4ZfL80G0i0UnIlyNo/SIJ7QTsrnHa1mEnfDyyW0awlkV5qb5/7twwfdvIODs8
         4iP7xpDQzsix29evUgtAOwglu/+6In149R8uohTR939rzBXduR+K+jXsOZ+yHWv4qQVH
         SwIvTmBxiPMWbyqCRFRFBZ7K/1sisUgyb+g+/pEruuWxyX+Ka+wIPAf7084JujWwGoRD
         T5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734207848; x=1734812648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrkjOPWzOWxIOLJtRQcSvC8VCKadtMcoPJW8JEroxUE=;
        b=iUSX9vzdJcREJUGqY5OMIBvAA7xReFnsysyOdFL5lCgfDbl8tOQDAUqoxp+mmkLFZd
         1lloKkwxm00rf8kocC+5PifpG1ISUEKp/icGreiyOB/J/6D2sJBBp3+V6qnqCKI9BWeH
         ayld+k33fomOld6HKLsmFNu5EVPoMjXQiL/HfW8gBAfa7Qg4xP59pbQG7qX509arN9lX
         O6bKztOeKR2932mk0+68asLcdPHzmToQMtsB2JGQCM6Nsjg7xgZk2F3ubSCU1l8dpvw8
         Z9twv+yQ7zGC+woFPpMle5ZJNjMAvLszrf3S8nQl8XGjVPFPEmx8GsJ9RSY2taXF8yZZ
         0ZWg==
X-Forwarded-Encrypted: i=1; AJvYcCVUJ34kLSppgPrfWezpIMODWnLXDNsDWFxPCL/Z51hxyIvda2WU8jv90rZBtXZ9pp++8Fw9iJg6GNOkcQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWIKN+zVSBTelfJV6k8xLKedcwV3JFmMRDQ+qoPpH5Zjn3O/7
	meRE48Co2S2IFw/m3cY5XwLWKEi863/Uab7cA6CdBhOLR3STXCIcdxatoBd1OTA=
X-Gm-Gg: ASbGncufD0cWDpVJX9Yf2ORG1oOUoMfAL42QTJzpfDs8p990Z66zGaghpV7n3hqw2UO
	qedFSVN4RWJmZKd4jbOFXqx5DRXvz+uWmUHS0++uvnkhHvCRnSP5REukQCXtWcWkh0TBbyyMvc2
	fn14JOeS16uGF+5kodqWAzwEt9xM01HRmqwIWGZ+TZ4PJMEz3TaTA2fztbapJEyXiVqzQ4XJVes
	tbQYApxr7xMF5z5Y+m/oKrXqC3gKQvbT6S/tlEm+gajGjQzuKwi4c5xEQ7XYONB6380WnYHw4Hb
	Jw+lpNJxFkpEmE9Hbw==
X-Google-Smtp-Source: AGHT+IEzwHeZTPoi4etfNnGZeXD/roCPhCaM/ndaTdf2HRFNxeHbdaDaBvyiEJyZScfzW8J+9PK8yQ==
X-Received: by 2002:a05:6870:15ca:b0:29e:43ce:a172 with SMTP id 586e51a60fabf-2a3ac867f5amr3376165fac.28.1734207848013;
        Sat, 14 Dec 2024 12:24:08 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2541725sm724169fac.12.2024.12.14.12.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 12:24:07 -0800 (PST)
Message-ID: <ebd71e3d-1902-402b-a84e-819b0976ba4b@baylibre.com>
Date: Sat, 14 Dec 2024 14:24:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: dac: ad5791: ldac gpio is active low
To: ahaslam@baylibre.com, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106103824.579292-1-ahaslam@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241106103824.579292-1-ahaslam@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 4:38 AM, ahaslam@baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> On the example, the ldac gpio is flagged as active high, when in reality
> its an active low gpio. Fix the example by using the active low flag for
> the ldac gpio.
> 
> Fixes: baaa92d284d5 ("dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios")
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> index 79cb4b78a88a..2bd89e0aa46b 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> @@ -91,7 +91,7 @@ examples:
>              vrefn-supply = <&dac_vrefn>;
>              reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
>              clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
> -            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
> +            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_LOW>;
>          };
>      };
>  ...

Hi Jonathan, any reason this one didn't get picked up yet?

