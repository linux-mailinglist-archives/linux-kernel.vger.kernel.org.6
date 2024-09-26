Return-Path: <linux-kernel+bounces-341120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FF987B88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF601F23CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07451B0109;
	Thu, 26 Sep 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYVtrQO3"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E4282FA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392446; cv=none; b=Ex8Kgjzm0NwFtqeTOS5nn/hyWoXt2aZ9qGNZG5TrjkGUOj+Zwru15/KO3PHydPzfsDdSJnrK6Ti52ISHQV7TZCJq7cg/BzAc0WsexD8FSKifJ/B9HOQhpReqwzZzJw3dHKgzLkPE8ruKgoGGZsQQ4RoBCfWhYh/m4lB4ysaZsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392446; c=relaxed/simple;
	bh=gvwcqXnMCj4t203l/VZ0Q5iLXQ+OUfQtfhIjf5MmcSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWGBPosK0wIqv9gyfdDimjL1E8Tk60Y2scEBbo6Z5ZwSeBE/SfKluQ3aVJqNLqinXyLtP/5OHSYqwR+PUo4o7ZVfEFcLGJ6yalS0HcD2txxyvNkL35Gr1QAmSd6IvRinjrYhGpiVYkV2cXFrVUoRMftH4/GlUyw930exSmdUIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYVtrQO3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so19069491fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727392442; x=1727997242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKCPXT2SnF217fYCBqO7kVOCMlyaVhnwZH7kFGVlu+A=;
        b=LYVtrQO3CrYRYnIMESPFiik0+GJSZ5Hv2nJWeLZkiFHchQe+tUqbkOO3eLBNtCLd8j
         ti3P/9fMPC7HBq2uGlyoHdaGUq4Nrpk1voyFfYpEkklp6v4VsakWYykoGrhGoG3a4u75
         RaM/n9mEQiNXhpR/RP4LftJGi1i2DYVsLw0QuhgvxhfpI56AXmjAUdeExde823R5kbUq
         BA0h3/d7lcO2eVz4iFRX37/Sw4wBwzgHScwReN0V9v3zOP3cE7NSOwOjzurOBl7naadr
         t9xoVzDNMcQAvWAAoaiHMu5bnXdOgT6cBZ2oKrjcV7ab+RbVtSz7ZZuw3mnSGwya4Oft
         NSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727392442; x=1727997242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKCPXT2SnF217fYCBqO7kVOCMlyaVhnwZH7kFGVlu+A=;
        b=kMlxOb/N4BG8vXRw0mvKT/T1Zg/grsHXSOE60Ft4u3845nAW6gX0OfFI+5sIMyE5kd
         F9dK9WQdGVJhMJl2Pct6RI5JtUPgNzNXc+U4G5JE8ohNKHWGvB1xFwcGdcMvgbWmof48
         DJIibs9JiVx59mdPCezQ58IhmlvtcG1aKnyQNTz2GOFxzz1aDVEGPKtST7BqK8Ep3q0O
         voQFYTetdyyQC8H58fMvwFfMx6t44zxKww3KI0Nl2rqTqGxmiLxRBDRLtczqCh9F5vq/
         EDG9wRwcIZQQH7q8qtM3IcvNksq0iN3HLc0PXumghFBnAd3cKWmp5LSbhsEh/Fsloh2o
         MhiA==
X-Forwarded-Encrypted: i=1; AJvYcCUmfclsUvCN+4WKvqxinyVYZPn3D24LgagJ41L0y0Fx0OPKMUwFArmhFozdZ3mqMSr907Xlfzk5J2idC9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRbPh570UM1y9j0b56mOd/NsRluTfB/36db/6rb6rCgCKJW6E
	a2lrcPCjpTMVs8t94gbPx8ARuVWRvVYgZcLz5YVrHDAIyzkIjpLFJS6/SXLW+dyH7YHyFDZpO2d
	xE4D7Dw==
X-Google-Smtp-Source: AGHT+IFwhlaM9nlI09IsLi+bYAjxYj9r1eOayb5QFxDr4jeBDHgkFOZ8axxQRpGJIerqpsmZEWNF+A==
X-Received: by 2002:a05:651c:b28:b0:2f7:5914:c22e with SMTP id 38308e7fff4ca-2f9d3e3a30fmr8055681fa.6.1727392441976;
        Thu, 26 Sep 2024 16:14:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d4618a80sm949261fa.107.2024.09.26.16.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:14:00 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:13:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Message-ID: <ovzeljss5uv6rymlbdfjolnjox3dklcv3v2km73gqnh6vejxvg@afhyhfwmt3nf>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
 <20240926055552.1632448-2-alexander.stein@ew.tq-group.com>
 <tosilxaxfg6hejtqs2fslf6ez5pdg5yxj776pohmodja3bn5jp@4jbdprx52fqx>
 <2754373.mvXUDI8C0e@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2754373.mvXUDI8C0e@steina-w>

On Thu, Sep 26, 2024 at 04:09:03PM GMT, Alexander Stein wrote:
> Hi Dmitry,
> 
> Am Donnerstag, 26. September 2024, 08:05:56 CEST schrieb Dmitry Baryshkov:
> > On Thu, Sep 26, 2024 at 07:55:51AM GMT, Alexander Stein wrote:
> > > From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > > 
> > > The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> > > registers, or the access will hang. For simplicity, the PIXCLK is enabled
> > > unconditionally, resulting in increased power consumption.
> > 
> > By this description it looks like a fix. What is the first broken
> > commit? It needs to be mentioned in the Fixes: tag. Or is it hat
> > existing devices have been enabling SCFG in some other way?
> 
> We discussed this internally and it seems this never worked, unless PIXCLK
> was already enabled in SCFG by a different way, e.g. firmware, etc.

My bet was on the firmware, but I never touched Layerscape platforms.
Anyway,

Fixes: 109eee2f2a18 ("drm/layerscape: Add Freescale DCU DRM driver")
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Best regards,
> Alexander
> 
> > > 
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > Changes in v2:
> > > * Add note about power consumption in commit message
> > > * Add note about power consumption in comment
> > > * Fix alignment
> > > 
> > 
> > 
> 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
> 
> 

-- 
With best wishes
Dmitry

