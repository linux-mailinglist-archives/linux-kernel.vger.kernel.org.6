Return-Path: <linux-kernel+bounces-536652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE47A4829F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66E21887ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4FE26A0E1;
	Thu, 27 Feb 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odi5uaSK"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDC22D4D3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668869; cv=none; b=PQg+vrV/RtBT/sxIrQjVp50cjYAxUkA0+lmWm1yeDuWem5O89zh8OlafQnnntblOMTtBOdFncnE8YJPNBDY/Epm0ZpiYm57vt/ZgHNcCTX+5ax97utn9DCGxT3pFj1pjZ1gzDS3jk5A/LVaAoQo5E1b9reXHEjcQq/lj4AA8G1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668869; c=relaxed/simple;
	bh=2n5bNgf6szujo1VmFwYXqWseruaD6/HFShhaQ7E/r+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMdnuvB92oRU0TT+Fl3vHvnZkrH9Ju6E5QJEc+DfIbKZLxboLKcAgIuDNstFczd0JgmZVZBopokeyjeOLe617b79zPfj1WmOQf7QeuydDeIEZOZ/UrwMthb9nst08zblKRvcbP/mirBPbN4uZJn7FWK/U6hYQvbY3X0dl98SbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Odi5uaSK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so10013991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668866; x=1741273666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PK0RBzU+X7MrHf7OnoKvPr4hQd6gs4EWXTwKEiRaqcY=;
        b=Odi5uaSK4Fs+GVFjFRQWF4EJYAdRIk+w170WKCBEGiqpT7HsP/5eVf6AdC8AfgwWM0
         4Se0sVAnmzeLWSoOQWjVH7AEmmaAWWxExsk7i64Bh+obwjJ0wpfk0ZIpzwSCiPqwZy8s
         y0EpVJNg1iXZuBsqpzp87vP7EQCU8msQLqw1S7gnGsiCJEoVSVQUdy40gPOCXPg35uuR
         8IAWSnxKNIs/jVefi7rbQydXDFH4XJvlWBcmdbJbRlqp//F0I/vy1o7zAS2+L9N8TU2e
         ccKDjnKDHGcnPztGbbuFJQc1O8p3y/7k4F7y1ls1oKeH1ujKVcwEh8DxLkj63uvd6pPS
         7FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668866; x=1741273666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK0RBzU+X7MrHf7OnoKvPr4hQd6gs4EWXTwKEiRaqcY=;
        b=MMoYsYGUbpiKtODhqzEd+NL7XFdKyJKqu82uDYiooZpUo0pnvSto7vjz9Mal+AHl12
         sN80Mg9wtrepcN6XAg0cRdWJAqO6mYD3hreLT457uZyj0uLnJ9N3rsNCzHT1a3xGhOVe
         OX/nPFykW367XQiywuFog86p4TOZECzpA5MuA7wbz2f8Nk/X4MgI9isEfaiEWrrWAYwe
         2eYQMqfpDfR0teBroeuKtjrjCNse3uTplVNnhjvV9idfRGTPPvakvhEc/lMQCH6PcW/9
         vr+RovM2ReD9MDHuqeqbwEw/tM6yOmLwnG1k15w4ChcWiZCDaduOJc12op1A8hjkGLba
         VlJw==
X-Forwarded-Encrypted: i=1; AJvYcCU3QlQB9Wed1CUXcwTXJz6hSZA1qR3Mx4hiRlq8DZ1LXen61LVVw78QMVECzSdEn7JlXzta4sflMBuwJE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiFx0edzIVj7jPxTajjyXoJiaFQurqKzy1BxF3JYSZDh0gkST
	huwGW5CPPBOdKq8TL3GflPV00jDyEP8Habh83h1rk2DYQdrNKXcSz6undnLvzpE=
X-Gm-Gg: ASbGncv8cIoivRqD6yXKccXG/9xOEADl6yr1y7CsNkBba/CEmCsEOR5i68+S43omZXe
	rtHX+t5R+crto+GBvzvMkMH2bqi6rhd95RwV09so0VcguM+APyO39SBPu2O+mFvOW1qniX5b/v9
	1+7D7x4KRubuFiUG8fqrX1weiyRGuQ40pG2OWbl9v8am3RqxGJxa7K4QqDzt9JwXugN6ZKUHnLE
	R813x+5Bxhggosx5Rtgk2Ce7QYPG2o6vayfVumk6B1aPpt7F0rdS/Z0SH+SNpigm4/NlA43ES2U
	Hcou1skAYs+DkucbgX3VLNbMin7pgTdFZM/Z1t1g83GAawYVyxXz9WhvbvuQi5Qwizlek2trXYr
	AZWHveQ==
X-Google-Smtp-Source: AGHT+IGaQ//J8Vtjfl7pYmy+TQqYupxV6d/Q8c6JMZHrTt4arFwXtLg1U0DaRna2TQ4oULMoVcUSzQ==
X-Received: by 2002:a2e:7c0f:0:b0:308:f479:56b3 with SMTP id 38308e7fff4ca-30a598981c2mr93380391fa.9.1740668865510;
        Thu, 27 Feb 2025 07:07:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867c8f7dsm1855811fa.48.2025.02.27.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:07:44 -0800 (PST)
Date: Thu, 27 Feb 2025 17:07:42 +0200
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
Subject: Re: [PATCH v6 03/14] drm/msm/dpu: switch RM to use crtc_id rather
 than enc_id for allocation
Message-ID: <se4b4kzp3vej4b6albecdc2t65ueiuba4kidutwvrv2rcfyjwr@e62fn225jwcr>
References: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
 <20250214-concurrent-wb-v6-3-a44c293cf422@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-concurrent-wb-v6-3-a44c293cf422@quicinc.com>

On Fri, Feb 14, 2025 at 04:14:26PM -0800, Jessica Zhang wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Up to now the driver has been using encoder to allocate hardware
> resources. Switch it to use CRTC id in preparation for the next step.
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v6:
> - Drop duplicate cstate initialization code and unnecessary memset
> Changes in v5:
> - Reordered to prevent breaking CI and upon partial application
> 
> Changes in v4 (due to rebase):
> - moved *_get_assigned_resources() changes for DSPP and LM from
>   encoder *_virt_atomic_mode_set() to *_assign_crtc_resources()
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  18 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  10 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |  12 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 189 ++++++++++++++--------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |   7 +-
>  5 files changed, 110 insertions(+), 126 deletions(-)

This commit breaks several tests in CI:
- sc7180-trogdor-kingoftown:
  - kms_cursor_crc@cursor-dpms
  - kms_pipe_crc_basic@disable-crc-after-crtc
- sc7180-trogdor-lazor-limozeen
  - kms_cursor_crc@cursor-dpms
  - kms_pipe_crc_basic@disable-crc-after-crtc

Corresponding pipeline is available at [1]

As I had to rebase your changes on top of msm-next, corresponding tree
is available at [2]. It might be possible that the regression is
introduced by my rebase.

[1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1374165

[2] https://gitlab.freedesktop.org/lumag/msm/-/commits/msm-next-lumag-cwb

-- 
With best wishes
Dmitry

