Return-Path: <linux-kernel+bounces-337797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5987984F19
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B211C22D86
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E618951D;
	Tue, 24 Sep 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4PIyoFf"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E51891DA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221492; cv=none; b=DUX+HPFN0IkuGjVAr5gwHjdHqYtLXp34ZQ1DqRVWc2yD0tNpfJ6n71FnniqUgnNLnuEGqZoAfm3xp+KbcNSMGMkQWGzgKexM2cnLOX5riXQATBrj4DN1TdKo0gMzcqtcafUYpneaq7VY4M2X9ytyY1Yvq8SQ6f0N4FrsLwGp4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221492; c=relaxed/simple;
	bh=0i25XNsBDwe1ivygc1JspvhPQ32uh2UA3hYsa1c3VqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eju3GjikCoaGL+ke8fcSho5f0ssbSj8liganC3shRonx0hhNCgowgncOaTzJrDSa3AaFhnZd4kQW8YOqCZLiymrPgECSaq9eglo4p0Zz2hAcGbee0aOlB/wcsOiW0tV0nfMFOnMmEawQWQwgQJCIforlwRwLQdjIfHW7yYORwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4PIyoFf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365392cfafso6358259e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727221488; x=1727826288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTnQcaz+QGqGQ+VZWuLMX82hxnpgAqAgeULVZprajdc=;
        b=E4PIyoFfkiZ58m+P8xdund/mCLCbosws1H6GBCYM2/gFRzmEdGU1ZJ/S5jDiNf2GYC
         EeYvXArDCNYDKg149m1c9eog4EqZFaB8nBhfl874EPXnrq6xNlB3jXNe/cA5vNiQA70w
         /yIZcjkYlzrZXifPCHPLwDfojWskk1ZPkzHa90tlUVnqkxei6W3nV+x9ysFNBXylMalV
         NdWtv8BG32zavRHRy9nxpGDwAcD7rVlYQb47X0ZwqrsYL6mbKf9/YX+wqeLuWqHRufFt
         glzhvmcGQ+btGMFpwt5Idt/5gMaiKnFaIhlDivuI3mZT6GocVCK1BndbEHM7QLnSRePf
         jWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221488; x=1727826288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTnQcaz+QGqGQ+VZWuLMX82hxnpgAqAgeULVZprajdc=;
        b=blIq7ovCxDnkBUR+ebcL+x7x+j+h5Fvj7hd5DtZNRTNduIAygOG0BcGLVFmDp1ZKte
         vvjwzto7gKktTo24YcXLupD+wR67zIqYZDUroSrf4PPfaEsjj1sb742UzvdU6AVKvQCn
         f9qD0kix/5tjyMTFIQGWR1tZidsVgRqoYzWMiiA5vUb36gku5K1HpyrQv00KvHDmvQnq
         PIIxgZ23z4cZ1BtBiGDMMoviGEIfGFly/9GFAfakqeUZBcFtLP/u+OCAPoE3kKFagryN
         Y2QmxKAvcvXoOjfBEYN5c4OlWa+hK44rMvRgDGuunsFRgbM/RrzVtzE6dpXXjJu2VgGJ
         5VSA==
X-Forwarded-Encrypted: i=1; AJvYcCUIWmDJG1jHHhqlZs7HyzTReNKI9jUiW2l3twje7peozIZqZ0cnldSIo5ZXbb1dtaW9shBwqSSur13P2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFMx31QSQBled8p0GZKo8VMaSvK0P2s8VOF8/VZaDoApIPuBu
	BN6P4MFGw3NrwtYf6nO37aEF135ai0vAmN8n5GA8GHtaP7SV3dAAnmuj0OIIr98=
X-Google-Smtp-Source: AGHT+IF6TG6ilcpWrQOEI+i8x0eM464ASRf7xWLlUBr7ne4UAlr4fYPfEfPSXmd2A/lIL6NquNGb7A==
X-Received: by 2002:a05:6512:e9a:b0:535:6935:7869 with SMTP id 2adb3069b0e04-53877565c58mr344952e87.55.1727221488560;
        Tue, 24 Sep 2024 16:44:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e12dbsm358681e87.58.2024.09.24.16.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:44:48 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:44:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 22/22] drm/msm/dpu: Set possible clones for all
 encoders
Message-ID: <vvycrbbrxcjiplkfsvonqdvhxrlntbiavah3sr5ak4bcy5kb75@7cfud63zswfn>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-22-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-22-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:38PM GMT, Jessica Zhang wrote:
> Set writeback encoders as possible clones for non-writeback encoders and
> vice versa.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  7 +++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

