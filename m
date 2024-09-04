Return-Path: <linux-kernel+bounces-315121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9DF96BE2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC201C2507A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88861DA115;
	Wed,  4 Sep 2024 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ6Bxug5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A71D9340
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455944; cv=none; b=iTz7f5kCgTO13W5wM92ftq35afM46dLP2Nk0UgLRGZTl0bpLBix+PFmK5aXudI8aQiO9pF0W3/mjbR/2UCRRIMWa8wY3QA08+fsQRHENUWm8M+w2Vw1kD5d+t+4oFVMdKTjKpWwhkXPNZCsEiMud+iJfmciLZknxv0rhZ+Zn460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455944; c=relaxed/simple;
	bh=iQaWUuNayeHsxNpsOPsmiP87PVA1V+997ba5NP2/0SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyjt4UkAne5qjqkYffrE1wwoqHsQuqWMi2mrapBGQ5y3AAOp5KsTb3EnJLhJIRzSbIZoAdqFFM00MhzbJhxKPCxSh0iQF7y8aP0P3xobcZm8lInjNfPJcrzeder1ulTJW6pXHn+kPls4UUiuxvvZqcv3cek/LbzTkzOsazRHrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ6Bxug5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A280BC4AF09
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725455943;
	bh=iQaWUuNayeHsxNpsOPsmiP87PVA1V+997ba5NP2/0SM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JQ6Bxug5FhdirKhlMS1LzSU6cK2X+gpcfN6ByVYAKVerwhVesNzvrzk0mC/HPIQc0
	 lQeDy1hGLjolv05LmG5ykgFQF5d6Csmed1Du/0yr4libZAqzSKaFy72YuH8D5wEOjc
	 q0Wps9kL5iFimSZABpuFj6y/taVXrJikZTmh51N0mGc4NCY33V/RjPSmvat2IUUagC
	 CpBY4mQDVvwk0AGtdC6DSgoDQQ6O2ZMjrL6c31qkSC0R3WtH5Nxo7phd2VGZaG82mF
	 SDgXXFMn//JMH+FxWYwg9KeDtYzH10fCmRjIIb8RoBINE+W53/7ITOlT4cHONZq8lK
	 rZE3TmElDEsxA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso81995051fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:19:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb8yfp6W5trXqXegiQHh+6AcsTN/JNlHqqQgKeAc1EuAIckiW2VVwgrkS+nQSDXdEypzX0g1F6/5Ac6aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHI183Dw5E5Ug5ceEBW61Y4x27kCa7fDoQlkqZmd/kDYWnroEx
	5AJqaSPoad+frKzauZPfrsGVXNnTabtP2Iwuk6GpR2UcIWBDUycNZ9F2ouiPPI7OYgrToIGcte2
	6mSerO6NSGmr52oLGJtTNIO/0TA==
X-Google-Smtp-Source: AGHT+IHUUeSgzSozkOQHj26+7oHV3+xzw+ZQjg6TFrBfWOYCsaBdvEQOe4/S7wY/3OtormH15qUALYau8GIPppWD+UI=
X-Received: by 2002:a2e:bc0b:0:b0:2ef:251f:785 with SMTP id
 38308e7fff4ca-2f6265503femr113203391fa.1.1725455942007; Wed, 04 Sep 2024
 06:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org> <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
 <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com>
In-Reply-To: <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 4 Sep 2024 08:18:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com>
Message-ID: <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Rob
>
> On Tue, 3 Sept 2024 at 20:19, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> > >
> > > Use of_property_present() to test for property presence rather than
> > > of_find_property(). This is part of a larger effort to remove callers
> > > of of_find_property() and similar functions. of_find_property() leaks
> > > the DT struct property and data pointers which is a problem for
> > > dynamically allocated nodes which may be freed.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Ping!
>
> Sorry, this fell through the cracks.
>
> > >
> > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4=
_hdmi.c
> > > index d57c4a5948c8..049de06460d5 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi =
*vc4_hdmi)
> > >         struct device *dev =3D &vc4_hdmi->pdev->dev;
> > >         struct platform_device *codec_pdev;
> > >         const __be32 *addr;
> > > -       int index, len;
> > > +       int index;
> > >         int ret;
> > >
> > >         /*
> > > @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi =
*vc4_hdmi)
> > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D 0);
> > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
> > >
> > > -       if (!of_find_property(dev->of_node, "dmas", &len) || !len) {
> > > +       if (!of_property_present(dev->of_node, "dmas")) {
>
> The existing conditional is true if the property is not present or is 0 l=
ength.
> Your new one is only true if the property isn't present, so it isn't the =
same.

It is not the kernel's job to validate the DT. It does a terrible job
of it and we have better tools for that now (schemas (though RPi
platforms are in a pretty sad state for schemas)). I'm pretty sure a
zero length or otherwise malformed "dmas" property would also cause a
dtc warning as well. Non-zero length is hardly a complete test
anyways. Any bogus value of "dmas" would pass. Or it can be completely
valid, but the DMA driver is not enabled (whether you even probe
depends on fw_devlinks).

The kernel should just parse the properties it wants and handle any errors =
then.

>
> Is there a more appropriate of_ call to return the length of the property=
?

There are several which are all based on the data type (string, u32,
u8, phandle+args, etc.). This case would be
of_count_phandle_with_args(). Unless you required something like 2
dmas entries instead of 1, I wouldn't use that here though.

Rob

