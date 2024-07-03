Return-Path: <linux-kernel+bounces-240023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719192680A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BEE1C22B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98CB186E53;
	Wed,  3 Jul 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBRsj8KC"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12017B4E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031006; cv=none; b=LC9tN1Qm/SYErhGywSZsy4lyzH6zkvNeJWmy97td4PlK53velWCMcdb87QXBBr21X8U7NA5rMQmUQaUcTBU1aCOrMYZhgOZ5fulMfws3F74Uip0AhV7mrOVTiqWKtmYN1BYDq+PTiRck7OX6GLMqCxptUseAaRX3FRy6zNvYzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031006; c=relaxed/simple;
	bh=qc8HN7KszPEJQ2QhBoSNcT7hbmyYFHAwuyB0gpcFzbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJzkueSh/bl61Nl9fxtCUb4C9X3iQAXeRcCoDzJXh6oZM7oEqR41dGRlxTPT3SJ8rJedmPXAMCNFMx6pUJ7C/BgPx+KcMj2OtD6sUJC7hPjmYi5oKqlviVXAkQrDvc7vK1wYJ6Z4kaqGJWlH/ENj653TipnLDeOAb1U1laV7LSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBRsj8KC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-64789495923so50415047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720031003; x=1720635803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc8HN7KszPEJQ2QhBoSNcT7hbmyYFHAwuyB0gpcFzbA=;
        b=lBRsj8KC8k/tfk/lthvfTEuDqACsXR5jKHx0Qa9noohnwYI9v+7O1r0ZG3uGsNOh3s
         aEXZ04Nus/Na5cNHQ5dNzyVHtKqT5l0upXXip2ACL1pb5n7C7F+6x4+ul9BOCOt0kknK
         nVhQ9zIs91QmEkMEEa9mZ6hMeIKt6Lv/oRcnnRkpg5BNbZ6hNKUt8PZRU+tr7bhy0KIr
         cdlB+Gy8AEz98aiNwMpAmewdfAq5Jj4DalfHpzP0kn6bz3V+Ya2Ab7yvWBs39+4KogRe
         Das864zs1U4EJ5R44IrVZ22GxEK2h2cm/a4sWfVtZCizUFl40mlAWjwD60iwbTNoaTCA
         A+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031003; x=1720635803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qc8HN7KszPEJQ2QhBoSNcT7hbmyYFHAwuyB0gpcFzbA=;
        b=kIcQvxrg+1czy8FV2LQ/Vfm1a4tBstI3m/zWpn+jcSj8lpUExUNlJHMLzjXODlPYY0
         MrtPqXxh59MlycinB497OUChg7uiEGZSFf+y2Xc0MWM6LY0MtoiLSBsAq1+d/4UDj29G
         VXCxCNX3hzL+okWVk08rrdFRIqaBIuiaKFXwfc8wOnchyacA7qszRL+h0R1yKwnqiWV/
         UZ+o4yTY5UMptNlaBWRT7iBw6QummUS8T3SsB8Dd1aT9HWq/myhrJCDqF5ZPzhQAh56i
         WAaEJRRHRh1vs75KaYoW1f9yWv3pKYGLRxNl484/5pPHf5AhkIFdqv2EFfnMVM4SViod
         QJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCX6F1f3skfZEJ/56i4n1QTmYh/VkyUqZYGFFRjUCk5b2EuTe668izoIVb94MnnnvFKeUfuXruyi8WPrBeN/ZoH8+LI3HoeDpJlbfud1
X-Gm-Message-State: AOJu0YyhTE06KSe6UDJbG1mDXg4XQDvDJBoUz1fpSudTiPqJjGJvqvI6
	X/rj2SJSRSGvAnptJQYwFt0GCSCRTpB1ghlxduscfV5ZOA0d2d9j8DBzZ/YcJYaHp573vwffgxh
	gYVKej8KD3MiW81lTbadc0sgFTJ2Uza+7C6Zs
X-Google-Smtp-Source: AGHT+IFc7eakTdb1sT9ybcjBjJRqy5HtZcNocS/fzf0TDpETCZ8IP/lxfLXGQy+D1/2a5N51LZukvKLo5kiFg+6a57I=
X-Received: by 2002:a05:690c:20a2:b0:650:9d94:7982 with SMTP id
 00721157ae682-6509d947c87mr47977057b3.46.1720031003362; Wed, 03 Jul 2024
 11:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628173247.3507846-1-surenb@google.com> <20240629131247.GA6138@redhat.com>
 <CAJuCfpGh9EBqij+Ru_D4ieEHTVx7_a0N8odaOLCPYt3g0iVCQA@mail.gmail.com> <20240703164836.GC28444@redhat.com>
In-Reply-To: <20240703164836.GC28444@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 11:23:10 -0700
Message-ID: <CAJuCfpFiirzUwUwgoxvWY=sMCS_r5BwAmjv2gQ0RQ8sZOJdPhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] signal: on exit skip waiting for an ack from the
 tracer if it is frozen
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, brauner@kernel.org, 
	tandersen@netflix.com, bigeasy@linutronix.de, vincent.whitchurch@axis.com, 
	ardb@kernel.org, linux-kernel@vger.kernel.org, 
	Martin Liu <liumartin@google.com>, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 9:50=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Suren, I am sorry for the late reply,
>
> On 06/30, Suren Baghdasaryan wrote:
> >
> > > I think it would better to simply change ptrace_stop() to check TIF_M=
EMDIE
> > > along with __fatal_signal_pending() and return in this case.
> >
> > I think this would not fix the case we are experiencing. In our case
> > the tracee is killed from the userspace (TIF_MEMDIE is not set yet),
>
> OK, I misunderstood the problem.
>
> > gets stuck in ptrace_stop() waiting for an ack from the tracer and
> > then is picked up by OOM-killer with the abovementioned consequences.
>
> and __task_will_free_mem() returns true if SIGNAL_GROUP_EXIT is set...
> Nevermind.
>
> > > Of course, this won't fix all problems.
> >
> > As I mentioned, I'm not an expert in ptrace, so I'll gladly try any
> > better solution if one is proposed.
>
> I do not see any solution, sorry.

Ok, in any case, thanks for the feedback!

Do you think if I resolve the race you mentioned (what if
try_to_freeze_tasks() does freeze_task(tracee->parent) right after the
check in ptrace_stop()) and replace cgroup_task_frozen() with
frozen(), this solution would be acceptable?
Your question about a tracer being traced itself and its tracer being
frozen *I think* would be quite rare. I don't think it's a common
pattern to trace a process which in turn is tracing another one. Or am
I wrong?
Thanks,
Suren.

>
> ptrace doesn't allow to intercept/nack SIGKILL, but at the same time it
> happily allows the killed tracee to sleep in PTRACE_EVENT_EXIT. And even
> another SIGKILL/whatever can't wake the tracee up.
>
> This is historical behaviour, I do not see how can we change it. Any
> change will break something.
>
> Oleg.
>

