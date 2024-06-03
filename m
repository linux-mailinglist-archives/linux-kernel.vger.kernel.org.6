Return-Path: <linux-kernel+bounces-199691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC99B8D8AEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DC21F26202
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AD13B58A;
	Mon,  3 Jun 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ma5Hv8Bz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817A210E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446744; cv=none; b=ZHUHft6bsHMbyCIW4hs+KM+cjZbUNXnHMT4qK8lo6+RdpvIMMnhNMz1Rv6/jY4f5lSdofQTn/Z59F8DdxM7VOVRe5HRi4ars/jMovKU8m+PIPuRBsm6BQTLTDGhJUuCmyiwffjli978njnXAsychu6AUKnqNdS0sSe5S7KY2iKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446744; c=relaxed/simple;
	bh=oMKAFRympZAtagj0tt77PNU05yPHXFb/Me7SXAReQHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJgY0xkuQZLGRH7KMu52yqaq/SWGSjhn3kE32XK4rIDK2TalYa8hlJqB5AemR2eAxF8+68sgGhvoiNhnnh5Zfbm6+8Z4FYbyjMCOZzg6DaTWsU6IUPsxyIqclWvgJqD53odK2ov8Q67quu2RLhVEdVRsm9z/cYWNqWqRuhALOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ma5Hv8Bz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa794eb9fso32434191fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717446740; x=1718051540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j3xWHdXJHtkqPEG1gY7KE65O7IPK9mAb/+ZmZUO/aW4=;
        b=ma5Hv8BzSScX6FEOmRxFx9lmYa2+UIfTcoytfAyRs0YMBqiVBtrA29Mgwf3m9UYlHJ
         jAV3mdZapIlBVPBkkq1mv62iOQP5vkhoPZKPec/vFmxqZjG14nGadDi3eavlRAA7Ed0p
         NTUetwLw38kYNauuwH4wP1a3SXSJt70AxlMrJ2k9oxncYXpGLqzsVZSuTZEKnOqq/k6Z
         U7ZUWvXeIP2ipN9GEI9IyonZ9gXwl6civEp9TQgoWCdzDoXvEFQJkbJYT3mNtgHRQYkF
         V2rJfFUnjjbwjsFfO81jwn2IpBZlauvU/+mtzVhOWuZZghq3lRDYFKvr5jIiyxKa1Clz
         NKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717446740; x=1718051540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3xWHdXJHtkqPEG1gY7KE65O7IPK9mAb/+ZmZUO/aW4=;
        b=M5ORd5wFrD4o/IcmVCZh+Ng5IIgNjIL22Gvf9HTh/oNZ5znbbwA1aN15kZb7XdUQav
         wZkb+DcqEj9YoVud0ZbNT5txc6RIwyqCOYY6WUd8XTeMlKPlopT0+qNkM0y2LotZ0GBa
         qKm2sdDEdGHzsuMFb2ePPe+o+0wtSgqHg5PZAxjJr8aWHCksN7AYzN500SDpTw5CMo4k
         MyA+jnFoc5PA/ViQ1n9YhSekfrlKwLJalxeuhHmOvXBJ4dVtzyvXA3z8hk4IQoG4RlrR
         bkUkUABJwcs+tKnJ3Xxw+72UtG5U2tLkHQjFWTSp1X/5ta/+OiTcGPrHDUwS2+qLIucB
         FqoA==
X-Forwarded-Encrypted: i=1; AJvYcCWbz/4XLhakMpj+mWZRePEfEPb/XST++IEUpQM1pMXNeaEMii2vaYW70P5GfhFiyLaGyVZzlmPQzjyGPwpA3kD5oNzz/BNAOb5ztri+
X-Gm-Message-State: AOJu0YzgYZyU9TbzNEh2zjAtzJAb0LhEek3HeC+Y59wAZf/DHz+qWih1
	necAeeF1rERMiYqvrxbYs5HTRa0yqnauiwoE8ddrYUh+V9+cBo8betS7j87xpVY=
X-Google-Smtp-Source: AGHT+IEN0ZKSc9dLsSicKTPHKeh3bX+MpeLnoaQErTFdnlruhE40PAEAx9f4Y40Xgy6T7Y3uFsAJJA==
X-Received: by 2002:ac2:464d:0:b0:52b:7bac:476d with SMTP id 2adb3069b0e04-52b896cd271mr6412478e87.56.1717446740419;
        Mon, 03 Jun 2024 13:32:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b950c07f3sm702431e87.55.2024.06.03.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 13:32:20 -0700 (PDT)
Date: Mon, 3 Jun 2024 23:32:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: noralf@tronnes.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
	Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v3 3/5] drm/mipi-dbi: Make bits per word configurable for
 pixel transfers
Message-ID: <ymr4xlth524itfdpsj4mjgjbtc7ivqdskawj62zddxyzgne6et@xdz6twnwc2pm>
References: <20240603-panel-mipi-dbi-rgb666-v3-0-59ed53ca73da@tronnes.org>
 <20240603-panel-mipi-dbi-rgb666-v3-3-59ed53ca73da@tronnes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603-panel-mipi-dbi-rgb666-v3-3-59ed53ca73da@tronnes.org>

On Mon, Jun 03, 2024 at 01:21:34PM +0200, Noralf Trønnes via B4 Relay wrote:
> From: Noralf Trønnes <noralf@tronnes.org>
> 
> This prepares for supporting other pixel formats than RGB565.

Yes, the patch is pretty simple, however could you please expand the
commit message by describing write_memory_bpw introduction.

> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  drivers/gpu/drm/drm_mipi_dbi.c | 14 ++++++++++----
>  include/drm/drm_mipi_dbi.h     |  5 +++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index fa8aba6dc81c..77f8a828d6e0 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -1079,7 +1079,7 @@ static int mipi_dbi_typec1_command_read(struct mipi_dbi *dbi, u8 *cmd,
>  static int mipi_dbi_typec1_command(struct mipi_dbi *dbi, u8 *cmd,
>  				   u8 *parameters, size_t num)
>  {
> -	unsigned int bpw = (*cmd == MIPI_DCS_WRITE_MEMORY_START) ? 16 : 8;
> +	unsigned int bpw = 8;
>  	int ret;
>  
>  	if (mipi_dbi_command_is_read(dbi, *cmd))
> @@ -1091,6 +1091,9 @@ static int mipi_dbi_typec1_command(struct mipi_dbi *dbi, u8 *cmd,
>  	if (ret || !num)
>  		return ret;
>  
> +	if (*cmd == MIPI_DCS_WRITE_MEMORY_START)
> +		bpw = dbi->write_memory_bpw;
> +
>  	return mipi_dbi_spi1_transfer(dbi, 1, parameters, num, bpw);
>  }
>  
> @@ -1184,8 +1187,8 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *dbi, u8 *cmd,
>  	if (ret || !num)
>  		return ret;
>  
> -	if (*cmd == MIPI_DCS_WRITE_MEMORY_START && !dbi->swap_bytes)
> -		bpw = 16;
> +	if (*cmd == MIPI_DCS_WRITE_MEMORY_START)
> +		bpw = dbi->write_memory_bpw;
>  
>  	spi_bus_lock(spi->controller);
>  	gpiod_set_value_cansleep(dbi->dc, 1);
> @@ -1256,12 +1259,15 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
>  
>  	dbi->spi = spi;
>  	dbi->read_commands = mipi_dbi_dcs_read_commands;
> +	dbi->write_memory_bpw = 16;
>  
>  	if (dc) {
>  		dbi->command = mipi_dbi_typec3_command;
>  		dbi->dc = dc;
> -		if (!spi_is_bpw_supported(spi, 16))
> +		if (!spi_is_bpw_supported(spi, 16)) {
> +			dbi->write_memory_bpw = 8;
>  			dbi->swap_bytes = true;
> +		}
>  	} else {
>  		dbi->command = mipi_dbi_typec1_command;
>  		dbi->tx_buf9_len = SZ_16K;
> diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
> index e8e0f8d39f3a..b36596efdcc3 100644
> --- a/include/drm/drm_mipi_dbi.h
> +++ b/include/drm/drm_mipi_dbi.h
> @@ -56,6 +56,11 @@ struct mipi_dbi {
>  	 */
>  	struct spi_device *spi;
>  
> +	/**
> +	 * @write_memory_bpw: Bits per word used on a MIPI_DCS_WRITE_MEMORY_START transfer
> +	 */
> +	unsigned int write_memory_bpw;
> +
>  	/**
>  	 * @dc: Optional D/C gpio.
>  	 */
> 
> -- 
> 2.45.1
> 
> 

-- 
With best wishes
Dmitry

