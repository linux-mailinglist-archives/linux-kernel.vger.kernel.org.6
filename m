Return-Path: <linux-kernel+bounces-546001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1EA4F50A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14401885AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4E1624CF;
	Wed,  5 Mar 2025 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhfcpH3D"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260415CD4A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143598; cv=none; b=T5UCm76X9JzKgF2UzTsSaVTd2Oi9r0ckRD9VWDNwA9vVYIk6DQOfrBiKMJVtv3RlICKX/ewf4r3qsWgYkqE/MwnkdhxRRlUFDqO3YkCuL5Pex33s8SOS/kg4MtwUw9N8iWQf4AjwL3knv7jmloLXWVWJ1PrUIjt2oNVKdcmlDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143598; c=relaxed/simple;
	bh=mPfqHmUHSKSQaPUHjpb/9HaN5cORCw2qlntCpea6OSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHPZim4SOnSWjyGyqw0Ffz4GfBZ/0dVmxAgrYRSadLd3UKc14Rh6qSYbK6f+YJGEMeSku3cCHvSmkdNtbJxFKEGbTNBVO+snGy5ox1W5rR3vIJV/e2OLdqifc6IbzeOzImFx0OBxJL+srWkX5u4RnnqVk6yX/m+IVZt+7QTWr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hhfcpH3D; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54958009d4dso4146328e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741143593; x=1741748393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJvKJ68rlC+sLGTBZdabg/gqDqFQctmrcG+n8a+ztWA=;
        b=hhfcpH3DgQDHlNmLDjqVdm7pv7/hbZyVaAikr+HqQjlP2ZoLaXUf18cpGQerOi0QN9
         rore8oT+1oDsxSwkjZAaKEMyrjAUQrQYvYphBj8GR56FIo/i9hR847DWKW4K31QWh679
         n7bcbLXWNakusR1jNmx4tMDsQuJn4UIraeraHt2wJ/JGvstLOPs7ra6F9L4HwWL4Ve1c
         ncoI+AWZSxl0xYw6emH1iqCPWax4Q6iDaCYLyuMi82i+8a8Z/cgvKuj9eniLF2YygUmU
         ee21AaQnfD9H88fkOA413xZg0K66ZuADh/4YjfLt6hRHOaa9ULx1qlh0LCSSPhRKquI2
         jNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143593; x=1741748393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJvKJ68rlC+sLGTBZdabg/gqDqFQctmrcG+n8a+ztWA=;
        b=gCg7YF8BcaCk8M3ZYd3o2fPihi5OnTkhNBF55dhffdllCw9okOH+MxSgH5ybjAjeQZ
         G3VSmbQ71m2i0lHyYwJEU+tWfhOLL8bmm1n9eGlrQ2+b0b5qpRHRJEz+4kgZTDvV0eai
         WGEk3GB4FjcxB3HDQbvnc5cHCRyXMpM8h1v/PG4gDKVXRTte+LY00qEbCMeIXCi7bTJ1
         tRzdQri6/G7q7DxUKnasJkmSgx2qQ4Y/UtvzR01hYmDXYzltxAvo/GiqDg2Fg1vkU72m
         hrb3/4POP5YhGLHDLHbBtyveYkiWLoT2/7Uunb/ZmpOVTe7oZGxqfOpoLusCJMlFUkZU
         9Nnw==
X-Forwarded-Encrypted: i=1; AJvYcCUloLtfRNZ8hg+gb1KN8HjD0nabszf2EXSGxjs4cdsa95ThV8k/zJIqsBn2lRP2Kyix84w1loBGwSm6WxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgWEtjIJV2ZdQ45KMWrKXCqkZrPxUo8YXDLhTmV//7/TpkoSU
	dmI8Y3t1V31BYwGQz4ayAnyxN0pXEISUhepVhtj5zn9Qnx2+60r7jw4zh373xio=
X-Gm-Gg: ASbGncvKCDjxsGoOJN9+uGZRxU8syi2txx8OjKEc3u5BfAxi1xwIVj1BB56Ajw0VdXj
	GfTpimGm2SBGe15g4yKH8CPPKMBOeZpACGUuZUUWOAbDhBmORyznPxJ14IjSzH7/dFF66N1vBlq
	5o75JXTOh9bl/t44gbyxAS68iXEU1ajZRL3g/4ZsHaXgaDKh9vVTX+TMkIe5zQzAawmTv4O+GPF
	6opGqQ5j32Q2K4WgRsoLFIunPlBBPO1tTMAyjpxDTTXd64hSRB4nBhMAQ4V1svABFVIdQre/34w
	OUc38pDTUfhV/x4hHir9eQwKdPeXoLh+jSob59chxRQO0SZ8T2XR5z0HdE7OANWApV19ZtNVb4r
	lCECK2KvmoUmjVtbmuG4YhEC3
X-Google-Smtp-Source: AGHT+IGkLyEj88NKFgMk5Dc/qcrMMu5c5mz/edvqKr7cxRFirThc+Fkx33VXvY/6F71lJ9O4B98xLQ==
X-Received: by 2002:a05:6512:ac7:b0:549:39ca:13fc with SMTP id 2adb3069b0e04-5497d382f6bmr469921e87.49.1741143592852;
        Tue, 04 Mar 2025 18:59:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54962415d13sm925305e87.257.2025.03.04.18.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:59:51 -0800 (PST)
Date: Wed, 5 Mar 2025 04:59:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 9/9] arm64: defconfig: Add M31 eUSB2 PHY config
Message-ID: <xgryihmtcbvhimm4fr2pcrhjcwdp6djfrgtwj4a5kl4tukeavb@de5irgx54w5p>
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-9-a698a2e68e06@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-sm8750_usb_master-v2-9-a698a2e68e06@quicinc.com>

On Tue, Mar 04, 2025 at 01:56:42PM -0800, Melody Olvera wrote:
> Add configs for the M31 eUSB2 PHY for SM8750 USB.

Please use git log on the defconfig to check what is usually required
from the commit messages. The defconfig is not Qcom-specific so you can
not expect somebody to know what is SM8750 or why does it require a PHY.

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 3a3706db29822036d25a7228f8936e2ad613b208..7a7187475a11206e708a5a2c6dd51736e16932e9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1587,6 +1587,7 @@ CONFIG_PHY_QCOM_QUSB2=m
>  CONFIG_PHY_QCOM_SNPS_EUSB2=m
>  CONFIG_PHY_QCOM_EUSB2_REPEATER=m
>  CONFIG_PHY_QCOM_M31_USB=m
> +CONFIG_PHY_QCOM_M31_EUSB=m
>  CONFIG_PHY_QCOM_USB_HS=m
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
>  CONFIG_PHY_QCOM_USB_HS_28NM=m
> 
> -- 
> 2.46.1
> 

-- 
With best wishes
Dmitry

