Return-Path: <linux-kernel+bounces-340032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039EB986DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349EB1C216A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8A18A6CC;
	Thu, 26 Sep 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+mP8DmK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864818638
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335969; cv=none; b=ozOGP+3D5lKb6ocUOQ7z4ypPtSyLWX50H5L98HJgD/S9F4St9eYZ9vzWBdxv5FZRt/bjYAG33KUTqmIQM3MhSqT4ULvX3JLwJnyae7RsTnQV31oU/39ZyzPcs665yZA+0Agr72sUVZ5spJkqbnAcPkMWDs3YIldfYOxFFJ4wrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335969; c=relaxed/simple;
	bh=A+ybC7nGAI2RjbvOZL9cTMg21JT+2vty7+Ly/J9gVTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfMEWYIS9c1bCrQ00tZMenM7eMRhfv2wvkGfkKY9uasrvLq8KzGjUU8+RjLcBrU2FUQOSLopIVeXJCTDzzGHuPSfXf6CmTIn6PpHW8HeHc2vSvIUlg2JuNMCFJYyFqrU25Rbw/I8oE598RFgFZRPAiuWaLCxQ1V5t9o1xCGLHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+mP8DmK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-537a2a2c74fso1649968e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727335965; x=1727940765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aonqfZhxhzRCigtKU2JDf5og9fZlc9KKVh/g2kla2I=;
        b=l+mP8DmKz++HQlkdmkNS8xzKGIacxbXDD1Uc6Ozvew9nROq3m7bxy0BeIsACD2f2VO
         HB6OQKOg3lWJ/GPvUhAfGROsdXO28E2uY2Y040BFgO2P1+L6Ykwo4XAXDLaewrRu5K/6
         615NZnKsRQHjGfCeF6edyPG7r26xwtzOTtyzGwoiOnp3TYodBssemnxz3rk/E/HZEFd7
         VjYJ55/5QjhxCY2rwzNQDRQ0KXBOwWUxxJpHkMagFrghfW9F67FAuH2dcycXc0OLtBsN
         cHHrKe4AyPDfjZIbCObcE01iW+oNHNDG7LzhCITiA+cqOU7xh81gmuQ4u20e4p3nhfgv
         GAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727335965; x=1727940765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aonqfZhxhzRCigtKU2JDf5og9fZlc9KKVh/g2kla2I=;
        b=OxvYTpa87cYMaxwpr/2JVQo2+nsSFzczYmxrGahbnEReApbOXNLRH2B3HRnyD2nSVo
         nUSZiRmpfiyQWBdRJnJ4exYbapWcNSTdqkEwhqd/P495DXcx3YJzoqAdox7fsV3wfTUR
         jjPntT1iQMuFVs5n2yhl+OZFqPAj8GN9xLU7FErmbpvykSjHEx2kGcD0iezpABbmeOu2
         AdwL6uY7ZWHo2Z3D3QDPB99jdWJdqkmjXMSGsfiDr6KM0rx3AOL4fKPOff+ntX8G6/5W
         87j2yeO+C2N0gT8pBYkQxB7sTjKTF0VyA+eO2xHNKJAhs/opmFhxXSHOVKQ4qR0HL6cY
         D3jg==
X-Forwarded-Encrypted: i=1; AJvYcCXOH+XbRvrcDrOxU+8I5IHzV8Ksr6WANdrR4UDnFzIMxJlXFBW7NmXTGQ4f3RMLhiAlubK7tFTZ1fpU2GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBN7+G2AUXSHS63dFtm3UYXmOQVd6zwfi3bNq1oHqTGKO9GW94
	/RtsxbkUV75h+aNtxSFkWSZv4BhMXrOHhNMneljD4B7YUer4QkaFpwJjDwlzAcg=
X-Google-Smtp-Source: AGHT+IFEJ3mGtjqHYi8+hQZO+ABBsYaf7BGxMD8HjL57H5h34gv/88G8VtZ+ToUkoIv8MyINwNfCgw==
X-Received: by 2002:a05:6512:304d:b0:52f:228:cf91 with SMTP id 2adb3069b0e04-53896bdeadamr669409e87.1.1727335965407;
        Thu, 26 Sep 2024 00:32:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e13edsm730901e87.10.2024.09.26.00.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:32:43 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:32:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stefan Agner <stefan@agner.ch>, 
	Alison Wang <alison.wang@nxp.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/6] drm: constify read-only regmap structs
Message-ID: <3i46wd7hqr5u3oxqlgyff4i27vxpg3spewkhby336hxmgbvmon@wijkq64pluzg>
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>

On Wed, Sep 25, 2024 at 05:42:39PM GMT, Javier Carrasco wrote:
> This series adds the const modifier to the remaining regmap_bus and
> regmap_config structs under drm/ that are effectively used as const
> (i.e., only read after their declaration), but kept ad writtable data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (6):
>       drm/bridge: dpc3433: Constify struct regmap_config
>       drm/fsl-dcu: Constify struct regmap_config
>       drm/mediatek: dp: Constify struct regmap_config
>       drm/meson: Constify struct regmap_config
>       drm/panel: ili9322: Constify struct regmap_bus
>       drm/sprd: Constify struct regmap_bus
> 

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

