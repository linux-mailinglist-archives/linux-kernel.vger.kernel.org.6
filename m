Return-Path: <linux-kernel+bounces-236934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1791E8C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EBE1C21A65
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3B16F8E3;
	Mon,  1 Jul 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG2H7pzO"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801416D9BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863001; cv=none; b=IerWa3Sd3YEdT/4g0l842UrHHt8rAV93pqqJdYn6nRlC9IfbgMZ2g0TiNHAEw7I4yZkcEmg3neSs2rJ03y8PFu+Tm8yPTyX2+lsQPsTB3EcggRCrvsApnKGMKJBCNZyrvE7zAs8sIBfPMPMvlQAh4F0JVIOIhmmnp7j5+toJxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863001; c=relaxed/simple;
	bh=shrbWN/CrXwZygomd4aysklY0BHpRI/Lqzag+3eHk6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKkoGuSNjrormwon2io8aGCcJLh4BaEwqYavnSo1LB9vLEscSx06Tmt8TiSfA7xvf3flbdpdWOKjx10/chH7ln+T1eiEkDgChXJj1PL5OqxOXWsSrRkrkt1xz/LgaUX0n45vGmyW48bI1UTw588LEN+2vExVV6bTqT0+Rp4lvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NG2H7pzO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cd80e55efso5935623e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719862998; x=1720467798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oscpSDO7CeUkkgmCfEkVvaRyN/meIA6JpS1dhxrIHl0=;
        b=NG2H7pzOxe/yfDqhIzNt+v71y7p7iGdRqk3n6WIBxAXU0lP5TRSfJN+WiVxW1kfluj
         8G6HxfVHKhNOq5GjPp4xJDwe2kFNG2v+ZSKzB1pOORKMp6hcCnPk4seBC4afsmc5CxQ8
         lPxAmH+TlPIjFFu7EjThCDYVq40pa00ox8UBpiQHgW6bIA+JYJDuE03uu45uNtUbvPUN
         EkNd4ax1mKmkG2mWqWOP8MqRfgHrPMkEtLX3JjvHoMUQsSyWIOGFmTf55yiF3TElCCMe
         BciwQq9isVqB2ltl3o/NukauCYAKOvaAVGGKuAuapbSHDURhL9l6INCx5tdG+ys0+6Aj
         5mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719862998; x=1720467798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oscpSDO7CeUkkgmCfEkVvaRyN/meIA6JpS1dhxrIHl0=;
        b=JG9e/ZInOLUMJY4Lte8cP3jZWOEgh+76MDRPb1kMsWHSyjZZLvotkHhTOG/MsNT2No
         0sTs5xPfw3/111c59+a3gECnosAC0kkajkLnp/peCquZOrB+COf92EAcQvbdE6kRUZzs
         QIqSRVJJjccgozGQ1aRF/YwfzTF5tBgcxFzLM1Nd5OnyjhRaGI3LpOx7ee9dCyPJh1oa
         iD65/4/8/O348SCRv1TGy3SWikCYAox/ZoY3fERj7lfqHhzLYNnj7A+nGAtikNJ6+dhY
         7k7BUyO9nzl7n/xvNrNGWUpwa/bc2J8MxNvniz9eA9Aay3gulkNwl0HYCFhagnGglJ3X
         /kYA==
X-Forwarded-Encrypted: i=1; AJvYcCVFGkOjaUYG5meOCP3ib1iu13droqoyHkOpNLjy+0LnBmseyWej/KJOFMpayEjUDmrro/bvwuCVO07rzDSLm8jc7LWsm/PQPpiyy2Kk
X-Gm-Message-State: AOJu0YzQPF/V3cW+5ZPAc5+r9nZpJQlWkLqgA+Gsqr7t7PAlrviW7sKy
	80/qQ0WOKV9mIHUn+niceCy3GkLpIZrx/q4txFWza/hJ3/lajXDBqlnsevpdsKM=
X-Google-Smtp-Source: AGHT+IFJ7WfUoSw0//3UtLKEzdeD18XEuk93La1NkOaUbrCL4a3tDiQ5T8y7FR/KCltxgwltD2/Zqg==
X-Received: by 2002:a2e:bc88:0:b0:2ee:4c6c:5874 with SMTP id 38308e7fff4ca-2ee5e37ff02mr73446291fa.10.1719862997936;
        Mon, 01 Jul 2024 12:43:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160d26dsm14817021fa.25.2024.07.01.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:43:17 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:43:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, swboyd@chromium.org, dianders@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/msm/dpu: rate limit snapshot capture for mmu
 faults
Message-ID: <5isw7c5kkef4kql4qcous3gmwhvgwc53ntgjm4staymqr67ktm@iw3cr2gr2iko>
References: <20240628214848.4075651-1-quic_abhinavk@quicinc.com>
 <20240628214848.4075651-6-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628214848.4075651-6-quic_abhinavk@quicinc.com>

On Fri, Jun 28, 2024 at 02:48:47PM GMT, Abhinav Kumar wrote:
> There is no recovery mechanism in place yet to recover from mmu
> faults for DPU. We can only prevent the faults by making sure there
> is no misconfiguration.
> 
> Rate-limit the snapshot capture for mmu faults to once per
> msm_kms_init_aspace() as that should be sufficient to capture
> the snapshot for debugging otherwise there will be a lot of
> dpu snapshots getting captured for the same fault which is
> redundant and also might affect capturing even one snapshot
> accurately.

Please squash this into the first patch. There is no need to add code
with a known defficiency.

Also, is there a reason why you haven't used <linux/ratelimit.h> ?

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 6 +++++-
>  drivers/gpu/drm/msm/msm_kms.h | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index d5d3117259cf..90a333920c01 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
> @@ -168,7 +168,10 @@ static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void
>  {
>  	struct msm_kms *kms = arg;
>  
> -	msm_disp_snapshot_state(kms->dev);
> +	if (!kms->fault_snapshot_capture) {
> +		msm_disp_snapshot_state(kms->dev);
> +		kms->fault_snapshot_capture++;

When is it decremented?

> +	}
>  
>  	return -ENOSYS;
>  }
> @@ -208,6 +211,7 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
>  		mmu->funcs->destroy(mmu);
>  	}
>  
> +	kms->fault_snapshot_capture = 0;
>  	msm_mmu_set_fault_handler(aspace->mmu, kms, msm_kms_fault_handler);
>  
>  	return aspace;
> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index 1e0c54de3716..240b39e60828 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
> @@ -134,6 +134,9 @@ struct msm_kms {
>  	int irq;
>  	bool irq_requested;
>  
> +	/* rate limit the snapshot capture to once per attach */
> +	int fault_snapshot_capture;
> +
>  	/* mapper-id used to request GEM buffer mapped for scanout: */
>  	struct msm_gem_address_space *aspace;
>  
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

