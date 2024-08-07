Return-Path: <linux-kernel+bounces-278551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7294B1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE29282554
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C71494AB;
	Wed,  7 Aug 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A2V2zjzg"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A444B640
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064759; cv=none; b=rdHl5VhJQU8xx8eZoIRgIsxcEzfT8Dfv7NS9mvNHTd5gH+gXAeOkp+Jox2/sJYVot4Fld6gtNrER17WWGPEEmPu05UtbErMWTEhN7WyOjvVOTc/aVG1vZSsRYylE3c1tmFFRq9AYFePJTZ8vtSreaot0pYD8OVmfOnqxC4Uqv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064759; c=relaxed/simple;
	bh=PLt1dqddQDBoCtJXzvJlGMS983d7hsEzCSQWgOd3+yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTMQWBxr6ex6tAGQtkhRHWxrvTyRC7PLneis5dsmNQpNMYUnG3JN/MzsDO6yWbumQdv061aO4XVd5QjJJZQhNdSSA9NCefPD8wsm6PQpqbWksGYHgvAxRrx9Q8e+MeMCa3NdpEDsQ9gtfu7YbgrgWoU1PWM8KwzU4R4FCbCaS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=A2V2zjzg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so2117116a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1723064756; x=1723669556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLt1dqddQDBoCtJXzvJlGMS983d7hsEzCSQWgOd3+yo=;
        b=A2V2zjzgmlp6CvK3kjJiriUBGKGnvvd2gNcsnySllLaeriv3gi6+tCtm7plWO+voZM
         XhRzNBOfGpzymBFrk5EVeL+uu82XJ6ZuL63mM8bTEzuhTf0L3nVPUBsRtZBfm1wi2phI
         dofoewJlbq6FNBQENFaZdttV2KH7vqdFVHjE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723064756; x=1723669556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLt1dqddQDBoCtJXzvJlGMS983d7hsEzCSQWgOd3+yo=;
        b=GyjUmXAhUszhx+1VHQfZdHLWoHdJXBc/VOwGCmOIaxQ4KLgVUtw4X89mY1E9YI3Mmz
         LS7oq8CXXiVAs76GFaySgrbB2bkR/Yqs+5AMTK749IH5DNX4V71QeOntbbEhv6L3g+lm
         gzDwzf5yA6wCA41XsuIoPnLdNjfJsohPESGdTGmAJ2ObQrvBAoXS7kUI2tzaidDwdO85
         YM7U+OXNqsImuw+wg/GBCP/ffEgfxx6lghm2pVeEl+JvEQMXMLwwz7n3/lvuyEl+IYM7
         qvt2atCILgLDqoTtAaIGQqQWhOPTxhyItJF8+PRCgVH8vZsDnGrlphzCR4+MO47UXrPl
         jHag==
X-Forwarded-Encrypted: i=1; AJvYcCXVs40KkfHNy3d7Tou6pQkd/xxdxakz8banKH7Jv8arIrvpApNjkIJw8cwhyk3S2wptT64+FwJFEr39jlvddRADzdgCFbRe8I08jVJJ
X-Gm-Message-State: AOJu0YzE5n9NOJcLyfjloz3+7ckcU7r6NKcT0PsfSt4l+y4u914ROohE
	f3pK5YEyc1pWIa+HqbQOIpRin3O8UMZOCVEBUWf0asSMTvlX/VEsoxBa6Q0yB5e8oh+B4qaRvMf
	XJbHuM2IYYFq4UCpNbBsE7YZSBFT5496ulyY9HQ==
X-Google-Smtp-Source: AGHT+IEVha/qZgi+k4Bh3HWayIPLXCtKLmeWiTv5Psq4K6YKu4pFvkNmbbQ2nEjM7A4vXgDM+ek6l629TptgUUKlLAc=
X-Received: by 2002:a17:907:1c29:b0:a7d:8912:6697 with SMTP id
 a640c23a62f3a-a8078fef477mr300907766b.3.1723064755831; Wed, 07 Aug 2024
 14:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624185345.11113-1-michael@amarulasolutions.com>
 <CAOf5uwkhThmTEuhYAxAgLqg86PEHJ49wWp67RahVhio=O2OfQw@mail.gmail.com> <CAD=FV=W9=Ynhgi3nrfuM47rz053iWTvsEhhQFkZ5xp_bmwzmLA@mail.gmail.com>
In-Reply-To: <CAD=FV=W9=Ynhgi3nrfuM47rz053iWTvsEhhQFkZ5xp_bmwzmLA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 7 Aug 2024 23:05:44 +0200
Message-ID: <CAOf5uwkkggf9ooNWuNxmN2Xn_KKPW_XRVsYy4eUo91WU0M0rWw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug

On Wed, Aug 7, 2024 at 11:02=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Aug 7, 2024 at 5:39=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Doug
> >
> > +cc Doug
> >
> > I have seen that you have done some re-working and investigation on
> > drm stack, do you have some
> > suggestion on this case?
> >
> > On Mon, Jun 24, 2024 at 8:53=E2=80=AFPM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > The shutdown function can be called when the display is already
> > > unprepared. For example during reboot this trigger a kernel
> > > backlog. Calling the drm_panel_unprepare, allow us to avoid
> > > to trigger the kernel warning
> > >
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >
> > > It's not obviovus if shutdown can be dropped or this problem depends
> > > on the display stack as it is implmented. More feedback is required
> > > here
>
> In general the shutdown should be dropped and it should be up to the
> display driver to do the shutdown. If your panel needs to be used with
> a DRM Modeset driver that doesn't properly call shutdown then the
> ideal solution would be to fix the DRM Modeset driver. If this is
> somehow impossible, I suspect folks would (begrudgingly) accept some
> other solution.
>
> From a super quick look, I see:
>
> * This panel seems to be used upstream by "imx8mn-bsh-smm-s2-display.dtsi=
"
>
> * In "imx8mn.dtsi" I see "lcdif" is "fsl,imx6sx-lcdif".
>
> * "fsl,imx6sx-lcdif" seems to be handled by "drivers/gpu/drm/mxsfb/mxsfb_=
drv.c"
>
> * Previously I determined that "mxsfb-drm" was indeed calling
> drm_atomic_helper_shutdown() properly [1]
>
> ...so it seems like just dropping the shutdown handler in this panel is c=
orrect.
>
>
> [1] https://lore.kernel.org/r/20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b2=
9f746b93621749c@changeid
>

Good, that is the information I need to know, I have read some of your
threads and it's ok for me to just drop it.
I will resend a proper patch for it

Michael

> -Doug



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

