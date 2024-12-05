Return-Path: <linux-kernel+bounces-434080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C19E6161
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AC416A579
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3961CDFAE;
	Thu,  5 Dec 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="md+Pov9W"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91E84A22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441461; cv=none; b=btvR+BtzNwrfi4JNbWZg5SFXb754Dbh0xJ2bqLpIIWNDWyr81yW0xBRHwfMP8B7C2PCEFhCARFauH+QifBfLtxS6MrHE2x9iLDH4prhFXIc7DRzDS5rvDhRySchBkeGB7eFTQcvToRd2rOtsOPwseAanDXPbqPaoe0s/mHcK9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441461; c=relaxed/simple;
	bh=s2NtbBMQeAbFqZv9Fe8TaMKmwnFhDitUp1q5ryCH/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFoieMTj+3CNKexLKsQLVtH3nEjLyT1E9z/p7GNAIBSf4RuUvI2h16BJfz0fAHrIuNUHHEJYtY5SWDc7XTzYbS8muEyyC9dOaDlm+ZVN0+kkOrRyc8cNw03iwHbkeq7oxihhHjAMe2inr0dML50yrPreUw7EWkXUR4fqMcYFXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=md+Pov9W; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53df119675dso2002125e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733441458; x=1734046258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRnWHKAnYkMS52ihrEL3z2fjZJGuaLl5naxOMGazVLI=;
        b=md+Pov9Wl5N+snrBvLqNQ7Un4YXjEB46W3O06O83CWSpGIjgtyOrmOAoCFs/Vw3qRt
         aegoau1aE7nsaQ/k3xGxhqjiVtgkW87znp7IlTtGoPMy4oGJs6o2iboZZCEY7DWfx5hh
         A1iZiyUklIBfmx8kKJD3UZ8cGsZMqnalO8ZAXB9PKT1ihf7qyWaB4WJGhtLM6a4vnm+6
         EoioyTY6Uk9E+Auej0tZpFTlHN6/zxnFjapoyJmH/9LdPz2Ht2HsNRF6VAYqKO7oJ+LD
         ZE6EdSkKDXnZ5DtD+rc/cbB2azCvsMGcesKwbYQLq+aJ7TEJyhWbuUGSXrlnLAdKgTMd
         o1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441458; x=1734046258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRnWHKAnYkMS52ihrEL3z2fjZJGuaLl5naxOMGazVLI=;
        b=fF46FdYm0LJNcKWCIjaOec2IDcHhJlrMn9n5jvKBzF18HqHQ3bUMrc2XXm/ap0du+O
         bQqPYgo2/taEVsoXnVs14CmnQtcRQxDHlUbu86YbulzBbYyyYJLi5mj/pjfjmySETYqP
         eriWidOXWhiA/E51Bn5XTriYp0xAJkUB0Ll7kBv4xUM0JlxUCuQLCTsfPjwSfvFgF6id
         ZkyULUCWggJIkwNhnaVr/+6hPEBUao2qp5/MAiu1LtHiAi9Gr5lHZ3E4BwKr8q/UeCeG
         9KnVgn54rnrkMpPtWwa9ITkRabjz5ftX6cKDfdYaSxkfT3qj3mUG4rrxeWfmRTAeo0NY
         y24A==
X-Forwarded-Encrypted: i=1; AJvYcCX7CYozpVmS5vM1cyYr11f6WcUARpcZSuBeRHu/5e/wv1tBpAyCmfYqSn4yd99rv47VGqXttIGqJ4n5QTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T7X7eYn2mqyNzDAzj1evHKLw+jFJWEfc76D6hDv9jmjvDQBu
	x/hRf2KIdKzt0uYVOPpsDKAgiyH+W15pxEJI/uSW7T/L9yfXp9kr6Q9N27YgfNA=
X-Gm-Gg: ASbGnct09j5pbAeNtWR1Bi81kF0TGylMbKlzalIs9wdr6LFYKADOIsBUGThkGfinYV2
	jw26EoVNkI9uQ5QBbM3yrbO8tMZgldeUW+c+C6RC4iBc+HqxftHdNR7Lv7aax/AA9YlXO0hyFoP
	NeiGEfHkCn5EAAZaBcCsnjNra6ln/xNjhdBJCWSnhWzxK/XnDYZsaFA49QxUkT2ny0RwuFJ7G+J
	4t+oEhKvUXg0qbPTXTTjrRFxclP1HMq07aYpIwNZC3rg0u12pW69Wtf8yIb3DFFVdpg6Q9CE/OS
	iq68XcIBsctrO0XvATiyzelQ4gIE5A==
X-Google-Smtp-Source: AGHT+IFTMrE9qT5BEMo6Ph+Ruh8YL8tnuoBuFo6I6W9OwPUPfUXB6m7wpo9TdecsvG/VYJvutiKHzQ==
X-Received: by 2002:a05:6512:31c9:b0:53d:eec4:2bfa with SMTP id 2adb3069b0e04-53e2c4fed10mr392993e87.37.1733441457746;
        Thu, 05 Dec 2024 15:30:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca0c4sm354372e87.235.2024.12.05.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 15:30:56 -0800 (PST)
Date: Fri, 6 Dec 2024 01:30:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 5/5] drm/hisilicon/hibmc: add dp module in hibmc
Message-ID: <3ds2jlusdihkby47yjizwmjymspdoy2mwyiupbqctdhp6cnt2e@jux3lq2w6vl5>
References: <20241202131322.1847078-1-shiyongbang@huawei.com>
 <20241202131322.1847078-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131322.1847078-6-shiyongbang@huawei.com>

On Mon, Dec 02, 2024 at 09:13:22PM +0800, Yongbang Shi wrote:
> From: baihan li <libaihan@huawei.com>
> 
> To support DP interface displaying in hibmc driver. Add
> a encoder and connector for DP modual. The HPD function
> and get_edid function will be add in next series, so temporarily
> using 1024x768 as default in hibmc_dp_connector_get_modes()
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v5 -> v6:
>   - adding hpd and get_edid comments in the beginning of patch, suggested by Dmitry Baryshkov.
> v3 -> v4:
>   - static inline hibmc_dp_prepare(), suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 118 ++++++++++++++++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  12 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
>  4 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 8c488c98ac97..388e4fb4fcaf 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -28,6 +28,10 @@
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
>  
> +#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
> +#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8A00
> +#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7FFFF

Nit: lowercase hex

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

