Return-Path: <linux-kernel+bounces-318880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BD96F48F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3EAB2259C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B611CDA31;
	Fri,  6 Sep 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXLYXcdw"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6B1CCEEA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626821; cv=none; b=qjarQlryXbov3E01YIGC74fGaTbFpYjL7HmZfblwD3LSNJCKwvRQbJ2tt6xRfUEAvdFXBboNF+tpfeLRXle6kSK1G2Wq0rfvAF4lx0zYjpTP3yTTizpeJJcZPkeNk856a/FokVjpGHLiYt8pS82TZmnT9L67UVyS6S2BoyJ4jgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626821; c=relaxed/simple;
	bh=7FXIhim4R/YZPrjdlDaGzgsy4ddzF6N81eaOgtlPPiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnqHMWvgrr4K1wKKRICzBz0l339HZDgITaq80JOO41UahfsIiwfXD+6pi/0UkHA7ExbueqebAgIUKsQ1xgDnLC9O3T+fCWPFqSt5SmbohTehO76Ekqy57Ui5R7inUPA5p51Tqcd5BLog3xACAPNMH9IyZvZezcMLD77NCY1jFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXLYXcdw; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f66423686bso17799831fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725626818; x=1726231618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCDROLtzQl9/e9E1lQx5QL5Q8ysDiREUAFeTrp/CYIE=;
        b=vXLYXcdwyJeI6NzaPpvDEAbjSfGQ69jKPmvyEpD4K2r9LzkJ3wto367mf7aOjmPm2d
         mKTCf7DDu0gDcV3Z4dhfE0iOo/muFNA9QtWyUlyhosgM0iEaOppt4nLnliMJCmnbK4Is
         8IvvVhLAsJq4yMmhowkgiO3iUSAv2seeqZtX+1QmT2B79qsGp3J2PDuFy2qPOPY+GQuD
         pKt/rTUi51vzbSIwwzNwApqu72MqNyNOE6jwKbtpKjksxFR13LrQx1D0Xj834G/8Fw3r
         J6JeFQSYzQq96GxSJCSzpWT5vvUtYfpSMoK8WZQeS07KGofbn9g0qv5bbnc2LGZWOkHX
         unrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626818; x=1726231618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCDROLtzQl9/e9E1lQx5QL5Q8ysDiREUAFeTrp/CYIE=;
        b=r2mBZMhf4WpxERNV2tsSOm59pSkPFTDRweGJiNmQPS9/MYzYjWCbCK7/j3gw5azYXz
         a+xz6+kDbyRWKpIbDr9jWA+p7839vCRQi2LbhTKc4kw2ST4OB/rKQLovZVAnn2hB4GKA
         smezSZO+L/lcDFNiKDZJYSC4q7I2x+fLCndR8KYcNliOWcfpCtQ7ACbHxk6EOyOZIVM5
         QdYizTK9FrYu45b4132CjHHoy8IurYcacDrU0GPRDNnPekP9Z7iDjKaNbxWkleWGf71r
         3Y5STFTL8WzFxBZa7UWRJDQQQgRlj8oE4CaDxCjbeCIZ1PyefsgIqQKSznf44BbEEzvX
         I1SA==
X-Forwarded-Encrypted: i=1; AJvYcCUDRIHjhXYzpWECrEJlPZC8uAyQmadmr8NP9uiNdR6HiCvQbaiISyxcU2by8SHUhBMI7WlYaZTJZpM0Wdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkpggv1WpvscKSghJRRed4Bi7p9jthDF0SFBvf0U7+4aW5h3fz
	xhNSysIgickSpxlFgdyMI5R4ajEr/1EkLkrGJFFosDwtzpEy3jcKYdDMzT3b2Oc=
X-Google-Smtp-Source: AGHT+IHdP6sVKOBLWAcV7i0DQrC/I56I/bOZ1oLFyOUUNnoZRvRmqzwYIqtPFBQ78Alx6bgpM5C6ZQ==
X-Received: by 2002:a2e:6102:0:b0:2f6:2b51:ee3e with SMTP id 38308e7fff4ca-2f751f82e6fmr15284681fa.41.1725626817484;
        Fri, 06 Sep 2024 05:46:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f38760sm29752311fa.60.2024.09.06.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:46:57 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
Message-ID: <cijdgivv2h57vwwpi7m5inl3atc2yryu4orrgxce52tguxiodp@aargw4zfdadg>
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
 <CAA8EJpoz7jtjN-Dxq-6SHNiZCz2xsFFf5j4HOoFiLAq=OnHn6Q@mail.gmail.com>
 <c4e1da1d2f005e22f74eb2461382fd4666dedd4f.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e1da1d2f005e22f74eb2461382fd4666dedd4f.camel@pengutronix.de>

On Fri, Sep 06, 2024 at 01:46:43PM GMT, Philipp Zabel wrote:
> On Fr, 2024-09-06 at 14:35 +0300, Dmitry Baryshkov wrote:
> > On Fri, 6 Sept 2024 at 09:39, Alexander Stein
> > <alexander.stein@ew.tq-group.com> wrote:
> > > 
> > > When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
> > > users were updated. Add missing Kconfig selections.
> > > 
> > > Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >  drivers/gpu/drm/imx/ipuv3/Kconfig | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > I'll update it to drm-misc-next if nobody objects within a few hours
> 
> drm-misc-fixes? drm-misc-next doesn't contain 9da7ec9b19d8 yet.

Heh. And on drm-misc-fixes the IPUv3 doesn't use drm_bridge_connector.
So the issue is only present if both branches are merged.

-- 
With best wishes
Dmitry

