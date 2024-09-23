Return-Path: <linux-kernel+bounces-335806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FBA97EB04
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7911F21E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF4C195F28;
	Mon, 23 Sep 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY21H64Z"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B480043
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092178; cv=none; b=J1nLKKuGfDOA44m9YvDEnD9KOI4jRb3kyk54nrD2Vye1zkdek3rkQlJ0UBKSwvEL9o74EqmlL80Q5/f6BJYFZyxpiFN94KKEzddSrcCq2xLNFLFY4BXVe7K+DbP+AK2/n7ry3w4WJfNaTP/16zyehMVY1K0rx0lThPYrILxe3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092178; c=relaxed/simple;
	bh=p+vqvItcbzEDqwLWzJYG6MmFFZc1oPZ0RMpSfGT3SDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFIhJ2Qb0kC9Nrna9TOvAS3iXkdV8xs36Cpydyd4jnYWe5P2sOxdYIrNNdkXSB7ZdF3M/iYOVlyipDGEnvybg5+CWc6GzGAIuUi8WjlaUwmihhfQ89vaBOLZh4Y1wA37GufyJyP4aJ70mdx6dznt6O/brIrEeSnksGr7r/+emTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OY21H64Z; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365392cfafso4281305e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727092175; x=1727696975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6bRS2Z4O7hfTBwHRyQc1l3okYOjMJYjPBNO68Gsqpg=;
        b=OY21H64Zdz9cu9A7JYokzq4Nx00ftFAgxqUyWtktmsDtymHoX67qEzuDpkx4c7gPO5
         /04T7H6wv3ggg1KUEYJPhpLe55Ip8tuI+OrZkalbOrvYrxjoLwk4Zyzw0SzPr48a+FXT
         2mrCm+zfeOXKGSawkduqXrQHYkTWRsmt1miCgwp3JS4TqnsEgidD5ygg7Lh4wEV0z/9T
         H3s/alHctrjfTyDN5oR9XpZ9gG0TCFsSZT/1TCmcIGCJQ7C3fvyy5GZWqe65Cy2cAzKe
         5NGnCFXMKaqF1EL8M7StBl0sdilNlZc/nXVUkktFmyPUkGDy1vTU7kjjc5wX2PKyp+u3
         P1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092175; x=1727696975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6bRS2Z4O7hfTBwHRyQc1l3okYOjMJYjPBNO68Gsqpg=;
        b=DfWJLCOUALdH8EIFoeyGdQZI7wjmd2av27Azov1qVywJWpKs6NPj+pPFXTle4FmggD
         bdujZI5wsC7Y0XUsh93SyQFSxo5YQyxH9uoVPEfpX3Hd9x6K4Qzn4Il0PCjwqyMPyT/D
         I5aAttXdZt1kCrIlCFR3KaS9u8k+SCKWepM1WfSk1jVIHXBznV81yPRfZvSxIRl7Cf7K
         SEknpUlKMKpmoB3MECYeyl5kREjm3gkBArPDg21TuaDr16Fnznus1E3dU6ok7kqYZbQH
         tKdtvYPCKxHbPiHXk/dASiJWmAfFgN+CrmIfmmf5vunKOXOdEzj2MXeRo8WlBGUeUf+m
         6plA==
X-Forwarded-Encrypted: i=1; AJvYcCXb+VvE+zBa0zb+UrYI247+r+NNq+KZaG6X45ufznLV7YBLVww3uF2IRIz0A19PyjuacyEsNawO0/Nxm9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKEvSmC8JoenEv0HFcsdUERpTE25JOarIiUSRCKleIzDecRcC
	s+61wEtnT0WVpnFFQxAFrk08u8bteqILOcfo0TvtNTRIETFQ1f4lL+4LhBYlXCU=
X-Google-Smtp-Source: AGHT+IH5eHlDs92X1oOqMydop+/YnEnJFYVNxmxYyIaI8FUxaiDkS6ZoXHq8m0aKaIqt/4QABOTUVw==
X-Received: by 2002:a05:6512:693:b0:52e:a63d:e5c1 with SMTP id 2adb3069b0e04-536ac2f5147mr5615655e87.30.1727092175081;
        Mon, 23 Sep 2024 04:49:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704da6dsm3267929e87.95.2024.09.23.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:49:34 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:49:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes.Wu@ite.com.tw
Cc: treapking@chromium.org, Kenneth.Hung@ite.com.tw, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater
 items
Message-ID: <mkx63gnb2fobxxc5jc2f326d2oviix7dahyoh4sfeuiyypucln@hnklvrtv4q2u>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
 <4viir5prnuvpp76npblwmdrwlttm5daumvdnocipdsn6geyxvf@2yfcytjb3ono>
 <a0a8f862018b4c9aa689672551e7a492@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a8f862018b4c9aa689672551e7a492@ite.com.tw>

On Mon, Sep 23, 2024 at 10:45:49AM GMT, Hermes.Wu@ite.com.tw wrote:
> >On Mon, Sep 23, 2024 at 05:48:28PM GMT, Hermes Wu wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >> 
> >> Changes in v3:
> >>  -add detials about fail item and changes.
> >> 
> >> 
> >> Fix HDCP CTS fail items on UNIGRAF DRP-100
> >> 
> >> DUT must Support 127 devices.
> >> DUT must check BSTATUS when receive CP_IRQ.
> >> DUT must enable encryption when R0' is ready.
> >> DUT must retry V' check 3 times.
> >> it6505 must read DRP-100 KSV FIFO by FIFO mode.
> >> it6505 should restart HDCP within 5s if KSV not ready.
> >
> >Still not readable.
> >
> >English text, please. Split the patch to fix one issue at a time.
> >Describe the _reason_ for the change. Annotate fixes with Fixes tags.
> >
> 
> with fixes tag include drm/bridge like this ?  => "Fixes: drm/bridge: it6505: HDCP CTS fail 1B-xx"

No. Please read the document that I have been pointing you to. It
describes all the tags and procedures.

> 
> About the reason about bug fixes. 
> 
> for example, the 1B-01 device count.
> will this readable?
> 
> " When connect to HDCP repeater, it6505 must support 127 downstream devices. "
> 
> And this will be only one change in a patch?

Let me repeat the phrase that you have quoted few lines above. "Split
the patch to fix one issue at a time." So, no, this will not be the only
change in the patch.

> 
> >> 
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 112 ++++++++++++++++++----------
> >>  1 file changed, 74 insertions(+), 38 deletions(-)
> >
> >-- 
> >With best wishes
> >Dmitry
> 
> BR,
> Hermes

-- 
With best wishes
Dmitry

