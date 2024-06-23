Return-Path: <linux-kernel+bounces-225949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F7913841
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB0C1C2128D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A9FC08;
	Sun, 23 Jun 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1ad/Fxs"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D414A90
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719122480; cv=none; b=Ugw2m88G2nnRy8VLGWgRYsCbZmDFimvlznzK3cfBWwQNtNkTEdKDtYBtQvzk2WEHFpc3UFyQckKmlPnyBSsp0KB3qCG0gZXMYl2HvxHgeXX6UKKu/KV6OvPgHvPEQFupoC1bM+26xbpyQP2+CyGQ/awh1Qyqt3LgQqpsxuen94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719122480; c=relaxed/simple;
	bh=QsXiMBMnUlHYeP5n2d2JvKCASEy1EtNQFInS1FsH9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2YcFDU9s84bKRsYz/aCAOD4yel5qP4IcVkVtoPCOoZpZRQFXEXEo4jW4ZCL7Ch/pd8ww9acH3CX5tFuX6S9VoWEu21rDahD0sPkkZnPoHxcUUWU5Qi2Mg6bZe1ryue7U3PWj4cRGHmFSjno2mmAiuns5Ux+6IKNGDBQetc6It0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1ad/Fxs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd717ec07so2138258e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719122477; x=1719727277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oO/yeKrqlD6AMd5wV3WFZIiC2wA8T5SaNuGSHMCz+LM=;
        b=T1ad/FxswEPv/V/HK8eV2GVBIH5w4LWZ5lvO7rxh8Cob56L6aznAIgqvzdOmx/iL7h
         5d2uM5xW6Qgv7YmtKjqg0xj+Q335uzRiQgM6H8w/SNOPGhYl28tc+lhihRNV8rymMc63
         ECZagKN4teoIBpCSzKpUEkEdFHQ6+W7sZwBW0AVhZsECDBfVN+xxaPv7qYgH5HRSkF8w
         oI0jCepgNa9WdO+b8zY5mhekG+3sbCdeyCcJMu5NlIrPyv0Sv/U+msqVupXzb3FpsPNG
         TLtPlbNQI9pkcyQSSBLMxrkDCDCrtp3h73NSXT2/gYzI14oROhs7q2CGVKT1nBwTMSuT
         mPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719122477; x=1719727277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oO/yeKrqlD6AMd5wV3WFZIiC2wA8T5SaNuGSHMCz+LM=;
        b=IRduHrOImuRr3eWIlYLk2oCRXdC5dKiI398np0m9pO+CC4W4IHbOZRyqQMtUA30QUn
         6PfCGnfoM1/ZM6Lo0AdSw7p4AYYUFp2GBVn25duZ3PMia7MtYs0Nv8mFPMO2JoUCqW5f
         9eoHDqlzh9l2C/bfjSUUPhqt6k9AVdeJpXW88FEEWWi5w4KvDD9UewZHBzoC26rU8Tct
         G/2efu2LWXR3ijv38PegHWlg1mSjcF3xfS3VftIqqrKd7n/h1ynp7O+85FLle9uIgyA3
         fMWcM/FcUZW6g9s7X2LDoumjb2312IDGUoePx18fSt0mEX2RS/DVCt6/asX/Ls3leZA3
         /hGg==
X-Forwarded-Encrypted: i=1; AJvYcCUot2nTtEbPJtgVehbHIup1FHWJDNIDKBLfk4Uc3YB1eKKU5eAunJnS/YM8qhVvJfgUIcKx7Yygq0T7xUDGvIVAsD8niiElZmlxwIr7
X-Gm-Message-State: AOJu0YyJJMYjbpctkyx6sA/Eo4mrsUn28erX0scEiV0FpegH8K/jpiWR
	Ltrli/kza1P/11BBYwU12ZzaHEl2z7UQX5I4ZOmOH8HCv22+CetM+8RDa9Wna1Y=
X-Google-Smtp-Source: AGHT+IFPlO6IKb2eGiTUnC9Nkv6WxHGRszGQWaUUwUdgPx1JDS5kmDVtdDq+1Ch5metEWw5+VYTjtw==
X-Received: by 2002:a19:4312:0:b0:52b:e800:25d8 with SMTP id 2adb3069b0e04-52ce183559fmr598972e87.25.1719122477496;
        Sat, 22 Jun 2024 23:01:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce17c3821sm162388e87.241.2024.06.22.23.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 23:01:17 -0700 (PDT)
Date: Sun, 23 Jun 2024 09:01:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Daniil Titov <daniilt971@gmail.com>
Subject: Re: [PATCH 4/4] drm/msm/dsi: Add phy configuration for MSM8937
Message-ID: <hmgnm7xgrf7bzae4wkfz3rvhmubprsa5qo3tydjq3vjhapj7wj@klsgm3tlkctg>
References: <20240623-dsi-v1-0-4ab560eb5bd9@gmail.com>
 <20240623-dsi-v1-4-4ab560eb5bd9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240623-dsi-v1-4-4ab560eb5bd9@gmail.com>

On Sun, Jun 23, 2024 at 01:25:54AM GMT, Barnabás Czémán wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> Add phy configuration for 28nm dsi phy found on MSM8937 SoC. Only
> difference from existing msm8916 configuration is number of phy
> and io_start addresses.
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

