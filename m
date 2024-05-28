Return-Path: <linux-kernel+bounces-191584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056A8D1122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1971F21AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1968BE0;
	Tue, 28 May 2024 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAgSxrya"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539CCD2E5
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857311; cv=none; b=VDH7Sn4vG693R5bCGNlbUVnPmgaQBRn9LeVpFFzND+Ka2Jxj43TgUOReOTeckODqrH9CIIByOz6pXmTm9/VuYrhvArCLG4wuOgfcW9XiKxsg6ZNjLZZh98XXOpNRr0FM9fT8pmeNXzS4Hyh/3b4Cn7dVllvQDyWhdqxjsfKeu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857311; c=relaxed/simple;
	bh=e4u/acEE0ZMjC2PVgT7Neyq/Ki4uSj17Vukxh/E5AJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Mhf1zC7vfXquzMFsGHsKO7wHI/UDdi/z/8a8lqg5c9B7ClXx4J2Yxpq+pIArRey81aRI9nou+khadsD5uj3nFWXNJfcbcokSEtCMx5ms4+70hGXcqjHzlCJ4rfwb082CHVGxOIOzYufCbsC9jsmhQhqHIQg/uxhy8Tux8O9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAgSxrya; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-529597d77b4so338095e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716857308; x=1717462108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqyKqJsE6pp+l2O4SC+W159s+eImxbzOSm8NXJ1OA58=;
        b=dAgSxryaHECVTJp17ExHlurSE9fg0colMo0OKrLr/JqO7RgkHog5KrRAvt3LNpnfWQ
         Dm2+A6x9DJJrATgY4F2veex7a3gEQpGlHXhKiwT8h6HZWIyfYmbLld+p2EWgNimbzQFI
         jqaFT4OdQXmSi4XbUWegSgME8en9TDKOy0ihXV9PHd7QvhaemDgreHbF/+GKjfiyQJkI
         rGVyLoP5DFnUFWi9CzS4a48WWsApmae1G74JS7TywzySVAxZR0G+O515YG+L2sJM9Fzp
         6pV8LTd0Y//ZGytu72DHy9kmqfDr9XOxIeD/bViBOhvLpEUYph+QdpjYGFWPKMq0awr9
         cXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857308; x=1717462108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqyKqJsE6pp+l2O4SC+W159s+eImxbzOSm8NXJ1OA58=;
        b=mCNw9Q00Pg2GLJlFjaSWrxF6HSI/xo8LeXInRmSNtFw4YM3p/2GD1FW/n/BVMjYXIi
         jpzJGXhLX/csheNdMS/3sCM7HAsmCCXQ4K/X7ZzcGpgUcczX+PHUzlU+D0Gzmh0lRkMx
         WUDe+aMEyYXYXmdP5Ql1RVqjaqssMo1bR+ahncU027JQfX5heC79IFJWbYB4Ng2kfxlp
         4kpawwaxIYPv+7nfS9R3cayn6Sej6B2OploI7AEMpa5ci08KI08TDjj+k8G8dkGM4JtM
         aB9UcutnJhQz+jcctEFSGK5vHy08PJ/AA7uLafEkjfmT6IIIjDmqKjXdWfDPTszQN0No
         CsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZtaGLAeSNNK9BtEvlTZXmZE4z4wndRb9DKVKaS9bx3kUusANZd1TAFE0sf1ERF5Q5ES5a7ytjmv9DeE+EdH9nct5WVoc8MKAy1BNF
X-Gm-Message-State: AOJu0YxRsAxnI+Vr1e3UB76Shx7qpw3NpkTmJ7vrmTwfB/+rzHKelbLI
	EfhqsKiOvJqPyGSFnDb29xGcGQD+OvbRkyxy0ar1TS7jGC5vzk+rdAIbEJQEbDs=
X-Google-Smtp-Source: AGHT+IEkY3dLBPQpnDZeVlJ5g4IQ99DKVk9uniY+rjpvwvxmpQU+WYyWo8C0Uczxxy+AfmQzepE2XA==
X-Received: by 2002:a19:6912:0:b0:51d:998e:e0c1 with SMTP id 2adb3069b0e04-5296410ad52mr7332337e87.13.1716857308562;
        Mon, 27 May 2024 17:48:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4a58fsm816295e87.67.2024.05.27.17.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:48:28 -0700 (PDT)
Date: Tue, 28 May 2024 03:48:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/msm/dpu: enable compression bit in cfg2 for
 DSC
Message-ID: <zdlreka3shviepb3p7cq4ulv7f6e2lz7b4af3pdqntnbqikmhq@uoiyu473v5e5>
References: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
 <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-3-f797ffba4682@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-3-f797ffba4682@linaro.org>

On Mon, May 27, 2024 at 10:21:49PM +0800, Jun Nie wrote:
> Enable compression bit in cfg2 register for DSC in the DSI case
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

