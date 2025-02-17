Return-Path: <linux-kernel+bounces-518277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290CEA38CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA771682FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D22238D2F;
	Mon, 17 Feb 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6OfmLye"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC3235377
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821879; cv=none; b=Z+VvCK56rtsYqnv86SDxz0V2m1ZC+ndnkMCH4GnU6mAUmmhXwHIE6+5t4SfH4yUD+Jtimd9njRf0eGZu25VIXrZeZT1q6hPOU+2rL/EGVl7XIra7aNQkjC56HgrE7foukq/pfImu9ZIXyBbwFW5kenD+iAHwCMUIzmBsBLzK+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821879; c=relaxed/simple;
	bh=gEL1+zcVPC/RV5a90EqpXLzztE8bxnY4nor7gtc46Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSP/Souh07aWqIJm+Rmb+h/ot2zKbQR+JCu4Jknurb96voMSjV91JyBtZjV7uDr+bXUEM3oelPEeYDhgLbq4uwZK9dgJfitXNcbgfqoiH6YFtSXOz46HWAh/USB1vclBbkhGKUaw3Bxs4/AVyN4EJqaNY59aT/DVb+r08Cpqrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t6OfmLye; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-309311e7b39so21904031fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739821875; x=1740426675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPHMiuUpbPXEyFU02G5OaxZJl5M9o+dz3xvjVDfgoLI=;
        b=t6OfmLyeC4XFL6/TBuknVVZMLbw0m0Ge5Ej5ldRxy5U+AhB2Ql3yjfkVzTJD08IgCq
         +ojQJfh0lsr9uFgCV/Fbgq5t4sc9f73kbQdXnFy45AjZ4u1Vbzd8tolfH1j7KMl0VQzd
         EXAl8WqzYIJ5eVP7O6HpDMCO8cC8boUeQLqcBo62tGEzk/F4MR27cC324uTbeo5WOczB
         jMtgUQRZd2dKFVWOCIizRSYO/SZGm6g0eXBtRi8GvtBwtupDMsQ8u9Fx/FIHghywgnCL
         LV/AhzWSJtCXmab4dkKudTuoxlqjQL/HyiEkdCn+yROb0/g4ZwdTbEJKmXsiW8mFXzqG
         xOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821875; x=1740426675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPHMiuUpbPXEyFU02G5OaxZJl5M9o+dz3xvjVDfgoLI=;
        b=dKfDDRyLlPKLvYHGNgLsbT4oITPkNaeV3hqLtNdnU4Z0+2vLQjWTfG/W5NzRM1qxS3
         PoIirCguteXjc++Hpp0IVrqhDdd7rv8vMgIFixumhZvX/SSS1COgfNFyII8xh+vI2EHK
         Pz4z2A+QiwYT+QBvy7SxSWWVtIn5tugy/Hbqaz998iVEuMS7lDqbnspJjtiqfjgaold1
         jZqs68ymOPymRoU9mpIs2389sodhQToiP6N3wz/P20L+osL8SYzOTBk/u3kOm6S0GomI
         1Aja9mrZ2hwWr0vrSbC6GkM/Z2WjKjKnavvFARXIb59J8GzlE9/BjoSiTGIQMOiRaNTL
         vPfg==
X-Forwarded-Encrypted: i=1; AJvYcCXP2Q8XB0HiqdQKE/iFTHWUMb0gasTYHwEh2tykZg6wGoRzfyaOtgM9DQ61Ei1VAqTirX4x+lj//JcYOYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSn53EG+CNMkEWLBZ4yqtnd5bzr1XVgZ37OHrgkeQUZgpBcoqN
	H1uKfB0vpXJFRvbV2gU9fxj1NzM4/JEawnV18idv1mGpMcgzybkp3Fuc/O1rFxc=
X-Gm-Gg: ASbGnctPJokYIdURbW34aHy1yObSlzeDUqv8UCRgSxRXLAL3wOIpZxJtu0PlMbnyQNZ
	jm2YeQc5K38SQ/eo8yqi2GwcrVr4pMAt5PlKu7TZUIrAQDHqxyAz0XOAGJ7Fymu76m96sMuVBlk
	Y/LxnCDnm8KKR94GeaV4te2rgVBNGZdgRdpA78AJDHx2bRfdWn16CS/HVE7R8gaxq3N07e301A0
	f1Eg5z+/HIdWT/NrdeviBzLQKFAVkTczW+jFEpXEdBABZxb0FZ7V9+txFFBVkORUsu4nIKLPGhs
	Ccil84rqaaWq2nHFqe3UU28Ld7hOhALHsg6YimapNmf2OJmLtgXRaypVnJ+Yn70iD96Jg6U=
X-Google-Smtp-Source: AGHT+IEQoBP7xS27h3W8daUCOs5a+K/MVyTg+zctUJ3ISgMlaM5H7WG6g1V94qDglsRK691P9WX9Tw==
X-Received: by 2002:a2e:8ed5:0:b0:308:ec6f:7022 with SMTP id 38308e7fff4ca-30927a630aemr30983201fa.17.1739821875240;
        Mon, 17 Feb 2025 11:51:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309cec7e45asm8598171fa.105.2025.02.17.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:51:14 -0800 (PST)
Date: Mon, 17 Feb 2025 21:51:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/15] drm/msm/dpu: polish log for resource allocation
Message-ID: <elx2yudvkpnrxu4q7uqm7wrhfryhd7mcmnuh3ktmtkor6sjmke@4ptbzra2k3a7>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-4-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-4-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:15:53PM +0800, Jun Nie wrote:
> It is more likely that resource allocation may fail in complex usage
> case, such as quad-pipe case, than existing usage cases.
> A resource type ID is printed on failure in the current implementation,
> but the raw ID number is not explicit enough to help easily understand
> which resource caused the failure, so add a table to match the type ID
> to an human readable resource name and use it in the error print.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

