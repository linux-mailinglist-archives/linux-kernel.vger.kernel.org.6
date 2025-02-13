Return-Path: <linux-kernel+bounces-512182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FDA33555
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78734167D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120C145348;
	Thu, 13 Feb 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Imu3VH3z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BEBA2D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412745; cv=none; b=B7/Dl/mdFi4kQ0oBtL/9OyftXQ4CfBA2g1cqYgm1dWxr2uG3CSst/Hua/o/s8ugedHBBfeOA8F/hu3z0+KjQALfjGqLTZ793QNWqoIFmkOi8Qu0FGKeF4sc34hZOhMzsSi1zRUvImDdRNr5TsbIa/TFKARFUtmP55eS2VhEVDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412745; c=relaxed/simple;
	bh=cvHp+RXCNnfQ5pSkm40nIlTWS/juErivtSgnfKyo1II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf1bRe/T3pA/nvL8sVdrLzN6wfgib9MxBGh5EzJqA6IXcdkeqPLstjiGytJpemYiTeq1BYMhrPcg7MDGDCyOKdBKrmA8w89UrTCzswgag+nkh0CQ5uJTa+vJyUXGtZXpqL+SMEaq5kmul1QGizFbQKagz/daVbFDlxmuzkzB/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Imu3VH3z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308e92c3779so15424281fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739412742; x=1740017542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw/9a5A6LvNevv/YEo/GWDHEhu1/e1Me0h9UeanBldo=;
        b=Imu3VH3zxaIplkIC2KHqzi3idv4cdAxe+xwE28rpg6tbnVJqsXmOMoFVAZPC5aOssN
         upjLK2snr5AugBbjENKUdkXlg626unnYeYzPtO2npSzV5dk7aoh0558lUvxVUlxdgwBj
         EqzMHRLHubz2A7oFnBIeO7EQTnF45eR/iCmPNxNjZ9dp09TXufHRpn549eqKH0C04J7n
         KQaMng3/OhOFgRefFvKPM5oJV1waEH9Pyq28QwjzbGx3t31b7wN+aR/GPCsvfcqHUnzb
         y//qoaxcBVEcKnb9Eb6lZb8CNL7bM93rAequoJOmpV+hhyt5viceYWC/1k6AXcsnhPGu
         q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412742; x=1740017542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rw/9a5A6LvNevv/YEo/GWDHEhu1/e1Me0h9UeanBldo=;
        b=MawTfycDADrvLVslar36CbhWzZgZvL3Dscmv+eewIroVB64ER9gm6OjH3T8ok8rMiy
         8/815KjJAJpfVDRPRywM99lzX6SOHwJOhk3xZxHD65tWTkmx19JamLDJqp4MIgLTXl2e
         vP6jYqoPWCfiQb7lue5YLQxtQ9NomKCZBV20HxGollxk81zkQtHIsKzuIq1CKEHT6fet
         OpPGQ9APVL7/OnUXaOE1HF9PtpoC85NBtdBvMMX8zoivzcJ677OFTc2g5WwHjZI84Y7y
         mXy4h6/7KjSHnT4uLa9drjivThYXMcW4FSWJLrm8oDcidSrwaJb4FDD6HmH2htqgNA9i
         3mIw==
X-Forwarded-Encrypted: i=1; AJvYcCWz6EcXkxhPv2xjIrekxAeJCifNLlpEDLUqRrUPpAC0YPQCwI5bPH41jBSGKlj8efYT2epFKc3+9zYCu4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZLJaNYWIaj5gG4zA7YRZmTkF+ke2MjJhNAx7z4J2OWAYDKAW
	b79O+dST3gfNHFGReAX3FNE8lc2h5+VIWbebof6mfUUjRH1zvDvY9ZipceTQ1fw=
X-Gm-Gg: ASbGnctE5Wx2GisZBKJrMiYcbyShS0K1cAjBex/2uvSzHMA1mymqwK1e1b2PAEPwblL
	czyEGFTzeo69+xvvgwyRm1O4UYaFjNUdg5wNVgQcWuBIz0vSlnVfP3DnSABF0DDL37hoc4nQH2s
	bWSlSwmnj1tUIdWzr7vBns8Wp6kQFPdbeVffh0tzD0UbgpQ+f7unJcw84CbCkX8MlvNfhUXc+kR
	oWd1Wl/G0iedjM1/WP2OqKsuLRKCdHyrMGntLrTkX+gjB6up8xapeB3hTPu2SRaIwg7gvqIJr7q
	rJ/35/8pNyYqZGGJ2EDSedPDUhwXgsTDn21C/bxjA5XzVgSZLGWwvcnqhWDFKiJA8omm2V4=
X-Google-Smtp-Source: AGHT+IGQtYrcLDc/I8anHaIYxUqEHWkHLWFBsjN/VO65ZVcW4zr73ZK5nrBsOA74X0CKYm6L1Ss1LA==
X-Received: by 2002:a05:6512:2101:b0:545:c08:e18b with SMTP id 2adb3069b0e04-5451e4f0832mr295754e87.9.1739412741686;
        Wed, 12 Feb 2025 18:12:21 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09b3c1sm32980e87.76.2025.02.12.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:12:20 -0800 (PST)
Date: Thu, 13 Feb 2025 04:12:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm: drop i2c subdir from Makefile
Message-ID: <twu3yewyuj7e27jiboqrcjsmxwccyzrhmvvp7qmy3dunewrzfs@nsjiuiih23g2>
References: <20250213-fix-tda-v1-1-d3d34b2dc907@linaro.org>
 <Z61IS+WVVi049Dp5@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z61IS+WVVi049Dp5@lstrano-desk.jf.intel.com>

On Wed, Feb 12, 2025 at 05:18:03PM -0800, Matthew Brost wrote:
> On Thu, Feb 13, 2025 at 02:49:41AM +0200, Dmitry Baryshkov wrote:
> > The commit 325ba852d148 ("drm/i2c: move TDA998x driver under
> > drivers/gpu/drm/bridge") deleted the drivers/gpu/drm/i2c/ subdir, but
> > didn't update upper level Makefile. Drop corresponding line to fix build
> > issues.
> > 
> > Fixes: 325ba852d148 ("drm/i2c: move TDA998x driver under drivers/gpu/drm/bridge")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/dri-devel/20250213113841.7645b74c@canb.auug.org.au
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Our CI caught this too. Thanks for the quick fix.

Thanks for the quick review!

> 
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

-- 
With best wishes
Dmitry

