Return-Path: <linux-kernel+bounces-218632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A590C2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A2B1C2201D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F6134D1;
	Tue, 18 Jun 2024 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgYzI3Nc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816A1D9519
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685946; cv=none; b=hBrf8mieqyTJVoLF4C+KMBejzHUZwVDSUn1uad7bgCwu00ZpgGv3oN3IabCeYzrKs5DS+KdK2VSee5cNyl0pS7e+coexxlr+rDHqCo9jcsGjed1dr0MDUY4kswf//vHP/wvdnfr2u4K56uZPDxoxAQTs3lGXffItoZwioIU/nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685946; c=relaxed/simple;
	bh=Q3bOid867FXBHgQ3XntiBbDUNMsvQsun9wkKdWZTvKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVmue07HVvAqQgp7NKFTs+j4rXcBQtNZv7YPdnVjqt7eC8KDcUQfjdzmx5/4E1wdnPKu9uxBrXheJpeLOcwtbomq5mF/mxImp17W8O3G1eOr8d+6AUBbjGJkJQk/5csiE6ngsqJTYzkogATzdTQWGP2/+JY+OJkBuf24fERVk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgYzI3Nc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso9341a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718685943; x=1719290743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNzT9krANqzxLCFv4tGSwAnGRM3QVsG0YISuromWOZk=;
        b=NgYzI3NcJxfwbloen3W/Nm3nl6s1yvF+W95uDW1gwX1wANr7/Cf2Vd3aSyAHMkMpi/
         ifm2833DZw+114HD/w7OSVkWbRvMCqmp8haWccgVH+WwdMpCLXLLCHoWB7oK+jI1HCYg
         wAajlPP5h6U4jbhuNIurZX/WTXtFo4nG7q9X2mHH6ZaK/OW8DU2aCjXBp2t15y6VefRY
         If9C1mBUfXhKK5JopThp756LDfM53ioV9M48pzgV2lTSM4ZwukCLNJs1BfRozNJWB+Xp
         KlDvh2we/C/m5ewxuZ4JUnS63cy3MJHvEEPCOSrIRm6qAcWO+HfxSR3B5+Pl4BsU3XcA
         40sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718685943; x=1719290743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNzT9krANqzxLCFv4tGSwAnGRM3QVsG0YISuromWOZk=;
        b=ZlwcOn0HHozMDwIzBCk+rcV0axa38gG/DbPPmabpPEQ4ASZOC26pcCbBtnycYcr47N
         VLP/s8vjtX7CayEGQplWeQSfhS+WalPUoeDUREhd73H+PN5eukvD2B6jDL6Rcs27gOlQ
         P2ONgvwPMxaN3QkeEuEdW4+YzY75kyYBg2R2e/BvZPLewaoszS4H/IEEXinQNwtLIkxS
         Agj94wuVAmURn4/Kqo44K/76ma8NwzrK7OdG6xU+kil+Xm0uUC2fMGP6zCAoAohZnkq4
         J6CteeuPiX2A0cRM1qD5UBcxBj1IpCTQqiW9IEMjDKkGO0dod/1zA0MniU98biW9zLn1
         6/hg==
X-Forwarded-Encrypted: i=1; AJvYcCVPune02hePxi85mH8LeXdAUJ9fqW3Yyn5niNMCXnSirI4pl2rgMRMhOT/T+7q+dVao6Pfw4LVt3jlwCXDb16pLhNV/gxa/nlVyKMTw
X-Gm-Message-State: AOJu0Ywqdb17Y+6Bj3r2Rn36Knj5ZMQtal+ulVdzk+lFdHfwpjghsAe2
	PHqXWPne4WU4XExEsIyrbg7ls7zbmsCGGyOibuzHmTiJphDDALvUEgAjwLW0D4a1z5tv5x4svto
	fT71DEsdE3SjrZAwfGI+vzYbLsYZBmypnCxz/OM9QVN4eAEiAaDg=
X-Google-Smtp-Source: AGHT+IFag4J0YGFekcJD9V6lSqsDeWfzYb9HM6A88ftjWTKGuCzvxkTGPILGJ2BUkH7PPDKoWxhi1GBv+4bx6rGjNaA=
X-Received: by 2002:a05:6402:27c9:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-57cf8dc61afmr128460a12.2.1718685942931; Mon, 17 Jun 2024
 21:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com> <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu> <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
In-Reply-To: <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 17 Jun 2024 21:45:30 -0700
Message-ID: <CANDhNCrShc0ak2BZN91fR9uj0MM6R20oskoDD-f7++SgPao6vA@mail.gmail.com>
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qyousef@layalina.io>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:42=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> Also, separately, while I didn't see this earlier testing on physical
> devices, when running virtualized, I can pretty easily trip over the
> following:
>
> [   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> [kworker/0:3:374]
> [   65.211107] irq event stamp: 118664
> [   65.212786] hardirqs last  enabled at (118663):
> [<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   65.218440] hardirqs last disabled at (118664):
> [<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
> [   65.223074] softirqs last  enabled at (118546):
> [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> [   65.227118] softirqs last disabled at (118541):
> [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> [   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
> 6.10.0-rc4-dirty #4393
> [   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.239089] Workqueue: events psi_avgs_work
> [   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
...
> [   65.288730] Call Trace:
> [   65.289958]  <IRQ>
> [   65.290965]  ? watchdog_timer_fn+0x275/0x310
> [   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
> [   65.297795]  ? hrtimer_interrupt+0xf9/0x230
> [   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
> [   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
> [   65.304590]  </IRQ>
> [   65.305658]  <TASK>
> [   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   65.309206]  ? psi_avgs_work+0x3c/0xb0
> [   65.311001]  ? collect_percpu_times+0xff/0x310
> [   65.313153]  psi_avgs_work+0x3c/0xb0
> [   65.314864]  process_one_work+0x1fe/0x700
> [   65.316782]  ? lock_is_held_type+0xcd/0x120
> [   65.318782]  worker_thread+0x1c7/0x3b0
> [   65.320571]  ? __pfx_worker_thread+0x10/0x10
> [   65.322626]  kthread+0xe0/0x110
> [   65.324103]  ? __pfx_kthread+0x10/0x10
> [   65.325853]  ret_from_fork+0x28/0x40
> [   65.327512]  ? __pfx_kthread+0x10/0x10
> [   65.329255]  ret_from_fork_asm+0x1a/0x30
> [   65.331073]  </TASK>
> [   65.332119] Kernel panic - not syncing: softlockup: hung tasks

As I've been digging on this some more, I'm still a bit baffled.  The
kworker seems to get stuck once the irq lands and we don't seem to go
back to the workqueue work that was in progress. That cpu ends up not
doing anything but occasionally handling ticks until we crash from the
softlockup watchdog.

Interestingly, if I move the psi_account_irqtime() call to be under
the rq_lock in sched_tick(), as I suggested earlier, I have yet to
reproduce the problem.
But I'm still trying to piece together exactly why.

thanks
-john

