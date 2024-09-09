Return-Path: <linux-kernel+bounces-321145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFB97152D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C911C220DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A11B29D9;
	Mon,  9 Sep 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="JCUeuMjl"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CB1AC8BF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877137; cv=none; b=M5TI2+/gT3g55bYhRGyZOPLVfKMVw7BXv5R8xAIusOqeCpkmLdQFjdKrwvb3jGEBX8MQ+/z3YpydNI5dD5VFPY9tEEaS+hVvLn4GbxITMVBR16759NziscwAd8PrtxTE/WQyBp52JplpxWrHNwm5Vgf3aZnDjJcBkeE5VyGbhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877137; c=relaxed/simple;
	bh=zQtYlSIQe4XDVixP+6H7WqFNgYzOL/m5CZbxuJud+40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8q4J/kbXy1rieFI9PhaNf/2h2LHJoQyz/q6nVZRIjv58Jo+7AjynOfY9Gqcn0T4OB5XU4dn1j9PXXS9g6OG6MRJzC09wvK28T/8qUyVeB2OJNR5by1e9sxuN2N+ZdUmpP25+46bs6O9KHRu+grmx4av7vGeH8knlC8Egymz2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=JCUeuMjl; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a7f1597bbso2951282276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725877134; x=1726481934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXL1j2tV411PkntAScb6rIKgAFaqv0ENfS30cqvdFFs=;
        b=JCUeuMjl78QTohUwmk+CvOVXVRReAjxLpYzc08r71xA2JvmAUldgG+9yqRP36MERsx
         1M4HxUZnvlhwihuDJqKvGtOlWfbxQwCrNhYKr/wD5RcJFcqz0z18FXKjy4tx7iTYgJgk
         Hhcc6Lcy5oAHjIz5Kz5UbFkJCqqVqUvY5nuWWxVRslmb49C5SlkSY4xJvZAx6GAvNmMh
         oBjkrZMedMLaHWUNIBf1VjPrcNAQ6XqRsdRs5zgR41FxLipvSt1oN4TBO7o2pabLjRCL
         ccU4bQ66X3arPeZYMI2N4t2rwGLdjj33zPTQOqX0fr5SQtjsbGnv9gFnsgwuT3E0Y6vp
         byrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877134; x=1726481934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXL1j2tV411PkntAScb6rIKgAFaqv0ENfS30cqvdFFs=;
        b=RpfTkn7MgfYc+O3UnG7cZRylojfCq38j9ehr+evVlx7AaI9I194Lmpa+vID/x0+Th2
         KiDFG0zpNkuNziwmW4NnaCiha+bx6MQEkQKhWj9DlI243bXdKGvzsSEnQe1YjjxJWAWa
         xZ39D1yFxPBDRyxHCTA8tjEeXHToK9Rv5eA0mN/xiZftLMvk9EX/HylI3EVYRqZJyQND
         ew2DFxe3R15mmFGybhiog2uvPebwbSnHPXkWD8tQwz92wPf+YiTa9552GrZxdMjOBz8/
         a8PDFdX5X4xzN52qobzypucWn9EnS3SHVrm/baQMcK/41e4jSaCZsH+v98ZhYXmZVXlF
         Ih/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCQW63fV/fA1skzHNLG2j4abVYusgMbTgStijFLHQXGE34K6j9hqgTNtPswOCWa7N7wVRUdSgFCbvIH/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YySB9c0g5C+WxPhtTLKLVtm6rqi1nnfa9tCCYc3suoELkwbPMlT
	SrLb1r6FbOrIN3PJX/Bnf37fviyDGmdBUCmusaoXjGlaQYq3egSzAfYIQiXQ9yjqV0j9Z1scxIM
	L7vtnuKYqyZpke+oby+8DSBQ9s8dNG9sYybBAFA==
X-Google-Smtp-Source: AGHT+IGg+H7CMIcAgfHAMyjf21XU26L1ocR5NRCUCu1cmYYZEZfDhB49cvkQMtwd59oqMMAaEiAaP8DL29pnlOaSndc=
X-Received: by 2002:a05:6902:1895:b0:e0b:1049:f935 with SMTP id
 3f1490d57ef6-e1d3425cf96mr9361083276.6.1725877133966; Mon, 09 Sep 2024
 03:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org> <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
 <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com>
 <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com>
 <CAPY8ntBJL9nJupadT8T1DGeQHn++MRGKbyH5xSF94a0moqWGYw@mail.gmail.com> <CAL_JsqKZSk+zY49CAzDisA3kBQf46TOvN-OF+wTH=LGLGwSQUw@mail.gmail.com>
In-Reply-To: <CAL_JsqKZSk+zY49CAzDisA3kBQf46TOvN-OF+wTH=LGLGwSQUw@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 9 Sep 2024 11:18:40 +0100
Message-ID: <CAPY8ntA68Gik+xi2s6YXPbydUZWNV5eqpGeMwv6z06YVEQktZA@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sept 2024 at 20:15, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 6, 2024 at 9:24=E2=80=AFAM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > On Wed, 4 Sept 2024 at 14:19, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Dave Stevenson
> > > <dave.stevenson@raspberrypi.com> wrote:
> > > >
> > > > Hi Rob
> > > >
> > > > On Tue, 3 Sept 2024 at 20:19, Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@k=
ernel.org> wrote:
> > > > > >
> > > > > > Use of_property_present() to test for property presence rather =
than
> > > > > > of_find_property(). This is part of a larger effort to remove c=
allers
> > > > > > of of_find_property() and similar functions. of_find_property()=
 leaks
> > > > > > the DT struct property and data pointers which is a problem for
> > > > > > dynamically allocated nodes which may be freed.
> > > > > >
> > > > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > Ping!
> > > >
> > > > Sorry, this fell through the cracks.
> > > >
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/v=
c4/vc4_hdmi.c
> > > > > > index d57c4a5948c8..049de06460d5 100644
> > > > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > > @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4=
_hdmi *vc4_hdmi)
> > > > > >         struct device *dev =3D &vc4_hdmi->pdev->dev;
> > > > > >         struct platform_device *codec_pdev;
> > > > > >         const __be32 *addr;
> > > > > > -       int index, len;
> > > > > > +       int index;
> > > > > >         int ret;
> > > > > >
> > > > > >         /*
> > > > > > @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4=
_hdmi *vc4_hdmi)
> > > > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D=
 0);
> > > > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
> > > > > >
> > > > > > -       if (!of_find_property(dev->of_node, "dmas", &len) || !l=
en) {
> > > > > > +       if (!of_property_present(dev->of_node, "dmas")) {
> > > >
> > > > The existing conditional is true if the property is not present or =
is 0 length.
> > > > Your new one is only true if the property isn't present, so it isn'=
t the same.
> > >
> > > It is not the kernel's job to validate the DT. It does a terrible job
> > > of it and we have better tools for that now (schemas (though RPi
> > > platforms are in a pretty sad state for schemas)). I'm pretty sure a
> > > zero length or otherwise malformed "dmas" property would also cause a
> > > dtc warning as well. Non-zero length is hardly a complete test
> > > anyways. Any bogus value of "dmas" would pass. Or it can be completel=
y
> > > valid, but the DMA driver is not enabled (whether you even probe
> > > depends on fw_devlinks).
> > >
> > > The kernel should just parse the properties it wants and handle any e=
rrors then.
> >
> > I've followed up over the rationale of this.
> >
> > The base DT enables HDMI audio.
> > On some systems there is a need to use the DMA channels for other
> > purposes and no need for HDMI audio.
>
> If that's a user decision, I wouldn't use overlays to decide that, but
> make it a run-time OS decision...

Raspberry Pi users tend to mess far more with the hardware
configuration than on most other platforms, so they do want to make
these changes when adding extra external peripherals, but they aren't
DT experts.
AFAIK configuring audio availability like that is not an option that
can really be pushed fully into userspace through any current API,
which would only leave a module parameter, and those generally seem to
be frowned upon these days.

> > As we understand it, an overlay can't remove a property from the base
> > DT, but it can set it to being empty. (Please correct us if there is a
> > way to delete an existing property).
>
> There isn't currently.
>
> > The current check therefore allows an overlay to disable the HDMI
> > audio that is enabled in the base DT. It doesn't care how long the
> > property actually is, just whether it is totally empty or not as an
> > alternative to being present.
> >
> > I understand that you may consider that abuse of DT, but that is the
> > reasoning behind it. We can drop it to a downstream patch if
> > necessary.
>
> I guess it's going to be use of_count_phandle_with_args() instead.

I'm happy with that if you are.

Thanks
  Dave

> Rob

