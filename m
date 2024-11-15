Return-Path: <linux-kernel+bounces-410305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9409CD9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F21B22C59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A20188904;
	Fri, 15 Nov 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hqaj3+Sa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7515FD13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654477; cv=none; b=a8p4wG76J/NSP/1E9C5b1N0v+HeflwFD5khrtNjeTQMN19Xv/eFH6cz4o9vebA+PDbiOrJcyraHuMZALly+D0NCzAoXSi5i3AIrxeIk74df3oD8Yal1X2YmJixKntdAjK9308Dwj3XCHXVoLCt2zYjcSaOGZwpOJl36kvmuLBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654477; c=relaxed/simple;
	bh=rPsEt4qZfwQKlO2eqOGfESlRxslv9lRvlh9ZaHQRvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA+uaB4gpus/87nz7GcgKv+nbKSnD6RhkxMekcdGBCKesTalT7Znt8JXuDcrwMWAFECqIc9ToVhzbYTwxuY+ZLvIJ7sN7oLPmiEVb7QFkmuzNWoE3P4+9e6NE8YHDlHkMwpckoqKNSV6POUYtmk39IzI3jZRFbWzPQR5xueTgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hqaj3+Sa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso21122131fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731654474; x=1732259274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6cKMaZCVTkVV3G8XB5LiWFxAM/cEoFnUMU7GwBqpgs=;
        b=Hqaj3+Sa4TPNvwG5DtzuZybzjJQpdnrm4y3TUcU2q/p34KxXT9zJNJQ1hZbyMA8srW
         Zv3qlB0nktcOhvfTiAPDUnofC8Q6gRXScldcrQMrpll5/bumdTp2+uK2Z63tHgiKua/b
         uTLxcxEBYIqXq4wzjSQ77PNzYz9vnAJnkn3fUk0JKGndGgchwXur3mdO2bHSGzfqjG/K
         QMV1t27V3UX+OtlRs4htwdMbCOX0uZ7lIvTqNKf2kjXrqzCvD/EXkXTMGH93AyA9eLZC
         G2OSLGWZqpusCbFAdGIJ4YwSRbmLO5JWufUyVQv+Rufhdw8dcssmfHB4pmm7XezSoLEd
         89Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731654474; x=1732259274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6cKMaZCVTkVV3G8XB5LiWFxAM/cEoFnUMU7GwBqpgs=;
        b=ifhJLOMXgIZ9fyGCnt7G57n+MszMC1otyupJ0MJyKkAFVB3S7AJr1ODDV/6nhEhdc2
         Dx46uhhrL9t5MO43uuUiA74TCQqwCaqMcCRsqxgEVam0eDvgLRkR9duIVIK8QDVk8MZt
         tFLUlL2fuDnrhMKd7/QduKSHNCTXxvgwlSHdStvFuunogvVUuVENpFJ5X9laxeCPt80w
         dBXwjbAmLR8iUvvPuPGwLYfR0c2jy2fqJL+OBfpYCpGZM9x8izMwaeCkZR5zL4I+oSil
         QLY4d1zfTt69G0u+y8UUjb6WdHmPvuDOuyPbClzwYwH/enWI3we8xZuMJ8BuvVpv+qR2
         vCbw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/sHy55gV+xhDNQbzEMAMSERHYcoRwMaWF2g0TnYFYy53X7g3vSHeaq863FVgc/a5Y8DHdnxXpdTtIhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkL6yWFEDultwnRw8dS0n4La6pnFWcRoA/UXOF4LsTFDOqk6Kj
	N9T6f5tbw8OwopKtgpC26qTne2s7EZAJhYP8OSHCq6Yfo00GRNx5b0GSGtYz4dQ=
X-Google-Smtp-Source: AGHT+IG1JSV4aGNvAct/tUZocWSedempVZ4kzonrQKqFj01UuIlfknN42Lm94EUeAmexpvhM1Oz5bw==
X-Received: by 2002:a05:651c:4003:b0:2ff:6152:d773 with SMTP id 38308e7fff4ca-2ff6152d8f4mr6807941fa.3.1731654473778;
        Thu, 14 Nov 2024 23:07:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a295fsm4440551fa.68.2024.11.14.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:07:52 -0800 (PST)
Date: Fri, 15 Nov 2024 09:07:49 +0200
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
Subject: Re: [PATCH RFC 2/8] drm/msm: adreno: add GMU_BW_VOTE quirk
Message-ID: <sgz4h6rlmekiwypaisjbnej326wv4vaqt3mgspp4fs4tg3mdfx@cwmdqcu6gwbf>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>

On Wed, Nov 13, 2024 at 04:48:28PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, but by default we leave the
> OPP core vote for the interconnect ddr path.
> 
> While scaling via the interconnect path was sufficient, newer GPUs
> like the A750 requires specific vote paremeters and bandwidth to
> achieve full functionality.
> 
> Add a new Quirk enabling DDR Bandwidth vote via GMU.

Please describe, why this is defined as a quirk rather than a proper
platform-level property. From my experience with 6xx and 7xx, all the
platforms need to send some kind of BW data to the GMU.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index e71f420f8b3a8e6cfc52dd1c4d5a63ef3704a07f..20b6b7f49473d42751cd4fb4fc82849be42cb807 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -57,6 +57,7 @@ enum adreno_family {
>  #define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
>  #define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
>  #define ADRENO_QUIRK_PREEMPTION			BIT(5)
> +#define ADRENO_QUIRK_GMU_BW_VOTE		BIT(6)
>  
>  /* Helper for formating the chip_id in the way that userspace tools like
>   * crashdec expect.
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

