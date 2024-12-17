Return-Path: <linux-kernel+bounces-448429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8719F3FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2D169A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D442AA5;
	Tue, 17 Dec 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1UjAAH5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528342A9B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398810; cv=none; b=VT7nitB7Z9Djn4xjky93BCjH/XvoEgDwxkLJAHuKmYs6ISaEB16ciSxKvjCs5Cn5KiUq7a/JRC/Hmrebjh05Nx0OPol91+ucAzG3IzOKAgQcpBFfouUNjKtOFn+AJX+WrojNUkuxaoilPBLhB/uxaGxbGDDoEK+ual3flMuZgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398810; c=relaxed/simple;
	bh=Ziy1X2FB9Nnq9e/Z2nqa/UJ2kTQAlBU8P//tznPPKd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGwMa8Ne8sF9nLsB+i3gtwuCPNLS20MsgPFeJbuzlLqk9CiRlK3k/GZysZt1V5pMhxxsAk8r01vEYKnTsBYqv3txdZmS2RiMHYXMy+MADwrQYT+X1C8LwtLFup5O+Bq2/bqi0iqV2cO8kz2NMZs8YswZQZ+yCx5boILvTcdwQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1UjAAH5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53df80eeeedso4731169e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734398807; x=1735003607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIrp81ZiiTPfk+3VPzj+WgFvsCEPmx+xpVPwG8ujmf0=;
        b=M1UjAAH5xnpyw4n2IsnuyXrarfKo2uJ9RmDfKucXDfmIbH3BTQQY9qS9rDsP13+MeX
         NzEKYs0uir9EXIS3IpjynHKNG+arz1HFu19YAEv66SGfbazeLTjeiWkThEFkT03SjGIt
         xN73S45YHe1T476NVL6eG1tM2H05Owi53/RZZ6stI82+C2uQVvs7Lbw/hCtonWKBGy4q
         qzlzKIGG8uA/jUCkQIKkhKfiXfCUidMkQ06mn3/cG5V26xPBgyqxbGEAUreZuOx/m29l
         tO/WHERDDr7XNP3rSw9vEqP5TL4snww1TXyAkRr2rm8vqLRSwWUY9cI+JFoPkVHbWt/0
         E2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734398807; x=1735003607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIrp81ZiiTPfk+3VPzj+WgFvsCEPmx+xpVPwG8ujmf0=;
        b=sURtJqHY/v6zbrxZROK2niHim7zyZ5TAlOnj6MLzuTt8QTHgalUUvSmg1jmysXANIB
         pLU8KX/mBKgmSGUSKjVfpb/Kz2d+vJ7jUXSLrotQwUbUhgfgLwf4n0veKK3yMQxwAiGV
         SEuIZyDOaV2KW+ynegoOerjiu6MFJy7NTj9XefP9TMzTiFmjNwllDX21nZm2/Ja93xjE
         IEcewuv2BrSH9QkXysO/oGouWtDGBbh5KMoRaQkFF8M2R5aF7ejjzhH8YISQvyBNyQco
         jdR/K3SsVaYsfd1d9Y6omND9pAAxJQ7jEpRpqWqq3bEUBo9tcrIltfZGgJrRyv/8TcwK
         YmwA==
X-Forwarded-Encrypted: i=1; AJvYcCXRT1iUHssqP/rXzJJ1MuHFQtJKsU3brBmLf3mnjJaCPuF8C/GJ+gSxUuACx+ermwH7yEhojeuNrhf3keI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoodJ/br2bk+4JLZpyTsCLSHdSFN4AgSC5QW8ryyoCtDRHRf2
	6T2BSILqPY43wiaXEsWgf35ZB/xdvatupc0mB2sFxDope0GuYy07mM51IhF1Yyg=
X-Gm-Gg: ASbGncui+1ejhohmLlIC/3YFjy5rjtdBjX4XTiBgxt+bnc6wx5sV+qx6F37x/IPKoF6
	/ATe7YZSIWnN65lhrl1XtE+IzJf4KYEgODpm6zunMxa1tHzLGcmDUZsOT/FiIAu+KSog5DO070X
	WzmPwEyKESb90hJ32uuVnOq2gtoiMqOAmw2vFCPRZLZU9aTtlQifx7r8T+6ofwrJsmk9a281EtR
	MTz1qKD7dmfZP7bJ9aJnmi7qNzhxT4H9zmH53i+5POCUwip7qqYTpY1CSKmV401U0pZaHWNm6ls
	J5d00JPJ/5GS+sxBFK5YUaZ15dYg0ZxZb0OP
X-Google-Smtp-Source: AGHT+IEFAVlmrtBdKZDemHD4kc4Sr3HT/4sKo+aUJjr1NtBRsFlsJQQbmQnA6rmmhL+0WNq+tfoLFA==
X-Received: by 2002:a05:6512:b94:b0:540:1be6:f15f with SMTP id 2adb3069b0e04-540857ff3b8mr5394531e87.0.1734398806909;
        Mon, 16 Dec 2024 17:26:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f62dsm1002965e87.17.2024.12.16.17.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 17:26:45 -0800 (PST)
Date: Tue, 17 Dec 2024 03:26:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v4 05/25] drm/msm/dpu: get rid of struct
 dpu_rm_requirements
Message-ID: <ykvaxv26maaxz5z4odttbfumuqanhtjsnleebprsh273ci6k6k@alm6o7vuzkfi>
References: <20241216-concurrent-wb-v4-0-fe220297a7f0@quicinc.com>
 <20241216-concurrent-wb-v4-5-fe220297a7f0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-concurrent-wb-v4-5-fe220297a7f0@quicinc.com>

On Mon, Dec 16, 2024 at 04:43:16PM -0800, Jessica Zhang wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> The struct dpu_rm_requirements was used to wrap display topology and
> hw resources, which meant INTF indices. As of commit ef58e0ad3436
> ("drm/msm/dpu: get INTF blocks directly rather than through RM") the hw
> resources struct was removed, leaving struct dpu_rm_requirements
> containing a single field (topology). Remove the useless wrapper.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 71 ++++++++++-------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |  2 +-
>  3 files changed, 25 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 83de7564e2c1fe14fcf8c4f82335cafc937e1b99..5172ab4dea995a154cd88d05c3842d7425fc34ce 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -800,7 +800,7 @@ static int dpu_encoder_virt_atomic_check(
>  
>  		if (!crtc_state->active_changed || crtc_state->enable)
>  			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> -					drm_enc, crtc_state, topology);
> +					drm_enc, crtc_state, &topology);
>  		if (!ret)
>  			dpu_encoder_assign_crtc_resources(dpu_kms, drm_enc,
>  							  global_state, crtc_state);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index c247af03dc8ef7174eedf3d5cc267d64f17a8656..cd5960af4a151428cc6fb7154c3ffdb65ebcf287 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #define pr_fmt(fmt)	"[drm:%s] " fmt, __func__
> +#include "msm_drv.h"

Why is it necessary? struct msm_display_topology has been moved to
dpu_rm.h

>  #include "dpu_kms.h"
>  #include "dpu_hw_lm.h"
>  #include "dpu_hw_ctl.h"

-- 
With best wishes
Dmitry

