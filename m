Return-Path: <linux-kernel+bounces-396861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB089BD34D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D2AB223D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18251E260F;
	Tue,  5 Nov 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyP/Mdt1"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851A1E1C33
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827395; cv=none; b=iWKHFRYRZlTdGXMzZRsM1Gu4GT0g8jAcAlxx6RJO8y9SCkfdTmpCP7yVPKMMEkkwPjXY1w+Rwneu6wvC0BzFM/MciBxygsuYjwwbNoS5WLoDLWk0Ny87kk9ku339XAVZkV3F8TzWsl/+ns12/Bm9YW2CCBCj23HEY+Wdrxn6Ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827395; c=relaxed/simple;
	bh=X+nVM5Ux9ZuBPMElI2g/fbAvFXZkWSd4puN8DC0/0co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+pVFld5GAj6v6KIBK53gpncvLEojEH9++HP5FJi3Lt6oTxwu3EI2741b/jxKzXf4UELhDH70YiaTQaCJhYPTbNp8khVfM18SqUejg44CM4FaWUE96tgbHHeHCeROpmsiASLUd/mZ1zp8jWx6cmvqZI5xHcIslScZyN05lxBkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyP/Mdt1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4341487a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730827393; x=1731432193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFEkJSmFiPqxmVdTIAWTeQZ4orXSMuinYyWJKTteJXA=;
        b=gyP/Mdt1RZQdQ5P+xfOA+FlR7nTT7nFhmb/drJGzuUeoOoVixSbrO1riueYMdLZieJ
         4W82Vi1hEQo7xPCJ6S7W1BppRwvaQVu34APK22aAwYhp49lQQ1+mRJO5U0WZRRtWSDG4
         hQKMa2y4ErarMOu9Q8vCliGDVUeaaILYUzij+be+cTY+ls2sphzMtKECaO1yBMh2n8eU
         jxDwYxKiE0Oj/tDSRLfIDGy0UqajLPLFeymM2A4zN/+TL3BP9gMIESFGcUCuR53qomNL
         3pZXSgFOrnjuhrZCp2HWvj48740egpSXUj1FcDQMe/rXTqzRyzxXfloXmab39N/9TG4w
         WX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827393; x=1731432193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFEkJSmFiPqxmVdTIAWTeQZ4orXSMuinYyWJKTteJXA=;
        b=O9KjxtkZNEfQ+RYR5A5937VB6iY8JWrF/2ygx6JppF4ZH6YVLzEguUu9L45dOruSkZ
         e3XpOj5uOdFaDEgHsOk80zfj6Ji93OfzVmaiZcznQ67NAHfKcXFbyHrfr7t/PmmO4oFl
         rydfqvPx+EI7T5BKBVpZQHEoOBat1R/clD9R9Ca/BZvrJQ1xkkxEuGD61vRvVMVyjtdG
         t3wnLXMwu/pL8rzD/HXSDDRl4Ux46Scj4mtm7ZA5tCidPau+RwTozLx33x8Bm9Lv+8YF
         as774rkHAW2t6CP9wOCSBQqTuF1a5UjKMApqfBLuqSuEKYMpRW4bUzbg7uY2dWw3JZvy
         kbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5XbqtPa3uZHtoQLYvVP0UUXe1j1uGBqmODHyhbCVa625U0Jx+Z6TvnrrWHckNEfCJSK/R+ovM40ij7ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhnhfO5/Yq6zIl0jBFNksf6ZhZgUji/mj8dBT8Y3EW7oT5HFv
	JO4Z+3cIOatDkZWgnhelzhBqZdvMEY/HHkY8QAmG/FfTUbz/tB5OsXAvkb3HcRET91ZhX6uwyQ2
	DUnlXG6DoM8XyhbUrr8xygegR3bvbKpeaVUkQ
X-Google-Smtp-Source: AGHT+IHma8fLUOn+H32JHjxE8FoZSYPSkUkdl8S3zm6eR6C0od/60rQM75LsVAzSrn9/BZfRkG+odt/kNEHn/zPcTIs=
X-Received: by 2002:a17:90b:4c8b:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e93c1d22famr25936840a91.28.1730827392768; Tue, 05 Nov 2024
 09:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
 <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com> <20241105120247.596a0dc9@gandalf.local.home>
In-Reply-To: <20241105120247.596a0dc9@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 18:22:36 +0100
Message-ID: <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 18:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 Nov 2024 17:53:53 +0100
> Marco Elver <elver@google.com> wrote:
>
> > > > +/**
> > > > + * task_prctl_unknown - called on unknown prctl() option
> > > > + * @task:    pointer to the current task
> > > > + * @option:  option passed
> > > > + * @arg2:    arg2 passed
> > > > + * @arg3:    arg3 passed
> > > > + * @arg4:    arg4 passed
> > > > + * @arg5:    arg5 passed
> > > > + *
> > > > + * Called on an unknown prctl() option.
> > > > + */
> > > > +TRACE_EVENT(task_prctl_unknown,
> > > > +
> > > > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > > > +              unsigned long arg4, unsigned long arg5),
> > > > +
> > > > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > > > +
> > > > +     TP_STRUCT__entry(
> > > > +             __field(        pid_t,          pid             )
> > >
> > > Why record the pid that is already recorded by the event header?
> >
> > To keep in style with the other "task" tracepoints above. I can
> > certainly do without - it does seem unnecessary.
>
> Hmm, new_task, pid is different than the creator. But rename is pointless
> to record pid. I would get rid of it here, especially since it also creates
> a hole in the event (three int fields followed by a long).
>
> >
> > To cleanup, do we want to remove "pid=" from the other tracepoints in
> > this file as well (in another patch). Or does this potentially break
> > existing users?
>
> We can't from task_newtask as that's the pid of the task that's being
> created. In other words, it's very relevant. The task_rename could have its
> pid field dropped.

Ack - will do.

> >
> > > > +             __string(       comm,           task->comm      )
> > >
> > > I'm also surprised that the comm didn't show in the trace_pipe.
> >
> > Any config options or tweaks needed to get it to show more reliably?
> >
> > > I've
> > > updated the code so that it should usually find it. But saving it here may
> > > not be a big deal.
>
> How did you start it? Because it appears reliable for me.

Very normally from bash. Maybe my env is broken in other ways, I'll
dig a little.

