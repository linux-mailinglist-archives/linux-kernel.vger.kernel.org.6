Return-Path: <linux-kernel+bounces-351522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E23991279
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD901F23E18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFB1C8315;
	Fri,  4 Oct 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5M+j5VW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1208140E34
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081830; cv=none; b=fMYFmFmGBe9UkHnaL0t1aqrCAHBpvbb0moO77Bf0wCEDsOHlF0NemTRm/duQva5heE/TVkzDdh5LFyRK48rT/4Sk74n3scioAKkHe9Oln8hWGqJn1nw9aZlc+shjIesK/gnLl+XGn0ZZ3AavP59Fjco7kpcAyo7aWdnYMfLMEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081830; c=relaxed/simple;
	bh=hTsVDsSTz/P36iF7GucUvxOHwCjfq178jr4uy98RWCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QabBGqAgrbw4vrHB0M7OHmi7WlREmy0goCM96xdSsDDmgNgqbT6reoqqcdTtlkn77C3qVnEYVjOjzlxcHjhjD2odBAJ/L4L39iM8oj9J4BpPCDzRkUFHifdQ7vVzGqH4r/nhVbSYRVpx+9kIxFPo/XJt2wxmdqCvB2fa1Akpu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5M+j5VW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728081827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22WNyUg9uONU3U+2BrNw01dK/YmAzBpj2KSyPRXI/sE=;
	b=X5M+j5VWBJ7clzjtaQZ57EnBfuDlurdVo/BkZEcfSOA1iHmHtf6qUQmnkdFpJmteIGD5U+
	6CZjwsDb52gkX8D/yq99fi8p+PQryD2AdHacnr++GzE4wq4Qe5wdujXbzwTko3yMC0pCkx
	CtFmsk4G7SrRx971YmCxZpUJ0DAHUGw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-YdVer5raMXOdX8KWoURAIw-1; Fri, 04 Oct 2024 18:43:46 -0400
X-MC-Unique: YdVer5raMXOdX8KWoURAIw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7ac9ce5844eso408501585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728081826; x=1728686626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22WNyUg9uONU3U+2BrNw01dK/YmAzBpj2KSyPRXI/sE=;
        b=n+QqMqggMUl8z5r45GtqSjHGpCvRGP6INS6qmLTwIzuTeCOUDUkqJxRc0UhntQui5T
         9rer/aKxqQoqtIz/1v3akGQ0enHOHXIo01auAnXstRpz8QW8eBftcUdZWnPdrY+2MTL5
         xEn5zZXkWoRUncpJUkV8v3BFg9y4hrGH1NSTG4POpa4iEf4jpiVMvHGBx5lsnW0p52PO
         guaHhs9bRRnfKA2hGeLiMs3nRw2QZ2//5GZ1rH4XXw6DPERYMQjTXbu64Izak/eS4tXU
         +5McD5X60hKO5HTm0jFRv2sre6AjbS+753QU6lyLfUbYGC1G0t0bu8xaZkZFLIr7koYq
         9GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp7g8PtoqIbS9g32AMKWU9DkqzdE57EgoFDlNu5YydWEFqNXHx4ytr8qNpE+4YF19kB9lB3mAbiag4vYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0z5eFt9xO8j+nQNsFiBrOai8teEWsWK+ZUqDda2Xk/jwGpHk
	iNwUGVtF4YahLH7bXtP1Gfap0DhBlM83mkIk1oKN8To3oSMYqu9AOI/3uonToEsKcalSZa2zTIa
	Amc/pzs3VEbAG0DsWxui4Bs9ppwzVOmBD5N46u3ljOypbZEJo3p8OAFMnKlY/lYAZ/crJMyBWYy
	pSUesC9dSwpVeii2qC7owWbvSf5CoVEemK/hN1
X-Received: by 2002:a05:622a:447:b0:458:17d1:cc57 with SMTP id d75a77b69052e-45d9ba2f6c3mr51333211cf.4.1728081826180;
        Fri, 04 Oct 2024 15:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlZi19+8KnQiLIaRpFJvazdsQzaOMR4RknEWw341XT9JtAoRarAa2m/hZQe+YCVN6ELe47JQL7QVkkexsU2Y=
X-Received: by 2002:a05:622a:447:b0:458:17d1:cc57 with SMTP id
 d75a77b69052e-45d9ba2f6c3mr51333011cf.4.1728081825746; Fri, 04 Oct 2024
 15:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130010046.2730139-2-leobras@redhat.com> <Zv_hk59xfNvzlw3B@localhost.localdomain>
In-Reply-To: <Zv_hk59xfNvzlw3B@localhost.localdomain>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 4 Oct 2024 19:43:34 -0300
Message-ID: <CAJ6HWG7UHmWp6gsci4o_=EMmdfB9T+_jSkhkSxxqKi1upwAQ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org, 
	Junyao Zhao <junzhao@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 4, 2024 at 9:37=E2=80=AFAM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> Hi,
>
> Le Mon, Jan 29, 2024 at 10:00:46PM -0300, Leonardo Bras a =C3=A9crit :
> > When __queue_delayed_work() is called, it chooses a cpu for handling th=
e
> > timer interrupt. As of today, it will pick either the cpu passed as
> > parameter or the last cpu used for this.
> >
> > This is not good if a system does use CPU isolation, because it can tak=
e
> > away some valuable cpu time to:
> > 1 - deal with the timer interrupt,
> > 2 - schedule-out the desired task,
> > 3 - queue work on a random workqueue, and
> > 4 - schedule the desired task back to the cpu.
> >
> > So to fix this, during __queue_delayed_work(), if cpu isolation is in
> > place, pick a random non-isolated cpu to handle the timer interrupt.
> >
> > As an optimization, if the current cpu is not isolated, use it instead
> > of looking for another candidate.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> > Changes since v1:
> > - Make sure the CPU is isolated for any value of "cpu"
> >
> > Changes since RFC:
> > - Do not use the same cpu from the timer for queueing the work.
> > - If the current cpu is not isolated, use it's timer instead of
> >   looking for another candidate.
> >
> >  kernel/workqueue.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 76e60faed8923..8dd7c01b326a4 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1958,10 +1958,18 @@ static void __queue_delayed_work(int cpu, struc=
t workqueue_struct *wq,
> >       dwork->cpu =3D cpu;
> >       timer->expires =3D jiffies + delay;
> >
> > -     if (unlikely(cpu !=3D WORK_CPU_UNBOUND))
> > +     if (housekeeping_enabled(HK_TYPE_TIMER)) {
> > +             /* If the current cpu is a housekeeping cpu, use it. */
> > +             cpu =3D smp_processor_id();
> > +             if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > +                     cpu =3D housekeeping_any_cpu(HK_TYPE_TIMER);
>
> add_timer() already picks up a housekeeping CPU. So why is it needed?
>

Well, back when it was merged, I could see add_timer() using an
isolated CPU, and that's why I sent this change.
Did this change recently?

Also, previously add_timer() was only called if (cpu =3D=3D
WORK_CPU_UNBOUND), and now we make sure that for any value of 'cpu'
the timer to be put in a housekeeping cpu.

Thanks!
Leo

> Thanks.
>
> >               add_timer_on(timer, cpu);
> > -     else
> > -             add_timer(timer);
> > +     } else {
> > +             if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
> > +                     add_timer(timer);
> > +             else
> > +                     add_timer_on(timer, cpu);
> > +     }
>
> >  }
> >
> >  /**
> > --
> > 2.43.0
> >
> >
>


