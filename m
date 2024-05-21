Return-Path: <linux-kernel+bounces-185216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3D8CB234
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107CE1C21C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E241146D71;
	Tue, 21 May 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j812cEtu"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60C1474DA
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309104; cv=none; b=jzoUroVgQ75AbDb3Hc7+c0O1fvi5zFARysvk364FVwN+r6bfyHP9BAdm0CGEtBCmnyCwJAql+HnDnvg/tn5zBWbG3VZ5kQkiOobLn6TaXrydDIDkLUdFpyuPGtLErF1ZvexEtnW44qqyWy76/ZMUBmpB+LlRJL5rf9/cpWDZ84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309104; c=relaxed/simple;
	bh=FMtQ8bZEdrtosmaVVi1qzF6mzARajgwH2zTkA4s/MYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBb5L/YqmxHjHomHhWFfj4QKWIeLzvg9gCwTpLCG63n/KZfqqs9dPM4h16RGhY41VSI2t9zRIwq2tccRNJlwqRJuH23103JDKfJ4x2JJ+TisNQE5JfCmUkEGN460F96+olB0JqgRAOGszBEeS01oqcH/QRO3eknCpzPpjcwsMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j812cEtu; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4d60c59f7so432642276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716309102; x=1716913902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PyVeLHofHdp4WzmSvmqwgfOSr9jC6cNc+YLU0l0YMM=;
        b=j812cEtujQnAA5OhPHRiYXh/d21Ib/BRVE880UJFuz2m7+uzHN/lCpbejhuAjsD1t4
         B1dy/a40Nzm+vLQ/KYT77BeqGZ8aiCr+MgqdCw4R9HQjWWw1U/uS35zjaPUDB+Glc59D
         SkAPVtatNaY3P6Q0NI7EKO7RIcfeParBMgEJyyuaqfDUDfmT3FZdqXmfx88p9PTfEs8S
         9RtL7mPocKW5b1jdhnPLBnJpCBmyMNbL9aq6TygE9XF0xdvMQ18T3Vr014oX2DBjAFzq
         oSHxBe8jop1KNItDTJWgTM3DRKezBhZgzLfjR5VTdYlIs3yLZgBvmbEKNG6bYDt1DXYl
         rwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309102; x=1716913902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PyVeLHofHdp4WzmSvmqwgfOSr9jC6cNc+YLU0l0YMM=;
        b=nMMbihJHFa2qNMyvKtbZlvYy+24MYT8HyKr7C1Vx309P+gesjiL87YoTjLlGDrs1Av
         P8I1iH6+x0oTG/F97BHuLftSYM+/ZGI0h4dj3QktK4JVaEs+k7ZXRhpS08GA6jEKKLgb
         b6Zwokv3wx/8BhAP/rXORpTibB/Br7FWGx0zx3f8+VZJdOfkI7VCNsNadSNtTDHmLmVl
         b3GTVeKoKGw98IFK4Z/FQ5lN35GLWNI95+v5dR0buIIarz1N2aeq1VAVDZK1ZovgYOvM
         oL1tmXgAHpaPEk7PkfFGYxonZdg+oHwKjF8iYYqdnood4RJZilNPN1gMmqRTf5O9uOoy
         FfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8imXNKHbfTqzU+NwNxXaVl48/EhdcHgAvzXl21Q79Ah9Xunz4r7R/hFoMd1j3UKeMrkN6Y4G6RGZz8HFU55BAlHE/qYR6x7b1GGMc
X-Gm-Message-State: AOJu0YwFl6yTWcPSvjicV9QN42eVfW0SNgk8yQPz/NMcRj2ZQDUdo8D6
	kMyfO7564mAXtUYdbUISF2Nr/eYGIWYpDdIB6ihNCgbhESG49RiJX/Q9380ZJoo03bhPBdiX1Sm
	IwCIm+hXh28XPEFT6ZxS4CEMAYpM=
X-Google-Smtp-Source: AGHT+IGouykRu87CKqvCpiwGn2/ErgeBVY3RroJi0opPXDFk+JnhvROss58hW1givn2023RobSphv1PbL1vqedg3yxs=
X-Received: by 2002:a25:6648:0:b0:df3:6f14:8d81 with SMTP id
 3f1490d57ef6-df36f148e37mr16200524276.48.1716309101789; Tue, 21 May 2024
 09:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-16-jim.cromie@gmail.com>
 <CALwA+NYXBgennLhnFUvaU+U871hoiQbjNK2uRaPEd6fxPr68Jg@mail.gmail.com>
In-Reply-To: <CALwA+NYXBgennLhnFUvaU+U871hoiQbjNK2uRaPEd6fxPr68Jg@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 10:31:15 -0600
Message-ID: <CAJfuBxzNKvFGB3AyJyPRDALkZ9nNYvG33u6yZ4OWEbmNypotQg@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 15/33] dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:46=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > DECLARE_DYNDBG_CLASSMAP() has a design error; its usage fails a basic
> > K&R rule: "define once, refer many times".
> >
> > It is used across DRM core & drivers, each use re-defines the classmap
> > understood by that module; and all must match for the modules to
> > respond together when DRM.debug categories are enabled.  This is
> > brittle; a maintenance foot-gun.
> >
> > Worse, it causes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3DY regression; 1st
> > drm.ko loads, and dyndbg initializes its DRM.debug callsites, then a
> > drm-driver loads, but too late - it missed the DRM.debug enablement.
> >
> > So replace it with 2 macros:
> >   DYNDBG_CLASSMAP_DEFINE - invoked once from core - drm.ko
> >   DYNDBG_CLASSMAP_USE    - from all drm drivers and helpers.

>
> Why does DYNDBG_CLASSMAP_DEFINE take "stringified" enum name-vals ?
>

short version:

real enum vals would be better - misspellings would be compiler errors
but doing the stringification inside the macro doesnt work,
 __stringify(__VA__ARGS__) produces "DRM_UT_CORE, DRM_UT_DRIVER" etc,
not 10 separate stringifications

I have a patchset for later that fixes this,
but I didnt want to complicate this submission any further.
Its already touching 2 sub-systems, revising and adding API


> > -         This module registers a tracer callback to count enabled
> > -         pr_debugs in a 'do_debugging' function, then alters their
> > -         enablements, calls the function, and compares counts.
> > +         This module exersizes/demonstrates dyndbg's classmap API, by
>
> Typo exersizes -> exercises
>

yes

> > +static void ddebug_apply_params(const struct ddebug_class_map *cm, con=
st char *modnm)
> > +{
> > +       const struct kernel_param *kp;
> > +#if IS_ENABLED(CONFIG_MODULES)
>
> Instead of the above maybe use "if (IS_ENABLED(CONFIG_MODULES)) {" ?
> This will allow to get rid of #if and #endif which make code less readabl=
e.
>

will do.

> > +       int i;
> > +

