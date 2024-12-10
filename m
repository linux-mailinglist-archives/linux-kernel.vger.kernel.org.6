Return-Path: <linux-kernel+bounces-439547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE49EB0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4694188C22B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019911A0BE3;
	Tue, 10 Dec 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEiBAkM7"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761719CD13
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833931; cv=none; b=mI9xqQK6QdmY6yB6uf99iHehbbvxGe15QRbiczWc0aYJA9R5+JDVJuFAZZZk0MRqGExqfUTOYqgcpNaqEhdUme1H9fOtJnWxR0Tpc7+6/1iQj1NxuTUh1RisRB1uSHTbazoOokztSwH7aIJQpRzUJ7qNn1zFDZtVNAOI/MKc13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833931; c=relaxed/simple;
	bh=bjSL/+T3XO6+BiIfn0dnykcmizt4Xk3G++g8TSzDjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTokKxWD3P86KiXPECZrRKd5Z8jTj1H1+FonUZzPOBksU7oqAAXCAXRrS0m84sfV078TX1NTHLcxZLKWpV6iUC9q7VisJiBow/NgfDfi/9UvDy2LZdGqe3LnJjc0wI4RjmPVFAf4SROa2wGsZbtEUWL4QP9m+/3KcHNLwxbv9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEiBAkM7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3022598e213so17998231fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733833927; x=1734438727; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xFyd1PgF3D2/xwv+F2WOR3tO3r6sjTbGoWT6Q3TM8dg=;
        b=GEiBAkM7bUignmQ/a/2tUcXAeAjMlluUsbkg2Zr/PSUZpfdJowe+qtuAquXsJ24YL+
         cwqz7aL0Dxp8/uLS+oFsDF4n8AZbB9hnChRkGsHbzMbFgJZLE7Va5xF80gj1JmqkQ3qs
         U126E7KpapBGj4/adr8SVxU1WNSmbbwa+cNvoaDA1Qd0iLFbUDcccaTLJmBOHgOf6D6T
         0n/vidFlY3aoTynbJ5u1aA1PwlCLt5OjKjfWaAlcg3aF6/iIbcbLPpZz/L2Ial9qUnWZ
         ko38nILSG4ELUoZ8GO25N2LoyBw7eiuhhrhIFSmQgg+w//CoAeX8djgDPOYgEVS8R1Wa
         VrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833927; x=1734438727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFyd1PgF3D2/xwv+F2WOR3tO3r6sjTbGoWT6Q3TM8dg=;
        b=ebmVz6Zg8E0Sf15cqCILMzNVqveN6ZrAVZqi39hciHBq4krNHPUf519rXxkXnivv27
         tIplWn0I+C/JJJRFGEK3lzfPEOv2f0K/Rx0wT9Dv0aIawEiOClDbm8WSga7F6XgTCl/u
         P55nu3nGwYV9Dio/BScc249JUgFknYtiixzidEqP0v2ZGtvj7vsSNMcUrrCvqcDvjxin
         3fWuVJBYauCPtf9UUHt/48QWtHYyjDfT8DCq6JkCevmkV3lDzKzAtGDX0xVXU8Pkw+v7
         szScj+0pmL2HN00ST8XABP8Nbt5fV/T3RpeXBF0jMp8RwcfgqHHH+KQBS42dT0io9dkC
         CU8A==
X-Forwarded-Encrypted: i=1; AJvYcCVYV4nIv5w6l4m+alsw6b3NFgnp6KkIXqZ92wkYFPKGchtG73uU3kKcIhQSacyApTMMP8+8fg8fmnI/C0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZsAyq+MJRYur87eP/p/jquhULdXCZXHwfrUzdxJV9RUaJVzV
	cYFa8bK4YtPQQD2cmytXRqD8b/iH4so2MAk3eEQEbApCKm5vq864r5F9ZtAHPvQ=
X-Gm-Gg: ASbGncvPezF6ZpgZ3x/0AMtmXOYeVw288nOCdvM/UETNMbI+MwJZc8kBaSXXGTJp4AG
	gkJjsKFYOJw0xuChb9+eRhJU3/r0cj3Gfd0wwtytujudab878MygFp85d6DmL/b3RJnzkkGh7Uc
	cutjbAzRPy4pDvPFYcMr9In7dE3VybzqKu6Y4z/Ag8sadsanD9m7ZeyBCtRymZhzwJYqQXypsCK
	XuNEGP/W5a7X7mgRZog6lPkYBKr9k1gUG0mCRQiLKRaPdp9PPS/2ufvtTixLbhFSrpXCV8Sdjbs
	g7V9MtR5YroQjVoi0fQDbzrp9gNvSr+/8g==
X-Google-Smtp-Source: AGHT+IFJ8BqRGzKbdRKo9sdokdyA13iJnEch3RCwabno4BEnD/wpduTivdAcQ64Maqs8TOr83ohZIw==
X-Received: by 2002:a05:651c:1582:b0:302:2620:ecc7 with SMTP id 38308e7fff4ca-3022fd82956mr14279341fa.35.1733833927539;
        Tue, 10 Dec 2024 04:32:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30216eb1013sm9110231fa.34.2024.12.10.04.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:32:06 -0800 (PST)
Date: Tue, 10 Dec 2024 14:32:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Daniel Semkowicz <dse@thaumatec.com>, Diederik de Haas <didi.debian@cknow.org>, 
	andy.yan@rock-chips.com, Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	jernej.skrabec@gmail.com, jonas@kwiboo.se, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	quentin.schulz@cherry.de, rfoss@kernel.org, robh@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2
 controller
Message-ID: <jl5obi7rd4h6ywozeqruxq2vx62sx5yf4wwpksrq3prdleps2k@d3zbr5ttquvn>
References: <20241203165450.1501219-1-heiko@sntech.de>
 <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org>
 <2203458.KiezcSG77Q@diego>
 <4e015ea9.960.193ae0c236a.Coremail.andyshrk@163.com>
 <ay5hbnqqjhopaqof6z7j2rzm2bc6xa2vbzan2ak3if6wzmyip2@kqh7gtrajnm2>
 <33e2c5db.1300.193ae284b6d.Coremail.andyshrk@163.com>
 <CAA8EJprLA09NP0KAztc5eoAMkGcrom84jg_pcbNcwN0FAaSLrw@mail.gmail.com>
 <2d68155e.1e5b.193ae4616b9.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d68155e.1e5b.193ae4616b9.Coremail.andyshrk@163.com>

On Tue, Dec 10, 2024 at 09:54:09AM +0800, Andy Yan wrote:
> 
> Hi Dmitry,
> 
> 在 2024-12-10 09:45:11，"Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> 写道：
> >On Tue, 10 Dec 2024 at 03:22, Andy Yan <andyshrk@163.com> wrote:
> >>
> >>
> >> Hi Dmitry,
> >>
> >> 在 2024-12-10 09:01:38，"Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> 写道：
> >> >On Tue, Dec 10, 2024 at 08:50:51AM +0800, Andy Yan wrote:
> >> >>
> >> >>
> >> >> Hi,
> >> >>
> >> >> At 2024-12-10 07:12:26, "Heiko Stübner" <heiko@sntech.de> wrote:
> >> >> >Am Montag, 9. Dezember 2024, 17:11:03 CET schrieb Diederik de Haas:
> >> >> >> Hi,
> >> >> >>
> >> >> >> On Mon Dec 9, 2024 at 4:06 PM CET, Daniel Semkowicz wrote:
> >> >> >> > On 03.12.24 21:54, Heiko Stuebner wrote:
> >> >> >> > > This series adds a bridge and glue driver for the DSI2 controller found
> >> >> >> > > in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.
> >> >> >> > >
> >> >> >> >
> >> >> >> > I did more tests with different LVDS displays. I tested following
> >> >> >> > configurations with DSI/LVDS bridge:
> >> >> >> > - 1024x600@60.01
> >> >> >> > - 1024x768@60.02
> >> >> >> > - 1280x800@60.07
> >> >> >> > - 1366x768@60.06
> >> >> >> >
> >> >> >> > All of them worked without issues, except 1366x768.
> >> >> >> > With this resolution, video is blurry, and offset incorrectly
> >> >> >> > to the left. There are also repeating errors on the console:
> >> >> >> >
> >> >> >> >   rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY irq err at vp3
> >> >> >> >
> >> >> >> > In correct operation with other resolutions, there is no error.
> >> >> >> > I am not sure if this is a problem in your series or rather in VOP2
> >> >> >> > driver.
> >> >> >
> >> >> >This really sounds like something is wrong on the vop side.
> >> >> >The interrupt is part of the vop, the divisable by 4 things likely too.
> >> >>
> >> >> This is a hardware limitation on vop side:
> >> >> The horizontal resolution must be 4 pixel aligned.
> >> >
> >> >Then mode_valid() and atomic_check() must reject modes that don't fit.
> >>
> >> We round down to 4 pixel aligned in mode_fixup in our bsp kernel,
> >
> >What is meant by the "bsp kernel" here? I don't see it being present
> 
> bsp kernel means downstream vendor kernel.
> 
> >in the mainline kernel. So, if the mode is unsupported, it should be
> 
> Will it be acceptable to add this round down in the mainline mode_fixup?

I think so.

> 
> >rejected.
> >
> >> because sometimes, some boards do indeed choose a screen that is not 4 pixel aligned

-- 
With best wishes
Dmitry

