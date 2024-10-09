Return-Path: <linux-kernel+bounces-357751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C499755D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8F1C2274A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A51E200E;
	Wed,  9 Oct 2024 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zU+55hIO"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176341E1C16
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500529; cv=none; b=mD0pG+rjY+Au7d1lA2DR/UXBHDEyEj2LnxhIsztcxpvMYYvbsBmYtFY3AHMK+8bRQoajiUUiWI/rooOPG1nDxfcJbLuoZwsgxDvY642TLao25whLB55THEqJVq39jpRkHuFl9bP1/fYeaAxzDyHMIXKerRFLzYYphUjRGVqf8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500529; c=relaxed/simple;
	bh=Y9AhP4Ij9yYbpvP42cTvVt9kdtqB5fM50/MgwEp4SyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amuvgHllesqRNvNu6R0Wbu8IRMeHG0UKGnPOKz3YhhxiFyYov0tMY6NML4KoD+Nef13e2tj1T/72bAQ689oug6ZqCYbp83NgVLtOUo9nVILOfVoFP9GC7Eb+tpqp643BkBexK8grofHhTLUZWDlu9xoXLBlOd8iFPwg1NszGhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zU+55hIO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398a26b64fso55441e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728500525; x=1729105325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ5+ACbZx+UOJv09QvSfDOymcofkqLkZcQ+uGiaQiAI=;
        b=zU+55hIONCx7BtqzCi6BofLui7OcuQnSWKJmK3EJY1hRFC2OOX+YNxpwoKvULCEjrV
         CA7S2bcMyzpXgWkfAHPIS/cOcUPW+q5FjHKOH8NULbimnUGDbY1mUs9t6rt2lpEY+3Q/
         iIEJy8/VGYTWRwEh8rXKvlhfEQXKkHj8JtvsIVT+LYSqpxLtXRaMmojp2YBpVjXGm4+5
         heA5XJhtmH+gxj1BpKxblyZR6CeTM95MjOXY34/onPMGk91NM/di/tE1SUyFQQT/G1QR
         jLiJfee+Hy/VLTKnM2ewuzvqbJWXzhxcGYhO43eZIvSzoVIv4Kw14tIkJ/PnKfCJ3/56
         wCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500525; x=1729105325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ5+ACbZx+UOJv09QvSfDOymcofkqLkZcQ+uGiaQiAI=;
        b=Dm6Kphro+W8KBvmhK3oOAyXWxMSSayteKSfNom4DWTFi/qo8obCToPgI2+34HbpvCu
         ZRecLk7SeKrxuwNzch7hGkz4PnJobKCjSkCvwNFkiBLqz+LPe/xvURMEMNdFusOpotRx
         C8VvUSMIjTKKwBKWI+WgNgLVfz8pyUCeDaUQgjYik71+34gOV9f2ErNPrm51jJULs534
         GGDX0IK52ghzRQbYeRID0kHlhsWaXookQl5zQACNmCCAkqWEGAMijopti2QYes7wPrVf
         B10TOiaE8UUf/sc0SI48LodtKucDWMtljCbOT77XacUbq1lQHWz2o0mCmPylzX+KW1tG
         +JoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV77fcXzlaphvGydbUC/hkWybtS96g7uVgP5X0HLILG1LZiSoaHhapJfr6rqZT56PT+/oQSNo7mDzLFxtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwrYpsdRVHgUrNNGzpodXp2BI7fb1/wsmoZ/HzAKngMg3hfuqJ
	KYc8yYfPKDdwYafq2x/XWEeoPekuXtNW88dZDS83/xraFzQhmU1t3AP47lmmM/I=
X-Google-Smtp-Source: AGHT+IEekgkxN0FoqtvPj+djHpCzoAdpqcQVG0lO0MMFyXD4siMsEcttXGyf6xKYoA9aRSDcmj33Jg==
X-Received: by 2002:a05:6512:3ca7:b0:538:9e40:94b with SMTP id 2adb3069b0e04-539c489754fmr2427993e87.19.1728500525147;
        Wed, 09 Oct 2024 12:02:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff28034sm1594268e87.250.2024.10.09.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 12:02:03 -0700 (PDT)
Date: Wed, 9 Oct 2024 22:02:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 4/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Message-ID: <qfglrrksmb5674fxwtnqs7osku4wqri7nxrymju6fa4ey6zrto@e7ww725n3cfc>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
 <20241008125410.3422512-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008125410.3422512-5-quic_bibekkum@quicinc.com>

On Tue, Oct 08, 2024 at 06:24:09PM GMT, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
>  2 files changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

