Return-Path: <linux-kernel+bounces-221638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565890F688
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C452F28403F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D915886C;
	Wed, 19 Jun 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ju4oL1tG"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2C157A67
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823209; cv=none; b=S/9vBhrMkGL2eB42Xa5/QY4kSb6sAqoHb/XPSK0S/V7dBVU513GXLEONr1ILXl+Vqu64Ye3R8zwhGJsTUmJXHNkAiGyZhQLH+V4X+cxrcieCtOrj+rJ/877XBH3FhCasnRaYWbm2xnPIZJn51WP0ER+rb/QpowUMQXK5UOHFGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823209; c=relaxed/simple;
	bh=6ztxlcGn2AnKYupDKfTVBswsDooklpeALUwz5Hks6k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8p+jtlG3CZvzVRo/NwBaJNGvdBJzpjDtgYFgs1OdekuGuKx7sPxU7MOYJztHMAYzF7b/szzt9S5py9Dtw2cCNOmxtIoSUsRYZHUY5/djNc43eYEwGjo55uKKk5wTbaJMeY6o1ATiuuheerNZXa5541qvYlwSVNQ58232ZIEuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ju4oL1tG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so48334a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718823205; x=1719428005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7VU9/vkRDVLt9/hPKpilxcIBRsUkpFlhfPUk5mASuY=;
        b=ju4oL1tG+Q8KokKWJKgP2UH/tFWgy4Ze323w6PSgbhKNA2LGHii9nJYph1YS6w18TU
         oQHr4ZdbNlwRZlPeG9kZLUfPtwupZ42Vqjl9vLuZL7jTosKUlMoP2I5IPbCz7qzDfj79
         xba02wdRMVZ6POa4e0C16F5fm13X57gg2IqPIOHfSpIXf7g1RakrYHu0P+DaRcghsIaA
         bdJAstYpzM7S48UuPxwDiU3dN6XNWo2CY1CBPCr9VEGCV2eXCjmah6RMDRIQRngw4hKK
         qttdEGG+mSrc6GWNbYuNGTaFhaEUBiI9fYxpU87L4CxXyNEcPtzcfQ4CUD4oPK+6Gk/P
         Notg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823205; x=1719428005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7VU9/vkRDVLt9/hPKpilxcIBRsUkpFlhfPUk5mASuY=;
        b=xHy4KFHmqnvH5jnB320fwg7wqEhl7r+hA71t+7lOhwVaN2pEQUXnlnI0hPsuKNGSDF
         BZgK6RJ+09V9WF2SRC7VS3OrDABnV/Ue0bLw8BSQ9AA5TzLVm2OvUFdTBNEOcNRhMJIf
         DXnnxzZbcG1GDJZwuUBG2m/5FuRbDqcFUKiZRBI1s17lvR2t5y29y8ncvjtF79J/p+Gz
         qHqQPCLHa7CzjNpyy4Igoc3Hi8u9kAmForz+ifITab1G4DtCrWnLG3nMTzenyjqmtcuK
         zvsX0TamtWNekXniE9jyvHyKimPiMLRx3SooqLy0muW2R7Vxki8ZbLzJNjZBWc+3zxtM
         dmsg==
X-Forwarded-Encrypted: i=1; AJvYcCXMcDr61yqZ0ogNTomHWJfRyzrOggpXr6fFpUrW4SHHWDlkcxvAa6Xtb/sHyMEy3nQJEzQiithm38PVznD3+x5UGK192MleqQNSwJ+p
X-Gm-Message-State: AOJu0YxbGmfQHrEmYBxY2/rLlKOQM756o7gYPbXBUT2mwCQ521GGp6dX
	SfCOHoJoqN2kuZiooQyivqEQip04BoczuOeWmihFzAJvs1n3ONyh8yCcVaOpEPM=
X-Google-Smtp-Source: AGHT+IGEsELbvieDunRcJVYAsix732u6ngRuAFNR/W1C2IjEg6EVXJ5enNfrAmSOVV7DyNRmLm/IRA==
X-Received: by 2002:a17:907:c5cd:b0:a6f:aef4:a28 with SMTP id a640c23a62f3a-a6faef40a8emr176598266b.65.1718823204545;
        Wed, 19 Jun 2024 11:53:24 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4dba:9578:7545:6874? ([2a00:f41:9028:9df3:4dba:9578:7545:6874])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd4dsm697972266b.140.2024.06.19.11.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 11:53:24 -0700 (PDT)
Message-ID: <b8338dba-f7b7-4124-8fb3-8171284e71ce@linaro.org>
Date: Wed, 19 Jun 2024 20:53:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p-ride-r3: add new board file
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240619183255.34107-1-brgl@bgdev.pl>
 <20240619183255.34107-3-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619183255.34107-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 20:32, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Revision 3 of the sa8775p-ride board uses a different PHY for the two
> ethernet ports and supports 2.5G speed. Create a new file for the board
> reflecting the changes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/Makefile            |  1 +
>   arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts | 42 ++++++++++++++++++++
>   2 files changed, 43 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 0c1cebd16649..916fbdbf5631 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -112,6 +112,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride-r3.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-acer-aspire1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> new file mode 100644
> index 000000000000..d7f0a25c1fc4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8775p-ride.dtsi"

The board compatible (and name) should probably differ

Konrad

