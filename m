Return-Path: <linux-kernel+bounces-363428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C599C250
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7B91F2154A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D2514BFA2;
	Mon, 14 Oct 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLDs+qvE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300491384BF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892736; cv=none; b=QvK/l7vcr69VuazhbTp5fyWObOitg+qlYz+9OU0+r5VjgvmOYqKEvrKMTGQHLWXbSlzAl1pCMq/CGwO6Eg0slhmyvFRmittOyW9JD9Rk+l80toWb1XP9RWwPIhuDcU7DCfrTKkaXwgioxf2O1gk1Nnk0wGi+1qJHARg05q5WSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892736; c=relaxed/simple;
	bh=RqmVuQP8tXxkfYf4bSARG/4e/4Zebv5k/Y7SfKz0oXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9+UX3HeGH+Hq8LhYNMnnWLaW/ZcCH+zLQ3xrdUhVa8ppCb0XpYp4QlLd6kyNtQ+gMp2ywpxsolpwxw3u8Xl/h5qPPuQQvp1zD9xwQRxr7xNNkkcYnU6mKpSwt4bL47x3dNbvk1RpXOhpo8BTcURdvS8vGLyHH8sdsI950xY5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLDs+qvE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so2453989a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728892734; x=1729497534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqmVuQP8tXxkfYf4bSARG/4e/4Zebv5k/Y7SfKz0oXA=;
        b=aLDs+qvEsyr8gOoKz/6F9az5pn5Jxb+Innn+bNlA+xWta7ykPmS9KKlcp1pzOj4fwi
         R6duyCSWbqYk5XTrXXN/NQ/sKeuRfCtyKjRbFY7TrQy/P6hG0Y5D7hUGuFfxOaNi2ivW
         3lSFKUQTvmW2fXlX2sbAtFSeeIxaj1EUgv5At7F7TZP8Iagf93Pw55/88CQe6p529yVS
         Tpdny3xskQmjUB08W5R/jXqMoMxG64bACGJ+FVaISf1PeZPbmoW7KFM5Eua8wSkD4eqO
         xkMvVX+qiLEHkpqbSpGBPk4Jy1SRLgEMpeFdLTyKaom/8l5E4DdOgB2HKAqZxuJZH/q8
         O6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892734; x=1729497534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqmVuQP8tXxkfYf4bSARG/4e/4Zebv5k/Y7SfKz0oXA=;
        b=N99X3CaP2PS8qoL7uoFcUMsJ4WZMvc9i+EGFhCIwUYaETNWZjYWx/u4SRUVIfFqQIN
         a6wUXsW4tUywSTP4K0eSliySNgDdaNcJN53FrGQNVSVe0q+Qqy7HglmNk2TxtablNi1n
         uZU5vJkC82Wzleg+huYqBG5pdj5C0km5CDeY5zZvscfkdZo3ugUJUP7RLYx94ONZFxKx
         k0dxwmbAL0fnsfVdElK8Bq5E/V9e76yj5TMdftTkpIIUbVdjLOG81FYGvKUw4PHD2t+R
         3jobnrb3+SBLBTxZTBuVjeUZjLrblSLTLmkA/ZuQQDsJvwOmPfaqA7bi/+xJbClxx7FW
         QfHw==
X-Forwarded-Encrypted: i=1; AJvYcCXWDIyHtYD+8cuqBJJEeFuQK/rIsqKQVrvpjUBjdaV4gFaggOMRPcPYq+TdLL5z9zwWHYywNlh8kEq0SsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1OdkbBF7AqIgGu3RPJ8Qk/LsdH3LXvdAKbF3g2to6VxDDo9m
	vJOpgSi66W6/r3997PRJgB4VZf1kQ4Iq2+y6VTbvnom9MAoOag7I5J9yKr1/lCFgj6oCgPS9C8a
	Z5lYbr8+zYmZ2283etuChrIJk3VZlQSwhQKGhIUfKdyeJeebxGA==
X-Google-Smtp-Source: AGHT+IH0rxFAb/gquf12kB1WoLBxxVmmzWA1ddhxQW5UFogYTApGsaquTgjXIgQgXTbE+LLr10ql9ylGg1JPB0NV9Uo=
X-Received: by 2002:a17:90b:3908:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e2f0aa22c7mr12370787a91.16.1728892734099; Mon, 14 Oct 2024
 00:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000047eb7e060b652d9a@google.com> <d7b91d4c-8498-49a8-86ad-27eceff18ae2@kernel.dk>
 <CANp29Y6Zvqt7K9_LWEPQ4X-n1WOJbN0W83wx7a6GRhRFuX_OLw@mail.gmail.com>
 <4661f4ef-44a0-402b-864b-83ef8d31f07e@kernel.dk> <CANp29Y7HT=+R-J9tL2v0Ekebe7eKMAPccmf73jLfMa_-7myCaQ@mail.gmail.com>
 <4b163281-7b7e-444f-a1db-a14b24afed30@kernel.dk>
In-Reply-To: <4b163281-7b7e-444f-a1db-a14b24afed30@kernel.dk>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 14 Oct 2024 09:58:39 +0200
Message-ID: <CANp29Y65=N43+0btYb0qpRJn7rxThO1_XkGDBsZf3635O0ijkQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, Oct 11, 2024 at 10:43=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 10/11/24 1:41 PM, Aleksandr Nogikh wrote:
> > On Fri, Oct 11, 2024 at 9:34?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 10/11/24 1:32 PM, Aleksandr Nogikh wrote:
> >>> (minus most people and mailing lists)
> >>>
> >>> On Fri, Oct 11, 2024 at 9:20?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
< ... >
> >>>>
> >>>> syz test: git://git.kernel.dk/linux btrace-fault
> >>>
> >>> It should begin with a # :)
> >>>
> >>> #syz test: git://git.kernel.dk/linux btrace-fault
> >>
> >> hah thanks, I always have to click the link to remember what to type.
> >> Guess even with that I messed it up...
> >
> > FYI we've begun to include a small cheatsheet of the main syzbot
> > commands at the bottom of each syzbot report. So for the newer reports
> > you can just copy-paste the commands directly from the emails.
>
> Ok question then - if I just include the patch inline in the email, what
> do I type? Or does that not work?

You'd need to type the exact same command. If there's no patch, syzbot
will just build the kernel from the specified repository and run the
reproducer on it. If you paste the git patch below the `syz test`
command, it will apply that patch before building the kernel.

--=20
Aleksandr

>
> --
> Jens Axboe

