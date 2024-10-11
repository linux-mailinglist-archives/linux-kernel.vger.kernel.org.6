Return-Path: <linux-kernel+bounces-361777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D836999ACE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D67A1F21ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB61D0B82;
	Fri, 11 Oct 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liYI+sYZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EB1D0960
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675725; cv=none; b=HMidgFoJfKzFB9+jp2Uj7Pse1UrpTetgyeL9Jf1zdlp9IVoQDF7uId5UoUFaPwERO/6wirgLSroOEAzE3jVa7f+203nn4xJnHXh1i4KdRIpvsenUU0Ai7+jhVyUV9Q8lcmfxjP8Aj80qlE1ekayfJHXp+x4B+6pC32QzYFZPM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675725; c=relaxed/simple;
	bh=ksr9J/NJBJ0Xuzu5HMGPsWQqNBircfh5z66J9u0hb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWmUCGBDRdSz+y+Yfw2RFnCMcyD+2QVAa/a5xcPExF7jeDYIexENVznXLa+XttG4M7jgPvvIzNAu30vLIyLi9iOOM0td/0sM7BXiW24oHKiDnAUO25h+IlWeFdbrDd0IgDVSBu14gZFOW0IrBMHAj/GjagqqnbJQITzJ7lKuMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=liYI+sYZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b64584fd4so23945135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728675724; x=1729280524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NkHDjpnUQFEt0hD1ZaAeCZnipeCJjRzk1S+2sZ6qMc=;
        b=liYI+sYZ0DfpC8J/aEzIYE18gIObe1zyR/rc/DFoqUy9RT+hk/da6ab0a9Wy3fIFp+
         XMOjUFNTLtGcfuqkzjJDyhoTJ8dfZLidncqLqHX92qL4H0PJDxZGlPKbwh6o+eas1tm9
         ynVYqeXvQmQBvClHbKriD+YVyZLPtAIxMbiSSdF+pdqb2z0eDnAWRt8yHVKzYTltGpgI
         FRxhLAP3Enh0UjkgTO39jblKUb/8t+/UKgbODAgLocML3Du1OhL8PHAVLBm1OgLJLxh4
         cqA/YDRRstZqrUzNCAlxtbP8gDoO7D3mk1MP78NP7bPyhnJzJf1/LC3tEfT0toQ86ZPV
         oDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675724; x=1729280524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NkHDjpnUQFEt0hD1ZaAeCZnipeCJjRzk1S+2sZ6qMc=;
        b=MfIdl7RF2JymeCnuwBPUTE47XY2o/Nxv9SqCsNbFhKenZZneKzvPTP08hWS8D0lteW
         BImve1vudg1O+wjCRANBcIT3iISSd6WKXNO5lQVjlkMqUFjX+oU3/gqhIHr1ME9DvyaB
         Ud1m90GEMdhVdsVD+wProb8pOIhMQ2iN9RuuMw2hbLBfqOzBHqmBww/QR2KcJUT8CYD8
         szy0ef0gyAEMBUxP0WLhUoZOZkvCq9l4Fg0dAL9/q8R3b8A3I5vcCBbpC5cdUO+rfuVl
         auixzFGKSaJIY4oGVCqt/tB4CKvn4eM7/oycNm8LkXfggxFeldmu9fgZ++YyL8p7cBOY
         +VLw==
X-Forwarded-Encrypted: i=1; AJvYcCUY6sqNEbZo7GX6WYMauOtxjq1Cwd1qlNdCxVfkalz9yB+6s/SffJ4aarvm4MVm1NlP1OLBtZa3Oc5iUDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAr8/J4A1FDDxYeJqLP0oVx1PE3oB25Xn2GPD6PbNgTO5ixdV
	3nYMnGnADK8cSjUtfU9sJj3xRDv79Wd8LVQKiynVhWM2b07+C8XAEwQ25XH5rfxOkvUPrZaGCqT
	TIqTgmO3N5kYdNy0LIiDy02SGXuSnF8OPB+N5
X-Google-Smtp-Source: AGHT+IG6TveOBF9WCeXcVTJX6s9D2yJmBXfLLU3gWSDnCN9YK113Nv3X6V0TyPbjMOSdSY14P2KDQM4XUGAKXNU7Cw8=
X-Received: by 2002:a17:903:1103:b0:20c:5bdc:c228 with SMTP id
 d9443c01a7336-20ca1461fbbmr44130195ad.13.1728675723433; Fri, 11 Oct 2024
 12:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000047eb7e060b652d9a@google.com> <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
 <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com> <4661f4ef-44a0-402b-864b-83ef8d31f07e@kernel.dk>
In-Reply-To: <4661f4ef-44a0-402b-864b-83ef8d31f07e@kernel.dk>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 11 Oct 2024 21:41:52 +0200
Message-ID: <CANp29Y7HT=+R-J9tL2v0Ekebe7eKMAPccmf73jLfMa_-7myCaQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:34=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/11/24 1:32 PM, Aleksandr Nogikh wrote:
> > (minus most people and mailing lists)
> >
> > On Fri, Oct 11, 2024 at 9:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wr=
ote:
> >>
> >> On Thu, Nov 30, 2023 at 2:17?PM syzbot <syzbot+ed812ed461471ab17a0c@sy=
zkaller.appspotmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    8c9660f65153 Add linux-next specific files for 202311=
24
> >>> git tree:       linux-next
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1006f178e=
80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca1e86555=
05e280
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ded812ed4614=
71ab17a0c
> >>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ec6e6=
2e80000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11964f7ce=
80000
> >>
> >> syz test: git://git.kernel.dk/linux btrace-fault
> >
> > It should begin with a # :)
> >
> > #syz test: git://git.kernel.dk/linux btrace-fault
>
> hah thanks, I always have to click the link to remember what to type.
> Guess even with that I messed it up...

FYI we've begun to include a small cheatsheet of the main syzbot
commands at the bottom of each syzbot report. So for the newer reports
you can just copy-paste the commands directly from the emails.

--=20
Aleksandr

>
> --
> Jens Axboe
>

