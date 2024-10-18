Return-Path: <linux-kernel+bounces-372018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654C9A435B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF0A282270
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97797202F8D;
	Fri, 18 Oct 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbiqDEw0"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF3200CB8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267844; cv=none; b=KzPVFBVIiGcUae6THQI8FIuV7wS2gjZudCzQWNitIoWMq/Z1Yj1uJzbkOf0ACLTYefzgKjZtatWDKa6Dasbe66q4XtkOrIKE2srHVz6k3+aJlAmsgwt+U5ZSGopo8s3yfHIbiPGS9B8BNTf5Wk4gLolVA9qyYjS2fnhI3rt38FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267844; c=relaxed/simple;
	bh=JuJzQzslhTotDMx0+6eb0uKjnXES4M9TQkjrM1Mz/Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/WkPupISiuLZrmLJo8s8StIYx+4R+vYZpi70IkQS7fZ0k4m2IGUu2HB8JxH0ulmZ2ib8ggH+PtsrtZ78L4jgQn7qoIYjztnfMMpqtQ4NdIFdQ2GKcTuB2Y+LfJywCxT55uXoBq0Hs5RHs13GWDkz4QVqWHjq0XJXu1lwuXjUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbiqDEw0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso576162a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729267841; x=1729872641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzcmIoSnnRoqVjkfImEkXgtaHxqUHP3HJ7pJbZDej0I=;
        b=lbiqDEw058Wdc7lykBpnzJuj95ENL+gOIUsRC8SLUqZT16XjdW7gRHTFb5Qy8SNCIJ
         j1ctA4wCqqxkDtn6QlTHMMqynmfBa0Ly9ab4CqUuTDyPOckOPN+eq4u/uXTJCHY04Fe2
         Xr25T1/QM6D6HN6JjGkydNVbSDduAWmjSLMg3hZxSkCbhd5+6HPpgU/u5rT20OF3zIeU
         jiJvPqaiNlMzV6Q8zbpu91SfcXTDAo9/SjCwKaxf9xS6X6ymDQopt/TjnQMi5GgqIgoo
         CYQ4JNRmWl76AQltEHe02oVmjeBhd+CcRmmtglAwp69cwdbY3n5LPIwn5NJss56B8YZa
         0akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267841; x=1729872641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzcmIoSnnRoqVjkfImEkXgtaHxqUHP3HJ7pJbZDej0I=;
        b=boaGOd2esxAlVmqNNAZmnwrXYdwVL2vNighqbGRGegWDhJeZ8s8RiM61YRobsOfLt/
         JeGZuBVmgRPzWKuOvWu+0l8pP9V8txfMbBQZUCX4JPDoJmp0z7ewE6kz2iPTGp+g9JKX
         tvYr5y74wPBDSiotUyihcrvek/x24D6Z+ZN1QMTlYCOZ62MUHysy/cDP9gxcBY2jb8L+
         1JzClETls5JBFe+mZSJsaIxmxgY4Z8MypOKVkFNaxhtF6QnDdUf9nVj2dFQhncKYYSaK
         5rmCIZSsn0MXaikCuGuJsMSIIZWOWXJnfVZx4ttWhqk7P2BaGTzXQO+64O92kTgESBBu
         bevA==
X-Forwarded-Encrypted: i=1; AJvYcCXKqyuRR/+87ZKC+TSA5PumJLaBf+1MJ2UdceB8VA8qrYA46LIQOYy5+TmeHihtVPOtRBLBIKOE6flPHEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTYf2AFuzQi1incY7j1K29xqAuxBzc+nDDGPMl6EGRgifG4sE
	KRqVzf42zuHY0wgUxZwxkJusdHHsoYEie71kFp38XcVe6uVTj6ljJ0hZskitRnK7T9DgnozL7Rt
	2hfvMBF7fUUNEbHULBDdpgZ4+yfnrKDwoUuXd
X-Google-Smtp-Source: AGHT+IEIaDHKGx3a03jjnaRAfVjQU/2C59OteMdtaOvSmLoZgagpqk8t3RjA9wfG7jz6Ng70z3qsoKYAO9sjNrgLdbc=
X-Received: by 2002:a17:90a:7346:b0:2e2:b719:d581 with SMTP id
 98e67ed59e1d1-2e5616c1e83mr3496300a91.5.1729267841051; Fri, 18 Oct 2024
 09:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67124175.050a0220.10f4f4.0012.GAE@google.com> <671260bd.050a0220.1e4b4d.0016.GAE@google.com>
 <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
In-Reply-To: <CAG48ez2VAMZ2K8AvWL0UoEvFCaKEzVYbaJ=syezoXj9Y_P5UVw@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 18 Oct 2024 18:10:27 +0200
Message-ID: <CANp29Y7UFVPYtdd0jVUbkUjdkpXXrv7Z+sczmKvZytNmtgx1hA@mail.gmail.com>
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>, 
	andreyknvl@gmail.com, daniel.lezcano@linaro.org, elver@google.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, rui.zhang@intel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

On Fri, Oct 18, 2024 at 5:43=E2=80=AFPM 'Jann Horn' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, Oct 18, 2024 at 3:21=E2=80=AFPM syzbot
> <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit b8c8ba73c68bb3c3e9dad22f488b86c540c839f9
> > Author: Jann Horn <jannh@google.com>
> > Date:   Fri Aug 9 15:36:56 2024 +0000
> >
> >     slub: Introduce CONFIG_SLUB_RCU_DEBUG
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14cc4c5f=
980000
> > start commit:   15e7d45e786a Add linux-next specific files for 20241016
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12cc4c5f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc36416f1c54=
640c0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Df24dd060c1911=
fe54c85
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1192f8879=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1417e830580=
000
> >
> > Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> > Fixes: b8c8ba73c68b ("slub: Introduce CONFIG_SLUB_RCU_DEBUG")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> This looks like a bogus bisection - the blamed commit was already in
> v6.12-rc1, while the file that contains this warning
> (drivers/thermal/thermal_thresholds.c) doesn't even exist in mainline
> yet.
>

Indeed, the bisection result is wrong :( At one of the steps, syzbot
has hit too many random "lost connection to test machine" crashes,
which derailed the process.

I've filed https://github.com/google/syzkaller/issues/5414. Once
implemented, that should get rid of this class of false positives.

--=20
Aleksandr

