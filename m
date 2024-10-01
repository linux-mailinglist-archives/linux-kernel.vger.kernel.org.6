Return-Path: <linux-kernel+bounces-346055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB698BECB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87857285A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD961C57B9;
	Tue,  1 Oct 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZbHbo75/"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8621D696
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791238; cv=none; b=Bfoqya1QN1xuiTgzhFNczpNmammvvD0uSRruxcIde5E3H+11AJ5nNhRCAN7J3XF8EM65NxuRUwsW/EBeFpSiFJtIJ/vbcbqwKIfk1UeBxFOyuFZnT5KHtEK5uegZqYrR0pXyjzsv8FFxEOj+BySB60P6RxOAYP/jc4xjT2oao4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791238; c=relaxed/simple;
	bh=AqsFfyLC8tN+SNNJfsZHtgUB3nUf4fNE4uThyodhGWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcXy6fRX3y5BzaaMj9aya3vOSJlZEz/8ycsIBdA80Fc+ax+0jNsbDEyoU2yBNHE37fAcqTT6Gm/IWHK63YG3vGbW3gEZVpB+QcU0qgh1i0PRIq5Cjt7V76iCIex3V0ray/1GpM+iFuHpXLo/4jDbinXbgakvQxadx1qgrRv44sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZbHbo75/; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-287759c0fbdso387904fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727791235; x=1728396035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nWi1kKhDoolczZJJvZQ5ZAlJdnQTE186YgzDeJ0QBc=;
        b=ZbHbo75/TBrJSE5erE1rp3rRv8bguWMksksy6RG+nrunaGNDL2OoCamsRNZaChindz
         ACTrFkW9urT3y+G5oVGz1utOU82psDOQvkfo6/yi8aXhhCb2mdec5C8rjSrYWSGWdRMr
         wjUBpMJZPuqR2CTteaBgvvyv97oxZaa5JMFLqLklISpwIe9HkE5424qRCDI4aS1gC453
         6BrHvXXr7Yz1nv241D76eeCNLtMGHXAf+xT50kAgKQkAInaSWp12EQjdy6ZDl+hIhEg3
         WcAbP0W10pO7Z9XvgHc579jAqnWMcLyLCoYD2xGTctUq/CgDbpaYrI3VKwJcgmPxhKQF
         Z0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791235; x=1728396035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nWi1kKhDoolczZJJvZQ5ZAlJdnQTE186YgzDeJ0QBc=;
        b=MHnJO+YtcPm7oWp4rkKNKrJQchcDrS5bKQBl1bATap/TAPNrBoIt0QuuPbC+XJB4a2
         Dg5Bci0he/fuf0om1WP3VlqzkByWmHd25RbipDC5kjgM/7QmZ8pzrmcjqkH8x0Bjs+fT
         xs0Oxoy1L2DmPyITu1T6izxrtrpZSYR0fKkmvTacFCQo4YEsRZg0sJuu5/smcUK7gICR
         vNi/aFZOmKNjaGb7ZxKSTg14a2ovTm7GeGXV1HkRPyrRnURR/W1C2kP9wVIyy4tzJprW
         AVuFkFHad5W1oCtgkbDSHTtES4vnXBF8IblP7bjSa1yd+gNBSwbukAwyjPkC4MjPkGlM
         4Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCV7EpghXr41uzZZJS/ErZyB0rUCoppPpwJ8vpbr34k5Tu7tTx4jEi+IWoXavI6mKwWksSk/qVIBiDPXDyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0p/I0yyauOyWsKaau+7V0ceikeeG25jgitntbBNggNQOKErtC
	WE1PKISuQ2SX7veDUYgekiizB0viqy5Vbzc0JrCcdsMmNsS4D5PjeFBwNeuypJ1U7JSYDfXe93H
	QnzTm+0irSpQ8+BA8U+WeWREm6zr+v7C91wZL
X-Google-Smtp-Source: AGHT+IFbW8PRNzfOVdMn6qCt4HMbXcH7R5NUNYG+Zg7sSDDi+8CTl65CAmUQL3gBFeXDjpem5K64pVOqAr9jWfjzfX0=
X-Received: by 2002:a05:6871:24e8:b0:287:886:2e62 with SMTP id
 586e51a60fabf-28710a62f6cmr9941304fac.12.1727791234338; Tue, 01 Oct 2024
 07:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net>
In-Reply-To: <877cavdgsu.fsf@trenco.lwn.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Oct 2024 10:00:17 -0400
Message-ID: <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 9:55=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:
> > The following changes since commit ada1986d07976d60bed5017aa38b7f7cf278=
83f7:
> >
> >   tomoyo: fallback to realpath if symlink's pathname does not exist (20=
24-09-25 22:30:59 +0900)
> >
> > are available in the Git repository at:
> >
> >   git://git.code.sf.net/p/tomoyo/tomoyo.git tags/tomoyo-pr-20240927
> >
> > for you to fetch changes up to ada1986d07976d60bed5017aa38b7f7cf27883f7=
:
> >
> >   tomoyo: fallback to realpath if symlink's pathname does not exist (20=
24-09-25 22:30:59 +0900)
> > ----------------------------------------------------------------
> > One bugfix patch, one preparation patch, and one conversion patch.
>
> [...]
>
> > I was delivering pure LKM version of TOMOYO (named AKARI) to users who
> > cannot afford rebuilding their distro kernels with TOMOYO enabled. But
> > since the LSM framework was converted to static calls, it became more
> > difficult to deliver AKARI to such users. Therefore, I decided to updat=
e
> > TOMOYO so that people can use mostly LKM version of TOMOYO with minimal
> > burden for both distributors and users.
>
> I must confess that this change confuses me a bit.  Loadable LSM modules
> have been out of the picture for a long time, has that changed now?
>
> Even stranger, to me at least, is the backdoor symbol-export mechanism.
> That seems like ... not the way we do things.  Was the need for this so
> urgent that you couldn't try to get those symbols exported properly?

[ASIDE: Thanks for the heads-up Jon, I've also CC'd the LSM list as I
think this pull request is a surprise to all of us.]

I'm confused, or rather surprised to see this patchset/PR, and even
more surprised to see it has landed in Linus' tree.  While I suppose
we don't explicitly state that LSMs should CC their pull-requests to
the LSM list, there is definitely convention and plenty of history
here.  Even Tetsuo has previously CC'd the TOMOYO pull requests to the
LSM list (below).  Considering the history of TOMOYO pull requests,
LSM conventions, and the contents of the pull request, I can't help
but think the omission here was done with deliberate intent.  I'm also
surprised it was posted, and pulled, roughly two days from the end of
the merge window.

https://lore.kernel.org/linux-security-module/?q=3D%22%5BGIT+PULL%5D%22+f%3=
Apenguin-kernel%40i-love.sakura.ne.jp

Unfortunately this pull request was sent while I was traveling and not
in a good position to respond, or even properly notice it; as things
are I'm typing this email from the seat of a plane (the first time
I've had network access on a laptop since Thursday morning).  If I had
seen this last week I would have voiced an objection that this pull
request effectively duplicates the LSM framework hooks in TOMOYO (and
likely a few other things, I'm only quickly scanning the patches ...);
I wouldn't have accepted something like this in a new LSM submission
and I can only see this as a bad faith move on the part of Tetsuo.

Linus, it's unclear if you're still following this thread after the
pull, but can you provide a little insight on your thoughts here?  I
don't want to go down the "security people are insane" discussion
hole, but I'd would like to know where the line is drawn with
accepting changes like this: are you consciously supportive of
individual LSMs sidestepping the LSM framework like this when they are
not able to gain approval from the LSM maintainer and the LSM
community as a whole?

--=20
paul-moore.com

