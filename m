Return-Path: <linux-kernel+bounces-446419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F89F2425
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B030516078E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E37189F43;
	Sun, 15 Dec 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0Ct/DSo"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD814BFA2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268378; cv=none; b=ehJPNXynnUqr/JI0NG0woPWD14sve4I4yMOpXezS0esg/iQG6YhSCLN18krKPpoD9muoLpBI/jh3+g+k2zVf6B6YPuJA79+ashoDXMtkiewkM9JVnM7UPZWkO95bda9tn8oHG5CEvIdT4aUVZgbJ4e/BMiUOotHf/zrdq/x0RiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268378; c=relaxed/simple;
	bh=eZT/H3AkHd+2JMU9XZD0Hhkg19i7yVqKRY4c+1b9PoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwIM4/dwheiaMEQrPFBnXO2PjDsQ03uNUdTFdoZa1htiCt6fYQU+cO8goDHyd55fKL/1YOIF+tbypFGcBvmeoIZ4KGqTpi92YF6ihVTLcHmuSHHDs7kz7S4o/jGL5bB002Q+MD32V+ERjGwMMBud3gwDBWzTDsAj3UdGAbZXH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0Ct/DSo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so3486307e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734268375; x=1734873175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buehLmGwnFS3OEkRMAySuSf7R4pwRpR3p0736Fbhkb4=;
        b=O0Ct/DSoQTz5/mfrFjvcEJVwbASN15Sm1/PYQdDqVgB4NieF0HKt+Qotm0RG7l/7ya
         ETXUZYrfX5zzzQnfcs+PTdlLWWRnXqpIzdtkk2RDSEIxQvOzQR8JD+q4P7upRksfzmqh
         TLdkcNG+ewlWeR4NwYlXJC90ShH5vejDWcvRVBicTtiEjcjTNcDI7WiktF73/nEPrvpW
         YBCmAqOLGmzjw8ervODN+/m22o3/KMqLNfoedyNeMa4Rmtz+eNRbMsL/73LoRPdTSQJi
         edYL55cvngrawmDK5OO9/FTrHFY+pKMk1MvEF5fAIyR7J++rNB2nW9QfNAVPyz4Oy1eU
         bGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268375; x=1734873175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buehLmGwnFS3OEkRMAySuSf7R4pwRpR3p0736Fbhkb4=;
        b=F220/0NBpeUetsFrJfz2xYZWZRJuQRhjeFlxTZ7Z02g/BZApM1WEbmLwG3izHXDpFd
         LNgW5UMhRSTw6doDFcMbwkM9ab5qTcK8qxojSM9RtwdWcznRr+vEBak9RM9phtkgSi67
         RqE5PfHgG0kYtLh/MT0FBFOP2fvwtCtn0ZKkaxQmimyVMGusAXgVF8MrzBj754IwNPTC
         T/sLC8TmcmV3LlNdJHph71WwWoKLMwaKxG3+gv8uc7x723/goZSFaHaISTFDtEY6MY+0
         YW7Qq3qbEbshoFev6HDRgaqZonanRIBhfeFF1PvUfSETOCBRUIp7i4gAxi2KtJZ7TXir
         0EOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+nuDDhg97mzdkCtccveMZnmj8MG1OpmFS35EtnvgMOgF2oBgUDhqjHD4mLAsTYF3by+HFsNMqWXdBqR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8EMfc9pJbRJVIn2H1DJsprIYwtZCL8xnHqtl4eJ66UBe76/r
	3gD2WovZkq9DBEZlQz87cWVzdJSVkIRt7OyqoG24dGYoNqVWbVcJ1YXWWydST0o=
X-Gm-Gg: ASbGncvD++numm2QNFRJErfjIYh5PMeWM4uOD4ghvih5shOjIcH3I12eut7CeJVKa4Z
	TnbBmGP5lH+6crTU7cUXcZzfl8/a4Rp3i38VhivgDXa4QEpBvTNzTQDiHSTNLryGykRmcXO9Eci
	D6lmbDRNQnCNeuho4Dekxg1nOitg1MXkGS74cwH+EcM+GtM3q0efOT6ZAeLGfexdhNktkS6eErk
	X5jZUYATOfhjTBPx0ysWoF5TD/L7h8tshkxp8lRXiqOsiClyEiB8sOrJvtZEMx2OIQxadyryB/Q
	49XZ3NldPHYksLWO3L3V+JFj1OBHxWTl62zg
X-Google-Smtp-Source: AGHT+IE5nPGTX/q1n9o9XkE8kqPf6xHzAi85QGGVhuxA9aSG4CES2IXluTi/4Tyi13PULwO/mLcgrQ==
X-Received: by 2002:a05:6512:3dac:b0:540:1d58:da75 with SMTP id 2adb3069b0e04-54090553c90mr2447568e87.14.1734268374981;
        Sun, 15 Dec 2024 05:12:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13d69sm497511e87.217.2024.12.15.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 05:12:53 -0800 (PST)
Date: Sun, 15 Dec 2024 15:12:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/i2c: move TDA drivers under
 drivers/gpu/drm/bridge
Message-ID: <opsai3edlx4cyt3vi3h2pjakh6yqozca7xl6ytseczkrgwbbxh@vyhz7i4yec6d>
References: <20241215-drm-move-tda998x-v1-0-7817122b1d73@linaro.org>
 <20241215-drm-move-tda998x-v1-2-7817122b1d73@linaro.org>
 <20241215123805.GB25852@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215123805.GB25852@pendragon.ideasonboard.com>

On Sun, Dec 15, 2024 at 02:38:05PM +0200, Laurent Pinchart wrote:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Sun, Dec 15, 2024 at 01:09:08PM +0200, Dmitry Baryshkov wrote:
> > TDA998x is the HDMI bridge driver, incorporating drm_connector and
> > optional drm_encoder (created via the component bind API by the TICLDC
> > and HDLCD drivers). Thus it should be residing together with the other
> > DRM bridge drivers under drivers/gpu/drm/bridge/.
> > 
> > TDA9950 is an I2C-CEC translator, being present on-die on the TDA9989
> > and TDA19989 chips, so it is being instantiated by the TDA998x driver.
> > Move it together with the TDA998x under bridge drivers subdir.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  MAINTAINERS                                       |  2 +-
> >  drivers/gpu/drm/arm/Kconfig                       |  1 +
> >  drivers/gpu/drm/bridge/Kconfig                    |  2 ++
> >  drivers/gpu/drm/bridge/Makefile                   |  1 +
> >  drivers/gpu/drm/bridge/tda/Kconfig                | 13 +++++++++++++
> >  drivers/gpu/drm/bridge/tda/Makefile               |  4 ++++
> >  drivers/gpu/drm/{i2c => bridge/tda}/tda9950.c     |  0
> >  drivers/gpu/drm/{i2c => bridge/tda}/tda998x_drv.c |  0
> 
> I probably wouldn't have created a tda/ subdirectory in bridge/, but I
> don't mind much either way.

I created it mostly because tda9950 isn't a bridge. It's a CEC driver
that works in pair with the tda998x driver.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
With best wishes
Dmitry

