Return-Path: <linux-kernel+bounces-319024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C255E96F69D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7921C2261F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6B1D1756;
	Fri,  6 Sep 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rUp2+tha"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3011D1724
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632687; cv=none; b=NhFuVsf1Xw0uFkmr9/A0nJ17VCgos/2JtTXAwr0b5NLmORgxYncZNGhA7048PnTJRxZ7MhAYV978U2B3dA7QdcYLi8pAO+4tr+REoRhd1cNSj1c4Hmxb3Mp/sdxj6lxpvGUlJTtnbrjdSn5o32ls3ZGxoRkNOaH6Jg9qaqR4KT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632687; c=relaxed/simple;
	bh=xTI4ohfs6ZhMCriwMEHyqjwYhMCUIWAAW0noe3ImitY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0sNIWG0qsvlORByIj3vBAoQzV2+4kyiKJJ99fB/dqgpCbHmSwlB5GGQRQEGjfDQD5qb7hMEi0VGihLLfifMpv4tzy/NGj3BGzfhrKV/TabLGJqRScoJ4Hv5/kXA6WJDNB3Kvv4O8dm0ya6Mvpay2Jmj+qbcJYXrgFZrE9GL/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=rUp2+tha; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a90780f6dso2185135276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1725632684; x=1726237484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8upxWrhNyZy+NKkFxmG2+Tbfi/9d0hGpUln0sB+Ifk=;
        b=rUp2+thaVub6rZ8PlgVkEPBeuL9EjYne0KMHhtZ2tKhW+FRoNPQKOMRPbN0FHkgBGh
         rct7AlliDMy4G5hMg5tUU3QwwmCH4YxJ5sJyPmVp87Vw15NIvkYDvjaFl52mn88snuKT
         ZkXMjnP52TAwOMMSO/4QxUHpm9MA0rh3ZBDiXAxcz+cNJ1Zs0jzeKmTgzhWOh+Jb/sbk
         i/4qwO07kNlJMikBOtjRkpxnqYMChCQcPiODJWp5Z3mW7m3X+FR67iCz6fscKLVdaN/Q
         YhAuISSqWYM9KZ9nz2XGXPhz9GaFLx5HT2dAJ8p29UQQe/XFRbR6iMSC+s2q7eTU+t7z
         9mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632684; x=1726237484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8upxWrhNyZy+NKkFxmG2+Tbfi/9d0hGpUln0sB+Ifk=;
        b=ZkBcGbiq2locFXomdZKHXpb1zBZ8EXiI+5/c5OAo2ukQ1v3EsxB0qb2NFiNbfYJlRU
         SetwXFHuex4dFbWdSARe7bdZv+MnHp2d9lfEmfGbJvOTklv+cqfAG8UvCNSDrfPUxbPd
         1tYIf1Sc7mS6HlyC1BRYtnEuddG3vJSkSFEZKMoFFJBxwCKntKa+erEcJmc5hLF/Tl4Q
         n1EDz85iwhKZYhfClplCgAajL3CoBBU2rsmXhrDR9DufWGVctw4JGhZ/ufTl/LwkJsPv
         wv3YcgrRwJwXa6F947rmIP47AGOLY9MoGSRpmofMFCHRA/7EfiEaOtXa0/FUr7SUpLey
         eDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqg93gKNMljaNkXO0qwN5cIz/xOGKa51cNeLDkS2TjevxpomRhHKAdT/0Jkd0rMyiWR632qh90LcdB/Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtBeDEtWJ6imOUxeRF/cy86ZLfVjw0TMf7r7k7E0oc2fPxzlm
	mQ2f8P7Q4iEMkpVwflGp+G5pWeA5tSMVTmdATF2Aw/j0TsyQVCWK/6PEXEYrlB/Pmjn31GdHB+x
	ai4SBnfMCM1JO2o1NqVDYW2HkUamNT6TIufn0uQ==
X-Google-Smtp-Source: AGHT+IF4IYCGA4TBwaurNOJuIBO9gF4jdAwiekpYJjy5zBtMoqX8s84RmLYpleVlyy+Sj4InWZismzm0fDYsFOMZquQ=
X-Received: by 2002:a05:6902:2513:b0:e1d:2f11:3eb9 with SMTP id
 3f1490d57ef6-e1d3486c386mr3504573276.2.1725632684260; Fri, 06 Sep 2024
 07:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org> <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
 <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com> <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com>
In-Reply-To: <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 6 Sep 2024 15:24:28 +0100
Message-ID: <CAPY8ntBJL9nJupadT8T1DGeQHn++MRGKbyH5xSF94a0moqWGYw@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Rob Herring <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sept 2024 at 14:19, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Rob
> >
> > On Tue, 3 Sept 2024 at 20:19, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@kerne=
l.org> wrote:
> > > >
> > > > Use of_property_present() to test for property presence rather than
> > > > of_find_property(). This is part of a larger effort to remove calle=
rs
> > > > of of_find_property() and similar functions. of_find_property() lea=
ks
> > > > the DT struct property and data pointers which is a problem for
> > > > dynamically allocated nodes which may be freed.
> > > >
> > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > ---
> > > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Ping!
> >
> > Sorry, this fell through the cracks.
> >
> > > >
> > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/v=
c4_hdmi.c
> > > > index d57c4a5948c8..049de06460d5 100644
> > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdm=
i *vc4_hdmi)
> > > >         struct device *dev =3D &vc4_hdmi->pdev->dev;
> > > >         struct platform_device *codec_pdev;
> > > >         const __be32 *addr;
> > > > -       int index, len;
> > > > +       int index;
> > > >         int ret;
> > > >
> > > >         /*
> > > > @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdm=
i *vc4_hdmi)
> > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D 0);
> > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
> > > >
> > > > -       if (!of_find_property(dev->of_node, "dmas", &len) || !len) =
{
> > > > +       if (!of_property_present(dev->of_node, "dmas")) {
> >
> > The existing conditional is true if the property is not present or is 0=
 length.
> > Your new one is only true if the property isn't present, so it isn't th=
e same.
>
> It is not the kernel's job to validate the DT. It does a terrible job
> of it and we have better tools for that now (schemas (though RPi
> platforms are in a pretty sad state for schemas)). I'm pretty sure a
> zero length or otherwise malformed "dmas" property would also cause a
> dtc warning as well. Non-zero length is hardly a complete test
> anyways. Any bogus value of "dmas" would pass. Or it can be completely
> valid, but the DMA driver is not enabled (whether you even probe
> depends on fw_devlinks).
>
> The kernel should just parse the properties it wants and handle any error=
s then.

I've followed up over the rationale of this.

The base DT enables HDMI audio.
On some systems there is a need to use the DMA channels for other
purposes and no need for HDMI audio.
As we understand it, an overlay can't remove a property from the base
DT, but it can set it to being empty. (Please correct us if there is a
way to delete an existing property).

The current check therefore allows an overlay to disable the HDMI
audio that is enabled in the base DT. It doesn't care how long the
property actually is, just whether it is totally empty or not as an
alternative to being present.

I understand that you may consider that abuse of DT, but that is the
reasoning behind it. We can drop it to a downstream patch if
necessary.

  Dave

> >
> > Is there a more appropriate of_ call to return the length of the proper=
ty?
>
> There are several which are all based on the data type (string, u32,
> u8, phandle+args, etc.). This case would be
> of_count_phandle_with_args(). Unless you required something like 2
> dmas entries instead of 1, I wouldn't use that here though.
>
> Rob

