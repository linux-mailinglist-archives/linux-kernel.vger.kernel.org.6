Return-Path: <linux-kernel+bounces-538320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B822A49726
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607613B81F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9CF25D913;
	Fri, 28 Feb 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIlKdcHU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7525CC7A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738234; cv=none; b=KhOYqNs3pPFO8uwOeI8i9P2svf2gQBZtSiBwBJYleAMdy45BQcbYdXLwVsKTin32VsSPkIlAADp4spHkC109MU+++P64ozUoVLFAAardRj4XnLojrwD4AF/JZDgOaWZwwelWDUSiPUhP3PFauZ//2GZAwstTpLBnucZgE7vGbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738234; c=relaxed/simple;
	bh=6v+0WDwLgpXPJnPNKdHaqelPONmHUTruWATfgBMcnMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uheDpGA8snZiQbvAdjpsBbte0uQFV1dO8AcHcjqRj0HbJMWiZmMkPXbRDp1Ca1lpzsuAyCAuKFwNS8iihN8UHL0WZ04pY1b2Y8h7XRNhJKSAtT4Vh20isJAtgbelswYGKeE+WW0YktiKfDMrYKwECaJMlxzTvp5yD65JLp+xS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DIlKdcHU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54605bfcc72so3475812e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740738230; x=1741343030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOXRurkxs0z+V+7lsmPMX66oMcslr79MsEtI3f5CfhE=;
        b=DIlKdcHUCYQGw98cm/04fmMJFcmKm/eNXu2mr29k8SIqxEDM+OmahSXD2Gpk8JBKL4
         c2kXBz1/Ka08ZTgYTu7wBABr3av+cx1DiaMS2Yr2vQlW58nnk9S6C9RwAmtDt9uHkliP
         rjjYI3KakW1cZ/dq9Xc9Y4P2e4H+Y4b/nHAt6spa7EVZJQML/hVp3W+pdyHnokq7FoUZ
         WfLX4u1zYqw8TFddcg9/Vs1A1O7w/vRGrhm36+PYaCG4heZ0i8Xq1pJX4juA6r7QW+as
         MFrYyI64TqlZ8BUqB2+CmXWFvhIxo3ngRhoryYl6doSufFkV7iYCB+FMXZkQNll5LsbA
         fKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738230; x=1741343030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOXRurkxs0z+V+7lsmPMX66oMcslr79MsEtI3f5CfhE=;
        b=lXrJb/x6foo9FJqq1cWK9cnatR/y9YY1VCOyLDVOjH26ZVNE45oWd0re11fwOXSMJM
         1p+YqiOFjTIGitPqg0VABds2M4vVPecUSn1Rdn5hcBL8UDYKhEgrIcpb1rPhVuEdIXwY
         HGQacMe3A3JujBtHjQZKxhGBWwWleWzef6Q3q/r29UPJumqhCfu7yRtGLnCyH3MwZTLF
         HEWeK62tfbCZDwe+T7durNDh2RYGhaXxiDHRZp0QLVH3QTwnVFCBV49w/rplp0NW6ZOL
         EdTeRlqoB2m+aUx3AobP9hR9vFO0sK+LF34SHjY2n/FSu5MarTS3Nj/lLWSDfg54Wh51
         qQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4nf2u4TgcZm/YVzVqBrf4wB0kMRcM8VEheP5s74rtfPOT4LOomiuQ04DCJ9ujZewAunM6DgVvQDE34mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywp+I7hS1zNzDzR9cs017PsRiRsqyS8UxQC1PVIDEkl3wlt7tL
	XqlVgwj9/C0wpkFrXEeAZYPnbkFd/IYxhS1ydLZgeL8LHzhXDMlH3mYIo+UgSt8=
X-Gm-Gg: ASbGncuHGeeVM9iNLDrH4TMrCJFvKXEKb6Pc17OYljYvK5cG6ylTQUolBl1bEbsE2tu
	fk4nk5dh/LUph6srnJQGQiXiO5LfSj+XQnTJkDvwuxZvvCY13rjPuDGBRo5RFLXuzzynPuEKVLW
	fkEFKl1DNp0tCDBioQJXyEyIkuzqP592OJXJ1QtFIh1QxYDoM3IwYd/IoKFmuPMKupaet4BrakW
	2dSVGcxAB3d+Fnevto2x1dFNOHThkcXUz0lZxebHrA4I9P3oQxtuSKPItG8wm2HlOdNlP/LMhaO
	8shMIKSpOfhAfYobDeqyGnDy5tgSWACrsXKtcE9PDJUbON4kvEbg2bHlJJagPLwkrUY/70VEj4h
	ttgD4HQ==
X-Google-Smtp-Source: AGHT+IF9LbW1HCKmZbmSt9YCfBY3dVCCtw9fK87uyuUzNs/7q6xF88ILJDPLd2GLLROaUD03gbt8UA==
X-Received: by 2002:ac2:4c4f:0:b0:545:25cc:23cd with SMTP id 2adb3069b0e04-5494c3339e6mr1166834e87.16.1740738230560;
        Fri, 28 Feb 2025 02:23:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54944174494sm441628e87.10.2025.02.28.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:23:49 -0800 (PST)
Date: Fri, 28 Feb 2025 12:23:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/bridge: Fix spelling mistake "gettin" ->
 "getting"
Message-ID: <qyckacqgtlqrmu7xip3o5h3qjrdqegtvsivtqihg2asbk3rzm5@sagoukfjydp6>
References: <20250228083248.676473-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228083248.676473-1-colin.i.king@gmail.com>

On Fri, Feb 28, 2025 at 08:32:47AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

