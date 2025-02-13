Return-Path: <linux-kernel+bounces-513467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE9A34A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A7917629A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B19A245030;
	Thu, 13 Feb 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuNnAQLO"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F7245026
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464713; cv=none; b=ENw0EEFkKoEZ8cSdYoRKJKkKTlrgOhCfv9Br14xLXhRwuKC8ORAeq3i6mpBD21wtUBNDGBBF/P5frR6QXDta32+q9xroIaexlWno/obv+wJEadRMKYcNx6aXVnQ8cTKYKQen6ljznmgC08Fj+8aVwiW5g/67yb3yNEVUKsjWwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464713; c=relaxed/simple;
	bh=6SRVdh/WeKElvEC0ZGe03GTYSdBjheO7X4O/C4CZwZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRTe/bRyBnB6CigmwfOIN3WyCv2VkA7dpZT4ixQHrjMTrS8UnvdJslwyVl5nQiEgFwEXJsiDzI2M28sSoDIBfm+t9TyxKfi9V1KK6JC8OQ3pPEeR9B2fa8VCHSFOLE/zmucYiaH2EcTlzeX3EBp/qTTM6R9tj8nA6607LZhq21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuNnAQLO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso11399251fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464710; x=1740069510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zyljHRvLU6CfUIp4JEgLGjq0cbAwicms/vHIYSGJBE=;
        b=yuNnAQLOMp3nTNghD9lItdSyOWahh0ET/YvKlBvQxvx6r26CLFLvOPrkohM1fTWGLf
         o9sxbPzu74funLX5D61avVdVpIH6CdV/SuQaaTrhhCRQCxMlXdPe7HtDs3PV0xApr2e9
         r5ZB4ZoTzzY87pooygfMY6RS6hRwCWXR/FCLAaPTZMnRdqt+eJv8HDxHyXSRTNPx3z1u
         xFtnapPgVWGAXF6Ksy2A4IQi1vxa+j65ahrGE9S5c5K5dSj6EfciyeWoB8h8/EChaFm3
         8y3gleTQfsOL49by/sirNpzc0TQ+hIx2SsKSV/qLCdE3yiaCzdWnHLDDsUMKCacRYMSW
         VdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464710; x=1740069510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zyljHRvLU6CfUIp4JEgLGjq0cbAwicms/vHIYSGJBE=;
        b=sN8Nn/li8z2kleEBg8N1TcrFLXc8PYVvU/MAoivgMqmaIbWhxvOZ6lA94PmV03WMEd
         w+6jruBrpjZnLPkLeXBQVcthURB7ccIa5cUS3j1GomVOAdw9PpdXhiCzpLB0RWjtALro
         SHpei6MaigCcN/atMfHH66OEcou1PgGXKI7GB3jfiAdYEwZvaa+dbnhp7ei/DZpTfQR/
         GFxaz5OtH0/F8RI9LzYcVixjdVQmeQxMrpKPauE1Glx6cxWHnj17arSt4GcjKqfdlOhK
         mL/DIHaEGXly7xG0ecbSrlhJYKFkuePRNlK309aqEOH9vIvbT8BfYPFkJH4ujx1zLfQw
         dXRA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Z7W1HbkVvlxd1mJ1ar53qahQ/g1n8rqFB/9gexWCxoD/X8r8LvLXhMnnkufgJ1DfOJDQOXnGFBF7Hw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO4509oN399e5Rz3Ea14+njj016BfLCJu+LMtHty1WobEIjvJ
	qOAQbR1+YMvm+VR4s+zVRxgQKvRUf6bNRJyEJSKzorKfAjr8erBiRQC7BbYtOC4=
X-Gm-Gg: ASbGncs1ryLqdJ9XVWUAHmvH1wfWkfQAHBl6WKxGRKtIJi5OaM5HSiPRcfHZRiGWrLE
	ocGfmedI3LLHelLaVgC90exVBpERgcY3/OGOgHkl+Ysc4hDEUkDJ0gjXukROretmXztxktvT09X
	8mJ+f2NSIINJ/JwxfV6P9IPMlaguuQ6Jscrl8KnmH9wrY3aKDkdqywFuS08P3QBXIhKgpNCRA3m
	UKJYZLDsgDwm86/QVFRtvX8cPgZbyUAn9758FLRBWYFs17ucAUyT9ytv1yof1koQKzKwzmZstF8
	UNtGfabkcdbYj9evre5yE5AYuwg+sroMge0/cL1aYcyY0RsC28Mg0BKZ+JRzXMAfvmjdkX4=
X-Google-Smtp-Source: AGHT+IH3xnLzQL6gEDeHl+s2Ja74DCPJbtqw3lrnmuWXPCOb9TRK/IEStkbvlyJyjGyoNdKUiGIk2A==
X-Received: by 2002:a2e:bc85:0:b0:308:f84b:6b39 with SMTP id 38308e7fff4ca-30903651966mr36959311fa.14.1739464710047;
        Thu, 13 Feb 2025 08:38:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30910276f11sm2438831fa.74.2025.02.13.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:38:28 -0800 (PST)
Date: Thu, 13 Feb 2025 18:38:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 33/37] drm/bridge: cdns-csi: Switch to atomic helpers
Message-ID: <5nf3oizcucrdbaju5nmwxzizcvefvzf7vx2b3rqcra2ltaduvk@c3bvqbm5f42q>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-33-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-33-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:52PM +0100, Maxime Ripard wrote:
> The Cadence DSI driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
> 
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the CRTC pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 29 ++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

