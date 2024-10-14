Return-Path: <linux-kernel+bounces-363994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBF99C98B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40861F25418
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669419E96E;
	Mon, 14 Oct 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGqlRace"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245913B7A1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906944; cv=none; b=DPoFc+4mjFupz3JtjCJ31HOYDAzB2PwQkgWbEHOGOLMGqu9ABK6cMGI2KUBuzWEy3tjElrKMXKmYv8JWsaFznb+eHk0GTHBUXEU5WFCOh9BUj8b6aLSaI59sVNR43r+nk4Fv8xvUMTTcquYnN1+GTiEEG+s8AvCoFQvNVRe8QVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906944; c=relaxed/simple;
	bh=iCJf2BvQKHMkT1neGc/lIBFFPg3x0mhnsRiA2u32SRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIDUyo6ZX3S40GNYA4wQanAkFXz0DZe3fJCOXARxFxReS4Z1tvdJv+y/Q7mTt23dGh6wYjtykH+bi1tFullEOgIsJLUkIfoJjA+5TrOHulCRTEgWk+fhljvM8y56ldWqKLVQy8MCxG+6DFrmPs2E/H3JXCZdi1feDndcu3jqjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGqlRace; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e1543ab8so3867423e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728906941; x=1729511741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/oxXTAg0PlYJqkRYS1FLak4rA2aWJDGdiaDrP2NuKQ=;
        b=OGqlRaceVBPrN78qLo/w+8MQkP3lAkKuQ2h95b8o/BDuyV6ZGuk1BMbsyPWG+YZhXW
         X2iJyRT4jP1q03hGZNT+CMvrqKWJDMChEBGQQW5w6sJ9kMRH8OZ38vXZglGFz/swSil1
         i7itr8aqcck0SoYO7XYK99BvG0fQJeekCbZeq0XMu802RwIrJPfUqCLM9mTHY9tF+oSa
         JJIJ8o3enozOkarig1bzWkOu+ZO5lUPP7wQDhpW8BTLwfVhwLpzJEQCCNMS2TK+XAX5V
         ksX85F7+ze9zckyOLhSfyAjgk68r5P1YqFOzt3YLV7NrSOEQ7kqHsgiygnxn7R5lyHDd
         Gn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906941; x=1729511741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/oxXTAg0PlYJqkRYS1FLak4rA2aWJDGdiaDrP2NuKQ=;
        b=qLdATIxlFNKe6i3Uah1XQBhOqw379RR48dHzNO1PFPwUnFhLxS0LXUjBABKVZ81Uxs
         3XoHdA70nfL/bjxIUp+glALhUrAAB24Q5qW+PzsCY2rKjqACby13jYGYch0PgwNRWZQc
         9urG/MdvA0Z2Y0zMci5Fykn4SA6QJMpZBIrLLTL2tJ8ff8+mELawZPctW3gS7QJzyhzS
         K9Dg9DyYr8YwrVYlA8ZjtRW0Oo95RcZ8N49/ZyFnPmaeYWdmpg2tP6Shcv/KaQJTKLy8
         JCV6ZvoSsCZrNB+7JZSJLdx94Xwh90Vs/kItWYF0NNy7iTt7di7FrlurXF+hJRUBeplY
         q3pA==
X-Forwarded-Encrypted: i=1; AJvYcCXt2alSfBd17UhLtE8D17YWUNzpOIvKZz7HYUQYNa/AhZQY7Yaq0alW8amBqgODuarmdaGv9UwW33UuMkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ow2I4zrRplYXxFhWOetLi/0fp3JRLlmeb5pMavZJpJ+BToof
	SFlksicgfdqiIsBMq+u9ceBN12eWBvykVyRmPwtAsvXjsBKF+M0OF0rio0jp3g8=
X-Google-Smtp-Source: AGHT+IH8rPkujKntCd/jKdFy7EZluu4nWyB6i94v8ZAP9Vh+vAG8UNERp3kK/+VzRBL9Ts67/Mhryg==
X-Received: by 2002:a05:6512:2202:b0:533:4620:ebec with SMTP id 2adb3069b0e04-539e54d7713mr3536430e87.3.1728906940999;
        Mon, 14 Oct 2024 04:55:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fa326de4sm211972e87.55.2024.10.14.04.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:55:39 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:55:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] drm/bridge: it6505: fix HDCP CTS KSV list read
 with UNIGRAF DPR-100.
Message-ID: <s25g54atrkqjv6pfhege6eekd5fkx2orxwddevkotpoaphrldc@57mf46ksd4fo>
References: <20241001064346.32269-1-Hermes.Wu@ite.com.tw>
 <20241001064346.32269-3-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064346.32269-3-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:43:44PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When running the HDCP CTS test with UNIGRAF DPR-100.
> KSV list must be read from DP_AUX_HDCP_KSV_FIFO in an AUX request, and can not separate with multiple read requests.
> 
> The AUX operation command "CMD_AUX_GET_KSV_LIST" reads the KSV list with AUX FIFO and is able to read DP_AUX_HDCP_KSV_FIFO in an AUX request.
> 
> Add it6505_get_ksvlist() which uses CMD_AUX_GET_KSV_LIST operation to read the KSV list.

Please keep the commit message wrapped at 72-75 chars.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 48 +++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

