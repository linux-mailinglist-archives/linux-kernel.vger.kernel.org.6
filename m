Return-Path: <linux-kernel+bounces-372542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEF9A4A12
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A809B23CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AF1E519;
	Fri, 18 Oct 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVNwM8c4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201C19046E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293889; cv=none; b=UhJ77CWt8mW0p7+rg585X+xDqXYRwAtht0wNralMifOXdib18GFUodobXFtMCAyci/Jf4vOzbhofBlURAzqPyCJCOC7K5s/Lte2dt0iP/MmzfB6hDstloPIIlsDfNrOBOQ3jnLvhAyup/y+rw0kp4I3YxKlPCPMJvwB9Ui3oawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293889; c=relaxed/simple;
	bh=t+8zcPGRR5YNCG/b6DB2+e7N8VnByVhpy+Dq5bMCoj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwZINKAryO5O1qWV4pFZB9UK7+ztxCTk9fazOjQNVdyFs5jXx9luO9kyXnZ1/PcqR1RDaaFTdLpS9I8Le7Eg8ccbZ5fMaKAYvKEqbfLoEJlCrdfcXWmwvXLgXuFvQDpeidUcVgfonS8QZM/ie8JBW7MEQM5UZSnrjvW3kVKzqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVNwM8c4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3422872e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729293886; x=1729898686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XL7RU0wcJwiLmyi3rltL96OHQM/RvogtscZRbUMIBE=;
        b=BVNwM8c4Lr7qY8FGd8alQ0LeMAPoV/TpzewbT79u7hpANmSrhNYuewuzHwgSQ93fJ1
         Hp6daA6drw0VytczPR1+kT6X9nN/JTb9yEJUw0gieg1VY33skaWbpoMAllNitABUQRbC
         DErjkvBYfMQUCI30pJLpKflgqlj/4zsv/phYnfK/2I08SNLNmXBgfBGNg2GzOi4PX/RX
         GoMAEntsW7T5cGpnKlDCNPr5ioyYu/hvZYUd9JUJoYgGlraFDYNsc/mjX0M2Dp4DQmGn
         31aDPmjWZhx+14wX/KRW/4i1ot7Sp0x+ZZTavQgQWrveqeYQvU3yXC6dZ8r8F+UUd4VO
         3aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729293886; x=1729898686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XL7RU0wcJwiLmyi3rltL96OHQM/RvogtscZRbUMIBE=;
        b=YndFevOTsutxqlaGTmHC0qY0+gAgHnCnnkuQJO7/2hVPZEGlt+lO1/wujGIH0WPNwQ
         6EvSPV78H5dGp7GsYX0UWqtYdHjw68abcoK01cPUnnmNj23kKPYHOmFTCW1wkCtMG7wI
         tttH/MFqDhqCMyqpvH4gg7AJw8+8lIK+ErkA2ndomOorGjr6Vl7sjh9AcX+6ZzY2UQl9
         +RceP5XdgDtGQZ5KCjO26vHFaINty720ZrkdDzVXjWNgcy3g6MD69kaEBitUnDxNCKiF
         btUsYN6BYMFlashKCF/ZHW9JJFQKWY9uPovRtxyw5kie76rIgFaQj8rmAraAHns6LOAR
         4sGg==
X-Forwarded-Encrypted: i=1; AJvYcCUmE9mKCVHeUc/nnrbvntiHM4iqfLnAI3LVX7i5jgccRYEnjawEOtDy/bF4X3Sa34p7h9d+i6Cq0rpy6+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkghbQZhpKfSQzK7lPZzbrIzn8nDfedl5Wc8FMcv2Vb5MGCYK
	M6mgQb0G7s1J1KAyhKynRoxdv6LIp0x6zEZoIhyiiFlG7IeGz97KDXdpfOSLpAY=
X-Google-Smtp-Source: AGHT+IGxQH8jPhf8nHBxYihXlnaykZShcOq9fR2nMiH4MBnj0+03pyQXpR9uKc/6SVuSIxYNBKMpGQ==
X-Received: by 2002:a05:6512:10c6:b0:539:9746:2d77 with SMTP id 2adb3069b0e04-53a154e049bmr2567706e87.61.1729293885758;
        Fri, 18 Oct 2024 16:24:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b90b5sm356121e87.88.2024.10.18.16.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 16:24:45 -0700 (PDT)
Date: Sat, 19 Oct 2024 02:24:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, Hari.PrasathGE@microchip.com, durai.manickamkr@microchip.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: Re: [PATCH] drm: atmel-hlcdc: fix atmel_xlcdc_plane_setup_scaler()
Message-ID: <qsfos3biidabnzdji5hkgmup3nmkeve43hwgqsaaod5npssjgt@277cxzczsv33>
References: <20241014094942.325211-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014094942.325211-1-manikandan.m@microchip.com>

On Mon, Oct 14, 2024 at 03:19:42PM +0530, Manikandan Muralidharan wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> On SoCs, like the SAM9X75, which embed the XLCDC ip, the registers that
> configure the unified scaling engine were not filled with proper values.
> 
> Indeed, for YCbCr formats, the VXSCFACT bitfield of the HEOCFG25
> register and the HXSCFACT bitfield of the HEOCFG27 register were
> incorrect.
> 
> For 4:2:0 formats, both vertical and horizontal factors for
> chroma chanels should be divided by 2 from the factors for the luma
> channel. Hence:
> 
> HEOCFG24.VXSYFACT = VFACTOR
> HEOCFG25.VSXCFACT = VFACTOR / 2
> HEOCFG26.HXSYFACT = HFACTOR
> HEOCFG27.HXSCFACT = HFACTOR / 2
> 
> However, for 4:2:2 formats, only the horizontal factor for chroma
> chanels should be divided by 2 from the factor for the luma channel;
> the vertical factor is the same for all the luma and chroma channels.
> Hence:
> 
> HEOCFG24.VXSYFACT = VFACTOR
> HEOCFG25.VXSCFACT = VFACTOR
> HEOCFG26.HXSYFACT = HFACTOR
> HEOCFG27.HXSCFACT = HFACTOR / 2
> 
> Fixes: d498771b0b83 ("drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops")
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> ---
>  .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

