Return-Path: <linux-kernel+bounces-218904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8D90C78E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D01F1C21C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9EB153BF8;
	Tue, 18 Jun 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2TdXiWr"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12613E409
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701400; cv=none; b=RcduOqmBjY1iQ/9m9aFmrYrSRWO57RnV2PtYBKXEBc1he0mD2zth+tyYEBgEINiBGYP+9ruXnG7pIFAoTYe1t9rwDlhIphpt7JluIYqt/TAbulIU7UcUjodgWKnMdzriJ8V962aNtdkzcPx7i2MIjBj/N6M2xnNQ4o1eABUNt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701400; c=relaxed/simple;
	bh=LQAnBnNceR1Odvb/waMeiElielfNWvoliCJGMlSUvsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gajld3EQ5Jx9VqOniH8nmRf7h2EuSk66L/hfzxcYduwh+Drkq+ll0+dXtiQot7JC3mV4N8babNWks+rdnKCKhDnAh6mwt3qja7HFkw4BaaCCjhPN6alRCsYy1Na0Rh9hPwTNla82gg4XMkx/Qs9el+j4mh8fEEKKJAU6iIQRB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2TdXiWr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so54927551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718701397; x=1719306197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ffhid/tBrPdxJ9K4GUEBHG+XV/ic/YFob6ya2KAGl4=;
        b=o2TdXiWrdbPGWzla7Mv/Rr1oTzsvKvCBEF/XGGCb6cgMe1VGyVQurwQZ1+NAI9j3rb
         Kt7Ed6zvPXWMae5HeBQvkTNrZboG2+Hg1YvZQGtJt9QomZdn16vZr0KxM+fEwZ0kqXJ+
         znqYEMvnc0mpFEEuH8KVGj6cdIfDX6Yz/WmSti0VCkNmlwDXl7XjevHfkotET9ieoVA6
         LWuoZ/ecp/pZ14KgxznXz4MgzoZJMWpbwxIdj0YwSfD0vsF7r4jW07RripYhklJWDqTm
         HxF6cYz/MzwWdbt3iflsx9l+PBcUSAjpZqXr71zHELODBDkLWl9v1dD5mxtqkT8xGRxd
         thKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701397; x=1719306197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ffhid/tBrPdxJ9K4GUEBHG+XV/ic/YFob6ya2KAGl4=;
        b=R87uD3LH8cqifE3tIwWNeu8jtrtJt2Q3bp0BGEBPE5jGYHxTH5q1dTAKWkcFS9aTsN
         eBHCgEc0Rf6wHgxXAmvg999wkGcjDiva9dg9aeRlMYUFlhAio8sKr9c03BIJ/VcV/kbP
         LCq7xXpH2/X4IRPEVqoMiU/tXsGt7P+dsuqvFQ78rYinijGPuQguPQsFngCxw/tq1gKg
         OSgqUv0/opb/kz7RX1WxTs4aNxdw5ysNrxMhhXnZWB9OSWnxBtmOvpPBmwlQ+yBsCl5r
         gsfotbqaXaFy+mnbr8odu7wHSIDtXhNsAn4EH94wKmLps2zXMEQJoj0ZsSHFDEGWCwmR
         57JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHwudfxBWPui23Cf0RyqqJOugdkyi/GOjZajITojzRwd1MkZnoCdXmsPwTaWIaoJiSnlgYRdc//MinjzmaIef6xiVLV6829dXcsRy6
X-Gm-Message-State: AOJu0YymUCymub2k7jaq4Fblcl/sZGeIaNOM7adOck1XGrrpMnQZ9+3j
	4OdTvcoHHhgBNQArw3wM0jURTYoETTnKn0YOpgZSNpeiXs4frHi5BlQl+gmLhig=
X-Google-Smtp-Source: AGHT+IEhCUvJr+a6y/HVPFNPVtdpiW5Ti409wW012CK56IkXpp4YYWVu+RHIYQY0ldZdVNtWnsp98g==
X-Received: by 2002:a2e:b0d4:0:b0:2eb:fdc3:c2ea with SMTP id 38308e7fff4ca-2ec0e5d1421mr70585891fa.30.1718701396947;
        Tue, 18 Jun 2024 02:03:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec079379casm15908771fa.124.2024.06.18.02.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:03:16 -0700 (PDT)
Date: Tue, 18 Jun 2024 12:03:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: dianders@chromium.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	mripard@kernel.org, linux-kernel@vger.kernel.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, spanda@codeaurora.org, a-bhatia1@ti.com, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Fix
 ti_sn_bridge_set_dsi_rate function
Message-ID: <k4t7zcvweap6e3fqrcixu7szqtvykn3nnqryyd3hdybhhufcgk@snimim34rrwh>
References: <20240618081418.250953-1-j-choudhary@ti.com>
 <20240618081418.250953-3-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618081418.250953-3-j-choudhary@ti.com>

On Tue, Jun 18, 2024 at 01:44:18PM GMT, Jayesh Choudhary wrote:
> During code inspection, it was found that due to integer calculations,
> the rounding off can cause errors in the final value propagated in the
> registers.
> Considering the example of 1080p (very common resolution), the mode->clock
> is 148500, dsi->lanes = 4, and bpp = 24, with the previous logic, the DSI
> clock frequency would come as 444 when we are expecting the value 445.5
> which would reflect in SN_DSIA_CLK_FREQ_REG.
> So move the division to be the last operation where rounding off will not
> impact the register value.

Should this division use DIV_ROUND_UP instead? DIV_ROUND_CLOSEST?

> 
> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Fixes should go before feature patches. Please change the order of you
patches for the next submission.

> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index d13b42d7c512..5bf12af6b657 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -111,8 +111,6 @@
>  #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
>  #define  AUX_IRQ_STATUS_NAT_I2C_FAIL		BIT(6)
>  
> -#define MIN_DSI_CLK_FREQ_MHZ	40
> -
>  /*
>   * NOTE: DSI clock frequency range: [40MHz,755MHz)
>   * DSI clock frequency range is in 5-MHz increments
> @@ -1219,19 +1217,21 @@ static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
>  {
>  	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>  	struct drm_display_mode *mode = &crtc_state->mode;
> -	unsigned int bit_rate_mhz, clk_freq_mhz;
> +	unsigned int bit_rate_khz;
>  
>  	/* Pixel clock check */
>  	if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
>  		return -EINVAL;
>  
> -	bit_rate_mhz = (mode->clock / 1000) *
> +	bit_rate_khz = mode->clock *
>  			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
> -	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
>  
> -	/* for each increment in dsi_clk_range, frequency increases by 5MHz */
> -	pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
> -		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
> +	/*
> +	 * For each increment in dsi_clk_range, frequency increases by 5MHz
> +	 * and the factor of 1000 comes from kHz to MHz conversion
> +	 */
> +	pdata->dsi_clk_range = (bit_rate_khz /
> +				(pdata->dsi->lanes * 2 * 1000 * 5)) & 0xFF;
>  
>  	/* SN_DSIA_CLK_FREQ_REG check */
>  	if (pdata->dsi_clk_range > MAX_DSI_CLK_RANGE ||
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

