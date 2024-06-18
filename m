Return-Path: <linux-kernel+bounces-218864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E990C725
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFFB242BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE41ABCBA;
	Tue, 18 Jun 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgTq5jhI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34E383BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699457; cv=none; b=eh0JLe4+/hEggcvNK75NThJFArXIxCfxyqaImmSHbu/x0nYiFa/mYoDP9f6/WaYMbbgZMRGOfekiiPdTiLYUw+RhA1CtahdpVvEGgVMYzed/SkXCqVj70ixGgcHmZtW+4hf94UIbjugaganUbCbgsEW9BgTPbv2BP+ODawoGvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699457; c=relaxed/simple;
	bh=R+5azQZ6+mBwxY5RI7RSFeuG0Vd7freNSUMqsMzkf0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr1Ehoq34ZvO4rwbRL6omZ3J5SWIn+fym4klOa4OdUuMcIVUtvJI6Y2EM2NqUMP5yYgYd9/ynnVlAXh719K3n6MPFXSowx6oynyxZvR08W+8ClNA+EqXkKdvUvUCNFCDj/luSO5Nh82w5ljN2KRZX+U6YEzf0+pIUxWRCFcISzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XgTq5jhI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so61525561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718699454; x=1719304254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN9k85Mrk3anlVUN1YElezSrnWglII9Sg2PXq/CTuRk=;
        b=XgTq5jhIP5bJwJ4vZgIFpk1jW3/ybhzJbcV5mZms7hDibpbHF16NzdXAVbRxWNZZSu
         NqY+WvQwHSoeQCCgqsXZMhkKgyMRQee2OYBz5Q3tnztBzgsyYzVoDbr+6ZMh90QeCRkO
         3sdNQtePYPB1x6nYralXACy6+iBIqeSsou7YQbpF2/1BS28HtNVukPdARPQ97ajt1XlE
         n3SENz2y76GrO3K5TSWc1KwwFjToaocqPPxgqt0uR861FFFIE0CXdbGxZ7Ei1b66h9SU
         /N9Nkw18QxKzjTOR+k66ay7yJbTQlprowQqS5fWrdHHErSq4wRYaFKPca/cRPI18X++A
         Ivdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699454; x=1719304254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN9k85Mrk3anlVUN1YElezSrnWglII9Sg2PXq/CTuRk=;
        b=VZRmCj12PyofJIsvdNd3lydTTw7lZ4S077Wwgka1++gV7ebU6uhQ0PrmZM4utboppg
         241hDeEp1Cc3OVtzbExHkpxAXBnyZvkFR5ghhf4LTixGuU0R+ycdsE84PINf/Rz3o5+4
         r3Gv083/jh2BG9IS54JZHJ1VxUO4sDuOb2UKagxEktOXoj80H+GhUjXCORnqpfcXpRUI
         zjI6cuWbJ6jVCaQJBFYcBaT2BqQoZrxMd1ziFIx8OvWJ/D4lIP3M5QFPWLP/rEx8Dn/o
         5CU1rhkL4R0j+ImiFa74/7CtbMPKXp3TpsbHVSPwqRN0GGuTtRTfNrN9bk9vCDNLY21Q
         bw6g==
X-Forwarded-Encrypted: i=1; AJvYcCVns/cldAsHLBX5B3X3NyWU4TOASgcAD9KJP8EL7zNW/UPt4N6IqCoOQVaZV2j8lHxGbiJY/vvQN7E9W6cme1pS6TBC268APEEd3X/i
X-Gm-Message-State: AOJu0YyJ7hjXrSW+c2cpJGk+6UbEth3yRWlcaqBC6P9jsZgnW8qZy+pC
	FpX5qBb4qbGeloRDx88NrqfUqTY4ObBaHOuzILjBC96RE7BIPr7sShAKB5dkbmc=
X-Google-Smtp-Source: AGHT+IH9eAQFAL6zDipOK/sDJ/uS/aCTBJG7zVkZruzaxOD1yJH8wQC7geS+TrEfqa1CGkcOieAZdQ==
X-Received: by 2002:a05:651c:2117:b0:2ec:f8a:6f14 with SMTP id 38308e7fff4ca-2ec0f8a7023mr83274231fa.38.1718699453663;
        Tue, 18 Jun 2024 01:30:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c8a2a1sm16266141fa.114.2024.06.18.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:30:53 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:30:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] drm/msm/adreno: Move hwcg table into a6xx
 specific info
Message-ID: <wnnjjljjyl5s3fkwiapux3f76243ngp2ppk2cm7kkhdp5dc4sz@v4wypnga3izv>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-5-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617225127.23476-5-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:51:14PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Introduce a6xx_info where we can stash gen specific stuff without
> polluting the toplevel adreno_info struct.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 65 +++++++++++++++++------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  6 +--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  9 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  6 ++-
>  4 files changed, 67 insertions(+), 19 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> @@ -98,7 +100,9 @@ struct adreno_info {
>  	struct msm_gpu *(*init)(struct drm_device *dev);
>  	const char *zapfw;
>  	u32 inactive_period;
> -	const struct adreno_reglist *hwcg;
> +	union {
> +		const struct a6xx_info *a6xx;
> +	};
>  	u64 address_space_size;
>  	/**
>  	 * @speedbins: Optional table of fuse to speedbin mappings

My preference would be towards wrapping the adreno_gpu, but that would
require more significant rework of the driver. Let's see if we can get
to that later.

-- 
With best wishes
Dmitry

