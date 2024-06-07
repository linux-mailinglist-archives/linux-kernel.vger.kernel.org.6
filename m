Return-Path: <linux-kernel+bounces-206709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FF900CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21065B22712
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062921757D;
	Fri,  7 Jun 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPgcznK4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312113F43A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792222; cv=none; b=IhIwQg8Jeo6z+IFkQ9EhhINOQWR0wcs8tJklbJ32XXyZjOOr2YxPD+2lPPhvR+KMCxN4FMcn2MxVbJIKlMej2IhJjO5mTs+yCWOVYhr/qHOmyzI6eJiXZd9FrEazQ3tZW3eUvR7hDyGh+X+A7Z9vwX/vjPC41u8O1SRYjxEET00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792222; c=relaxed/simple;
	bh=ROYTdcM3h5PdNH7jMsNq6wgFbtlVF4K63MVqa1RfUTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPQFY0eIHyIkBVMR7GxPDfa/y8VvQHm937UYlrai/ZG43ZoILNoUJF1g3CtOLdU1hi5AUcntJsjvmGB9Gc8k+vCOf41BqCWa8H2njEJFCwYoDnQ6PNX34ASYI09xCZpW666X9plCRgk7M0d1xLq1h0YVw2zaeEWJ97q2gER1PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPgcznK4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52961b77655so2862922e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717792217; x=1718397017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJTzxe5ddw3ZN3ejg2VHMhuR5Wz3A7+WGmdxaZHLCtc=;
        b=jPgcznK4RAkh5ubL6/776sukf9fOifb8Q3nuqaIvGnB8rXMWK2r0LVjzK1Ar73g+fu
         k1ZO6/dZrJtO+9fuDmDRuaU9r3WfxCn83Fvpw8sEg2Mtfg9XlllH+km0bd37ogiZocEX
         ZWOir99w1mUS9LnKGy54FmCzHE4WHF+iRhRDWGqXs4ARZt2dtjIcwbYmbnRDMuOnK03F
         71tB172xx9hiZzvXTCsYh/bA++AN1kV2QhAkaZhI7LyIRZx5BJ1F1PDu334/sHvALEmA
         Mq4OqkumimzGq/vxxqSqHudjZBWQwPU0VBd2EeYys7T9Um5oWN6FAJQQTvZIde62wt0N
         F+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717792217; x=1718397017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJTzxe5ddw3ZN3ejg2VHMhuR5Wz3A7+WGmdxaZHLCtc=;
        b=J1mgCr24rZQ4jzKGGjSIssMZBv/lA2rv0bCGpf7BpmLk6pMfMRODgVTthSzb0RXo1/
         yVM3KENCYHxm5TP0pvo0lUt2DWXk5n6yhppsHjL/GoIVKG6hR8VX0cNn7tQButYcOTW0
         r1bX3IH2V9fvKWYRGcMmvX4UTOohOsTmKupcFKO23HKy813OHhXdZG0Cewho9Oo6krcN
         S1SGGXSOS99gaiPlxzY6mCZsspox+3UeM3H9wg6qfS3nK8UeC7PV5RZcjvAfj3rQXFSY
         kbNYVU7kKkq5EbwQfjgBH2Xumrfkkz38cxaYSnLjVrtUrmGf+z3hiUO+wEQTTSrxPAOW
         do4A==
X-Forwarded-Encrypted: i=1; AJvYcCUeEZvcLLBL0YynYhcWioIua9YQvrGeLNUjZE5Q5L0DmfMqNCU4GYwkjR66vEpNa/b+tdLr+cfHTcyeQuf3JFcEszXRiydnfn6KkxrM
X-Gm-Message-State: AOJu0YzRTYE0cS1gfoX7mdOa6DJU/m1hn1mZonrNJyjYtc9Tnui8u1a9
	nL9T2UnUTj2bLZDC82EvWV9d6KvHAmWy/C9ReBPfSIKLxFQ+/1aGwGApo0bFyPA=
X-Google-Smtp-Source: AGHT+IGXgq8j9ZQSdjhR2WRP238Fqx1W2VoFAvOkFfDn+JlkqIE2s+YVCpbU2MO5IYDF067L6l+FEQ==
X-Received: by 2002:a19:ad45:0:b0:52b:f2ab:1303 with SMTP id 2adb3069b0e04-52bf2ab143dmr524832e87.28.1717792217335;
        Fri, 07 Jun 2024 13:30:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb4347001sm646147e87.288.2024.06.07.13.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:30:16 -0700 (PDT)
Date: Fri, 7 Jun 2024 23:30:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: request memory region
Message-ID: <ugh3ohzktjxyus4t43jywmrwatz6t4zqz66nm2wdfjou7zu3yd@g64z7gp27wl2>
References: <20240607-memory-v1-1-8664f52fc2a1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-memory-v1-1-8664f52fc2a1@gmail.com>

On Fri, Jun 07, 2024 at 10:00:04AM -0400, Kiarash Hajian wrote:
> The driver's memory regions are currently just ioremap()ed, but not
> reserved through a request. That's not a bug, but having the request is
> a little more robust.
> 
> Implement the region-request through the corresponding managed
> devres-function.

Please at least compile-test the patch before sending.

> 
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
> To: Rob Clark <robdclark@gmail.com>
> To: Abhinav Kumar <quic_abhinavk@quicinc.com>
> To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> To: Sean Paul <sean@poorly.run>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> 
> Changes in v5:
>     - Fix errorhanlding problems.
>     - Link to v4: https://lore.kernel.org/r/20240512-msm-adreno-memory-region-v4-1-3881a64088e6@gmail.com
>     
>     Changes in v4:
>     - Combine v3 commits into a singel commit
>     - Link to v3: https://lore.kernel.org/r/20240512-msm-adreno-memory-region-v3-0-0a728ad45010@gmail.com
>     
>     Changes in v3:
>     - Remove redundant devm_iounmap calls, relying on devres for automatic resource cleanup.
>     
>     Changes in v2:
>     - update the subject prefix to "drm/msm/a6xx:", to match the majority of other changes to this file.
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 

-- 
With best wishes
Dmitry

