Return-Path: <linux-kernel+bounces-373189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF29A538B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC10CB21F31
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AE15445D;
	Sun, 20 Oct 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8zJi8Nm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E646AA7
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421350; cv=none; b=I4L0flJcDryjJ/iuvl50IhOpgdRn4+aTf7htW6zH9GqDemXb3NOJPgZHP981BzuJ+gsc9rXN2Gq4HEPXZijLc56lEimlr9M8yGj05vanZdTwbDpxDKmQt4hdr3PxxWcC0mY291PUbh+ua2YnXvVBew1wEBjB/V+FEi5SHz3KN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421350; c=relaxed/simple;
	bh=aHYrWo3tXa24le8QFqOnmsunJ/wmjI4I5WZumvM2HtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRZ5nl4zTsHH0BREtJOoss++8SAXF5ucR4cENOxbSwbuwvWyxkh29A/AL0gM1iBWYZKBUjc8UnSUekJdGpnFCq91qgsjzBNTtJddy9f3EY9ORdFFfgxZXDSSsi1Zcrjgx+2EDXzNm1KzodBoJAqMobwu+WnAdc8AWcVVhLmRhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8zJi8Nm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f6e1f756so4135761e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729421347; x=1730026147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XnRvKQZOPjLLwFgoT+R7Kj3/LS+KzGl7QLkoKVG53M=;
        b=M8zJi8NmdwFfpuuBFvWiJQywyPvKM+nK/dk708LBDZquzrspKj2H/dZecP4xbCtQ+O
         cTBGsYL0YQfY+zpxuoqriOkrNT2UhlLPsKP0fQxZtuvj7L/+2+qmdaL5xDukoLeHli4x
         kEnHIaGZQSg5GEBXznJqSloaXEzm+yllySKlb9kNSk05DCCn2Y/iY64CjM8POUxx1eFb
         nyp478Mg7sOjbjs/mxAYljecHO7oJBBTeZFu92xKuGtvwDZ75X5ME8z6VBHg2lPh/Q+B
         JAN0fBO4CvDff35rxjlMX5EaQaENVS4k+ed6PhnyLE2uudG/DKYtSRooQblQ+bRXlV0E
         IbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729421347; x=1730026147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XnRvKQZOPjLLwFgoT+R7Kj3/LS+KzGl7QLkoKVG53M=;
        b=F3mPGq4Gx6XapkxMn3bzCecg8baTZqEHlS9fXoup2EfN7eeQQffZIWhl5n7D2xy9o4
         cVkqTtoKACO89fPViC9Dx1kqc1toFx22EI9usZdUg7D/9dYpnZg3WBqugh2XRou7gkBP
         rPINRLH7v7h9cPoN9e8csOj/w3enGglrL7ICUrwRrJ005yKRSGJD1zfG0AkbCewxj59t
         g6hdJ8TQk0UMRe1uv8OF9rebV+/LIuRwXdV84IK6K7cYpdSgPfZEcwH2jntQyLTZjUTp
         rb2DBO1p2LIF7/10CqR6Ar6FYkEnju6spjU80C/4oJp6onTWrO//XlhU4F9kxnq3EDFa
         MhIw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHekDHKiKr2ORNMqG0iamQX4N8ciBN0Ev3824hF5jnN3JZjp95sbZ3a+XqKTkEJ5phem98tBbYs/sbxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVt0amQAD+b/T7sHrlmi4fwb/L2Q9dwCtsG+1oQosHFVq6VnS2
	Lw40HSz2uSduvFzhrHwgRfRlVVJ5Q5hBwoo1CUmJ7G1WFTRIf/Yu5v1alFmO3S8=
X-Google-Smtp-Source: AGHT+IG15odfy1uIpfdw/x7yt8H3vJ7DWHk8bseIVvdVWT8X/fdgPz4GJSpxX6HrPRoBkC049bAgNA==
X-Received: by 2002:a05:6512:ea2:b0:539:f995:5b00 with SMTP id 2adb3069b0e04-53a1520b222mr4261814e87.7.1729421346743;
        Sun, 20 Oct 2024 03:49:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e587fsm190423e87.10.2024.10.20.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 03:49:05 -0700 (PDT)
Date: Sun, 20 Oct 2024 13:49:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/13] drm/bridge: cdns-dsi: Move to
 devm_drm_of_get_bridge()
Message-ID: <pw2zhwnyx6xn7lgondigds55ow6fkdbyh54sfuk3zqvsdsedtz@nnfsv7wenqrv>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
 <20241019195411.266860-3-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019195411.266860-3-aradhya.bhatia@linux.dev>

On Sun, Oct 20, 2024 at 01:24:00AM +0530, Aradhya Bhatia wrote:
> From: Aradhya Bhatia <a-bhatia1@ti.com>
> 
> Instead of manually finding the next bridge/panel, and maintaining the
> panel-bridge (in-case the next entity is a panel), switch to using the
> automatically managing devm_drm_of_get_bridge() API.
> 
> Drop the drm_panel support completely from the driver while at it.
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

