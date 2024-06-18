Return-Path: <linux-kernel+bounces-220359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2890E02D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE431288557
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286D117BB00;
	Tue, 18 Jun 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wb4rjL3c"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667211CA9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754607; cv=none; b=jhofM0O0SGryWs8EIhbkfTodnd1K1q93Kk1iFQb+bJEMbTMUwvRbhRa4FsX7/WqNSyuARADsmRF2Nwva404cY20ELL2whZNpnFBR/HWEQXEOAaZVtGrUGkjuwjHBoTR3lxttIpoDKrXGng6sZccwfprPiQ42fEP0qwkpgrlROCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754607; c=relaxed/simple;
	bh=LuRs4UoMixZtW9wC9DXlGZ+iQJ7nv669Oq/k30wGXbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL8Zw1eED7JdVuxTc2dBep561CH7mXVVbKW/0mQWVMNC6avazWciXPMreSWiHhrmAM8hyjAjKIS5gQN/oyJcXdqPX0ARQlZFlFBD0MDDlbj/qyCH/BYVg8JFvrW0xySncdHBxRP6dDHVEN72g0BV1VsNS9KVNtM7H809AAJBMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wb4rjL3c; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff06b3f413so5659475276.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718754604; x=1719359404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuRs4UoMixZtW9wC9DXlGZ+iQJ7nv669Oq/k30wGXbM=;
        b=Wb4rjL3c9V7TjKOLUJV6mvSq1gvE1lPO9jUv48EoT24Eqj/BDOpyWdp2oywtpCeHpB
         TH7HCacrg/RxvCga8UaxnF1HCkwMjttLBPZ38pcE3INB09cU7dpWHkQJQj9dCTqV6L9K
         qtQ1HT7qEYOAhd/fhOMR16UX3TZRE+HGi3FkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754604; x=1719359404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuRs4UoMixZtW9wC9DXlGZ+iQJ7nv669Oq/k30wGXbM=;
        b=hWeTtyWAoTz2bXKlR7ZAy7y0AMCyJyViop5p4Nhv7G3rsYNI9LZ2u/hCY3IVA3ISpd
         dwVna8DNlP0GsGfpimZ3yTiWFOdftXfxoefkxoMHLDZno6OKgsOWXOFibRrHTzDnO0oC
         W7U4Bptciq4k8PyJfj0aO+LZYZuBEasL2K/kC/Zh/FH2TJzgeREqakaaeRGf4RyR//iY
         790tVlU6/XEdOskVqiB9Bn7FtwZq4sE3DipqHUGSakJtiv0+xujIPodUEG1wOGoZspS+
         LIDtU4oabHKFrLxEM1kbZOWKSnyH07A09hq7nNY4k+R2myZqdyQ7NIOiuK9URpahhozE
         xO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVfLEPFF94WFPyVXMJBZV7MzJf0RsG7bQE6EOAEHpw4XFuMpiUQIzCfdqFqSZlnV724Cv65AgpMxNTajgXCYrsYKr/qyEsEerkZ5fQz
X-Gm-Message-State: AOJu0Yx8yUEx3ES9+n/dKlnqCXKneGYr9+NgPxiqguYrOEhzXX3CUM/S
	UJV4pUcjUzW6ybPpB0HLHra75YYVvorJCVa2js/B0GzojLHTDNfWE/ZnO9eZd/lpeWla0LXYXKM
	=
X-Google-Smtp-Source: AGHT+IG7CrvdEjiaEhnZ5mwHd9ek7+461bcj6zLBz975tVWivhWgPp5Jg81FfrZkGgE77yHp99ucmg==
X-Received: by 2002:a25:246:0:b0:e02:4329:4dff with SMTP id 3f1490d57ef6-e02be100f5bmr1358368276.2.1718754603565;
        Tue, 18 Jun 2024 16:50:03 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4f1e3csm60171701cf.25.2024.06.18.16.49.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:49:57 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-443586c2091so206021cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:49:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqYQz3fJeKxIDUS5Owgw6Oyk4hI+YS7mYj6Xd6T1GGVVASVn4taU4H4qEDxHt6KtfqKBKnhjWMAaWPlQTQ6RLD7ffkQf+n4+Sq7PE2
X-Received: by 2002:ac8:5982:0:b0:444:a616:de03 with SMTP id
 d75a77b69052e-444aa3b5060mr753291cf.1.1718754584856; Tue, 18 Jun 2024
 16:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local> <CACRpkdbb5OdizDLSRW3bFEJJhrQ7Fs8Pb=Q2yxBog62Z1m-bOQ@mail.gmail.com>
 <CAD=FV=Vm==ngDo_bZ+xqV4Ojj0SSOO3ZWaxAbWA906h6-e8FMA@mail.gmail.com> <ZnBGsbeJfvqP7wqI@phenom.ffwll.local>
In-Reply-To: <ZnBGsbeJfvqP7wqI@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 16:49:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUNcS0uAUro-oXEksHcKMb37kF2NMfd4pE9FahT7jXVA@mail.gmail.com>
Message-ID: <CAD=FV=WUNcS0uAUro-oXEksHcKMb37kF2NMfd4pE9FahT7jXVA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, 
	dri-devel@lists.freedesktop.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Maxime Ripard <mripard@kernel.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 7:22=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> > I'm really not convinced that hacking with device links in order to
> > get the shutdown notification in the right order is correct, though.
> > The idea is that after we're confident that all DRM modeset drivers
> > are calling shutdown properly that we should _remove_ any code
> > handling shutdown from panel-edp and panel-simple. They should just
> > get disabled as part of DRM's shutdown. That means that if we messed
> > with devicelinks just to get a different shutdown order that it was
> > just for a short term thing.
>
> The device links would allow us to add consistency checks to the panel
> code to make sure that the shutdown has already happened.
>
> And we do kinda need the device ordering still, because if they're shut
> down in the wrong order the panel might lose it's power already, before
> the drm driver had a chance to have the last chat with it. Only relevant
> for non-dumb panels like dsi, but there's cases.

My impression is that we shouldn't be relying on the driver-level
"shutdown" call at all but should instead be relying on DRM core to
call us at the right times. I get this impression based on the fact
that panel drivers are encouraged _not_ to implement a shutdown()
callback but instead to rely on the DRM driver to do an orderly power
off of things (like via drm_atomic_helper_shutdown()) at shutdown
time.

I would also tend to say that for suspend/resume that things are more
complicated than the driver model can really account for, which again
is why DRM devices have prepare() and enable() phases with complicated
rules about the ordering that the bridge chain runs those functions
in.

Said another way, I believe I could re-phrase your paragraph above and
say the exact opposite and it would be just as true:

And we do kinda need the device ordering still, because if they're
shut down in the wrong order then the DRM device might lose its power
already, before the panel driver has a chance to use it to send a few
last commands to the panel.

...but that would imply the exact opposite ordering. The issue is that
there are established rules for the order things are powered on and
off and those rules are encoded in the orders that prepare() and
enable() are called. Trying to replicate these rules in the driver
model just seems like something destined to fail and probably causes
everyone who attempts this to give up.


> > That being said, one could argue that having device links between the
> > DRM device and the panel is the right thing long term anyway and that
> > may well be. I guess the issue is that it's not necessarily obvious
> > how the "parent/child" or "supplier/consumer" relationship works w/
> > DRM devices, especially panels. My instinct says that the panel
> > logically is a "child" or "consumer" of the DRM device and thus
> > inserting the correct long term device link would mean we'd get
> > shutdown notification in the wrong order. It would be hard to argue
> > that the panel is the "parent" of a DRM device, but I guess you could
> > call it a "supplier"? ...but it's also a "consumer" of some other
> > stuff, like the pixels being output and also (perhaps) the DP AUX bus.
> > All this complexity is why the DRM framework tends to use its own
> > logic for things like prepare/enable instead of using what Linux gives
> > you. I'm sure Saravanah can also tell you about all the crazy device
> > link circular dependencies that DRM has thrown him through...
>
> The panel driver provides the panel, the drm device driver consumes it.
> I'm not really clear why you want to structure this the other way round, =
I
> can't come up with another way that makes sense from a device driver
> model. And it's device driver model stuff here, not what's really going o=
n
> at the hardware level when everything is set up.

...but, at least on eDP, the DRM device driver provides the DP AUX bus
and the panel consumes it. This is the reverse order. Perhaps you
could say that you should have a separate "struct device" for the DP
AUX bus and the panel consumes the DP AUX bus device but then the DRM
device consumes the panel?

-Doug

