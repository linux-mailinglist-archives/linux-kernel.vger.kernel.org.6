Return-Path: <linux-kernel+bounces-337780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7FA984ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9751C20B14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2161482E7;
	Tue, 24 Sep 2024 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3xJmfGA"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56151C32
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219968; cv=none; b=ekWtRruOiGaksOU0weAj+aDfI1YsRIxT3sqv1j7kcFUC/3+PhtWal0QdiYJK3tJ62sgFgqTqmmxvkYHrCFYRW3XIfSX2NrEmFECBQ7YNHH42uJ81bxJr5mhnQaD1AU85Muzw4u+IGduQ3V/zxY/fPVK5EqVvuKPu5/1n0VasmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219968; c=relaxed/simple;
	bh=vNlcHPiP4LaoqF4HPfhg89hpjHfzdn3g+qofGKGWCC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4PoNs3yMXhlnh32Lf39HTILdS67EiY4+esh+2yfCs14y3S+7kR07Xh7PWTmlLtrJuJEm84sw0ree8F61Wf4Dk6VysQIWCdY38j3wGPKt26UMOsydcnx3kDHz5W2tIhBwRoyzGHs4DybJytwErKGKdJJzwUtSHoGJGo21vZZKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s3xJmfGA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f761461150so73586871fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727219965; x=1727824765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvU7Vx/LdaZKtGEV8daIjq0EBTdyjFTk7utGpIyOftg=;
        b=s3xJmfGAUP/MQvQSko+HANOLNiWK159QLZqX/sdo1+xoAXCIiZKsnSyoqOXOinAYhP
         a1DyFr8/01ZSnCfNk7qSxuvk7g8sktL90TYvjmFi682RXxZXt1jCFzaGDOhn9qmJtwDZ
         dG8cN1El65ZgAY7C8Y/nfKZZyHFR5IzWdLXPuuDDfmIpqHOqGfMuPshrHQkykNiHvgDn
         dEKz5AiuRe74QjIUBQYoal6QJyPTU7eiFLP2U6p5dPlJF0sDfeqPMY5SdpQQ8b+jOU4r
         EmWdQJW8erAyG4PIcjkIoKX/mxUEcowU8PgoQj1qMpNhg3DW/RijWGdaG/x8v5otW/bL
         Burg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219965; x=1727824765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvU7Vx/LdaZKtGEV8daIjq0EBTdyjFTk7utGpIyOftg=;
        b=nyAmsKlWQwLq0lUa0b9lrmHnz3UnLYIcAWO1+++CXrbZ1OxI7EhYHCNoPWaplk2zhY
         IakOJNiU0P8RWzXiYuSWPTYwnYjv4AO7+QyseKC04/cC/miB0wYoO+ud0ET4f5st84V2
         gscc5va7ljBIS+XpiSv1XUNRKH7LIU93RbYbyAESGylfclkFvRQFXyeMxXNxl2pO+yCy
         EeCdTuoL3E2fIpp5YVOy3JoOFaRUMuFPv2SxToo3srNbOHQR+/o3mfj4vBelqHDEMqtl
         3ga3KnJCFjFN1EE1+y16OSdcKMlNinZKYSyiQwE/7bb9a0hR9xu30cUW6Eua+D7got19
         jwEA==
X-Forwarded-Encrypted: i=1; AJvYcCUtIA7qSCWf/dS6wt9Fejcq/ceW+va1nWdFCCIKCPjxF7Sy3+CPMJR04xsxvMmOspJ4gNO3fWHtJRE7hXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0DsUDNLjQeEVnff8VrgbGCImORBogXkUGj0F4uL+7Ai73WlU
	gnLLTj0fPYxk40No63/lPECwjomneolTweJ9Wgf0hi7ycbrYSBCCp1FGFccZKhg=
X-Google-Smtp-Source: AGHT+IH0klG/CcfMRjXMdFbReF7bhlWRSCeWv4kqKqNH0sL3opOyR4yRKdhF285Ci/EQb6g7QrSjmQ==
X-Received: by 2002:a05:651c:1991:b0:2f7:562d:cb6c with SMTP id 38308e7fff4ca-2f915fc0a2dmr8141701fa.2.1727219964875;
        Tue, 24 Sep 2024 16:19:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283b86fsm3519751fa.30.2024.09.24.16.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:19:24 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:19:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 10/22] drm/msm/dpu: Add dpu_hw_cwb abstraction for CWB
 block
Message-ID: <sm7uvwkkir4oj3n3wdaadcfoufh3cktn7gvax6grqma2amhxxc@w3ahhlj3x3jt>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-10-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-10-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:26PM GMT, Jessica Zhang wrote:
> The CWB mux has its own registers and set of operations. Add dpu_hw_cwb
> abstraction to allow driver to configure the CWB mux.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/Makefile                |  1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c  | 73 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.h  | 70 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 +-
>  4 files changed, 148 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

