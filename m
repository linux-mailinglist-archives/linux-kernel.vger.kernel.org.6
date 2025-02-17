Return-Path: <linux-kernel+bounces-518273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7FA38CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC6C188EA85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7623872E;
	Mon, 17 Feb 2025 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHZOkN+6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0D237713
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821838; cv=none; b=hYF7JwsC5yMI5lXSSTDQtl8kgKyXDTLfTbebHKbH5OdzO6c5Fr0h1pzVcK/WuAxEudu1NUREwp7o5wO9IKBoN8AFV78scdBAEUwh5yeStAGhts3ncMr6/QQ/z1m6LoScLm6ZolFxICm/ga5OyA4nSTsseKYmGy+/5nvBRIAn80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821838; c=relaxed/simple;
	bh=OtQGjZibfaoAgSCWyYg6KTXMKcn/tqRoYLIaZ14cr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/hbG/prrj2uRAPpzNjawBXQGybAXDAyttYu1s36Exx48q10CblVRoqe7iydpeKfvSgOpDKcvSA/jyNhXpTAi3W0iSCt3Veta/yOytEifpe3x/12UB3aMccTyNd3XyoMvYTfB+v201/ZUMNtNSrcVAbOYs5l5J2yfAd+/eq4bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHZOkN+6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5452c2805bcso3498304e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739821834; x=1740426634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7XMMxmB25I7aAKLMKpG9EtSe+ebYBtU0fhxbENZPlY=;
        b=DHZOkN+6j4g1JB2ZqNIdmdqxxEnDt3S3x4OS3nQuRRYoCn3Qc0uOtIZsf710fFLMx5
         uguIm4xXeaeg2VI4zzn7UQgP+FYNfghQ+wSoSTdHw3ILdyWCAD4ykXIXtOzfCyTaYm8F
         RTW6RhptQrDFfgzaBugi2mgAKm3syyJfGKpGTqNxUQaNZrP0hHPDFtRtHi/XshvzBaV1
         0+I+ik5xB1vBH9zN+Xq71eK46ONniwCnnok2Qps2NA6FVtPmIcoR0HbimYyeSxySJQo+
         Wv+V6+VmK8Oxh2225P2N9pxdJcA7Sf2uj1xubqiZ46Yv9mk9ITPxESEjud/LIXAaFFVt
         +NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739821834; x=1740426634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7XMMxmB25I7aAKLMKpG9EtSe+ebYBtU0fhxbENZPlY=;
        b=ph7rsJWYWRvqoB/gUcroMOXSnXAlEQV+yORWFvxi8F/OArp+AmcaML2eYeiEeIpwkR
         kSPbE4wz46nCBSSou/zru89hSUhpo2X0g5UqjSUiYIX05FVe0KKEwj8y2QmKHhEzeATo
         /dY3QxUsKj3PY3E2esHqiMIJllY5nHuOSP3wz6f63MeLTu+BM1CQQ9WiyDbzjn32reQp
         LtvYS/Q5TgS1bRoHIwFFBZKUXIKT0PFIvBWmzJqGXjn3f47Q4TiMcSnb27UGuiGQPM/C
         kBqLZkwWSMV4URv7Sh6TMuhuMjzEQDvrVJmCTxiSHEW2zhkAaxclF2FfXuMUFB+TbpDJ
         oH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn9VR4MZUM6pljTZ4UEmsVc9hNlPgDktx1E2aBUFDrlR29iqc6Jfs6h+E3FJ+/KQzEUAF6Yc+3OYIfn/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYO8Tb7ocgday122XXoFgUjYcUkEWLzKxpFv3uvRyVOiw7NoBR
	94AQ+S7ZOBlZej6e5yj2zvzgEstDfmQ9Fcbzl4EUKa5wZufy8uGGjBjHrr15G2g=
X-Gm-Gg: ASbGnct/XVDrBKlzyj1Nd0/MwvEP1jGTp/btnffIKyQjV+vaZ5rkFw/UiHSR4UtoFlR
	rH6vbvOlGoc9dC+CPkIyibHCOujvUO+mfL//TsWCpSRSIQHv/K+QzS2rTScQnve5lnI4ZIQaigW
	kaVnf/cTPWNeqFkdBry12Y3scHMBJKNJB1faMiEh8uWTBEfQkaxjzQm7DUbDZ9vIWhQQs3Lnflh
	lcluecSzI9fBMGIBGheLlOD5ZFZ2Eab3r57hm413SVj/k9GXGDKoksZMMcrL3kXRZhHBAJ2Jt7f
	Hbc0+xF34oJS5ebBcVKAJiFexgZQcapPw8jx07ITq1ryrG0sLbpoSvfpZAMvYUQybmhiNZ4=
X-Google-Smtp-Source: AGHT+IFEnXuT2usVcSoMTmal4BeyQztiA9BaCKYabRMQm3dIpVeX4YHZzzAuOaY3bq5cOJl0zMdGsg==
X-Received: by 2002:a05:6512:1194:b0:545:ff1:bcd4 with SMTP id 2adb3069b0e04-5452fe2e442mr3602142e87.3.1739821833664;
        Mon, 17 Feb 2025 11:50:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54522858229sm1504623e87.4.2025.02.17.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:50:32 -0800 (PST)
Date: Mon, 17 Feb 2025 21:50:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/15] drm/msm/dpu: check every pipe per capability
Message-ID: <sd3u2l4epms4ttytoc2bqrzsqfxnphqkutwkxremjon22ven72@3rohlpaxhryr>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
 <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-1-c11402574367@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-1-c11402574367@linaro.org>

On Mon, Feb 17, 2025 at 10:15:50PM +0800, Jun Nie wrote:
> The capability stored in sblk and pipe_hw_caps is checked only for
> SSPP of the first pipe in the pair with current implementation. That
> of the 2nd pipe, r_pipe, is not checked and may violate hardware
> capability. Move requirement check to dpu_plane_atomic_check_pipe()
> for the check of every pipe.
> 
> Fixes: ("dbbf57dfd04e6 drm/msm/dpu: split dpu_plane_atomic_check()")
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 71 ++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 35 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

