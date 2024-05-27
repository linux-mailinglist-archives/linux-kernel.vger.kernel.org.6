Return-Path: <linux-kernel+bounces-190292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98C8CFC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0F1C21902
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B46CDB1;
	Mon, 27 May 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW4HkYj2"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1D6A33D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801016; cv=none; b=pP9rVf4NHYoANhZgK6Tbe2jv8M046nmg48Ec5Dzu4QS5u/XvrkbYfZJs0drZpiZRotw2bDSo5Drqm5zLpISdhQrERuYSTSgktYxyBRMUqIYewBE3yxHoSIp4ONrjNG6qbbv/WbnRCc6rMRObE52SYd4Jo76NuxEphaq0W8KSmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801016; c=relaxed/simple;
	bh=2/Fn/nQA+bYoCF4HHO6FlwIqD+6UmhDLh22fdqRy5Ko=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=gDbvoU8g2h8PpJ2zd8kSWu+FAKb/rJLvkiJrWYNQgUe5cU9NMTRLxb6YHukDvSB03imMftN7FBbyMgTe4Df/TPyRZ/0Y3NkugIhLFEwQxH+GPTppE18WakC2gY9VEjVchSTdjdPkZfFWOCNwKMmDvNTHz22sppu3IzZY7aqSnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW4HkYj2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6fcbd812b33so1578231b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716801014; x=1717405814; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA5MA9ElT4onBZOSJ0vxjjNzsU+x3HhymHgEqsmUdos=;
        b=DW4HkYj27+uhblDmps4JXTVbXDcOv/RiMjyGpM0B9uMuZrkEN0+zI0kE3ba0Q8tJwN
         F0aSJbuTo5ZZvsDJSZYjtVdIbaeRp7RLny1JDupMRCDb6VHOkAPZqiQ2Epuyi3fCrfMx
         44WB/2WfPlPhi/SuJrrxWwyCH2p5kLmeS/n3usVDHkOEcn5Zx2FEHVFIOxBSikCvB+sm
         TUUmNZvA9wXWn6xhjWQvCkLwOWu7ZXXeyMZkYl+Fz+WUoWBhycOas+IHUSs3vyH9kX0t
         AcEwAcGy0RiFplzv2DDrCjvwh8TiL2EncQeY6CBV7M5hEmYpcSEsNC0xq3t82ZyRfTjI
         rvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801014; x=1717405814;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NA5MA9ElT4onBZOSJ0vxjjNzsU+x3HhymHgEqsmUdos=;
        b=Fr/uecnN2A/rY0bWu62QHff5cqqYEFmblsZfOODviHAQdnAWBN1D3jxjCt1O9bGoCb
         EYerdP+LYcyn/9Ifx9wdWMQ3FBOH2O09mbdVblVWqR0QDJMxtkS32M+TOibdul0NppLJ
         yAzBQr+iIbPu4WnM2j9RRYA8NDIU6FLIY9Tajt06Vj0abK7NY22f4uR2tKQ5VAbsoVly
         T0bY9gLrBIxuU0ssx4iCykTek3mADlth+gaWTOJtimZIUapAHoJ7bvLvtSH9mgCDdvqe
         VMOlqdpm/hFCsWPHOtpKQjZOmCi+7Lq0pQnkxfUrSNlzJsESiNJtBZ7uqm0eBhDPRCsd
         9aog==
X-Forwarded-Encrypted: i=1; AJvYcCXNErn0hdzFs2c+EFItuF9X+XJI3TLP+FyWDNEdN3pWeK/PDaffwc/sUc4xpI4O/l3XFIXLJ7dbXRGblk3+bGdlBPvHhea3biDuRl6X
X-Gm-Message-State: AOJu0YxKzFTAtQwOr9t3BRHE+BhaUTsf2bBJr4l3ZruLGYGXn/A7Y8/p
	8N2VMn/rBlSPJf8tEWwiqJDnWG1671rfmOJwICM3E4kLzOJ/+45e
X-Google-Smtp-Source: AGHT+IHWwopnPUOXJMpVA+irYg1C19nG4Eb8trTZuupZGlG0iBYLd/NRYLU9m7/A4QjFNe6DeyBJbA==
X-Received: by 2002:a05:6a00:2792:b0:6f3:86ac:5eae with SMTP id d2e1a72fcca58-6f8f41b3b81mr6789895b3a.28.1716801014490;
        Mon, 27 May 2024 02:10:14 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dbdesm4660838b3a.18.2024.05.27.02.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 02:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 19:10:07 +1000
Message-Id: <D1KB5Z1455DI.3HOVYR566ZGXN@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Oleg Nesterov"
 <oleg@redhat.com>, "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Phil Auld" <pauld@redhat.com>, "Chris von
 Recklinghausen" <crecklin@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
In-Reply-To: <87v832dfw1.ffs@tglx>

On Sat May 25, 2024 at 8:06 AM AEST, Thomas Gleixner wrote:
> On Fri, May 24 2024 at 20:37, Oleg Nesterov wrote:
>
> > I've already had a few beers today, I know I'll regret about this
> > email tomorrow, but I can't resist ;)
>
> You won't regret it. :)
>
> > On 05/24, Frederic Weisbecker wrote:
> > But again, again. tick_sched_do_timer() says
> >
> > 	* If nohz_full is enabled, this should not happen because the
> > 	* 'tick_do_timer_cpu' CPU never relinquishes.
> >
> > so I guess it is not supposed to happen?
>
> Right. It does not happen because the kernel starts with jiffies as
> clocksource except on S390. The jiffies clocksource is not qualified to
> switch over to NOHZ mode for obvious reasons. But even on S390 which has
> a truly usable and useful clocksource the tick stays periodic to begin
> with. Why?
>
> The NOHZ ready notification happens late in the boot process via:
> fs_initcall(clocksource_done_booting)
>
> So by the time that happens, the secondary CPUs are up and have taken
> over the do timer duty.
>
> [    0.600381] smp: Bringing up secondary CPUs ...
>
> ....
>
> [    1.917842] clocksource: Switched to clocksource kvm-clock
> [    1.918548] clocksource_done_booting: Switched to NOHZ // debug printk
>
> This is the point where tick_nohz_activate() is called first time and
> that does:
>
>   tick_sched_flag_set(ts, TS_FLAG_NOHZ);
>
> So up to this point the tick is never stopped neither on housekeeping
> nor on NOHZ FULL CPUs:
>
> tick_nohz_full_update_tick()
>   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
>     return;
>
> > And. My main question was: how can smp_call_function_single() help???
>
> It's useless.
>
> > Why do we actually need it?
>
> We do not.
>
> As explained above there is also nothing extra to fix contrary to
> Frederics fears.
>
> Even in the case that a command line limitation restricts the number of
> CPUs such that there is no housekeeping CPU onlined during
> smp_init(). That is checked in the isolation init code which clears
> nohz_full_running in that case. Nothing to see there either.
>
> So all this needs is the simple:
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index d88b13076b79..dab17d756fd8 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -229,11 +209,9 @@ static void tick_setup_device(struct tick_device *td=
,
>  			if (tick_nohz_full_cpu(cpu))
>  				tick_do_timer_boot_cpu =3D cpu;
> =20
> -		} else if (tick_do_timer_boot_cpu !=3D -1 &&
> -						!tick_nohz_full_cpu(cpu)) {
> -			tick_take_do_timer_from_boot();
> +		} else if (tick_do_timer_boot_cpu !=3D -1 && !tick_nohz_full_cpu(cpu))=
 {
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);
>  			tick_do_timer_boot_cpu =3D -1;
> -			WARN_ON(READ_ONCE(tick_do_timer_cpu) !=3D cpu);
>  #endif
>  		}
>
> along with the removal of the SMP function call voodoo programming gunk,
> a lengthy changelog and a bunch of useful comments.

I might not have tested that path on powerpc since it should not
switch clockevent driver (or clocksource either I think) at least
on 64-bit.  Explains the smp_call_function warning if you are
testing on x86 :/

Thanks,
Nick

