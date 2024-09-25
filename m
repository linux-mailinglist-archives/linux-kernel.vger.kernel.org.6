Return-Path: <linux-kernel+bounces-338264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4D985597
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A864B1F24CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C815AAB8;
	Wed, 25 Sep 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFguPwAH"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C61552E0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253414; cv=none; b=pmxJkroQVlRhOEUEpni3n5wZffrYWgBX6mZu+5v7O0bt5l7Iftf34Ytq/gnenlcAkmcXptm3qQIhCcKlSLW/ThNO23cT+Y/Q+mkg7NK4iUm0MPyT0m0y8yp9sAHYGvEMLGTbgGQBDfdknWP+biee1vxVMTKSDz44p+YbtVxQRNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253414; c=relaxed/simple;
	bh=M0aotw4FUaDTsuER1Qe9yFHs32+HvH0H5XJwh6aFk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc7Dz4g6/Aw/NCG1p9GpvG2+ciEJhb2+8L7LQYcjjFKX3/bMwWfBHPG3/P9PGabKYCdny/ZFjhCTBJNzSAzRkmgZbOulsAHOu+yKojqSa+zWzW6rAqgz06OgzYb48bmvkWqpQxjIlC67erYl9ijkDO4Bn9yn58zBJhqoSGQbxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFguPwAH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so6666582e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727253410; x=1727858210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LFFK30ORGOB8opISAVi2/AjiV23wsDk5moHBmYPz9c=;
        b=iFguPwAHXGEHuf6HzKMA4mfTAV2JlGKc9Y4RfzigMR+YG7PedtPQbqifv8476ASNnq
         06gI2JHJ6WL0IABubYTpXF0PcFjUMJkWbYr7DWNrpgBPgeE8ZsMZ9eD5FhqpTPBwff9/
         85E3mpINcv5FSaAup6BXFZatP5QWRsH3AkXSYl58VFEXivNZDYWY6rXD1mO2xYYakVEb
         wSw8Hd5P4Apb+pnvu/NihaQgfCWy4WZLezg7+kERQgb6oDd9e7NmJFhXie85h5a3Ch1G
         iJCqdBquLprq5mt9DvPh7IlkMD0ay9QO0N+P0sMgN+BB4DH8PqLhSOxo+F4cVjgFmnqz
         SV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253410; x=1727858210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LFFK30ORGOB8opISAVi2/AjiV23wsDk5moHBmYPz9c=;
        b=fjPXbQq7kt0IfAAB4G6CqHhB0p9eqOpw7Q6siwLw/sZyrtb4QzfcC0YReFipd7qe2C
         JAggfcS4QD+VtdNoHTFIFhCog7FyELk/x2ep7qoOLhFfhbA/RGSfsfkJROwMaVIfl3zE
         DN2crgx+r6M6ekjyDJ7dXjPtJcPV42IgClheUDu/STMASD2J1jBALNJvuQKfMG1RQJqD
         WAQLMHekFdX6Ahtwd3cyII+3ya+PHz1JhfK3nuW+MFi3DDt9yJTnd7BQy6UAoRjjNria
         FkFTbQB6bhg9KGbWqNZotSCGMv8TLTE+kExpxF0n2MG/onl8bkhKIpf5xOovxVybfb58
         oYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6MN7j275R9SJ9w3unfZiFGDRf9jRKNszhbGP3TognwDwwmRLEYNaPA+zwh5YRFNntTi4DWDFNFgbl7GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkIuFVPE+CAvmYI5qyitX4kG8NgjA7xVzWw/0gHD8LQIzjunY
	r2clEhZiVKHAJ15aIlk8LocNkDMpj8KZ/t48+Y+z4uNwbtVQGwBeUQDjb1OBMRM=
X-Google-Smtp-Source: AGHT+IFzrCK0VcF5jVceh0qZQhYC3c4kXM0RNJ7sHMGDqRBw1Dr0li2TBcCq7sjXdcDnOzH2DHlX+w==
X-Received: by 2002:a05:6512:110e:b0:52c:e3ad:3fbf with SMTP id 2adb3069b0e04-5387755cb9cmr1098457e87.42.1727253410148;
        Wed, 25 Sep 2024 01:36:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0ba7sm457699e87.52.2024.09.25.01.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:36:48 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:36:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liankun Yang <liankun.yang@mediatek.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	jitao.shi@mediatek.com, mac.shen@mediatek.com, peng.liu@mediatek.com, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/1] drm/mediatek: dp: Add sdp path reset
Message-ID: <ybnnqysm2ptvclaal3kw26ttqkgbicn45cwxkkchl72vuzwtt2@el7c34zqxmjl>
References: <20240925064854.23065-1-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925064854.23065-1-liankun.yang@mediatek.com>

On Wed, Sep 25, 2024 at 02:48:22PM GMT, Liankun Yang wrote:
> When using type-c to type-c to connect to the monitor,
> the sound plays normally. If you unplug the type-c and
> connect the type-c to hdmi dongle to the monitor, there will be noise.
> 
> By capturing the audio data, it is found that
> the data position is messy, and there is no error in the data.
> 
> Through experiments, it can be restored by resetting the SDP path
> when unplugging it.
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> Changes in V3:
> - No change.

If there are no changes, why did you increase the revision?

> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240923132521.22785-1-liankun.yang@mediatek.com/

The link points to some other patch. Please consider using b4 tool, it
will manage changelogs and links for you.

> 
> Changes in V2:
> - Fix build error.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240923133610.23728-1-liankun.yang@mediatek.com/
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c     | 15 +++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_dp_reg.h |  1 +
>  2 files changed, 16 insertions(+)
> 

-- 
With best wishes
Dmitry

