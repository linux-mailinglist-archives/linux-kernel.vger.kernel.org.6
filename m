Return-Path: <linux-kernel+bounces-518586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E629A3914B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B17188FCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65417A5BD;
	Tue, 18 Feb 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWhCJyru"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C1179BC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849222; cv=none; b=CA+vMV0F0/TGMyzbEb9ItY8YLsgpuuSv+pdhrXnBChc4y4UddWGGGjigY504Exkr+RzlJkfxRsw/VwawIqa9aSZXQa6i6NLsjU1obFm5ZWt3U5G1FdUnSnTahdEpG5SbvOJd/pX4eCCdBJwJsmu0FmO18FILywRKmTH+P7jX74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849222; c=relaxed/simple;
	bh=J0CCOCVepdvrlKPShysmzSA1RnzffskiQYKJmYDTVRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeIjeoesfyelOhrLSUO+BN3Xzv/XLrC6g5xKGIzmbIaDcJVLaTRXaT6aWTPktPg+yG+1dc8nPOZFWr3Q6rLeqbYhPgVRmtk6kcSRbKN46U6eXumrhhB6kA5ExZUdRVV4Z6UZ2LIoBxGYOtDdQ8xh9+gBrKCf43JHkq1jVLGME8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWhCJyru; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso2204534e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739849218; x=1740454018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSCxueoLHB/txHVHiuPd/+UkwH+GSWwoHHKB59+DFlU=;
        b=AWhCJyruu2SnB7tRsUSJLaRxT1ae86e0WCtgVItDexSa+c+EmBOOJkTAJV7BoZoqAD
         DIzPYAnN/DtvIB0ELrtXGSsmEgP/gnw22GQHN8qdxiMlwuCE6l2lcubS7g6zfffPmLM3
         hv6EWY0fqoVJ6FDHjYd50p56vZRphGPDREi5tD7x4iaDCOSDMCK/29LrkfIvfx3luNFk
         ALQBzgNhAsienWkoLXitgU6Do3XuDx5xVQr/Y8l9ij78Or2I9byw3WdsGmEEEZgKGveL
         V7GRpKFthCSoMqHr3COq87MJvF6WeIUm4MtdMirSdezX7aIJw29Ks2SXMFz3rcoV3r7A
         K37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739849218; x=1740454018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSCxueoLHB/txHVHiuPd/+UkwH+GSWwoHHKB59+DFlU=;
        b=HmzW13IPsTvkqdP57DeyOsKMEykUgzAWrHXRK9Py3SavuLgERsXOeybDnKcX7xe9R2
         F6gOqpfKINjJbKYiMf/AtDyeB1oOQtMacDNFvZoYbMZrqLI0eZEwQTAtrfJn8JH5glYo
         5qxx6u9vFzPqDBvFoJDYhZIMHWgXdmA4m7lfQ59PqO1B33Npq+a6FP+4N/ZK/88XUhTo
         z+GrsIfEWqMfDnMwDYgPLkmWNVSJB75YqpyypDw2W+I8uKZOk/w3Mkmt/GQaEwF+WMBz
         pLG1htjl0BnthDLE2Z3O9URancQ/1mOuDiaoR1zd0A3VqWtbdV4WW43TAm8NLUMhpzIO
         BQlA==
X-Forwarded-Encrypted: i=1; AJvYcCWINlM09lkAQymz7/50bZb6vxzcyCAiWqegcPcV/N3lfYDQ2RWzgsYvXrLuZ4mMTbVHgTLzZGdk3Xlvnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWfIAmC21GXVms3A4zN91TGQSO9l5bO80bzRVGSAjUydb6yHj
	YZ/enlnl8jQt3wCzuWoG8eqj2YdNWDY/+TxeT717qNLw2Au3XOGKcpKqVBrKzss=
X-Gm-Gg: ASbGncsk120pgpgkqeXv/iyTdKcP3ZpVKqGe1C1ZJxRu1yjUGr1aV2SeHnASmdeaWwm
	zdqCBILnCTjOerWjtpVkr4WJdow2FaRSyq+KbUkMjccVuB7SIgeVKVEGqyxaup/xpGcmI65wJvt
	7YK/A1lYBtTyCMLkkGMXcKCCldOdKMqhOvKtv7r/4EiAoZe2qtdpTaviZiFpzmda5NWAzvBE+5X
	CDx57IhTDqJoZfW4Dsvf5qVs08o7ggExWM9bNjPDWFlvmd+umvV7iO7c5R8e46Zih7yrneJDimP
	JzkEaOrbjAfiUufCk2pBg1O9P8NlvFmJFoX4RPxK2Adsw1X7yq02DiQtbysQORYyVFvoNPU=
X-Google-Smtp-Source: AGHT+IEuXEdpqn4is6TUxaE/+JLqNClWKujDuBTB2tz6Yn1fQEc4M1pLzGsmXbDamEwCBtvEsM8kFA==
X-Received: by 2002:a05:6512:2342:b0:545:f4b:ed58 with SMTP id 2adb3069b0e04-5452fe47777mr4001491e87.18.1739849218533;
        Mon, 17 Feb 2025 19:26:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54595e38064sm980129e87.126.2025.02.17.19.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:26:57 -0800 (PST)
Date: Tue, 18 Feb 2025 05:26:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, 
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Message-ID: <naw67daoyb2lfmq4jovlwanz5niaolptwnug3c3kkrtlfoh6dd@trkctqyzvtb5>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>
 <bdpw2g65uor77tijlhpabodog7haqvdcemnr3wzqkooerzuib5@hfdn5zsrbkgg>
 <7674314f-d95a-433a-81d2-ca78bc199359@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7674314f-d95a-433a-81d2-ca78bc199359@ideasonboard.com>

On Mon, Feb 17, 2025 at 10:27:56PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 17/02/2025 22:15, Dmitry Baryshkov wrote:
> > On Wed, Feb 12, 2025 at 04:56:10PM +0200, Tomi Valkeinen wrote:
> > > Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
> > > container.
> > 
> > Is there a more common name for this format? Otherwise googling for it
> > reveals only your series.
> 
> In the cover letter I mention the gstreamer names where available (this
> particular format is not in gstreamer). AMD has these in their zynqmp
> documentation (https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/Video-Packer-Format).
> 
> XVUY2101010 is YUV444_10BPC in AMD docs.
> 
> X403 is Y444_10LE32 in gstreamer, and YV24_10BPC in AMD docs.
> 
> I'm not sure you'll have much more luck googling with those names, though
> =).

I'm asking, because include/uapi/drm/drm_fourcc.h has a pretty explicit
waiver: GL, Vulkan or other open standards. Otherwise normal
requirements apply and it's required to have an open-source usespace
implementation, etc.

-- 
With best wishes
Dmitry

