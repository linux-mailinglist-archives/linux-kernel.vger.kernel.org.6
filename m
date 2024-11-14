Return-Path: <linux-kernel+bounces-409796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FBD9C91CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BBB1F22704
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9419CC0A;
	Thu, 14 Nov 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoyLSPhE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D119993D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609653; cv=none; b=I4X/NTmohIIBLtkJHx+aRxdPCS/A9n9W+xncyqUMdqCFxX3M1Yt+YYTC3cNxmo2M+cOO7Z7eclXYIr3ecwZcJ4GZn0jHBUcnOzgt72tTHvsC4LUty2oLL+6I5Oj+kZaRsQB6ybIxtpcfaLaw+5FjpVydG7hCLExxGInv+V21AIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609653; c=relaxed/simple;
	bh=oEk7BZ8L5KOfLVEi91rmtmNKS5T0Fm6ByTo0N0BCCWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5MwsOhQ6ZrN8Oaq7jfI0TZnDhc7MnhD96j3KUs3uftzuMd5L7ivVruqU88HoBsFwrVUW6eWqCGoT0lW/arQ7eg9lMYoXqH8xVU79JomVV/QSxJHmNN/RZTHPpwFNKGPFv+95BNPE9xfqgfM07q6n1C3T7N5QN6K7HDJ21foU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoyLSPhE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9ec86a67feso184199466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731609650; x=1732214450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEk7BZ8L5KOfLVEi91rmtmNKS5T0Fm6ByTo0N0BCCWw=;
        b=IoyLSPhE2xXXFiuYxnt5js+ax2Sf3/5uWTRW0vj2+9sDA1cTLtboeUSO8n3/f5KtIS
         qy71AlULy1EPOuvZkLZPLfca7XZaWNzTrKPSSA2mLdOH3MxEt1e0sUNEDgPiIJoTRGre
         vYMQW2++JL5khkf4EGQ/SXOh+ROwleWOLo1ZOYdY1nyKljQwSoQvzJaUJ6030Yvmbp1m
         +WiJsCAsECfhlCbyS2FZHH+GQ+eOj2I3I9w1hJN4GcdPzvKtPXPOuKg5jT9Kl1gZGuzc
         85nN0oqArcifDpiV9WEWrbAWPKDtO/8DwTjjtn2F7JgOdW77zW/bIHQyEYGCvK7HlfOe
         x2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609650; x=1732214450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEk7BZ8L5KOfLVEi91rmtmNKS5T0Fm6ByTo0N0BCCWw=;
        b=O4k22tH5H+OX8TacShbHCBilBjhzZVxFD07gTRg8biu29XxJyxXRxJMEUOM2E1XIpE
         gf3y9cPzmOC95SDBjWxzX5WF8hcuOrecKGyADTJM4+h6tR3IOM/6xmvj58KsJliL/qCK
         imZyPV2XEGsGrXOsXj8wPAhe1h+sNSBMx1jimTHB0uwV7QTv1tEC1qwmufE42bcrHtsY
         bEuw7UHyN0wWQY4Hjjk067n3zNpXBQvG9l8S5GXVxXk6buuR/+8WwtuEgehZ7MPENVWE
         iUeP7lqPAbRSwYUGIwnJwHaKcVqQo0vWsLHFdVK+FSYzxL6sezIDvVuDVnMa/kK4RaWA
         s5Lw==
X-Gm-Message-State: AOJu0Yzcu3fooKTRjJ3BZsv8xZOw6YiqoLiRw/IPtACbPRkQTiGLLxKI
	6VYtatuYcdWhiNLK6GMFr4ONoMAaIS+OouD2s9OeK90cbtycgXkKjX4ZvJGP5Ex/yVP1BmATQZY
	izqkhbfNZMZG/ItBGno1EuTfYzOEEE/lNQV0=
X-Google-Smtp-Source: AGHT+IE6B3oQcO5YzzGjxaKAskCM/mQFBoS4nrImpcvJVjwUqyLRcM6D1MKn+EAI33uAy64uNg76StiD/5f1/A8N1mI=
X-Received: by 2002:a17:906:c007:b0:aa1:f73b:be43 with SMTP id
 a640c23a62f3a-aa1f73bbf94mr637529866b.32.1731609649877; Thu, 14 Nov 2024
 10:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
 <20241113215252.3977066-1-jstultz@google.com> <f6dc7b18-e9af-de0f-7871-6ceb24e24459@amd.com>
In-Reply-To: <f6dc7b18-e9af-de0f-7871-6ceb24e24459@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 14 Nov 2024 10:40:38 -0800
Message-ID: <CANDhNCqDJ1MTmvgZBtu0tOJJFyZXUTGbv+mKc8_jjkq5Ky0VgQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>, regressions@lists.linux.dev, 
	Thorsten Leemhuis <linux@leemhuis.info>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:37=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
> On 11/14/2024 3:22 AM, John Stultz wrote:
> > Anders had bisected a crash using PREEMPT_RT with linux-next and
> > isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
> > wakeups from under mutex::wait_lock"), where it seemed the
> > wake_q structure was somehow getting corrupted causing a null
> > pointer traversal.
> >
> > I was able to easily repoduce this with PREEMPT_RT and managed
> > to isolate down that through various call stacks we were
> > actually calling wake_up_q() twice on the same wake_q.
> >
> > I found that in the problematic commit, I had added the
> > wake_up_q() call in task_blocks_on_rt_mutex() around
> > __ww_mutex_add_waiter(), following a similar pattern in
> > __mutex_lock_common().
> >
> > However, its just wrong. We haven't dropped the lock->wait_lock,
> > so its contrary to the point of the original patch. And it
> > didn't match the __mutex_lock_common() logic of re-initializing
> > the wake_q after calling it midway in the stack.
> >
> > Looking at it now, the wake_up_q() call is incorrect and should
> > just be removed. So drop the erronious logic I had added.
> >
...
>
> I've been running rtmutex_lock torture test in addition to a few
> standard micro-benchmarks with the fix on my system on top of
> tip:sched/core and I haven't encountered any splats there. Feel free to
> add:
>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>

Thank you so much for testing! I really appreciate it!
I'll resend with the provided tags and without the RFC here soon.
-john

