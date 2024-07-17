Return-Path: <linux-kernel+bounces-255252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843A933DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFF2B222A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3762180A6A;
	Wed, 17 Jul 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQss0plX"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C1566A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224373; cv=none; b=EmcMeRc5FPrdVYZxwYkNpmxZnVpNecExR5QAB1BsElZq0Fpy2ulFLtfs/Nj3RIDYjkCIUPShwLOy/yl4/rLTMPuehjVPMboU5viTa80EW6IXuGf2tx6tSQBe9G2n445TZDDvZu2VGlGPiKxQnK1iXkFT5ftUixB6HlW5v82RukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224373; c=relaxed/simple;
	bh=HiQaCLQyficZU4LejmHgxsnpMOj+j4vX6TmxWnlCn+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsytJGMFsHByUNwc63CJjYEExiyYTOUOCYdP8XSmD2TEuO/7qxaaR7hwXYnSKHASHTZlxfme27Lz1MlRsmlClOCIkdbDmnQ1WTANWGLJlG2bqdZLrSA0+LgDuz6gZx14sRKdySp5gSDa5gJE4m850MgbV5i5o5imcfzs+MWvY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQss0plX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea0f18500so7016702e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721224369; x=1721829169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTZ1w34LpY+Iwl2cOExG2kPyEczemOKdDN28ITn5flU=;
        b=LQss0plX/L+ERYp14gzm5AYrWVDeUGcRzThpOq3y2sBzS5twi+2DYdo9qzOc63eJ/v
         Oid/3KlHik1cNhgZ67upM8XGfBs+JpCKyErLeKheUEnNdaWHheLGTCF3EBW1bJEY84rg
         19o9IliKx297NEv/pkFCL1D7LHLqNieX5+UAFZhQAOzvrZfCAB3X0Kmi9Oh5Tpi77PLp
         /t7TorcgJxFvcn2xmiSf2TGRG+YMkezpRys6SF0rHXYt5D/ruNHWg0w8cTTYKVEhIe9i
         j8gCmWX7eygee3n1whuK3tV9oAnvR9JI28yvfCw5jBTG6nssNffM9h6rrwqzV97O+JAp
         LPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224369; x=1721829169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTZ1w34LpY+Iwl2cOExG2kPyEczemOKdDN28ITn5flU=;
        b=gJVfQ7sIN6r451tHxvSjFC35opTAgk3QPwflC97mbTxdxK61QHsl4NykupqGJ/Agn7
         rbawMl62BRqssEsMov9s47tSJpfA6Ny74i/vIFKYFsv0DatPJSchRAH0jEssgduECGGg
         3eNH1GgJAw+tU8nw9GaMUzb+kkaaLUDCOQEKf2RPAU1jh5lV0tPPpxBZHzxg/o3naPwF
         JYaQa9DxapW7OtyIRppijQ57675IwrpWIYQucROuJDQSSKSq22rk1i7nL6Lxmnnfa+Oc
         2A4ICyGLlcL9vBmdnNGcZOJ6SU8Pqhbus850vehhF0tXTCLftDkncr37R+4quY44Rfri
         bZOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPENhkJK3TK+wvZanYO5PhSo/UsG+U+hq4zDH576vUoe4gupyvZG9TXua7OWcFk4GsKh0GQN/8FD5Tmzf7ojVzp9cwl2mc8TL22ANe
X-Gm-Message-State: AOJu0Ywr6Ufq93af9ez+XCjp/hpO4k8a6nPpEabBtk3mCWMwqPOK31Aa
	3axzZYhT+K1VpjBfTdRROBp9PokPSZv3Fz6lT59cv2WXl1EtLd/UDseRLQ/yUVI=
X-Google-Smtp-Source: AGHT+IE6OoXjvcCZm9Pc74dlkP2dbs85YedF8j5WiIaAFphQI9CaG9G+19xV9GW3eCQ2VKK4rEBu8A==
X-Received: by 2002:a05:6512:10d5:b0:52c:e402:4dc1 with SMTP id 2adb3069b0e04-52ee543da79mr1235817e87.55.1721224369292;
        Wed, 17 Jul 2024 06:52:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed252d771sm1482228e87.124.2024.07.17.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:52:48 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:52:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge-connector: Fix double free in error handling
 paths
Message-ID: <7nlj7lexg4hwllwaw27gtfsgvkbhlnodi3u2ckr7uwryvwkhhh@mjc5wduxripy>
References: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-bridge-connector-fix-dbl-free-v1-1-d558b2d0eb93@collabora.com>

On Thu, Jul 11, 2024 at 02:26:55PM GMT, Cristian Ciocaltea wrote:
> The recent switch to drmm allocation in drm_bridge_connector_init() may
> cause double free on bridge_connector in some of the error handling
> paths.
> 
> Drop the explicit kfree() calls on bridge_connector.
> 
> Fixes: c12907be57b1 ("drm/bridge-connector: switch to using drmm allocations")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge_connector.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

