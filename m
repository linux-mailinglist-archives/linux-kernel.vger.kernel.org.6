Return-Path: <linux-kernel+bounces-415649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94889D397E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0A4B267EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF685197A87;
	Wed, 20 Nov 2024 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sglkLF7R"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE419D89E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101565; cv=none; b=f5HJugIFdvQbxij7n29qJzNWfKoebh0tOqBHFgOn7Ps4J+H0hTvYwuaIM1DnZIH4osVXKfwk8eSsYGIU0QoPeL1i2d2UwRy3IE/Zq5/Q4MTVQka1+pcEr8Q0WnBMwZ2SVam6IPh8EpLDv+RfNyG16iWikA393XeLjufW9WntikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101565; c=relaxed/simple;
	bh=92Dmkw67Yjgb/1xLInbl4rH+zqF32qiTgg/ksPzkVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfITZd24HfYTSK/n4sEa+T3aWqvioa0OV3DAKVnuRnep0BUys8umE94wk7d/OTnXzTANApysfk5qSnhybNygf9SlgEjYsTR8P1/895GRAUf/uLZY6K3eyfKuxPXr6HzAiYD1mUS7ow9MOSQt+9enn41kI6RsMkjJJ3Ujb1HHL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sglkLF7R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so23685221fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101562; x=1732706362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rdRMEcIeKMxsgTSwvPC2Ggi3/Ka8/LNcXy0+kUwfLg=;
        b=sglkLF7RQfwdkl6WwhseePbAlmVCwE7AAenf/kPDt+/3lGZ+Zfdv1ALOuqO3bea6YV
         JEfrDY+EtRlwwcEW/5xgy0YrXWnvd24RabkFrOO2gwMxk7h4FfA8xI7qvjgCW+XoZuYa
         nNkFzHg/feCHL8jNR01T3gxg1nzw3lP7cPCYcVqPiq/YzFcnqr5musqsbP/q5xAqF+x7
         QUCKGdK1N02GFgkt9VstF4maOXvA6plbTwOnrnt5T+xJXxtmYEOvbACeIS9JC8UYrwKT
         G1iPx8OTn279uqKv9KYSXym7uWX7W6T3io7tvCPjNyO3Rms08uY3cWp7qSxu4+p8PrnQ
         EIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101562; x=1732706362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rdRMEcIeKMxsgTSwvPC2Ggi3/Ka8/LNcXy0+kUwfLg=;
        b=OVmJ+1q0QcIrmu2u7jKLVeTQb2qIyAzPnpjWAOXdVm5cK54z6jTXuE6au9kpWyDptT
         OL4J15qITHX91Sqe6r8Sg+NNONUP+/Si5Vs/Oz9wocpU2O07rV/SGTLReABpY1C8MRQb
         eN1rJIJ1HRAyCbbgpEFpEDvOyS8gxAnurbrAzhcEqqIcxb0T5taD0FQmoUaKbH6WcSCC
         pHEwv1pkc6LxUKzu5Dl90sYxP/g/YcRbtSUSX3j8IkzFPhVpx7KVTyO38GZwFWZbt4p7
         Z51pDgdSztO1zHzAkKUHi+df43zVMi87aUbngldafqpU2gcbTWcwqxOiu+HMYWa/vkmK
         DlBg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Z+UfrmYZvrVSwBGICBfE6pf3FWmzQxNLvvhgme4AiLT5177+K03OGOo1a4gRhEq2p7lRGj6hN4oOhXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIICLqBoO+MO//jzn0GS4+nu5sIFbLQYNzWGrDs0lBIHKh5dQe
	VjeZqZqqsHt8afb5gRlmZnvRJWed/zkPRj9oM5WeCtf01a9BwRuYXrKYtERdQJ0=
X-Google-Smtp-Source: AGHT+IFz4/wMpaCWcpDGZw/e6uCaZaeyezhXZTQfdXVBkzxU2f5cPxItg85GBW91OdibreTQE0mP0A==
X-Received: by 2002:ac2:48ba:0:b0:53d:ab10:234a with SMTP id 2adb3069b0e04-53dc1333888mr741916e87.21.1732101561756;
        Wed, 20 Nov 2024 03:19:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4670e6sm595236e87.159.2024.11.20.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:19:21 -0800 (PST)
Date: Wed, 20 Nov 2024 13:19:18 +0200
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
Subject: Re: [PATCH v2 04/11] drm/msm: adreno: add GMU_BW_VOTE feature flag
Message-ID: <iw75ptavkqw3vybfov2f7koz5nh5lfzxcou3wey7rdsqt2gj5n@7luy2kqrzkj5>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-4-4deb87be2498@linaro.org>

On Tue, Nov 19, 2024 at 06:56:39PM +0100, Neil Armstrong wrote:
> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
> along the Frequency and Power Domain level, but by default we leave the
> OPP core vote for the interconnect ddr path.
> 
> While scaling via the interconnect path was sufficient, newer GPUs
> like the A750 requires specific vote paremeters and bandwidth to
> achieve full functionality.
> 
> While the feature will require some data in a6xx_info, it's safer
> to only enable tested platforms with this flag first.
> 
> Add a new feature enabling DDR Bandwidth vote via GMU.

Squash into the implementation patch.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 4702d4cfca3b58fb3cbb25cb6805f1c19be2ebcb..394b96eb6c83354ae008b15b562bedb96cd391dd 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -58,6 +58,7 @@ enum adreno_family {
>  #define ADRENO_FEAT_HAS_HW_APRIV		BIT(0)
>  #define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(1)
>  #define ADRENO_FEAT_PREEMPTION			BIT(2)
> +#define ADRENO_FEAT_GMU_BW_VOTE			BIT(3)
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

