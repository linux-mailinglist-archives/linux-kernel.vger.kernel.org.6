Return-Path: <linux-kernel+bounces-371990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87A9A42FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9201C26239
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95B201277;
	Fri, 18 Oct 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmkuvIsX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB2165EFC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266850; cv=none; b=eVC5e6Aj6khZFuVNchdS165+VtYNWDCGaEIDjfteGPWTdcEiFv0jH1Ob53al1RbG7Tm36agx/AI6GKXgTGpZ/ZlkW6gDVv3sm4AxouMwSbj3JM2IP0nWMD+Dfd9e29/F4GkTh2W/+7IiI5HrRKoPOnhvMBWcFi1qDUlk4S72U1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266850; c=relaxed/simple;
	bh=YM7MVXw079Qw532MI8vKRcx/+utkdL58y0+ezHazIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm0SrC3IXybtm3ot9wX6SgPpBDLy9WW+h7yyhp1zp1i3CdVZ8gvoyE2ziFF18M+VndWE+SQSB/77/+ojnBU06mCCTijhTw3ycav9CxaCxZsZR2HeEMRYjqSJpSGYM4Ur9wSwDr0rMT9L1vi3m1GS4yv2Suiu1i0jYMASgIyyGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmkuvIsX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f58c68c5so3717823e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729266846; x=1729871646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpwCbM4LBCW7939H36OgTv3MYW3D2YNl0kDGBqimkqU=;
        b=UmkuvIsXA+w6pPxb38nptN3shHWNn97C5AEaWaf2WtGHF2vNpQnRy9MCGovvafqHkA
         8a/pi7qT11KF4n+donKMWx2ImbL5dtOEdML3Zc1U/T80cacvQ1Cb4J2bU1uKsgA2fGGu
         20PZuWML9A+LPK4bsjAHjstcLiUSJ1SljMI2CjqC8DIDi4s+oqGm4V5dC7nH28XxUV20
         AUVPGb8a43W+am2ffzL0XAzptn/cU6dLAkwcW49XSnXB5SvGR23h/oR5zP8qrLEkZAEy
         7GgUJC4+2kV4FRy24+zpWD35dkAx9VeYasx32oSBp7wjWRXTq0g9ukYWGA+Wt7x/cRCz
         OzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266846; x=1729871646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwCbM4LBCW7939H36OgTv3MYW3D2YNl0kDGBqimkqU=;
        b=hpprIQ/bSzNdMR7W99gVUaMz6Z3kEKdflsftHLx6v7IAzuX98TU01ip3QVSCLQ1OXW
         K2h5KOXvFeytrh5TMTcvO2/HwZyZlocgjV8j8ZujsM7e+0iIUIcXE9dmhRtxY96MBRn/
         2kQT39NtaL1MPrkHdzK3Uo8uAjwW5F3kbc9r0NUYoNAENHZd/VlMxnK1Xcnzpnig04WE
         tPL0BTZ8o03I5jOMfgPZr+b0xD2udOQ6jnufzAoNmQsEFCHrqwprRtYVHGvOiWA9g1Bv
         pzJxeiK/zlTgum//MowWpYJgwDN6uxo2RgAqbrfJTUy5zayVJJcPICwNGk0SoPVCLmgX
         ppDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnhWsIwmSGgbl360NuYFmq55Swew/GXdgd6kfaALjBDCVEQsfXnAKiOAU/RUfwhIddRutBWLnGBOTvtA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4QfEG3igpxYqzwK6+MVCn1mlVLCdHY7kCs0jj6D2urb+zGa9
	zOnVJIN8HQU084W3ZBO3WjRFYNJg1MCxLPVt5rc7QSAbQ2Q0fFzUS5O8axaMF5Y=
X-Google-Smtp-Source: AGHT+IGhho3L1K3a1JYBXIXN9ildFXC/piLjygCrOlVDIveDLOAwyGQX/DIfb23VIc6IiDg6s0rRXw==
X-Received: by 2002:a05:6512:3d8f:b0:52c:deb9:904b with SMTP id 2adb3069b0e04-53a154ca09dmr2914041e87.38.1729266846118;
        Fri, 18 Oct 2024 08:54:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152041edsm247311e87.184.2024.10.18.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:54:04 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:54:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Algea Cao <algea.cao@rock-chips.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
Message-ID: <ff5eq2x5vhv3jxv6fjjd3bdohndyhurxqa3o4a5jbnis3543wb@jyfd3iikkzc2>
References: <20241018151016.3496613-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018151016.3496613-1-arnd@kernel.org>

On Fri, Oct 18, 2024 at 03:10:10PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Dividing a 64-bit integer prevents building this for 32-bit targets:
> 
> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
> 
> As this function is not performance criticial, just Use the div_u64() helper.
> 
> Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

