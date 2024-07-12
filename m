Return-Path: <linux-kernel+bounces-251146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7166A930127
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD80283CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270313A8D0;
	Fri, 12 Jul 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwjUjhn4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E94595B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814083; cv=none; b=kgIlSNGNgreipNWTTsz5lnVkmK0YEbVDwxznV38XMTAeunBvQuR1TxhYyuaRqjK6lPUACrUQwt6zUO3t9heuBk0Wx2OQl0cU3otQkdSuHLmmq0H7PrBWHYVefCPW7C7BAaJ1MwILf4P1H8ELW8ME4nJppnUMB9m8at/15CsrPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814083; c=relaxed/simple;
	bh=4SchWY7S6NRUE49TELE+HE1TqvjIcIbZLMftWmUPkpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeTW/KhCk0iD1/SJUE6Kz0uMntWFBeuxBNnMjrfoT1nTnh1fxuL4nBahHih5G9HweYNCVZigy5ixKMCjQEX97CSSDRf+a1O8xm9Fr7PYGt8U3uXAneZYb2CUB0+oNmgm0vSXFi4/6AFHADBceNuRk8Nm9B+gD+rFXv1ufqWBmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OwjUjhn4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42666b89057so17805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720814080; x=1721418880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCNWxK1vnzk0cXKr4+S/YRzGwip2ddKd6b1A6V9LmVw=;
        b=OwjUjhn4zVtKIftnxHGXxHHufOY5lysT+xQKVATs/+7Z54p4h73WfhR52C7kboA2Sn
         b20WefZHjjowXtwuqDkdt4NOkU3LqgC+WANQD6ToatPxmuKndObVpN8WahcWSHcM3FlR
         h5FyZqQhvddIvcR9Apl+52VSdMbOreKU38uaVZ3difQocivHj7U401o+3ZYnOhO8pgse
         OYo7HHjIFIXJv8qWkVfyj9Wr1ppIXwnEYx0TSsdgWhTOkPpwag3k/5rzkM6bIeWw62ck
         RGJwpfeRLQKIbFaZnkKzF8zQOn6bvUYkwi3y7iMbhjlXUH3g73ZpfCrPcjd4YT3vr0Z8
         ovVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720814080; x=1721418880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCNWxK1vnzk0cXKr4+S/YRzGwip2ddKd6b1A6V9LmVw=;
        b=dG2Nnh9iML1VaddtluFni8NAKr8h37IQgfDOvO/aNHf0gEMffsyArQLshEJNxxqcmo
         4+LGs1JHpTJNXAzK9gaHaw9fme3jlcbRxiBd0t8mkHQ8iSF3zHjVcLZQTqVHFSOcs6R0
         M4o7Ux22p4WD7pak9AVKfZBKsUQuyhFso/zCd3oYOVJuDtnDfr7oFzWACA0Szlwre0rq
         ARwA6WflZTGUMbljdkDesv5Tv0ORUzsTSNxwMje20xq7025BBrkVpTxrWVIeARRC9OCm
         TobAa4HTDmgvXEbjS6Pw1Jt5uK4rIyedGCrVcy1Ev5xmYpCmX5UtwSV/BN1f4xm21sK8
         Ipdg==
X-Gm-Message-State: AOJu0Yw8gZ9BuZEkqOrfFAg8VUYjVghDRMekaNhX9WLdYRrBLMQ63ypY
	Z02wD5lXtn3IZjyYZDxNIr31DhUEruKUMdkRmCRG0Y3qYdIa5JOPcKOhclpSH3BeJYGeaUlOI+J
	a2I25tekngZdAPvM9vxZ4R1mXzBM6LJubkms=
X-Google-Smtp-Source: AGHT+IFs6bHKwYBRBXQaiYJPRrjQWtCOELU13jkixcBvCruX4oD/N+aWF991g34L+PbA5sgTA3+/cyayIqwQSu2/G/M=
X-Received: by 2002:a05:600c:6a84:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-427a46fe3a5mr335615e9.1.1720814080138; Fri, 12 Jul 2024
 12:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com> <20240709203213.799070-2-jstultz@google.com>
 <20240712145247.GL27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240712145247.GL27299@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Fri, 12 Jul 2024 12:54:29 -0700
Message-ID: <CANDhNCoW9LKF0bPiBqwkV_30WSjcpK6RPTf8MbdNsH6D1dVFNQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:52=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 09, 2024 at 01:31:44PM -0700, John Stultz wrote:
> > @@ -405,8 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *loc=
k, struct ww_acquire_ctx *ctx)
> >        * die or wound us.
> >        */
> >       lock_wait_lock(&lock->base);
> > -     __ww_mutex_check_waiters(&lock->base, ctx);
> > +     __ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
>
>   preempt_disable()
>
> >       unlock_wait_lock(&lock->base);
> > +
> > +     wake_up_q(&wake_q);
>
>   preempt_enable();

Ah. Will fix for the next version. Thank you for the review and
pointing this out!
-john

