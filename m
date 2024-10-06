Return-Path: <linux-kernel+bounces-352569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1A9920DE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C8B2819F1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7F18A95B;
	Sun,  6 Oct 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv6FS7Jy"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8148155336
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244020; cv=none; b=iwasfsNRwl58kbYC85naWNFrgTiB5hGcDhwQJt2ww1dfQPYu2mAV6vq72eb3qUPWgXXFYV4I4LJUG77yhfE3vMVuCR201o9jHQ2bD/Azr6lY/pgFjtYiyQdrUTMRNdpi0dFcrf7FV2oCQDNa9pNdEPnw7Ia+xnNWE6vyN4GOtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244020; c=relaxed/simple;
	bh=t24rienVc4EcFw1ZjloxygcF35IiW56DAVO5p2W/jJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB3DPhZ44fQpxRvsB8XbluMu/QIbv8WA+wx1UktLwI9aIAunzykBLEr/agQ4GeEX/TV2Maz1LxPBFjCCQWeix3z3Q6kmUmofyWrBcaxmuSHdQeutzCvQaaWaamirdJ6UW+ALcd9QPFtZgnetRvUn9RsEZ4xWCJ+83f+appVxfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xv6FS7Jy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fad784e304so44209001fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728244017; x=1728848817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nudt6VvmPjF0HbFLFck+5c0LXbisuTPtkHJzkxMI8Xk=;
        b=xv6FS7JyAuqkWRKoJSmW1nlT9ZOV5HHlARMydCEhjVvYUiwWXTZocgR1MN+bNmBKFl
         kcH6U8JMfTkVTCY1NyERnzQ1xbllY3nkowjqPnOJJ6hhK85waRHmvKofE9BUEy5kg67+
         Y7BwF90350vGsqS0CwU2orfv3biXSVZH0iIt9V6lNfqKmKJPWszP8rcOIes5sLHk8wT9
         IoLKC9bu5g45ceNZuteA7Vcau6QzCVoGpWCNWG+i3NHW5gnIYSsDTjdU3+UgPlyhuorb
         961xtweZHsbd7FerqSGAVqRB13WU2NOXBogBo/h83bAloWUJ2WcQFw23OTeUHaXSRgDn
         8SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244017; x=1728848817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nudt6VvmPjF0HbFLFck+5c0LXbisuTPtkHJzkxMI8Xk=;
        b=GlfEU0myv9P/gf+n6m9KsheHx1vXephlmhZjbOiJRzxWVJMzr6+zaIpIh2Al+7m9/+
         nFNe7AcwEzVXxQ74demV+n89PR+23GOm0BWcPqvq3TdXBim3/gB/OBtOU5d2G7Ho06Jp
         dkDwnwJUcJEiWb8wfJXcruysazdQgF9FxiZOZcsFkPXoe3zZqvhnxgmC1mkd7nkecXhd
         brqzN3eUNDk9/aUEU5Pcr5gFyAHzqhA3AArnG7PlcP4GLKGlUAULTYjHo2cYvitm2Oja
         zWzb8UKTTzM20VLkgbO0+7T8CqUOmZfPxNYkOgV0uDTt9nMwiGlxUPYdUTdRTZF5Qbf5
         xS0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxzb36hjgMp8H3CAFU7OHcab9mpS/CPgEWkNFYcsKFPLY1YDJNqDHhtYSAgBFQzBRJdEpoL82ojzNCuJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZTJj4QFiaV0ixzBKfj+KX3oikXythS5CipIXKkQq5wbK99FA
	Bo3ZWd8xjAp7lgqxcNJICiaVwH9U0/l6NnKsTEAO+3oERqfljx4LvCLoAquwJuk=
X-Google-Smtp-Source: AGHT+IHQ40ic093FZX3v4B1HtEnY+cFajGIuhrqmUeVmOK/1zrCrTPpZ72nuQMgcgqEOYhJIrHyv5A==
X-Received: by 2002:a2e:f1a:0:b0:2fa:d84a:bda1 with SMTP id 38308e7fff4ca-2faf3c1439dmr35177721fa.10.1728244016963;
        Sun, 06 Oct 2024 12:46:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23e0bsm610963e87.243.2024.10.06.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:46:55 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:46:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] drm/ci: add sm8350-hdk
Message-ID: <eoumkcfeiw5v5apczgthateomnhjs3ihdyjwcjppg4gwgdseo5@vh3loy4jlma7>
References: <20241004133126.2436930-1-vignesh.raman@collabora.com>
 <20241004133126.2436930-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004133126.2436930-4-vignesh.raman@collabora.com>

On Fri, Oct 04, 2024 at 07:01:20PM GMT, Vignesh Raman wrote:
> Add job that executes the IGT test suite for sm8350-hdk.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/arm64.config               |   7 +-
>  drivers/gpu/drm/ci/build.sh                   |   1 +
>  drivers/gpu/drm/ci/test.yml                   |  16 ++
>  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |  15 ++
>  .../drm/ci/xfails/msm-sm8350-hdk-flakes.txt   |   6 +
>  .../drm/ci/xfails/msm-sm8350-hdk-skips.txt    | 211 ++++++++++++++++++
>  6 files changed, 255 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

