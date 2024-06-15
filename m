Return-Path: <linux-kernel+bounces-215699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA209095FB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6F9284D89
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2ADDF6B;
	Sat, 15 Jun 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0JAE6Ik"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA7139D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718425828; cv=none; b=W4NietKAsKf4lupJaExioOg3XH166O00bAfVA/FX+no251pcjwn8Q2Mz+VkkrITHv5t5tLfgJ0XHxZLMPn4zYVf0Sp4hRhPKUaPsauc4LXlHfsX//f4pg16+YbQVkisgOA7Bxd/0kWTMNE5j40tpoIkC9uwqTb6RtN/XidS1alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718425828; c=relaxed/simple;
	bh=et72wdh02USuUZ9T3Npp/+khcLFvzyihP6fMTFDqalk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL1q6wD28POfnsH52kRBjOf5FRlrSOZvv7BOsbzKY7AV/GIEob0z91/7JV1HGRrYPKBD52rpsV0H5voL5XtetJ9kJSKttOhCd/b/l1lmJwNfpNOJZbO6h5yiBgHwAf6yuXWN6jXMLM1TuTffs595t/9ogSv+cWiZyjpehSWddfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0JAE6Ik; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so32185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 21:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718425825; x=1719030625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biTC+V9v+0IuoKTuZRK4hT7YvOAuo0qgtjaFOA7jUc0=;
        b=l0JAE6IknfnvW7FyFuh5sTes7jyDyw+DXXOCV0RrbIySOkt5G4GXL47zVjoW9PoSKU
         BPokFSP+2W9klA1pZKmsoye/SLZ5ZVhv8u+QBsVorMEvLepuUNRrqFdcCiHQUDLPMrET
         7oN69VIbRCoJTlVtfky6YzqgOY9d9jKXqSEdz3xMDCeYxMHSCDRGdm8jP/jqBrc2IjOT
         UWMWgMp+3KjqFoWcdbQBAP+sH07RO9kk38lPKqGeYcgdRcYiTjwMG/Z94SEarXhd2oEP
         pw0jBAfwYn1Qm5UWWVZyRbXdIIFZkflCrP73U0e5ePJuDCUxCZExusi8p1JJoGTClvxK
         GoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718425825; x=1719030625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biTC+V9v+0IuoKTuZRK4hT7YvOAuo0qgtjaFOA7jUc0=;
        b=u8AtRY9K8/SNNL3bc0MeTSsrPVFQC7WSxAIZf7xuw3+s9DDYDFnRHsKWrdqt7CZQkC
         J4nv0jwo63f4yLUWvjSpIDq+Qe0cEM23E5Fwx/cLXTjh3Jkh1B4RzUeM21QrYv195+UP
         zj8EZneMZi0xrtnv+lI7EBMGtZ62h6sgKID6Z6WESFfSNDU6OpgWK9ZT47/2VLkpWtze
         IALZsWQuwzHyV+ceA1rOv45dbBIGAud5G/QuAJkRsa9UkDjndXw8v/GcQN25e044U6pe
         6qXip+bjEoJl0eIIW70xKppAVSUdfvn+qt3QTXBVYgkWatv3hFM+j5JI9MvGZKX6FMFk
         Djxw==
X-Forwarded-Encrypted: i=1; AJvYcCXRGI57Vrj/u7zosG44Q8luOLLEXk+0iCqE+0frCKqf9fLTQrjW2lW34HeCPvFXS7l4gGee5gBEmgLGxYXbZdeEIiYtb9E1IAwa1RmP
X-Gm-Message-State: AOJu0YyKMrMzCm5mN8iGeDquSPrQZU1KDJ+f7D9ffT3+4VK4PFDyiXqV
	WnswC0Y4KA1nCm3SLnYC9kJlV1xQAlbnhZm/bnVBZQY7yMaKvuuSbl2UDra0gEsf1MHOlxAXYCd
	AzYav90qZbNBMLX/7kynvmvBNOd8Fd2NuPYM=
X-Google-Smtp-Source: AGHT+IGk+hi/MiIXgzzulLGlm2+RgBP9KqPoDtrjtbvERZ3kT95RHNnFhLGGo1pVu8CDAlgBxU9VF6ezPtrya5ir8iE=
X-Received: by 2002:a05:600c:500f:b0:421:788b:7f21 with SMTP id
 5b1f17b1804b1-423b5f934c1mr886875e9.2.1718425824830; Fri, 14 Jun 2024
 21:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com> <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu> <20240614094833.GM8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240614094833.GM8774@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Fri, 14 Jun 2024 21:30:13 -0700
Message-ID: <CANDhNCrVVTtp37BH1zdTBUJqXCFpzSAOpqEvXii2kKTg+k=wBQ@mail.gmail.com>
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

On Fri, Jun 14, 2024 at 2:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Thu, Jun 13, 2024 at 12:51:42PM +0100, Qais Yousef wrote:
> > On 06/13/24 12:04, Peter Zijlstra wrote:
> > > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> > >
> > >     sched_clock_tick();
> > >
> > > +   psi_account_irqtime(curr, &rq->psi_irq_time);
> > > +
> >
> > If wakeup preemption causes a context switch, wouldn't we lose this
> > information then? I *think* active migration might cause this informati=
on to be
> > lost too.
>
> I'm not sure what would be lost ?! the accounting is per cpu, not per
> task afaict. That said,...
>
> > pick_next_task() might be a better place to do the accounting?
>
> Additionally, when there has been an effective cgroup switch. Only on
> switch doesn't work for long running tasks, then the PSI information
> will be artitrarily long out of date.
>
> Which then gets me something like the (completely untested) below..
>
> Hmm?

I applied and booted with this. It still takes the accounting out of
the hotpath for the CLOCK_THREAD_CPUTIME_ID the microbenchmark
performance is back to 5.10 numbers.

I don't have any correctness tests for irqtime measurements, so I'll
have to try to work something up for that next week.

thanks
-john

