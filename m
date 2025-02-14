Return-Path: <linux-kernel+bounces-514200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8155A353E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DFB3ACAAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20E184FAD;
	Fri, 14 Feb 2025 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXNPRkR+"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9E347CC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498109; cv=none; b=VAdnzRZYgWNzZmt5uAHtwuwL+EdWpQ8EAKtq6y6UowWc0iRLPbRbVf8jMJBZNS2TvBJq531z+piuwjfq8ly228uD0kaFTvLVmGWwsIwbE9zqeU5FL6AKYbaYaWJ+PPRWzwAo7UWCixFPDzo4a+e2Zhx0bu4Ij7QP3ztuKqoBHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498109; c=relaxed/simple;
	bh=/5JTL84Qk0znyiDqF3HvwuK3EXkIWxHTi1kPb6Nah28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8fHINMI2I1ZnFjkZN470ssmiXp2U1aAv/EIK51TzSLHh32RqlV0rjE23DHrEuSmSFl9PCWv8OBBrFwLVOnpklfmaUQ79VSRstHCWNYXlisFXGGq3z53F4zqkIIRgdGJJFTxfjXJV2zIVK3+K9KnjFjhkDZE2EI66xSlOzmMHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXNPRkR+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e442b79de4so14185036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739498106; x=1740102906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7hcmi3D52Q8E6QfNbGo+6Scsa2Zp9WSOQdDFyzodKM=;
        b=hXNPRkR+fjMiUcbW8oVDpIOLV1liuASREMm0DqY+3XT7X5YTZpMBuaUrS+6XCt4qLQ
         cVN7jnIxBg2eJwgPkWJP0bkhxXlsTtIsEL0qzN61Uh4W7vWA+6Mt+Fxq7peaWStSfXJb
         5wyvBmi75ujpNl3Bpk1HRI3wnt9wZ9B9hzPTD8/mXYYXLHQLBHH5prjXVS6eoszny1iF
         k21dZw1jlURfRM+KM5S9npb6ShKXh6eL0kxQHrnRmZnn9O0YPYv25NAr4PGLhWOCsf9+
         Ct4cEIUEsdJJNcZFG/OKa/mn7jhC7UO6aoGqS1GejKYfe2swI3s91uN7sCePSSixxX3w
         Dyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739498106; x=1740102906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7hcmi3D52Q8E6QfNbGo+6Scsa2Zp9WSOQdDFyzodKM=;
        b=C/FlUES0V/t/UEsiDZtVJAdMtqIj01gdb98g4KQnOrYMQcVBmZT5jCuFU5I/SdA4w4
         ZSPFJyXK4YfNAqcJzK6B/am0IhWptPGlbadDGkgQFSu1/n7XI4+O8CXSxFrhfhRb0mMW
         PYakFqxzu/Il8k7TJuizS2q5QjZMqtvdmKUbqa4Yl1doF3FjzY/ap3APAxtB6bG2QSPX
         +WGYC+L2oDKM8MYx4+CbYcWXipIYaVAaf3OCXVbhWU6BaJSpGV5HLQv+cIWsL3FK3RKI
         Qb/MFFDcAUiwLo+vG/7CA4QNQS60QvdOULTROqs/YBLLCL8s2mPtnsqFw5z1vUyewwuc
         WQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbb1/BXM24E8fUqvDwVfnuv8/k4q9aoa3vU/UJsPOG3HI3KWQjK6XUq0Uf9oYsHFOBkLgeZ1Yll5m4cZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPgS9Nutuon9uIS0ZLq3+/STf16nS8AaH94Y3HDB1DDUTGQ5H
	lFeHmAvg9HvtcZc51WT0LzpbeA2A8rD/ZA6QmewjEL+BTDk/eTcLLDvK0Gv7
X-Gm-Gg: ASbGncusVj1IIyS9Zkf5EOsgKF1gXrfxZmtw5soIAdkda6Nsgm5hbFaPFy3TCI7nLKT
	su2Bg8s9V3Fpg4M2edZCGqNf3yTJLpTJhAl4rnqWFZHMzr2Fr7v2I09Heiv3F/39m6Y/TCdR+tL
	2oU7ogfzDEliaL8TRa73sOz3YM3JmpAUFFKzMxhxAIkNbf4Oe68Wl0z5otb79rPrLwciflGFEpD
	NM7J/QAw1/uzdr7+Gq9mUVVZ/6tpTsVa7gTT10ZJig7nBe3fQHs0y37MJWAlAEALYOy+ZSzEeyo
	nlQgRFryvBDDGMHyKXwD3cYbwvQYZEOfzKVdByen0BOLRt2wX6gT
X-Google-Smtp-Source: AGHT+IFKc3TLG8LG8D3zxGwyYTUjO6FC4U/JBOmsUrPI1nqXN6jqDdFrM4DpEVmDCbZNaeOPBA4Kjw==
X-Received: by 2002:ad4:5c46:0:b0:6e6:6686:afcf with SMTP id 6a1803df08f44-6e66686c9aemr3613236d6.4.1739498105872;
        Thu, 13 Feb 2025 17:55:05 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3caesm15936166d6.54.2025.02.13.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:55:04 -0800 (PST)
Date: Thu, 13 Feb 2025 20:54:59 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/repaper: fix integer overflows in repeat functions
Message-ID: <ejsf4dwcyg7j4wdpdtbs56lbwokzlq65fxn2gxio4l5xg6di2r@pmnpafv3nwxz>
References: <20250116134801.22067-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116134801.22067-1-n.zhandarovich@fintech.ru>

On Thu, Jan 16, 2025 at 05:48:01AM -0800, Nikita Zhandarovich wrote:
> There are conditions, albeit somewhat unlikely, under which right hand
> expressions, calculating the end of time period in functions like
> repaper_frame_fixed_repeat(), may overflow.
> 
> For instance, if 'factor10x' in repaper_get_temperature() is high
> enough (170), as is 'epd->stage_time' in repaper_probe(), then the
> resulting value of 'end' will not fit in unsigned int expression.
> 
> Mitigate this by casting 'epd->factored_stage_time' to wider type before
> any multiplication is done.
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 3589211e9b03 ("drm/tinydrm: Add RePaper e-ink driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/tiny/repaper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
> index 77944eb17b3c..d76c0e8e05f5 100644
> --- a/drivers/gpu/drm/tiny/repaper.c
> +++ b/drivers/gpu/drm/tiny/repaper.c
> @@ -456,7 +456,7 @@ static void repaper_frame_fixed_repeat(struct repaper_epd *epd, u8 fixed_value,
>  				       enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_fixed(epd, fixed_value, stage);
> @@ -467,7 +467,7 @@ static void repaper_frame_data_repeat(struct repaper_epd *epd, const u8 *image,
>  				      const u8 *mask, enum repaper_stage stage)
>  {
>  	u64 start = local_clock();
> -	u64 end = start + (epd->factored_stage_time * 1000 * 1000);
> +	u64 end = start + ((u64)epd->factored_stage_time * 1000 * 1000);
>  
>  	do {
>  		repaper_frame_data(epd, image, mask, stage);

It might be best to change the underlying type in the struct instead of
type casting

Best regards,
Alex

