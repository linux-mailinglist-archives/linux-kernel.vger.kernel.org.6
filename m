Return-Path: <linux-kernel+bounces-278770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FA94B48B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF16B223E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F379CC;
	Thu,  8 Aug 2024 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QDbiONE3"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B224A3F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079953; cv=none; b=rxIKi5bPB0I0NnDrGBcowtV+8e+7rNtOixYdTt1oxcM53qeuOyuaf7DdE2iINF4uC/lfcuDg6YaTPZEOcOBduqP2BC/J6QosLO1RP2HU3X1CKN+JDgvUeAa9yo1s929GRzgxxkdLHaBCfo/6sB2HgPC5oQNt8nLQHhi7ePow7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079953; c=relaxed/simple;
	bh=5QluHlPv36JuhZb+cmekviKrasjtJstzUTt8OKUag+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6D+PR47VR+4aUla8Ycg8qisGyty9vAFPoEmjPgOnpanhDJaw4l/wm3jbwheaccU71p1VFiReW5ZfS9lGjDXO54yrWzf5Zkxuo7ZzRSVr4C6zDZH9afjamKBcE+Qf4J7RwMG5XyluAiG71MpHyD393jSeu9tOqkDA2YrVEDyJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QDbiONE3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66acac24443so4391287b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723079951; x=1723684751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7S4T07fYwuaHbTK9ICFwiFQZuOKkNB6BGDV7kNOtOk=;
        b=QDbiONE3fQ6vjHW4LYv5wN4gAWXkT9bjk/fivm6c8zdB6MJxYDe16MSyazFm6k5Lmn
         n6VnN6CKHHFB5Fu74elC9VYX6JjB7g21930bxcgZlUpl8gxS8CCOLTANDpuIHxp9zZOH
         K/3G+7HA71qU4xG+QS4gHZBNiQRQ7ZhboxBaJZftM5hF5CCzcDPMEncSnmQd48ySyE/8
         NJxp0zJQFwS8bormwKg97VSw51+UoiPMR9m/HBRJH9HdHwtAXhBBAKJM+x5EU1OM6cP/
         jNVfvixi9gCMJHyYWSi7YjkUelGLTjXqh5DjA/0+0ADt/WeprozIdhbgH6a+6chh3qPt
         t82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079951; x=1723684751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7S4T07fYwuaHbTK9ICFwiFQZuOKkNB6BGDV7kNOtOk=;
        b=rZFKfZi2swD2/6UOpaqCpxBKouYW3nkfdEmw+ZdSWpPRC+seUwhhozVPvJXo54B6Y0
         tLR+w4pzb9Vr/KLZXUspzBMNgnkx1lOgjhNLF7MNsydxEQPgxvIYh3jWfeXavvBMYz3s
         qulWkp5NXg6zBrqhQd6evbk1uAKnBvt+t+MQWlU3v8TwmKXKVG/8OUxMA9LaEayRTPHt
         a1MSwd86WsZXX+HWleJ3TR0B+G+CftFBrhveAE8765oxYxX5Hfebupn0M4F8sNYTt6f/
         t3TG6M7HgzRpFA6la9flYCQx7sNKVBPTbOwUbnlUyKTWhxvy1eALLm/9IvnSuuSJrSLT
         elWA==
X-Forwarded-Encrypted: i=1; AJvYcCWdFVSWTGHOAVdvjzVBej8tfE6VjBPqM0DmLnJZB9gr+EZ0aRe50hXwmH8CSwWOJvIiblb3LSZfYeqNG8pjTB5TrjqrwK4kaS159qmi
X-Gm-Message-State: AOJu0Yz5wTdqyXfBUuIkuzuAk/isgMfoh2vUBp01Ft4L1gPRklMNkVkx
	SqOTERJ3kGeR0LQ0EwXANJSc8mtJZ3ijyvBwGq9uXhikv9hro6Or1Uppy23g6N5+pKR9Uj1yt5O
	DUVYtLkYoOWo9Np2Ki6A8XzKJXCgDMrGNkyIk
X-Google-Smtp-Source: AGHT+IHY48KCfemBj8Iz84PcJvEwnJBWoJGzUJq25uMv2Y9U11/V8LuM8eNsUFka7P2nJhnh9a2o+UuHKUbyiXUdcYU=
X-Received: by 2002:a05:690c:4589:b0:664:e8aa:26dd with SMTP id
 00721157ae682-69bf9344fd4mr2878877b3.24.1723079950776; Wed, 07 Aug 2024
 18:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com> <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
In-Reply-To: <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 21:18:59 -0400
Message-ID: <CAHC9VhTd0MKVXsZ7J_b_Mmr2vP+RMJtxzfsgpH1rZ_hoHY1D3A@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: KP Singh <kpsingh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> w=
rote:
> On 8/7/24 16:43, Paul Moore wrote:
> > On Wed, Aug 7, 2024 at 6:45=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >> On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>> On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@ke=
rnel.org> wrote:
> >>>
> >>> ...
> >>>
> >>>>> For what it's worth, I have not noticed any issues in my -next test=
ing
> >>>>> with this patch applied but I only build architectures that build w=
ith
> >>>>> LLVM due to the nature of my work. If exposure to more architecture=
s is
> >>>>> desirable, perhaps Guenter Roeck would not mind testing it with his
> >>>>> matrix?
> >>>>
> >>>> Thanks Nathan.
> >>>>
> >>>> I think the additional testing would be great, KP can you please wor=
k
> >>>> with Guenter to set this up?
> >>>
> >>
> >> Adding Guenter directly to this thread.
> >>
> >>> Is that something you can do KP?  I'm asking because I'm looking at
> >>> merging some other patches into lsm/dev and I need to make a decision
> >>> about the static call patches (hold off on merging the other patches
> >>> until the static call testing is complete, or yank the static call
> >>> patches until testing is complete and then re-merge).  Understanding
> >>> your ability to do the additional testing, and a rough idea of how
> >>
> >> I have done the best of the testing I could do here. I think we should
> >> let this run its normal course and see if this breaks anything. I am
> >> not sure how testing is done before patches are merged and what else
> >> you expect me to do?
> >
> > That is why I was asking you to get in touch with Guenter to try and
> > sort out what needs to be done to test this across different
> > architectures.
> >
> > With all due respect, this patchset has a history of not being as
> > tested as well as I would like; we had the compilation warning on gcc
> > and then the linux-next breakage.  The gcc problem wasn't a major
> > problem (although it was disappointing, especially considering the
> > context around it), but I consider the linux-next breakage fairly
> > serious and would like to have some assurance beyond your "it's okay,
> > trust me" this time around.  If there really is no way to practically
> > test this patchset across multiple arches prior to throwing it into
> > linux-next, so be it, but I want to see at least some effort towards
> > trying to make that happen.
> >
>
> Happy to run whatever patchset there is through my testbed. Just send me
> a pointer to it.
>
> Note that it should be based on mainline; linux-next is typically too bro=
ken
> to provide any useful signals. I can handle a patchset either on top of v=
6.10
> or v6.11-rc2 (meaning 6.10 passes through all my tests, and I can apply a=
nd
> revert patches to/from 6.11-rc2 to get it to pass).

Thanks Guenter, it looks like KP already make up a branch for you to
pull, but if you have any problems or need something different let us
know.

> Question of course is if that really helps: I don't specifically test fea=
tures
> such as LSM or BPF.

In this particular case we are most interested in testing the LSM
initializing code so I don't believe you need to worry much about
LSM/BPF configuration, it's a matter of ensuring the different arches
are able to boot without any panics/warnings/etc.

There is some Kconfig needed, KP provided a good snippet earlier in
this thread, the relevant portion is copied below:

% cat .config | grep -i LOCKDOWN
CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,bpf"

... and here is the full message:

https://lore.kernel.org/linux-security-module/CACYkzJ6486mzW97LF+QrHhM9-pZt=
0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com/

--=20
paul-moore.com

