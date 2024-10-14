Return-Path: <linux-kernel+bounces-363990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C0D99C973
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65CF1C220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6519E971;
	Mon, 14 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzfukRlW"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3C19340F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906801; cv=none; b=b6Z2sRrCUdOgRChjlwvST+jCTffklh6G06CtN4MBIyJCLODyzCQVY8tS/JY7ddYMz9AQ340dZ+9i9TIHBZc+oUFVxKhbBzT+p6jazq/vMv9yis2ptmRKrphTBqHpBDnafDZQxUst+GpEG4tx1ysEij0Wb0RHkJzTC8rd2DLoAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906801; c=relaxed/simple;
	bh=y26WP+8TPkw99lMdoFWJeEoTevLZ04L7MB6taLqjdx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq62abvVjs9AA8/ulpODx4Q7u7I0MTNyL4t3dZUwA+9AlaCwwyI4o3wTu2gVv7waoabzuaXHF0sECIn0q6V0l/Vvx+SDluhS6DpBWJDQSnvmv11FEb1OUz8ieuahigFFcj9gYDKB7061lXzrLieFVL4hrf3T1H9/J6dZFb7CjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xzfukRlW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e63c8678so1699444e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728906797; x=1729511597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXutyinsioeduBN1ANUedSGpi+lN6zkBNkpYVXz8SBM=;
        b=xzfukRlWRNOQ3vyTKkhCPxF0LDFquUpdG+GI+4/vvluuWHFQQP3TSOJRAWpSOXUeGb
         5AC1wrXxXdKR6+oOwJMdndP8xuJRoZQzPRrAnLOZmyb1/D/bD5/h2QdyOLqsS150gexd
         XZJlzgxMrdrp8QK1RZTf2/RuVPVrasasHboSP75pY5orz3Z3ay79sNQ+pxV8WAeMu8vY
         CoC/J8YhAddNgLzy8WnWPgO9F8oXzfhK5lQk2H36IbIqDLeTJ5kKkyYz9AGl4Y2UnfP3
         5b0OLhvEYZvfYvoSsapckIpvsRwcwB1aMxPKmL4shPQBUA/aTWU74qwYGYZshx6LGDLG
         AN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906797; x=1729511597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXutyinsioeduBN1ANUedSGpi+lN6zkBNkpYVXz8SBM=;
        b=A3Yh5HKR0ZQWIWSqGmBY44FLe0eUp0WFgjLCL27/tUJsC9B/j/cbmF1omoHEq+jDN2
         2en7p148FQpCvsgPU0E1a43YiCq1eo8RWSTot8wwgOZ7HqzABFuM1zv7SCFadXVqPrBn
         d9ifyuFWn72/JNCrWvG5IZnzr4JWKSy3K9ZQoOdM5XAMkw//7yDML66dIiOurrwfkNLq
         jKb1ewYWT1KyS80bJpFwmbXJsgtVXWaj710ci5BwMzJJItWOqSv99w/kOq/O/UI2UkMn
         NJR4RE9lJumWIvRp/j4BFJOKoIwBaNOIXJkqqR7gwhAk2xg17fXEvPKNqHBow31tgbmk
         KtSw==
X-Forwarded-Encrypted: i=1; AJvYcCWtl07+FRJO1344u03XDDnUIbx8UB0nMD+WAI556hhZN29H7rT01/1Uu9ZpXmsItkl/8uve9Fp0FiQJ9/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF76V6Rk0Lv7ptnR45gTt9UQJgJmQGlpGNDNaDC0+4K7mbMCW+
	Z+vQmhaM5F6AWqw/QWBsyB8i7NGJQPpAeE1lJiv/UDY0wy9nKmaV+9Hhtnp/ofU=
X-Google-Smtp-Source: AGHT+IGe2wtr0DTqglXGDZDAqNeDCeqKaarBInzPOg6nFlThmpKx5vXb8rTb6jYSk73JB+HKA2RlLg==
X-Received: by 2002:a05:6512:280c:b0:52e:7448:e137 with SMTP id 2adb3069b0e04-539e54d77a1mr3345987e87.6.1728906797122;
        Mon, 14 Oct 2024 04:53:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e21219d0sm1146912e87.128.2024.10.14.04.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:53:15 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:53:13 +0300
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
Subject: Re: [PATCH v5 04/10] drm/bridge: it6505: Change definition
 MAX_HDCP_DOWN_STREAM_COUNT
Message-ID: <lazvxlk24rzsdgjwk5ym5dbrr5jwtznftryzbxdxitt5i6xjv5@blhmwclr3ay6>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
 <20241001064305.32180-5-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064305.32180-5-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:43:03PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> A HDCP source device shall support max downstream to 127 devices.
> Change definition MAX_HDCP_DOWN_STREAM_COUNT to 127
> 
> KSVs shall save for DRM blocked devices check.
> This results in struct it6505 growth by ~0.5 KiB.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

