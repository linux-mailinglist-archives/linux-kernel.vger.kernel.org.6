Return-Path: <linux-kernel+bounces-335720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B3E97E9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3195E1F211CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC91195F04;
	Mon, 23 Sep 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpJCmsqD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D68194A54
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086491; cv=none; b=iCsBH0JBJWcoYLeNixrbYmeF0foVVNI6gx3rLRb/9BeRstujFvRfTgTRYI+0XkKjXD4RCf3t7ayJ7/I2vWP//jbc0GHP/DkE8vZ2Z2LJGJ5DdET0FatENwNV86HB1OJCAHoy+Zjnz6w2yj811+iwUu1aDUcaoTyeWbuJdaSYWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086491; c=relaxed/simple;
	bh=KlNHg/5ZKE5qrB8hmfVL3SotEkE21J3fncPu64aclHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L30Ob1r2kvHg5fpS+omD9kawhnv+1gKP7C/bxaQ1qIjCRn/C3F2mTCWHvUvtR7LW7Z/hkk/sHjkawFiY1BKLHr364qMTT64Q76cVQSD1YCvJLAo4fKoaP4e4DvgB4etvzmTSH4zHhhbbO5ORQ2IaK7q+rIYuXJbIQJCEcyslicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpJCmsqD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365392cfafso4165011e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727086488; x=1727691288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mae6Avg1FIHgSG+BcO4YtIKpdaFqrjXa2Kuld6x2i8c=;
        b=fpJCmsqDbnXaL+Z723PU4VyQ/9CNPo5vvNi49OTil8spul6x56JI4HwdoRF6al5J9w
         YMH5C2uNB0HrXNycXq7Zm7BUf4ytq1aC8H48SE+xjwB9lsHwuTeVFu24wT/rxU9IUD8L
         S9HfU+ZBmn4kUQSdZ9QO4ohN/W2XjWDPZhOIWbfAE6RgxH/vzyHpMTL34pANqO44Yug/
         SSPdp2VVFK4z3gAfVi2tdLx9e3aLXx2h0HjZe7p0KZ6Xfs+cCueKr3PIE39woQJdLGTi
         iuXdfBnF5M5LOfYpPr4N7R64EcmGyso8ZhgCy88P42ckDlogr3f4BKAfyoTMJNkaO6yn
         PIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086488; x=1727691288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mae6Avg1FIHgSG+BcO4YtIKpdaFqrjXa2Kuld6x2i8c=;
        b=RpXfMyNTeO7pPJSU3YUa1Uw9CIGZxhKKg8fGxvg8EUBxoux3Iq1pMjK5Bn1OTw2/pu
         dzP9SensWDYTPbmIpEjKxGVzg7muzbX22tz+VsrFULnliWVAgwrAQiHoRYEbdgcPtY15
         7Ltl+nZiCNMbOk//f2X81LuT2K7Fk0IxvNVbk/cGoX+LHbOje0sk7F2hZER8MD7FmGMe
         5XReElNAKiJtHfsy2gMBxM96AYoFA1EDiiGuPKBFM85Z2JQPMHQ4//TetKfADWmQhEwb
         zujcmcpCm75yc0gvTO6d/8vtw9HN0mOa9gyBirJ3ZZz3h0C6ei4oRSwSkBgsmca1XTjS
         15DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfn6WzuS4qZmvC4XMCKDX6moHCqxVfU/Px19a3cuOeC3n+E9kJMoFo1FbSeCFN4lu2+ldVzi1rtqzXqm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/cfj8wBMKv23f/Po0LOPIhakJnJS4wJHc3xZabyS1ilrfk7b
	1uGeoETr5hyhwQQlKHD818F+GubUQXnh04eJu+WrvAoJ1NqhqnHAecCj2Bi2PIk=
X-Google-Smtp-Source: AGHT+IEJ4FRJFjtM6OZF/5c9q24G7P4XNARCEcNGCmeR31EtaLklWtVoHKAsqQj4SgCYxhyH7gIfAg==
X-Received: by 2002:a05:6512:acb:b0:536:a4e9:9cf7 with SMTP id 2adb3069b0e04-536ac3400e3mr5563017e87.56.1727086487564;
        Mon, 23 Sep 2024 03:14:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368895db54sm3140244e87.112.2024.09.23.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:14:46 -0700 (PDT)
Date: Mon, 23 Sep 2024 13:14:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater
 items
Message-ID: <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923094826.13471-3-Hermes.Wu@ite.com.tw>

On Mon, Sep 23, 2024 at 05:48:28PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Changes in v3:
>  -add detials about fail item and changes.
> 
> 
> Fix HDCP CTS fail items on UNIGRAF DRP-100
> 
> DUT must Support 127 devices.
> DUT must check BSTATUS when recive CP_IRQ.
> DUT must enable encription when R0' is ready.
> DUT must retry V' check 3 times.
> it6505 must read DRP-100 KSV FIFO by FIFO mode.
> it6505 should restart HDCP within 5s if KSV not ready.

Still not readable.

English text, please. Split the patch to fix one issue at a time.
Describe the _reason_ for the change. Annotate fixes with Fixes tags.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 112 ++++++++++++++++++----------
>  1 file changed, 74 insertions(+), 38 deletions(-)

-- 
With best wishes
Dmitry

