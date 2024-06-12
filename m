Return-Path: <linux-kernel+bounces-211996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56A9059CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831231C2145C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB921822C8;
	Wed, 12 Jun 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cS8fReS7"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4E1822EB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212990; cv=none; b=bO2pof/4lJC8vCm+JCA8aZ/2wzljJ202/KR2QW1OlGDUU+YWnPL6j1XaJvTpz41sKmVt0eceU7nv2SzFLYo1vmih4WX3NgxFsIKudvJ5zz2D4DaPNSpbQs/eBOhfxngyUuLvLoRSKEVP/v2XVSIepredjvbuGF2BZn1BoJO6Ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212990; c=relaxed/simple;
	bh=/eOveMBmlkJAaaoZTPiEjakaH7aRf8qPb5didjqx0C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIWkq63gn4znAlnzcJSqSAVBe7ZG+Bh+JGsJiWT9poPpQ+ddRH0LoFjdeCLSL32/F/FfXtiMVKTYUEKbzSh7mE4HGul92uDfFKu35GGFJ6ckUzVw794+ss+Va9GgtwIiDINL9fCSghFsrI6wLucfz/aeuGlhPC3sCEidp5Ulm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cS8fReS7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b07308fe6cso315166d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718212987; x=1718817787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eOveMBmlkJAaaoZTPiEjakaH7aRf8qPb5didjqx0C0=;
        b=cS8fReS74js7c+3A33lMxQFwHmCrqYRSXaJwfv+mqJyOZRcrPhe9hMthKqQh2AUmtq
         +oT6dqrPvkVhN4mNxC5adwxcd1iWSrkD2H14HbY65/NGJye1MgOigeeo2nDrq//B46Af
         O0Nu2oTTtiUH+se73VuTrKqc9bSLRefhmcUgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212987; x=1718817787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eOveMBmlkJAaaoZTPiEjakaH7aRf8qPb5didjqx0C0=;
        b=lvJCUnIzqtkafE/ujqG7HF7qaLU7/By04fdOoEQosh55+TsHYI+Gp7zXq5uad/qnqO
         X0bkY6C/NCaocVll5zeEdgJC1Zj9uGTADjwSoGM4gYx9htYMwi7S98TQTQPNLudQKYVF
         /SreOAyO4KB+fic745ts9H4Y4C7lAuerUtyHstULpaGQalz51/jciK33MtXzIFYzmjUO
         OCr3se71Z4dXA0WxlqHdIWfZxLmrIhCLZPhETxijKJFuN1wSmVyr/bTBgXt04YqqGMYO
         oSHicl/A4pNtUQnlme5h9siE65GP+X5n4Isd7WAjrRgpQorDHIi/RmhtkV8RaerV8KxO
         P/6g==
X-Forwarded-Encrypted: i=1; AJvYcCUX0o+GNeqIkNgKWE6hCGZpCuUA6py1LFGAtoIbE3TpgzRPDOZdRbcAr02ePFaGgj87+yneuPAIBBw6PZxGOqYnuoTnaAsyM94qMu9k
X-Gm-Message-State: AOJu0YzIHCqcfVTg3rXbySgY7aOzk85ODF3dCrASB8o/P2vrqmNpvQAf
	fRe1/3Mx1I2C851DabLoXjxuws8rIMp31Y2IVDXk3FEs9PxGyO0YD8mGjwlNFny/Im0eG1g+4Bw
	=
X-Google-Smtp-Source: AGHT+IFdGlB8aLlAFmlIrRPiKDwJYO9DXS9IGMfBIcsdcocUAvgIRwHVLcJKvSI9iBx51x1eqKCiAQ==
X-Received: by 2002:a05:6214:3206:b0:6b0:68cd:6fc3 with SMTP id 6a1803df08f44-6b19196633bmr27248446d6.20.1718212986961;
        Wed, 12 Jun 2024 10:23:06 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b087f2b91bsm23819676d6.26.2024.06.12.10.23.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 10:23:06 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4400cc0dad1so34921cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+3RmZC6NphjwmDCws6ISojzXtTxlBbl9ddLEOYpoQqXIhUIFpx8obPp5YKIwI1CfZTuB/mgFfS4NAHOSdyihnoWvsOF3kaHSRrCBo
X-Received: by 2002:a05:622a:5488:b0:441:5e6c:426c with SMTP id
 d75a77b69052e-4415e6c434bmr2453591cf.17.1718212985692; Wed, 12 Jun 2024
 10:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <Zmm6i6iQOdP613w3@phenom.ffwll.local> <CACRpkdbb5OdizDLSRW3bFEJJhrQ7Fs8Pb=Q2yxBog62Z1m-bOQ@mail.gmail.com>
In-Reply-To: <CACRpkdbb5OdizDLSRW3bFEJJhrQ7Fs8Pb=Q2yxBog62Z1m-bOQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 10:22:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vm==ngDo_bZ+xqV4Ojj0SSOO3ZWaxAbWA906h6-e8FMA@mail.gmail.com>
Message-ID: <CAD=FV=Vm==ngDo_bZ+xqV4Ojj0SSOO3ZWaxAbWA906h6-e8FMA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 9:47=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Jun 12, 2024 at 5:11=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch> w=
rote:
> > On Wed, Jun 12, 2024 at 07:49:31AM -0700, Doug Anderson wrote:
> (...)
> > > The problem is that the ordering is wrong, I think. Even if the OS wa=
s
> > > calling driver shutdown functions in the perfect order (which I'm not
> > > convinced about since panels aren't always child "struct device"s of
> > > the DRM device), the OS should be calling panel shutdown _before_
> > > shutting down the DRM device. That means that with your suggestion:
> > >
> > > 1. Shutdown starts and panel is on.
> > >
> > > 2. OS calls panel shutdown call, which prints warnings because panel
> > > is still on.
> > >
> > > 3. OS calls DRM driver shutdown call, which prints warnings because
> > > someone else turned the panel off.
> >
> > Uh, that's a _much_ more fundamental issue.
> >
> > The fix for that is telling the driver core about this dependency with
> > device_link_add. Unfortuantely, despite years of me trying to push for
> > this, drm_bridge and drm_panel still don't automatically add these,
> > because the situation is a really complex mess.
> >
> > Probably need to read dri-devel archives for all the past attempts arou=
nd
> > device_link_add.
>
> I think involving Saravana Kannan in the discussions around this
> is the right thing to do, because he knows how to get devicelinks
> to do the right thing.
>
> If we can describe what devicelink needs to do to get this ordering
> right, I'm pretty sure Saravana can tell us how to do it.

I'm really not convinced that hacking with device links in order to
get the shutdown notification in the right order is correct, though.
The idea is that after we're confident that all DRM modeset drivers
are calling shutdown properly that we should _remove_ any code
handling shutdown from panel-edp and panel-simple. They should just
get disabled as part of DRM's shutdown. That means that if we messed
with devicelinks just to get a different shutdown order that it was
just for a short term thing.

That being said, one could argue that having device links between the
DRM device and the panel is the right thing long term anyway and that
may well be. I guess the issue is that it's not necessarily obvious
how the "parent/child" or "supplier/consumer" relationship works w/
DRM devices, especially panels. My instinct says that the panel
logically is a "child" or "consumer" of the DRM device and thus
inserting the correct long term device link would mean we'd get
shutdown notification in the wrong order. It would be hard to argue
that the panel is the "parent" of a DRM device, but I guess you could
call it a "supplier"? ...but it's also a "consumer" of some other
stuff, like the pixels being output and also (perhaps) the DP AUX bus.
All this complexity is why the DRM framework tends to use its own
logic for things like prepare/enable instead of using what Linux gives
you. I'm sure Saravanah can also tell you about all the crazy device
link circular dependencies that DRM has thrown him through...

In any case, I guess I'll continue asserting that I'm not going to try
to solve this problem. If folks don't like my patch and there's no
suggestion other than solving years-old problems then I'm happy to
live with the way things are and hope that someone eventually comes
along and solves it.

-Doug

