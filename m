Return-Path: <linux-kernel+bounces-341503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC49880DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39BB1C21C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731AC18A6CA;
	Fri, 27 Sep 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLN0GqyA"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBF18A6AF
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427048; cv=none; b=Hk2yV74O5SIiJv7l7f4rGu/SzHWYx3/bF7ZlV7+OOaegDCbGi1E7L92ww965nLuAc7/R0NKchww3BST5wUsh14oEIUFxb8lzxDtSMAA+hhJKA7nHSYEbscdS95YPgT1X1ZTGcJu+/lX7Ow4YRlbXV6pblNcZzjAfDc87a0vn+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427048; c=relaxed/simple;
	bh=5+rIyitqSJDhl3YHfZIlsDA/HiikjLp2+GiMVKo6SZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KORfKqU0mwBwkzHZKRkk7u/enSeMGhjPiH3vDRMEExSCOt7rDwm1o4XiDpOayndKeOn1qByccuqac222brjWRDmxYID8rO+myT/O0aRNeOteXNgwxHw5Zmf6gyII7UZDDaND4w3NGVGDyIoCWf5F2D9Z38ZVm88xLz+oOasZ5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLN0GqyA; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-535dc4ec181so2058055e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 01:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727427045; x=1728031845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSbb6GyqIU91E3tpBz1h87UeS05X7HA+7wteUPe++Bk=;
        b=GLN0GqyA0L1GrkZrkYy6VVUtTfC/uKnIKpfg4YwLhBK9vrVersZgfo1K0gGyNjnmmH
         3Rhvi01pAg4KDT62iRBCOKPWKbtbRfjWrw43izFOCHTHwmtGrvJPX+KD49z9UtJKc5Vj
         9AJU6oaPEaRSW7vNxV8scONiI4SV0aSB1qwTxUemr0LL3a9j+QFoQeU1Njbu7QYMJS/D
         up4yFi2f1KrxIn6K6JSpy0jkkOIIUasbtA0pPN1LOQF/7bVAXt2wiK06nCvtH1Q8uUEv
         mGlPstB6cQtkoQthaXd1PDRZKs6iCY2P8eeULH55LQFa6avQJfySo2kxd9PvnOAnja4g
         bIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427045; x=1728031845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSbb6GyqIU91E3tpBz1h87UeS05X7HA+7wteUPe++Bk=;
        b=Gok4CGqE0plAfQ+nQLi3Mbwa/oYKh9Ut4EUXt4Bcb3HIW1Z3bFopJ9AMK6HdzMS7y3
         MqEBHQEbabnWK27sgj/LNYPWiXpdEpr9LEDpU+SidC/TfWwNCjWbYyLd8alS/EkFjaw0
         i70AS3FQ2k8W/iXFlm0JcUa9fK9YkjAdTkFuDxUkD9S9cGwFFkTdmWLTquR0RYPoCYxo
         kvH7ir4HnWsK21ph/n8vOKXMIlOfGtgcQs5EHJ9gFTHmWU9pLRZBnQ5DRwLIbr5PHWNu
         RzhN4zDx3mx2nf8yc1/TER9y2BDSFjegKPSfE3fIg3BS682N8WxdmLGbYG6MdrBorHwA
         Fs1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTKyjLh0PxoH3qkfDTRJVPz1CdH5IhaQdpgTver/Wta1okABawempWhjQSaRRMnokq5bEpteKMvGrfhMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWHPdgjLYWyRkddCqUjXmehiV4nMZdhCRrZoYpMXokphHAtXC
	1nzEK6yxrRiYAtA3YHELsDhHGlcEEhy+Ed5lhVVrfA06j8raZjViAAJJXGyNMPc=
X-Google-Smtp-Source: AGHT+IHm9fx8bb+DamCga+fbsS/5uI9hmB42O72j7rISNL/17Jx88bpWAxOp7qLf5bQkAJzDG+1krA==
X-Received: by 2002:a05:6512:1307:b0:536:545c:bbfa with SMTP id 2adb3069b0e04-5389fc3c77bmr1626228e87.20.1727427044919;
        Fri, 27 Sep 2024 01:50:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0442d9fsm229532e87.281.2024.09.27.01.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 01:50:43 -0700 (PDT)
Date: Fri, 27 Sep 2024 11:50:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.Wu@ite.com.tw
Cc: Kenneth.Hung@ite.com.tw, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	angelogioacchino.delregno@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP
 repeater ksv devices
Message-ID: <pf3ehmjz2nx4gea5ioucftpinha3rzbitonmvmspaccdhirblt@wz6yybzethox>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
 <xyi4czye2dwqmh6iaschacduwxm52oaipbt5ulvlmalamkzwbc@6gt5endjo6gl>
 <79e5e8479b2b4563b2ce4f4a252b2586@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79e5e8479b2b4563b2ce4f4a252b2586@ite.com.tw>

On Fri, Sep 27, 2024 at 02:18:54AM GMT, Hermes.Wu@ite.com.tw wrote:
> >
> >-----Original Message-----
> >From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 
> >Sent: Thursday, September 26, 2024 4:07 PM
> >To: Hermes Wu (吳佳宏) <Hermes.Wu@ite.com.tw>
> >Cc: Kenneth Hung (洪家倫) <Kenneth.Hung@ite.com.tw>; Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong <neil.armstrong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart <Laurent.pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec <jernej.skrabec@gmail.com>; Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann <tzimmermann@suse.de>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Allen Chen <allen.chen@ite.com.tw>; AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>; open list:DRM DRIVERS <dri-devel@lists.freedesktop.org>; open list <linux-kernel@vger.kernel.org>
> >Subject: Re: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP repeater ksv devices
> >
> >On Thu, Sep 26, 2024 at 03:50:14PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >> 
> >> A HDCP source shall support max downstream device to 127.
> >> 
> >> Change definition of MAX_HDCP_DOWN_STREAM_COUNT to 127
> >
> >This results in struct it6505 growth by ~0.5 KiB. Please mention it in the commit message.
> >
> >Is it really required to have sha1_input in the constantly allocated structure? I think it's a temporary data, which isn't necessary after processing.
> 
> Change sha1_input with dynamic memory into one commit or 
> 
> change to use temporary data in one and change definition of MAX_HDCP_DOWN_STREAM_COUN in another?

If it's needed during the lifetime, it's fine. Just explain the
necessity to grow the structure in the commit message.

> 
> >> 
> >> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c 
> >> b/drivers/gpu/drm/bridge/ite-it6505.c
> >> index d1f5220e04a6..5d5ce12cd054 100644
> >> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> >> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> >> @@ -296,7 +296,7 @@
> >>  #define MAX_LANE_COUNT 4
> >>  #define MAX_LINK_RATE HBR
> >>  #define AUTO_TRAIN_RETRY 3
> >> -#define MAX_HDCP_DOWN_STREAM_COUNT 10
> >> +#define MAX_HDCP_DOWN_STREAM_COUNT 127
> >>  #define MAX_CR_LEVEL 0x03
> >>  #define MAX_EQ_LEVEL 0x03
> >>  #define AUX_WAIT_TIMEOUT_MS 15
> >> --
> >> 2.34.1
> >> 
> >
> >-- 
> >With best wishes
> >Dmitry
> >
> 
> BR,
> Hermes
> 

-- 
With best wishes
Dmitry

