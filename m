Return-Path: <linux-kernel+bounces-173832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CB8C061E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E179283AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AF8131BBD;
	Wed,  8 May 2024 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kxuxpqp8"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF60130E24
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202905; cv=none; b=KoC9/g/eGilsGgOX6Zi/R3/w3QbrU/JrQh65jCSqr8miny1HAlVAB1SikZLe27pNzZyzKLoMhE9uUfzv7VPTDyt7EkX4feaQHP+DaHK1pKqw9XW/5OMeBqADmWa23fwj4Abiy+XFEt0G8leTvcGkHpjiNvoTRc+DLpILgjoPrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202905; c=relaxed/simple;
	bh=ZAY9OmGIvyuKXyebqDh1IRclz4/RXSUx0T+wrGSqSIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rol6ii73esrVw3GAgukzXVkagsi2x+Ib+tBm85F6DXXF3LedwWxkZPslEJBKiLT2EdH01HLZXNF9oOHoOLvS++C3TOrwDKkSAR1QfivtOQIxrOY1QaAqYbTOIwLi/MuTpLc0a51wNSIORpQpNmI/NCeWJFhP2tjQpxSlTNCZGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kxuxpqp8; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c969fa8fd2so152196b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715202901; x=1715807701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buSNW1rXJ5tp0mHF2b1c12zxGyNSJnH+cWUgnRIBSqA=;
        b=Kxuxpqp8c24qcvc4ShwzWdwy1bdADPCCWE/3rBmWfhiQl6hmu0NdmIbHyO8NB8+22V
         T1AKHck2Z/tvmPyshjvk2+2JGaFhz/d59CmLU5kYFec3BAR0eclD2vwZGFpBSnY8R0DQ
         pOxGVSom0MfMQBZNbGBcdViJYzUQdo2vhLahY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715202901; x=1715807701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buSNW1rXJ5tp0mHF2b1c12zxGyNSJnH+cWUgnRIBSqA=;
        b=LaZEWfssmsrJM0RfrqyXNV9SrSFGHqHobGA3yvNgiMpwTOphPT0nHvwfFwQKPyBrc6
         icQHiNreAgSm3KnYz60kLBLxBXqNvAndcOIbnP5sN/t5peX+oMXDyanYroP+3Cl6Qkxq
         G2oVJIOLhcql0zRwYHVyQ4+0qSSwdstlvKy6uEN2R2FZ6zfJk2tuEnWXomU78/dOjDv0
         C6xLAwZHb6G5RlaGz1GrwPR/kjA0C9L9d9xNQXd9p9eaAhJzzkaht8L3wQ79c6B3a2b8
         LbdjYs9nQ8ZZa37OJM2tzY0gbNAhxNYl/NlaigGUS7x38RuTdvHw+m7GdlV/rYqNfZBj
         TnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR7qQ8wV6AU5P8IyVHiKEoNnaxu+3ZM9MAqz0wCttSefKFDDtuGvO/stXpdMPvAhooi2o580R6pSREMiLT4XdN8TxqAFRaY1g4IKET
X-Gm-Message-State: AOJu0Yxo+iOM2KFyG++L1n7BYJZN7M9SA2PEJkLaYQQk0Yi7A1w9UQ8V
	tiSzS7oY6mO0nVFD4n+nbDcZXm2OPERqcGKQaAekKE1TpnGXPlfD9ovujwKClvGPS2H1dJvuNvQ
	=
X-Google-Smtp-Source: AGHT+IFv6xGirBnyCIMeN/JrTkUQJvNBCiOS6MZNF12+ENLhoNMZNmPdghedZfb9aUXy6B2Rc/asCQ==
X-Received: by 2002:a05:6808:418c:b0:3c9:6f6d:2e72 with SMTP id 5614622812f47-3c98532acbbmr4281556b6e.56.1715202900539;
        Wed, 08 May 2024 14:15:00 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05620a319b00b0078d631f35c2sm6249125qkb.24.2024.05.08.14.15.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 14:15:00 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so47171cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 14:15:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmoxIhwE9AXpq2I4K7XbdEqWbQU1NeJrSsL9PWFgvR/ZW8I0nvMDY8WWKcJFF2OvevAY5wJCSn9sx845PGs9EflY5UMY0ushwWllAE
X-Received: by 2002:a05:622a:1c0d:b0:43a:c1cd:2f4c with SMTP id
 d75a77b69052e-43df44dc04cmr169931cf.5.1715202879034; Wed, 08 May 2024
 14:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503213441.177109-1-dianders@chromium.org> <CACRpkdYbtfE9RLsDewV2UwnJknCp_sFEgc+cq=OF+Qd3tkTcwA@mail.gmail.com>
In-Reply-To: <CACRpkdYbtfE9RLsDewV2UwnJknCp_sFEgc+cq=OF+Qd3tkTcwA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 8 May 2024 14:14:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WoYm43SzrdrSZ1Np58iQ4nMwF0u6uamOAnZc4pqmBpsg@mail.gmail.com>
Message-ID: <CAD=FV=WoYm43SzrdrSZ1Np58iQ4nMwF0u6uamOAnZc4pqmBpsg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/48] drm/panel: Remove most store/double-check of
 prepared/enabled state
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
	Purism Kernel Team <kernel@puri.sm>, Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Stefan Mavrodiev <stefan@olimex.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 5, 2024 at 11:52=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Fri, May 3, 2024 at 11:36=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
>
> > As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> > prepared/enabled in drm_panel"), we want to remove needless code from
> > panel drivers that was storing and double-checking the
> > prepared/enabled state. Even if someone was relying on the
> > double-check before, that double-check is now in the core and not
> > needed in individual drivers.
> >
> > This series attempts to do just that. While the original grep, AKA:
> >   git grep 'if.*>prepared' -- drivers/gpu/drm/panel
> >   git grep 'if.*>enabled' -- drivers/gpu/drm/panel
> > ...still produces a few hits after my series, they are _mostly_ all
> > gone. The ones that are left are less trivial to fix.
> >
> > One of the main reasons that many panels probably needed to store and
> > double-check their prepared/enabled appears to have been to handle
> > shutdown and/or remove. Panels drivers often wanted to force the power
> > off for panels in these cases and this was a good reason for the
> > double-check.
> >
> > In response to my V1 series [1] we had much discussion of what to
> > do. The conclusion was that as long as DRM modeset drivers properly
> > called drm_atomic_helper_shutdown() that we should be able to remove
> > the explicit shutdown/remove handling in the panel drivers. Most of
> > the patches to improve DRM modeset drivers [2] [3] [4] have now
> > landed.
> >
> > In contrast to my V1 series, I broke the V2 series up a lot
> > more. Since a few of the panel drivers in V1 already landed, we had
> > fewer total drivers and so we could devote a patch to each panel.
> > Also, since we were now relying on DRM modeset drivers I felt like we
> > should split the patches for each panel into two: one that's
> > definitely safe and one that could be reverted if we found a
> > problematic DRM modeset driver that we couldn't fix.
> >
> > Sorry for the large number of patches. I've set things to mostly just
> > CC people on the cover letter and the patches that are relevant to
> > them. I've tried to CC people on the whole series that have shown
> > interest in this TODO item.
> >
> > As patches in this series are reviewed and/or tested they could be
> > landed. There's really no ordering requirement for the series unless
> > patches touch the same driver.
> >
> > NOTE: this touches _a lot_ of drivers, is repetitive, and is not
> > really possible to generate automatically. That means it's entirely
> > possible that my eyes glazed over and I did something wrong. Please
> > double-check me and don't assume that I got everything perfect, though
> > I did my best. I have at least confirmed that "allmodconfig" for arm64
> > doesn't fall on its face with this series. I haven't done a ton of
> > other testing.
> >
> > [1] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46=
d6b234f89613b5cec0f14@changeid
> > [2] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium=
org
> > [3] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium=
org
> > [4] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromiu=
m.org
>
> This is the right thing to do, thanks for looking into this!
>
> As for the behaviour of .remove() I doubt whether in many cases
> the original driver authors have even tested this themselves.

Yeah, I'd tend to agree.


> I would say we should just apply the series as soon as it's non-RFC

It's not actually RFC now, but "RFT" (request for testing). I don't
_think_ there's any need to send a version without the RFT tag before
landing unless someone really feels strongly about it.


> after the next merge window

With drm-misc there's not really any specific reason to wait for the
merge window to open/close as we can land in drm-misc-next at any time
regardless of the merge window. drm-misc-next will simply stop feeding
linuxnext for a while.

That all being said, I'm happy to delay landing this until after the
next -rc1 comes out if people would prefer that. If I don't hear
anything, I guess I'll just wait until -rc1 before landing any of
these.


> and see what happens. I doubt it
> will cause much trouble.

I can land the whole series if that's what everyone agrees on. As I
mentioned above, I'm at least slightly worried that I did something
stupid _somewhere_ in this series since no automation was possible and
with repetitive tasks like this it's super easy to flub something up.
It's _probably_ fine, but I guess I still have the worry in the back
of my mind.

If folks think I should just apply the whole series then I'm happy to
do that. If folks think I should just land parts of the series as they
are reviewed/tested I can do that as well. Let me know. If I don't
hear anything I'd tend to just land patches that are reviewed/tested.
Then after a month or so (hopefully) I'd send out a v2 with anything
left.


> The series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

-Doug

