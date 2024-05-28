Return-Path: <linux-kernel+bounces-191601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9718D114C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BAF282F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A4D515;
	Tue, 28 May 2024 01:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4E+zGg2"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4B8825
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716858131; cv=none; b=Jup1pzrZlFQhmZULErjM4E5iyAQrttH83ZCXvY5fcBF12U7SJ56VOq9Q20ucB4HA1Gk+SPM1YoQxsvvmxExuXs0EzSMl1ZHRvHqBzFeASUx7wCJW5sSHLFidY6bdbcv7vZOLpQ033th11BRoLKyUMDHcuR3dhIzpSSWr+UJjvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716858131; c=relaxed/simple;
	bh=AYfH0l+s5u656zWLKGBO56eNhCo6XkoEX2FLQY//O2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mYZU6huN2hs0kpQlVILrRI3FxhS0fsX85UaolPB9HwgpS5l/5wpYIlUkBe7+/5Rq4LVbOaFNzBNnfXNqZB3/JmPeyLdoSWMbRaEigoYlMSXfzDaLe5LlBR/Fa/TR2OEMtxZHDzlfwvd+d7xoaDWzGcjaX8TkpaMfSzdC3HqjOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4E+zGg2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so200710a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716858129; x=1717462929; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dQJP7ckrq9H17dUajU9sivmFtv5phvAbWRXPyPKlQo=;
        b=g4E+zGg2MuEUn47fLAWZe1e57NewewtbD2en4JLzoHJyKfSbieYg9VoPh53hloMEhY
         NT9hDL8TN/2hlf8l25xQOTsQYLXRD+VAVd+VGA9kwIa+/abX6px5jLj971k//OmI7SAc
         fgIDMF/hV7kt6XNCd5N0xOGv/MatI4YH1fBh+2o40MqxgD/IplcVZcPjmLHJml++4PU3
         aUaLvbGe0sT+kHRe1WEp2qbg0IW+Nm42yDPvix/0T2Pd2uyUMsMc7mS8l5QycHPCd0ZP
         OULFxkGAnRIkYazwJPSUObSwec+XeLi1nDxUQlFCXiKKX3Mq71tqB1CBCiGiQ5KZxRLn
         pg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716858129; x=1717462929;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5dQJP7ckrq9H17dUajU9sivmFtv5phvAbWRXPyPKlQo=;
        b=gQNsZ26t1LbPvICLZ8IXM/TZ7lxoTd7cr859O9B+7JGKHelvsckd1bIJjts9L9n/92
         igK/Th8nFYdXAnjpUvbvArecAB48ZLOAsnHVAnknWntkQpEtv/mq7faF7DGlxJQf9Lv8
         8pop79MC7+rebMnRiKkIgM4u/WJbsK6w7EghRDwrCeKLg0QeLCIB7w7ZrhE7Kqnc7Llg
         L1++Btjwe45LHQkhwAmBJyZUgoLdKCGRTB9ckwDZGOOxBmYdYLlGygqu5uuAG5V0YCKs
         DnFSuxqaKW+bsSwAll/4fLKqPthIUq3cRPLl8DQZhQDacBVrg7FOo7OP1b2vIfpi589q
         UJuw==
X-Forwarded-Encrypted: i=1; AJvYcCVhb3KfUitF+lBpdXlPjhAvhWC9RY7rifnEc68H5Yria30YHBsT2FXbP9/Q7Cqvf7JAu9dtcu1UJWjeNlvuYuV84AosbWFLohINqBxV
X-Gm-Message-State: AOJu0YwuDpbsm0mZ8p4ST+8iE+43zZlzDZh7yly2JK31u2Xyhyz2kwyW
	KyvNhbCoLHK7FO6qnpiB3kIWe0wgHDZrlQUjM/p/NyvPLzZhp7B/
X-Google-Smtp-Source: AGHT+IEif073OcjQcQ+Mz9I48PWbOvtLRYIdKE7X5MaSgnxyGtbR3SqKOaiEYgT+WXniq0b67B862w==
X-Received: by 2002:a17:90a:b009:b0:2b6:208c:2aee with SMTP id 98e67ed59e1d1-2bf5bb6b2abmr14882522a91.20.1716858129021;
        Mon, 27 May 2024 18:02:09 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f310044sm6411613a91.9.2024.05.27.18.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 18:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 11:02:03 +1000
Message-Id: <D1KVETKKSRHL.18ZTVKAN8JS3Y@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Phil Auld" <pauld@redhat.com>, "Chris von
 Recklinghausen" <crecklin@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
X-Mailer: aerc 0.17.0
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx> <20240526192758.GA21193@redhat.com>
 <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com> <20240527155739.GB5733@redhat.com>
In-Reply-To: <20240527155739.GB5733@redhat.com>

On Tue May 28, 2024 at 1:57 AM AEST, Oleg Nesterov wrote:
> On 05/27, Nicholas Piggin wrote:
> >
> > On Mon May 27, 2024 at 5:27 AM AEST, Oleg Nesterov wrote:
> > > The more I grep the more I confused.
> > >
> > > On 05/25, Thomas Gleixner wrote:
> > > >
> > > > Right. It does not happen because the kernel starts with jiffies as
> > > > clocksource except on S390. The jiffies clocksource is not qualifie=
d to
> > > > switch over to NOHZ mode for obvious reasons.
> > >
> > > Not obvious for those who never looked at this code ;)
> > >
> > > OK, clocksource_jiffies doesn't have CLOCK_SOURCE_VALID_FOR_HRES,
> >
> > jiffies clocksource requires a timer to run it I suppose.
>
> I meant, this is enough to ensure that clocksource_done_booting() paths s=
hould
> find another cs, best !=3D curr_clocksource, and call timekeeping_notify(=
).
>
> Nevermind, quite possibly I misread this code.
>
> > > And I still don't understand why we can rely on can_stop_idle_tick() =
even
> > > in tick_nohz_idle_stop_tick().
> >
> > AFAIKS timer_expires_base would be 0 unless tick_nohz_next_event()
> > were called, but that is only called from places that checked
> > can_stop_idle_tick() or is already a tick_nohz_full() CPU.
>
> OK, thanks.
>
> So, Frederic, Nicholas, any objections to the trivial change below?

Since Thomas says it's alright, then no. I guess I added it because I
was not certain about taking the tick_do_timer_cpu while the boot CPU
could be running a timer interrupt.

I would take some of his comment to explain the race is harmless and
put it in that if block.

Out of curiosity, you are getting this going on x86? Or another arch?
Any particular use-case?

Thanks,
Nick

>
> We can cleanup the tick_do_timer_boot_cpu logic on top of it.
>
> Oleg.
>
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -178,26 +178,6 @@ void tick_setup_periodic(struct clock_event_device *=
dev, int broadcast)
>  	}
>  }
> =20
> -#ifdef CONFIG_NO_HZ_FULL
> -static void giveup_do_timer(void *info)
> -{
> -	int cpu =3D *(unsigned int *)info;
> -
> -	WARN_ON(tick_do_timer_cpu !=3D smp_processor_id());
> -
> -	tick_do_timer_cpu =3D cpu;
> -}
> -
> -static void tick_take_do_timer_from_boot(void)
> -{
> -	int cpu =3D smp_processor_id();
> -	int from =3D tick_do_timer_boot_cpu;
> -
> -	if (from >=3D 0 && from !=3D cpu)
> -		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
> -}
> -#endif
> -
>  /*
>   * Setup the tick device
>   */
> @@ -231,9 +211,8 @@ static void tick_setup_device(struct tick_device *td,
> =20
>  		} else if (tick_do_timer_boot_cpu !=3D -1 &&
>  						!tick_nohz_full_cpu(cpu)) {
> -			tick_take_do_timer_from_boot();
>  			tick_do_timer_boot_cpu =3D -1;
> -			WARN_ON(READ_ONCE(tick_do_timer_cpu) !=3D cpu);
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);
>  #endif
>  		}
> =20


