Return-Path: <linux-kernel+bounces-433933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F19E5EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B13B169C00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1122D4C2;
	Thu,  5 Dec 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1fRl4Pi"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCC194AF3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427472; cv=none; b=RoWsTOIhTANnd3yPZteKMW2xOkEaBV6ZEcGG0NtYRLPt/qpdV8K4Vs6PL9kzi8ol7jMiquVKvFGU4t1YwBro5Lzuzfg9WAEQZLUSgAz2FcaRKzO4TlAhSUOLWcMOfS+57XkuRhFHa3uAczwXUj3w1bfgMHfWwjD/8qbxXZo5Z+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427472; c=relaxed/simple;
	bh=dL5DA5YmPHj8zIzYDTZ9wNaSz1ji//8Uu0Gc8/UpJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bplcAl0M3P0ORX3+7KiARNMvVplZNm28aE13t0CJxwXuRCBx8wRXrUlKt0L+SBx+0lVSt+PqaAO+XBk1w3EKM/Z1R/Qti37HoKYzM/ShTu9eT0614r4y7vpIrLyOwt8jpyYVfALs+xib2ImOapFlDUd8IzA3t0mo49qhAJLW0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W1fRl4Pi; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso1704090e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733427469; x=1734032269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffMfzaWl4ZxhGzNXZBnVvZ4mLesiUwKAMA7C3eofRvY=;
        b=W1fRl4PiN18BQhHtNQcqo7b3Vj448umS51XYwVn7DFvQA9oIJEfonWYPsDIWKZ38nW
         bIP2Vlo41E/Eqs58VgzdZI4ja7NOS80v0jDWtcNI8GjbYVoBX3oeNp3RZmxenpkEGMxM
         OFku45jdmg6SbTEYdfvs0X48bLW2H2uYfLb76YdPrMA67tE8eGsZMrhplFhAno7LTPwf
         UON5pIpnEV0qkbSeIdR6Z86qTGd2KfSMH1l0tc1VEsETyZ9TF1VSLcz+N2rN8sbYta38
         Az7e+75dKdgPK83RiC4WiCANV5ZBVP2dpuvz0ojB9SqrG0oB/OJJsLYjwJOTpat76HZa
         HHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733427469; x=1734032269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffMfzaWl4ZxhGzNXZBnVvZ4mLesiUwKAMA7C3eofRvY=;
        b=rDZ2tYEfR9D4jb/h9cZjSHt9Ygau736NC/eHMiA1FxdDbkR6LU7UoO/XQvg45qiOiE
         wghPHr/6w+BH/tcVJ64wBBgLuTxe+eJOZP2n8I9F/Jm0VBJrbRllHe5fQ8cPJi6x6zmq
         cgN5wsvXnjkwc2PdB06gvL7p33E16FAs3RigEZ6laEzmCaDOeMXts5yu1M8aovQHQ/w3
         l/cUVFgqP9UV/52aJqxEa7xPAJBQm+tCRhZ9gq3pr67v+19Y1FLLIEguND7+zyeSQaLR
         NJkzXhXjWWAezD8xmGkVfAJXtJDizVC9uEDBOTeqwF5uo0eF9uEqCc9YntJ76Xa5Ko6x
         3M2g==
X-Forwarded-Encrypted: i=1; AJvYcCVwApTybJzLw21k974xH38mMBeFSAr3uRbsoTDJHngV68Uyp7sMf9FteIQbN/0SpqyEB71Bfcazf58b6hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuclmTeAa0DT5siOEkfCvXArdkkLN7AJQBwCj+ZLR288lwlP5n
	fSh6zSqZz7ksULIn06I9j80ZgPnQbk9ycbBEOb1LeiwGI1tT+UEwLTyg5rq4JC0=
X-Gm-Gg: ASbGncvhanrbRFXRs7GicdqoH5KuV03yzb7f+/VqBRFcnFJ+WHece8uFKUVIT7eTYN/
	SeZ7uX+jl3QzYIzeV+p9Sehg75onp6G8vV08np7j51VieshbOeR3+DugYC+yoMdxAXbhB+EZ8JE
	duuijqai8ENwqmpQRa3MbWjAQb583x4Wtkd/jO7wC8JqsAKLsuHUjrRnSEfcNWxY2qQ519PnKKx
	JejPJu7FdG5/wqPNsWh9KDvGlMAP0F1k+Xvg0XQnA33tPw2tezMteLVztUJo/tAVeTLa7nP5PHg
	cWzb4e0GIF5yXCIGjvlB3t3WY7KSgg==
X-Google-Smtp-Source: AGHT+IHouSk4z+9DUIpuLa/xoDTs/njDFQllLy+4Rry7lGgtHnn5l12emLPBbFN+f3zxai1eSi/qpw==
X-Received: by 2002:a05:6512:308c:b0:53e:2789:f0ca with SMTP id 2adb3069b0e04-53e2c2b9004mr88734e87.21.1733427468718;
        Thu, 05 Dec 2024 11:37:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba7d0sm318153e87.143.2024.12.05.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:37:47 -0800 (PST)
Date: Thu, 5 Dec 2024 21:37:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: visionox-rm69299: Remove redundant
 assignments of panel fields
Message-ID: <uar66c2tl6esj4ecce3nwskplpphuarq43su6nwqriv6tmvkl4@gyjqcfahhpto>
References: <20241204093942.1374693-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204093942.1374693-1-wenst@chromium.org>

On Wed, Dec 04, 2024 at 05:39:41PM +0800, Chen-Yu Tsai wrote:
> drm_panel_init() was made to initialize the fields in |struct drm_panel|.
> There is no need to separately initialize them again.
> 
> Drop the separate assignments that are redundant. Also fix up any uses
> of `ctx->panel.dev` to use `dev` directly.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Also fix uses of `ctx->panel.dev`
> 
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

