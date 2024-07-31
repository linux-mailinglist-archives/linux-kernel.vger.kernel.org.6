Return-Path: <linux-kernel+bounces-269959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73A94394D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6F41C2130C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808B16D9D8;
	Wed, 31 Jul 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlCGFgbQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D116D9CC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467658; cv=none; b=NSRPfoggS203rdoopC42rh32LiujkIzbyn1x+4X6gIi7R+z50UQfSHz05GhmZkn7nB4BIhc0Sy9xrP8jZuWysBGi4gX7r/cpF+6Gcz1ndevMmwmw8G1tJzOg5h9h/r3To3WFuaH2m4fn4itTGTg9didN5RTq2fzbSY6z0YnrBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467658; c=relaxed/simple;
	bh=DPiJW5NDDeSxy3mCpzAv8g5OyaHdfPhJ4OV9wn1T6n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joIt46OlI49I6kVfCIV42cTpLxXvAPi6+DfbhWDtL3+ymSHc0IId2o2vfV9eqHOh7NVCEMMVnnD57ESgVJlslD2Tswm3MRLs64JkJxVAxfoJ3MM1M3D6ZdpwFFjTJXxrKF1DrwO6P2OXNbfxFTsQh7UpbV+Fg5s7KaDR8DMHxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tlCGFgbQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef20c3821cso12293091fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722467655; x=1723072455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVIkEiUFmcZTwfLHh9VWjF1Hcgwt0wWahOboNMKilr4=;
        b=tlCGFgbQTUOOrOgKtFLianXD7V1/4YpHi+iZz6g0n0H6w7ltmPKn97Iio3ioUY6vIT
         +g8ePpMGUie6vaQJoOTNmHhN40HLCBsA2hbgRHEPkse4r6pST9SZPRL7vNjW1lBVI06M
         V5snSYkCFI91T3moajxvw4EBO2X/dXEna0ivSFVkdEZi7QX9ZWexSwYAxe/mQDkfMTnF
         lOHzvKIpQ+irPFQCc54HU9s4IJuIwayE0taH3O0V6u/ahHxizBgeNzkmzw9Dx9798EFz
         v4bHB6t0Y1UuZCUGcGIRVzuaEIKCc7Wr/PKW9ntmyaoZaC9hlXM+8rlqKq5SIrEOdG8M
         3RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467655; x=1723072455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVIkEiUFmcZTwfLHh9VWjF1Hcgwt0wWahOboNMKilr4=;
        b=EoyMluC/1sSjqpgHs2fJGC6kgg3QFF4OLIvN0+PUOh7K3yMDzX0AeYeZ5ZVmt/n+1B
         KBAZXciRfhGwlIs508ZIJi/EFKW+5ZhKt01c06UAmw/aCEOND3/nfAOO/KLsuQV82Bt0
         LcXQVRC0QHkTpwc9M0yzK/6StI28resmuwPpKRRQktfhne6n2H3G9TFcpGHf2id+Rnl+
         qxeRLPVqPrmaSPGJt5uZr8hzNVeaoeX4jpZnCtM/ztuQtCODVkvJBTQP8GtcV+oKtJrl
         uvGcRZTcXCLb9jjA/MTBdpFLQ4rOIdLPEe+0DVZn7uMhRPTk0GV/0QNvzcHlKE0B2LNo
         8NUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPedi6fUmQpW0E4+cYUDk+JRD4tioHeIxWW+E5WwgCwvz9de53wo012UkS+I/tnfUcF1tdPOmGYBCqPxC8DG4Tz1OwRFV9SWRmR3r5
X-Gm-Message-State: AOJu0Yw9HVOyBfFPT/U/N6qDU8q6ndXB85UYWiuYNWh9MRoIn8tatIWS
	cVfLl2mOpHI7yDwJON247TyjrywGBhuI0KDJQ7f8Gnjq0p70O5FkmmHuVOS0Hgk=
X-Google-Smtp-Source: AGHT+IHOKjhruKtYSCVFydIC4h7W2fXEpXqqwH79gYTayKHSYhc6hJN7Eni8LmzhzkPjTEvMQZg+qQ==
X-Received: by 2002:a05:6512:39cb:b0:52f:c22f:32a4 with SMTP id 2adb3069b0e04-530b61f7818mr142469e87.6.1722467654641;
        Wed, 31 Jul 2024 16:14:14 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530abeefd04sm671995e87.121.2024.07.31.16.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:14:14 -0700 (PDT)
Message-ID: <590f4fec-24ef-4a1b-b1c5-eea67ec04def@linaro.org>
Date: Thu, 1 Aug 2024 02:14:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] dt-bindings: clock: qcom,sm8450-camcc: Add SM8475
 CAMCC bindings
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
 <20240731175919.20333-10-danila@jiaxyga.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240731175919.20333-10-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 20:59, Danila Tikhonov wrote:
> Add SM8475 CAMCC bindings, which are simply a symlink to the SM8450
> bindings. Update the documentation with the new compatible.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 2 ++
>   include/dt-bindings/clock/qcom,sm8475-camcc.h                  | 1 +
>   2 files changed, 3 insertions(+)
>   create mode 120000 include/dt-bindings/clock/qcom,sm8475-camcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index f58edfc10f4c..2dea246882c3 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -17,6 +17,7 @@ description: |
>     See also:
>       include/dt-bindings/clock/qcom,sc8280xp-camcc.h
>       include/dt-bindings/clock/qcom,sm8450-camcc.h
> +    include/dt-bindings/clock/qcom,sm8475-camcc.h

This change won't be needed.

>       include/dt-bindings/clock/qcom,sm8550-camcc.h
>       include/dt-bindings/clock/qcom,sm8650-camcc.h
>       include/dt-bindings/clock/qcom,x1e80100-camcc.h
> @@ -29,6 +30,7 @@ properties:
>       enum:
>         - qcom,sc8280xp-camcc
>         - qcom,sm8450-camcc
> +      - qcom,sm8475-camcc
>         - qcom,sm8550-camcc
>         - qcom,sm8650-camcc
>         - qcom,x1e80100-camcc
> diff --git a/include/dt-bindings/clock/qcom,sm8475-camcc.h b/include/dt-bindings/clock/qcom,sm8475-camcc.h
> new file mode 120000
> index 000000000000..45444160d465
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8475-camcc.h
> @@ -0,0 +1 @@
> +qcom,sm8450-camcc.h
> \ No newline at end of file

Please remove the added symlink.

--
Best wishes,
Vladimir

