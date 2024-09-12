Return-Path: <linux-kernel+bounces-326133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B9976382
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B81C22F11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9B18E764;
	Thu, 12 Sep 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjbKfsr9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DA18C915
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127587; cv=none; b=Ls97Aq+2g5ukE1YvKTy0cR7TWBwnt+ycTBI5YOMUjJbraG1559IoTnLob/fLKTdKQ/lqM6pkXQZa86Mj4ZYY0v0k7DzIGZlfq+24C26Oi+Y+L5uGDM9zXewh/KJcdammjB8iPZPFMEpDLu1pf6bLMwkKwj9chMRgFTKMjboZWYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127587; c=relaxed/simple;
	bh=tEbEuuKZpwAnFVH5hSfQscYydf1M6jbKUfNey+GAKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuxOgx5rbjaTuzYapi/3V3j34UuoCmAwk2qk6iTR/nSokFiU15pf4wXSvp81otcgWWZL0lTH9CEl0OVJumkFkBlcU1dvdSiAzv0iweTqp+FChEM0mU/c9tKR6ky0F6Sha4F3Xe7FUXYphCOGZrQdAfTqwK4qGDvns1sUEgQyKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qjbKfsr9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f761461150so9597161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127584; x=1726732384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plV9zVWaER2nVL76z2wZIDE0Ej/fFWbWekwnS0bRoPg=;
        b=qjbKfsr9aRhV9tYkJdEOurMU6qHFa2xjFrGEVyN05uwA2hn60kshKNdgRR6N4jGbdB
         fYzQtW1OdkiTOD2PQsYBCAV6nAapiRAy+0iwE0D18kW1lzF34gpiFTp3hNT9kLT1GSIH
         ZIiJPD8CTVjnbhrnRGuU02UK6DwmxwzqQwrDMq2pzXKFTNEeKw2ZNrT+TgxB+zcQUxh9
         fP/2ZdTYKB1EFvNJsEUdjfglonqxHVWAORccmwe7QNONj9SQ9KfB39v5bpyEiPcEC/wL
         l8PDoj6WtZ0qIP6xAEo/Fcoad0z1pQ1pwN7ueMS5lGEOmnYA0s291IQxIF6WZqo9ssZ2
         CD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127584; x=1726732384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plV9zVWaER2nVL76z2wZIDE0Ej/fFWbWekwnS0bRoPg=;
        b=hGqLIw/gNQ3vWjS0TVYsF/BDC0VduUCUOpQKeU+knH13vXpFehAAHnA71Mvxz8Fpmc
         8e/ieEA+GNGpVmcelt39mnATdfoMc1KsHuRTSDPFv/2MzrO9P0s4ykIVzDxOI4TiwcFY
         3sl7Fu0GFgbLJBk41jIQGGMndqMcREasU98SXEXCXxvhUctkHjtv9XsrSATZMLg/n/bt
         IbN6BotEBXAV1eobBbkNfAwCqjf2yjzt8Izzg7t4GSrt/zP3UHu84YMOVVVS0nVP5oxr
         dGy3ZRaQ9+F/CSh81bM6rGDAXnaNsO9rkhp7bi82sNAbpy4E/GN3iUH+Fg8Yo+N8nf3z
         hhKg==
X-Forwarded-Encrypted: i=1; AJvYcCVNyNE8usa3J9auYE14idB4PHhYiGYNd1UzkNoZkSW1Dz1fVHVF6QO+qMsWD/3FoMDyur1bN3nxbG+bAUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqe2c/FWE4HS6QsbmFsswYsAkuuMvWzyPFlg8Fqiy0VnKicJ53
	2dZQagOx+L2G+zrodh2ul+hSBc+5Nq7DaJDYyPsQrF/ioLru6p0knsuX1OSnU4Y=
X-Google-Smtp-Source: AGHT+IGNAjjrqwXcc00olSCpw8KkiqSQhqCV9M6o89EyqQyNZCGyom+XQTk0RI8UmFhrk56pycAn7Q==
X-Received: by 2002:a2e:a7c1:0:b0:2f6:4a89:9afa with SMTP id 38308e7fff4ca-2f78e18c52bmr1151811fa.22.1726127584296;
        Thu, 12 Sep 2024 00:53:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bffe937sm18013361fa.55.2024.09.12.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:53:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:53:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH 0/5] Add display support for Qualcomm SA8775P platform
Message-ID: <3cpxwtqxapxhvg3w323xr7drv7p5sozrlwgoqscz4dqyuqft5x@x3pqxdjbpca6>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-1-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:32PM GMT, Mahadevan wrote:
> Add support for mdss and dpu driver on Qualcomm SA8775P platform.

You can not support a driver. Also, MDSS, DPU.

> 
> ---
> This series depends on following series:
> https://lore.kernel.org/all/20240816-sa8775p-mm-v3-v1-0-77d53c3c0cef@quicinc.com/
> ---
> 
> Mahadevan (5):
>   dt-bindings: display/msm: Document MDSS on SA8775P
>   dt-bindings: display/msm: Document the DPU for SA8775P
>   drm/msm: mdss: Add SA8775P support
>   drm/msm/dpu: Add SA8775P support
>   arm64: dts: qcom: sa8775p: add display dt nodes
> 
>  .../display/msm/qcom,sa8775p-dpu.yaml         | 120 +++++
>  .../display/msm/qcom,sa8775p-mdss.yaml        | 225 ++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  85 +++
>  .../msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h   | 485 ++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   3 +-
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   3 +-
>  drivers/gpu/drm/msm/msm_mdss.c                |  10 +
>  8 files changed, 931 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
>  create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

