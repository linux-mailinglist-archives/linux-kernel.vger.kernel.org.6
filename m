Return-Path: <linux-kernel+bounces-324790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C49750E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8121F24E56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0C187327;
	Wed, 11 Sep 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFkpp55J"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2D187329
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054406; cv=none; b=NuZ8NKIKIz5EIYOTzv4h1QjPfhER1nbmUyV3H/D7Y5mYAN4bH7aNABwzcMrm2gK0CL4E956cJeW7jAMNA9KpFRad57PNStW23ftMsnVWZFetzVXg1F09jjOQhYkI2bhSViM5I31EpsISEg8nSza/rppjqVK1vH3tQTBjA/95gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054406; c=relaxed/simple;
	bh=cM9An+lJrKf5fchTezFQIl5Mxbf04kjvGjWZErkcecY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNzXnaqHCsblSf9b7gicSYQgIQJUWvRNEvrgWFhSX8ks+s5tRJW7d86HkVM9cICMvRnVnUdtTVy9LXS1Y0R4RP9iS2dy8H+OIvxjQpbzC7v10Nx6SxzxDW2xVnX4nEobZYmhvwUQkA797Tk9kKdWGe4710v5gXSBDjXo8KA/qEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFkpp55J; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53659c8d688so707825e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726054402; x=1726659202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0GzAnTjhxYZKHt72GpqMtlHwxT7ETsaEqcjwqFxbdI=;
        b=WFkpp55JtRzZOjAB/GYZzI/AAXoxYIdt5n7QKwndZHxWfIeb1swPv2Kx2JZzXojZSz
         kuCDx+aZXjS5MdCh7FOKdRJGjoPH2CS6RoEk0UHhiKXhkhdAdIp6jGTv484CasUdkxsu
         zC7jq+BNtr1pzEU9N71x1bdyICea94x//A92vVP4TI/hOxeA+3gDTziTPeWkNcKdSlBj
         UuTF+7X9zO7fw55Fj7n157U35txDj2tP+4MfbapIbTqe1R+Qdo+Ol6bzwg4vK7zDMTLA
         n96pt15m4K1eV0UDIs3GICG3TO/TKsW2BTCyDNsQpd+eCe7wciEAewHtTCoVEGstfwlP
         QWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726054402; x=1726659202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0GzAnTjhxYZKHt72GpqMtlHwxT7ETsaEqcjwqFxbdI=;
        b=YBZkWgnCmvu0Z1bpFb4hkwAkepBAmAqNa6P1yRV1Tv2kr0VFiKJIXIO7eg8Qhj59dM
         fkFHPjsXIM3DpGsLwJKp+cu2MEiThM+uR9eUkEmv+1ucYdNxDZft9/zhdLOZSO1yjzOY
         Fw4Qk+FGgZcUm1wnVT1Kv5uGmemQzSq6QH+2pj5WnTJ/YPtdVpgwRCttZGutI5IOviaC
         oAp4Ae1hHzJTDySl49dTyeJ+z5f76oIUAtPWbAnunOtvXnfzYZsQzHEzT4vw702bWGEz
         /XM60jiOcoOXw7dA/6N/cg63WGhcrzXIzRzikTN5XpE3hy0io+ZzImj2Q/HLO5coiTP3
         lDmA==
X-Forwarded-Encrypted: i=1; AJvYcCVHlSfStzQE9kU4PxCsuX2IECCwZQqGEL41cbubWU81ffaoyAjv8+UEzdEbSJCCYZjfDmSUuLjIeyvwC4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR6tOwEsHfSZZjjm4p722YakVVnn1q6hwS6tVc1TRFd3L13oaU
	Ng8bjWyxe/8GbdtdQ0ADqlKybEvPTSlZO1YBTJIMyZcTBGjRnogSFPU1D3ltyA0=
X-Google-Smtp-Source: AGHT+IGJTJ4gfvXWiLZYGJnjq1U6O/nKro6eMFZ5KwjhG3ZDqLoxi5tKw42KVzSzIJdS3EXUUs0o+g==
X-Received: by 2002:a05:6512:2250:b0:52f:cf2d:a1a0 with SMTP id 2adb3069b0e04-5366bb48a71mr2373288e87.26.1726054402046;
        Wed, 11 Sep 2024 04:33:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cad44sm1548242e87.150.2024.09.11.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:33:21 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:33:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, 
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com, 
	kernel@quicinc.com, quic_pkumpatl@quicinc.com
Subject: Re: [PATCH v1 1/4] ASoC: dt-bindings: wcd938x-sdw: Add static
 channel mapping support
Message-ID: <iv2ajlr4qe7lcfwd7vwqsghxprpqz6r2nrvgmqmg6ryscgslqs@zb5nsyavuzej>
References: <20240909105547.2691015-1-quic_mohs@quicinc.com>
 <20240909105547.2691015-2-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909105547.2691015-2-quic_mohs@quicinc.com>

On Mon, Sep 09, 2024 at 04:25:44PM GMT, Mohammad Rafi Shaik wrote:
> Add static channel mapping between master and slave rx/tx ports.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../bindings/sound/qcom,wcd937x-sdw.yaml      | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> index d3cf8f59cb23..1db3c001ce98 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
> @@ -58,6 +58,30 @@ properties:
>      items:
>        enum: [1, 2, 3, 4, 5]
>  
> +  qcom,tx-channel-mapping:
> +    description: |
> +      Specifies static channel mapping between slave and master tx port
> +      channels.
> +      In the order of slave port channels which is adc1, adc2, adc3, adc4,
> +      dmic0, dmic1, mbhc, dmic2, dmic3, dmci4, dmic5, dmic6, dmic7.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 8
> +    maxItems: 13
> +    items:
> +      enum: [1, 2, 4, 8]
> +
> +  qcom,rx-channel-mapping:
> +    description: |
> +      Specifies static channels mapping between slave and master rx port
> +      channels.
> +      In the order of slave port channels, which is
> +      hph_l, hph_r, clsh, comp_l, comp_r, lo, dsd_r, dsd_l.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 8
> +    maxItems: 8
> +    items:
> +      enum: [1, 2, 4, 8]

Can we please use sensible strings instead of a randomly-looking numbers?

> +
>  required:
>    - compatible
>    - reg
> @@ -74,6 +98,8 @@ examples:
>              compatible = "sdw20217010a00";
>              reg = <0 4>;
>              qcom,rx-port-mapping = <1 2 3 4 5>;
> +            qcom,rx-channel-mapping =  /bits/ 8 <0x01 0x02 0x01 0x01 0x02
> +                                                 0x01 0x01 0x02>;
>          };
>      };
>  
> @@ -85,6 +111,8 @@ examples:
>              compatible = "sdw20217010a00";
>              reg = <0 3>;
>              qcom,tx-port-mapping = <2 2 3 4>;
> +            qcom,tx-channel-mapping = /bits/ 8 <0x01 0x02 0x01 0x01 0x02 0x04
> +                                                0x04 0x08 0x01 0x02 0x04 0x8>;
>          };
>      };
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

