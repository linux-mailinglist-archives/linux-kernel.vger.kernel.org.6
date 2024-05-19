Return-Path: <linux-kernel+bounces-183292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD48C9744
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E18E281186
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9397319A;
	Sun, 19 May 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZ7OdG47"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736971745
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157606; cv=none; b=gxQt0RfMMCc9ZKnR4TM6eGznyOhkQAofAO4Rwk7J2jezs7DkgF/CXDWqt6JC1uQPP3EP3ScuCNLv1b7m6qoFFqzOvqR0qi2EtwU1+dof18G/5lwOJg2p4L84F4c7brgmL2+lIIKwzfgXymSFp/jmnkPpA66lX0pot4rcwEWMyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157606; c=relaxed/simple;
	bh=bhsmvXZL+pT7EmyzyVZPA1xgTKqR02mDPGlmGXciAs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj87bHfnAywEsejfqMsAMJDJFYM/tCuGwvMtxCDdGCzs0q8dpQHAT52LtVvbjeQsSabaF0npHrPX/IKiN3AMiYOLiQABNBjuzIac8SSD8uLpsoNxXIiSt05OaZoFge91VstjlYpC2xrBMOgvmT8N5K4ijVDjbHBZn5sMh5gNaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZ7OdG47; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso37922001fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157603; x=1716762403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JObSYzQBPhN8GXmYgBbRvZYZ/SCSfA1Ecyc4ynw/10k=;
        b=nZ7OdG47AmzNx8CMCzNdKmkW2V44WzcDZJd0p9RdRqOqb3CzhnRRpnplxzMeGtXinx
         ib+bklGLm0smH/lKd9mW9Q/Z7zNW1bQ3Pvk7U7h8YNCWWgDvFUZZi1agHnzpwCp2zAow
         KFbxSBwb9Lp4HWvacXT8JTQJOEinGeg4Do03RF4Stkw623t8RbcBDeNBI7orYvc4QF4+
         Coyh8tYvIjJrXEYgOAKUY3L/HYhmFbVNpQFk/iyh5Z8y87tf40YGNf7TnCKMEqDWw9dG
         X5EYgRLCleFxy9ZbL2Oht744HEWlQjmdrUoqms6tUIzrQK89NeBz2zZLnS+5ZMiSQflB
         x5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157603; x=1716762403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JObSYzQBPhN8GXmYgBbRvZYZ/SCSfA1Ecyc4ynw/10k=;
        b=kiCU+PWWi6ejsIxTc5z/bl9yuHdNH1rojpHur5tb6koICBXHAMT2MZAGAX7GNDgAdp
         fJsrx/3q9Pk+MCtgdxH5ijmXQhTpeffGd+8TwQtUYWy+h1p3RjXTNYehB6N8h4Q7rB72
         zD10trEcRrvuRewNSbLDCwDHGrrwPbIhpWOLc2i7jU8k2bWD/i3KWvfy+bwqq2EJzuDY
         fiCa1ODfZqNbhOE+/yfzLHfThVG15nqCnmFWC/3pXRFULwIor2fcW7qP7CcWMbsRbxgk
         eGKmM5V31FVaJWX5t4bjnrAVhTts4Pw05sbLGSEIppaXnud2OQPGQTdfcGUs8rzUtgrg
         qL/A==
X-Forwarded-Encrypted: i=1; AJvYcCXMRYNo2+qVemoy9d0U9Y1b7+yBixpunoW7SoQubliWWp/ZaOm/vk1kgGBX95uz/xJy6Dc4WDE1hAZ6aQOoONGgfx62SOQOoiUy4niv
X-Gm-Message-State: AOJu0YzNH7lK5i2GUX3odiBp9JCKKOGSTRck/BOrr79KsDxlfj19y6dW
	U9z2pnLYd8qOlUIHQuvUL3BMnQN+rjd+1FiggC6hD3cftsNMMBC7Tc5pyjvxPiM=
X-Google-Smtp-Source: AGHT+IFWahWBY2ir7LucN1X/aBwVlMImRfoE+eP/cd4MqvN0pjGjs98YYiaYuQpQSioRNFZxFIQh1A==
X-Received: by 2002:a05:6512:b88:b0:523:8c7a:5f6 with SMTP id 2adb3069b0e04-5238c7a06e3mr11745122e87.51.1716157602727;
        Sun, 19 May 2024 15:26:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad640sm4025069e87.61.2024.05.19.15.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:26:42 -0700 (PDT)
Date: Mon, 20 May 2024 01:26:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Shuijing Li <shuijing.li@mediatek.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Xinlei Lee <xinlei.lee@mediatek.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/panel: boe-tv101wum-nl6: Check for errors on the
 NOP in prepare()
Message-ID: <5n7uz7wacuz7cwlv5drr77l27kq7nsw34horh6o5iecrhs2tws@5gvxuusty4rx>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.3.Ibffbaa5b4999ac0e55f43bf353144433b099d727@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.3.Ibffbaa5b4999ac0e55f43bf353144433b099d727@changeid>

On Fri, May 17, 2024 at 02:36:38PM -0700, Douglas Anderson wrote:
> The mipi_dsi_dcs_nop() function returns an error but we weren't
> checking it in boe_panel_prepare(). Add a check. This is highly
> unlikely to matter in practice. If the NOP failed then likely later
> MIPI commands would fail too.
> 
> Found by code inspection.
> 
> Fixes: 812562b8d881 ("drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

