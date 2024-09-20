Return-Path: <linux-kernel+bounces-334457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440297D780
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A8B2868E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A717B50A;
	Fri, 20 Sep 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JApEuZUM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF8F4ED
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846423; cv=none; b=YEhte9/C/LaXz1v1rwtejUuRNcxKfwUG0/TJWFFDGAupzvyeXeI3UtOnQpqaYdJcsy63Z+Nxw3RImM7sqHYsxN4qo/woy+Iud68Ajwu5UEVDfPcb7R5bMzUVDIBsBs8mZWBq6r3VudF4g8F/M/WvdNYOK8xiLfBt18KbCkmYgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846423; c=relaxed/simple;
	bh=RiEptuTftjEOqpAnpoW1D96DZueqrX1jCG2ztD4U++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDsaTlz/ldGec9tnJx/ERwIN4VnWu7gbE22g1n+x35nCnJYeEu/EPSGZoXip4J6kgShT+rKSyx1FpLypG0iqD7E4xFnvnvMNRT2HGGybN9Nf0+ez4MVsv02GTIvoWeF2Q+FLtEYK1sYcdWV9oAkqnJO6KDG/qmBEGkx0YHAOnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JApEuZUM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365c060f47so2916174e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726846420; x=1727451220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9o8TGrcov4wFQsLxGwrTX430N+dK3XgvjP2/6zbGA=;
        b=JApEuZUMmlwS75DC1K6YEeR776i5z6NTWrkV+OWFV1gI5OpoQX1dcAPsbtGp52dQz8
         y74reLZqWm0ymxiCoGbgz54pauzZ/uQa6BIJK0qvqd234uD5EDIDxmYF13Ld8vQ1NQ87
         09zZ4GHXWIN0CiV2lk7iHSnk6zVcZE52by7i9sVhISBvzmS91KZ9kwfH0iLdH2lFdyac
         KZSuwSK/XFWJsqOgsXS9NNBf5qjp9zIaX2WMZAOaP/jIkaiP9VBX0X95S/qnJ5m+CXjt
         gX/4Sawp6/eDR/Ro/hYeLbVI4A18LXm6jqoBORI1Igb+tyn3VuPdpAQXAMYjgHX82ly4
         LpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846420; x=1727451220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv9o8TGrcov4wFQsLxGwrTX430N+dK3XgvjP2/6zbGA=;
        b=Qf5YGFW0Y1YsLCrqSuaxpmM6dGPXtPvSZY0kVG6gahVc5KRGUdV602tXoUnfY1T4Tr
         xoRTPDuXBpZ0hjh5sU7dxFqMbmbGjGBmznifuqzHAzRmlSC7qv2x4lM6Lv9empbozOUz
         6sq8gC1RhHDzpTRdhaf6cwS8pk+k2Z0c44BaVLsugR5D2pcJmW5mgIUksaRKzhlBvbQJ
         BcFi763EiL14ZZDwUua2jxJxIIKnDz2v9OBoZIOKJVqCsgoxAcblmBRsa0c+VyOZICHm
         VVVLsDlDl05YXTpnkuXkpIzJCEuqI0qczGs9XflbjrOiOLEOujsbzcywh4xpWZ3qUv5g
         gZSg==
X-Forwarded-Encrypted: i=1; AJvYcCWtcqEsm9ZCsdP46wT4I8cfL7RXFFFwvYRDIjm2/wuxA3vYFSea8yxM7+P6cStyvZeL3o24Y55w6iYn4Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFwJKlXgw4of9gSSxm45Xg9ByIiCPegGLPIWxWLLTyViAe6tz
	FFpJIUCHkydwAXH04pc+MroruDpgAFIiQX/m1q9fU+YDi34fnRsFSjJ4N0sQJt0=
X-Google-Smtp-Source: AGHT+IGw23lF+hbTYFLwOdhKlOYBaupGaR45yI6nU+klXthzjCAMI9F9zKfWYuR9PZ4gB9iVyxMFRA==
X-Received: by 2002:a05:6512:138b:b0:52f:c833:861a with SMTP id 2adb3069b0e04-536ac3400b5mr2077421e87.51.1726846420009;
        Fri, 20 Sep 2024 08:33:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a45aesm2242756e87.183.2024.09.20.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:33:39 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:33:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>
Subject: Re: [PATCH v2 1/2] drm/bridge: it6505: HDCP CTS fail on repeater
Message-ID: <ho4ixf5fi5nuuq744ojjadzsku23y2sksnrkhrzlnvgvd3qfdo@cb4aocrk53ug>
References: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
 <20240920082451.9240-6-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920082451.9240-6-Hermes.Wu@ite.com.tw>

On Fri, Sep 20, 2024 at 04:24:50PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Fix HDCP CTS items on UNIGRAF DPR-100
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>

All my comments from v1 (except for the Changes-Id trailers) seem to
apply as well.

> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 152 ++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 51 deletions(-)
-- 
With best wishes
Dmitry

