Return-Path: <linux-kernel+bounces-325957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18864976036
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979A31F2421E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79E8F45;
	Thu, 12 Sep 2024 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVwJrt/5"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AC80B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726117426; cv=none; b=RSw/S8q9qFVH/N4wyU061TJOZuVglikzvdUia2h16zjBJ+5DX0JQR4BcSImvCuCcPpnqvyYT05A+G9oVbYzmFgneLaOKYd+0WEzUj9Tp/Gp0gsCvyV7DoI/CN5qpaYwShCOkUSVJL06Le+pyjksDROcVhXRnrL78GWezmopbn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726117426; c=relaxed/simple;
	bh=F4VxXzrLOAEWzMVJOBXTjy1IslzXS0RyN2UyGwo5AEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4YJerEFxIg7siHxTrPzN9KI40JDJW3UMxlLFIxzRE3UXKfu6sLneeMpY22QH+Yv93HsQuXFsktEQs/Cf8IKim+QSqg0TEceQfwKuLOo2tNCBtXmNwmMOEIYTBxPGl13O9N1OilqGiMLwqmdcmycrUCQsjlLsbp/e2k+gGNQH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVwJrt/5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365cc68efaso552454e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726117423; x=1726722223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noD0uf88q3RdaLafoUYt98P8HM8wv8kHm5RyRAQfAOE=;
        b=GVwJrt/5Dh9hb9+393jhhQCE/Is7BOJelG2/76Qx6+R9fIXicLwmRVm0hvLjGxA6Of
         XIP0Hyd1nWJuUmMgJRTwnwWS+MVbCzgHEzFfd0bg7vcwB/fiG6TDuWuauMADr2hRK51u
         azakALD/4JLFIXgMs21phRoEGqui76jHelDlnqyOHUdu5AROmONJbyoLqO7m46fz1LVG
         LnN/4joE1ClVBjnAzEioysdewdmMiaM5Q/18BYmHLIQUoRoKemBB4HAUMN9JMDPkwPDs
         xkCNX6+7rNGa+P0JGr10R09I8yawHJI2me1W334/rIvOLofO9zg4OM4VL+gi2Fi/nBcE
         5ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726117423; x=1726722223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noD0uf88q3RdaLafoUYt98P8HM8wv8kHm5RyRAQfAOE=;
        b=WzUGUsJZLWmpRZHXtyDx86it84KshwxY27NlsIoW1W8orLJWja++S1P5H+ji93lJYM
         Op9yT1YotMwBOSY95UIv3zXKgiQUKOdV+HueTMy6og+2+LA6EosWm/JvqkrPFYB/ogh7
         I3ORyOASCrXCGN76z/l4VZ9PUT7a/3bzBFH0rQ8lY315N9kzcJADvq26eirpLFsAoEn6
         ivAJNJgXp9g+/QiU9H8iuttJQyqB6/2sXtGQDQIyBpY/vQmP9vaTyVKRDzKAHC37vEBu
         DwtCgWsiG9I1Fh+rmJjSUQzRwptDnCJjQLNAlJEeozUkft5krj4cQQHewfhA/bIUTUnq
         DXkw==
X-Forwarded-Encrypted: i=1; AJvYcCVIKKTMEx3LBD+Rxhq4RZtWIAxuD5oR9yB5yn6ojgSVNSqst4HxaTOP+Jy3xFifrQ4WsQtMWTRiuEPGXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEelo0/ce8LEXuBLgqLu8GI1e8ygHv/q8xdscmqWk3Kt9dtH8
	NHRxiZ1Mx//B4Ce/D+tIWq2ffW4gQS5++OhFn1+YSmy4r2jdYWIlK1PF5s9mfPfo0hXSpEYu8CA
	b
X-Google-Smtp-Source: AGHT+IEhvubGxjrEQVdVXNSpslGFKwSw4CRUWLIiO5R3/3qcm6MQuihMMnkeCR9XhehXo7BfZGCjhA==
X-Received: by 2002:a05:6512:a87:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-53678ff4d11mr738269e87.58.1726117421945;
        Wed, 11 Sep 2024 22:03:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f868c5asm1775717e87.43.2024.09.11.22.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 22:03:41 -0700 (PDT)
Date: Thu, 12 Sep 2024 08:03:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, airlied@gmail.com, 
	simona@ffwll.ch, sean@poorly.run, konradybcio@kernel.org, 
	marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drm/msm/dpu: Fix some typos in comment
Message-ID: <pd76zf55h3kjpmgiydiu4br35bwlzsey2losublklv4o4ta7ko@z3gzy2eec5qh>
References: <20240912042425.4703-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912042425.4703-1-shenlichuan@vivo.com>

On Thu, Sep 12, 2024 at 12:24:25PM GMT, Shen Lichuan wrote:
> Fixed some spelling errors, the details are as follows:
> 
> -in the code comments:
> 	collpase->collapse
> 	firwmare->firmware
> 	everwhere->everywhere
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Missing Fixes tag.

> ---
>  drivers/gpu/drm/msm/adreno/a5xx_power.c | 2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  drivers/gpu/drm/msm/msm_ringbuffer.c    | 2 +-

Subject prefix is incorrect, none of these files belong to the DPU
subdriver.

>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry

