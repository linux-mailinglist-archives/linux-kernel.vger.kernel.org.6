Return-Path: <linux-kernel+bounces-536803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF40A4845F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B535F3B8FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5C214222;
	Thu, 27 Feb 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MquGZGAv"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C31DE8A7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672266; cv=none; b=m1ueDQ5K5zhysX+AuNh8G20M6xwnkPlKUE0PDXUdX/LDMJl1O/49yImQfUFRwnN/R/R4aQGRwSaBvO5W84E9M6RRGjk1RyFuGrEy3zOTiqGrs0ec2HQfTyQNZQQjMHy071zXVvz9/3/zzCCKrATfPP59XA/nvS7cf0GeVQF+rI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672266; c=relaxed/simple;
	bh=oj2AG6wmmJJ4H/Q0+emx01SPXzf5eu+V/rtDZVYIAZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ed9Q1SC3tOZtCYyZL6lOLR0UuGPnMr2uJL6m90DxxrYtCBEC1MypR7jNlCo36OzXnFzVnZEEpKeZKbN1tsXR8nGTe5FIdqQGvWzXETFKbq2RibhACZzNLQWtbIpSItqzEsGcDPoxIX2iTZXdIYSqjU6xJ9YD1cBCK/mREefnb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MquGZGAv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso8280335e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672263; x=1741277063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM0jY1XZhN480IYHkyWbssi++aAJjEib+LuOsVp+WY8=;
        b=MquGZGAvNE9P7OVDTheSoHWhHot8P4rpUQQl7G80Ye5CyajCq4JI8XabeLoLjQ8GfF
         XsvxckeaTqdwwBSnqmfLyjDZ4sS6FA2GWSHAW02LPMfoopoVdAMsQNNMN6sp8G4xI8Qf
         dXjL6VFqPb+Iq4i14LfGLn1bnHaf0+nBWdD0UIEcEhm5+CweA/lFsfZSQHbqnzcYamGN
         G9Gv2gaqus7KsKYg+F68ISkMyFGoOyFObXJgp+GmbMT96PnZYCHhYbw5W4NoPKuNNrMw
         QUHLPfS/m/8PKM+pTugadzRREnS1Fdi/2PBnQfh00wKavLQuR12Sbma2i+9LMua+WrTE
         ixjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672263; x=1741277063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM0jY1XZhN480IYHkyWbssi++aAJjEib+LuOsVp+WY8=;
        b=WOwRy6eDZh6SFRgzago57nKLE8Ldl6vbcwCZsyUE2D6+siUOr+JcFv+cWVAjNOgI1g
         HiE9n37n5I8Js6RZ1gwY0ASlN7ktJf138fcFJIgHrZmj0O97g7LUv1wtaHecuCl3SlcS
         cdtMyoZ+Ised1/NWSi7tZ+hMkAGJtFyOTR6lGZUpe8NJ8RUQLHOKinXmqPW8WwqptlGb
         6RXuKqs9EWy3Phdz7aYpYi9RW2AU5bpKZtJaP01PjUU6jrVidUJoFUu/YMAkn8f2l5H5
         U2bkAf5lM6atciTV3T29XzmhOYTNCRvurH45Y8bHRVJQJrJiS9gcaK0hZan8hCkhKAbP
         CFXg==
X-Forwarded-Encrypted: i=1; AJvYcCVASSNKevAnMO6FUJjAUclHSJXp3ybo+mrI6Pb/8nbPKQY085vSQ8kK++g5HvyiwUhESzYqwQeXuH6rnJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWcifMaHTInHsH0pTI9wQkWM5VD5z7xuha/DbzIU+0a1cCdWOs
	mMdntM/vtrMRYF84HEOaNgpKkEastq04vDwvF5Wulm4aO1JtCQlNUVlF7JOOnws=
X-Gm-Gg: ASbGncuEU5wotrXbxZXTYx2qnLK7xckad2EaEi40lGT0b5DyDdXbR1kvNwBDBbuIQUt
	rAIBfndzyWREkV/1h0VoS0EWEY6rvuI5aYoTn2FHGIEXlF5CF5iZurdKs6KKUHjT0n4a/3BeAqo
	+DzPhuaRPNEvyUXsqwkkMNQRBA6zX1ySc/ybYj/Gd5toKP4n+YDOopCb9w4eq19bU/5RHdZHZx0
	pw6ozSfW827a4ObBqXLJ749VH2VFHRkazucQ77FsdkWHZlXNL9NlwCSj3c8j5kxMUx/amzNtcPQ
	F2OwgLHxFKkZNCDNP/rE+jJfHYG6ku3HKOrfvBtK29W6JNzzxRffDAnrRB8Ym6EpC0o=
X-Google-Smtp-Source: AGHT+IEMGGewvd19qcjVCxmDcaVHNgbW+bq4SLc6gp2SqfT581QltbD0gE6bwBqjd++WCoSBmbQquA==
X-Received: by 2002:a05:600c:1989:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43ab0f4271cmr128329665e9.16.1740672262881;
        Thu, 27 Feb 2025 08:04:22 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73718de4sm28728855e9.23.2025.02.27.08.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:04:21 -0800 (PST)
Message-ID: <8e778221-bec2-437f-b51a-b665ad2ed405@linaro.org>
Date: Thu, 27 Feb 2025 16:04:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom:
 sdm845-db845c-navigation-mezzanine: Drop CMA heap
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227-qcom-nonroot-overlays-v2-0-bde44f708cbe@trvn.ru>
 <20250227-qcom-nonroot-overlays-v2-2-bde44f708cbe@trvn.ru>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250227-qcom-nonroot-overlays-v2-2-bde44f708cbe@trvn.ru>
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
> This reverts commit d40fd02c1faf8faad57a7579b573bc5be51faabe.
> 
> Fixes: d40fd02c1faf ("arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Add cma heap for libcamera softisp support")
> Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   .../boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso     | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> index 59970082da45203311146cc5249298f6188bf67a..51f1a4883ab8f0ee7c66fab89c6e1a88c868d2f8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
> @@ -9,17 +9,6 @@
>   #include <dt-bindings/clock/qcom,camcc-sdm845.h>
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
>   &camss {
>   	vdda-phy-supply = <&vreg_l1a_0p875>;
>   	vdda-pll-supply = <&vreg_l26a_1p2>;
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

