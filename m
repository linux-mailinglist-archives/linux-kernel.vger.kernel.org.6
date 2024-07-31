Return-Path: <linux-kernel+bounces-269958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3A943949
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902BD283085
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089E616DC26;
	Wed, 31 Jul 2024 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9IMll/j"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0616DC01
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467625; cv=none; b=jJX+AUicKhM7X1ynZT4ZCD0EPkA937IfW+XLVSnONsCANJFcseODZhJNyNw3RJNkcyfSUeYel4+iFkyO8j9mUxwLFEgepHKfLf6M4zprkHzIpkCIFt52KLeTZDQXDarZ+2evZOTapVEakfneBaSVTkC3EaQrGQmXkcrV9CYBZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467625; c=relaxed/simple;
	bh=VyJpcTQ4QOnZkSwkJW7Hc93Gms/6UVZFKZBOeAtTHFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XA0asQDNr7W72ziVn/AI9aHko8xm0d0V4CcbddtHaygU1Q200P0oQ8oeLopebdAQ4Hrrmom9+NPNirWu7vQzkNKHncGnNU3qFYmi5lRfOru3AfIQOqjcxZJKPOCR2eNxyAhVVU3QqJ20X8qN9lPS1J6Tny12bt6eoBs8xX1tW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9IMll/j; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f015ea784so1042185e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722467622; x=1723072422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm0Xwjt+29MOSwfuccAriuqumY0vc7/Lx87pSACSnGc=;
        b=M9IMll/jhPcIZZErPZUpVobxjMykBy655FwYzYC4W5LWZUk7PWfoRBQhGAxhprX3hc
         f+TeZpitKM3qF4Yh27tdTJAI/oHN9gz17bvQYxLr6aYkcJzaXiTYHR3SyiFMyWioPfDI
         vCItZY+P4s3Y6KzOx8pcEBOUt07eBNDFoCOQrSrZ7ItirxWRXRdVta74+88jDV8pWEMy
         FFYZyQH6OLPiwLtpQTd0isbuITqh/RO+cqSL0FdwYR54iTw7UndKBs/G+hm2tR5Zv4Be
         sBwXaAy584eXtwwE+B1Vrw3OWAGb4pT3oDnws6gwN7RiZZDgl1f9pLiSPkDLjPgdGm3J
         on7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467622; x=1723072422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm0Xwjt+29MOSwfuccAriuqumY0vc7/Lx87pSACSnGc=;
        b=IQVeyQzp5fUIwKYB8Yg9IdMkRz73g45E0Au9lv3TeL50hGQNaiYPeZZ1287ia+INdc
         2Ll7M6h+DZVvn6bBO+ccQLhmLBcDh8VEAZXBBurM9tPEgE95rUUHnzB1DRskyFnmL2GS
         FCDz+jnLrnJeTOYusuhKB8WD4SZe/CGG/y+xDM7+lc1WOQ4awdEBbWCbYIU+nML1/PfJ
         47hyNDnEVefqjE5qr5vm4Krpq0IJOOdnSWXHOlNgMPQfiE26xqMDgAjQAGw9LF/ybilc
         IgIc+agY8tXxAZk++k2YZUI4RMqWngf/DhZ+rshElJYN3ZTLluB3Sk6Fhzjtl7kawSx7
         dRrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56tatnC2zKGLwhOGBsAlL5STdQ9BScKXzNwqASjqSZVqo+4aoSRXHS+mUzfYsmCoqC3PaVxCBh6EorT6tNVt3VusfiuUPqyAAQZMJ
X-Gm-Message-State: AOJu0YxXkvvQD4s8KXhEkPVggAkoqT9LN/v2P+MBabP/hsQd0CKZ2Jfo
	0efkAbUdTM35nrQaYYV1Iq97xMkdnKUPeesFPDCy/L5FU0YumyCJ+pFjgjpAUzQ=
X-Google-Smtp-Source: AGHT+IFtA548ZKHz41CyPsrXPin66nMAe94DZLZT2aDUq+/ZTHUGdm+iBpDTOUKzJpBgPlCMMKm6xw==
X-Received: by 2002:a05:6512:3d86:b0:52e:ccf4:c222 with SMTP id 2adb3069b0e04-530b6210ef1mr134150e87.9.1722467621495;
        Wed, 31 Jul 2024 16:13:41 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530abeefd04sm671995e87.121.2024.07.31.16.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:13:41 -0700 (PDT)
Message-ID: <e306073d-b0ba-495e-a19f-d433c74f6666@linaro.org>
Date: Thu, 1 Aug 2024 02:13:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] dt-bindings: clock: qcom,sm8450-videocc: Add SM8475
 VIDEOCC bindings
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 vkoul@kernel.org, quic_jkona@quicinc.com, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org, quic_tdas@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@mainlining.org
References: <20240731175919.20333-1-danila@jiaxyga.com>
 <20240731175919.20333-8-danila@jiaxyga.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240731175919.20333-8-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 20:59, Danila Tikhonov wrote:
> Add SM8475 VIDEOCC bindings, which are simply a symlink to the SM8450
> bindings. Update the documentation with the new compatible.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml          | 2 ++
>   include/dt-bindings/clock/qcom,sm8475-videocc.h                 | 1 +
>   2 files changed, 3 insertions(+)
>   create mode 120000 include/dt-bindings/clock/qcom,sm8475-videocc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> index b2792b4bb554..9186d2ee87f8 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -16,12 +16,14 @@ description: |
>   
>     See also:
>       include/dt-bindings/clock/qcom,sm8450-videocc.h
> +    include/dt-bindings/clock/qcom,sm8475-videocc.h
>       include/dt-bindings/clock/qcom,sm8650-videocc.h

Won't be needed.

>   properties:
>     compatible:
>       enum:
>         - qcom,sm8450-videocc
> +      - qcom,sm8475-videocc
>         - qcom,sm8550-videocc
>         - qcom,sm8650-videocc
>   
> diff --git a/include/dt-bindings/clock/qcom,sm8475-videocc.h b/include/dt-bindings/clock/qcom,sm8475-videocc.h
> new file mode 120000
> index 000000000000..231cd153052c
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8475-videocc.h
> @@ -0,0 +1 @@
> +qcom,sm8450-videocc.h
> \ No newline at end of file

Please remove the added symlink.

--
Best wishes,
Vladimir

