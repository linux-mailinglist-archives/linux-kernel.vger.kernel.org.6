Return-Path: <linux-kernel+bounces-537847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA1A491C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00C816EE08
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B10C1C54BF;
	Fri, 28 Feb 2025 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAFB7OzH"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D3139E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740725103; cv=none; b=sRhjN4XON7qQYd7fEeQsqx/s/F+IWXXk5NypQ3qBvxEvYP+DcDcFxFbJKfQaURwyq/HVLyYxD1qDGx18MNHoYJsrJl48wGoKzkw+rV45iPnAybd/F+1cz4cEyVlyHDIPfK4y9sYXRkZsmQPdegsvrBIcpdFBHRwda7bGoFy3Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740725103; c=relaxed/simple;
	bh=rzzgHjFp/+vBOUdP1pb2/or/MU6AFe3iVEVOCf2GZOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl6r52B50uGlTBRBfi1gsR4WPrGbpPnngAlaYdBkq0FjLOJGfjCbFC99Amoy7XqM9zsUr8CZk3lq8sI8bU3/aey9Z7Pgh8tkMuG9xCl1Prsd7eUiDvx9hK+0PWohiNPtqaxQxnwyRgu905W84rLrgEBpEu3yGrpDxs/fNd5L3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GAFB7OzH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5494bc4d741so833035e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740725100; x=1741329900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UwWIKz2ocQO8lKlTLMYiX1hlEMOEiYylG9oMJg+Rd0=;
        b=GAFB7OzHTJ1W8rAn8PO0VF3TnQ6AuWrZ671ZpEUl2y3mdn9ZigfbJ86vrQPyrtdAH0
         STbtDPs1mE2v1hYbsPJ94jCpVerSL+GZA72DtNAeUBTYdg9lG76iFX65CwYOmamOOeAV
         1uHL3A03f57UL1GJg2EXX9tF7mI+6MIJVdumxIAmGsGHp9EiV7DhUH0rro8M/S+/v61F
         lu9soUhEuW/kee9mDEK8229o0oxp2/ceF843iznz+vrGST1Sgr0DqYbREdYUAUrLI+kq
         O87pLrfrJZoZpcx+doGFJwJMuTnxs81d2KXz/Mh3Yke0V9BoFPvDfZwwN0IvCm4+0Pmj
         BU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740725100; x=1741329900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UwWIKz2ocQO8lKlTLMYiX1hlEMOEiYylG9oMJg+Rd0=;
        b=IWYVqYEJI1uru9p1Ah71ZlqOcSCcNF59vn8P/HaL74WBOFodMof6a7Km9hdlnOEj9J
         Z1omtxKBM9aM6VVlYdDDgFxyU6wX3Nf1RTu4Ahb7qdZXcydSCB+zyJUhZEb1MZaqMkLz
         d0pi+22gXX9Y/QfkRuaqDQXxH7x4iPq/nCyRkl6ls6E6qu0SJOUEGLEEdHcaXourxyqZ
         3650kwXE16eRGZWuCnTJNEGKbhMejaVeRcK5rpC/jLqR7imdT1+tEvzEavIJptty78n3
         0iBg0zT5x7Zhw8+1kDR1cGT9s4h6jtfO4zODXG/4iU3XyLsYRWYVx+qRfEUp7gUwXXYx
         z/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUH0tb46Bl4XybpI7vWni2QQuGLPrYtR7mdkMDJ8tW+K/q1AnY7kFbCUcqL7vKuwYhK0M/of3XQMwyxbyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgpKAgq1guKg4a+biJnJBwGsEtBVZeT2OoUwKwLsu/aEvDQef
	C4Rlv/PTPZoSoqXU8ezYUfTznYA15J2EtBcaMHp24rX7yRxerqfOnSLPyWLDyJg=
X-Gm-Gg: ASbGncvAQIvHe2TAozqb3FJYB2w8OpSlbykJKCggtKGRcT1atMDqZEScf/QPsV2ZBxE
	Y/9ngGo/XgQDz5EHqX6oMPmilJSLWGdK51vaHq2LT4MRYk6hu21pTKUpdVA1AHDFXZm9emYrlvY
	4fPwjjishoWd5K6BAoQH2prqTTYod+I33YkjS5GqPGvLBSLw32P3tBlq5srXT8OCmgsFyCYX2T5
	vUEvyGzuR2nO9FNew9zEuPs471Lz/9IznG7Ltfqq8nKm26VKrY7CrILIr/Bqcv4DTzAYo/6PRcl
	icJgaLpiTvpjByzvCldh2aNNjbmBdPLTnjYCMSWgR4YNNaLRKwoeByTlRGKGHn55VEbeqf6921I
	1+MgTPQ==
X-Google-Smtp-Source: AGHT+IHDB8fBe378tsuV5Q4vwcGascJZUy+amYGeXzsNguWtg8036c86qjE7FSNVxZDOzRfFY6BYFw==
X-Received: by 2002:a05:6512:114b:b0:545:d72:95e5 with SMTP id 2adb3069b0e04-5494c107c7emr1034250e87.7.1740725100131;
        Thu, 27 Feb 2025 22:45:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417b853sm385815e87.102.2025.02.27.22.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:44:58 -0800 (PST)
Date: Fri, 28 Feb 2025 08:44:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable DRM_DISPLAY_CONNECTOR as a
 module
Message-ID: <nzv5wokyetzltnmuuufehdztreorhd5s426fs63shrolr7b57q@fyswxst5u2ay>
References: <20250214-arm64-display-connector-v1-1-306bca76316e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-arm64-display-connector-v1-1-306bca76316e@linaro.org>

On Fri, Feb 14, 2025 at 04:57:11PM +0200, Dmitry Baryshkov wrote:
> The display connector family of bridges is used on a plenty of ARM64
> platforms (including, but not being limited to several Qualcomm Robotics
> and Dragonboard platforms). It doesn't make sense for the DRM drivers to
> select the driver, so select it via the defconfig.

Gracious ping. Bjorn, could you possibly pick it up, as it affects
Qualcomm platforms?

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index cb7da44155999b59aff95966f4cdc9107f2af46a..dfcc754962f7a40377d1f8e0f16983af5ace28f4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -911,6 +911,7 @@ CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
>  CONFIG_DRM_PANEL_SITRONIX_ST7703=m
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
> +CONFIG_DRM_DISPLAY_CONNECTOR=m
>  CONFIG_DRM_FSL_LDB=m
>  CONFIG_DRM_ITE_IT6263=m
>  CONFIG_DRM_LONTIUM_LT8912B=m
> 
> ---
> base-commit: ed58d103e6da15a442ff87567898768dc3a66987
> change-id: 20250214-arm64-display-connector-c1c1569f9799
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

