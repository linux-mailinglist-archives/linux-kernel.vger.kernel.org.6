Return-Path: <linux-kernel+bounces-385019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A69B3174
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29D91F2251B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99181D7999;
	Mon, 28 Oct 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="js/khd8N"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AD191F82
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121370; cv=none; b=nNjywjav5gj1Uzyh812BrRDxHmzDbD5QOZDbwSyxRn0ibwmXiCjEmDLYdWOXV2Jc4lRUo6tnO7UdAxf59BNofWQhujGz4Yrd8W3AyydZzbNJmWvmBI5ueAkCPPnP2lF5/ztD72d5kPw7382o+F7tNdMv8S03JxTsR527DzkCQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121370; c=relaxed/simple;
	bh=s5eLSjJL/9dEcWiEjqC5lEzTCNSP+7We8UeqyLuVx+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ073K93GtyEmE69AyhLzm8gwc8FBbAee8/W7IiJFEpHEc9bIDr+9wuUMv8ANBBFo3To/xzAAiXstFOCWpZfnkSwSp2B+sPCXclnRLH5OCJLFtTK0dumUMTYNGhDqJ/CBgQ8ZOAq1ugO31/VLfLoXMmy4VVEzgO/GKx4jtTy7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=js/khd8N; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5111747cso38437541fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730121366; x=1730726166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQj2u/EUMKp1RSMJyz02F9DUDwEFhFZUuvyibq9d3rg=;
        b=js/khd8NVSllhxDReS7g0tniLIQlD3wZ8RT48m0dw0MLZv1BmQRgKDz7pesdTVb2tK
         b+U2MQM0t7mcoTm0RyeNPsHon7LKkjgq8FYDx9BKqFPmyIUP/9lL/LMqF5dI2lPmNhXK
         ++K4q1CK5Lhq2Iyd7hR8e711CQQaM6vh2Ax9QE9DOvRhvFHVdcaKlZUZ2r2M6mMLj64b
         jCiRio+Z4ZrGxafyqx+05KFGiUkSFiCbIklMrhPcsJQUQicNoLmqXS3MVvgxU2/qLy3f
         321YzCLGxCRba42fcXCBYUgXfxVvE0Ro4qODI3ZBj2Osgk4+STog2/DAMMmda8vQLiEo
         hGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121366; x=1730726166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQj2u/EUMKp1RSMJyz02F9DUDwEFhFZUuvyibq9d3rg=;
        b=W2Bv1xoqEX9kMucTw5Z9wd2C5tYw6WCkiY+bqqjh37TtZiFX+LiS42Tqm572yuEsel
         Dwoi3UbWM71zPQyaujebmqtwJrmLcRVicXbkfjj1ZMee8PkxatZAuAIw24olTmaM/CmJ
         AQFqoe7jtwopXuXsfvlQbnUJzGPLtgWTVcX3pfE4xO+8+zEkKvYL0PnZSGtZkFflFT1l
         w2+cJ6W2zOSkNktIrqYKvPBd79bDwmtcuhuheG5jYkbJSeAx0i+7SzKZ8oh4MS9cutZr
         +C4NplqCORMcmtIXCpRruW/mtjp/4fbncm7QsqvK5n9e3QMWzd8PJ7Sm+Vse1Pibx873
         G27A==
X-Forwarded-Encrypted: i=1; AJvYcCUFuipJ7LRElibKpa5M2Qlcsw3vqB9NWI/YNq0bVufz8AArchnoJ+ht1KqyBybVchyYNGOngf76Yytur9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhAiPltqNAmye75JBE43uT+ckSbXckbGRjS7c0VfwioDZq7NG
	NJbL9fYhb4kxofEwFYvppdU/wygwgTKvAQpFgzvKQO3NkJ+yL6xyFTN/ShKNBa0=
X-Google-Smtp-Source: AGHT+IGQ7S8hq2lRtSSOBdtmbOV8iimSsRBc14mXyCXrbAnhffIB8VwNLDv0WkdYHbRoHFHZoYlCzQ==
X-Received: by 2002:a05:651c:211a:b0:2fb:266b:e3b2 with SMTP id 38308e7fff4ca-2fcbe088a17mr30036131fa.36.1730121366357;
        Mon, 28 Oct 2024 06:16:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1e56sm11546431fa.89.2024.10.28.06.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:16:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:16:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm: Remove unused
 drm_atomic_helper_commit_planes_on_crtc
Message-ID: <267fqxxhxyxihheex577dji5yjmggxxorcferqtyn2y5j3rg3w@d7j6a4klqmlw>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022232934.238124-2-linux@treblig.org>

On Wed, Oct 23, 2024 at 12:29:30AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of drm_atomic_helper_commit_planes_on_crtc() was removed
> in 2018 by
> commit 6c246b81f938 ("drm/i915: Replace call to commit_planes_on_crtc with
> internal update, v2.")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 72 -----------------------------
>  include/drm/drm_atomic_helper.h     |  1 -
>  2 files changed, 73 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

