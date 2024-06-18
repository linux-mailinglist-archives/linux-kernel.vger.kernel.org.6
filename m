Return-Path: <linux-kernel+bounces-219029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D690C8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0819E1C219A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6E15AACA;
	Tue, 18 Jun 2024 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptlSLm6K"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CF158DD1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705267; cv=none; b=SqtL2UhRq/lC1tJ2jt/z4T4Jmf2s5ymi0WDjuzesFzvnKggByNnEDhdw+5A8UlUuLxPSTlyP+88vrbwjLTfaEDa0i+RLSyZOoZeT9N0duAXbwPxqucleD5flCSerkzF28STZ6J7asYvQjmE0RUPnyb7VeNoYaLN2T7/ApnVPWAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705267; c=relaxed/simple;
	bh=v/D5FL4vw3khVU80PEPJGR8EkUujjMjlydKlY4DDxls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4Bozlijukb/jO/GNovt8IreYKos7mm+b0SW7M7qgEaL0N3O4/FeTuQO2SPHL/QHZ/vO+5pC8QMXY1otu6+AxIUfGMIoT0Wj81D3KZgsAsoJkk65ZrxDoAAGloEDC51e6lRMyEdymK+2kEBVh0+BK6eoCYDG6shHvsiJktLqmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptlSLm6K; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so4996836276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705265; x=1719310065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCx7fOAnUmTX/Xe4ctYyfLYc6JY69uTQO3mrnLIZgkE=;
        b=ptlSLm6Kgl0CaAFzOYbmLSkmO6PFBF5hTp7xc4IXHSfoKGzt96F5d08DK26Zg/+kzp
         Vx7b2ANWxNluZn3annDPgNELO7emRBwCAlPUH+WdprJVDc+wzwxIEtSy+vmqlryM1etQ
         PU3bgzk0LXRYh9He5B/laGd8SAA/THXHCkd1CeFZ1PnDd9fTLiCUHyZouw4dxo/FNA9r
         8jrjxTiH5awm0HQQwBDAxDNCNFRhWuU+f0uZ/q97mba+dIcI9261S117XFy+nyJuHANs
         2t/jwGssWmLY+TO/Pv6kcgjW2CStAs/rMAjp6axspBayx+ytc14Ir6MvyL1zeiAPYjIN
         0wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705265; x=1719310065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCx7fOAnUmTX/Xe4ctYyfLYc6JY69uTQO3mrnLIZgkE=;
        b=CNcPu1w9RrMIoAO3AJRElTU/3QxDRTvie86kWHCFbeyt7GqJUI9iJ1jD9gFbBVwEmC
         TnUhpB3J75jG7Pygmz1RAUcXwgF8zfY3eD5IehmElpCGfi2S7ks78srDQm7VtSJHRygS
         Lz6VpBirzvD3k75zT4RwdcT6Ta9DDdWHFoV1+xWQ3iU+5H7Jt3jZB7Sn1+w05PDsflrw
         EeaNvXQQ1doH0IdE/Swl+bUmdFdxCJ5Ik9UC84xaf3N4tP9uw8CdUFm46LOZ8LmOt8N+
         Xfkqgb36/4VQzhablzcnOOZ0y3niWPYDt/xrzZhnSyqcTCuIWzzQHYxayY8nh3MHxDPq
         3sEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWanBwdigiunwbRIDQ/ag3UM8NReZplMMGXng9gblkpzDWijYpkFn3P7Y/XJ2HCjc8gXtszDQk/cTCMNJQCH5/FBkxmCziJST3goEca
X-Gm-Message-State: AOJu0Yy2iqynXeuVC3hlOzUf8O8x4FH6kq1qzD0RfmgsVOOpoBb6YoJ/
	V78dXX6JRkF0VyoMx7CmGZuwFAqLcBfuhxIghiS+f2r1TsFY666iwW2ISYKANWphhFRrsAOrKH4
	tOaBnsK77NIfbdrG9+X3z8r1c+Zd8p5X/1j4BNw==
X-Google-Smtp-Source: AGHT+IFJ0kiksoEZDocVzYOcTdne8U7N6C+jsZexpeus6Jap6pxdsUb8A3nFZ7pup6bdeGO4XrwkK9/1Lawl6Ll+PGk=
X-Received: by 2002:a25:abe1:0:b0:de4:828:b73c with SMTP id
 3f1490d57ef6-dff154d21d2mr9969203276.54.1718705264631; Tue, 18 Jun 2024
 03:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618030024.500532-1-andrealmeid@igalia.com>
 <20240618030024.500532-3-andrealmeid@igalia.com> <878qz2h9pp.fsf@intel.com>
In-Reply-To: <878qz2h9pp.fsf@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 18 Jun 2024 13:07:33 +0300
Message-ID: <CAA8EJpqM4iaG3PKM5c0Op7Y7c1SRDrOCk_oOnwG8YfdCxC8w6g@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] drm: Support per-plane async flip configuration
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 
	=?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
	=?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Karol Herbst <kherbst@redhat.com>, 
	Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 at 12:38, Jani Nikula <jani.nikula@linux.intel.com> wro=
te:
>
> On Tue, 18 Jun 2024, Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > Drivers have different capabilities on what plane types they can or
> > cannot perform async flips. Create a plane::async_flip field so each
> > driver can choose which planes they allow doing async flips.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  include/drm/drm_plane.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > index 9507542121fa..0bebc72af5c3 100644
> > --- a/include/drm/drm_plane.h
> > +++ b/include/drm/drm_plane.h
> > @@ -786,6 +786,11 @@ struct drm_plane {
> >        * @kmsg_panic: Used to register a panic notifier for this plane
> >        */
> >       struct kmsg_dumper kmsg_panic;
> > +
> > +     /**
> > +      * @async_flip: indicates if a plane can do async flips
> > +      */
>
> When is it okay to set or change the value of this member?
>
> If you don't document it, people will find creative uses for this.

Maybe it's better to have a callback instead of a static field? This
way it becomes clear that it's only relevant at the time of the
atomic_check().

> > +     bool async_flip;
> >  };
> >
> >  #define obj_to_plane(x) container_of(x, struct drm_plane, base)
>
> --
> Jani Nikula, Intel



--=20
With best wishes
Dmitry

