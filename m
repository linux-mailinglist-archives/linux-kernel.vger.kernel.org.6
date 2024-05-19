Return-Path: <linux-kernel+bounces-183286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B28C9733
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54893B20BD7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5D6E5EC;
	Sun, 19 May 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgK/oTtU"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C911185
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716156922; cv=none; b=fZwrrv261Ciq47gyAX/RqNVc+hJCXtPn/wE/tXiycnEz+hX5VJiPbVkqR2BUCK6PxVLKSPNnOEM5/sZHVMhclhFSsbUIUb74foLhtNfC4qBYqsp6N1WySGTfL99JfC0XOt66Z/c7yBJDwRfcc0pgYsYqXz5bIhN+8gpOyd/OhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716156922; c=relaxed/simple;
	bh=PiCXiozXwvaHoCjCH02lGtnYPbNI3wicnp8Afq43D5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnSGflupRP7GSEILO72vZ9ZwLMeQ3AOWf6sTbt9EaKq8expYycMhs8yX++kjw3NA/eVIVFf6VV8352MZKX1MXAfaMdA3Bo3nlZ93uOOymHDmajKwt26sXmN4LN6LGO5XuippHm7Cc4eOqp6OcsuWL6rQ94HYhqv92yNsbjUSURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgK/oTtU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f40b5e059so3029362e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716156919; x=1716761719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNZy7sIdE/z1TlxALr7ub8QrN1KQgxipVOeDnJjogOg=;
        b=MgK/oTtUBhs77HMoDawHYBiJPygnY/XkRzMKlKiyCN8GW3A8JyDeoQwGMvCon3V5VA
         E5kDZIyznclBPPeEJ4+M0Ffwt1l8TtStJriBnfhMLhqqAfkMYuKltGNDhAv1tNkrmXQd
         oWEIc8LxtiDXZeDnBMhUanbs1IEfHDyReVM4nOW8RL3njEq1n3LwAwFq8+SeBniRV3EY
         sSfqQpPkwM+N7hR6vMwnLMEY9601SRWWdBteqE1sO969mvgNI1zZBiXUl4RJ+/tBeaSK
         GdttbxLMTYdbyLxgFrD9cu1WVpWNI5G1hriv9w+q8OHSrL0uj5Ae03T/PTGpqGC5CRLK
         pxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716156919; x=1716761719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNZy7sIdE/z1TlxALr7ub8QrN1KQgxipVOeDnJjogOg=;
        b=a2fxdAzNPItD45wcBX4aSnjH1PRCqJIaGyN4lpfXPkmlNQw24jUusw/v95Y1mPOV1j
         joUcv+9JgLXt9WFaNqc0+cxrxHwKQxSkdQ0EsgJHcjj3ArtJdBtud/cgl72znnctxSvk
         oGEo9p5gLPlVw/TxJk+v16ol4vUod7tFK88PVJn/GndN59Y7Zmsoj3xq1ZhHL2qNn5Dg
         /QmC9bP6FHsU/ignDpZ4cdRvYXbAkX5v8bXdN/NLq4xK6KpLh3WXehtKp/cVTzqC9D/H
         gYuJTun6tHmUKlKTIM6bo8FcVek2pCVDF1FX5txkVTy+lDYL3hFewczeZgeH+MBrGSPt
         Gi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6ni9Q4+HSOrWtgy2WqEAMsT6m/ppzAzdxXsWkye0cWou0d3Dbcj7wcDDCdlBhySfRr2h5ljbY5q2YsJPevjCf1nVLEuJADNo2U5VL
X-Gm-Message-State: AOJu0YwizcYuSjqqj7r+LmaHlQSNtqg6fX8Jm85GxWfWXkR98b7KZgJ5
	cNoTwqpACKV9EOBwec5KXMZS39iYWqsoWeD11OB4iN9wIfPVM4dZrbeOKsqf76A=
X-Google-Smtp-Source: AGHT+IEyH/3C1D8FUQmIyRnndhRQ+yB7Ivz2S3I92VUPNHqwIS586UKcVrPcgtF1Kcad2UcVYVNqGw==
X-Received: by 2002:a05:6512:3188:b0:523:ab19:954b with SMTP id 2adb3069b0e04-523ab19962bmr10070712e87.17.1716156919240;
        Sun, 19 May 2024 15:15:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2b8esm4068246e87.247.2024.05.19.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:15:18 -0700 (PDT)
Date: Mon, 20 May 2024 01:15:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: liviu.dudau@arm.com, mripard@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: remove unused struct 'gamma_curve_segment'
Message-ID: <f7xuppybgsxxfcc3eugi75fgmvdtehan5rngu5cynqnc6ortns@vixp6c2au5fg>
References: <20240516133724.251750-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133724.251750-1-linux@treblig.org>

On Thu, May 16, 2024 at 02:37:24PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'gamma_curve_segment' looks like it has never been used.
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

