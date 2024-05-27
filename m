Return-Path: <linux-kernel+bounces-190458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC218CFE86
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844FC28137A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EBC13BAC7;
	Mon, 27 May 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbh1YcF/"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2A17BCC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807719; cv=none; b=myImYScUlMUpZpElXslNty/XijTn7SaXok4GSGHG0ge5aZZ5xanU9MLhJgIk5bvlJwVg+EOCEXqciv0V1XxRsvUe6R+p4wQ42nv44C3/3EGhzTPbBr2OBd9GUFPUmNctWRJCCAdO1JGreB3cH3/vxTlWa7GClclHtZXkSoEGpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807719; c=relaxed/simple;
	bh=AsrVCLUcFSzbtPI1hEaxIe6byGDs3hp07mY6F7v3C7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ugce8zNKY24/epsHXk0b8OYhBDYKTTA5A18tDLms6Q4YawxDHxha0+OrupZrnzjPGYZLwB/IccmI3wyKkzV42+Om5Qxpr02lichDFNCZ5aiqLykvlsSPzLM6j3G2D4C55CEUFZubtd+Cgae7OcoZOSLYndUA69GMlZPsvxMvov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbh1YcF/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f32b1b5429so32731475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716807717; x=1717412517; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3WWrTHVACXpCI2fdQV5uCOcWX1YRuGVU7Obj/fZBnA=;
        b=lbh1YcF/OT0uMCOgZyTmA3rWNFzwSZOoVmeU1f09RS2SPqctD0VG9/tvoc+QM5bKtv
         6mfZ9oOFaNkoa3DyAzvfpgQqEv6kf+/aSDyiOfe3//8DokqSj8ZRRqzCODI/WPBF3gI4
         PvnA6+qH9ihxvBQni6tK7lTHTlghe8pcMJ1HGPSaBhPeB60U4sybAEJn99b2l2WOhgEy
         wfpPj3gspP1FPeHw1gG755fVaMhly+SvDXP5Uk8SpKJ8FUzScajwmI5Z6DIVkm4aE1Sx
         sD2BbxN/0CDEMmesyBX22woyq0Fp4F6pkczp3nKgcDMqGgCQGZrkUtVPJ4LRHIiqayrr
         pthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807717; x=1717412517;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N3WWrTHVACXpCI2fdQV5uCOcWX1YRuGVU7Obj/fZBnA=;
        b=oV3YtyLHlLekxa8C0LzKbk9gR4PWiQnPSe+//cgINSX0SACTDOVPVhpZx4eq4ZJaju
         DEjNYyYA4JmGxaKpt8BtFkTUKWl7L8MHqgAclYmOfLMw5kvkl83JgJh6QFExpK6uzsBD
         ziTGvnXfkWer4ASOY5htyd77fC8IKlKzzvysqkoihHdla+f+egNUSnSm5gMvxKGDR/NH
         jOfs1E9vpcRmOUR71Zu8Md866W6xuiX2foOcS1oX1dnbPYfuo//LP8wFgY2FCmz6YSy7
         lbsXZJddy+7BDGtT6P3kOtMkSPnPtFwjWtnpqDDoKOrGTnwzSdpZ/RaUD99qORDIr16B
         R/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVClRnCmoI0JyYTVNqVAIdvGi0hc8q671xqXhgDD79c6yiK0qYqR+mIJ89txY45NqVgME5Xn+bdb+LN3y1zCPxhPgzkpboNvdR4m+k8
X-Gm-Message-State: AOJu0Yy966hNPtFgWYeRPkLD+WwY7sA5ait9+dwHINdHEuNubZZ+lJkU
	hG2k+sEw8I2RtHEeQVeY8YrgXQqi5IaVm08AcrA7sdGVRvQMpfJ7
X-Google-Smtp-Source: AGHT+IFy1CLmFJXDnV82Uvr5Sip6r8t8rLY5iVjYqpYFeW3M3VHVwgfQEgKm9tzOImxPQOKm2bTgBQ==
X-Received: by 2002:a17:902:db07:b0:1f4:8ad1:3672 with SMTP id d9443c01a7336-1f48ad13b52mr37204615ad.22.1716807717418;
        Mon, 27 May 2024 04:01:57 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967acbsm58346825ad.149.2024.05.27.04.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 21:01:51 +1000
Message-Id: <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Oleg Nesterov" <oleg@redhat.com>, "Thomas Gleixner"
 <tglx@linutronix.de>
Cc: "Frederic Weisbecker" <frederic@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Phil Auld"
 <pauld@redhat.com>, "Chris von Recklinghausen" <crecklin@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
X-Mailer: aerc 0.17.0
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx> <20240526192758.GA21193@redhat.com>
In-Reply-To: <20240526192758.GA21193@redhat.com>

On Mon May 27, 2024 at 5:27 AM AEST, Oleg Nesterov wrote:
> The more I grep the more I confused.
>
> On 05/25, Thomas Gleixner wrote:
> >
> > Right. It does not happen because the kernel starts with jiffies as
> > clocksource except on S390. The jiffies clocksource is not qualified to
> > switch over to NOHZ mode for obvious reasons.
>
> Not obvious for those who never looked at this code ;)
>
> OK, clocksource_jiffies doesn't have CLOCK_SOURCE_VALID_FOR_HRES,

jiffies clocksource requires a timer to run it I suppose.

[snip]

> > So up to this point the tick is never stopped neither on housekeeping
> > nor on NOHZ FULL CPUs:
> >
> > tick_nohz_full_update_tick()
> >   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
> >     return;
>
> OK... But tick_nohz_idle_update_tick() doesn't check TS_FLAG_NOHZ and
> the tick_nohz_full_cpu() check can't help at boot time.
>
> And I still don't understand why we can rely on can_stop_idle_tick() even
> in tick_nohz_idle_stop_tick().

AFAIKS timer_expires_base would be 0 unless tick_nohz_next_event()
were called, but that is only called from places that checked
can_stop_idle_tick() or is already a tick_nohz_full() CPU.

And timer tick CPU can't be unplugged with nohz full.

Thanks,
Nick

