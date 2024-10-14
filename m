Return-Path: <linux-kernel+bounces-363987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21F99C965
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3935E1C221E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC719E80F;
	Mon, 14 Oct 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evt0oa+U"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73513C67C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906700; cv=none; b=G7z7B+3oPSddenY8AZXyMy29wRcotUQB/hF9DhgoPJZmIa5yTXgMLPPADfVu4Z6wgFDjX/VDs3tgUNy0DcPvgVhJv/ROPJOq0NvskLVHBfFuorf41yIr0nSgDWIo/nkxLQ58VL1aqD94rMsp+fSDM/IFEpDgsUq5pDeWMoN5Gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906700; c=relaxed/simple;
	bh=H0U3uZ7KfOsYmM2ci8kiRSH44T1xP9+zi5pkF5bDyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecsjnUunonYfCiTkJeoY2MjavFXRzp1g1H+99ZTXLXPJP61r5EFb3dLcxanaQPtHzbcqcPX9mi6K6oU+mYG9IUlW6gT9Y5TM2DzjiwNmOkEhYf7rYzlnlDjQeSroJAA6cwK0AgGjW66Ur8DIhNfPf0GjVJr+b+0D0jgDFGsZf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evt0oa+U; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c913aso895667e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728906696; x=1729511496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1xWMt3UTvAd/JjpHzhIgfyaHO9/VjAl/Sg2CqO7Ryw=;
        b=evt0oa+UcwISwgOMlx5cVBO8/zIIC6OWWqiEyXcyVWwugswgpP+uFXCBj1CeXi446Q
         q1M2pjddkH2t05BC4wMzCY72TxZZReSd+jYN9TAutNKFn3r25BLlT4eKhztmU940fsG3
         a8bcUN2dUplF/ARbXZ9kwBKErJXMkB7vUIpoTi41pQT58VN5A/7c6b9r+9R6NJlouxh+
         bZVXuxbFw6ld4Us0+If/d8EK0wRLUl3UDfifZyKQTCtWSxcp01LDT0hQNIUxvRSQSPD0
         MuYYttyYJy3D00xnK7NcQMMvOP2XZS7h8ANz/mNFPn7s0C6YURxiIgtPYtjb09ZjVIy/
         mqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906696; x=1729511496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1xWMt3UTvAd/JjpHzhIgfyaHO9/VjAl/Sg2CqO7Ryw=;
        b=ooY9YmLKEFbh5yqBKISmrYSgNLNKGfH7uALTfKUoEHTLnwLDOwmK4+KokrRh9ku50T
         kcnaiM7JyJOzlI6bqaWZZ9aNRosQG9+XvxOhY58KFt+DBoGs3ch0cj4AgNUVPSA1V67P
         JnvnipMeFCGipoBMX2vsqJoS4B3bhdyyN7f06M9LkkGgTUjSduY0a4Hu21j/MZZTDbOK
         9Dl9wZskuixejGLEt/KI2r4VRHb/i8xMdA3L1zIZVoy5Ocac49RMJFkLeab6r45+FyJl
         HRKNXong8REhc8RZtYRnfNVlZeQQpMTeN9fmdqxFhkIpkFUANUaskVH1O/CzOupOHRA0
         Fueg==
X-Forwarded-Encrypted: i=1; AJvYcCUmz/VeRTqqI3xZh7pDiu9xNMJ3/RsTz8Fv1/mjVqPxbyJf2Qszp3tARtO2bNTms0NeEL0+rm+Mpb2tuB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvEXnhggyaqz8hraHN8DrYxqF90dPVPVvaAAxoDv0w6H4B8x6
	jyUREx6xHLSqhWvmbveMu0HU1am/cgwwTvANSm5YdZELpXqIycdducDA7on0Mpc=
X-Google-Smtp-Source: AGHT+IHHuAMIoaQuFwnEb6QkDi1r5lPPQLpCWZGzSTxE9JYStKerl0AiV8ueiqeqgLDWlOoq82aTTQ==
X-Received: by 2002:a05:6512:2302:b0:52e:9b9e:a6cb with SMTP id 2adb3069b0e04-539da3c649dmr5594953e87.15.1728906696406;
        Mon, 14 Oct 2024 04:51:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e85ccaedsm874894e87.58.2024.10.14.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:51:34 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:51:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] drm/bridge: it6505: improve AUX operation for
 edid read
Message-ID: <e5slvrvg5es5bzb6jfqph53o4lylsqyytcjvopkkp6tasfya6p@iht5n3cqedfk>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
 <20241001064305.32180-3-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064305.32180-3-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:43:01PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The original AUX operation using data registers is limited to 4 bytes.
> The AUX operation command CMD_AUX_I2C_EDID_READ uses AUX FIFO and is capable of reading 16 bytes.
> This improves the speed of EDID read.

Nit: Improve the speed of EDID reads by using CMD_AUX_I2C_EDID_READ.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

