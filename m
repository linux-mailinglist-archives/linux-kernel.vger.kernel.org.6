Return-Path: <linux-kernel+bounces-334458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A573897D782
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74E91C22980
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A517A584;
	Fri, 20 Sep 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qolx6+bd"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853FF4ED
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846439; cv=none; b=W0na+2P9X6C92+IMJrTJq15ey2aLL26SODNrY7HW686tHUB7icKGtoxWv6WjDwI4+dhk/b56+pivtbizM8CDOvbDFco0kfspJ4lYG6HF3JepEpVCztKoOcJEB9B0Shc8sve0+bfh6zANA/A0dCHUoE3mk4eHd/cCw0lxROd1jU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846439; c=relaxed/simple;
	bh=gRuiQFgId8KNL/BjHOUZgS1ElCbc4udFpTwFhFtoMnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsfh4xQwxHb3XqyZvMGkrNAojScTC6RgejGsuHT/qfxZ9DIy4JCA6LB00gn60dH0gtx8SOXtgUVbGRhXYfpthjhY/phW5TkX/kIG+J5FNMOiEHv31+5Bt8OYW6h5QTd8aVYQLjIw1Evd4JQkKcgqj9MWSTJc/Yw5J4fckLkLU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qolx6+bd; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356ab89665so2908110e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726846436; x=1727451236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfRSdEyyPP0dQ0p5xGwwdjhrzJv+SRRAK8F5od/ccqQ=;
        b=qolx6+bdtf/caaKPsK+avhbcaz6drOoy9GlTQ1TQkHhn/v9uLFmzxnjjdwKjHVelKQ
         b4/A7wcbWrjA8D8YEUUpWr0fa5/Q7QK70nFUWDEN4sCIEsABk4UGJuYA7l3KJrBawgA9
         oliqNX/6A459XBirvYEqM1ISvzU0LdkByc1BlXJiN5C4+oqIl3zCWmlil17mSBh0bd++
         5WfN5GfcPHJ/S1kNMWB5cLuKatFFv/6nMmBiGx5dqNzUmod9sKP5ysgCnKya//48Ikss
         MtQNc9rsUU+ub8XKBjMB4yPpYg6D503N6Uc4g0uyxe+Mdht0VVBFsfnrCq419K3CbUjH
         0+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846436; x=1727451236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfRSdEyyPP0dQ0p5xGwwdjhrzJv+SRRAK8F5od/ccqQ=;
        b=gHvQpAc+DIO+mwGelMkPv+aemJO4k8v3ZUgB2PtUtkSAC40kpU6K1OkeNDbL2GkGZx
         riqqBPqhTVyJ+JRx11hHl2uBqte7NwTzhyw5BMCo05CE//gQk80n0tF8NLJCyEhbvbiY
         NaGse/9GcWyab/XGE31iZTVMsZifEYobbJuNzuC5YaQIrFdvD8YR3VNIIjdpxgoEFZhY
         zfsTYIlDwjTm7E9EplIIlTa0jGxcxZyonUOFVwl5XRvBr/DAqpYJedid/AKzEo3addLT
         bTEJ8YZAxrigoLJdY3HlnGzapf9LM5TcTq483XNlnoUWdp+EAz2Rpt15EYZjIidaS0uT
         TM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1lf+9LJ2zGZSryjcbJaSQLxjf5ahHBFBAhePjlWCPWwnK6IkdM8aBgvxs1ZQVes7IveTcb7VcgV6xXkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEp6hliWkmg6+wtjQL5BvUSkda1ZD7iqijkuepfAZ5jIEsP3P9
	rCLH0fS/h0tPDhO5DM8Nm1ZCi8b9qUaKkJb/SLTq4+gYwqWrpLeCe8JSW3jyWLlmDf0LUzO25VH
	ta1Q=
X-Google-Smtp-Source: AGHT+IGr0TDWtOdEFGU71FmO+FDqpRt6RiquTpfeC5Qvxd6F7KCQOX2rz5F7/wD3huV4BCuu3doStg==
X-Received: by 2002:a05:6512:220f:b0:530:aa4b:81c7 with SMTP id 2adb3069b0e04-536ad3d5526mr1683832e87.59.1726846435720;
        Fri, 20 Sep 2024 08:33:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a89f2sm2188989e87.240.2024.09.20.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:33:54 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:33:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>
Subject: Re: [PATCH v2 2/2] drm/bridge: it6505: Add MCCS support
Message-ID: <zdfbyhr4td3blv4bnofrihjorah6n3aroy75uwwonhlrvimpl6@2dlrlbhficbi>
References: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
 <20240920082451.9240-7-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920082451.9240-7-Hermes.Wu@ite.com.tw>

On Fri, Sep 20, 2024 at 04:24:51PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> add AUX-I2C functionality to support MCCS
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 209 ++++++++++++++++++++++++++--
>  1 file changed, 200 insertions(+), 9 deletions(-)
> 
All my comments from v1 (except for the Changes-Id trailers) seem to
apply as well.

-- 
With best wishes
Dmitry

