Return-Path: <linux-kernel+bounces-255472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C63F934126
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A187284FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829B18FDCC;
	Wed, 17 Jul 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJvsSw2+"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE718C186
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235798; cv=none; b=EDv8nmmAsbNKt6vifEXZKvmDw31v3qenGRdtpIu8Kp9y5Hm4YuFT4hIJqRXTgaGhph4JWa7U81j2a8LoLq4b2iyzqZpvhVuqYE4JJ4QhpPTvTclFn06zTYNWpJY1eyp32eqj4RpOl63tCfEoCsozPzlGxxclepFnDMpEbtmW2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235798; c=relaxed/simple;
	bh=uAkb7bsPpIEfUDX92An98wRmTRLXcVOO6v8qfe1TC4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vrioh+QgKxq6hEQkUkGJRo43gG8x6nXZz//LDLSdu/971nHv+Ralzo4+sLHdmAmUqzQ07nZzw5OlPhjAsB7TOuIzrpODf4cQIiAdzAXWrrc7Dm8csAXVksO19VIs7V4IImmTtCG4QNPadzLD18KgyZHWtfQD9vnMfkK5zCOy0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJvsSw2+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44aa1464dc1so36953301cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721235796; x=1721840596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAkb7bsPpIEfUDX92An98wRmTRLXcVOO6v8qfe1TC4E=;
        b=AJvsSw2+u0xo9ydv4ATID7bJYdqXr54troYI0p6fRDDedL0GWQtt05VWkVikKdoEi8
         K8//4MjUSEZAfnAG/h310v6mr/kWgcyqcoixvwyY40SgS9tBBGV+a6GSUcZdVRRQSpGu
         yVJRZ6i09ua0Umxh281kf5EZ67P1/4RHdtsinJYzHgptrNzpDgE5zEPlmcAKOpZrQ8Y+
         mnqNxEIVTjFH92nXaiCKBNj1jutKra0DT5d79ZN1FxIaPdw7/Y3EbsXF1SzgibpCBGvf
         SHcQSVAcy7EpHOUJW4FyHHXhpB1RHO55EPmIFzb+KbvjMlCs92zU4e55dR0kbSznSy3e
         h/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235796; x=1721840596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAkb7bsPpIEfUDX92An98wRmTRLXcVOO6v8qfe1TC4E=;
        b=JffNhCWvAM6xtigr7XZC9mtHzHlFyH37pGbJvJW2xPNYPmazbqkLebsVNUTM5gEACN
         gi8zQTTb0XsHlQWlHPSoVCmOExgaZ4xKcBqm1oLfy9CNggihcnhbWV/hnrc/My/Jz+Qz
         JY+RetLB2Qmkmlohhxxl6LnwTrLFA3fjrLlfsw/ML+Qv50CY8EMmVZdH6xnPyP91ck8p
         UCalo5aBd6G1jljRtozLCWfT2wMl1EWvpLOpkifmAHm/dlZapgeEDCiN3crpulGJTp/G
         KBBQAXQBS+E80sctRAwFI+VNu80f2SIg+tr7SHxmg/okAyPeWLwWWoBmew4/DvBRIWTo
         jrYg==
X-Forwarded-Encrypted: i=1; AJvYcCUldT8hFr8u4cKcaZgs5eIggUkiS01SGSmV193D1vmGfT377QeSx+2qxsoQOQqckOAKinRvxH11DItuhTB61GooIoN1AsYoRaWjAHOp
X-Gm-Message-State: AOJu0Yws9tVMpLm2yplYREVRpTe4f+3FeZJrRI37GjhUhFdn+h+8PAct
	wfZAUNfp9x0241MAyd0q3lHBXmGgu2m19ZLh9HnEEWEZsfnlE3ThQCkPJqFGoNS4J+CvgNRbjBU
	u8RLZj/PYQjGgPWuKWl8LlkpdfyxiYedeYgTY
X-Google-Smtp-Source: AGHT+IFfsy10J2p52OrOHb+61BgwDzhSsBfkue55vvpbHqhrGaHypD0E0E/901HU8CJhmSoEoOrzrqwJIsvOeI8Yse4=
X-Received: by 2002:ac8:7dc6:0:b0:447:f105:e6dc with SMTP id
 d75a77b69052e-44f8619126cmr32111321cf.4.1721235795958; Wed, 17 Jul 2024
 10:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjJf27yn-vkdB32X@google.com> <CAO7JXPgbtFJO6fMdGv3jf=DfiCNzcfi4Hgfn3hfotWH=FuD3zQ@mail.gmail.com>
 <CAO7JXPhMfibNsX6Nx902PRo7_A2b4Rnc3UP=bpKYeOuQnHvtrw@mail.gmail.com>
 <66912820.050a0220.15d64.10f5@mx.google.com> <19ecf8c8-d5ac-4cfb-a650-cf072ced81ce@efficios.com>
 <20240712122408.3f434cc5@rorschach.local.home> <ZpFdYFNfWcnq5yJM@google.com>
 <20240712131232.6d77947b@rorschach.local.home> <ZpcFxd_oyInfggXJ@google.com>
 <CAEXW_YS+8VKjUZ8cnkZxCfEcjcW=z52uGYzrfYj+peLfgHL75Q@mail.gmail.com>
 <ZpfR49IcXNLS9qbu@google.com> <20240717103647.735563af@rorschach.local.home>
 <20240717105233.07b4ec00@rorschach.local.home> <20240717112000.63136c12@rorschach.local.home>
In-Reply-To: <20240717112000.63136c12@rorschach.local.home>
From: Suleiman Souhlal <suleiman@google.com>
Date: Thu, 18 Jul 2024 02:03:02 +0900
Message-ID: <CABCjUKAgH7ryZed=FP0GP84GTjeMRyQbjhP2pSsJ3Ksp63D7fA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Paravirt Scheduling (Dynamic vcpu priority management)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sean Christopherson <seanjc@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Ben Segall <bsegall@google.com>, 
	Borislav Petkov <bp@alien8.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Mel Gorman <mgorman@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, graf@amazon.com, 
	drjunior.org@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:20=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 17 Jul 2024 10:52:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > We could possibly add a new sched class that has a dynamic priority.
>
> It wouldn't need to be a new sched class. This could work with just a
> task_struct flag.
>
> It would only need to be checked in pick_next_task() and
> try_to_wake_up(). It would require that the shared memory has to be
> allocated by the host kernel and always present (unlike rseq). But this
> coming from a virtio device driver, that shouldn't be a problem.
>
> If this flag is set on current, then the first thing that
> pick_next_task() should do is to see if it needs to change current's
> priority and policy (via a callback to the driver). And then it can
> decide what task to pick, as if current was boosted, it could very well
> be the next task again.
>
> In try_to_wake_up(), if the task waking up has this flag set, it could
> boost it via an option set by the virtio device. This would allow it to
> preempt the current process if necessary and get on the CPU. Then the
> guest would be require to lower its priority if it the boost was not
> needed.
>
> Hmm, this could work.

For what it's worth, I proposed something somewhat conceptually similar bef=
ore:
https://lore.kernel.org/kvm/CABCjUKBXCFO4-cXAUdbYEKMz4VyvZ5hD-1yP9H7S7eL8Xs=
qO-g@mail.gmail.com/T/

Guests VCPUs would report their preempt_count to the host and the host
would use that to try not to preempt a VCPU that was in a critical
section (with some simple safeguards in case the guest was not well
behaved).
(It worked by adding a "may_preempt" notifier that would get called in
schedule(), whose return value would determine whether we'd try to
schedule away from current or not.)

It was VM specific, but the same idea could be made to work for
generic userspace tasks.

-- Suleiman

