Return-Path: <linux-kernel+bounces-309240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813F9667F9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18531F23BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AE1BAEFB;
	Fri, 30 Aug 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjUa9Vh+"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819A1B2EC8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038990; cv=none; b=EXS2xXWVxuB28c2ZDDRLiqoocammGaaLLjkoJ5lvxUvIUPiEpcIPUXXkIuZxl/LGerqTOEcPC5bQkkvujJyMylzpWXLKz49myI8sgmUAHcFOn9dinckM3f7q6WZgTke9Snb5BMsUmBa/slmuSqq/1kpsRMcr7h4MvymHO1onDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038990; c=relaxed/simple;
	bh=fGXe8YGAHhcDys28qYKWkkspchfxx5nyon5peMLKmAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpq+XTMdntqFDEzkdBDve9qxgQxI95u69alI1CNdPDCiVyFcBccqxg9I+YtWw1j/Hs7IAjk2q/ZVqoz0YcLCRV4TmJNG0WvujBhHlokXNuNbbYCdCJisUf5e2cyTnW6zoumbh7Bo/vJXV+uk43masgoSxtiGAyoMpSk6bGyjHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjUa9Vh+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso2877346e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725038987; x=1725643787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKq8Bys/USH6KZ1qBw1qwYVQ6z8sgBRiOI37jtuxbtw=;
        b=HjUa9Vh+GCiG8R2KhqbXn2QrtmvXEY93LUxw9RboH42ubkCNt5mqXRHOq9TvL9FG9u
         Llyb2Hyz4+7exzIKqEY+xDdHgAJsFiBUN/O3kDY09VqViHja/CAh9IAEa5jvWqz9FPJ6
         UK29igzkL9QVgXZ1DWISuXvjUVFa4CyzaHSZnblCibYTW8yl4lIO0W1ThyWmZn0+5YWS
         UNBEG36vTbLtZw0RjjdmOk2/zynBByIn2/ZAfGp0sWskNcgt2mybzsAMyZqDadb/hT9G
         QbBiK18pUODsAoRWKA/XVjuWWN8R+vsZj/PmVo6dtnh2Pe4cXHKZ3GwNYr2v14fUFY1V
         ouRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038987; x=1725643787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKq8Bys/USH6KZ1qBw1qwYVQ6z8sgBRiOI37jtuxbtw=;
        b=IZTxDTIWUJ2RnaafVW4wP5/VnqDKuGLovC7e0QaLIBLl5ebucnHro55pVgy4j82u2J
         R03wuLdN2pEAM04sXZ6mIGY4RIaIidrWS/KQzE0AVZ3jxk+I/2eqYTnpFeKLQuf00h7O
         JFnVGPKRnoXdHPpDgLr1DJfXPHI0COKnT5jln2vC6otofEX+lG6Va3vm0NgRk3oKvhw5
         kFCEkaimG0yRIO9kRYTJAzu9cs+OmqRTR6xzT3VjTNlXAuNSADnVSdrx/vnuE7yes+VH
         ByD7Z1NYtAgwwTFJgQzlrxN4k95yByr4+Tyac+4R1CYMcYi0wWs1dwKLZxoAdQ/WdJYb
         ezEw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFvcmj5WL8N4INlhc6qfe/q14CcCf5hEtTvMKrlH6bplYmHwBxGJhpmtP27sI5+jaqnKMGJtblDEu3pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7GOHUlv82VlXDF/OrAXXgtoxxZGjdUTd+QFP2PdmwH94KBMk
	R85msZGtmal8RZGSagKAK9q3gvpWVqRVPjAmISr6fY3UM1x5Wl7VusO26Iynkiw=
X-Google-Smtp-Source: AGHT+IHxxcADvc+QZ/22lw1wDm/AXNztt8D4qol0EtkLRXo6WdtzvIw9t2cOGwGJz4GOWOGI05INZA==
X-Received: by 2002:a05:6512:2344:b0:533:48c9:754d with SMTP id 2adb3069b0e04-53546b41e00mr2294513e87.34.1725038986104;
        Fri, 30 Aug 2024 10:29:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079babdsm693823e87.50.2024.08.30.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:29:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:29:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 16/21] drm/msm/dpu: Program hw_ctl to support CWB
Message-ID: <vsg4izby2zjcdtkwteti6by7sl5rwddzqw32yhnevhobgmy6cg@hx6n7tthwj5l>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-16-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-16-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:37PM GMT, Jessica Zhang wrote:
> Add support for configuring the CWB pending flush and active bits

Details are appreciated.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  8 +++++-
>  .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    | 13 ++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         | 30 +++++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         | 14 +++++++++-
>  4 files changed, 62 insertions(+), 3 deletions(-)
> 
-- 
With best wishes
Dmitry

