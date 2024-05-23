Return-Path: <linux-kernel+bounces-186867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA568CCA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0942CB21CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684D1C36;
	Thu, 23 May 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9y08BT7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C2A29
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425480; cv=none; b=FcT4Hlidlu9VFpNKfKBzT5HFgNG6wViET4XWNEnc9LA7aTFcXeM8hgsEeeg66UA1uHbrXRm7AbWcB/ftvAy4goPfH1WgMyMw2fOhFwlAa3f2Srjb2+fTQYK8YZ7vQ0q8iUL7z09GqMTvArWQdMCIS7QwMbqtddQ6HeLqqW1/neM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425480; c=relaxed/simple;
	bh=yxU1QwZ7uz0FY2t5VpTQaVDl0Pyu6rzKYoJLrD6zb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYkpNlEwq8Hc+pk6qWafUzBydHcZl/+wbI0EP5ELVKAtQsJpAT6LMPnI7pLEjBWwmUWcQ42b2oGUu/Sjq7QBbhktMBUKeyRRI2wkAdzJaFuHAkCZzVVZxK/EQAw16hDoZI9XferBgszH9+r0iqWw+SaC/Kgnoc/4gPxlOWBrDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9y08BT7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so11149674a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716425476; x=1717030276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eNvVxmV8P5acguEgjlHTJnEuDbK2NepmN9TUkFRojg=;
        b=V9y08BT7qlxD819x03+nP1h3fzop2jaGREsNRt/Mi3uy2GVUK2lqMWFPAhBL1MFErC
         p3ew6OOVXc6GSwC8juKjGhWMBkuVC+ItjJh88z1+IiWDd1M/bk8rnFB1NJ8aWpbQMmao
         a/5t/sTb//YM3Wf/FPJ4dqIn3fhHHpCHYzN9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425476; x=1717030276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eNvVxmV8P5acguEgjlHTJnEuDbK2NepmN9TUkFRojg=;
        b=PkiT+m4vJ+1tmCvTQDRvT1tKA4DRyj0TGaqsn+7tJZkUuAsb602HlI52bK41ejHKi1
         +Ovb57mrQl5TNv24g1dMSpfM5TOobx6KLVwTTMH73c4Y9HwAHO9MLhxPHgEXsf9s2uk0
         BkDD6pbZwPTQL2oENIEUYfDIPUaPfj9lkjse0M0uDXg9hTFKi1/tbtJ9EruQkPuLgZDX
         AVlBraglDJrZVdVqbq85Ut+GQwS4Seq6U/MHL6TZ3uJaJ6ksddqECvqMEjk4N198eSyR
         /NBG+y/jmVF6ibJqTrdqn7wGS1a38iqFiLPE15S7HsMTBV5gA6lSaHnmpxJGoMCl+2bQ
         PYxw==
X-Forwarded-Encrypted: i=1; AJvYcCVJqxByAvY6/OEGFE7Vft0hN2Ub4fCwCnAa7EpwJV7ZFj4Ih7Yu8S0eKZnQz430pNcRgAcIb1nsfyjE4CU6RYLS2aRwD0k3lZ0Kbdw8
X-Gm-Message-State: AOJu0YzoJt8q7+hcowS9u6GB5IRKe1C2mM6NnJj2TQWuvx1IxHjWQM6r
	Nje0B2e3GZiTUrWljFEXARQRIvlv8EqK+2mAGG5eISPEviIU7STtIZQ9ad0ch4FTMOlkFWliY8Q
	=
X-Google-Smtp-Source: AGHT+IFjL7F6LyDnJJBT53II/Guw9oU4C/GUtNOPHU0J3TPfsfX7xw4C4ebDMKLnucB9A3E91SO5nw==
X-Received: by 2002:a17:906:2347:b0:a5a:4683:e961 with SMTP id a640c23a62f3a-a6228163179mr245631166b.52.1716425476246;
        Wed, 22 May 2024 17:51:16 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8b634cdcsm1175252966b.93.2024.05.22.17.51.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 17:51:15 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so11149654a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqNVbAtW83145rlqZgE/k1HVhyuJfd7Wxwke+QLIl/DeIa0F67co7GIBfCBUcWCI8gxXG95HHA4J03iEnPY92Y6iOEyUGC3vnLJEAs
X-Received: by 2002:a17:906:3f94:b0:a62:404a:d0d0 with SMTP id
 a640c23a62f3a-a62404ad2bdmr31881866b.42.1716425474954; Wed, 22 May 2024
 17:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com> <20231222032123.1036277-2-yu-hao.lin@nxp.com>
 <20240227175306.GB11034@francesco-nb> <PA4PR04MB96383C684AAA40C14DDB4B79D15F2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638983EBD1DB4D3E8FB5474D1222@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638983EBD1DB4D3E8FB5474D1222@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 22 May 2024 17:51:00 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM1PEMRyxRpBryJ7G6e7yzG8Ku+g2_qpHN3g5djFpAWkw@mail.gmail.com>
Message-ID: <CA+ASDXM1PEMRyxRpBryJ7G6e7yzG8Ku+g2_qpHN3g5djFpAWkw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Necromancing some v8 comments here, since I realized I had the same
question on my last pass at v10:

On Mon, Mar 4, 2024 at 11:26=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: David Lin
> > Sent: Thursday, February 29, 2024 11:53 AM
> >
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Wednesday, February 28, 2024 1:53 AM
> > >
> > > On Fri, Dec 22, 2023 at 11:21:22AM +0800, David Lin wrote:
> > > > +static int
> > > > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > > > +                           struct net_device *dev, const u8 *peer,
> > > > +                           u64 *cookie) {
> > > > +     return -1;
> > >
> > > See my following comment on this

> > > > +             mwifiex_cfg80211_ops.probe_client =3D
> > > > +                     mwifiex_cfg80211_probe_client;
> > >
> > > Can you omit this one? You should get `-EOPNOTSUPP` for free with
> > > probe_client set to NULL. Am I wrong?
> > >
> >
> > Yes. You are right. Remove in patch v9.
>
> This function must be hooked, otherwise AP mode can't work. I will hook t=
his function as before but return -EOPNOTSUPP instead.

You mean, hostapd doesn't like it? That seems like hostapd's problem,
because the actual effect is the same -- the feature isn't supported,
and will always throw an error. The kernel is lying if it adds
NL80211_CMD_PROBE_CLIENT into the wiphy command feature list.

Can you point at what specifically goes wrong in hostapd, and see if
we can find a way to fix it in the right place -- in hostapd? I don't
really hack on hostapd much, but it looks like it comes down to the
drv->use_monitor flag? Notably, that has a comment:

# src/drivers/driver_nl80211_capa.c ~ line 1424
/*
 * If poll command and tx status are supported, mac80211 is new enough
  * to have everything we need to not need monitor interfaces.
 */

So, you're actively subverting something that hostapd is trying to
learn about mac80211. That sounds double wrong.

At the very least, if we're going to include hacks like this in the
kernel, we should probably have a comment in there, so that future
readers don't keep stubbing their toes on the same question. Or worse,
removing the seemingly useless function and breaking hostapd. But
ideally, we'd drop this hack and fix hostapd.

Brian

