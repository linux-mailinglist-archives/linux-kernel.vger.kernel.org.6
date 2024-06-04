Return-Path: <linux-kernel+bounces-200031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D98FA97D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E11628BF90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D4136986;
	Tue,  4 Jun 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQzvii5H"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C977A1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717477708; cv=none; b=MMpLGohoypHU02Yz6KBrkPTLzyztNDpfHUsEeykAKfFOjGwDBzRih66b0nzfflaKYeLvRAhQ/CprNfMnwLtUc86ulKWWgBrpc64AG9tbOauloFLVZc452C2Gn866JTxxtnVQeqj3GpJhkXmxh5XgMKQwhlRSy381HHGpSQVXqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717477708; c=relaxed/simple;
	bh=u6xUlYyqWFseNZE2BSG/EantzrlOVjuSvprvPmK0SA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KCIsu27ZYHFyVOgLJkU+PUtSvTLSWv2+P62rdAl9iKggFoYDZi4g2WyVhabOYFEMIeGZ9apWuN5bCnnRoZjshr5Bpl2vvJ2ClGbnBjv9A6UzO9g6DVneT98fziQFFe3FLY1bEPWrOFbRQQsAjKogDJbvht0jOQ+TZHkW8Q7y4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQzvii5H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a5344ec7so37778545ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717477706; x=1718082506; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6A6zQuKXwsl6JbZetHDPUY2wp2Jw40n4ysRpxyw9ZE=;
        b=KQzvii5Hha7gMRSv2Nqf7LhP1RY3GKWave7bK3IwVSZLvwYMWP7KdN1V7LoH87ZT4s
         ytxKxFVQbJCLZUSVgbN6sv4ViLNP3mRN8vFyQyVOyfXmzFjKQL+q/Yl5/3yEyj+NbNoR
         CynJDtkPIAFQjPNVGfHT4BXslsiD05i5sJkLOEJ2PO2Tc68iOzL4cBQfvEJzQBCDSU2p
         zbjV+NvIP/K/F2g8aFhQ4L4RCrgxFk+nPhgiFbMDDuAWrHewbxDavi45OASKD/4Kei5b
         rnqZy+K2qsqaavA1JcXuSxGfcZG5fLn+98E11gWBXAhTy7QV36S5gkAkzdSrlbdjOXoA
         O+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717477706; x=1718082506;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6A6zQuKXwsl6JbZetHDPUY2wp2Jw40n4ysRpxyw9ZE=;
        b=FwgzTZF1cJGHKXOYUP35MtAtHihG5Al0sqWHAFJ0of8hbabyfo1Ev1pkCeXQ8UJI1Y
         MO/QwX08Rh8G8Wq5Nw/LaYSnmDH7fTjFuZxhdDkvg+htvyGu/jG74SBy2LdO8IFxIbbA
         Ej9Ihu0D4Ze1/eiftv+Bb2SRDDkUAzuolB+BQ4cYpUJC1reJ+Pv2lC1sPEI6SO5hVhrw
         EDAn9ujHAtlHNqdLyaUV9TV2aBuVLd97OoFK8JFIgjTMY+nGL9cgvZ/oB+4O8XfWdD5G
         gIxBz4J7aJwCkG9kmct/QQsUMkXplCC8udTJnve/2XBgTLfvAqPiOSkLzOa7S33aGmQ9
         BgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDk0w+eTaXKZljJGDs11ZQ6NbawkKfnlZqLBJ1wyZcMXkWy6cR73ROq3yDqhYogEQ9X+B7aDkuzewWptdIsTzh5b5MRpwm38yTx5x+
X-Gm-Message-State: AOJu0YxgTDCU8FBXOWnjEZ+5U7PsYq0nXeabzc/RYieRRsMMeq3fBnQ6
	Jsh1VCiQjHFlkcDk4HZHTbS3sboMxuOzrK86zG9y+SBmx9BR1n7P
X-Google-Smtp-Source: AGHT+IF5tu5hfsSPot2HfyhWnMGA5eO96rl/pu4J7TG04S40PdaCX3ujPjsrgFylG1uoYxJlYHmz7w==
X-Received: by 2002:a17:902:d48a:b0:1f6:7f8f:65ac with SMTP id d9443c01a7336-1f69390ae7cmr26292595ad.26.1717477706322;
        Mon, 03 Jun 2024 22:08:26 -0700 (PDT)
Received: from localhost ([1.146.11.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f65a50962csm49577535ad.225.2024.06.03.22.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 22:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 15:08:20 +1000
Message-Id: <D1QZ17GX9Z9V.3P8J6D3MDU0T2@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Oleg Nesterov" <oleg@redhat.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Phil Auld" <pauld@redhat.com>, "Thomas Gleixner"
 <tglx@linutronix.de>
Cc: "Chris von Recklinghausen" <crecklin@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tick/nohz_full: turn tick_do_timer_boot_cpu into
 boot_cpu_is_nohz_full
X-Mailer: aerc 0.17.0
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com> <20240530124032.GA26833@redhat.com>
 <20240603153557.GA8311@redhat.com>
In-Reply-To: <20240603153557.GA8311@redhat.com>

On Tue Jun 4, 2024 at 1:35 AM AEST, Oleg Nesterov wrote:
> We don't need to record the cpu number of the nohz_full boot CPU, a simpl=
e
> boolean is enough. We could even kill it, the "else if" branch could chec=
k
> tick_nohz_full_cpu(tick_do_timer_cpu) && !tick_nohz_full_cpu(cpu).
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  kernel/time/tick-common.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 27d0018c8b05..82c1b2206631 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -49,15 +49,6 @@ ktime_t tick_next_period;
>   *    procedure also covers cpu hotplug.
>   */
>  int tick_do_timer_cpu __read_mostly =3D TICK_DO_TIMER_BOOT;
> -#ifdef CONFIG_NO_HZ_FULL
> -/*
> - * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
> - * tick_do_timer_cpu and it should be taken over by an eligible secondar=
y
> - * when one comes online.
> - */
> -static int tick_do_timer_boot_cpu __read_mostly =3D -1;
> -#endif
> -
>  /*
>   * Debugging: see timer_list.c
>   */
> @@ -192,6 +183,7 @@ static void tick_setup_device(struct tick_device *td,
>  	 * First device setup ?
>  	 */
>  	if (!td->evtdev) {
> +		static bool boot_cpu_is_nohz_full __read_mostly;
>  		/*
>  		 * If no cpu took the do_timer update, assign it to
>  		 * this cpu:
> @@ -199,18 +191,14 @@ static void tick_setup_device(struct tick_device *t=
d,
>  		if (READ_ONCE(tick_do_timer_cpu) =3D=3D TICK_DO_TIMER_BOOT) {
>  			WRITE_ONCE(tick_do_timer_cpu, cpu);
>  			tick_next_period =3D ktime_get();
> -#ifdef CONFIG_NO_HZ_FULL
>  			/*
>  			 * The boot CPU may be nohz_full, in which case the
>  			 * first housekeeping secondary will take do_timer()
>  			 * from us.
>  			 */
> -			if (tick_nohz_full_cpu(cpu))
> -				tick_do_timer_boot_cpu =3D cpu;
> -
> -		} else if (tick_do_timer_boot_cpu !=3D -1 &&
> -						!tick_nohz_full_cpu(cpu)) {
> -			tick_do_timer_boot_cpu =3D -1;
> +			boot_cpu_is_nohz_full =3D tick_nohz_full_cpu(cpu);
> +		} else if (boot_cpu_is_nohz_full && !tick_nohz_full_cpu(cpu)) {
> +			boot_cpu_is_nohz_full =3D false;
>  			/*
>  			 * The boot CPU will stay in periodic (NOHZ disabled)
>  			 * mode until clocksource_done_booting() called after
> @@ -221,7 +209,6 @@ static void tick_setup_device(struct tick_device *td,
>  			 * check in tick_periodic() but this race is harmless.
>  			 */
>  			WRITE_ONCE(tick_do_timer_cpu, cpu);
> -#endif
>  		}
> =20
>  		/*


