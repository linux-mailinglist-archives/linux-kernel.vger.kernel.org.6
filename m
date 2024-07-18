Return-Path: <linux-kernel+bounces-256376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44390934D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26FF2836D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4878C93;
	Thu, 18 Jul 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bwi35K2V"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BD40875
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305921; cv=none; b=BAj5nya9rFGWleZGw4Nrkh1BBSq9kzSMmySyJoUfUzOv5YIv3PiLb03IGHWnbfbVrXBtrr48vTn6JqRGLwCpiPY4E1GIVa5T8bsS+a4BsQQ3HugxVsi+m1jE55Cc2F9SOxpciAhceKLsSVDhWHErO120mH6K+WoZOZwm7Wl2RNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305921; c=relaxed/simple;
	bh=DK820VpofJg6rP97ErE676Irvfoo9tcIEXGvvccsjXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEqoLxY/7raA4qcDRuA2xdJeo+6VBKLhViCOaCVDZaD03C5GZreVChTqB7Rm7MYSeHL5cvcdMkH8oQyQTtTKqYHgP7/kObTGC7Vzc3+gIuzelYV0ggwKwSrpMh0j47rqTDT2ZihgQpWlDfjHycdwn5CLr+KciBxxmz8A/UwyZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bwi35K2V; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso355216e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721305918; x=1721910718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bFckFnWty7GT0h7WRWkKM0jPqUcetmJUm4oCOzxQM0=;
        b=Bwi35K2V/VisLcZwNkQ7FCuIija/2j3pbEyNAMQCg0Pk/L6JwYNWc13vF0WxWOKnOy
         6CUKNISJLRozrwb8DWf2imFE9WA6met94flqaj+dfUDjECgi0Gx0bQmH0/zwMicvoc1w
         jHZ+1CpC+T7/5RW8K8/q6P4gpSGT3FW1LxKnUYR2qDeNEL5RcwKBPtJooUw2plv76EeZ
         k6G984z2J5aWnXaVui/8X6N4TvxF6jzGmXj+Y6yZFCRBLxHzpQU9oUVt0f/3Z2oQhVXq
         rFMzWFhXO/MqZRETD0xsbvBZ1u+6VWTlrPb9SgW7+p6IViBGmqZAl6KqIzla5x7Ie+Zg
         vNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305918; x=1721910718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bFckFnWty7GT0h7WRWkKM0jPqUcetmJUm4oCOzxQM0=;
        b=OKeBlyz/MGW6lRzcYegyOvh+SnzUidhn13xfR9yQSj5EIWMo3UMu3ZTMO1nQ20tZnW
         YC9dKQsLvoHKg6eLvO9AgbG7BJSfeCRy+8wrEQ7/ACjfT37wLfyogIRjjRBOUW5XR/eF
         LBSnyNBY4r92qBCqTuQnBuy0PA39muXWRJdVN2yXRTG1xA//dIBT7d0WVYQ609OO+Jmb
         6z15AKsHZNL0SF93j13Bb8R9sYBXbl/CM+kq/utoCsVhwtN4/YpRCepQdm3GORrL6eWB
         6pjBgF6HEe9b8IFpSacJ+gtXjrEGxHqVUPMjV5aIXhu1stkLiAtUP/7AL+TSdudMDVyv
         acvg==
X-Forwarded-Encrypted: i=1; AJvYcCUp7KbyyelWraK1ax1ewoHtK5kz+bwdTMJIPN9SF8sAo0abqY1Gc9UiHAnAC9B/5kqsquE6XatWyJzdbHWAGiSSCQj75jOCVekrFmhX
X-Gm-Message-State: AOJu0Yy4/fZ+k1tgAzF2pp069YSti5elAaq2M2Yg1ODDmlOwWcPrhW8v
	yY2q31ozFId3KXHeWvsBHK6WWoKuIwLY+70Hkrp1ND3cXSDgtApD0DustTgJNbI=
X-Google-Smtp-Source: AGHT+IHV353nj9C2X6K4hspGVal2ktaseN9D4EwDrW1RpkZb5c5QpQoMkz6JS4I1iUevAj4265AQlQ==
X-Received: by 2002:a05:6512:1253:b0:52e:9cf0:69db with SMTP id 2adb3069b0e04-52ee5411212mr3381313e87.46.1721305917750;
        Thu, 18 Jul 2024 05:31:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef0744d6esm76255e87.171.2024.07.18.05.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:31:57 -0700 (PDT)
Date: Thu, 18 Jul 2024 15:31:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] drm/panel/simple-edp: Add Samsung ATNA45DC02
Message-ID: <d5vfynn6ba4fwkaw7cegzillhw5qkl5z5huw2xb347j3tv7gnu@etgiotbc2x3r>
References: <20240717215847.5310-1-robdclark@gmail.com>
 <CAD=FV=XCOKJHJ-yzENpvm_MD34tMR5LRy2m2jYdcWzZXP4pfXQ@mail.gmail.com>
 <CAF6AEGuBZqV4zg1asUNbMLvq0-i-iyFwfi37uKS3kWNuRSOU+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGuBZqV4zg1asUNbMLvq0-i-iyFwfi37uKS3kWNuRSOU+g@mail.gmail.com>

On Wed, Jul 17, 2024 at 06:09:29PM GMT, Rob Clark wrote:
> On Wed, Jul 17, 2024 at 5:19 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jul 17, 2024 at 2:58 PM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Just a guess on the panel timings, but they appear to work.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > This adds the panel I have on my lenovo yoga slim 7x laptop.  I couldn't
> > > find any datasheet so timings is just a guess.  But AFAICT everything
> > > works fine.
> > >
> > >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Given that this is a Samsung ATNA<mumble>, is there any chance it's an
> > OLED panel? Should it be supported with the Samsung OLED panel driver
> > like this:
> >
> > https://lore.kernel.org/r/20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org
> 
> it is an OLED panel, and I did see that patchset and thought that
> samsung panel driver would work.  But changing the compat string on
> the yoga dts only gave me a black screen (and I didn't see any of the
> other mentioned problems with bl control or dpms with panel-edp).  So
> :shrug:?  It could be I overlooked something else, but it _seems_ like
> panel-edp is fine for this panel. Plus, it would avoid awkwardness if
> it turned out there were other non-samsung 2nd sources, but so far
> with a sample size of two 100% of these laptops have the same panel
> ;-)
> 
> But that was the reason for posting this as an RFC.  I was hoping
> someone had some hint about where to find datasheets (my google'ing
> was not successful), etc.

Panelook has a datasheet for ATNA45DC01. It's behind a 'register new
business email' paywall.

> 
> BR,
> -R

-- 
With best wishes
Dmitry

