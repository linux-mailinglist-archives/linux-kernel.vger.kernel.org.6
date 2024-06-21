Return-Path: <linux-kernel+bounces-223864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB2911988
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40328662B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56712D209;
	Fri, 21 Jun 2024 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PqnTEpHf"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58312C473
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944590; cv=none; b=jbttYJzYjTV7/OWdYOLfZQQ5dooNTMxl2w8G3JvERQ3WiA5/ZtJOSbMT/gNoGLk5hRZnrAPHm3KZpUJgcnzRW0TBsVM/VaaGW56jikMTlyJEpQTNE2KR1kiKoihM4toX1Xs+7I5cP2mbwsvLjv8bDlq9CR513w17eb1zfbAmh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944590; c=relaxed/simple;
	bh=VqERxm63JwnNlY+A19AAgs+glp5ehyrfPGP8LDyD2e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk2NQOwLDZHQPxuSr9CtadhuQgO4pjHyBEdETsR2zb8qpxDqYYy8I7KNVCLEcRlSFUenYPNvar4o5pDVYQnGvjqqDX9BTNtH0oIX2Ofnn2DqisxSn+QO6+NGsOvPXx6eUUwScC26v0wlOEtNeF+F3WwAggG8GT1gRA50Wv7o07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PqnTEpHf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295e488248so1892687e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718944587; x=1719549387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zw9eqla+4WEFJzC5MXcYyWJHlS7ohQWFgUNHhet/5Oc=;
        b=PqnTEpHf5vsb2s+EeSebw3mACHRdiYynm0u+spLGj55Or5nPIQv3Rj4yYljJbD624K
         ga60DZ1r+IXO3PEPxBQGG5zARMhyUqtIH+xppiTKjdK9qt4/ZtZhES9+60mod5vj1UhL
         /Uh6wYi6klK8wmODC3QIKa1rb7OCF04gOG508=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718944587; x=1719549387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw9eqla+4WEFJzC5MXcYyWJHlS7ohQWFgUNHhet/5Oc=;
        b=UoolxJrwulEceVcpxpvUWzIGH6+YsMIXabKE09Uok4E30Lh9IfPlcovfO+iuoHYF0I
         +qR4nRoFlo3ASApxKUfcK8xZcRtRAGwgPMLJtfCfVZj834liHo2oW6in3tEfaiSWVvOW
         dYZU0BXt8HM1dxYvsIWXXJMIIfIuXhDc6nwA0Ydpw99QEuMTrLkQNQJVlY5vXOq2AWym
         1ZxPsndh4ISPdwjAQmqBQuzIkwwgqfvtFyX/51jhI3U0Zb5w4iePvVgvFqE6xdFNz/8B
         RmlEoRhMqnyoW2Sq6+qt1jMJGXUFc12LBEU10QPjg6u77VdT05FoYx+EA6igilYwruBZ
         1TOA==
X-Forwarded-Encrypted: i=1; AJvYcCXhT06aEiBYJ+pD6VcLxMcfZBwv926JyA/XsXzuOGLeSkfLJbBgbQD2svAMKIkqW4WDrq22idfF0Bt7cmke2hrxiJF2BEnZOrbMVJaY
X-Gm-Message-State: AOJu0Yw+YEks5MJbbAJb8WGtbmXY3fvKnnnPES8f9tcs0kjZrU2RHs1x
	AezdikdWIWGlBj4q1NnCqWDUHp5ae90rBdMiQft8CxrxXlefATkCBL2FHEmxutnVcrrMixFUDX5
	f6lbJXb26ilIXf0k7O1PaTC75xQtmgPedhizR
X-Google-Smtp-Source: AGHT+IEPOx56mth/eoNVspclyTmtuDsKA4qruGwwFkV/Tvs4Ji2AC3El4RzP+9qwO2WHKD7XvJjJ5XQecwMBpwY/q40=
X-Received: by 2002:a05:6512:2087:b0:529:b632:ae4e with SMTP id
 2adb3069b0e04-52ccaa2a9b5mr3937318e87.2.1718944587158; Thu, 20 Jun 2024
 21:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620092526.2353537-1-wenst@chromium.org> <35047932-65d0-44ae-98e1-b4c771be0e6b@collabora.com>
 <CAGXv+5EGqGB=Bb-YxY1eCPg216FyVHT7Xs_Zoe2EBMKuRmZMow@mail.gmail.com>
In-Reply-To: <CAGXv+5EGqGB=Bb-YxY1eCPg216FyVHT7Xs_Zoe2EBMKuRmZMow@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 21 Jun 2024 12:36:16 +0800
Message-ID: <CAGXv+5E5io6NMvdkr7gX1rrVBk5OX+pocT4qgyArJ3aE+jGXUA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Re-add codec entry for
 ETDM1_OUT_BE dai link
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:28=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Thu, Jun 20, 2024 at 6:27=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 20/06/24 11:25, Chen-Yu Tsai ha scritto:
> > > This partially reverts commit e70b8dd26711704b1ff1f1b4eb3d048ba69e29d=
a.
> > >
> > > Said commit removes the codec entry for the ETDM1_OUT_BE dai link for
> > > some reason. This does not have the intended effect, as the remaining
> > > DAILINK_COMP_ARRAY(COMP_EMPTY()) platform entry becomes the codec
> > > entry, and the platform entry is completely gone.
> > >
> > > This causes in a KASAN out-of-bounds warning in mtk_soundcard_common_=
probe()
> > > in sound/soc/mediatek/common/mtk-soundcard-driver.c:
> > >
> > >       for_each_card_prelinks(card, i, dai_link) {
> > >               if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", st=
rlen("AFE_SOF")))
> > >                       dai_link->platforms->of_node =3D adsp_node;
> > >               else if (!dai_link->platforms->name && !dai_link->platf=
orms->of_node)
> > >                       dai_link->platforms->of_node =3D platform_node;
> > >       }
> > >
> > > where the code expects the platforms array to have space for at least=
 one entry.
> > >
> > > Re-add the entry so that dai_link->platforms has space.
> > >
> >
> > Ok, but wait a minute... the commit that you're pointing at in the Fixe=
s tag is
> > a commit that fixes a problem identified in commit
> >
> > 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY=
()")
> >
> > to keep it short, after that one, without removing the COMP_DUMMY(), th=
e audio
> > was broken in .. some way, I don't currently remember specifically what=
 was
> > happening, but I had no sound at all.

In a way, by removing COMP_DUMMY() completely, you effectively replaced it
with COMP_EMPTY() (from the platform entry), while the platform entry
effectively became COMP_DUMMY() (which is equal to a completely empty
entry).

> Right. But this adds back "COMP_EMPTY()", not COMP_DUMMY().
>
> I guess I shouldn't say this is a partial revert.
>
> After painstakingly messing with the mixer controls, I tested all three
> audio paths (speaker, headphone, DP) and they all work correctly.
>
> I'll send a v2 updating the commit message.
>
> ChenYu
>
> > If the problem is not showing up anymore, backporting this commit to th=
e kernels
> > kernels affected by the issue that I solved... will break sound!
> >
> > So... well.. that's the "some reason".... :-)
> >
> > Cheers,
> > Angelo
> >
> > > Fixes: e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai componen=
t and rework codec link")
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >   sound/soc/mediatek/mt8195/mt8195-mt6359.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/me=
diatek/mt8195/mt8195-mt6359.c
> > > index ca8751190520..2832ef78eaed 100644
> > > --- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> > > +++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> > > @@ -827,6 +827,7 @@ SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
> > >
> > >   SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
> > >                    DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
> > > +                  DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > >                    DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > >
> > >   SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
> >

