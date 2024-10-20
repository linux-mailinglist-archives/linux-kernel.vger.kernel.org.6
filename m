Return-Path: <linux-kernel+bounces-373264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353A9A546D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07F8B22263
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE4192D73;
	Sun, 20 Oct 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoKWGfZS"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D21191F81
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432408; cv=none; b=OwsTwdzgHVhwekAVOr3O1ebeAal74Rl0fVbqQvtsg0WORb1pfIOeUgDDpi0Vm1tF36ZlofCbYG9KRXO2HTfbBu8UJ2Uuqs5WWG3Av0C6llzf6B7FabKeRQU4tDg18YPIPOc2GR751wdwBBVu2IkierU7Beb4BqHYDVEbJE/SUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432408; c=relaxed/simple;
	bh=Y36Tk3BAKXay9jg1/YP537EfP1diQ5EjGNXaVf8dwd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahFWEIk/7tXgYN2V42AY/RhvaUtl48DZdbmmWEVJVu9rQ3YFNiI4c567SqR/mo/Aib1eeviPmydxFX4PCHr8SShLciNbkOtqOIdf//hk/RIJaH2ZZ5tab8yCquJOjJdSx5bBTraP5AaCpmD18N6zPrqgFR/0GtKaHqe3YERoCG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YoKWGfZS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso3098793e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729432405; x=1730037205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dcZocbQAxMZJMuRQMBhMQ2acDaQQYkZv0genuOW6so=;
        b=YoKWGfZSB+NBVFsNlId2IEiAxg3gTeserUjGYaGr0eKo7weEMFrNRMQCeVMRzCZbmO
         rSHET30Awz31IyJYwSNjB/iWkZH6xGci0PRMeFl9VnRS/kCBSh9Uaa6VqRgjaH7nXOOJ
         X2udBH9WS/x9+bsxXNNN72B0jGWQ+wJEM6IFrduldkCpkhM6vAY1BhF+JLoAsciteH2e
         ViSD1Owp871f5/jufIBfLDv/iHl4qjkqFpsiKz7LHmXBlj5aKH40DKHjd+xwQ0TsmRv3
         oBuKwopM/42Cg8WSytVT4+DMg0iDq9APGrBdqIZ5O+mE8eA+IC2b9572WQrdIa8JPcjf
         bZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432405; x=1730037205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dcZocbQAxMZJMuRQMBhMQ2acDaQQYkZv0genuOW6so=;
        b=ozy26ZO4WHLw5+kWIgGq8h4BXqrNpYgwHcfbc6oDIj7gsc/T3dfd6OjW+Q7qWyAkrY
         jcV8H6DJgw1TQlM0aZ8/SZozX4jj/YIGgY05Z75IO35GtxT6nh1CzKcr3utOP+ni2CuI
         dBTIR5t9PkZm8y3Ro4Ahe+a9TkYiBH3PpA90hhwcDZ/rTWz/S9Mai+Gq0VgccB20sW7t
         wyU90s+0B4i7M7qznzTbfld4fA8nlG5neWfGesgIQigIBgO0rVPozQixtE/+TJYeigC9
         LoNcy6EwO8X1pRvdSOhZPMio2XQjmC2MVx3RFO0i+j1pNOM4osULqZIC/89C9msOet32
         jUDg==
X-Forwarded-Encrypted: i=1; AJvYcCWukv2X+lX2AyyK37zplPr1dBIgc8nECqnp3ZzbhyWPOkdmBq86OqryuaYU96Xr9JZRS+aag4pUB0aFCu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnBfeVmK2uh0rZBYETKaqhgoc3ZqBCIaCd+preMUSpZGDGdVf
	QrLCdA0X5AEKg5qrYpHGhQyIcjrpQSpLiY2nzNZFf4W0exZdXC+PAjm5kIBAy1w=
X-Google-Smtp-Source: AGHT+IExkPAoH6vcrB6ciPGIESblnBskG+VZiXEozUG0W7ri0WIjDPZ44I7+RixVz9rzjj9APfG7Dw==
X-Received: by 2002:a05:6512:3d88:b0:539:fd33:abd2 with SMTP id 2adb3069b0e04-53a154989aamr4051319e87.25.1729432404693;
        Sun, 20 Oct 2024 06:53:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5951sm232241e87.58.2024.10.20.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:53:23 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:53:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Pin-yen Lin <treapking@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>
Subject: Re: [PATCH v6 02/10] drm/bridge: it6505: improve AUX operation for
 edid read
Message-ID: <bs7oewydwrzotmaqrlruwztwbx52lo26j6h62odq7j2rmijzmk@h3pbqq2e6s34>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <20241016-upstream-v6-v6-2-4d93a0c46de1@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-upstream-v6-v6-2-4d93a0c46de1@ite.com.tw>

On Wed, Oct 16, 2024 at 03:54:14PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The original AUX operation using data registers is limited to 4 bytes.
> The AUX operation command CMD_AUX_I2C_EDID_READ uses AUX FIFO and
> is capable of reading 16 bytes.
> This improves the speed of EDID read.
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

