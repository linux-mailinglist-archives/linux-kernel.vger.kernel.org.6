Return-Path: <linux-kernel+bounces-238037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C355924274
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17CF0282323
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BE1BBBF5;
	Tue,  2 Jul 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFITaTMZ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583E1BBBC3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934365; cv=none; b=gQ1b0CKfwzeFixEoJQv0rR5qIGyIarCdFPsjo1r5us23VTbCUuEELotGIldMUYvo8SJt5rTE/q5QnffinH5fdLPBXc7wGVdOyA1RZZ650/5rUjCkSPK/ZiiHsc0JjBmiqeWItbm2/3SZwggwu1vpjdRYm6Xky6R/g7WAyuZiedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934365; c=relaxed/simple;
	bh=C/m6fd75vr0+1BIFC2PeIwG+mleUy9yNFQhDe3qHmc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POQt5InXmVnY1tKvLaHJ6/AO1Ehd/a5SzZ57wWcgfzhgJy4pTinbAdBvKyJqc6KIuDN0WC+QBEBqN4/89YcmuyLJ5YWOK8jrpeGrf3TB7bEA4am0lT9p5EgQwQpdZCmsSSfJIsweYRJiFfVHrYnYnbWag4PJFVOMaKHzcWR3+U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFITaTMZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso7977451fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719934362; x=1720539162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/m6fd75vr0+1BIFC2PeIwG+mleUy9yNFQhDe3qHmc0=;
        b=dFITaTMZMBwOi1alls6EAjY9yG/iDphamHhu1lA/zoWqXX75nQ1ErysF6FeyennyvX
         nvfnnLESSR4SZeIKHsOjA7Oy+9i3q0P4dvuqKX7PXrUxvHQ/3H3W1yLzHIjgz2Mlhq7D
         b0mqR6C5ywr7Ap3v+sjrcesgZ2k1yaLPz0vZ0Mrl8tRS+OXOPtbqROPZ6bqiUmaQgmd+
         CY8o7u04jZQWrHzg3ZBhmf8B944CHsC98Fg7Z7qpccOgmdq3fD6vuTE1+gvyP/yDOCTv
         btwf8U8U0msFr2htpSxGl1iiU7UnWUwkt1rL8PkTURyj/ekurjoTd3O+qyMFreuia8yk
         DTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934362; x=1720539162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/m6fd75vr0+1BIFC2PeIwG+mleUy9yNFQhDe3qHmc0=;
        b=l3x+sXe73UEhB8cri0y1aqabi4JgcipJUiu2OZZ+Ba5IWcdRrJ7cxAp5zALij+ih0w
         8Ik7WeB9kclYrsIxlRIUrb4EWXTT/h1v4S8OJO9cjEcTi5hSwskdjwJHTT4lx9hRYhj2
         AEjPO97xdl3u8b5btPbWNI3S0rv9U7np7ivHSY923oCIxnbyTgvFFmgSmWhfWI2HRLla
         YJZdXV2tRBRa89N0SJhepdop/scjPmk9J4GWHoWRVm0Jk5DIQB2OZVPs7HUofdyuuBnc
         cdO76JLKrY1Mgrnde9xsvxdCwinKS22g0xVQ5+UJS35R70CtzyT49XqWlEpvh8njt9wA
         Im5w==
X-Forwarded-Encrypted: i=1; AJvYcCXMcntTFiEOPmItndsaudJ02TIj7X7DKpWYAkJE/XIQ2Bv3L2pEvZxnDGHLGc0+n+mBr5Ri77OdyArgupSsW3iQIlekxUuohrYBI+Ga
X-Gm-Message-State: AOJu0YwUoRT13h2wT7dmkfWL2O7UssM34uuow8ArYhFHDd6ubFBbFAkK
	GV+8Wq5Oo7Mk6aJw3bFnm4jtTz2X3tncKyVV4cJFvZUzCAXn/YYv28u0EKs2ViU6si7B0XvywIe
	v6U7FaLcQ8XvTKpuDetrIw88fWPM=
X-Google-Smtp-Source: AGHT+IGpss4noUQgT3U0y8rHVx0PXPERHp6cM4+5fhPb2ffHe8Jw2nNKmIcPJRz59rdV4Tn6bFNR4p7ayqOSLwFJSvM=
X-Received: by 2002:a2e:9a13:0:b0:2ee:6254:f9ee with SMTP id
 38308e7fff4ca-2ee6254fb2cmr65786961fa.42.1719934361988; Tue, 02 Jul 2024
 08:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn8GVkpwXwhaUFno@titan> <CALP2yXcUrCdzyqQx7RQUup3QjfbH4VnMVCPFVXNmmd08GJkKMQ@mail.gmail.com>
 <CAMBcuYNG6n1_yc0-5MSFoh2xCfh3-tHG7VcQq5vY65RKSq39RA@mail.gmail.com> <ZoB1ac1bEI8aH-Yp@titan>
In-Reply-To: <ZoB1ac1bEI8aH-Yp@titan>
From: Jakob L <jakobl.gm.g@gmail.com>
Date: Tue, 2 Jul 2024 17:32:29 +0200
Message-ID: <CALP2yXexcwNR69Og48Wd8oyqP+YRUnujtUkgbu4ZLkQUQsAEVw@mail.gmail.com>
Subject: Re: T113 TCON Top tinting troubleshooting
To: John Watts <contact@jookia.org>
Cc: Kirby Nankivell <kirby.nankivell@gmail.com>, linux-sunxi@lists.linux.dev, 
	andre.przywara@arm.com, Paul Kocialkowski <contact@paulk.fr>, 
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

i am pretty sure other devices don't have this. At least i have never
seen it on V3s, A20, A33, H3, A64 with RGB, HDMI, LVDS, or Mipi. This
was the first - and on MIPI its pretty bad, to a point where its not
usable.
With the allwinner u-boot from BSP i had not experience that tint -
but i assumed it to be somewhere in the wrong Mipi packager or DMA
setup.

Since i am not very experience with mainline contributions i am not
sure what is the best approach. While i agree that ideally its done
right on all sunxi devices, the risk of breaking something without
need should be avoided?

All the best
Jakob

Am Sa., 29. Juni 2024 um 23:01 Uhr schrieb John Watts <contact@jookia.org>:
>
> Hi,
>
> On Sat, Jun 29, 2024 at 12:14:39PM +1000, Kirby Nankivell wrote:
> > Tested this on a MangoPI-MQ-R with a RGB lcd and can confirm that this fix
> > removes the green tint I experienced.
> >
> > Disabling the mixer1 in DTS entirely also works.
> >
> > I suspect on the basis that the Mixer/TCON-TOP topology is identical to the
> > R40 but does not seem to experience this issue, that is a
> > silicon errata specific to the T113/D1s as far as we currently know.
> >
> > However, there is no functional reason from a drm perspective to require
> > more than one mixer tied to one output via tcon-top - unless someone has a
> > good argument here?
> >
> > in my opinion:
> > 1) implement this as a quirk on the t113 and fix mixer0 > rgb/dsi and
> > mixer1 > tv0
> > 2) make this a global default for the sun8i tcon top driver where only one
> > mixer is initialised against an output (which would also impact the R40)
>
> The only reason I caught this issue was because I implemented LCD output in
> U-Boot and saw it looked a little better- I thought the tint was the backlight.
> Had you not contacted me and had it not affected the person I'm doing
> work for I would not have bothered looking in to this.
> It's entirely possible that the other supported devices have this issue,
> or that future ones will and nobody will notice.
>
> Going with a preventative approach here by fixing it for all potential devices
> and relying on the behaviour the sunxi code assumes rather than the datasheet
> says seems like the best approach to me.
>
> John.

