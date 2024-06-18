Return-Path: <linux-kernel+bounces-218861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E790C71F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7330C1F25EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895411AB8E2;
	Tue, 18 Jun 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sc8Q8mm+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976814B083
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699324; cv=none; b=BLDHtumzsSmblRooiYzoAKK2gQZbQSH435mkiAcgJ6/RJ54uzJT+cpPRvbKqQK7NxUM+h8nJyo42gWw2MLWcr123QBkImWBBLUxiedZOlTz9NecuzOCBUhFoeVcDCrF0KdsKGxH5JBDcS3vIbAv96BV8HcjowbIQb4vJomf9Tcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699324; c=relaxed/simple;
	bh=J7Ubp8bWtL9MUA5mJeU224tE13X5WxGju7ElxE2/nnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGG6ZgWTBgbEvVGJpzNKbvbldSVCYdQsjTh5BWGfz2YqwkdPOqr2Nj+HG7hpMoXNB3etVAl+pvnMJQPheVCKwDtN0V3DLr5KueetbiBhBZa5KxG63udO3rFEGlID9bMr1xUz3pHcn1qlTDhDREY9A4sw11OA8MXtmOmlt9rff/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sc8Q8mm+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so50807941fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718699321; x=1719304121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYZjAGpgEt4oOgf7LT/jfEKyned/wQxFG9qSD5B+G2c=;
        b=Sc8Q8mm+DIk1cJDvXMdlrDhYlT3dCmzSbWhtCjXyEyFOVzdxWXFx7mAppiYwcJmu0+
         VV6PxTYonpHYfMylsVwX+BSkKStbOCTiPkH0ABj9DvMUIs5v+lx9K9tbiRXTLswQoV8o
         JVfvpeFz8h2ANI4D7VsmwZ3VWP1p0MN+El1CxLOWO5VzE/eFfusYVrTql76kR4EazwIk
         eRkp4Vleub+SV05JvqgsoVRhec9/vmMK4folP+bWEa1MjKaatbjVXQ7ee5sv/z9CVIky
         s1Jw16p4GS/mEEz8lSSaKg8qLf4af97eJZUMtoWIk61UsbLmTQKiYHdFa3ZZw6Yr6+P2
         /v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699321; x=1719304121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYZjAGpgEt4oOgf7LT/jfEKyned/wQxFG9qSD5B+G2c=;
        b=aazcKoiNO7O+T/UCs/m7slF+rnfFM1jS49d6yiZFUhN/da1eJSMc7I2HZ31fWDXrmX
         S14lqXH+JN+PFVKvwXIEGV7yYUvHD17LnIX0xBzpIgGtoFxc4OqNwTpdef06MZU/nL6u
         GFqMyEo4z1xxlbFZj0gjE+1Xuf0IgOZv6SdI/1Eo71pIXMtJGXPVrGVap2Q2lgbS+5SH
         b5W7H4F1o7D7mz1HjZ2ghEEsBtLMOHnWrvX7AjlE6cfpSZ5A/Uuml44K63sclHnKGdBf
         IbaqMJWFyBPc733JGIcZpvmg7NsFcLPg9V39DDgOmvuw0I0WJ9Nmlbqj+58Cx79KF3cX
         ex+w==
X-Forwarded-Encrypted: i=1; AJvYcCVbyJNT49P8piok3GH+Arzz+WBcCEck2sFCEoQSMn7BtFqKJE5MB1pvw3A2i6a3FvH2buPwJwRUsmuOmBJAWHVoKQ1RCeQvfI+xKYcA
X-Gm-Message-State: AOJu0YxRrJggaSJmRu8Rc9XsK7leCtnQCSHDya2677Yy/4H2+ipn32A4
	vg74nmigfU2EBe7uE3xpazrMohgjcsPveaZopoQqTlLAnEPekbfFKO7IqB5DIuM=
X-Google-Smtp-Source: AGHT+IEwq8nhRRqn9q5YxuzIXR5AcAtlRS1/gJNxZ9ufr0fPbu7ispovCsrRMZxqawaZ5SghogxRog==
X-Received: by 2002:a05:651c:b14:b0:2ec:f68:51d2 with SMTP id 38308e7fff4ca-2ec0f685646mr85838011fa.11.1718699321178;
        Tue, 18 Jun 2024 01:28:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c7813dsm16388561fa.76.2024.06.18.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:28:40 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:28:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] drm/msm/adreno: Move CP_PROTECT settings to hw
 catalog
Message-ID: <eob2zex45yckr2ufuq5deerpuiwhcyfpzxrqj56zoc3t7w4uye@kwvr23fxhvex>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-6-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617225127.23476-6-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:51:15PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Move the CP_PROTECT settings into the hw catalog.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 247 +++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 257 +---------------------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   2 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  13 ++
>  4 files changed, 268 insertions(+), 251 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

