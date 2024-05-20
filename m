Return-Path: <linux-kernel+bounces-183640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7998C9BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F67A1C21DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88904DA09;
	Mon, 20 May 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIexqk64"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23B1643A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202995; cv=none; b=ebF5u5Hc8pppD4s79UzhoNTVBRXLXibSELv4P78Xh+R6FWegJ4ksJS+yQyXYQAJFAz3h85dlMJgZG5x/xVzHaNv6YUnxH0pOqhg/SxeIird12ES5tHzGzpJBwiQ5KP3pU4KUExSfdYd/klWsVjgaW+qh9ThP5Me4To9FPkxSx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202995; c=relaxed/simple;
	bh=bmRX0Du5YIWf6EyefB9p66Yf7FLiWGJlF+AIqUB/FjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpNpgG0R+sDmN+rKM3FdSxD5d13ik7sv8LKmovCUggPjgyq4QnOKL/9w4ChNLvBv6YUDLuFcEhHMvAS2dM2e2uD+5GvSp8gX33EUOPiIRtj1ohS9FamjK4CemmC5G06EWqm/Ntadu+3SPHiZuBssh/JoQZVz/5yTS/9Ctjl+KLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIexqk64; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-523b017a5c6so6145322e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716202991; x=1716807791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDt5zL9HqHL0LNTVxzu6RK9k/3ub+zUe1M1krBVr+UI=;
        b=hIexqk643Cqu0SJT2YCRJ1t7MiZFYAeTDN2c4SjzbZdrZjhClFwZVuci8U7zt/RZtC
         iINOQOVe0bgHUEgvYW4rTmngkXAWdlTtnzkW9SrvniVmEGVRhYlhutqYE4BTG5NN8u7M
         JtCxI5zENy6kQTiitE4t4HyDhMln2bO/M2DYmOGV28HW1Ugvo8nEkCJaP4cGe9xk//Fk
         RjTiKCXQ12AvpxN99aAMyzDKWNI9sU65OYjiIg7bqy2Cl6I1T5YOj8Wu8qlS0vdRZcJX
         FkTRLJ1PFeZ4B/JNTog7d3zF+utAKUtDOdAEXhizrVSGzXJA3RibwlF3D6kgky/4aNil
         lvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716202991; x=1716807791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDt5zL9HqHL0LNTVxzu6RK9k/3ub+zUe1M1krBVr+UI=;
        b=Gx2fBHv8xnCJCzQ0A80KPgxRFEp7kyNIGIuJDI7YylQBull4bs5UaSEc5LlQqd1hxT
         4JaDGhB7TXMSyR7GPAOrScrhFHDUPlC52jlvdN0xeXqzJEEOHglcL3WujmnBZDX7eP+M
         +0lKOptrFh1Nvs1xC0bhU7Vc9uPGgJSQqCgWJZ9aCYFAJkqzCDkdjToyWSIVjEO0+Kve
         8JmtLjhlMVRZQIUnlHRmb2yXUmn/Ka9Xd/8qNcRRkcoa32hRbekYPmD3QS+LtLQmJtmG
         1yy4YM+EL2CeEf6m/c2qND5RE9DIYM+xpJc0NlsdzvE941qfeg/ZEhZNJPSZ0+VjJh94
         bi/w==
X-Forwarded-Encrypted: i=1; AJvYcCV1ysXi47LCk883hsg6KzdHo4XgfFT5jq1Fl/4Xt0GSRRvm1Gq0EO7Z9a9j0X1zDY1S3jFmpxL47FlTEU95ijjm/Ghzsx+Y/gL1zGid
X-Gm-Message-State: AOJu0YyOII3pHTYBkwIMLSk9REwLrszkni2z8Wwv5hO+dcYp6x7pfVsn
	RMOsSrrm7u01w2KdGdH7ugh6OwMAXUhoAwhMLxMiH+JA/kKsT4nxNcNNs1oj79U=
X-Google-Smtp-Source: AGHT+IEACx6wIZ/owZMa9fgLdIORVLGiIVgPJ5CApXgwF8B9qZycal7wPuLLAhEdV381KLhAEa79fg==
X-Received: by 2002:a05:6512:33cf:b0:51d:9291:6945 with SMTP id 2adb3069b0e04-522102785abmr29386158e87.44.1716202991332;
        Mon, 20 May 2024 04:03:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5225132505csm3241339e87.116.2024.05.20.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:03:10 -0700 (PDT)
Date: Mon, 20 May 2024 14:03:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] drm/ci: uprev IGT
Message-ID: <4hnd6bznqsp3ve7dh6uhz3ygs7yyapqcrainnqlhfejomcdbvo@htlnfpqb3jg3>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-5-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:55:00PM +0530, Vignesh Raman wrote:
> test-list.txt and test-list-full.txt are not generated for
> cross-builds and they are required by drm-ci for testing
> arm32 targets.
> 
> This is fixed in igt-gpu-tools. So uprev IGT to include the
> commit which fixes this issue. Disable building xe driver
> tests for non-intel platforms.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Split IGT uprev to seperate patch.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

