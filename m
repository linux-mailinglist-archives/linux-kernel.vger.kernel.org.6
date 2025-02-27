Return-Path: <linux-kernel+bounces-536802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CDDA4845C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD61F3AACDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5369A1DE2A7;
	Thu, 27 Feb 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koQKNspj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAB1DDC0B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672250; cv=none; b=cZMrs6LMLikfWGkgbX59UMgjciVdo5sMFF57I6P/XIuvjPkww8GISuXifX/GUW6/TkLM7/Ye61huQUM1exe82t1v83qDDeIdH5En/Z8TkutgdKF+G5/0CyBtXL8vc/6SrL4mH134+gIlOUO8nMPVvSZpS1PrXw60IjU/UGpn/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672250; c=relaxed/simple;
	bh=tyjvAD+adDTd//PDrw1nlWoUz+V/OCQOULIAUJl5qMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHVoJSPu//OGej/dz21WFtSDs8RpAzOHHJmD470Rvr+d8bZD/BwePrcwXPwDJvd4ytWJVgHUvwnhOJ7ww/02eYvWuc9RTlyNmlN9xi5qecsA2EmP4JfsHch4EU6x7p2RXOls9JdrQb96zqUDZtsgCe8oervzpxGJw4cT69+zwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=koQKNspj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43996e95114so8239005e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672247; x=1741277047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvIn24tYLHOsgb21p347DIWtQWK0Ha6hvZuB/OU8gA0=;
        b=koQKNspjSWudfG9DJfPwlQQTnrc2AX/QdoVrNc67zuepx4saVwpGStrcGd9e6CCsaM
         3xyre+69JFtI606iHO9Vn0ipMjdFVrOuxAy55K9SWwlf5ZF6vuU0SMkRhw42pMd5Of9e
         n8YMafu+0x1ARUzQHMgqB/n4p+VSwBzGg3FeT7wQv+5WYZJY/D/ylEwhQBjbaj263Z2a
         Xu8QPf9pOF15K5kbGAGLdOOVA/xZVLykYEysF5R4L0qMuBNACCAg6s8z3xsLR9G3afJX
         M1PQ5oaMO2zuCLtnJAyNnVZ/UOet18YKA2ydy9rP3A3Y5xigwwUWM+Q+RZweVqxa+0Pp
         ybaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672247; x=1741277047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvIn24tYLHOsgb21p347DIWtQWK0Ha6hvZuB/OU8gA0=;
        b=Z0pb709bB+s0npuXSYjRwzLj636P7Dm4JSv/iUuizinAAO/B7pB6bqlyIb+33kHI67
         NsXBtPht84zZl0HLpCUcugy5aVH7ypFDHyctIO210NTU1rSOS0ffrLoDhQhDZm8y4Qf3
         jja8VrJNw3uLIOBOlgQV8CFDV20eAazAzcUcoLlxYgZ3tN8WT2luIOl1tlCl78V3vfz7
         bbOdJu+Ya+pYCBSac1jdOwxxcjFI63HB+/8I7VnWGX5vjTsu9qR6Vl1YGC84mnOJ0v6x
         Uh91HsG4XKkMjs6O+HMyk4BXUp1xoolv/kHjMkax8oZbHWgaWpY6hxklm/n8lIHnWI/f
         lEBg==
X-Forwarded-Encrypted: i=1; AJvYcCVKjnNoMsfkpg51VY306JOp7062f8K2D3YUY5KjIpksel0mokTmMEmBXhN/UDXKfH3vHzZIHjKNY0di4AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4ZuhIWbFJKo1Wu65KYbSO2sPiJT+QnRYtozFSi3CPGG4LUUY
	Iu3ua8O7waVhsqRoG2gJJKBgms5w7zsDgcTa21FtmpN0RCzRcaHD9PPnOk0pHE0=
X-Gm-Gg: ASbGncv1dXfxydrBFQsegtXz/8JnfHcw+6NHxXgdALrh+zPPBFLd173fR1azXjKhBnC
	PCywERyj5ygLqI0vC6JX5jKo4KSX/nuydYiXFr3WHlOlZ711yDpYtK7P8RLCNaMjb/4YtxOTqyQ
	AkHCsqyECKjlx5pAFfu9vP9l8s5S42dtA0oUzLfVIp0E3KkdmbrZTtEIElRSUBBi9+XPL913IZM
	1EW3t3/EtGEzPT1bVrzco93/zmVu4vXTIhM9dFtEWhLWLoaXKAsmZkemDR1XKaYi3LtX8Qzd3J3
	hqo1otePtOZMXhUHyDkNVIZlQMeH6FGoLEQFzXMIJegtYHMuzx6RDjTPFFSGKfy2MXw=
X-Google-Smtp-Source: AGHT+IE3Ip9lM9pQRwKTBvY/WeuCuU31LF5zKSLs2OxofNzgwY3TCLJUZhTWGYeeFNNIo1VpBFTuBg==
X-Received: by 2002:a05:600c:1c1d:b0:439:9496:181c with SMTP id 5b1f17b1804b1-439aebdc9e1mr215296025e9.29.1740672246975;
        Thu, 27 Feb 2025 08:04:06 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27b27bsm27022515e9.31.2025.02.27.08.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:04:06 -0800 (PST)
Message-ID: <96208c2e-f38f-4d1b-aa6f-0b774359c2cf@linaro.org>
Date: Thu, 27 Feb 2025 16:04:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qrb5165-rb5-vision-mezzanine:
 Drop CMA heap
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227-qcom-nonroot-overlays-v2-0-bde44f708cbe@trvn.ru>
 <20250227-qcom-nonroot-overlays-v2-1-bde44f708cbe@trvn.ru>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250227-qcom-nonroot-overlays-v2-1-bde44f708cbe@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2025 14:26, Nikita Travkin wrote:
> Initially added, the cma heap was supposed to help with libcamera swisp,
> however a mistake was made such that the node was never applied as part
> of the overlay since the change was added to the overlay root ("/") and
> not with a reference to the target dtb root ("&{/}"). Moveover libcamera
> doesn't require CMA heap on Qualcomm platforms anymore as it can now use
> UDMA buffers instead.
> 
> Drop the CMA heap node. This change has no effect on the final dtb.
> 
> This reverts commit 99d557cfe4fcf89664762796678e26009aa3bdd9.
> 
> Fixes: 99d557cfe4fc ("arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Add cma heap for libcamera softisp support")
> Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
> index ae256c713a36078afdadc67193f381a19ea8e5d3..5fe331923dd3cd31ff2be047a2228e1c4104e80e 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso
> @@ -9,17 +9,6 @@
>   #include <dt-bindings/clock/qcom,camcc-sm8250.h>
>   #include <dt-bindings/gpio/gpio.h>
>   
> -/ {
> -	reserved-memory {
> -		linux,cma {
> -			compatible = "shared-dma-pool";
> -			size = <0x0 0x8000000>;
> -			reusable;
> -			linux,cma-default;
> -		};
> -	};
> -};
> -
>   &camcc {
>   	status = "okay";
>   };
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

