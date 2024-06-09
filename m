Return-Path: <linux-kernel+bounces-207490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D432B9017F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E6281317
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFD1F932;
	Sun,  9 Jun 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZmWpfaR"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54E4D8AE
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717961586; cv=none; b=pcM3CJZ3EYD8hza70cVjDts+/F1UtzpyeVv8lqrh7TneXsVM8ojiHCNfq1l4P2zuZG6TG+YcHunONhdCZ2Z580UeNHH27luQ3G+/AfWzh7etOcWhS+c0pJ8eTJYPHdTbE+C0YjkWkpqG+K4aW7PfWaDsxH3Ay4O9lNG6/d0tr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717961586; c=relaxed/simple;
	bh=XjbWpDkaZCQJlX1Xso3frog+iV4mNS+oXnpMMsHmkGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUGQ+l0je9ENksd1SjX5EKUg+33pMl2YRPFaItsAnDbkPIf0A5AqZFdsonFfyDtOabPGnxL2YQVbiyYxvKxEgE1TXhbWV/eu2Dfh7jSfkAtxk/mRSgYd8RBcQm1Xlz9ew+YhMikUBZfEz55NyqPazYiE4EBQqgq6+Kt3xBRJoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZmWpfaR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so41645991fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717961583; x=1718566383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Viqm4Rd+vVlyg7IQXnYQo+tnnNOCKizP2/Q+mWLtnNM=;
        b=RZmWpfaRTCAO8ROZkmrROxEx5L5q1C2lOckaG33jRfbiZxY86IpVJXJ3CJzKEUQoxA
         VWo9RuezihwZrqAyvcM48N6OTZghKMiHKWoxIzQizdNtDtzmzco77LwunB2o4QtAc/fI
         08qcoRRGI1jd2hbP9LiR723zSrSPzOUJfTsgtFjtHDbG5Uuvsv8fwFPhN26yLfYVnzxG
         xFTKVKq7wN1y24B+aUOQTiAIdr5PFHeyBSUQnZ294ex2o00Wx4AX0iRRthTuEmnd04+b
         THx8NVDP5Tf7FqqjRA3G7TNhFXWR+UQcKBonIQVeCBoHEKNVi98kmWpn4vlhjtQ2oqE1
         HhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717961583; x=1718566383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Viqm4Rd+vVlyg7IQXnYQo+tnnNOCKizP2/Q+mWLtnNM=;
        b=eMEOhm/06oAlPnMCHyantz8ErK+IhD/eUUtRWaIfGlbRvCl55oh65vBsdE6zaei//9
         Eb1fcKl7MMYQy20y6RatMLJkc6WMYKsgSU4ujglQbmkk11BEvSiSW69baJ67j9hF72ph
         +CszbOY7UmJLVqqxnJCwVVMpmj7n4b995LxURuj9447+mZAEGlIzEiA0ERp+Qc7+jI/K
         5mEHw/EWxCKRxVuDJD5Gn/WtULXGh5Hw/kBdAquqTpV9A6QBJ7cBn/2B+R/U82kc+GOW
         BvHAa1ygXFkHm6ApZ4jVMm9Ov2HOX+xown9qDHCk9D+JCnw6kznC21vbmseGOP7Jlzok
         Cy9w==
X-Forwarded-Encrypted: i=1; AJvYcCUkcRz48EqdOuoVnr+y4w6xi0/OkRY5qAsUUzA6StYKoVIfX1/z5w7D2C1d7orJilUDrhz1xXsC2VtOH0ApBuNcK57iU6IegIqNW8Cn
X-Gm-Message-State: AOJu0Yw/Bke5yQrQoc9/Dhis/BlEK7VltnLZXsQ19pjNrxyhdJcQQpHJ
	myCuzUCFULJ/Tn2Czk76asb6LND31e23ZloxHRMq2NzwyOdshcsiNTIwEPcZ9Vw=
X-Google-Smtp-Source: AGHT+IHr4rTUrevKHEZm6LYZHWVX/UEWe2caOFgwKBeK//7r7LpbbqtNwUhcdND+fIL/TyRKCR97+A==
X-Received: by 2002:a2e:740a:0:b0:2ea:ea79:4fa6 with SMTP id 38308e7fff4ca-2eaea7951ecmr40855531fa.36.1717961582894;
        Sun, 09 Jun 2024 12:33:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzbgq2gvv5-kpclzt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a04:adb1:631c:fd0c:1269])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaebc60f9esm8825191fa.123.2024.06.09.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 12:33:02 -0700 (PDT)
Date: Sun, 9 Jun 2024 22:33:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Allen Chen <allen.chen@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Hermes Wu <hermes.wu@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: it6505: Fix potential NULL dereference
Message-ID: <3u6bktmaxri5ktwmhstrjzzi7f2qcupy6tc2zuh2qjreo7s2cy@ypl52gxmqfii>
References: <5e6e8882-478a-46c0-9119-b643d524cc0c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6e8882-478a-46c0-9119-b643d524cc0c@moroto.mountain>

On Sat, Jun 08, 2024 at 05:21:08PM +0300, Dan Carpenter wrote:
> Smatch complains correctly that the NULL checking isn't consistent:
> 
>     drivers/gpu/drm/bridge/ite-it6505.c:2583 it6505_poweron()
>     error: we previously assumed 'pdata->pwr18' could be null
>     (see line 2569)
> 
> Add a NULL check to prevent a NULL dereference on the error path.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

