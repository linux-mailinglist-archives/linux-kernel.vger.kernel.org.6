Return-Path: <linux-kernel+bounces-271798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2AF945355
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7B1F23BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F714A4C3;
	Thu,  1 Aug 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tl7ChjqZ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235B14264C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540316; cv=none; b=jQ4PDTDurh4slC9gs/QkIk32CLWz8BfKgq1fM/ystz6LEPf7TjktZA0zi4I8GoY/m6g0n6N33lC4EfiJOmGT52ZaEo/1sXVP/OhccvTOdDmTfqxyy4l1Ql91l3g7QJwTFzE9Oe0HSi/04wvkF/ntthdM54QpmmueBwKoLVjtzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540316; c=relaxed/simple;
	bh=TpCNPi6/NjMMws2DAkbtB0a6gtbkVNILNHKvFRfoKXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irybIF/b4xHqw5zx0VRnxipM+xcIdjbdAylIPILwV2UzvQhtFbIVkVli+/5vaJAK87aH14H4olezZD5gX6Viku/yvlhivOI9kXmZkU4qJuiVRylOsIk2oYEtTDuI1JRd4cWn2p94dJKec9X+BqZhnnKq1M2bRAyW2+1z3agtaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tl7ChjqZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso8982868e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722540312; x=1723145112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrLSwEPusse/MuTuJW5ek+V6ugLF2Iclegua7zatll8=;
        b=tl7ChjqZuOTB2ycvv0GoQHGWLeJIjsCwXIbdZQQ0hjzYrqRQVWZUCy9mymX47CjuVh
         J1g8MbbLgup7zyI9Lsl5GfHyEXY+6WvbpUtCHoV7tBHe/aBofYvT1MYkRzN/qMSKTW/Z
         ReCP9CW/BPahshSoxhbTgpFB3SkMXBJsefdHRGxbzRfX3fXmYAQq5XNC4vyyOhAoAwhV
         3auwhecucSKFzKek2N4k0Z0JoykLCBG3koHkKHVZWW5FUL317rYTdd8ooLZo7mTcUr/I
         Nm7HYoCNaXzJojNv6kPVkoV8E4B1l0WrFYKSbbFbvJJmBC6xdC16L5D+S3FtfRo2LWqz
         LHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540312; x=1723145112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrLSwEPusse/MuTuJW5ek+V6ugLF2Iclegua7zatll8=;
        b=TjQAoFG4V+K/KBzDVdlSFbH1GNbXPvLtC3FavyMeCfXEIXULx2qPO0NSROGBbBtYSH
         SGqUlX3xfw90+LJxxHPtipEXcblRTSzqqWSC1GkxNNmvUvHo94Zraz2zs0PmxOQKgG7x
         k9HhMOYC5d0TSuTY5ApFHuTzv71m9Ij87yDVMaAyzd3hpEtj+QMf8hHguFVWF4AAO/bJ
         9YqBrbn+0qzrJh2Qiuh1BjROGUj9N94q+a9NO9Yik3jC5c1sU6Nj/xzoGwkM7yH3z1M2
         0nbMkqR1uqNaxR5p+/LQT6GAAPr9E1iNDVn5RBxCMJVjRhxemd4s2BK0dLjqMGKNFj2I
         3d1w==
X-Forwarded-Encrypted: i=1; AJvYcCWkcO36Pi1qLvzN/i5c95n2Mj/HKYDJ1AD1ea9SfauGRATM24DY1bPeZgzQsD4/00YnPl9nU3YpJKQAbXfwQ72CZfP1G5GdgODUJwZu
X-Gm-Message-State: AOJu0YzzsVthzSONmp9O/6CePjnxRNGuI2fvHGT5s/udafyabaQj8rDH
	AjWeKbMWq8fKQBgxIh65IvBViEzGD0lOgSi7O/rF9VpMzZ84znlVRX1QE6OWOJU=
X-Google-Smtp-Source: AGHT+IHyvHO6F0PypSn/UmfAHe+RChPC8zWKCvyEdtI5ipmD0BkNJ+h95UKmnYJ0E129Lj7ff5XZnA==
X-Received: by 2002:a05:6512:a96:b0:52c:8c4d:f8d6 with SMTP id 2adb3069b0e04-530bb39b0b0mr724584e87.45.1722540312231;
        Thu, 01 Aug 2024 12:25:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10fd9sm35859e87.99.2024.08.01.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:25:11 -0700 (PDT)
Date: Thu, 1 Aug 2024 22:25:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 0/2] Add MSM8996/MSM8953 dpu catalog
Message-ID: <zeek3j7skstysho5bduxn23xipz3fpqsfwggue66dlyozhepnn@4wnnd7q6xf22>
References: <20240628-dpu-msm8953-msm8996-v1-0-a31c77248db7@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628-dpu-msm8953-msm8996-v1-0-a31c77248db7@mainlining.org>

On Fri, Jun 28, 2024 at 04:39:38PM GMT, Barnabás Czémán wrote:
> This patch series add dpu support for MSM8996/MSM8953 devices.
> 
> Note, by default these platforms are still handled by the MDP5 driver
> unless the `msm.prefer_mdp5=false' parameter is provided.

Could you please provide a summary of features actually tested with the
DPU driver? Have you tested YUV output? Have you tested RGB planes?
Which LMs have you tested?

> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
> Dmitry Baryshkov (1):
>       drm/msm/dpu: add support for MSM8953
> 
> Konrad Dybcio (1):
>       drm/msm/dpu: Add MSM8996 support
> 
>  .../drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h   | 218 +++++++++++++
>  .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    | 348 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 106 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
>  drivers/gpu/drm/msm/msm_drv.c                      |   2 +
>  6 files changed, 678 insertions(+)
> ---
> base-commit: df9574a57d02b265322e77fb8628d4d33641dda9
> change-id: 20240528-dpu-msm8953-msm8996-5d0fb7e387b8
> 
> Best regards,
> -- 
> Barnabás Czémán <barnabas.czeman@mainlining.org>
> 

-- 
With best wishes
Dmitry

