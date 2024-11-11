Return-Path: <linux-kernel+bounces-403759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B689C3A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD41F22153
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA5F15AD9C;
	Mon, 11 Nov 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNUvdQAi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E361FE9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315771; cv=none; b=rrFbTK/8rXhOAVHB9WBfdel75ePU99/j4NMV60ZhcjV3e80/IWXsf1zCjzbL0oK6ycUixYBDhVxTEBcuYaU+qqj7cMNcGUwtUt+4rcinVRyeAHRtrKBvwMKG/mxyxQQ7p+r+i7s4KwVDpowwYwRwaslhbmD2VZL8drULCXKi88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315771; c=relaxed/simple;
	bh=CYSNG/qqXNu0+GJWEnseUA5wjbJICc0EknuBF89Or3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smJHASx9LX5EgWejDibd5S9NXOmlJuTsFHsd7buLkD9U1XRrHGZyM7Me/I4lTLPKVbSTKJoFkKpfBW6TfWJMN297v9glt5gkvrqniTPFq2c/zIDbdUhxNXr+hb/N95hNG2YQ2FapdyS8M+M6e6lpkqSfet9iMIDvFHtuWKMo6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNUvdQAi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so3092125a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731315769; x=1731920569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYSNG/qqXNu0+GJWEnseUA5wjbJICc0EknuBF89Or3U=;
        b=kNUvdQAi+y2I8sCS5dHas0JWJQM3g5MnbyonT8dKIEqqoJq3eG9OcgI0X3Y2qbub85
         HZsMfqoxZNEULh4QP/pElUFQDxShXUEL9RB2/otBo+I5Ei5tIB7Ft8vueQwX8BkI6zIQ
         5dinVuuXdKeSVxLUg3fmH0YqRCLBE34XjaFpqPDwg5XQZgGR/9KDdrevo3y2KLPt0Uad
         gIg7UDeaLrvhiqVlQWP8/E/7cBARp8dIIR1cLEs4C3Rq83fIsMk8pkNJ+SYHapDFRdEO
         y7xGjBL/JYugCNUwnyY4/kFjJ9XEhHYj5JEsSg72lYxglIl2qnLfTG/N2cqAdOBM8gMk
         wqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731315769; x=1731920569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYSNG/qqXNu0+GJWEnseUA5wjbJICc0EknuBF89Or3U=;
        b=Rjxa8vzcuz3eih4McBX5IXdcNEHjOEYlP9+QBW9aQhYTcKuB8XUYHCbSCfazJgkpN+
         LsPJ8O8lKLGt9qipbv+A5cYP3+8dzBLOr72a0xZCL69I9yYoL93EHf5DzBrYcYwf3tXy
         Vq44qbyHGM3O9dGn2q9F5/9rED+hHCEVUIL5jDmaWucAClixT6cmuZ44+y/ZhYV51cAj
         s0xINbtTqBJnxb3VEMfE9VI8+hUm7usgj+nJqx4hv+nMsajksJOJdNnGA99t3Wj588r3
         ZUHycZ1KtIgm5jNSpiysCX5mzicKgG8wWELAbdQtbC/Oqo7zP1pk/8Gw6SAI4dd2bP/x
         7oiA==
X-Forwarded-Encrypted: i=1; AJvYcCXjooXsFHEvRrVgsl6w2CsXd22QqUgpchSyBOxU4e7f9J0FDI9lDdxMJhvpFx34YBGVVnmlbF78TAX78PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwryDPlH+21vitkIpvqjS8OHUPvmR8ZCkNKZxUJe9XOKL8uzxQg
	MDo5VbBTcwUAcKtKv6ZW1fGGw3B4a83zZiaz5Zp2+XLHIhdqhtnFqpGyQEBMu8xY7kznuimmebG
	iS8egEEf9TC+y6O9DWJTw/BYJcqf+cl6bZ4a+
X-Google-Smtp-Source: AGHT+IE7BhhmHH93ANlUvVsdbH0DwtX+JARu0JXzWF1CSIa8C/d2g2DE2EvysUqU6K1KnCS/gOLqexRdcODuLCH+a24=
X-Received: by 2002:a17:90b:4d11:b0:2e2:b922:48a with SMTP id
 98e67ed59e1d1-2e9b173aff9mr18254078a91.18.1731315768678; Mon, 11 Nov 2024
 01:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <6eb8c1ce-9823-4d6a-a04c-6a9dc1c346c8@arm.com>
In-Reply-To: <6eb8c1ce-9823-4d6a-a04c-6a9dc1c346c8@arm.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 11 Nov 2024 01:02:09 -0800
Message-ID: <CAGETcx9ByrhRzpVo_5akoxx3NqjpxVHbPJrC-yq7xoYcb6+3qA@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Christian Loehle <christian.loehle@arm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:25=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/11/24 06:15, Saravana Kannan wrote:
> [...]
> >>> Can we tell the scheduler to just spread out all the tasks during
> >>> suspend/resume? Doesn't make a lot of sense to try and save power
> >>> during a suspend/resume. It's almost always cheaper/better to do thos=
e
> >>> quickly.
> >>
> >> That would increase the resume latency right since each runnable task
> >> needs to go through a full idle CPU selection cycle? Isn't time a
> >> consideration / concern in the resume path? Unless we go through the
> >> slow path, it is very likely we'll end up making the same task
> >> placement decisions again?
> >
> > I actually quickly hacked up the cpu_overutilized() function to return
> > true during suspend/resume and the threads are nicely spread out and
> > running in parallel. That actually reduces the total of the
> > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> >
> > Also, this whole email thread started because I'm optimizing the
> > suspend/resume code to reduce a lot of sleeps/wakeups and the number
> > of kworker threads. And with that + over utilization hack, resume time
> > has dropped to 60ms.
> >
> > Peter,
> >
> > Would you be open to the scheduler being aware of
> > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > overutilized behavior during these phases? I know it's a very use case
> > specific behavior but how often do we NOT want to speed up
> > suspend/resume? We can make this a CONFIG or a kernel command line
> > option -- say, fast_suspend or something like that.
> >
>
> Just to confirm, you essentially want to disable EAS during
> suspend/resume, or does sis also not give you an acceptable
> placement?

If I effectively disable EAS during the dpm_resume/no_irq/early()
phases (the past of the resume where devices are resumed and can run
in parallel), that gives the best results. It shaves 15ms off.

More important than disabling EAS, I think the main need is to not
preempt a runnable thread or delay scheduling a runnable thread. But
yes, effectively, all CPUs end up getting used because there's enough
work to keep all the CPUs busy for 5ms. With the current behavior (is
it solely because of EAS?), some of the 5ms runs get stacked in one
CPU and it ends up taking 5ms longer. And this happens in multiple
phases and bumps it up by 15ms today. And this is all data averaged
over 100+ samples. So it's very clear cut data and not just noise.

-Saravana

