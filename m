Return-Path: <linux-kernel+bounces-417334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73749D52BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2F1281D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365B15990E;
	Thu, 21 Nov 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKtDv2sS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D73B67F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214765; cv=none; b=RZl1rKl9gqR2GEY1VpC5YcWnmTbSDtp1J1u/K8m+IJgjDHmGIcO+WYbUd3eYAea6/jmZJAt+Lib6YW4kw0D/YJWiMsgCcqspLIF89r16l7hMUjKv0S/YK9q6qzHD/n7hcnkt7YBQsPQm+jKRNWsYHv3zSsLQCn+Ivc2T/Eghelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214765; c=relaxed/simple;
	bh=3UUlF0HmxlSVz8Df4mv35dnQDsPGSDO7wbgueULFr/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV5k7JltiAfTEGrr/Xdz04N9oaptsIlNAvdpnvdJo/nCLL2EJvuD4h0b2BG7NCi7h7NFQCerZH8hyZ5qprS8nXhihRn21IalNoz/iWrNCFLkOIHZ41J+M7Ky4eK2VetP+wYCa0qyGxhYUBvEP413I4ol+NJKkJKYdqYwGVHKe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKtDv2sS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f84907caso1338268e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732214762; x=1732819562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnablajdzkJVJy6Wp4cRfkLe1DSYH+fJmZ0JrWl5Hcs=;
        b=TKtDv2sSEGqIKmg0RK6qiMmKkwmtE1dQGguTGiu9XutIdt36vETisvDh3szpJIqw8E
         OFlqDE+drW6IWw7YDLcsUiiwn4sYfT0/Q3zXrirbVbP/vRd79Ys2xe0qNJKreVyFKsTF
         Hq92KvSfEpQtmTkJO+eDGiX+nECVtSJmS2ltuqjRfKuimEp8T6YaA/RXqtkDxr+3p05+
         W69eOKgPuMWx330i5qPiqGOUuznaYUCX2LMdKxGktdzXLWq55xJgmejSpR3NUq/PV43P
         ceUcIebASRm3vFuJOV9iumZYIJ0CJJy+u0PiGR7ExuRtPSZhcuIADU0nZm9v2qLMlqI3
         Hzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214762; x=1732819562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnablajdzkJVJy6Wp4cRfkLe1DSYH+fJmZ0JrWl5Hcs=;
        b=lI32DjOcwMIXRSezy+YgANlQRRVS4Ku5jOu3QnwfZ/KWFkOzzeiKB2QstllbtnTqXC
         4lJMHSXVhRNayR3VJMBJimAauIqSNa0YpLPILmKdRKtfc+afHBfXABki34DNqUFGA25J
         wJhYb8NTOcDpT9w1pQQGyr4GG2UKQKUrajDWLdC8JXfFoSqLluHO+Ko8kZ2n3QjkCBS3
         BtGR9JU/y935x7A/qLl4Ql5XP6cpe55LamV+3oWqK8skF4Bcu2ObMbvKvJ27/U4zcBmW
         jebrpzzoqeQkHyjkUjdtEp6AaHyerZPlYQdlVzyjhW+iuxWjx1QHfiROU1LhHEuPzduI
         uXOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqt6zsHFh0tISxlVKqhai2LHMkX2jKUFzxDvaRpUixEukXPhioks/y1QDxxO4gEUgmimUKachtQJGqy1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf+KJUiFsyfYml6xzzV/DAHnRGEvEl0J1ZKgVk0FaavmLvfC4
	7IAtsHU0fZj2GgxYIWs/PH/8VITPr1mkX5jLdOnjXlfGuVEG2CZ6umqGbRZWFr4=
X-Gm-Gg: ASbGncu3HzErruhtPkUvRkzPLyuMgBKCmTEJoUt7YHW9uefC/TalMKafuvZvCZRCWg8
	SUPNH3WWW7oXG/KTmrUAZCeD4TgHXZyxfKY8T4dPIUiiSpYnwNZSknvUzN4M5qLkKAnqJeninMD
	dkHuinrYZ1gxX+kBEKe2AwYOy+I+LEgt2bnLCXOAyxvZQzle4Q+dRCE5J0CcJU6TWo1Pavx2sXY
	Gq9rYXS2Dl8NBiS7DrZwiX2I2VqCRVqmM2Is9/m2M23yZtLW68KoOQ++sEV7736/ChrreDH4NOK
	G7YpGJiJuxWExmxy5w7XA0BD6nte2w==
X-Google-Smtp-Source: AGHT+IEFMJhZvAQ6Q6Wl16HShSZo5FGRcfel9GsUflAZEQIhYBQDxaV99Gquo8VIj1VgFnA8lOzrRw==
X-Received: by 2002:a05:6512:2383:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-53dc13417b0mr3615259e87.25.1732214762476;
        Thu, 21 Nov 2024 10:46:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497dbfsm44161e87.244.2024.11.21.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:46:00 -0800 (PST)
Date: Thu, 21 Nov 2024 20:45:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/11] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
Message-ID: <yo7silisbeesgdn54x7wsy2tgqw5wcjzdbm7ay7htajk3k6xib@v45gfvdtlaie>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-5-4deb87be2498@linaro.org>
 <stifp2gtqxmegysrewfuwdsxpqin6zznvqndw7rj5nysi6rq4g@543stomenpvf>
 <a1aa497f-3be9-4870-a09a-d91f10091308@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1aa497f-3be9-4870-a09a-d91f10091308@linaro.org>

On Wed, Nov 20, 2024 at 01:37:16PM +0100, Neil Armstrong wrote:
> On 20/11/2024 12:42, Dmitry Baryshkov wrote:
> > On Tue, Nov 19, 2024 at 06:56:40PM +0100, Neil Armstrong wrote:
> > > The Adreno GMU Management Unit (GMU) can also scale DDR Bandwidth along
> > > the Frequency and Power Domain level, but by default we leave the
> > > OPP core scale the interconnect ddr path.
> > > 
> > > In order to calculate vote values used by the GPU Management
> > > Unit (GMU), we need to parse all the possible OPP Bandwidths and
> > > create a vote value to be sent to the appropriate Bus Control
> > > Modules (BCMs) declared in the GPU info struct.
> > > 
> > > The vote array will then be used to dynamically generate the GMU
> > > bw_table sent during the GMU power-up.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > 
> > LGTM, two minor nits below.
> > 

[...]

> > > @@ -82,6 +92,10 @@ struct a6xx_gmu {
> > >   	unsigned long gpu_freqs[16];
> > >   	u32 gx_arc_votes[16];
> > > +	int nr_gpu_bws;
> > > +	unsigned long gpu_bw_table[16];
> > > +	u32 gpu_bw_votes[16][GMU_MAX_BCMS];
> > 
> > We still have magic 16 here. GPU_MAX_FREQUENCIES? GPU_FREQ_TABLE_SIZE?
> 
> Yeah it would be max frequencies.
> 
> I tried to replace this 16, but it's used as ARRAY_SIZE(gmu->gpu_bw_table)
> like the other gx_arc_votes & gpu_freqs.
> 
> So I don't know what do define and where, and how, a separate patch ?
> 
> The define would only be used in the struct, not in the code, or whould I
> drop the ARRAY_SIZE and use this define ?

I'd say, define in struct, ARRAY_SIZE in code. And yes a separate patch
changing gpu_freqs / gx_arc_votes would be beneficial.

> 
> > 
> > > +
> > >   	int nr_gmu_freqs;
> > >   	unsigned long gmu_freqs[4];
> > >   	u32 cx_arc_votes[4];
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > index 4aceffb6aae89c781facc2a6e4a82b20b341b6cb..5b80919e595fa1ba0a3afcca55feb89e60870cb1 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > @@ -44,6 +44,7 @@ struct a6xx_info {
> > >   	u32 gmu_chipid;
> > >   	u32 gmu_cgc_mode;
> > >   	u32 prim_fifo_threshold;
> > > +	const struct a6xx_bcm bcm[GMU_MAX_BCMS];
> > >   };
> > >   struct a6xx_gpu {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> Thanks,
> Neil
> 

-- 
With best wishes
Dmitry

