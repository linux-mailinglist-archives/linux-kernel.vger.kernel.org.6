Return-Path: <linux-kernel+bounces-335255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3797E325
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D61C1C20CE3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B255886;
	Sun, 22 Sep 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIGwx6sK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69D39FCF
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036064; cv=none; b=PNzqegjYHRA3Kl36WI/sCq4x4882iYSzn5v8wR+43L7FWB919YUDFGbpjJqo9EIE90G3UppeljgmhFzdqqhfT6I2f10p/WWdVlYf03ReXq/CxE692OObPpHyw5czFnoGbSdgUb9dK6dwnza1Rhtj/OieWC6VF1glK6ro1hrtXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036064; c=relaxed/simple;
	bh=US1Fcoz+Y1LQZL0oT9Tl/6knfi8gDalPGn1nY8wLJEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yvn0telNNp5g7dJPIlStkp1TCifpCiJdEXgM3jbLGmoitATJ3gyZrGR79otWifgl9CPvlNXFeIL9ITVQUHIheq+6YK/8CWnrMH4icdwmmsygsPtQXl8YnXtc22lLhdcSjWnwFNh9JWEHzgetpbE6lCe9m8kyPUml2PcAEmKJf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cIGwx6sK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53654e2ed93so4122654e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727036060; x=1727640860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXnO0dAhio8cKR7ZLjPPkbdRt1uauj4aZsdYTjUljaA=;
        b=cIGwx6sKn4aTrX1mPY8h2GLuza5SoPVzx4RStj/NpUD69Vyt97VSiXnpyI+KGbWrAC
         1+kz113mD7Od+5BODUDxPSuJd0nNofo2h7JzZyybvRjSZ5+QpqCExe+SvzdRTxm90Nc8
         FCRru/4aoAJw1rBrJIql8a94C5RpR1ffY84aSCPOst4yXICP2unQdml4RKCmaafIWUnO
         Oe6r2s3imh0/4NtDhsasHkh+jN25uiRo2h6dZwTF9eqPUYkqdiqP8mdAZuvXzgkQanuD
         DzNt3yZBarvgYu4vG4OFeRdjIERrc1UXdG1Pkc1oxsSmf2NC8oHAm+N7QeUa8S6vCLrJ
         tovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727036060; x=1727640860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXnO0dAhio8cKR7ZLjPPkbdRt1uauj4aZsdYTjUljaA=;
        b=JuMNbb72O5A4rvDjyYSdjDu9n+MsrvdLYp/dFBoF2vvbdHV0gB/9mod/RRhzH3eGcS
         cwLzOJawVTwzqTIG0m3rbCapCTXIP9aDxpfIXJn93V7AHL+TmBkih2LZlHMb3ut9mHXc
         f309QuLQcEPq8LlIPzu1htjO91oYt5EzqxqLio7KGrjebl8XWrzgGohbRJKBrOS5aGln
         Nfzx7C6OM0H5SfXud9LBXcxHO/cAYOhYzKvxaysAgIzfcmZqcEanf5TAVpTbMMZkgd5/
         anMmR5HJ31ra2ap9m8DJqwh0RfYGpiMem9fAWUfzoizOjQn0D2FZZI4PoEmV/LjZAcqe
         FRzA==
X-Forwarded-Encrypted: i=1; AJvYcCUTiMrr0kk15Kpug+l3n/amiFnkwpcJxfeBS5QuC9DQ3rRMzEuoTkuwzBYLllsp9ZCe+/UqfRDM2ZHosrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylQB+0MM7oP2Smlq2GYVErQKDfC3mnzSCJj+zrKgD19Xm1w3Wa
	FEx9x1U/apFbUnQUaGs9pju/jdl5zTu2YT0BjxS/agW1taiWLsB98fBRlzwqeuv1TmFeHCYxGsD
	ddUY=
X-Google-Smtp-Source: AGHT+IHNntfHeoqZClLotGkHewiODZdHeP2Ru6UbyB/4XkBdQbNOsyJ6quJdr+0d7MsOdO94wbCHTg==
X-Received: by 2002:a05:6512:3f04:b0:52c:e1cd:39b7 with SMTP id 2adb3069b0e04-536acf6a527mr4485424e87.5.1727036059628;
        Sun, 22 Sep 2024 13:14:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704665bsm3052672e87.55.2024.09.22.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 13:14:19 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:14:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <5brnhm3yqqbsnukllo4l53ohaeqmxum53mwq7dme74ny5dsnjq@shjoravp6beg>
References: <20240905124432.834831-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905124432.834831-3-lanzano.alex@gmail.com>

On Thu, Sep 05, 2024 at 08:44:00AM GMT, Alex Lanzano wrote:
> Add support for the monochrome Sharp Memory LCDs.
> 
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
>  MAINTAINERS                         |   6 +
>  drivers/gpu/drm/tiny/Kconfig        |  20 +
>  drivers/gpu/drm/tiny/Makefile       |   1 +
>  drivers/gpu/drm/tiny/sharp-memory.c | 682 ++++++++++++++++++++++++++++
>  4 files changed, 709 insertions(+)
>  create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Please sort out the review tags for dt bindings (either as a v7 or as a
reply to the corresponding patch). Then the series can be applied.

-- 
With best wishes
Dmitry

