Return-Path: <linux-kernel+bounces-363985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F799C976
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3391B2505A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6B19E7E2;
	Mon, 14 Oct 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvEJHHaY"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028819E806
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906603; cv=none; b=WGqRDP4RR88xcYydcJ7NWPQcRhuJdMvVwUZDcXghFN/CRqEGamxfvMAIHvsimNf6gLjTuf0T5mm/O2u9GxPG3DtIZO+MIq0FlwOrKoPM64OAoeGBl787H4vXez/cW0r0EAbSOFgkJBO0HybnCk18oYPEg3Y2u1EfPoEqVTk7aoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906603; c=relaxed/simple;
	bh=ygYWdRNLEPgpU0RcfDsUTagJdgEPb//UzGUn4Ts4m2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO1j5gMlp4y0uYE99n4QJ6JMU6Pgo2lZm2DjKjbLfAXGXNS+u91x1yhq8B6iNzUAyL+5+HEgcqGOlIn0RkwmfjuTq6HkfHMYZKKlF7tJ5VBiGwrTP05I9bxK8VB2Rak06i82bCSBOjqj1CBamdEFjB+XtM5D6gMJhMn8YuLYgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CvEJHHaY; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e3f35268so2320095e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728906600; x=1729511400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iew+RP5Fy2E/40HugkpA9EDa/gYy4wZkIO70iXxUijM=;
        b=CvEJHHaYyh6oNBN4VCQZmezRuBTPMuuvBjiJbzS6nRBmx3fkreVGrGdPnjz4lUOOjI
         8GljKDBlriYJaZSGHYY7viZLi+YfY35gjsQR7dT1bjhxJoNr5ZJrTXxXxIoRFQeW9UVK
         U9Rzf98XZOZrtmknh48KJySCkRmHb47VlPrUDKeU2Cey4jIngTETo3O/HVh56qUt+kJ8
         JFzZH4tNru0aViwkSYNXdBA3OBbPyblv/K67k2ISMtxQCTB6FggGilAzBhN3eqEWrSl0
         DoGS21M9B/jCoOzoXhtcSWLhTzf8rucuqGjHOugL2R5oQSDSd+Ul9fjP25PgAvrlPeyy
         7QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906600; x=1729511400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iew+RP5Fy2E/40HugkpA9EDa/gYy4wZkIO70iXxUijM=;
        b=J85XawzQGhON+CrE0CNUpR5e0fmo30hlWzeD2JX+yCkjYL8KfYoBi4VTjrMcHz8VkB
         G3Yk/m2Jyi4bAys/79NlzG6pvvexaykFJRFoY3dSjn49THs/pdZV1Vhomoezsk3DBWfU
         9r22dDF1E+S2Ql3NBKwHLd4oKIBBy4etQYCkHoPL65MPyW4vuzyC9BVsReSlm3CjG0Yn
         iaAuPtAZb6kU2mdHO+b0ctkAGfKN+DqVJkFIz4DI1q+BrzwQE2rVolPjzxBIgjcZw2DQ
         8b+SOQIAIMcU9pw7MMNnWxyzvLbaQN1a9kjVS5sA2QIUSMe1mmUKQEuCx18+B0BK9eWG
         deHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkozdJRn1ITFt0lZV1VvMdWY3VOLBAPiC9MM5KH7cfR+s+MTNIsOlkHLNpaGs5z6+TzpO6BehW+8pYHfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97L4bLt3uw0bmfiKDCoU3NvpFbdQUBhzyLKM2H8icC5gU97nG
	FYV+elhqPgNHoBT908cKCc+e/+rS1G8U9+lleNZ1oHiMBS/56mcR2lqe27s7a/I=
X-Google-Smtp-Source: AGHT+IHeZFlUvv6UeKWga3KrcKpVyfEpfE58+7vHUSg0GUxX8MLLjQZt1fSXn5N5ExlcM614tFbcJA==
X-Received: by 2002:a05:6512:ad3:b0:539:d428:fbdd with SMTP id 2adb3069b0e04-539e574b00emr2705259e87.53.1728906599992;
        Mon, 14 Oct 2024 04:49:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539efe446c7sm585904e87.271.2024.10.14.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:49:59 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:49:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Chen <allen.chen@ite.com.tw>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/10] drm/bridge: it6505: Change definition of
 AUX_FIFO_MAX_SIZE
Message-ID: <2wi23no7jee5hpiyplipjhdmze6a2rulnmhrmukchlp3zui4np@c5yacstbzuxl>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
 <20241001064305.32180-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064305.32180-2-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:43:00PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The hardware AUX FIFO is 16 bytes
> Change definition of AUX_FIFO_MAX_SIZE to 16
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

