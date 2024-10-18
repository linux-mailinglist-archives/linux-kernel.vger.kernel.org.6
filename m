Return-Path: <linux-kernel+bounces-372005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ED09A432E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F52286619
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7B200BA7;
	Fri, 18 Oct 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2y9nBIa"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0E133987
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267546; cv=none; b=oNdbjbfQlE9W2EL1mOLJte3YrmWaPEifECgvMEVM4ziK3jnijQEUDxWOlwbjxNFlSG8kaEy7WjCPdMdlSfGlKGDJ2mWOA6VmBn+3xPlGAE0yRUtg5BLJsKNLxpnbgZ9Je/tU+z4Ry4KugLduvBbPRLYlWWCo0uH8Nee6vGcOv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267546; c=relaxed/simple;
	bh=6zIz7rLqvlLD78tMosqFxFhvxskFnkIyYamCQ3zyCFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq0DrwQ2T3IlOAjB8jKyFs8dWDj3TeqdZxNxlqBEwoEtMdWWribne/v5Imgsu7zwCkVXcDQz9GoBGmyU9q2/9hJv7yCj7nBuRmwcT7dKxJwWLkbOimvjKMpd3PetX41Io0OsIIpyXEzCG75cYZLn0dBPeoJb5vcrYpdSF5/aaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2y9nBIa; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb443746b8so27141501fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729267543; x=1729872343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lHZpTCnaSttFJL3uIXwXWK6iRmjck9Nu4C1mKRZ028=;
        b=H2y9nBIaYobKk45t8wMYJlQKH8/e+yxoOkRZHMFB9C2En6LMwp1WzHGkkfF5RhpDVQ
         d46Tie4/ANS8rC8sevdixK3eeqRaxUXYlkRYeydmUL5d1gXqEF/D5LBSLjiqP8BwSS/v
         /aJwpOkbOcE7IcWtI1IQwaFChA8KejM5JajkrDN+8lZxvEaIRwJJBlpOULQ6j8D5ed2e
         XlUMNsQ95JnifZlJGEdE+mEwKoLYOe427fCL/Z3tSvt0JZw/hnh0uIqsHEeF0gPOn2UC
         nrmb+ZldzXeKpN1SyI7FZaVPPGfQ76Q0zDHkZwUwLIr09+p+pOOn8Tt2pMLjKSRrweVN
         De4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267543; x=1729872343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lHZpTCnaSttFJL3uIXwXWK6iRmjck9Nu4C1mKRZ028=;
        b=fsPsZbe2O/eOA9ae0QYZHzKkHtBzvDvEOaPlgKeXcsTszvszWEZ66do9zonB8n5jlb
         iGg6ory3Mbqw2E46DmGMCjkUEaj8zhCTRwUszw8EZrR+DVWJ1cInjJrrT7uQJVBUprSB
         DzYugXttDt7NeY5238BwEHgdgEv4Te/QYoj52tD3cNSuu00XChUJDGba/USPtFR76eFo
         Www8F5BnKZY7+JFya/PtyJA8V7eyoDKe9jbgWY1xwqsod+hA9DknpIQY/9OpkO+4UaZV
         T4ICBC4hUd526hrCNde2nYn7kti6U7TbH2NMRH+K75S+8J0V4YAY1iKrOztaGbPj+NNz
         2xQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbWHSoI2WAlcaPE+E5Axt3W6Pls+NsO+PnhJLqJk5BtYTfP+/RqQENKo2NvogNLB+KHM8QZxDyY6F5e9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5nLfNzfKi9mqlhbHkrDl8dxKcfoKdG3r0m2Z2sb6GNqVB7d4
	5E67QyPSilPJ8Gfhk3kOO32Qe2ERJjmf1DikW/9N7qgB1bqgkkpL46A/qZ+ffks+lYrW27ibqnr
	4k6w=
X-Google-Smtp-Source: AGHT+IEpeWFLJ8yL29qE6iphuWnFhSa96/H/Y2vX/YZ6kUiZe2MzqHfEFttDD3Eg9ojiGCjOGWPbXw==
X-Received: by 2002:a2e:712:0:b0:2fb:5504:7966 with SMTP id 38308e7fff4ca-2fb831e92aemr16524871fa.30.1729267542646;
        Fri, 18 Oct 2024 09:05:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809a69f3sm2445361fa.26.2024.10.18.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:05:41 -0700 (PDT)
Date: Fri, 18 Oct 2024 19:05:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/imx: parallel-display: add legacy bridge Kconfig
 dependency
Message-ID: <ccpkyf46bbfe4z4lo76kokixocgfofc4gltifnlesnvfuj4ndc@q66ke2mf5uqu>
References: <20241015073004.4066457-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015073004.4066457-1-arnd@kernel.org>

On Tue, Oct 15, 2024 at 07:29:57AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver now uses the legacy bridge helper code but can be configured
> to get built without it:
> 
> ERROR: modpost: "devm_imx_drm_legacy_bridge" [drivers/gpu/drm/imx/ipuv3/parallel-display.ko] undefined!
> 
> Add the required dependency, same as in the ldb driver.
> 
> Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/imx/ipuv3/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

