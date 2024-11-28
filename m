Return-Path: <linux-kernel+bounces-424790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B919DB97A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E32281B20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE71ADFF5;
	Thu, 28 Nov 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQFereLR"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F319CC2E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803515; cv=none; b=h1zSn+NAT39JBAumnUxKqIjBisD5yYxc/gJF7hicA2y1Vt8ngYMkySSMZDr+et//Iyv5Nh0dcfSRbWvnKjUFn3F4LfzYfPigsqY3pe+Ie809XWqSCdH6IAwROlEzrNeJRS5AhyJmxfo6t0eEeDJbXAajy6D10FsCp+Pea4ZNs7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803515; c=relaxed/simple;
	bh=dcwb9b33KIM/BSPqPVuj+rX/P95ylrOXU+LmT00E+2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiQnoXWZmvOXxApWP3tV8x4PrIX++c68asn7DHGIDMkjbfIdg2wlgUauI1oj5lquEGhe3wsQT3Cg+EqqyF3aAO2okReiYq25Y8WAz14VGydLiZV9Cjl4YYAO51nkWuj220drWzIhDFUl/8EDhAo50GedHsT1s45UnqUhihojKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQFereLR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffe28c12bdso4997821fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732803512; x=1733408312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA8QccDB7jDinpTszrKQcVtNkmKlzXFjmJDa5bO0Mmg=;
        b=yQFereLRqx3TUmAloybv5y6exMM6SDvOqnquGmqoBgI6GLSNyIV70fM1PKgfghZNYZ
         0f0gkMjAsAtr1vGNXiQ6CnL9bAbrozgXcWP3sk8ixh/xlzeGkWHfqVxA7O01oWBUVZI1
         euF6nW46XQwM/tH7jbqmWnwpzU2B06/Hu90rEuwurrveR92hZ7FQn9HvHeVfQ9zF+n0U
         NA7zzAstEpkTl37uAz60DsN7joembZ5ey/v5OKVRrfa48kPwPvlnSN/fz1gVOb++GK4g
         93dLOJySW4m5dJNTiS2Wvn1XtNiHjSBJiGiC58v2QbyCwJ3QWnptpwe/x4XXBWpXVzWZ
         1p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803512; x=1733408312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA8QccDB7jDinpTszrKQcVtNkmKlzXFjmJDa5bO0Mmg=;
        b=FAI9Bx7rTMTbUOgcyp4t3L2vSojlvbyCWcCOZfmUQBLQV4JTo5FIil4ges0vnTNduB
         11h7MKNGhOOL8FqyDe21Y+cJPXxY1zdYWpptzjz6rx998AqnfX7fwZvHHhmgTVVmV3aw
         oC4eB28lVwWi2LPLmrLA7s9Mh5A5qJtisQKTeQzu0fX7acX4kMhX6AyxHBW0hG94xzfc
         0rWHXvH0ELQdVsGrhmpqFYPBywiA8rBJvlVCCFghr2GdbjmsUljHDK5ROcGqFD4XjFYz
         +rzqAMSv02rU4oxlZ14uYz+ogiXxebkrHLhhDSHdsxFQ8aSscsfbh6vW/4XoWrXRuMq3
         d4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVetPY07eqf0JEduQ2aGJ2CyOoB/CiD36laOXKi0X4o1UMOJZaIVLq27Y7/osu0egOB6d+664xVJivsUQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86ZnB182kRrYgmi0c29JBNfCbT6NmorKq8JGVOjY2hAPmn1HD
	RxR0za4Ua4O9vUVo9frBQXW3u1ycgYImp8156FVWPYUpRfKDkpl69tneit0CcLY=
X-Gm-Gg: ASbGncsQajYAx+sZVZswOD6BJdPC/OsMtGcUgsyacMPOhmJkBuHx18U/VxmZnyTrMOu
	e/kZ5PAr2Z4tC8viIpwmBq1Zsue2nlVUsYuxtfLzlYxn0Qm1ZSncTHO/gjQtf67micEeKPuLrpT
	VN13tXkL4TPGXeYPc0rL/MNqL6QkyAgEsE1bBtGFuIR4/gMD4hSaoxT0B5yTPers39v7+XQh/Ep
	TXaetmQvFRkrflCydEtX0w+V9NLU9SEH/KR/mNoFLcoT+GLDEQ8h9Ai3+dacGeM87oZHcaDrIPw
	TpC2ue4kytFkmKyy2JUBZlcdBofnUg==
X-Google-Smtp-Source: AGHT+IEWrfuUcnXV1iqJHqdNEOSGIK8M6/LbygKUp+v7qqACcol4zNxR8qGEVUdI0pmwpuF4EUOzaA==
X-Received: by 2002:a05:651c:887:b0:2fb:8920:99c6 with SMTP id 38308e7fff4ca-2ffd604fc7fmr46439611fa.23.1732803512212;
        Thu, 28 Nov 2024 06:18:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc75452sm2022861fa.85.2024.11.28.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:18:30 -0800 (PST)
Date: Thu, 28 Nov 2024 16:18:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, glx@linutronix.de, vkoul@kernel.org, kishon@kernel.org, 
	aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, frank.li@nxp.com
Subject: Re: [v4,09/19] drm/imx: Add i.MX8qxp Display Controller display
 engine
Message-ID: <kixewphwyawbyrfu6pxtqx5fywqmq7ms2sa5j5pzogetmebcjz@ouhpohk7twbc>
References: <20241125093316.2357162-10-victor.liu@nxp.com>
 <c4334c9b-833b-4923-8188-64d662231512@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4334c9b-833b-4923-8188-64d662231512@linux.dev>

On Thu, Nov 28, 2024 at 04:46:53PM +0800, Sui Jingfeng wrote:
> Hi,
> 
> On 2024/11/25 17:33, Liu Ying wrote:
> > i.MX8qxp Display Controller display engine consists of all processing
> > units that operate in a display clock domain.  Add minimal feature
> > support with FrameGen and TCon so that the engine can output display
> > timings.  The display engine driver as a master binds FrameGen and
> > TCon drivers as components.  While at it, the display engine driver
> > is a component to be bound with the upcoming DRM driver.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v4:
> > * Use regmap to define register map for all registers. (Dmitry)
> > * Use regmap APIs to access registers. (Dmitry)
> > * Inline some small functions. (Dmitry)
> 
> 
> Why?
> 
> Its seems that the switch to regmap APIs is not very necessary,
> as ioremap/writel/readl are simple enough and easier to use.
> 
> Isn't that this just introduce an intermediate layer? It's okay
> for display bridges/panels that behind I2C bus or SPI bus. But
> then, why drm/msm still haven't be converted to use the regmap
> APIs ?
> 
> Just a few questions, has no opinions to your patch.

Please respond to the original review comment. Then we might be able to
discuss if the suggested change was logical or not. Discussing changelog
doesn't make sense becasue there is no context here.

-- 
With best wishes
Dmitry

