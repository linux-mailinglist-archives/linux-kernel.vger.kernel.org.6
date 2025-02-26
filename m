Return-Path: <linux-kernel+bounces-533127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBFA455F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2091888ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC8269889;
	Wed, 26 Feb 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQpx7sY7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8E1C84BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552403; cv=none; b=R6H1wH6xnWXPREU+RbdFXe7QZDgNxpnctASOGHH9bq7aXBOhwY74x2bvWTiB8eEGhv8VWDJ0UmNC5SjBIvSbqj8YZfle1h1jAId885Data5E7ZwWyGKvtEIVNHvMsx+PWTqeMWP+d0lHS67fJG0G6ZVfokDjH1fObwF9dWfR1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552403; c=relaxed/simple;
	bh=AlJ8i0/1yjlaeluMJRDTs3G/YjpA+hVdot9s1d2NPHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKOuMiGbKAhQI6qJpN7/L1OdXv9EaLuOsRKbZkxXwuPr9PrFC7QMDrHUhTD3YTW+LO5b+sChYJnTxEnkKM9K1N5pbkziAiBxQw9NtQonkNBhGSxXKuTSjIy7/2LSRujZpZKaYp2rfV984UmQTd8980nA+XpWJ4vQUnfj9x9RIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQpx7sY7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso66713801fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740552399; x=1741157199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vfdaNHAgLU4X4v38fyX8xInLCuGf2K2NlB/6RcTL/Y=;
        b=xQpx7sY7qe7PfjHFyuTmvBHtI5c5MWbXfdBEJ0t886q7LW2/j18e76g/bGx8Cjwsfj
         pRwf6TclXMfDEE8+5EsOA3jiBKE5BzjXloMsUX4A60vlDdaI7jkjZQAVB6CeYwBGf72E
         vPMaZboDOo61dj0pOhKaHKPfBdcmFU6spA7ILtbA6sObKy8R5sB42IavibRP5n5agxYz
         kgQT2+2HYVabrsg/8aMcX5Sd1DgikoK3Fam/JnOESYR7Be2lX2+3YhLERbQ4o1dFdC/G
         GDJKHNC0TC2wb31UBJdjmhiXV5bd/av4L/qZ4mBdAXwPrkBkLdqYMqh8zUbhqJOknAo+
         2fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552399; x=1741157199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vfdaNHAgLU4X4v38fyX8xInLCuGf2K2NlB/6RcTL/Y=;
        b=rjNN2DnlZ2OT2W9k+hmsIquH1gQydaroYD2t9XW+aoA5ERy3FEg9wwHcHEfW+dsttX
         IPUZ/opuIqMAp9UyqFfZcxhF3CRyDNfzF+t+BCqL9eu3sH+oZ/oDcTZBp3Khcyb+lMFz
         TgrfCFz2KEWWeRcG9zU6YejPk3TJK8Fh/qKzVqcpcGsl4p+16Yb0qhA0xO6TvOzsMTwd
         owaqutLsHwS1+MoHHlvlvoB99pgyqTawCatV+Y8xr/P4hlUWbycdknzegu9lFFSKYYm3
         kFg+KMDZjEEogrMdttzg640Ctz9XINEtHU9gvU/46bA5r6qYHMLiT+jkYTVYVqttu4/K
         1Peg==
X-Forwarded-Encrypted: i=1; AJvYcCXYVZmUg/UwuQyDVnbrUIRVNzdDzpewAkPE9IyNMCUbnBi2diEGQ0LGDPND2RccqFK/L761atR2CGI/uIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhv84ShOEHVc/Yxp91XkS20abxtyTHCn4QmfCpYr1yQrWZi7Nw
	YLQ+ZpzwTSI9xe9Na+YwWSlRtnlvBXOUBitnkLJSxD+eCNjtCSzwNuzMS/imk84=
X-Gm-Gg: ASbGnctP0oPzCpel2CW0yvjSM4RdyA4GxHd+DhDQTJISlHmpqLC09jn3jVZu8ckU4o/
	MmU2czuGh0VCICmNPMtkSC8AoLeIfnK3BuKqWvkhwUGpr3m/a5AHNY6QlpSiTGaYsf1VhO3qWou
	+oovia8ibmdAIVbrj9Iy6BvDWgopuaENYBXftyt7NTvDe0/Ta95qfb9Voq0Wsqg0vpHZkkPJ8/b
	l7O1xHgrsQripLcGC++fPTnjWJtryq15tW3pOVQNEbU4oDqT8k4RuL4qCxvF+vwBPA7Hqo4S97m
	yCqxh+KFezAbxM7dKM9PCcWVOdzCkmucBBCpOYAg4oHshHj3QrZNFN832A8Dyr4V3yb60XTuLJr
	rIQIuUg==
X-Google-Smtp-Source: AGHT+IFlGFPHSuOs6aKtjduRbIhUyJeMLrZ5qkVf65OGMr4mgS4XwrgCjHMmEUZahLCcnZP5OZSzgg==
X-Received: by 2002:a05:6512:158c:b0:545:b9a:b4b8 with SMTP id 2adb3069b0e04-548510ed8cfmr4069970e87.51.1740552399254;
        Tue, 25 Feb 2025 22:46:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f5da7sm4244041fa.62.2025.02.25.22.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 22:46:37 -0800 (PST)
Date: Wed, 26 Feb 2025 08:46:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] drm/bridge: ti-sn65dsi83: Switch to
 drm_bridge_reset_crtc
Message-ID: <rgybsoofzkhhkfpl4ivdibv5z7eutq3wegzmliebmctklqzqif@f345drzfbhr5>
References: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
 <20250225-bridge-connector-v4-9-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-bridge-connector-v4-9-7ecb07b09cad@kernel.org>

On Tue, Feb 25, 2025 at 05:43:57PM +0100, Maxime Ripard wrote:
> Now that we have a helper for bridge drivers to call to reset the output
> pipeline, let's use it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

