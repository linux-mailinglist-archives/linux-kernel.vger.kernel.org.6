Return-Path: <linux-kernel+bounces-435414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E789E771E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65721286D24
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABC2063DC;
	Fri,  6 Dec 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UlPju449"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F411F4E21
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505871; cv=none; b=Xfauq6pugoTetQB7kfTv5EgWIoBgtURu7mKE0AOqMrlsoho+sVyAyIQ2wXOrLVxRmAvjyV+YkO+sIK+vGxEeYxFOKa5LjPSWq/ZHc5RqTfEPRuSonaXwwY6PG0af2Z1YLVrb63lfBJ+5NNNzesdiAHVjZB5LYEnesaQOWtR+XBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505871; c=relaxed/simple;
	bh=nsgEt+PHsiT2Xb7gYcSrd8xrVZ0P7ceZ5RC9RwgI5Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC73Wl/ZNm2gHC9anfoguBaBnXuNOcVI+q6/uqGXFXYhin1M8RPR40PdQETbRx12fJ80Juymf2wOMhC2RabWtVpTYO7lM/l8fOUrZbVJKrS0/S9qK9gTER8xb4UOYztNhTOW+4NqByexZZS/SKEoTK+0v+ZGQt7jhcFI6zRDeqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=UlPju449; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e388503c0d7so2264196276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733505868; x=1734110668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYSASV6VmiyGIaXZMN82SMsczFJfjPktXcbm8Rdy1aQ=;
        b=UlPju449Bcsuei5UY3HRz3g9CvdD9AjMT2Ny2bsAXRWL1wXCwjiC/U3FFkT/w3NSZU
         i7S87bBZ3wFnOSy49jtKI91maEo+42M0UVE1EanpJklMBLp1eEZJHM9m71V39LEtvBKd
         Wjl0UBsrNlHLKsTwQ3lK/L9PiOiby7hwctUMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733505868; x=1734110668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYSASV6VmiyGIaXZMN82SMsczFJfjPktXcbm8Rdy1aQ=;
        b=Xl9EJUJ1n8DqJdteV0FLdK/UKVzbEGMA5V2/7eoP13NsCIhwZkvLu0Ll+HWusecjB5
         CdbWdRNakGL7fvWMU3xRAVzVsqIi6iC+NSUTajGefyWrNMXrnOl+DAPl1ZZ+uMrqDjee
         itX7YES/KmFQ1F8fgXYdf4CaUrHx6qRu4kd+6doaKw25+DelVHp/bbuce6UwFjhLlh79
         rSOP6e9CR4G0Dz1mZBcYcyr+yBkc8gVR2WSuHts8aDuO5q/duh8TI3bbJX14dq3JHFg7
         YIRbNC/apjt0sC5tmebg2cVPAApx5Kj171phXVqKoHvrZ9U/h5yL44OxFq8nE/YSW5fr
         6vjg==
X-Forwarded-Encrypted: i=1; AJvYcCW88PUN6Pz3tyVM47pCOA8yNv6COW05GswD6mYEQ3ROFWQWNt0fN0YdoHKLrBA2iroNn8ljWecWtdaFChw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATOdYqKqxfV/mGtEZkIN/uHeJYjkHRB2q+FmrKGuWQAA/Mifz
	GUT2079hNsEV2RSuucnXG2vHNDCZtegHVfGVmJzDEixXm4Oz2k4K7qK9lpTpUn019jQqaNpkFuB
	WaQ1rfdNYfH0LFyBW2TW8+JWYDc6XXB7ivffa3g==
X-Gm-Gg: ASbGncvRwEgSqnSf/OImeG5mVB/fCHtPp/FUIH9kdAJnjLYkii5vdHhbMZFnKdPggxt
	nuvEP9HdDQh/DrmCKSZ+/rM/U3NfxcrBN8bcaBJvWz2DfIiHfbqLg0miNXvml
X-Google-Smtp-Source: AGHT+IGwZJNlO3sf4mGY8w8eM9vzKtwW1kLIaZ3BFv870IxuKczhNGqp88E07CtxksZNl0Bvb3IhBzBiUyx4Pq1FR2E=
X-Received: by 2002:a05:6902:114c:b0:e39:826b:4c14 with SMTP id
 3f1490d57ef6-e3a0b47908emr4496902276.32.1733505868013; Fri, 06 Dec 2024
 09:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <571b2045-320d-4ac2-95db-1423d0277613@ovn.org> <20241206151819.GA3949140@google.com>
 <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
In-Reply-To: <CAO7JXPhdv+Jx_UpAq=-aG-BKwiyjZ2kvuZDM4+GLjbya_=ZJsw@mail.gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 6 Dec 2024 12:24:17 -0500
Message-ID: <CAEXW_YQnh9aD5yOv5HTDPk6LruEhi+2-mZ4SfXzivD1wdgpPvA@mail.gmail.com>
Subject: Re: [v6.12] WARNING: at kernel/sched/deadline.c:1995
 enqueue_dl_entity (task blocked for more than 28262 seconds)
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Ilya Maximets <i.maximets@ovn.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, vineethrp@google.com, 
	shraash@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:57=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Fri, Dec 6, 2024 at 10:18=E2=80=AFAM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> >
> > On Wed, Dec 04, 2024 at 01:47:44PM +0100, Ilya Maximets wrote:
> > > Hi.  It seems like I'm hitting some bug in the scheduler.
> > >
> > > I'm running some tests with Open vSwitch on v6.12 kernel and some tim=
e
> > > 5 to 8 hours down the line I'm getting task blocked splats and I also
> > > have a WARNING triggered in the scheduler code right before that:
> > >
> > > Dec  3 22:19:55 kernel: WARNING: CPU: 27 PID: 3391271 at kernel/sched=
/deadline.c:1995 enqueue_dl_entity
> > >
> > > I have a lot of processes (kernel threads and userpsace threads) stuc=
k
> > > in DN, Ds, D+ and D states.  It feels like IO tasks are being schedul=
ed,
> > > but scheduler never picks them up or they are not being scheduled at =
all
> > > for whatever reason, and threads waiting on these tasks are stuck.
> > >
> > > Dec  3 22:22:45 kernel: INFO: task khugepaged:330 blocked for more th=
an 122 seconds.
> > > Dec  3 22:22:45 kernel: INFO: task ovs-monitor-ips:3479822 blocked fo=
r more than 122 seconds.
> > > Dec  3 22:22:45 kernel: INFO: task mv:3483072 blocked for more than 1=
22 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task khugepaged:330 blocked for more th=
an 245 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3479822 blocked fo=
r more than 245 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3480383 blocked fo=
r more than 122 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3481787 blocked fo=
r more than 122 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task ovs-monitor-ips:3482631 blocked fo=
r more than 122 seconds.
> > > Dec  3 22:24:48 kernel: INFO: task mv:3483072 blocked for more than 2=
45 seconds.
> > > Dec  3 22:26:51 kernel: INFO: task khugepaged:330 blocked for more th=
an 368 seconds.
> > > ...
> > > Dec  4 06:11:45 kernel: INFO: task khugepaged:330 blocked for more th=
an 28262 seconds.
> > >
> > > I have two separate instances where this behavior is reproduced.  One=
 is mostly
> > > around file systems, the other was more severe as multiple kernel thr=
eads got
> > > stuck in netlink code.  The traces do not have much in common, except=
 that most
> > > of blocked tasks are in scheduling.  The system is also idle, nothing=
 is really
> > > running.  Some of these tasks are holding resources that make other t=
asks to
> > > block on those resources as well.
> > >
> > > I seem to be able to reproduce the issue, but it takes 5-8 hours to d=
o so.
> > >
> >
> > CC'ing a few more from my team as well.
> >
> > We haven't seen such an issue with the DL server, but we are also testi=
ng on
> > slightly older kernels.
> >
> > Its coming from:
> >         WARN_ON_ONCE(on_dl_rq(dl_se));
> >
>
> Thanks for including me Joel :-)
>
> I was able to reproduce this WARN_ON couple of days back with
> syzkaller. dlserver's dl_se gets enqueued during a update_curr while
> the dlserver is stopped. And subsequent dlserver start will cause a
> double enqueue. On the peripheral, we don't track where dlserver is
> active or not directly and an explicit tracking could solve this
> issue. But the root cause is a little more deep and I think I
> understood the real cause. I have a potential fix and doing more
> testing to verify. Will send the fix out soon after a bit more
> verification

Oh, so we _have_ seen this issue :-). Thanks Vineeth, looking forward
to your fix! By the way, I do remember now some variation of this that
happened a long time ago but I thought it was fixed.

 - Joel

