Return-Path: <linux-kernel+bounces-550494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F010A56053
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B61897B38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881819ABAC;
	Fri,  7 Mar 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWxqQWM6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3E192D76
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326545; cv=none; b=iFN3iJqC5LEYucOKOV2L8tlMF+2D5jqljIF/G8ugwHfBwbUuMjg8wL3mpeDVlprBNquBesEiK0iy5Mhxu9hSKxUMFu/UzCp7rqo1FjlmdWGvaaonnQ6cElm/g8HQM912I4v5klMU/nAsCAWcNzwY0be5FiA7MPavzSEwPF6X8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326545; c=relaxed/simple;
	bh=cqj6ewJym1miHgUZm8iH3RiovqQFuy/3bRNULbbMasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUBhq4ev0uP2Ga91nlk1WxgTtkNolbZruP7vqO3pZfkP19Sx+YW9TdA7gL80yERGh4cArpJ2YSh+zXJCxW7u87gAyiV1fb1DKN9QOBAmhD9f9RDRPaqUwxgoQjyQUH4UqgdtSIJJo9n3BMjY8uIxktX1qu0hTxfQDjCAeO7pYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWxqQWM6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fcfso16154661fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326542; x=1741931342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddZoIefzqan5unLa1d6QbkepNMobkeXSFMsHFbEyBPg=;
        b=NWxqQWM6YG8OVHHmKHX7IVQHC7xeBlj51ltje4EYuxLu5RzF5furpRRIWYpbCzeOmg
         9x41xRCNLY30pvK05qs9XuhqdtgWukdb8uVR6zdYPz/Il3R4zzSzzypLiIiE5zKNUxRS
         j1SyRkoExLEblfB/2WHoQe8o8b8sBmYJcy2UCdXULTEOKYLewZOqV1piigT7VrDVXZ51
         JaYJ+BnCSdhwabeuinA8y/JV0VDr1Own2VmF6/eowK9w01JxgIvffOwraixjsuE4Yx0E
         mWsfrXDscjYYvkxZsnyR9q8GE3WuNyLCxxhaI9cOmmxUF707shkEVDtbKpJUhrnevUEK
         CR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326542; x=1741931342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddZoIefzqan5unLa1d6QbkepNMobkeXSFMsHFbEyBPg=;
        b=SL8Dm7IxYeZnQz45omyY1y7Ck/n+REnkQMS7AIrp74RTNnap4qGWbVRJozOzxqv/2J
         Cn89FKMrqIcZwLhNHW6KvJ4AMvg2LubXtPMtoApCsZujxGk9KNhQQ1IZzJ6yD5Y9ByJM
         tXZ1J1puv4cvxLkqfpt+QmxtMbAVQGTUrIWh1RqI1EUgKeMjC1rZuBVeLLGoiwaZIgwf
         ljm3SZorrId2WhfUUlePNY9lzG5TmUSBCvCnl2Vnpci/tHbs0wwf42DyJqDo4ynBEn1L
         SB7Q/45dM3Sfp4nBuCV+vy09G20sX7Xc+hRyz6j158n1Dala/xQxgUGi2mDxcGkROayC
         H+2g==
X-Forwarded-Encrypted: i=1; AJvYcCUWvA+ADC5bdghN2dVJIzHP7V8YkaGudBYBYm+b2cLpSSeBWM+TCgjlP6FrmxXVNJ/+7DblkCeqhmFb1wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOdwmiLZG0i2gy55RbgAqgFE8dOCnRaDuMQb8YJbaXXhCC8LIv
	h0TadFMh5TecPyRTjEmsn7sF+yAgF8v2nQKM/wazqgNRbTfWrCWF8pJ94M34nzs=
X-Gm-Gg: ASbGncsWLnrAxcbIRSFkn54XIoE4nT4xRioKkooCgHbrGJT5gMuB8oTECzZYPx59Zb2
	DdW9n1qeXOtHTjBdSZ141tp4ULzyGsZ1tDBAZhZyua7iAMi9dSOSuY9+TMFaJ+87/Q0Dmq4ghLA
	xGzCs4OqpIMsZCWaNfhIRXSuCvMOHnnl8a+3cbz9uOf2a8msx5Ls+dpG95EyiXifFhe988RSQdH
	LEFyrt8T3cfFUjUjf+zpsrBowdBnJl77x5UYRGh1g68EQqx2tMUztj3qeRxJjzcCO8aQZGAxCyT
	xo2qEbuI1ZDt0oR4qtpK/xRNKLH25DT83L9Fevw2JDhYM9nrlUKlhyAU2FWPWlSPDEXYdlWozPw
	AXF4fUhE4+ZfPVNo2tk1glCoU
X-Google-Smtp-Source: AGHT+IEQXgwPTN0zWE14o/eWd+esiKQ+JOKkgZz1V9e0jKN/Xjh/s0kS262qvqbdXkWzD17f+19+eQ==
X-Received: by 2002:a2e:b88b:0:b0:30b:cceb:1e9a with SMTP id 38308e7fff4ca-30bf451104amr5734371fa.14.1741326541966;
        Thu, 06 Mar 2025 21:49:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98ec3f5sm4209511fa.28.2025.03.06.21.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:49:00 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Robert Foss <rfoss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sc8180x: Rename AOSS_QMP to
 power-management
Message-ID: <6fqpulpczqnzabdnpckd2rtrcdhxryydhkuou7vdhmsftquckt@wzuoxvhyep5d>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-8-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-8-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:20PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node is currently named power-controller, which requires the device
> underneath is a power domain provider. Rename it to align with other
> SoCs and resolve this sort of warnings:
> 
> power-controller@c310000: '#power-domain-cells' is a required property
> 
> Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

