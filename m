Return-Path: <linux-kernel+bounces-334456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260E97D77E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00D22867A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5717D358;
	Fri, 20 Sep 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikiwGvh4"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661E17BEBF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846353; cv=none; b=lvJLqLj/blk/+fSRhwxKf528kRoM8RQB3bPxx8daYkQuUPEGGiCX7IZrR0fxo2/KC0+4opjA9XVwGAuKE1LoyjyiW7zPzkQpi7oluUpbGGMWOt3EfIAh0pmI24L3oMretAmu7rXQwEKSvlyPHwxkhktU9wgtCqW0T8lx8lCWi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846353; c=relaxed/simple;
	bh=Isqa0zhCNrGOkKf/88IOjyHqOe/K4zP7ATE4D5bVdqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn7p1QBDHQ9qYf8viXYZZ210I7+kHC92S//UlfNQlEsfW80jRgcDdiZOr2K/gUx3u0EKvlY44C3dsLKYL2se3ncjUyVlJ9XTkpocAcmD6jh/yJXXKzVu7ALBHjnvkprKYd+avl0N532vfoBlJUgZpBwzscj9l/4BXb1IjRmRQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikiwGvh4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so26618021fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726846350; x=1727451150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVvBt4ITf3Izwk7cN6igXz55uEITPGN8VqBf+wAkebA=;
        b=ikiwGvh4PoXvJ1MXbVEhNGBFAvHfaRtVniTPE1PbWUvekYd594++BqrHJTu6XiYzdK
         VY5TZqMDqE2YJE2i18h7kSRDq5kPu51nKwrJ0OpzKi3Id6Rc1+3kQZd0n2VXMn15xuT1
         PomlXhV8YXskvX78MRJctEgoIgYhpyc8bXg3UcmGCPQBBLNuklMJJeupTz8IsrmqLrmF
         zZ3ptAEFk23JoZSg5tTABLaucPE7ZjBcdIotgyIrx9aiZ3l/S/JtXljnuftwO0RJS/60
         A+MJeO2BwIo0gOLUZdp+n/A7/RU8/2Bhwam/oobySDah3tkb2uEQ8WBpxTzEmzaUrFyZ
         +eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846350; x=1727451150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVvBt4ITf3Izwk7cN6igXz55uEITPGN8VqBf+wAkebA=;
        b=kox1d3G7klCI7KP+CpT2ErTLERFDV1mBigqwpgCok0hkripTBVgAQSKM+Rzya26bXx
         VO/BSAgMTgH12rFVbOLGcvbRvAP1DPfcKHvIPdRpzGU73vdaM4hWTfYvu7URF2ubENyS
         0T13pbFadDbgRpnXiRkUkfGjlXubDKa9rrt6wX8udXZx9BBj+6PNIfQh1RNs1BaJlSqP
         kJD+ORHDyuZUtSh6TV7ZGSW+hqP7XKYXX+glwg1KgS6SGyTXoEITUNieDjTxA6i5+EOS
         foKT3ShD0URl4mn0dP5z6lNzL1VD7EK9IFmxTxpaGgqqXMFIkQXwZeW9CMp89oF/Tlo3
         FsIw==
X-Forwarded-Encrypted: i=1; AJvYcCVrKGIYPMkxGQyvHBA1ymiiYosZXzTkeEuK8abSKffJ9KmahKVEy3A5hBB16PS6EHozl7AD9oDbjdEv6wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1RD47X/nEAgDbYBBm09c3H/Ndjv6Omv6SdaKKDuW9Zdi+Q9x
	dzdhKZAIm1ZLKSkRUT6eR9l+S9NX1CgnkCqlreKhxbI5+Zc3Oa5df9p0S60Kw8g=
X-Google-Smtp-Source: AGHT+IF//uVEr2Zd+OvykaAJPU+E3Yc/1OLJs3/DZxpLPCqo0XwH6DBwqDEvCzEaB/5XFcbFSFXmqA==
X-Received: by 2002:a2e:a593:0:b0:2f7:5980:78ca with SMTP id 38308e7fff4ca-2f7cb360495mr20703281fa.32.1726846349554;
        Fri, 20 Sep 2024 08:32:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37f8d8sm18808801fa.92.2024.09.20.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:32:28 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:32:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	open list <linux-kernel@vger.kernel.org>, Kenneth Hung <Kenneth.hung@ite.com.tw>
Subject: Re: [PATCH v2 0/2] drm/bridge: it6505: update dp aux function
Message-ID: <vxs3eklfifsnaq5rn6kppegfv3plsviqaq5nvlzo3fgazwj6y7@od4atbvf5ep3>
References: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
 <20240920082451.9240-5-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920082451.9240-5-Hermes.Wu@ite.com.tw>

On Fri, Sep 20, 2024 at 04:24:49PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> This series change aux function to support MCCS and fix HDCP CTS

It is v2, but where is the changelog?

Also please give reviewers some time and don't next revisions too
quickly.

Last, but not least, new series = new thread. Don't send new revisions
as a response to the previous one.

> 
> Hermes Wu (2):
>   drm/bridge: it6505: HDCP CTS fail on repeater
>   drm/bridge: it6505: Add MCCS support
> 
>  drivers/gpu/drm/bridge/ite-it6505.c | 343 +++++++++++++++++++++++-----
>  1 file changed, 292 insertions(+), 51 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

