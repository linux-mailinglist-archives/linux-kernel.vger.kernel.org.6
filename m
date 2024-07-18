Return-Path: <linux-kernel+bounces-256789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3C93703F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1209F1F227C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567E145B0B;
	Thu, 18 Jul 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9QxbNeI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78126D1B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339275; cv=none; b=HQIEEVPVJCB6lGi5Ewm50pmhT13YSyyEdP0SOJvbJE1Cog4Wl/amJEoXmPzfVJwkaHRZL+/0EGx6Hxz46K8TXNPhOzUcVKdXU8x6g/BuKSJyb4l+xn3tHGkDj1yp8703uSmA5a2jPPCB4QT0kQJh64/Rv18OoCM2798gPKd1+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339275; c=relaxed/simple;
	bh=sIlaMapUNBK5D0OB317lndvKGlXcNDPuqRvYytuCjvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4LBWqneWlJ7py2TG7pkt0qcsoa/9XTNerAtwft1+thteUKX2TS/hPyKCMdncEWbzZIndX6oRRLwWbWwZ++AqbZAsC25siy6i9PR2G8qHZ1AvTEMAwIC66fG+zHhQojSEmdBFhsfdVmWPG55QjlqMVvT6Qs7If3VzptBnMo0DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c9QxbNeI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea5765e75so1189844e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721339272; x=1721944072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpMLX3kfs8/bfyK2ait4QZAXJJhBDNKyleclQhXZDdA=;
        b=c9QxbNeIaF6Waz4VqSW7thtQ0FLR8JXTY+OQftOdH9jXH+1d22DLkapxzNKwYTlkpy
         iHVksuoAZVhYGuWtHdvd3GkN1gBN1QmzyG7n0Ee0rcmv9MJNTgvjSplDOpp+vCewR29t
         IpB9+OufjupWeOOuFvzL8X6AlR2MJMaH+Kc1pkZhetLhdCFkQL9VLreHZncYHn+1Ifue
         mT2UtKrbRM/wRPbWlKAeMpInl+13lDG/b6frkVO0FiM8HuspqtFa0bFY2NC+4HO56D5F
         iSnjebd30WOdqv9bHzaZAKsLpuPRQgSIWOK147cHsAubFRstaOGGrbA/qeIFnQS6SiNB
         GhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339272; x=1721944072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpMLX3kfs8/bfyK2ait4QZAXJJhBDNKyleclQhXZDdA=;
        b=Z47cI3QxbYzWk8cOLbUB/RvU01rOTv80kDzZ6gViRZ85f7trcbUZD5F3ZUksws6w7f
         aLqUJK3vBW/PqS7w/B3M7Y08LuozGWslBzR9JXrdJP+z5AKAPQ3Y36037qmHCelIgmHg
         lzeCl6fWtbg6iNLPQsuH44VN8b+uH+IjXxvrsBI/ThKYUGpZtA80SW31XBt71Pub2aHR
         5tGwK1PexnmABaFas7MJAGxP437NbXCw+g17MJAg4qozdhyJXrRYbZ8eI9AJ5jt+2LRY
         pLS/rqCnlH+Sri58BBwVYmkWC8BXzUwEYHR4r7VMgvIXZ+AzFfPeLC+wGcHB18QVesWf
         tgPw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ljb7WsGYHigWQ8gcnyaKpIRgLBExeInKm/TwhpI+cY05bscPA9g6+LP6SNF8Kb101/u3QtlSaNrPmTskFESkRkBQzgShH6t+OKCK
X-Gm-Message-State: AOJu0Yz5PGx5nx0PuzafpRs9Y9hbKObLPD+WF31pAhZOta2FEWnuzbL0
	+zIJGhB39vl4+D4psfC1e5JGnU7ALQ1a7dmOLO51khDlr4+swxN82GWNLan3ZjM=
X-Google-Smtp-Source: AGHT+IHblCKnDA5X9aLd7Di/A53K4ImLa7YtSeAHvDZw3KfD4za5bxapeD5LaXRZlyMqLAGzfMTH5g==
X-Received: by 2002:a05:6512:3c97:b0:52b:bd90:29c8 with SMTP id 2adb3069b0e04-52ee5428b13mr3546662e87.60.1721339271758;
        Thu, 18 Jul 2024 14:47:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556ad17sm20e87.166.2024.07.18.14.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:47:51 -0700 (PDT)
Date: Fri, 19 Jul 2024 00:47:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <7csq4ml5hm53gqwrs4z6pc2vtokxsadzqmyc3yj57zcxz56766@asuk4vt2z43f>
References: <20240520125551.11534-1-linux@treblig.org>
 <g4nwb5cgcg2wff4qogzayhdrj3omneeusfjqmdupghy6zlji5m@kp55dmkbj6k3>
 <ZplVoj6xAAaMnisJ@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZplVoj6xAAaMnisJ@gallifrey>

On Thu, Jul 18, 2024 at 05:49:22PM GMT, Dr. David Alan Gilbert wrote:
> * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > On Mon, May 20, 2024 at 01:55:51PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > > has dropped all the users of the struct bridge_init from the
> > > exynos_dp_core, while retaining unused structure definition.
> > > Later on the driver was reworked and the definition migrated
> > > to the analogix_dp driver. Remove unused struct bridge_init definition.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Hi Dmitry,
>   Do you know who is likely to pick this one up?  I think all
> my other drm patches have found their way into -next.

Applied and pushed.

-- 
With best wishes
Dmitry

