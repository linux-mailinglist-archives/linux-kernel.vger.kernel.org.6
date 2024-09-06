Return-Path: <linux-kernel+bounces-319397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A8896FC03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F57B23E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B71CE6F8;
	Fri,  6 Sep 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNBrTrTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B131C86FB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650126; cv=none; b=UP686WDEfsRlCBDNc7aTo5H2JwOzuID3tEe03wlWww9dp3Y6YDZBx2UwdluXoS+iBdYzAufW2ngw3dJgrOMtF+VSl37T5VbT+cC9ME7HrCV/pwY1wXyQYnRlcnZ9frwfTStyYFXrBy9hTU4q6yY+UUvOB33ErVT7oYyUqT2NoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650126; c=relaxed/simple;
	bh=8PYtUzBcRzDR+BkqAPJy0YFiShnPQgO2syJSUrN07gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=th1UpOsTL/KHu742xZIqy/wZYCJ8qWJ5fz4Td7CE+CZ5M3YB0/2tZrmdXT58jxzYj6yew7DBZASK63ELprxKaJ5DCE5XucwCN462MHaM+Wk4HdvNLMUysBBLQ2+RrnSvbwD1buvsaiyms7fezsn76n4vKX/bceFGYVwK8Fk7a7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNBrTrTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F8BC4CECC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650126;
	bh=8PYtUzBcRzDR+BkqAPJy0YFiShnPQgO2syJSUrN07gE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oNBrTrTAYqb5KVvZmDYXr/Tw1x3q2PzUQw1iCxKVBQIGMk9jv/ujH8K6Oz/Xb5lyE
	 zITJ6p6plvdQZy1zcSOKHAyO4JjvCQy7Y24Yu3n+1+XRIrwr7efRcyEcRD2Cj4ciME
	 yUOsSxscNyPTcLXk3JreInQAnNknQIuEPzy0YqHvQDl9ZBY/CiFuz3ANmm4nrSMPWV
	 rTx4TGMdsqZPUB/HVxpY3/Siw92u26oF0PoZTNsZOwQDm40aY64R4Svbaii67UBWsW
	 cVZxotgdPvCM/1MKM+xF3tv4obg45rv5I4JjZgx24MVlpV4qjuSrDifnDYjRz0XT5Y
	 dLIAngWfoW4kg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365c512b00so554712e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvGkipZNKXuNbvMIRutDptg3oPfcNoBAYKaCXd86/9I9tcXLE/1+9t7q4dXVQyDR5LMzbzz5hglEyz+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXmai09gyZM6OUYMk8cbr/hUg9Y0oEDF4BZV8hD42FEBpM2pK
	mkAyj8QLPNWH6IpjWPgL9qULD56uvzQ3loAv9txXKY+XHwa+pPO2wIv1L+UjkVUdjV9tiYsln5D
	KIUw608up7MDnotmY5Ws/ehW9sg==
X-Google-Smtp-Source: AGHT+IESGdRuCUkts+rxu7pfXA/qAjquHWsXBUeusiW4kkmLl2lNFAhP28jMC+hCB9hG78a+QRBP6Rs8ZXuOucr3RL0=
X-Received: by 2002:a05:6512:1289:b0:52e:9fda:f18a with SMTP id
 2adb3069b0e04-536587f5be1mr2777799e87.44.1725650124666; Fri, 06 Sep 2024
 12:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-12-robh@kernel.org> <CAL_JsqKvA0Uw7uqpmdMP7Z4mL3Qsmay5Fqb4M97s=QsBW_Nxyg@mail.gmail.com>
 <CAPY8ntAv3Xpq45ykwX_98WJKFBxqP6Os+6KvD5xzDTFz8a1idQ@mail.gmail.com>
 <CAL_JsqKjRbHCeFoZDE_wss5HMNmt8UBWa+y_8yJ6TC80xxiTOA@mail.gmail.com> <CAPY8ntBJL9nJupadT8T1DGeQHn++MRGKbyH5xSF94a0moqWGYw@mail.gmail.com>
In-Reply-To: <CAPY8ntBJL9nJupadT8T1DGeQHn++MRGKbyH5xSF94a0moqWGYw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 6 Sep 2024 14:15:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKZSk+zY49CAzDisA3kBQf46TOvN-OF+wTH=LGLGwSQUw@mail.gmail.com>
Message-ID: <CAL_JsqKZSk+zY49CAzDisA3kBQf46TOvN-OF+wTH=LGLGwSQUw@mail.gmail.com>
Subject: Re: [PATCH] drm: vc4: Use of_property_present()
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 9:24=E2=80=AFAM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> On Wed, 4 Sept 2024 at 14:19, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Sep 4, 2024 at 6:18=E2=80=AFAM Dave Stevenson
> > <dave.stevenson@raspberrypi.com> wrote:
> > >
> > > Hi Rob
> > >
> > > On Tue, 3 Sept 2024 at 20:19, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 2:13=E2=80=AFPM Rob Herring (Arm) <robh@ker=
nel.org> wrote:
> > > > >
> > > > > Use of_property_present() to test for property presence rather th=
an
> > > > > of_find_property(). This is part of a larger effort to remove cal=
lers
> > > > > of of_find_property() and similar functions. of_find_property() l=
eaks
> > > > > the DT struct property and data pointers which is a problem for
> > > > > dynamically allocated nodes which may be freed.
> > > > >
> > > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > Ping!
> > >
> > > Sorry, this fell through the cracks.
> > >
> > > > >
> > > > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4=
/vc4_hdmi.c
> > > > > index d57c4a5948c8..049de06460d5 100644
> > > > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > > > @@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_h=
dmi *vc4_hdmi)
> > > > >         struct device *dev =3D &vc4_hdmi->pdev->dev;
> > > > >         struct platform_device *codec_pdev;
> > > > >         const __be32 *addr;
> > > > > -       int index, len;
> > > > > +       int index;
> > > > >         int ret;
> > > > >
> > > > >         /*
> > > > > @@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_h=
dmi *vc4_hdmi)
> > > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) !=3D 0=
);
> > > > >         BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) !=3D 0);
> > > > >
> > > > > -       if (!of_find_property(dev->of_node, "dmas", &len) || !len=
) {
> > > > > +       if (!of_property_present(dev->of_node, "dmas")) {
> > >
> > > The existing conditional is true if the property is not present or is=
 0 length.
> > > Your new one is only true if the property isn't present, so it isn't =
the same.
> >
> > It is not the kernel's job to validate the DT. It does a terrible job
> > of it and we have better tools for that now (schemas (though RPi
> > platforms are in a pretty sad state for schemas)). I'm pretty sure a
> > zero length or otherwise malformed "dmas" property would also cause a
> > dtc warning as well. Non-zero length is hardly a complete test
> > anyways. Any bogus value of "dmas" would pass. Or it can be completely
> > valid, but the DMA driver is not enabled (whether you even probe
> > depends on fw_devlinks).
> >
> > The kernel should just parse the properties it wants and handle any err=
ors then.
>
> I've followed up over the rationale of this.
>
> The base DT enables HDMI audio.
> On some systems there is a need to use the DMA channels for other
> purposes and no need for HDMI audio.

If that's a user decision, I wouldn't use overlays to decide that, but
make it a run-time OS decision...

> As we understand it, an overlay can't remove a property from the base
> DT, but it can set it to being empty. (Please correct us if there is a
> way to delete an existing property).

There isn't currently.

> The current check therefore allows an overlay to disable the HDMI
> audio that is enabled in the base DT. It doesn't care how long the
> property actually is, just whether it is totally empty or not as an
> alternative to being present.
>
> I understand that you may consider that abuse of DT, but that is the
> reasoning behind it. We can drop it to a downstream patch if
> necessary.

I guess it's going to be use of_count_phandle_with_args() instead.

Rob

