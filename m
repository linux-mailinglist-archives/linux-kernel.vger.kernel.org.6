Return-Path: <linux-kernel+bounces-337968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF659851B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080681C20EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E31494A9;
	Wed, 25 Sep 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l7PFiia3"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E71FAA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727236882; cv=none; b=TchY+5ERztWhmYiw95elIfKwnpdn0Nm3Jo1fl4W3dSfkqu6e2VhTiFf9XBwwdfEBTTe/p8NFSibtQjHR8wNuBmX+jkFY9U/ktGSvCRqiXJlmn73e7Xh0D18yuQ5DGctKjDYBcgAf+/ZrpUvXIt6xvj80ty2cNMekOTBh2uwDzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727236882; c=relaxed/simple;
	bh=EKPS+oo/SYEIXrJlcvkra97kLZnQ1iRLYXvaEVbf4zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYsEZd7iHWPT959S/CBGgJhoIo7y+w9CxwrQeX4zI4+a3U43OYbN81A0i6D9pm+G1vqB+0DicGs6cnnjwTUVGYm/GTX6sV6jpHRTBQozuHRUG8EDwbfJGbJx28co8yGSedO9AbpRnNC7uXXavpRj/jFqcoBmnroGAoTbtbLeLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l7PFiia3; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7138acdfb49so3229803a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727236880; x=1727841680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv0LNQbODtscukyro5hUsz/iAMlBwMMkYBgi7p9HDmY=;
        b=l7PFiia3cwYhq30iI+vgIAlDXmM2H0WNzaf5+hf8pJ+rkY30o9iSQxBctnzp3IR+vB
         uPoSkgLJ6ucJaHUrJLglE6NlXp4kTgBWViRwmIu/sQwA1vGQQUxjcXqFTcdIG0NolUv3
         symaN3xlaNy1EEhwXyUZ+f4PKNHRXjQjg42Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727236880; x=1727841680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv0LNQbODtscukyro5hUsz/iAMlBwMMkYBgi7p9HDmY=;
        b=X8GaJsY+C/j42siWoknnykkXfbOFZBfu4RBEdzteJLKoPNs42oT1Ibyx5rU4WVpt+H
         +zeguSvWtP+VNAfBuDbBj1ePSilHw/7iFA5HnI/mBiD0cxePMqhOv30rhMnww13IAuBM
         DgwACs99RC4IWV27WUCP0Rmuj0xHIZKjlIvWn9q909LcvK8HeWas2k7/ekUxLEnZBoyX
         CfySzvt7ZAfgnTiovMOIpAvuRBmA+LtZC3P8uBjkB148V4wqdMAS3hTTS424U88o7tl9
         IiIMoWsrWoQWU+pDxCQu33v7SMf45cBaQwo35rT8Ag2PvmVeVjbtoeyDfplerZ5v2UHT
         RCZg==
X-Forwarded-Encrypted: i=1; AJvYcCVF1VA6S3R/NQZ6D4NrGZGEvsdDKTjiPf3eVO4wNS/ji7gGmC0WKmgERhApsyOT0r8wsdpYcBTdOzRTRWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysoaMQgkulYB2OrgjLZJFF1n2KPb1QMlzXzx3wlFLl4fiHWEct
	8xyFSzx6V+eAOns44Rv3Xw9xxOFaDYZrtZFzXuo1THZW40O3zxKiJRAzMfHwFyx7ZxjozfUS5NZ
	jWT0YeH9xZ3W526DbYxAdbXt+gH+/jIa0OIRYAfRePzTx7S4=
X-Google-Smtp-Source: AGHT+IGgau4syMiJqpfiz+BN973InPoO24YNAxRH9R43N/ngNivhfxeEELeM5iRFh9PG59Y1/XRvme2ovOJhUwuCj+M=
X-Received: by 2002:a05:6830:2d88:b0:710:f76b:350b with SMTP id
 46e09a7af769-713c7d942c7mr1549438a34.5.1727236880259; Tue, 24 Sep 2024
 21:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924035231.1163670-1-treapking@chromium.org>
 <20240924035231.1163670-2-treapking@chromium.org> <CAD=FV=VEMkociw5gyVOtVCPmCyf1b0G7owsAm=o-LxB33YUnjg@mail.gmail.com>
In-Reply-To: <CAD=FV=VEMkociw5gyVOtVCPmCyf1b0G7owsAm=o-LxB33YUnjg@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 25 Sep 2024 12:01:09 +0800
Message-ID: <CAEXTbpe4R8rXHn1+e55RxzryNW-0YexQfr7M5CBz2hP9qneTQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: anx7625: Drop EDID cache on bridge power off
To: Doug Anderson <dianders@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 25, 2024 at 12:43=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Sep 23, 2024 at 8:53=E2=80=AFPM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > The bridge might miss the display change events when it's powered off.
> > This happens when a user changes the external monitor when the system
> > is suspended and the embedded controller doesn't not wake AP up.
> >
> > It's also observed that one DP-to-HDMI bridge doesn't work correctly
> > when there is no EDID read after it is powered on.
> >
> > Drop the cache to force an EDID read after system resume to fix this.
> >
> > Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to =
DP")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> I'm not totally sure if it matters, but I wonder if you should change
> this to only delete the EDID cache if you're in DP mode and not eDP
> mode? For eDP mode the panel is not allowed to change and re-reading
> it needlessly seems like it would slow down things like
> suspend/resume. I think this would only matter if someone were using
> eDP panels in the "old" way (not under the aux-bus) because we don't
> set the "DRM_BRIDGE_OP_EDID" when we see "aux-bus", so maybe we don't
> care that much but still...

I'll update this in v2.
>
> Other than that, I know that there have been discussions in the past
> about EDID caches but I can't quite remember all the details. I know
> that panel-edp.c still caches it, so we must have concluded that it's
> at least fine/reasonable for panels. I don't remember whether caching
> is encouraged / suggested for external displays, though. Do you happen
> to know if it even makes a difference there (in other words, do you
> actually see multiple calls to read the EDID when you plug in a DP
> display)?

At least on ChromeOS, Chrome triggers two EDID reads when I plug in an
external monitor. I'm not sure if this is common for other DRM masters
though.
>
> -Doug

Regards,
Pin-yen

