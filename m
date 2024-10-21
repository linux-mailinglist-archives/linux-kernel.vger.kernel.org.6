Return-Path: <linux-kernel+bounces-374273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C49A67BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C311B22760
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C411E6DC2;
	Mon, 21 Oct 2024 12:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvHHPvks"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43281E7648
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512938; cv=none; b=PqNN3q93pDMZQ1CtVfCDzjU7PUdXvBuSnh/7CmQXvDg6lUXAzvFG1VNcvyMEPZ97t2EsTG/h+ZMdPQrzs2O47H6mGwQzofBq0YNLKqXdhuJ2cDOgAqDVsTnDb9X85DkC6mWGHt0jSyihqhljlVKdGxvL16pEQ+LpjU5HQwMEDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512938; c=relaxed/simple;
	bh=ubniCwvujlyUXuESJ+QlEf9nz56jGqzEaECw2Ab5mVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX4EwPU6cif/A7PuRUDsnTwbvmO1VecQKSqd+by7STmVRBfm2hLiVPMiMWd+NEwAqF4bw6ceZlfew7YqyFHy7pTshKhXvbb3z3DKs/JBw7TLcAHpdOFr4bP1FJ89zXUTcSmT0+B9wn9vgjQPMxuY3w9KwlN8EUosvs+t1a8ub/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvHHPvks; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso59375801fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729512935; x=1730117735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixvYPjSjHOI3A6bs62BEm+orBMViEbYtWgKUxWp9vmA=;
        b=rvHHPvkses1XqI9p3HHt+k8MomBAw29aI7JFnxRYtF3CcPzOf82nPnwY8v6ikZLZ20
         vh9xG2kNM0YDJC/6pgW00qjYxc0oVGQihSwljavjDX2YxNV3yeBlKHKpVTBtCxQrT0Vr
         K1PqW73E7ryxMH6KgMSGuNgCAldxjCZjnP9GzDL8pV1Cn0M0Tdkszu8n8o8PK8t/2QbY
         4X3RspUfVdMsqS16GQ/LM4f/Sk+nFEejVi1DQtHLixbvCj4TJfctWpICTcebFEHYWHO9
         XF1ABahq3A/0nlvMl3YhfUv7d9QL8ejPilJgZjmxkAw3KWTu3EcQjrdjSC/NCWiu87Vf
         2F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512935; x=1730117735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixvYPjSjHOI3A6bs62BEm+orBMViEbYtWgKUxWp9vmA=;
        b=qDqOejx9WPhXuTdyIbEKBz0UYOJJ1Q20j+FhuUG/J7aYLoYDqBSKa358jwARqY9MHR
         C9ej3PoF8qwmMZmXyOhVjN0wTvf1zaKMjJdcWttym/OWCWbkADr8HazGJf9UAxkHprpj
         b1Vjwfw/vc7hj7OmOFYvDZEqjOPtsB1NIMPo+skCMiyxpN5lz04y98LJNLrMxG3mdPDB
         xCtf8zZyu0i6cAuCW2UQ4shW5PyVGT/wk6MqxofOpHfNKf0eM0f+xhflt3Y907yfkJqw
         VVPdn/CtVx7OVg5fP2H27cl+egRSjD84ZJph5rmwKuNVg3RwgzcOX0Nisot87yvMzK6A
         MZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtLwfL3KCrTdoplB/bPxKtNR6hH1LqMIKHzBbrW+Az8jnaMH4IBztWp5sEcJ2K8p7yNjoiG5ajJTgcs1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHw44ppsliO3Oa935JjWejXN4FZZqI0pS45gwPYiN3E+ov+wvu
	QjoxBnrPrKMIr6JlqosTFON4dups6K6P7kQKU0Cih+OGt4hWUlogwq4XQIK6YF52g4EXkVEcogb
	AqX0=
X-Google-Smtp-Source: AGHT+IEkcKoatMCDEuy5jqS04CW2sFmKYlfJWSMdE2NyRaxseViNDhyaFOJIPHQ/mBlzZ4JfzX+iAA==
X-Received: by 2002:a05:651c:2124:b0:2fa:d7ea:a219 with SMTP id 38308e7fff4ca-2fb8320f101mr78774851fa.37.1729512934612;
        Mon, 21 Oct 2024 05:15:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad60d95sm4785161fa.33.2024.10.21.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:15:33 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:15:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quic_jesszhan@quicinc.com, 
	mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org, 
	sakari.ailus@linux.intel.com, hverkuil@xs4all.nl, tomi.valkeinen@ideasonboard.com, 
	quic_bjorande@quicinc.com, geert+renesas@glider.be, arnd@arndb.de, nfraprado@collabora.com, 
	thierry.reding@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com, sam@ravnborg.org, 
	marex@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v3 06/15] drm: of: Add
 drm_of_lvds_get_dual_link_pixel_order_sink()
Message-ID: <zaraulehid255ij3hs7hazd463ye4l5ju6sguoos243kda6552@lztoq22vzqyk>
References: <20241021064446.263619-1-victor.liu@nxp.com>
 <20241021064446.263619-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021064446.263619-7-victor.liu@nxp.com>

On Mon, Oct 21, 2024 at 02:44:37PM +0800, Liu Ying wrote:
> drm_of_lvds_get_dual_link_pixel_order() gets LVDS dual-link source pixel
> order.  Similar to it, add it's counterpart function
> drm_of_lvds_get_dual_link_pixel_order_sink() to get LVDS dual-link sink
> pixel order.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3:
> * New patch.  (Dmitry)
> 
>  drivers/gpu/drm/drm_of.c | 76 ++++++++++++++++++++++++++++++++++------
>  include/drm/drm_of.h     |  9 +++++
>  2 files changed, 74 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

