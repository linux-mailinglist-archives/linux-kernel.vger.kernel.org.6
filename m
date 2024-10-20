Return-Path: <linux-kernel+bounces-373268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228049A5475
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11B11F21FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C3192B9E;
	Sun, 20 Oct 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erlNQv5s"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BF1DFDE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432628; cv=none; b=rMZois4LU3kqQW5yNk2t6DxOswPsWTMLAsOLumXZRYXtcaOtE0KpJUwXSkKInKpYoKGKSWzCsHWLCDmG6ulUCm92Pq0Cn6It9/CM+CFI9PheD4qmjUHiKsYXQHr0wYT0OEIQm353Q+fQFgaVwE89I4S2S5P1a5iXYEiWQCnmTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432628; c=relaxed/simple;
	bh=LKvXBucsWNXa6YNdOsCnMhPVAZ2uJWc4U1q7eVLGPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlF9dhKKnIeTAEg3vkn80+ToWChULVqFtzq0chi/c1Mxa/LIb+Qak8IaGguToSiCk87h6yW2NXv3JT6g03E1+p48GkgMRxnDTskQh25qgdJhMczMkzeF3/Ho9Bz8inaSbxdcl5y7x5RcVpfxg9N2ACT2fBtSejSubXXrkS5Cv98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erlNQv5s; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb51f39394so36887361fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432624; x=1730037424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3d49rBoiN5wy+WZ1KPN1f6wcIO3VQTEw3clZT7OmJo=;
        b=erlNQv5sWTpHyvCQyhapjNpUSl43PoI9umKRiJuqNODg/Fh6HQwtOn6CnACS6bfb4k
         JmM/hKA7815Q5tzzyXVuvBUDXIUkdIWiwqr29T4hxq0Vqbhe9tUVD1VwBw9VDbVb+oJQ
         HXbmRmegGCAfCBj3NE16jw+biqjWyt2cjtezdFbjjQa3Za2BjvJ7wVP9Dyh5Q21Y5Vnv
         yJRqWdWetetmcEH5K5Ogx6NJ6qS/3zioRhgrtGj3dL6JpJ49GlZUpwbSmz2ctN3xYnGx
         tqPMUEGkFpfF1T01a6c71+foJxMG+k1FDMEePvnC3yua4P8NJeRgWN2c4NtjYjlDOZq8
         5BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432624; x=1730037424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3d49rBoiN5wy+WZ1KPN1f6wcIO3VQTEw3clZT7OmJo=;
        b=WYtXmsGdz78v8P507BrXpy0S4uPeHo9+3BvPGvuLUaLws4t54JnGDMvarVX5ify9IF
         Ojb4gm9nYqJfYXicXaRRUPk3/yEKIpnJjQuPtMpu/lPqwPbXMdZ3aDNPTaVChUBbYI5q
         1w7DJxuG3g143Jhbv3ZW+O9cK8pF6ugPA+ri4UIopS0GiTMSCuznq5t9/n2OXULHUNNN
         KvXhl0C0I2Cm5VWw/JJXcbtgu9hdjIvwzc2as0osuvM1E8c6STBmnk0nhW5taHiNLOQ7
         h/xbZdCSGDpxoM3hgTZNVFGRVwVOQXKRpYlAR+ICNK5RdEH5jE9K8TOEcY/ptIWB4S94
         1z2g==
X-Forwarded-Encrypted: i=1; AJvYcCWMEWTwihXEXi+W9YG+9T9WTcSrcSDi2kq753jiRVRDGAQLJ16jTWt9UbcaGpwKoAE6V+YQArjzxyCOU0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaJ3m3Utw/B2MBJlD1akno0sipIYi2wGhTwTydzQIIStPHKji
	6dqihvfZFMgnHTXzm6KEnro+9TRGGeqEbngiykEZqikALP8YUNyaROb5c6K5/Ms=
X-Google-Smtp-Source: AGHT+IGhj7gVRiVovdTClhWIItAKdcIzorRVBXk7eo6paSV+KVr0WEnvWmVLY27F3Mev3fjNEnnjdQ==
X-Received: by 2002:a2e:f12:0:b0:2f3:a06a:4c5 with SMTP id 38308e7fff4ca-2fb831e953emr30661331fa.29.1729432624471;
        Sun, 20 Oct 2024 06:57:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad907a2sm2384691fa.71.2024.10.20.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:57:03 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:57:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Pin-yen Lin <treapking@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>
Subject: Re: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Message-ID: <e6ksqhssu55ox4ffzyko7fsahvk6i6aoj4jo2rbe2gv6sclvzp@elpidkcflh3s>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:12PM +0800, Hermes Wu via B4 Relay wrote:
> This is a v6 patch-set.
> 
> There are lots of failure items while running HDCP CTS using UNIGRAF DPR-100.
> In Order to fix those failures, HDCP flow needs to be changed.
> 
> The DisplayPort AUX protocol supports I2C transport.
> In Order to support MCCS via the aux channel, the aux-i2c operation is added.
> 
> v5->v6:
> 	-keep the commit message wrapped at 72-75 chars.
> 	-[10/10] fix return variable being used without being initialized

I have reviewed the patches that I could review, but I lack deep HDCP
knowledge, so I can not review patches 5, 6, 8, 9. Hopefully somebody
else can step up.

> 
> v4->v5:
> 	-add more messages for changes.
> 	-[2/10] modified AUX transfer data size judgment.
> 		change for-loop to do-while.
> 	-[7/10] change for-loop to do-while.
> 	-[9/10] change wait timer with timer_after()
> 
> 	links:
> 	https://lore.kernel.org/all/20240926074755.22176-4-Hermes.Wu@ite.com.tw/
> 	https://lore.kernel.org/all/20240926075134.22394-1-Hermes.Wu@ite.com.tw/
> 
> v3->v4:
> 	-split changes  into patches.
> 
> v2->v3:
> 	-split aux read  KSV function to a patch.
> 	-[1/3] new in v3
> 	-[2/3] add description of patch
> 
> v1->v2:
> 	- ignored.
> 
> Hermes Wu (10):
>   drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
>   drm/bridge: it6505: improve AUX operation for edid read
>   drm/bridge: it6505: add AUX operation for HDCP KSV list read
>   drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
>   drm/bridge: it6505: fix HDCP Bstatus check
>   drm/bridge: it6505: fix HDCP encryption when R0 ready
>   drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
>   drm/bridge: it6505: fix HDCP CTS compare V matching
>   drm/bridge: it6505: fix HDCP CTS KSV list wait timer
>   drm/bridge: it6505: add I2C functionality on AUX
> 
> Change-Id: Iad0c056d72abf2655081357cf40c3b0d3df916b5
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
> Hermes Wu (10):
>       drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
>       drm/bridge: it6505: improve AUX operation for edid read
>       drm/bridge: it6505: add AUX operation for HDCP KSV list read
>       drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
>       drm/bridge: it6505: fix HDCP Bstatus check
>       drm/bridge: it6505: fix HDCP encryption when R0 ready
>       drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
>       drm/bridge: it6505: fix HDCP CTS compare V matching
>       drm/bridge: it6505: fix HDCP CTS KSV list wait timer
>       drm/bridge: it6505: add I2C functionality on AUX
> 
>  drivers/gpu/drm/bridge/ite-it6505.c | 334 ++++++++++++++++++++++++++++++------
>  1 file changed, 277 insertions(+), 57 deletions(-)
> ---
> base-commit: b8128f7815ff135f0333c1b46dcdf1543c41b860
> change-id: 20241015-upstream-v6-9f4b015fecf7
> 
> Best regards,
> -- 
> Hermes Wu <Hermes.wu@ite.com.tw>
> 
> 

-- 
With best wishes
Dmitry

