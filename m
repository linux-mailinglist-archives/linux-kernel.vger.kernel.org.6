Return-Path: <linux-kernel+bounces-241621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8E927D33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8971F21322
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1070073443;
	Thu,  4 Jul 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N2/U+gj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23EF7344C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118179; cv=none; b=BKa98SbT0JemNseGzTJCiwUPAHuCvlIy6wrfD/Zbzm+oGV+6LEGUM+nnovqQPXpzgVaO3DNCTHcTpmUL9DkjNElom94kKGvriangIMEqPOGblZGTji0n8QFQ6M/Wh85xFGv8lbY8To1FzRu+piLWsQN4y/td7oT2SRlIg+JNFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118179; c=relaxed/simple;
	bh=OuiuIk/uej5hD6ctUQ0sHEHyXJx0Mi7ACNO0r9tkxOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E64r26kqJOZmmGplbRYwPRX68kmPPLKukcabA3s8DIrjOi9QqAnHtgyx1efwSLC2e2RWSfDbrIf2LppRVNlVeCTjyu4UT3hbko4G3rahAFd/ZKLLTqpqGU+i7XHq2/C/KN4YN6YsdjPbWFzNhr20vAmFoKjrLIHyjJzM2EPJLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=N2/U+gj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAECC4AF0A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N2/U+gj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720118175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuiuIk/uej5hD6ctUQ0sHEHyXJx0Mi7ACNO0r9tkxOk=;
	b=N2/U+gj2TgBpNkbDSsuYiRPakmOJQVFz4V/8W2qFGxPSJmki1NXuWKGEhhDB5tPmbDmi9z
	mnz+lih34tSNwPOdcwV0/UKUJZm8I2cxCxBTG2DzvgZNo7eFYKLhWOCygf547EBQoJIZCc
	uFeugMNMZ9Mi63V0TB+srLPgCMlAL1E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e5391b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Thu, 4 Jul 2024 18:36:15 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-700cc366e0dso428901a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:36:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPtpeSsyUTLFjHus0izsm0TB6lQEYUvvJpMX4HzUMMdmuyXozkmWXSUqg0CWV2XwLIBxyvcKcXD9plfGYRQfKLXwDAeF04B/JFmub0
X-Gm-Message-State: AOJu0YzHryB77q0/pg8kd5DorDMRHJeKz2VE3OWIlKFcvdJkAYIjyz/E
	FoSbuutaxkxbALOazBd8wUuiPdRtgP4qA/jqdcS2yq9SKSMptu+VHb1xAg7s9WZHxoXzbbQyMkN
	q4IwklbsuT2HeS9GAy5h/yDM0WDs=
X-Google-Smtp-Source: AGHT+IFbtFgg7L97e+n0cgFnXAuyoEI+bq0oAKVrVHmyzTuWovsSVjMbELnp+2Vlb/gNNeCcr/92vXFzi98cshdt1Zk=
X-Received: by 2002:a05:6870:d624:b0:24c:b0bd:7eb8 with SMTP id
 586e51a60fabf-25e2b8dd7c9mr2373124fac.6.1720118174065; Thu, 04 Jul 2024
 11:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com> <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
In-Reply-To: <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 4 Jul 2024 20:36:02 +0200
X-Gmail-Original-Message-ID: <CAHmME9qwrGUCC35Z7rNrqDANJN2Zr7q-T24=8od0cy7O3xi4Dw@mail.gmail.com>
Message-ID: <CAHmME9qwrGUCC35Z7rNrqDANJN2Zr7q-T24=8od0cy7O3xi4Dw@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, Jul 4, 2024 at 8:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> > What do you want me to do here?
>
> You literally said "those users exist".
>
> Make them pipe up.
>
> Make them explain why what they don't have now doesn't work. What this
> solves. In real terms.
>
> Make them explain why that random "we duplicated the VM, and now we
> worry that mixing in TSC doesn't help" is an actual real-world
> concern, rather than something COMPLETELY MADE UP BY RANDOM NUMBER
> PEOPLE.
>
> See what my argument is? My argument is literally that theoretical
> random number people will make up arguments that aren't actually
> relevant in real life.

No, I don't think this is made up by random number nutsos. I believe
this is a real actual concern.

> Do real people migrate VMs? Hell yes they do. Do they care about the
> numbers being magically "stale" after said migration? I seriously
> doubt that.

Yes! They do!

>
> Do real people start multiple VMs from one single starting image?
> Again, hell yes they do.
>
> But do they start those multiple VMs from some random slapdash
> snapshot that they just picked without any concern and cannot just
> reseed in user space? And if they do, why should *WE* clean up after
> their mindbogglingly stupid setup?

Except userspace isn't really in a great position to do that. There's
no need to suggest that people proliferate these foot guns either.

> See what my argument is? I suspect _strongly_ that this is all
> completely over-engineered based on theoretical grounds that aren't
> actually practical grounds.
>
> And dammit, I'm asking for the practical grounds. For the actual users.
>
> And if you have trouble finding those, you just proved my point.

And I think what you're missing here is that these concerns come _from
actual users_. This *isn't* theoretical.

Look, I am not some "random number" nut job. I've worked very hard to
move the kernel's RNG far outside the realm of that world. And I'm not
looking for things to do or code to write or ways to occupy my time,
just 'cuz. I'm working on this because there's a real, tangible, need
for it. This has come out of countless recurring discussions with
folks at conferences and elsewhere. I am very much part of the world
where people are writing code that makes use of getrandom(), or would
like to make use of getrandom() but can't, and this pickle comes up
repeatedly. "Oh but we can't because of syscall speed, so we've got
this userspace thing, but it's not optimal, so we're just kind of
hoping for the best, but yea one of these days somebody should do
something..."

It's okay that people aren't having those discussions with you. That's
why I'm maintaining this thing and talking to folks and caring about
it and thinking carefully about it. And because people are having
these conversations with me, that's *also* why I am very sensitive to,
"is this guy a random number nut?" concerns, because lord I've met a
lot of them and they all have their little hang up. I don't want to
add code "just because we can." But I think this here will solve a
very real problem for very real users, and everytime the fact that I'm
working on this comes up, there are real people with real concerns who
are glad to hear it's coming finally.

Alternatively, you can say, "well until they talk to me directly, no
way jos=C3=A9", and that'd be your prerogative, I guess. But that'd be
pretty darn disappointing.

Jason

