Return-Path: <linux-kernel+bounces-336937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E879842CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC0B28888C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4891158DD4;
	Tue, 24 Sep 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBG4oiO+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731F1487DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171969; cv=none; b=CzV5ZhCBMX2kIHofMsrHSzhyMV8Sq5CHAFr1y3XLhLf9swH9XyJvhTS78Y672XZefRbse73h95yc8GY9to0WtRVS/CwzfurDZ4RQJnTLdbUO34F2O4y9Ljum5TR6jvgaZ0YLjIQwaEqgtx4RojSXPUZ2inYCcOL7JgHO7oeI3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171969; c=relaxed/simple;
	bh=PA/C6FmzUtv/YQcdxurT27+fTDeXiW1YI2RPuTYD7o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+AeGN8eCsKzQID4Kk0GvwZJ4Z7LjgEpgnPajbW9Qm0E03m9XU58K6q5z2TbGXD+t9spMR2cX+5N8+qT+cOxnzBiFtsAv+27Vd4UoQxwNHNgCeYEEzLcRDLrXHcaEr5ZPy1VmQ8wYxtpPJti1B2sWiBGfL7li81jFZXD/w9FYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vBG4oiO+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f74e468baeso57205981fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727171965; x=1727776765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cue4W9TL93NwHbM6aNpd7v3/ibP9k+0QyUerPzS+jBk=;
        b=vBG4oiO+svXRlXoVMOnl2iEGGSapajL6t2Mnq87glfy8qdev7RyLWy5Vbz+8G7JJxy
         M05CSQPE/8+eoC5InJuGLBbZoTvm9xkZe7BbFtL0wSQ+omq6iEw8PzD/JYPM0HFAgrix
         m/vpw8M6hOy66lW5tlIJfMsBFeAxsXAcvmkSgCP9qcMky9hAaZcv+wwdb7zfOr0aNJsw
         NziEq69C3esW/LtbO6e5kXhWOCxuK+HVkhoEDE+me5UAWwqzslmthyndRhBqiVp1G36F
         k7yR3bVywdMvfBtPTnc+FDfubj3Jn2vI37fPY2eHhIPrRkqD3Bmyw0pGOobxd06SaxIA
         ctUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171965; x=1727776765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cue4W9TL93NwHbM6aNpd7v3/ibP9k+0QyUerPzS+jBk=;
        b=R5iKAVHpC3c/3xKuL+E5OsCgN7iSsDmKjJbFJ+B02dPHvbg0vblwivoQf+z5Irkvxy
         DHpufht5QobJk/S3u0ueSia/dVJ86rBg94k6yKS7BJRyi4mYTvGz+4ejULTcVisPdjhy
         wkSM+QgTaUJm22zhNDTBn40grUPAdnG2L+ohq+LeXVcIGGFXUtcqpX7NImaxJpjW74gB
         dZCqbpQaEdmVH6nbu5Gn/+ysU2fmg67BW5+ZHC5DTNXeC+/7FDGW5VvL6AumD94igAn6
         JIZrzGu2pc8FO08mSAsUkThEwCeHzRDt9pz099utVEwF6RyYmlexORM56QZqThIk9cNO
         iXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCnaOn8PCgpi2f81FMr/5Be87BJzvU8dGBYH77fxpL9hWHU9FOy4BLUsMo8b+9PsVHWAm8amjH6AvjHYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBulLNrWcKrzglkXJkYGu3wbnIlyFMIMFuevdgOe9R5y29RrAM
	Rd7QCVK6QMqFJsce6LhqKjeNHQH+C5abVawHSxinYENUE/cPQBSTWvoplf5nlK4=
X-Google-Smtp-Source: AGHT+IGxXBr3ISMNgRfS1/EiFBTfON23QMpcYn/pHSiLqk0vW/L3gbH5rzPUZk7NUx4bYMaTwS6m/g==
X-Received: by 2002:a05:651c:2206:b0:2f7:5914:c22e with SMTP id 38308e7fff4ca-2f7cb2cfe6bmr79444711fa.6.1727171965324;
        Tue, 24 Sep 2024 02:59:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b533sm1714211fa.106.2024.09.24.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:59:23 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:59:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.Wu@ite.com.tw
Cc: treapking@chromium.org, Kenneth.Hung@ite.com.tw, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/bridge: it6505: Add MCCS support
Message-ID: <lxh4anqlrrfqs5iljf5iughavosvqt6dzcff6flcoruimxgeq2@d5ig536voy5q>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-4-Hermes.Wu@ite.com.tw>
 <x4eixnu3kta6u2xqf6mn7ons2pupr7oe5fzjur2pfhgppmozoq@lgmk7zwqhcqm>
 <217c3d82f89040e7b29465ea71080cd2@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217c3d82f89040e7b29465ea71080cd2@ite.com.tw>

On Tue, Sep 24, 2024 at 03:52:34AM GMT, Hermes.Wu@ite.com.tw wrote:
> >On Mon, Sep 23, 2024 at 05:48:29PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >> 
> >> Changes in v3:
> >>  -remove non used definition for aux i2x cmd reply
> >> 
> >> Add Aux-I2C functionality to support MCCS.
> >> 
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 174 
> >> +++++++++++++++++++++++++++-
> >>  1 file changed, 172 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c 
> >> b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index 156440c6517e..5aedc5570739 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -125,6 +125,9 @@
> >>  #define REG_AUX_ADR_16_19 0x26
> >>  #define REG_AUX_OUT_DATA0 0x27
> >>  
> >> +#define REG_AUX_I2C_ADR 0x25
> >> +#define REG_AUX_I2C_OP 0x26
> >> +
> >
> >Are these registers CMD-specific? Because I see that you already have defines for 0x25 and 0x26.
> >
> 
> The AUX packet i2c into aux transfer frames,
> and I think it's easier to understand how it6505_aux_i2c_operation() packet i2c request into aux frame.

I'm really sorry, but I don't think I can parse this or how this answers
my question. If for the user I2C a part of the register space gets
repurposed, please comment that before the defines (and maybe separate
such defines so that it's obvious to anybody reading the driver).

> 
> >>  #define REG_AUX_CMD_REQ 0x2B
> >>  #define AUX_BUSY BIT(5)
> >>  
> >> @@ -266,6 +269,19 @@
> >>  #define REG_SSC_CTRL1 0x189
> >>  #define REG_SSC_CTRL2 0x18A
> >>  
> >> +#define REG_AUX_USER_CTRL 0x190
> >> +#define EN_USER_AUX BIT(0)
> >> +#define USER_AUX_DONE BIT(1)
> >> +#define AUX_EVENT BIT(4)
> >> +
> >> +#define REG_AUX_USER_DATA_REC 0x191
> >> +#define M_AUX_IN_REC   0xF0
> >> +#define M_AUX_OUT_REC  0x0F
> >> +
> >> +#define REG_AUX_USER_TXB 0x190
> >
> >And two defines for 0x190 too.
> >
> >> +#define REG_AUX_USER_REPLY 0x19A
> >> +#define REG_AUX_USER_RXB(n) (n + 0x19B)
> >> +
> >>  #define RBR DP_LINK_BW_1_62
> >>  #define HBR DP_LINK_BW_2_7
> >>  #define HBR2 DP_LINK_BW_5_4

-- 
With best wishes
Dmitry

