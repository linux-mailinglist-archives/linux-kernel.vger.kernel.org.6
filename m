Return-Path: <linux-kernel+bounces-239822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590119265C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4D81F23525
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E57181CEF;
	Wed,  3 Jul 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk4ZyBnx"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D398442C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023120; cv=none; b=c48/qd49qjODlPQphriYg1z+5uooGvPZGcwJwcfA/w8yiWy5moB1ZzXJcv/0yxgdruMcHRD6KkzXpkVl+Dlr3zUs9ytct7ZYBxtL2u0WN6D7vSNbUhTXHPVuOqISmLlc4Qbbe6F9+OUI7EO5PDgfCEu8oEktp+QwLbEfJrTEvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023120; c=relaxed/simple;
	bh=Vq2WviJPzU9+t4YbTs8q1YmTVcOSzsA58Ukn6pilCeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpANKEeKHDLOVQi2efYY5B6AcWnOJBL4oxz9dBfHBluscY6VQjOFQqwIaGdUv5zmYOMSbLfSgpGZOtBKBI0spRc+T+vk142vL8lteuyyFu8yjltxdPZ+YX+JbB6QZAcYJnkMQGfTjcK96YXImBKr1WrXWe0ZXKjgfYMYMogxNNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk4ZyBnx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7021702f3f1so2194676a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023118; x=1720627918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/dH8jV/d+x/FI16gAcv4uydOAqFjUfOw8j20FTynlU=;
        b=hk4ZyBnxmBbfcIYTT+95kuyZfKtEndK20EM0LaKcBw8pb/AS/X3pnCkz3PtCjB7MZi
         nSiWDUpJX/AXgpSN1kZOVLAFyZX52hARCrmPdY4cJI7bXTwWA971PNsoiZItE9PvsQ1I
         /riD89cr3k+eRK9HRAsHIwJzp1tELKEIPziUgd/1y7xG1mOrlFucQzPcg79xmVzdKiO0
         z35+lCC9nCb2kDPIgylp/x4vOfP+Rm1t+I/RlM4Uo4IajvAaACbHwKaiq56if5wp7rRj
         n5w2x+ZkWriJ/D6NWs4aLnGf7+zPL3Lq5KM4HA6j9bewVVlDZHFJfm4UZNIuKaXlZ+qq
         lO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023118; x=1720627918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/dH8jV/d+x/FI16gAcv4uydOAqFjUfOw8j20FTynlU=;
        b=m99hyeGbWqfiMlKSEFRZiGzq9ZdKRnUOOeClvyn/3IRlN5RWE5IWkBB+msp2kZNXws
         n9FMpKCiT6qe8xvNcij5XK3MqMuD2pS3dEAhxj8blv/XUzMYgvoeYp9dy2XM3BDnU/tK
         UsPh4rr8jqX5Mmd7cj5APaRgWwx8ztdYyladkR+1Nw6wklf8pNhU5Wn8E7DJe/oHk5n6
         T1zxG5hP/3FQqnJ9bDUyPap3c0utK2iUYGIfDaKLW/BSeysRD2FKROkbSC51QyO7q3uY
         4RB5cERqWo9CLZp93E+oJbzd0imCBVcTLtPCGDQi+M/BU0iAmz3V3iIEKMLsUP0/Hut1
         rjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSxQ9c/SK2RG4IMDDeOkHZSG6yhlHcnixahEaDJHB0m3RnE7vFKxC6dXlr1g20CEDXT1hLnfBW2D5UYPc/jv6+NWSA6YPRL5wRWKfE
X-Gm-Message-State: AOJu0Yx3KV7dRPeTrZgruUsgaxb7BGsdibl9Gs4ol9b0xY92NXqKmICf
	ftCwA2/SUihxYzo/6mfDnOYCETp4yLQunv2KvSfO7CA26o8xPAxUfTuGL2poleGgSPzfMbt5upD
	/anOO8s6C6IXYVdDwlcaIWKchop8=
X-Google-Smtp-Source: AGHT+IHHyVJ7tvgjX6YNT5yXxjT4ZfaP2CSlRVqBQQ9Svv1tUxG/jN+Xkt79kJWNOKN+ENdTMdSGcTnRp+qX6KDNUkc=
X-Received: by 2002:a05:6808:1909:b0:3d5:5e58:528b with SMTP id
 5614622812f47-3d6b2b24045mr15706235b6e.1.1720023118007; Wed, 03 Jul 2024
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-31-jim.cromie@gmail.com> <ZoSOMClB0MeWeokU@intel.com>
 <CAJfuBxzsZUpO-Q_uAfMhzXs0WHYMTnj1F8ju7af-kQZKQjLvNQ@mail.gmail.com> <ZoU7kR2aYwVDvd_G@intel.com>
In-Reply-To: <ZoU7kR2aYwVDvd_G@intel.com>
From: jim.cromie@gmail.com
Date: Wed, 3 Jul 2024 10:11:31 -0600
Message-ID: <CAJfuBxwVWbJ9TdgH0ARmxUy+_DfNVKrTewjkqWKmCQtfOKQEAg@mail.gmail.com>
Subject: Re: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	ukaszb@chromium.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux@rasmusvillemoes.dk, joe@perches.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it.
I had some mental block about passing designated intializers as macro args.
it just worked, I needed to eyeball the .i file just to be sure.
thanks.
I have a fixup patch.
whats the best thing to do with it, squash it in for later ? send in
reply here ?

On Wed, Jul 3, 2024 at 5:52=E2=80=AFAM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Jul 02, 2024 at 08:34:39PM -0600, jim.cromie@gmail.com wrote:
> > On Tue, Jul 2, 2024 at 5:33=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Tue, Jul 02, 2024 at 03:57:20PM -0600, Jim Cromie wrote:
> > > > dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried =
to
> > > > do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
> > > > EXPORTs the classmap when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, for dir=
ect
> > > > reference by drivers.
> > > >
> > > > The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they stil=
l
> > > > redundantly re-declare the classmap, but we can convert the drivers
> > > > later to DYNDBG_CLASSMAP_USE
> > > >
> > > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
> > > >  include/drm/drm_print.h     |  8 ++++++++
> > > >  2 files changed, 21 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_prin=
t.c
> > > > index 699b7dbffd7b..4a5f2317229b 100644
> > > > --- a/drivers/gpu/drm/drm_print.c
> > > > +++ b/drivers/gpu/drm/drm_print.c
> > > > @@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, w=
here each bit enables a debug cat
> > > >  #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> > > >  module_param_named(debug, __drm_debug, ulong, 0600);
> > > >  #else
> > > > -/* classnames must match vals of enum drm_debug_category */
> > > > -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_=
BITS, 0,
> > > > -                     "DRM_UT_CORE",
> > > > -                     "DRM_UT_DRIVER",
> > > > -                     "DRM_UT_KMS",
> > > > -                     "DRM_UT_PRIME",
> > > > -                     "DRM_UT_ATOMIC",
> > > > -                     "DRM_UT_VBL",
> > > > -                     "DRM_UT_STATE",
> > > > -                     "DRM_UT_LEASE",
> > > > -                     "DRM_UT_DP",
> > > > -                     "DRM_UT_DRMRES");
> > > > +/* classnames must match value-symbols of enum drm_debug_category =
*/
> > > > +DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS=
,
> > > > +                 DRM_UT_CORE,
> > > > +                 "DRM_UT_CORE",
> > > > +                 "DRM_UT_DRIVER",
> > > > +                 "DRM_UT_KMS",
> > > > +                 "DRM_UT_PRIME",
> > > > +                 "DRM_UT_ATOMIC",
> > > > +                 "DRM_UT_VBL",
> > > > +                 "DRM_UT_STATE",
> > > > +                 "DRM_UT_LEASE",
> > > > +                 "DRM_UT_DP",
> > > > +                 "DRM_UT_DRMRES");
> > >
> > > Looks like this stuff just ends up in an array, so presumably
> > > it should be possible to use designated initializers to make this
> > > less fragile?
> >
> > Im not sure I got your whole point, but:
>
> I mean using
>  [DRM_UT_CORE] =3D "DRM_UT_CORE"
> instead of
>  "DRM_UT_CORE"
> so there is no chance of screwing up the order.
> Or maybe the order doesn't even matter here?
>
> Could also stringify to avoid accidental of typos.
>
> >
> > the fragility is the repetitive re-statement of the map,
> > in those un-modified DECLARE_s,
> > once replaced, the USEs just ref the struct built by the _DEFINE
> > (once, and exported)
> >
> > I dont really like the _DEFINEs restatement of the enum-values: DRM_UT_=
*
> > especially as "strings".
> > I can automate the stringification with an APPLY_FN_(__stringify, ...)
> > but the enum-list DRM_UT_* (w.o quotes) is still needed as args.
> >
> > unless there is something C can do thats like Enum.values() ?
> >
> >
> >
> > >
> > > --
> > > Ville Syrj=C3=A4l=C3=A4
> > > Intel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

