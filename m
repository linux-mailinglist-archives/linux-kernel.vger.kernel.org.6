Return-Path: <linux-kernel+bounces-359438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DC998B74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE46D1F27476
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13A1CBEBB;
	Thu, 10 Oct 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbsAhHue"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B020DD2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573978; cv=none; b=L77IhRKcpNGKTT4F1jPB2fYEA5m/5MXgOVUETVPGgP+Zn4ukgYN/Y2iuYZ/QW19k6gxTbnp5R1gaXIz2WW8dqPR1RIQ2rmh0YJ/LGBliWNz96FS3BoiS7qSKV7DNeLT9Qi8Kzy5ESUc6UhGii/40V/HrvMAQOx7XnvhaRIsxT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573978; c=relaxed/simple;
	bh=8iLhINW2fTj5WUJzg3GZsQ/0L7JLDk5w5lmagPvY1ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMQX9dV7dJc1RnOfPg+81b2EfydFX2yCY4FJKELiCq4W5cNBU2iOArCvORgiMVrKiYWyxG41m1XTlZRgzgY1TKFJeYC0d4lCksXJZroByxwPHJXgBGMliCM9XzPts9MeMgX5yeN6MGM78DNzX56Sg6mHppWVsFgjSAS3XjRnkJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbsAhHue; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53993564cb1so1309159e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728573975; x=1729178775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjv95FcATPuD0KP4sHFq/UApzMJM/NMZewKQ0oq5ikI=;
        b=GbsAhHueQgGH6/kksR4GwS8w31mnCXVC3PrcajYFxTymVhIVzXnF6bZGs3v1kjBw0H
         PUt4p1jbhR7RoWLLa2/CeFwoBWdB4dbHUVHaGLMDKgGHdm7IfyLFqjZAIOZzvfXLUj4p
         Kj9cHGA2e8+YiuKYEu0smYZFDB/vurbSNOYsb/GOhrf5DMVIIGt5BDrvVNcOrkc19gUZ
         eEYH+Cl4CxY+oFJ21CLHE23HfPusIghXyEiBQC+dzYqg8F/xJaj+o+xvj4XCR12Zysgx
         DIeChb607A7NWfqH6UFqGOSGmjAHOrpE+UAeoBP+12yf0H41MZq0D/kztr0RoGEqt0J1
         MpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573975; x=1729178775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjv95FcATPuD0KP4sHFq/UApzMJM/NMZewKQ0oq5ikI=;
        b=Z/0VHnnTxI/T5O0EY7uxKdyCcAEAfQOvBVx8U+/qyBsaKUiyZEFXr1HA+cbUfyhvCo
         yw87VrxCaICEY/g5ubPqDgSgvUdGfzgK+H3JIfle5yvV9Plf+fRoSEuX3LqP2EKsklU1
         vBzpN5UBk2+ZzVaCKrlorZlrKz088oNuSAIfwbBqoBdqYjYtgwUyjq5ybz4OuFyk7PIu
         wd18p5n9LqWfOIpWmkyAEQEDuQWRBtAIGAwKmFCAL8TX/lBSP+Cms+tE89prEbBqeRDx
         zzP8DrI4O4vMZB0M8nT5pge97cj+meUyArt+B2D6Z6MFRt9C29ow0V2ySNpJeuscAN/1
         PR8A==
X-Forwarded-Encrypted: i=1; AJvYcCXSPVLWuQcLcwBuw14CVt3O21sTmebk3cB4MgIQ8fV5Xp33WUvgVRGWzy+JYc/E3uvFF2DsgHIIX3aXvX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxienVJm15manY8b8bU4Gb7usssoOZO72TC9+f3T/nnSgJp2wB
	gBB+PJkCvv8ng30AeZTIEvWE7eDLT2bW4Xx7/Sh9v9nYetv0vQxyKpT8NHJHijA=
X-Google-Smtp-Source: AGHT+IFJsbsDmm6eiwBtSIMPdm44NFqMMEfCi5YwEg7a+EYMDtuYGtgssNmQ+Re43AO2ySLd93pCRQ==
X-Received: by 2002:a05:6512:3b83:b0:535:6992:f2c3 with SMTP id 2adb3069b0e04-539c495ec7cmr4698143e87.41.1728573975454;
        Thu, 10 Oct 2024 08:26:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539d0c2d25bsm69243e87.5.2024.10.10.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:26:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:26:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	ple@baylibre.com, neil.armstrong@linaro.org, andrzej.hajda@intel.com, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH] drm/bridge: ite-it66121: Drop hdmi_avi_infoframe_init()
 function call
Message-ID: <wsz5umbmcunw3bm5ppqxb4ypcryvgrvx5vndig5dl66ubt75pf@nwzkwnytswwz>
References: <20241010092643.1048116-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010092643.1048116-1-victor.liu@nxp.com>

On Thu, Oct 10, 2024 at 05:26:43PM GMT, Liu Ying wrote:
> drm_hdmi_avi_infoframe_from_display_mode() called from
> it66121_bridge_mode_set() already calls hdmi_avi_infoframe_init() to
> initialize an HDMI AVI infoframe.  So, drop the redundant
> hdmi_avi_infoframe_init() function call from it66121_bridge_mode_set().
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

