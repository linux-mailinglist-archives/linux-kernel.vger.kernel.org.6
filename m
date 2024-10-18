Return-Path: <linux-kernel+bounces-372011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB39A433D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE7286700
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C48202640;
	Fri, 18 Oct 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nS+SJOqX"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC752022F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267639; cv=none; b=YusJuptP/OH/GAbil91ENK0oIA9HcB4WD+enfS4aa4NBQGd41pMcsRV9I1IlTg6dNtdMS7/q9dYYpI3mAs6k2dlvdTtOWNkGoNlqVIwJFU49QW0rnbdzZ1+2VA8e0M5CIPx0okDYlKHQ5sbZV5E4m9rktbofNGQZ2P0maQuZlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267639; c=relaxed/simple;
	bh=ge0C8lBlP6RPzAcBnsx8To4U+Xjlc+9GKnJ2vqk8aVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7/YK3tpanfBsL7A1z1YxYRL2RCxCWRB8CVhpgAt0x2zuYfOe1ttAj/WvxYMCE+UAqivK+9noFip9n158iaOatbzhAwPB/N+NnBpiYjYLPmiD+zKbl4eqTPrFX/u1dLXJyf428moAXBNUuFU9fziAf7ix6h/WdFnsLIkEE8cTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nS+SJOqX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e63c8678so3027801e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729267635; x=1729872435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjcBRZvnJO0Q/9XpD2JDbA/HXvXf/zaDJqw9x/2j+Bk=;
        b=nS+SJOqXbizvgs9mSzcfkbHNNFe+/8N3R9qHE+nqlYNI5YcNMGjGt96i6U15KeZNGs
         eMwf81FSCk4F6j/9HeipCo9c2PdjNeJMIH6dZFmosxhmAgC9ex6dghSug1iFWjq5KvKH
         cxFEyL8dzyNcdL9MtLIUw2FGNIajRTZ8527CSe6QLkjWJvpL/Uyb1Kwk+melF1aMoNrW
         fskA3qIM6d0W2Ch5uAnLAkQOKuebESmkECArEp5CIDR0BqVH+KcXqW4opBF92zTU1WYC
         Bl7Hrk9sLRzc0ZXOCXDFLebH1QTYzbswbjV+VU1CCYyzMj0TlkLhJpCFVilidcH62rlZ
         loJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267635; x=1729872435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjcBRZvnJO0Q/9XpD2JDbA/HXvXf/zaDJqw9x/2j+Bk=;
        b=vSxuFUXCIU+6VAHJhQWXOuQHKb0mFJNIXCQMKRBmmsk76k84gdOv1DQz/SfRH6+eqW
         5vnklCiDMOmc/rxicbDovEHfS+EXeeNRS0CzSdpTlqDh36Zrcz8t4X1uI2Ud+XDVY/JO
         4uvDUuoe6+WtvnMIjE4lYxM0bib8XK3mWjjWrQEUhMN0l51Q3h3/Rt1TKVmC9ol0uzcv
         G0pLXHetynQ5KOgMft9BWkLzcf6I0XuNj0gfw5u+Pu7ND1bVvJAt45ZjFybbt07BIGN6
         If2wYY5XbbUQoepAp6Vyw2Orzyp4+l1ScFc2lMmoGg7fzteNczFH+bPpsC0U0oX6+n0U
         OvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFOiYzfVJZdxh1yWbDgNyuITndeBFDUE5m4vlGkOdWoD7fT15gW9UQy03lVC7iNvQC8qetjBfIyujawUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfh9nbvKCqTsPFzu11VdEsNMf0WsTwIe1QlfXWr7CvVfaVVLt6
	ISueKjP7dB6AjllxHlCYaRi7lSldp7shEuS0KEykxsnOQp2GnEn/siKadDuZZHw=
X-Google-Smtp-Source: AGHT+IHwvQU8GblbN9I/D3jtz2hj1cj70UCdrbo0R6U79C6HYhqn13HNnFfZCrdaYv2b9j2Lm7EP+Q==
X-Received: by 2002:a05:6512:b14:b0:52e:9b2f:c313 with SMTP id 2adb3069b0e04-53a15495a0cmr2076684e87.22.1729267635230;
        Fri, 18 Oct 2024 09:07:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a1513dac2sm253377e87.0.2024.10.18.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:07:13 -0700 (PDT)
Date: Fri, 18 Oct 2024 19:07:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jani Nikula <jani.nikula@intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Imre Deak <imre.deak@intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge-connector: select DRM_DISPLAY_HELPER from
 DRM_BRIDGE_CONNECTOR
Message-ID: <pzeye6mwl2bdzwfepoazfpn4qjhuiajomx2eygbwzkghmocgme@wnmyk2xvum4l>
References: <20241018150850.3418359-1-arnd@kernel.org>
 <3yqpyobkkvnan4fo5h3vx5jw5ke4zqoavo354rkw7h3frleurn@oag6vpmedaz6>
 <19944f9b-e7d7-45da-bf1c-0c3eeda27c12@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19944f9b-e7d7-45da-bf1c-0c3eeda27c12@app.fastmail.com>

On Fri, Oct 18, 2024 at 04:01:17PM +0000, Arnd Bergmann wrote:
> On Fri, Oct 18, 2024, at 15:42, Dmitry Baryshkov wrote:
> > On Fri, Oct 18, 2024 at 03:08:45PM +0000, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The imx display drivers use the new bridge connector helpers but don't
> >> explicitly select CONFIG_DRM_DISPLAY_HELPER, leading to a link failure
> >> in rare configurations:
> >> 
> >> ld.lld-20: error: undefined symbol: drm_bridge_connector_init
> >> >>> referenced by imx-ldb.c
> >> >>>               drivers/gpu/drm/imx/ipuv3/imx-ldb.o:(imx_ldb_bind) in archive vmlinux.a
> >> >>> referenced by parallel-display.c
> >> >>>               drivers/gpu/drm/imx/ipuv3/parallel-display.o:(imx_pd_bind) in archive vmlinux.a
> >> 
> >> Move DRM_BRIDGE_CONNECTOR out of the DRM_DISPLAY_HELPER block and
> >> instead select that symbol indirectly.
> >> 
> >> Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I think a correct fix is to select DRM_DISPLAY_HELPER instead.
> 
> I think I just didn't express that clearly enough, selecting
> DRM_DISPLAY_HELPER is what I did and what I tried to explain:
> 
> >>  config DRM_BRIDGE_CONNECTOR
> >>  	bool
> >>  	select DRM_DISPLAY_HDMI_STATE_HELPER
> >> +	select DRM_DISPLAY_HELPER
> >>  	help
> >>  	  DRM connector implementation terminating DRM bridge chains.
> 
> I had to move the 'if' block just to avoid a circular
> dependency.
> 
> Or did you mean the imx driver is the one that should
> 'select DRM_DISPLAY_HELPER'? That would also work, but
> adds a bit more complexity.

Yes, I proposed this solution. I think this is what other drivers do.


-- 
With best wishes
Dmitry

