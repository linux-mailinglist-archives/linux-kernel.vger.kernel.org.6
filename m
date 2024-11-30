Return-Path: <linux-kernel+bounces-426141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F229DEF6E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F026B16364D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E1C14831D;
	Sat, 30 Nov 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dkl30hIx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB711C6A3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732956944; cv=none; b=D9AnA68KmUfkN8OpERSuxEZpuk1ncRcdPWfzpSWQ1qPm/P25fd4kAfGNDqVN2wZC272o6JY8QyWlOkz9CeRC6If9FTIptKAROxC3eOX3xo7p7aw8mldsnlGwMnxy5bZYWTJEdSOxV1jsSUAfAnI23FfWxQBlE5/51NI1D5fo3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732956944; c=relaxed/simple;
	bh=TJhmFdfaVjwr17f3IT79WpIJd1EULklSXl6L077M+tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBl7+iRjnb8YdDD3EzNj8ByDzkx1rGka042E7FVn/Bsr0H26K01ZaETyyWwq0xrZ9oVxjTA2aIgDzck4NX8Plk1g76SsfQCTru1j5qPevFdSp+WxTet1ge7jjRkMOchZGPIOK5mLOz1g7Y8A8uqMb5XY3WZP9qv5ersgqvWmlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dkl30hIx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so2242220e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732956941; x=1733561741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWYIp2XJ9QFXc1y2xfe4G78/qq9zuMJu2hdWvSe+Nws=;
        b=Dkl30hIximcw4/rPSUXilojk2Rb73wR+7hc6v6lfebAKtBv6Crh8rGFzswcKc8t0yc
         fINCiCkEZ/BgcnVYmkaRcxADi8Fk4COt7+1CQj/PiwLjNVJz4hPXomUmpot1kddIohDs
         D5yknsQj+xVYNMcGR/obiPJ/D+Y7gjiYv6MNW5gPjhqBmpSSz7Okc+RloEsPTSugSVZX
         fkD0DZTaTUx6wyAWPOVsoNqPzrVeK6ZdL5SBuIx1ljzmDvicfqYblDy0hXwGZDO+pZRO
         +67OpRf0wsxYewu8WgoyTILmee77nKjvZ5cArTtjvqYgforJX4T9tDshLmro87Pd1euM
         ys3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732956941; x=1733561741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWYIp2XJ9QFXc1y2xfe4G78/qq9zuMJu2hdWvSe+Nws=;
        b=qIj1dWrZpbZMXvn/8K05DBCpfodstkv/8+9NfcyJnKyB7RF2cVOuu/o49Sw54kRFp6
         xUPTIyrLyhvG1RBjiDMMUWUlKVhKdRt+sC+qM5uhwO8MaSWSg4xfo7WEdbX3gWpf5SJb
         IeZ2wc9AI33x7qZgDw8MYFLtHhjr99tDC6vRZzkFAB3tLjXAE7wYfWbETmVXTey1keB6
         DuJs6krJ0OhiOpc9lR5UwVLAM2lnnOKu2gK7iG3mCJAXmU6WvZxqj1BHmlwFY9iAuGWB
         qXjzF9AB88/n1qNp0Abb6ppDWHGkKcws1y4TtCN0NXXQFfxudRhMpVxF/QSUl55UXhn8
         CYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Vl/xI6bXhC48ThRyolMG9HNWn3I5RtaGQVZN0SnUwRBjaZZYlXF3WYO91Wre92wpi/jg/riBrRyGq5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1Iwr7jkCZLiMkkeBophXtUiQI7pEHCY2g0cDYPqINHTKTCyD
	gGHOWdP37/C8QB87xMetlddRd1hEm3nlkB3c3s8F5ZS12OCczeX86Mg2AbfzHZo=
X-Gm-Gg: ASbGncv41vfVXA3iJxsd0Z7ddU3qoeB/L20rrRYUkddqIAcqytdpc+RRccR3gMEDZYa
	+J/+olJak4NXp6+R6Z9K/IWDHW1wRNddQHTf2WCep9nWjPe7gEm4w/PevOfBIWPP/prV9ktkoGc
	65Et8u5SustUc43UPUPXAabxAyOHn0s99E2pzk8l82Oi2r9HDcymOCX5SWSAbWfk27S4j1vD5eh
	g6ND9bXuaXauhacimFZJFQNi4LVmhSqatMpsas3TkDswxOB3pybUkAj5KI3soHdwg+G3qb9IVt5
	FuAWhpy2N723Q/CzOI+f7JnR8EslQA==
X-Google-Smtp-Source: AGHT+IFGpIIuU0NV+ptiObgzcvj/OfHO1P/2xGAhJue3uJys9uUaaKu+obE+URGKCHPGZpBab5Jpbg==
X-Received: by 2002:a05:6512:2398:b0:53d:e7b6:c6ec with SMTP id 2adb3069b0e04-53df010493emr5483484e87.41.1732956940996;
        Sat, 30 Nov 2024 00:55:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a09e6sm718764e87.264.2024.11.30.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:55:39 -0800 (PST)
Date: Sat, 30 Nov 2024 10:55:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, bliang@analogixsemi.com, 
	qwen@analogixsemi.com, treapking@google.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge:anx7625: Update HDCP status at
 atomic_disable()
Message-ID: <rsorgspggl325hx3atrvn3jqhbhy3sg5tvd4ckufrw7hsphrpv@6z63jtk5co4v>
References: <20241127030221.1586352-1-xji@analogixsemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127030221.1586352-1-xji@analogixsemi.com>

On Wed, Nov 27, 2024 at 11:02:20AM +0800, Xin Ji wrote:
> Update HDCP content_protection to DRM_MODE_CONTENT_PROTECTION_UNDESIRED
> in bridge .atomic_disable().

PLease describe why, not what.

> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index a2675b121fe4..a75f519ddcb8 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data *ctx)
>  				 TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
>  }
>  
> +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
> +{
> +	struct device *dev = ctx->dev;
> +
> +	if (!ctx->connector)
> +		return;
> +
> +	anx7625_hdcp_disable(ctx);
> +
> +	ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> +	drm_hdcp_update_content_protection(ctx->connector,
> +					   ctx->hdcp_cp);
> +
> +	dev_dbg(dev, "update CP to UNDESIRE\n");
> +}
> +
>  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>  {
>  	u8 bcap;
> @@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct anx7625_data *ctx,
>  			dev_err(dev, "current CP is not ENABLED\n");
>  			return -EINVAL;
>  		}
> -		anx7625_hdcp_disable(ctx);
> -		ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> -		drm_hdcp_update_content_protection(ctx->connector,
> -						   ctx->hdcp_cp);
> -		dev_dbg(dev, "update CP to UNDESIRE\n");
> +
> +		anx7625_hdcp_disable_and_update_cp(ctx);
>  	}
>  
>  	if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> @@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
>  
>  	dev_dbg(dev, "drm atomic disable\n");
>  
> +	anx7625_hdcp_disable_and_update_cp(ctx);
> +
>  	ctx->connector = NULL;
>  	anx7625_dp_stop(ctx);
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

