Return-Path: <linux-kernel+bounces-337772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E03984EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA721F21C92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501F185082;
	Tue, 24 Sep 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xHKCM2pK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8482184530
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219202; cv=none; b=SeeRzOKIqe7T26vSj4Hx51yVHnnFVz2dxuS24SfZAd6g1SHGuSo44AJvkj+iFC0Cw0mfP0T+3W+S/gcLoBqcabal7lW3Nijot6QviR3QhAdSXIP0s9OeKrTlfO6ITmHiz/j4rLDpaMJRYg7Q29mqahOS8D4zlgtk9g+r8n8b0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219202; c=relaxed/simple;
	bh=yCWrkRvUvPKj8R8u9t2RlIAMJhzVku+24rs712str3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPPBz33JK0seSEZxP1JCpJPJEI9IMk7xnw8RCuVoD4ZH2OPclxqjgogjqZfsS56Cv6QRFCuQAF42G/7nEqKGrlfcoBl5MJGVWd5jtvsKrccyILrpSa0cNd2ZkdxeedonWIgoimKaBxIpDbtraywXg8cjX4PVlOvCLez9msCGKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xHKCM2pK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5356ab89665so7267980e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727219199; x=1727823999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot0UCcvaEAKPUSxY4CDMqGuFsrwzINAe5eEjab+YIEg=;
        b=xHKCM2pK7mxGFVs/8Y7gPQKzbonOrQ32yasbmcih+RHtbPAwoRE3S9Ctlnp2cx5nVg
         t7otzEmN/MSP1lHyW8KNvpcZh02qL9gezvdRQMTx6/vEeJI9aVPVyAO1mmjZZxy0wWnG
         NUJK9QSoCZPOMabrhqEIGwL7aEjAN9Bf3l20m5qoh6Dgrrv8qhTT/3m3zeVsS/dtjY26
         SzpO5GpXHkixc6kYuNsUdRO6+011B9t+D4sRJFs6hyVaOFckf7hhp5TpPyLPxvB2pYYc
         oCs2EeBWOBSQ+WpBlUAOOHK7pOKIpFR6pqc7pAowJbKM8gw7OoLMfVdb/YDevuVv5LT3
         8Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219199; x=1727823999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot0UCcvaEAKPUSxY4CDMqGuFsrwzINAe5eEjab+YIEg=;
        b=rKgSE04D6N9orhYFOc2yZc5ZeBQesaHPfJql2TW7pvMZ+GKpUe/eoDnWVUbUgkHTxD
         yDJvO5DczKXjtk2XwyeAfwrCaBVfwjT+hqgRBkU8jLjafV/bSvOWukQhnFcDkfxnyAQL
         zoPUFVW4YOL8ctpW3yZ8GYEsUpJo8gjkWaUxzlc2Nn6F+MVtQRKGfXgaTkUYk6O90Saf
         d5HIwS9qzx1wcOgPhdlSI3s4Kkhee4NeevacKaE5o0Ww4P4B6ELmQTMuRkjntETh3cdf
         v9vPRGcuoQUyXujWHYscFRRc+3q+ZeascJkDMZU0XMxNxOWutsxzwcWT1lYrnMj7cUZL
         ysFA==
X-Forwarded-Encrypted: i=1; AJvYcCV21KmIlnzwgJ7EkxotKfZonbApGLb5d943GTvyF0zhhQ+CxpaV9ItPjpZ5mswAZ9eR9Eyk0sIqhgvY8+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrXmSNjOiBttYWSQfFlVdIV3DmPKkNoQCMnjsfC9xUs22Ozz0
	8c4zE8GmasUm8ZTMhtI3DuG6a6B78CeRXNEQ/pdteo9zx50SZNG+Zne7jZIc8s0=
X-Google-Smtp-Source: AGHT+IGdSmMW42umh+q5VuXZORxUx2TV5lqbdEctn2Rn3L/TYI6A/pArZFkotNwLnY3N3aHG3FKpiw==
X-Received: by 2002:ac2:568c:0:b0:536:9ef0:d854 with SMTP id 2adb3069b0e04-53877530b7emr326255e87.32.1727219198658;
        Tue, 24 Sep 2024 16:06:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864e26dsm354725e87.295.2024.09.24.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:06:38 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:06:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 01/22] drm: add clone mode check for CRTC
Message-ID: <y2apz5arp5d7jv2fqujh2qyl2gqovmpvkpvpvpxewitfcreke2@ihung7uzmcwu>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-1-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-1-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:17PM GMT, Jessica Zhang wrote:
> Add helper to check if the given CRTC state is in clone mode
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  include/drm/drm_crtc.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 8b48a1974da3..ecb93e2c4afc 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -1323,5 +1323,12 @@ static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
>  
>  int drm_crtc_create_scaling_filter_property(struct drm_crtc *crtc,
>  					    unsigned int supported_filters);

Missing kerneldoc

> +static inline bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state)
> +{
> +	if (!crtc_state)
> +		return false;
> +
> +	return hweight32(crtc_state->encoder_mask) > 1;
> +}
>  
>  #endif /* __DRM_CRTC_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

