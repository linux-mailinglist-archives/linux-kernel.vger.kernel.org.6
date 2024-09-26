Return-Path: <linux-kernel+bounces-340083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3A986E70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1B31C224F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7A13D638;
	Thu, 26 Sep 2024 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhTXaH/D"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723244C91
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337684; cv=none; b=tdvi0vODhIVB1TRC3yUFKBJBZqkn4sB41SiILMLj3RgdsevIR2jINv8AziJs7zRxr4IuYapTHQ7OrGdyo72nOHWWqw287FXSiw52oKYAsh7KG+nupYEh+jO1YGzQMKZqgf1mC/fEp7sVaRMlQdLfoBqkzyRWOvHB/KbKDiX2Hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337684; c=relaxed/simple;
	bh=AR6atAPvVEqP/mZPC144HSL/sY2AEBRd61UQzKSFzNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDQWzVgwvPpO9BWWE+rr7tkgyn/o9ZELosOcd0tesTlw2KapOtL/F8a+lMtyzLiYgM41aYp8gsFS4Ww/Zn/E+bv6brd4hTBPjIb5PPCF/qGXVsT3sueNIAH5l7BAr1kVRCyWSUQuDGblQ5HkRqC8benTd8sZDVua1XTSheN2TvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhTXaH/D; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so6559781fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727337680; x=1727942480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnYkXlO4xqxmTC9/oaS9Fy67Dlsqb/FqP+5KeOimFjE=;
        b=NhTXaH/Dcx6hVoLo5GNIp0RupcBSjMHsz3Qus1S/UuA0y541Nn3QP/OLlUpy+2Kp9f
         i5jYge8Wn8dMTMzI0zUrZVCRrjPHahijDDD04aqepBcaGkUjifp4LfXaoQQ9ULrYvb76
         HHDYCzVcnHge1zpWfnLBXEIHmQusAjMFgQ2VYyuxX6jtVPfzZOaui05S4wIB/ayuzGYA
         QWQ6QBiTEQciZgH4VztmAADlFictFFf6R/rhCMq/b+e/MuO4ra/+1YCThOL0/UhYsWHo
         ajv+vT7VU+VmDOTmGH9gvQt7v//6ltyTcyrGeWHN6068p60cdF5k9SUyMPmBVEQP9RSo
         t+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337680; x=1727942480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnYkXlO4xqxmTC9/oaS9Fy67Dlsqb/FqP+5KeOimFjE=;
        b=ns/SukOAGXe8P6RsQc/g7wAPgvtejngAKvelWKwJG78KSkWwnR1FM53plhKRVclq2l
         2m99SVNYyfBB6/tnN/DO1S7gbGdS6IqZWRGna831kv5Fh8SM03IfedomT710kUmeeyqG
         gsPOtquHKD6tdXrj9GgXCDyxp2jiamyLq/3mt0lC6i+AE+9YvHu7mL/vAsclnwOzi/It
         GewzBYL/ok9rJ/a5GzKQMSzPaX1nCxMGBkpx78cjczR24lTc+FXqoHHD/QQf1RQgMil/
         Ve7OlPne7xc16fLZlzi1j+uWQGYAE91taphjTfunGC103N5oEC94FXrJsjqqtX0B91q4
         aKqw==
X-Forwarded-Encrypted: i=1; AJvYcCXMWmPuOxfON+P2RelAyqyQtOW5mcLuzN16M8Ei94k0i33e+hC6STF7MpXfhoXARuC2ZwW97WX8dPeBFXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LtzKMu7fOhrW8mffQDljfdRG66CmwEFg+IkRALZxufkD6zMG
	HfgaBgzvXnqJ7jaolpxko//UvFPq6SxYMw9rkhxqMx33Q6af6p58HM1eYWJkVSg=
X-Google-Smtp-Source: AGHT+IFtMIQI9HYA+rwxH65S1pikrqxhoUIciOnR3NOXr2mN5NDNBRifM1sAHFCpXhAFfxKki4zyhw==
X-Received: by 2002:a05:651c:50b:b0:2f3:ed84:9e66 with SMTP id 38308e7fff4ca-2f916007957mr32637691fa.13.1727337680478;
        Thu, 26 Sep 2024 01:01:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b6f7sm7591461fa.113.2024.09.26.01.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:01:19 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:01:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Allen Chen <allen.chen@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] drm/bridge: it6505: fix aux command write to
 aux operaction register
Message-ID: <fcy6i4cfmtpsgnvuqfjm7pwlkyuno65rij5w32snmjbudma6wp@ht2jqtj2rsxq>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-5-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926074755.22176-5-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:47:54PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The aux control register command is 4 bits LSB only, adding a MACRO to get
> correct operaction command.

Nit: AUX, add (not adding), macro.

What happens if the driver doesn't limit the field? Let me guess, the
KSV reading command is 0x10 (it should have been a part of the commit
message, BTW), so it overrides some other bits? In such a case this
either should be a part of the previous commit, or, at least, come
before it.

> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 0583abdca75f..d1f5220e04a6 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -329,6 +329,8 @@ enum aux_cmd_type {
>  	CMD_AUX_GET_KSV_LIST = 0x10,
>  };
>  
> +#define GET_AUX_CONTROL_CODE(cmd) ((cmd) & 0x0F)
> +
>  enum aux_cmd_reply {
>  	REPLY_ACK,
>  	REPLY_NACK,
> @@ -1000,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  				  size);
>  
>  	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, GET_AUX_CONTROL_CODE(cmd));
>  
>  	ret = it6505_aux_wait(it6505);
>  	if (ret < 0)
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

