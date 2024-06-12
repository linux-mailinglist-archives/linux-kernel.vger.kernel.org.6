Return-Path: <linux-kernel+bounces-212118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8C905B74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BE31C22983
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1747F4B;
	Wed, 12 Jun 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cN1g7mDS"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5952F3B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218217; cv=none; b=LXCVlg+MrHxLdTO5a+G1zzBMnApMuCG2kB60kvrOJNehPXkrCTGNuqRRiq5tQYc7TBTiQErWrSGxYBeycxFNsoavELUDRlUj42iHKfRZc+8iyUVzL4Y61MlhXWTKaE7GZ6h9SwUi7b0OH1FRTQaUWEcZghiHYVoOvJae0zl655w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218217; c=relaxed/simple;
	bh=mKH3KFbwiBL2iLlYxExmS861ZNTGGvJaaQc3V4mMtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfvnXIWXM3I9PWrQfxuUO35Z1coSgSgXt5Bm1uERaKu7RsgC3vx5G3mr8QiTbaQk03BRlB3MSQF60pprVWiSWYVd7zg6ZNhR3t5xJW9hd2xt2qJWyWde9/aCQrWRT9edJgZVEc3GBSsoo6ej4peFaEuTEw6QX6TSo2GuCSPJwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cN1g7mDS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso978131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718218213; x=1718823013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NjYmegOgGYNhcpDDZKmoKBQxNKIEWn/rR4O3QSBcqc=;
        b=cN1g7mDSm3Fi46BKkb0UE0X3CZUOhT70TlSMiL6V9puV6mJ6mDV72nontO5Ofm+ep9
         qQKU+Io+9N8pCTWKsntuBQ2d1cO5Afg4fuN9qyZpdMJEHvfNax1XURV4ivfoT4iClOrh
         wn09mE329kM6RtSfceZKwEst3UCmurY3tW8PPOYb3ECdwdLyGqTpmLYH9O9zFKKoIkrf
         grmktupwTW/L89PYv1TKZJy6hJWyeIRjhFxGtOd4FbRBH/r9RPtW+mh/0MRIL/pQBw8f
         DNmz0CZ+WVAbB145TNIQJ4iK2VkXDI4q7VXN0yqWr+msJPWMYBYsgv6l2R7wNQW2Ufnk
         n5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218213; x=1718823013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NjYmegOgGYNhcpDDZKmoKBQxNKIEWn/rR4O3QSBcqc=;
        b=AFHCO0ZmfNgvT62Vi4k5g/y76DdFBSmWhiSmniCUuN7cPzioJDjc8rV0y6b7a6wTVR
         sW0/BGLbfUJb5IfrkLwIes9o96wiLCWDh/8Mj4uo1op2M5Q4SVtVdzgVdmnkC7Nc4t1Y
         NC7JHvEwzK0xmDQmcMFholaoerC+e9suK8Sku+7+AlIbP+v+7icWSyradFn3xa9SkpML
         pgrMY8GoIoKfYOtgCCHGH4R4Mk488LGYO8MV7WxH4zzPcYY52wqHrV9JbiIv55/Q+X+E
         xXZ8FUylJEUtUA4/DQrnpQHBKPftBtby8vmapoH4Al4neqAVG4hVa/+GBilTXHI8esGB
         4g1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXji3sDgiMYVVM+ZejP4zuM0LJDmgtGkBcNxFIDArsnlrh64hO8QwnI85E4sbxfieRXQEfaKUXE26w3JcFPlXq8plbwHqCfrKpX81LJ
X-Gm-Message-State: AOJu0YzSbvc0EUwO/hfZ3K4Wc9/ToTRLKLwP8KDjorIhKmvjRe+nnCju
	6kAe2ZPzMkYq020U838RmHOz+a5KQLUC91/K0ctMVgrlaogebxbrt/BN5yGTXVk=
X-Google-Smtp-Source: AGHT+IGVSOtOEYm8t+tqYTfwcYnrU/mWmoEEN5ecTCoD/H46fXlyAPX3sCNCsVsHzssEPRHW+PHTpQ==
X-Received: by 2002:a2e:a30a:0:b0:2eb:1de9:bede with SMTP id 38308e7fff4ca-2ebfc9abc5cmr15140731fa.51.1718218213391;
        Wed, 12 Jun 2024 11:50:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebe4169b35sm16677301fa.135.2024.06.12.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:50:13 -0700 (PDT)
Date: Wed, 12 Jun 2024 21:50:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dianders@chromium.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panel: truly-nt35521: transition to mipi_dsi
 wrapped functions
Message-ID: <k5cfzjqguuievp6dg7eagnpk5v4yy7o2uwr4dbtubdmzdv2l2s@5eh6iqw2aene>
References: <20240612163946.488684-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612163946.488684-1-tejasvipin76@gmail.com>

On Wed, Jun 12, 2024 at 10:09:42PM +0530, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> sony tulip truly nt35521 panel.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Fix code style
>     - Changed calls to mipi_dsi_msleep
> 
> Changes in v2:
>     - Fix patch format
>     - Fix code style
> 
> v1: https://lore.kernel.org/all/485eef24-ddad-466a-a89f-f9f226801bb7@gmail.com/
> 
> v2: https://lore.kernel.org/all/3288287d-8344-4b37-a333-722cf12fef13@gmail.com/
> ---
>  .../panel/panel-sony-tulip-truly-nt35521.c    | 433 +++++++++---------
>  1 file changed, 207 insertions(+), 226 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

