Return-Path: <linux-kernel+bounces-218422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06F990BF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD131C21786
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BC199E80;
	Mon, 17 Jun 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQzOrdCy"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5938199259
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665810; cv=none; b=QdFzxYNkueOoCTEvglOYXk7kC0K8gzUvZkC7aRH+g6cXIr8dSYNiStR12nq9jv+kdi8gdo/kWj47MhfOOelgVGWOiW0wg/g8LmSMB8NVoH5Mdy+s/3bXAvwwwnDDLdzQ2/Tr4ARsjsMDq7tQ+o1biTDGoUZSivJdrTJmzevqhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665810; c=relaxed/simple;
	bh=dAVX1Ey0xCojWJ8O3TOwTPJpk4aDMpB6vZKL9iRxwO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef43kUHpZz6WYXwrtnqycBWGohNeEvH30MJfEe4Yck0fqmSHKIGVPvwmE87pK2r/syQS4jrATj28Gr2ia246DbAc3KJhWsR2w7iAx3y7HAbt310YCBZGtdaxYINmzlhmLSZrOxHBUV+Mz5K6uqWYyjOdFq8JJ9towWnrTP0XHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQzOrdCy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cc129c78fso821257e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718665807; x=1719270607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wXBmWTJss/RzmPYrqxUbUPy1ew8NM+9YCA3AzpnMEg=;
        b=AQzOrdCylLBIQB1UPtxrwW7QRQJlLhGAnGyYRosCKxAvzuvt/PvbNbnK7LxTkDWDZj
         mSDGfqSYE04Lfq8kv0zJdv0TLS7WqcFQtEK22YIy6z8iQCkbxXk4NhagtdjEG+aWuc76
         2bKl3fZlfLsSJY29tYFQMQASTeBm3ypwpE4F+8q2gp7/Dp6cyzaPH+t48IWtWlwn57Q2
         KHU+NvB+paJoNhIp6pGBBYlfebtNTP/zNMawbSfjzMnjrdPuR7D+pdCUPYJ5T4WAb5h2
         jtI6aWLdF1jQH5wpW+JfGclxaNhZPFb6AtZsMfdN7M3vE7uLLovN48sMj/Td25CzhcTR
         p4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665807; x=1719270607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wXBmWTJss/RzmPYrqxUbUPy1ew8NM+9YCA3AzpnMEg=;
        b=pB7c+7pZ1oPnFI7PUlo6GeF26qUvs0jC64V8mDhy70aK5CSg3IGg0RxAfp0yt6N4q5
         tF03xT3la4rloT90yhWRcG9NNKSp5rF5zJ91kVEQVFRvofNUhpBjk6gU6tRqd8XBBtuS
         J9ea1zFqRyzco4F3tFZzIjFdGMJlNhCq9udiIYD/Ktw8tSoBGlrDzADm1nkTGdpAAsac
         krqEVZlHUzqAnAxhPAvOdt14aJVXzaY3S0FsGTkNc1tlVL1NOOtZAiD69eBWxJsHmxrJ
         bNzPeLnb5stOg8xkwkWRo/43ZYch7uXlURPNLrSJJueoeNM+udQ7TcNM06hw3WxgNUhx
         vAZg==
X-Forwarded-Encrypted: i=1; AJvYcCV5h4L59ivBvIRlwL1BNVmCDSePy1S+hbJtst1G1rJCNXFGlA1VQd3K5uD9lHrf5fPjil6jXKomBa8BrvsKJwkVJRh4dHg+ERng3ZBb
X-Gm-Message-State: AOJu0Yxo5GkxtGGqH7izbzGHihym+vMklTITOiVnTqsr5/plMNoYJ96p
	HR6+dl53YTGm4tYhIFTo/Uaj6bkGGKDRBSGArYMdxnsm+UAtjIbOrGWoP1CmmlE=
X-Google-Smtp-Source: AGHT+IHUJRlG8SD2S6dAElgdpD/vdPMBsgptCF4B7ZC/wxomG8NUkgDzrQQzTs6Mt9ZY35JeVrbnIA==
X-Received: by 2002:a19:e051:0:b0:52c:896f:930d with SMTP id 2adb3069b0e04-52ca6e9f182mr6936181e87.57.1718665806612;
        Mon, 17 Jun 2024 16:10:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cba650945sm568522e87.225.2024.06.17.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:10:06 -0700 (PDT)
Date: Tue, 18 Jun 2024 02:10:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] drm/msm/adreno: Split catalog into separate files
Message-ID: <vpks6rzfkhzq3dgfee4l7ht2w6vdnlidppw3y34gxv64g3x66z@z5ojt6po77ir>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-3-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617225127.23476-3-robdclark@gmail.com>

On Mon, Jun 17, 2024 at 03:51:12PM GMT, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Split each gen's gpu table into it's own file.  Only code-motion, no
> functional change.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/Makefile               |   5 +
>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |  52 ++
>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  81 +++
>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |  50 ++
>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  | 148 +++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 338 +++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 625 +--------------------
>  7 files changed, 680 insertions(+), 619 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

