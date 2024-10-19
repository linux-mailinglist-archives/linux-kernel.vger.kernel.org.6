Return-Path: <linux-kernel+bounces-372875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06679A4EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D594C1C22EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959D2CCAA;
	Sat, 19 Oct 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqzsIWoV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A202F50
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348264; cv=none; b=EIWFUZ3WxPuqgYkXx+MzhoyY1xFVaL02FfUD92B31hBBZ3c6D///qUWPrHkNkne8Tf+QWYfSY8NR+XC3dIGEeOcliAwT6mQCQEp19Yyf61chM85vVIwqYZvMX6+NOpR5jOZQpbWxJSOEHh97HXGGLCHk2xnX0wZB6xRjI5vWCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348264; c=relaxed/simple;
	bh=IRfntrIiIz6h1Ks3LqQblUU/9WIiDt33cjV14SqGcZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM1lGTAVYGB/HmmITcxtqUTWI12Lzyvxu1zDBMS3qUdZTaXD0YP9deAVdSle7XOzSVNMe0ehm5Bs6sGzGTFdOGVOoZtUodSG9dkZAsmIHn0pPfXMK4q5Oz1MPE/DAMN3dN4+s1opi78h3amGhFuuvGdJcPQd/LM/I7KXvZ3FzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PqzsIWoV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so3832777e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729348260; x=1729953060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1OZg2lit8ojUrZI5PFtcsvJA55BRZgPzGoX56nWOWU=;
        b=PqzsIWoVlJzyd1iXR5aypbqQZ+5rYTvxN/HLG6kdXk1MOLjPRg/UnYFu/MBFO0p63O
         F+cd4GJCqBkIh++Nken8hHdxXLQP0McytvWGiKR1uzdU8trF/9LPaioZmIaJO/j61vdo
         +QAB7Ao7zB/1wKSx8M8Qfyc87qtKauHzxxlmJ2ZGbICg5l5nORO4O6Woxv9CRO2mzx7E
         Z4hJE5ic3p4MzEPzoXloH2t5wZgvUUnVLLD2jl2VjQsO4NjUCVah942VIJiDpMqRBoYG
         MAA7L76rhzPIMnYbTReSCxfvpQWqmDZq0jRA1FJY0tOxjdTtONXd7k5kmwUDCyJG7N74
         p2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729348260; x=1729953060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1OZg2lit8ojUrZI5PFtcsvJA55BRZgPzGoX56nWOWU=;
        b=FDuuJnNo2wsZVsdy4ifMpcD+1x4k+CMGyZ0BvGlT+hTkmrEpKxN0Z04lJodzshDfNh
         /Yh96a1VH6wfyQDyq1RDHG/YmXjxr8WSVBTHgJRgfnQ7iA24jtCdzwQwfZ9RFT/rJCov
         PSqg7MnYdraCrUNKTzK/UAgWgsAPdu/iOf0w1YvEMPVDjDpZtRbjrd8J+u0Uk2fICCrg
         FGuyH6Ze+8RbneYSDDxIkQzp2ZxhXmJeJfCLxJLlF7jYRjWRKm2JD4kycI1t0zSOFz0A
         d3LvwfnH7+I+30jHCq+SuZ1KB4Se7Ij/bYdkKXVbLZ7ENJWIGD+Iz19+Tso8HMkoRljd
         VdXw==
X-Forwarded-Encrypted: i=1; AJvYcCWyDcwt8Wgu4e0iCeWztri4LviGjv9rlwa1dL/i2i0jrFMlciBVG+R1T63Iu7jnpeH8pKugo4a6kscI8cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZntCcbNcRPQh61fvDE59S2XEaQG+0lI/8QmMtp9oz37iVaSy
	YECltS6vwIjN3w52QWBxYmvRh7bNfN13qTt1CzoP4rjVyS+cMFuMHTqePo0RJoY=
X-Google-Smtp-Source: AGHT+IEN3EZQT9uQn9oZnEUWGdt0rQ6BiPDob8tepon8ZdjaPQoA3NoiyC4bQ5Ivan7fSfYkwlvodA==
X-Received: by 2002:a05:6512:691:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53a15459cefmr3394100e87.14.1729348260129;
        Sat, 19 Oct 2024 07:31:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214e95sm538762e87.287.2024.10.19.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:30:59 -0700 (PDT)
Date: Sat, 19 Oct 2024 17:30:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Message-ID: <mbgd2mjqjhlytvpkljrvlcva7qzahex4qcrfusy2vijz6ysq7a@6baliilco6ab>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
 <2754373.mvXUDI8C0e@steina-w>
 <ovzeljss5uv6rymlbdfjolnjox3dklcv3v2km73gqnh6vejxvg@afhyhfwmt3nf>
 <2007957.usQuhbGJ8B@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2007957.usQuhbGJ8B@steina-w>

On Thu, Oct 17, 2024 at 08:50:43AM +0200, Alexander Stein wrote:
> Hi everyone,
> 
> Am Freitag, 27. September 2024, 01:13:57 CEST schrieb Dmitry Baryshkov:
> > On Thu, Sep 26, 2024 at 04:09:03PM GMT, Alexander Stein wrote:
> > > Hi Dmitry,
> > > 
> > > Am Donnerstag, 26. September 2024, 08:05:56 CEST schrieb Dmitry Baryshkov:
> > > > On Thu, Sep 26, 2024 at 07:55:51AM GMT, Alexander Stein wrote:
> > > > > From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> > > > > 
> > > > > The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> > > > > registers, or the access will hang. For simplicity, the PIXCLK is enabled
> > > > > unconditionally, resulting in increased power consumption.
> > > > 
> > > > By this description it looks like a fix. What is the first broken
> > > > commit? It needs to be mentioned in the Fixes: tag. Or is it hat
> > > > existing devices have been enabling SCFG in some other way?
> > > 
> > > We discussed this internally and it seems this never worked, unless PIXCLK
> > > was already enabled in SCFG by a different way, e.g. firmware, etc.
> > 
> > My bet was on the firmware, but I never touched Layerscape platforms.
> > Anyway,
> > 
> > Fixes: 109eee2f2a18 ("drm/layerscape: Add Freescale DCU DRM driver")
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Any additional feedback?

No response from Stefan and Alison for nearly a month...

-- 
With best wishes
Dmitry

