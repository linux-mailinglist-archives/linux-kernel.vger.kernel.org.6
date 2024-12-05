Return-Path: <linux-kernel+bounces-433755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E039E5C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DC018829DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72618224B03;
	Thu,  5 Dec 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+aW88um"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A91F4E2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418832; cv=none; b=kkWdWha9SaoKExvhVJlV5DjqGWQkEsdhD1jfEaReehFaxNJ8lJFnNfcCq4/VQut/sY3CEbTLvdXfHDloBwvM2ZS0bcPs7X9kpvqOphC9GPOO1SbiRRKqHOULCG8PzeuLKP31Z9i5grzK3k4QvooxB0M1IM7ETca40N1dL2Dnicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418832; c=relaxed/simple;
	bh=ibuxcH9X0KJd9ISnHUuuoisGxnAvgdnrSWtBco98quk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIa5iXpv7e5T9Rbb8QWAhKKzq/z4dJgXyrDv+0kXLNCYWrPPEpkGoh8xNAa3M4yhHRyqdOyxtxU/dEXhk1wHWLPYnXH3/UMBtf+6CTH3WUMOgc3VBcmGaUO/RFN7C9gZMQ1jW3xtwZt08Bz1TXKWWQ9i7ZPAsQfOwEEg/PrQvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i+aW88um; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd668c5easo1329628e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733418828; x=1734023628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7/aYzJxX31d++q2E25pi18VA+QiD6xbJwhkvq0pjg=;
        b=i+aW88ume3k1pjm7MTasb6MvsXWJ5zIjseR0ad3xz1rJ85p2Rs8Q5XYYlKf+5f6Y78
         1EPzMScw+gNW1+A4N+0cAjS9jbVwmZMfH0pel2H+IZA408ti8+hS9tswWo9tPaaY/rig
         UpoOgfZe0MIEgqTTjV0rP0mjKnAyZ2iotah0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418828; x=1734023628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u7/aYzJxX31d++q2E25pi18VA+QiD6xbJwhkvq0pjg=;
        b=BWGbf+7KXcplve8oCmMzwpSobtjG8suE8XqypjDCa/J6SML5yFOJB6XpWf0l9mlBGc
         tCI5sXoFYyMdjB3+v+J/bQr+MBjgzzGfGbphs6nUjR7t8dNQTDx3QLPwX+bg7JMw4S7b
         BA2bcaj+bEsHrKWjoQCY2byJhjWCDL+KLCE/GHxa5YlgNWESObNs541aTHHEqlwQp1Jm
         jZmEdyRW2zzpS+kBgBRP97K5qA3rBXH3TGRrWr7501sWKvgm/fRwS0wZgyjSEav4VLBf
         HKt6i51wtLiVqpGpMPVGVvtAnORTlO92UmLq+RoBNhkrQ8l/VHXNHyxL5wyGWPRUsMT/
         VxOw==
X-Forwarded-Encrypted: i=1; AJvYcCUhh3lc7pPjcQru/yMrqNcDGpM59JSGAC7xWadD46I0AV5yzIRpI98rKUt14c3j3Y042jCPJDPKe8ctGH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0gUzd0ji9DjCfwlWweoS6FFQz9CKy/o7PxKqldmJRIZfTNbp
	w7gymgxzJ6cxwo5WyTLJUfatjtb2XCKcpPNfI8Ht1dk4nehu1JWorOmTbRGQELxRDk9jtT0FdIz
	nbOOl
X-Gm-Gg: ASbGnctN5Uvh99LuSZ52VJ/MQoOOzZlJD367Rlp3wle7DMH8Yt8873epYQV5dPMqlzH
	qSOZXqfhOsl634HDXWfnkyimqG1mSJbra646h6ffk3kFU6GXcUmot3cSVlutt78nrexP/yqdot6
	TyBeBU62VPil5JJgYOD/Eut7TGRmF1gNnAPBKZQTv57j2t+xqNKlc4DV52EedrIbQedk9todT5p
	sDzWijlgD6x/pUMi3R3ajP8WD20WUDRWot87NU5W9gOIfqInNt2zaP7ao833wOJYxDTFsj4g/8o
	Pq0xuv1tGrpBQg==
X-Google-Smtp-Source: AGHT+IG/qmJx4Qr1GbHXcfKIh8bvOFIkQdpWwlFRVyBaPBjQefHmr2mh0KdiRnnkineY9Z+1x+9nLQ==
X-Received: by 2002:a05:6512:234b:b0:53d:f647:430c with SMTP id 2adb3069b0e04-53e21916dbfmr1404300e87.17.1733418828060;
        Thu, 05 Dec 2024 09:13:48 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e5736bsm2596991fa.105.2024.12.05.09.13.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:13:46 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53dd668c5easo1329560e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUiPehosm6TvLqeQWSP9VFGM3R0baLxltfOVlmo81OcD5aEQo5DeI5LqQuKOKS/u2Nk19xR7lCY3dkaSM=@vger.kernel.org
X-Received: by 2002:a05:6512:23a7:b0:53e:1c46:e01d with SMTP id
 2adb3069b0e04-53e219159cdmr1448759e87.19.1733418826029; Thu, 05 Dec 2024
 09:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com>
 <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
 <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
 <Z0-4umP9TnNAbJXO@google.com> <CAEXTbpeeZVwCYWR0wzX8QMYJ7okj=zmziwt9Nvtu2kzA4iMCmA@mail.gmail.com>
 <CAD=FV=Vrv6cJVMpm-vUQTG5p-k6Td1KFKvX6epDfiOzUOAON+w@mail.gmail.com> <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
In-Reply-To: <CAEXTbpeEPw66aJAfNBYDGCuQP=UsHvrqBTG7cdQJ3D+w6AiCcA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 5 Dec 2024 09:13:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
Message-ID: <CAD=FV=XdPzA8jO+4xMpYJU_1k8dp1GNGt7fnmLA4WX1f=civ4g@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Pin-yen Lin <treapking@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 5, 2024 at 5:46=E2=80=AFAM Pin-yen Lin <treapking@chromium.org>=
 wrote:
>
> Hi Doug,
>
> On Thu, Dec 5, 2024 at 2:11=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Wed, Dec 4, 2024 at 5:45=E2=80=AFAM Pin-yen Lin <treapking@chromium.=
org> wrote:
> > >
> > > > > >  Can you try testing (and gather timing numbers) when
> > > > > > suspending soon after initiating scans? It's hard to judge what=
 the
> > > > > > lower limit of this timeout should really be without any number=
s, just
> > > > > > like it's hard to judge whether your 10 second watchdog is reas=
onable.
> > > > >
> > > > > Pin-yen: is this something you could gather?
> > >
> > > I tried entering suspend right after wifi scans, and the time spent i=
n
> > > mwifiex_enable_hs() is always around 100ms. It seems initiating
> > > suspend does not increase the execution time for mwifiex_enable_hs(),
> > > so I think the driver is capable of interrupting a scan.
> > > > >
> > > > >
> > > > > > Also, for the record, since we might have to field regression r=
eports
> > > > > > for other systems: what hardware (chip variant, FW version) are=
 you
> > > > > > seeing problems on?
> > > > >
> > > > > Pin-yen: I'm assuming you'll provide this.
> > >
> > > From the debugfs entry:
> > >
> > > driver_name =3D "mwifiex"
> > > driver_version =3D mwifiex 1.0 (15.68.19.p54)
> > > verext =3D w8897o-B0, RF87XX, FP68, 15.68.19.p54
> > >
> > > The compatible string of the DT is "marvell,sd8897".
> > > >
> > > > I'll leave it up to y'all (Doug and Pin-Yen) whether you want to pr=
ovide
> > > > the above to provide a little more confidence, or if you want to
> > > > reconsider your use of CONFIG_DPM_WATCHDOG_TIMEOUT.
> > >
> > > It looks okay to me to decrease the timeout here given that scanning
> > > doesn't seem to affect the suspend time. What's your thought, Doug?
> >
> > I think Brian is right and that we should change how we're using the
> > DPM watchdog, but IMO that doesn't mean that we couldn't also change
> > this timeout.
> >
> > If nothing else, you'd want to post a v2 of your patch containing a
> > summary of the info you've gathered so it's recorded with the patch.
> >
> > Maybe what makes the most sense, though, is to put our money where our
> > mouth is and land some sort of patch in the ChromeOS tree and then
> > report back to upstream in a month when we have data about it. If
> > things look good in the field then presumably that would give some
> > confidence for upstream to be willing to land the patch?
> >
> > Probably about the best data we could gather would be to break the
> > existing timeout into two halves. You could wait half the time, then
> > print a warning, and then wait the other half the time. We could even
> > land that change _without_ changing the timeout to 5 seconds. Then if
> > we ever see the warning print but then the suspend succeeds we know
> > that there are cases where waiting longer would have helped. If we
> > made that a WARN_ON() our existing infrastructure would help us gather
> > that info...
>
> I just realized that mwifiex_wait_queue_complete() has another 12s
> timeout[1], though they are not directly involved in suspend/resume.
>
> Should we also add a warning to that and see if we can make it half?
> This starts to make me think how many timeouts we want to consider.
> Does it make sense to only focus on the one in mwifiex_enable_hs()? Or
> should we check other timeouts in mwifiex or even other drivers?
>
> [1]: https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/wireless=
/marvell/mwifiex/sta_ioctl.c#L51

IMO any of these "arbitrary and really long timeout to make sure we
don't hang forever" type things probably should have a warning so we
know if we're getting close to the timeout. It wouldn't be very hard
to make a wrapper around wait_event_interruptible_timeout() to handle
this. I suppose that wrapper could just be local to mwifiex, though if
other drivers found it useful it would make sense to put it somewhere
more common.

That being said, if we aren't actually hitting these other timeouts I
don't know that we need to do an extensive audit right now to find
every one of them.

Of course, Brian also said he'd be OK with just setting the timeout to
5 seconds based on the research you've already done. In that case I
don't know if we'd want a WARNing after 2.5 seconds. Maybe? 2.5
seconds is still pretty long, but I don't know if it's WARN-worthy. It
could at least be dev_warn() worthy...



-Doug

