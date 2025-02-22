Return-Path: <linux-kernel+bounces-526960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F077A405B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900B819C5DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE81FFC58;
	Sat, 22 Feb 2025 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8w6au87"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78E1F03DC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203080; cv=none; b=c9svh29fjTDYfw9wm+RjekM14MGJbM3pZ94nMzUKBDy6KlXVyCSU78jQu90T44cs2ZJjZsnKjZlhPPUswOjsnozUiFmRViuAwh8ePhKTkUIudDRLtJSePyhnDTZ0ocXQqLY1UufM3DnGr4SYD/OnV7ocIEbXsn5ANbPwDATUKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203080; c=relaxed/simple;
	bh=g2RqUGAPwhT7EVyaCr6VI+SGbjZLelh6Xvm4z6vngrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBGPfkAvRl86U5suP/1OmCnBBxYbwDV4odbv7naxpOm0r7jwaparTbieRSngnRKXk41zbv5dc7ELcGiKSZyMGom1I3YbIMOVtnBHlYTm88aX4mBmvjPm60WriBIuURQNEIVANNEdYcvGIUGu5ObVV7tljSdnMwCs6RtZPfKOIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8w6au87; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so2619478276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740203078; x=1740807878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW0U6XE5dadFnlwiaJSOgRm7TtOqVG8RKY4MPvgIS9M=;
        b=Q8w6au87afMdo91RgXasEKEa3HlvmyE3urikrRtXFs1xCHMC2JfdYljDV13tkH3t4d
         ixd6w+XYc5TQq4Zr71ngk5bciLLBSDw/xkfguVmA0U5fKEKzq3g7mT176dqChL0b9Vnj
         nt1MdSxoMNzk/FQr7sTyP91GgX3m/w4JskiRr4ApV09Tc13xZf6G8CLHV98KbNuA1MnA
         Ug8xSJFPwSmpaHL38o2Da3iYI4q6ctuSev7X2sqmyay4LGjVGPlM+gte01GLApmfoLe+
         NHZNe4HJu6WCuB+LoPLiec5dcgshF2iG64d+KOTN9XT2wljTc43HKaesK4A0aXERZH8K
         MqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203078; x=1740807878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IW0U6XE5dadFnlwiaJSOgRm7TtOqVG8RKY4MPvgIS9M=;
        b=d/gfkyiW+rarkfEHWKzFEWXkBPcNmYYXErziul2UWvTnE2wV6r4W0eWxmIaTCrFz4N
         l0LILhMjxE33B94wknmxjIJX2OMo0v3pRJuK677lax0DOVy6w/CSZt6MGzidaUcxKQhW
         fhYeoWGL74RDyXGmI/kXpdDO99hbGpahXa2EM40lcjYwXWmuFOo01t7i6jAVNYVvMMSa
         H28kAd7JSo56NMmk2EE9qcr71JJf+P/XJ7hHT2kjC8ABSvIogB86dxWlr2C23V+bTUtw
         LqveoBbHVLukoESHSRF7WzvrN1N8QpRzOaWDiojKebQyGpI9zPRQbO4cmC4BHzcGUg9b
         R6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXizUI9dX2+gq5wh653v/JI/VFp3of/V10HmShYqaD4SKW2cBm5aKiL5/7xcRO0PrY2c25WL7cdueFCoe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCljiXN5XGa5rq9Ptccr/KFs8QU/QPN90wOSRAuacWeYSEJ3q
	54t8KowxXK8S54edsez27DrTBkVlvgj/tXX/tr51KzLZOmmrtSfu4I6Z9aCd6JRuFvqZpI6QFd4
	Q/yReuNZxfRdgjwBJskmmX9coiXjpyujEoWM9
X-Gm-Gg: ASbGnct8C2BtPf3PuS+NyQxSMZ2W+L8KJT5W+8dncaWt37XFltARzQxwx7b7pTRjAWq
	t+UM7hYnhLTnTH/z1mOZOYgDDdo58iqWUfg6hhkmqkBZouWfb9Uo89I3FbGqeG+qHF0o1s8pKhn
	nTRN7s9A==
X-Google-Smtp-Source: AGHT+IEMpO00uemXmGY6b464HS40oKo+dihlFMgpDgU1txDpLJh+5Afnfry4LLgBDLhNg47CesKOoJ0XEs4AQlt7H1s=
X-Received: by 2002:a05:6902:f06:b0:e5d:c686:fe02 with SMTP id
 3f1490d57ef6-e5e8afcf651mr3936362276.16.1740203077552; Fri, 21 Feb 2025
 21:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>
 <2025022100-garbage-cymbal-1cf2@gregkh> <CADg1FFc=U0JqQKTieNfxdnKQyF29Ox_2UdUUcnVXx6iDfwVvfg@mail.gmail.com>
 <CABBYNZ+63EdbEcB7-XD9jN79urmk5CtUZ6iBzphO3HuCMukQoA@mail.gmail.com>
In-Reply-To: <CABBYNZ+63EdbEcB7-XD9jN79urmk5CtUZ6iBzphO3HuCMukQoA@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Sat, 22 Feb 2025 13:44:11 +0800
X-Gm-Features: AWEUYZnYXlpbzQNJ7UlFKYOWA3cFheHOAd-U40G8kDxTfwzkk8us50aaQAcEy-4
Message-ID: <CADg1FFeyN3AWYBD6UxOYGKfUaStyvVKVhuAzVtG_oCpXVdQnMg@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, Feb 22, 2025 at 12:21=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Fri, Feb 21, 2025 at 12:57=E2=80=AFAM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 1:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> > > > On Wed, Feb 19, 2025 at 10:03=E2=80=AFPM Hsin-chen Chuang <chharry@=
google.com> wrote:
> > >
> > > <snip>
> > >
> > > > Hi Luiz and Greg,
> > > >
> > > > Friendly ping for review, thanks.
> > >
> > > A review in less than 2 days?  Please be reasonable here, remember, m=
any
> > > of us get 1000+ emails a day to deal with.
> > >
> > > To help reduce our load, take the time and review other patches on th=
e
> > > mailing lists.  You are doing that, right?  If not, why not?
> > >
> > > patience please.
> > >
> > > greg k-h
> >
> > Got it. Take your time and thank you
>
> So it is not really possible to change the alt-setting any other way?
> I'm really at odds with adding something to sysfs that only one distro
> cares about, at very least that shall be put behind a Kconfig or as a
> module parameter, or perhaps we start to intercept the likes of

I'm willing to put this API behind a module parameter if that resolves
your concerns.

> HCI_EV_SYNC_CONN_COMPLETE when USER_CHANNEL and then check if
> alt_setting needs to be changed based on the air mode, how about that?

This is a good idea. Let me verify it and get back to you. Thanks.

--=20
Best Regards,
Hsin-chen

