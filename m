Return-Path: <linux-kernel+bounces-211864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5D0905854
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5C1B2B63D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DB1836ED;
	Wed, 12 Jun 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HD+CkIzQ"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362D1836D0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208212; cv=none; b=Kx9PXlJ76b0bl/vry85PRXdLAzSO0IAumut6Ea1c2SokQeaIvbRKGLamvlUgsP5mpYvrJnrKzYjIcCfa+cNZyPt/UY3z7DNBhrzIW+JdWIU2osoVRpoH3Gtkvb9WPZmQU4aqu5VKrx2mp+XGqVAVJftF7KBi7NDhAFFxIfuNa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208212; c=relaxed/simple;
	bh=ohVgUKw8pNuG0pdNC0IycgIg/FLKQkS/xkAb0Ciu+dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLn2gYeSXFNfLUxbopgMVmM1P+o5vyvbUlo3t3HpRXltPCK83q+qv3rkkvWXJ9dqjFEB0uqNP3y37WFAzcwMwkNFeAfn7p0/5nKqysYDxGlL+sNggcEc+YKAQAz4STAEQcyHpp+FkuTTzWixHJ2WVdvL7dlrQvGzDbXHvpnwd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HD+CkIzQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b08d661dbaso10405006d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718208208; x=1718813008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohVgUKw8pNuG0pdNC0IycgIg/FLKQkS/xkAb0Ciu+dY=;
        b=HD+CkIzQhH6ru/OPHO0hR+Dix5gdLJgUOlX3BrTHAmwtIIdJbLoCt2LVNyebydevX2
         DlAUpzDgJexgomn/uPXD5DsI+rPX/4lNO9pcXgZ6sksSn5MjimF3yirN83rLJRVM2fjB
         rjGSfs5pHdvznSK5FCWnRKv5aDNMLl+5yxmwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208208; x=1718813008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohVgUKw8pNuG0pdNC0IycgIg/FLKQkS/xkAb0Ciu+dY=;
        b=T3NI+HLUmjqLqS2Ljg7RzjNgoZtYlNZGxiWLuY0gRT9EAZkOtjOFOSLq8jRC0TfzXQ
         +B6R1PTyxodSJIQgrD8UVa9DX0mRHLQLwZK5enicPAHTDj1CvLUXWVM23eJbqMaA3Klj
         srJEZUiOzdga/kkXj4lwPTCKzSjF86W5HAFWih7iXUIGFPFWu2amoai2qfzFKSLnRA30
         oJiJs9LZMuYVvQMX/ph+6mCYrkNJVXnWgFyomiwNEMdyl2C64gMqfurdDad0KNWaWf8T
         tPGzP7jjp+bTXP+7EUI6CIgHPc14RRZG5MSR/tnrsD9EhqXOF5hsOr3SMAPthWmoVWYW
         eIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvo9nM+S22f4yQDRQArntslBygfPYIhP6TuTiPRDoOBn1SD6+PLXuD8WEPle3tWvzDOmMZ9DNtDqs7nxKYRuYuJpi/XJ+Rxh8buy9a
X-Gm-Message-State: AOJu0Yy5vVMKk074n1qUZ5OodLmr4MT7AnkxlmK/bY3PzrmSQtDcE2y9
	3fNLoaYDOnJ5o8NnRt4RXJWNDC5uUXOhGzYevfNsdhmglx2RwAm3lFXs6NgwNDfxD4E2sYdqXKE
	=
X-Google-Smtp-Source: AGHT+IHYZXf0r1HnI0Mys6g5iwjPecdoCMAj57gs/Dipcro7IDjdpj30MTzMuCg2es6ro2b+lHZQoQ==
X-Received: by 2002:a05:6214:1bce:b0:6ad:7562:c286 with SMTP id 6a1803df08f44-6b2a33de154mr1968656d6.15.1718208207704;
        Wed, 12 Jun 2024 09:03:27 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0782266f4sm37310366d6.121.2024.06.12.09.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:03:26 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405dffca81so191321cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:03:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0w3+nStMMj81jXhTtpd4h1KgCbN4+Sz4M3u3LfpAR1owsuIMJI4d/wHXk9nT3cUX5sYOUwA4vqW17NgRR7hDmOJfSWCFkqx7yLImz
X-Received: by 2002:a05:622a:8c3:b0:441:6135:ba89 with SMTP id
 d75a77b69052e-44161360e39mr1211681cf.3.1718208205353; Wed, 12 Jun 2024
 09:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <20240612-garnet-condor-from-saturn-1c51bb@houat> <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
 <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
In-Reply-To: <Zmm6_27GikpmT3HQ@phenom.ffwll.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 09:03:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSXX_FgBcF0XHMUkLpfEzPcgThLEttcB9RzVXzyqKnNw@mail.gmail.com>
Message-ID: <CAD=FV=WSXX_FgBcF0XHMUkLpfEzPcgThLEttcB9RzVXzyqKnNw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Doug Anderson <dianders@chromium.org>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Chris Morgan <macromorgan@hotmail.com>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 8:13=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
>
> > > I ran the coccinelle script we started with, and here are the results=
:
> > >
> > > ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver v=
mw_pci_driver is missing shutdown implementation
> > > ./drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_plat=
form_driver is missing shutdown implementation
> > > ./drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_p=
latform_driver is missing shutdown implementation
> >
> > Sure, although I think we agreed even back when we talked about this
> > last that your coccinelle script wasn't guaranteed to catch every
> > driver. ...so I guess the question is: are we willing to accept that
> > we'll stop disabling panels at shutdown for any drivers that might
> > were missed. For instance, looking at it by hand (which also could
> > miss things), I previously thought that we also might need:
> >
> > * nouveau
> > * tegra
> > * amdgpu
> > * sprd
> > * gma500
> > * radeon
> >
> > I sent patches for those drivers but they don't go through drm-misc
> > and some of the drivers had a lot of abstraction layers and were hard
> > to reason about. I'm also not 100% confident that all of those drivers
> > really are affected--they'd have to be used with panel-simple or
> > panel-edp...
>
> Aside from amdgpu and radeon they're all in -misc now, and Alex is
> generally fairly responsive.

Ah, nice! They weren't when I sent the patches ages ago. I guess I
should go ahead and repost things and maybe they'll get some traction.


> > In any case, having some sort of warning that would give us a
> > definitive answer would be nice. My proposed patch would give us that
> > warning. I could even jump to a WARN_ON right from the start.
>
> Yeah we defo want some warning to at least check this at runtime.

Yeah, my patch today currently just has a "dev_warn", but the question
is whether it would get more attention with a full on WARN_ON(). I
know WARN_ON() can be pretty controversial.

-Doug

