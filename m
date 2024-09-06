Return-Path: <linux-kernel+bounces-318619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18A96F0D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C73285672
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4B1C9DFC;
	Fri,  6 Sep 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGUm+fYO"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CD17ADEE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617027; cv=none; b=C1meZwMGV2PXxekhsmFuAEI64RuJ8mezwcdYT1uqg94tNVlWDcXgycqzs4qOiiqDV/f6mV0EvZ2Zoh915m3L67QUQIGR3CnmXj3aFdyJqCBV9L0Y78WMp5I+P4t4I009GntO5YZ5B2MijIK3xZVCrxHdOQr3RU40gkailJJNRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617027; c=relaxed/simple;
	bh=ykjZT1qCQJJJ3XZcbbAY68b6WbmlbW47/0CikETw7zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARKztBM3HY7kDukhWHRCGTmWzP6hG5MtvYy5Hlyk0ZFWcanyBMb1zMDtEgIZnwvjwZ6ki20m30LYgi5TbJd8Rfp9nydtOUp39u77I0tqRtIbXnwMry1nYeK1xm11TlEeF3/ojJq5WCSymOWzEziQNN3WTh3/qO1sbwAL6lK+ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGUm+fYO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82a24deca03so73630839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725617025; x=1726221825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykjZT1qCQJJJ3XZcbbAY68b6WbmlbW47/0CikETw7zo=;
        b=gGUm+fYOuQUBQMIBgbySopOqadfh+91h/hanBxqlO/d8hGQm/kLrtZOVi6WTku4/Sc
         qZMmS2cMzBf0YFkdmFd/p7DZHect7r28KKqKVCwlTfb6wWoWXLr6CI8hZ75jww1H6uV2
         698wtTV0+QIpk1YFFx9i8WEgqcATSJAYlHSKqyvPr2KsDzpHEYYPqdOc8Ne5jOGAMgdX
         mz6D2lu1gFDFojAVZ64aZlOlmJRrP23gVpJ1nqC03ztQ3ATiPDF1Bmpv+c4P/VCoGnU4
         Vzix93d3zQYA3fkbxNcKToKwf4XFoSKawC3mhds8zWienorfU0dJmgdAgLRo4ToXpJNH
         VRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617025; x=1726221825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykjZT1qCQJJJ3XZcbbAY68b6WbmlbW47/0CikETw7zo=;
        b=TCUNBq8IEBHX6s9A7bDlKIDJf/IehkeHGvthZy+jCMnSMTkRlGXFlRo1UJY5rHtayJ
         u9FhthutwLnf8xrVb5w08394cKLt0uJWAQhFTWriBFTU5Q1qv9pGIDV+XgpZ7gFmEmSy
         du7HNNGC2algEhbNT/2JIDiZR7liZQbD5r1V+c3m1S2c+hU6cmBUBGAsXjnh1bZSgIBv
         fj8Z9keYFFi4VCW4kCeMyNlHi0l40GDK+CXgIQ5+5nn41T2Sfvqf88UEwy1cadonkp/r
         bqjYkCuaxCfI7rCeK7KsfCyc/daAgRcbXYeD0HM5dfI6XNQh0yaCt8wWkq7CFsDoCT5Y
         /QOA==
X-Forwarded-Encrypted: i=1; AJvYcCUREUf0zxTQNwK2963xO7uPIxnzHUoQzaU+oRGB+bvGBTXtsOCwGs16jF16RRJk9RfiNaTHuLxCFHKm0x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dgJSum4jGByqbyA9AH+poyVXMp1cNCLaiAEfRDrK5VfYxIoC
	FJrsFVNI+6yD/Dfb24LRWDx8AlYq9xhFkLU+phq4w1H907YY8/FNqubhw5duljvtMpP3OGuGCQU
	7T3UqtqdSTsdfNWXh6a/bmeBPaXM=
X-Google-Smtp-Source: AGHT+IGLblbDznwhi5XUsCBXP3kvWOxgvI9Avhj1BOw/3MxSBfTG6kXQJMxY10TRpORM3B+wCoLF5/kEQFKlTUUAsJU=
X-Received: by 2002:a05:6e02:1a6d:b0:3a0:4d1f:51a4 with SMTP id
 e9e14a558f8ab-3a04f082fa3mr20737635ab.13.1725617025015; Fri, 06 Sep 2024
 03:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822070944.GA13716@didi-ThinkCentre-M930t-N000>
 <720FE0AC-FFB4-4236-9A29-9BE8C5D27C07@didiglobal.com> <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
In-Reply-To: <CAD=FV=Vw1fG9sUiG4R6LiKnR2fgnt5Wr4QKzRg+v8MC15pWUEg@mail.gmail.com>
From: Yuanhan Zhang <zyhtheonly@gmail.com>
Date: Fri, 6 Sep 2024 18:03:33 +0800
Message-ID: <CAEQmJ=gCZBv1Mg6dxvWe5fRpFnrL9A_JM-1pB+eX9M-5v4xH7A@mail.gmail.com>
Subject: Re: [PATCH] watchdog: when watchdog_enabled is 0, let
 (soft,nmi)switch remain 1 after we read them in proc
To: Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"zyhtheonly@yeah.net" <zyhtheonly@yeah.net>, 
	"john.ogness@linutronix.de" <john.ogness@linutronix.de>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>, "mcgrof@kernel.org" <mcgrof@kernel.org>, 
	"linux@weissschuh.net" <linux@weissschuh.net>, "kjlx@templeofstupid.com" <kjlx@templeofstupid.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"bristot@redhat.com" <bristot@redhat.com>, "vschneid@redhat.com" <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=885=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Wed, Sep 4, 2024 at 2:23=E2=80=AFAM =E5=BC=A0=E5=85=83=E7=80=9A Tio Zh=
ang <tiozhang@didiglobal.com> wrote:
> >
> > Hi,
> >
> > Ping :)
> >
> > // get_maintainer.pl does not tell who are the maintainers or reviewers=
 of kernel/watchdog.c
> > Add commit signers and sched maintainers to the CC list.
>
> FWIW, people in the Linux community usually don't like "top posting"...
>
> In any case, I saw your original patch but I struggled to make sense
> of the explanation and so I left it for later and then never got back
> to it. I suspect that the explanation needs to be a little clearer.

Thanks for your time reviewing and sorry for my poor explanation,
I update the explanation with an example to reproduce the issue.
Please see [patch v2]

>
>
> > =EF=BB=BFOn 8/22/24 =E4=B8=8B=E5=8D=883:09, "=E5=BC=A0=E5=85=83=E7=80=
=9A Tio Zhang" <tiozhang@didiglobal.com <mailto:tiozhang@didiglobal.com>> w=
rote:
> >
> >
> > For users set "watchdog_user_enabled=3D0" but remaining
> > "(soft,nmi)watchdog_user_enabled=3D1". Watchdog threads(,nmi watchdog)
> > rework only if users reset "watchdog_user_enabled=3D1" without printing
> > those watchdog swicthes. Otherwise (soft,nmi)watchdog_user_enabled
> > will turn to 0 because of printing their values (It makes sense to prin=
t 0
> > since they do not work any more, but it does not make sense to let user=
's
> > swicthes change to 0 only by prints).
> >
> >
> > And after that, watchdog only should work again by doing:
> > (soft,nmi)watchdog_user_enabled=3D1
> > *** can't print, or everything go back to 0 again ***
> > watchdog_user_enabled=3D1
> >
> >
> > So this patch fixes this situation:
> >
> >
> > | name | value
> > |----------------------------|--------------------------
> > | watchdog_enabled | 0
> > |----------------------------|--------------------------
> > | nmi_watchdog_user_enabled | 1
> > |----------------------------|--------------------------
> > | soft_watchdog_user_enabled | 1
> > |----------------------------|--------------------------
> > | watchdog_user_enabled | 0
> > |----------------------------|--------------------------
> >
> >
> > cat /proc/sys/kernel/*watchdog
> > |
> > |
> > V
> > | name | value
> > |----------------------------|--------------------------
> > | watchdog_enabled | 0
> > |----------------------------|--------------------------
> > | nmi_watchdog_user_enabled | 0
> > |----------------------------|--------------------------
> > | soft_watchdog_user_enabled | 0
> > |----------------------------|--------------------------
> > | watchdog_user_enabled | 0
> > |----------------------------|--------------------------
> >
> >
> >
> >
> > Signed-off-by: Tio Zhang <tiozhang@didiglobal.com <mailto:tiozhang@didi=
global.com>>
> > ---
> > kernel/watchdog.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >
> >
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index 51915b44ac73..42e69e83e76d 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -995,8 +995,18 @@ static int proc_watchdog_common(int which, struct =
ctl_table *table, int write,
> > * On read synchronize the userspace interface. This is a
> > * racy snapshot.
> > */
> > + old =3D READ_ONCE(*param);
>
> Given that the first thing that both the "if" and "else" case do now
> is to set "old" then it feels like it could move outside the "if"
> statement.

Done in [patch v2]

>
> Even though the existing code does it, I'm also a little doubtful that
> a READ_ONCE() is really needed here. You're protected by a mutex so
> you don't need to worry about other CPUs and it would be really
> confusing to me if the compiler could optimize things in a way that
> the READ_ONCE() was needed.

I'm also confused, the only reason I keep 'READ_ONCE' is to align with
existing code. I remove 'READ_ONCE' in [patch v2].

>
>
> > *param =3D (watchdog_enabled & which) !=3D 0;
> > err =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > + /*
> > + * When "old" is 1 and watchdog_enabled is 0,
> > + * it should not be change to 0 for printing
> > + * nmi_watchdog_user_enabled or soft_watchdog_user_enabled.
> > + * So after we print it as 0,
> > + * we should recover it to 1.
> > + */
> > + if (old && !watchdog_enabled)
> > + *param =3D old;
>
> I'm confused. Why all this extra logic? This should just
> _unconditionally_ restore "*param" to "old", right? The only reason
> the code hacked "*param" in the first place was so that it could use
> the common proc_dointvec_minmax() helper function. Aside from the
> common helper function working there is never a reason to muck with
> "*param" if "!write" so it should just always restore.

Yes actually the if statement is useless, my original purpose writing this
is trying to make the explanation more clear...
Remove in [patch v2]

>
> -Doug

Thanks,

