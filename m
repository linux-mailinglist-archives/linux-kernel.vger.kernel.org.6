Return-Path: <linux-kernel+bounces-185825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F598CBB91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B751F223C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E17710B;
	Wed, 22 May 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDzNEC4Q"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC54763EE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360581; cv=none; b=ropzYQ4R9Yd0DoWsQoy6MV1ZORGHk5IwxJb5Fw81RFkmfnkXZH9RXhPVKD/1Q6hh0wNLxqDR5xuQ2jr+aLl8aB3IKHPwuOpeTuyZXpW9+uKju7D3ZdUDZRlE/2usnlocdNCxk0y/ZTMx4eko96A5k5DJvuafIeVb9dLhO82h28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360581; c=relaxed/simple;
	bh=t79tNhnF0U4tKmefiJS31gLP7DMNXF7TVaKqyCzYe9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnaxCJNeRk01akKdDMQYLvG4WZe2XO62US3ne5VexUz2VY27aa7+OW8XCOmWiYJFULylggeR6ane+4PVioVQz/8Rr1byOpQkPG2/0BW9NPe2yFQH/u1PJP0Q+r330Omj5URCY7bQQUnrgnAM16WWHgXbrE9f4mbEPyWSLMVAA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDzNEC4Q; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23d38cd0df6so3075121fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716360578; x=1716965378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boY7I+U2IkIFxkvefOK0Ies5C3tQz1C/8vO7w5fV1qo=;
        b=uDzNEC4QVCVZcbi4EqFVdgotHo9rL1t5oE/XxwiY6sD5CU1BHAfIYQ6kPFQtnJQbQG
         A3qgpmKKc95v9n89P6vKz9R76oYbZO5P6KUplRGwuMrWJmLwae+oIDNMKYFQnrxFFYNN
         39NclIqlkjSPE32R6ODWxwTbaQkJ+ozp6vU4AJKZgrLlfxu7lHokcg+KtEAfyAA2vN2r
         GpUgZA/0bGb6eFrYQe9DDjbUdlD62sD/+/NNtsDK5piGMf+eJBXBhM7EE5TBj9lFJqVD
         EG1fgkMgEryAQmyMrXXi7qDH1/CelsoVK3fuhTzzdp+n85NEgNKsoBEBFMTcUkBfg5qf
         8oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716360578; x=1716965378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boY7I+U2IkIFxkvefOK0Ies5C3tQz1C/8vO7w5fV1qo=;
        b=mWsoYzh/ap+Rc0j703qrj7iVkMq0vOvE54gZrqCIvaVEQpmLfeTYfXPACtr8Vi+f2p
         VOOugb33JfJO1I8tClcTSue6jsll/LgMNi+t7Q7wq2t2w3S2hI9IeL0ECkHfedVkbQ+/
         08BjEPEnRRVGTe/YQGqUsd9FNsiksPwpYVQO5fAStNfisyCViDVooMIFCK6OveOQYlmE
         MoUKBr+LkE1GJcW2ez8KFelM/dmXbADEuXGty+m1CdQb+YF6MmSYc5+IJbWjySRQPgCM
         1X0S/I5dUXH+IEHQoty9sgQWiqOg2p2Un0meSSfIWJbscejubao7H69eIbZkDdomNyFE
         C4kg==
X-Forwarded-Encrypted: i=1; AJvYcCWQxc8mpIL3QUMs3CegJamu1wd2OUQhwmCfb/0HyiRp+6fpGWDA+TuvT7gxSKqUSUIQVarmwTKS9zqJ2rUFoL1aeTDU15bSY3bzx+mu
X-Gm-Message-State: AOJu0Yw75TANVIZsElJTKhMTBsL6laEpvml3y4obgi4clFhbpuh0So4V
	ZBergeQpzRwA8e13gbdCd4CpIsDSBAF1WvCZ00+NBmOEkkW/GAw0BFmPcNtd+gFHWkSbIGIvbuk
	mwycgSC8mzhPuL8UXQivvLCD6IFzCyqH6fB+1
X-Google-Smtp-Source: AGHT+IGSUt5c7N996mNyO+k+8eqvBVkk0Zy1gnSDtVoWMBKltkCR/hR6bKlmDxbSutm7Ct5LB7tvw0aetrCohakmuAw=
X-Received: by 2002:a05:6870:ec90:b0:23e:b4cb:5d13 with SMTP id
 586e51a60fabf-24c68d22fa5mr1292186fac.4.1716360578344; Tue, 21 May 2024
 23:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514175551.297237-1-avagin@google.com> <20240514175551.297237-3-avagin@google.com>
 <20240515125113.GC6821@redhat.com> <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
 <20240516093427.GA19105@redhat.com> <20240516130913.GB19105@redhat.com>
In-Reply-To: <20240516130913.GB19105@redhat.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 21 May 2024 23:49:27 -0700
Message-ID: <CAEWA0a7NGbv32RG3DE=RwuvEUZsjQsfAB=i1f82Rr5oj8drOPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 6:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/16, Oleg Nesterov wrote:
> >
> > On 05/15, Andrei Vagin wrote:
> > >
> > > seccomp_sync_threads and seccomp_can_sync_threads should be considere=
d too.
> >
> > Yes. But we only need to consider them in the multi-thread case, right?



> > In this case exit_signals() sets PF_EXITING under ->siglock, so they ca=
n't
> > miss this flag, seccomp_filter_release() doesn't need to take siglock.
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


>
> Ah, no. seccomp_filter_release() does need to take ->siglock even if we
> forget about proc_pid_seccomp_cache().
>
> Without siglock
>
>         orig =3D tsk->seccomp.filter;
>
> can leak into the critical section in exit_signals() (spin_unlock is the
> one-way barrier) and this LOAD can be reordered with "flags |=3D PF_EXITI=
NG".
>
> Hmm. I thought we have something smp_mb__after_unlock(), but it seems we
> don't. So we can't add a fast-path

We have smp_mb__after_unlock_lock in include/linux/rcupdate.h.

>
>         if (!tsk->seccomp.filter)
>                 return;
>
> check at the start of seccomp_filter_release().
>
>
> Cough... Now that I look at seccomp_can_sync_threads() I think it too
> doesn't need the PF_EXITING check.
>
> If it is called before seccomp_filter_release(), this doesn't really
> differ from the case when it is called before do_exit/exit_signals.
>
> If it is called after seccomp_filter_release(), then is_ancestor()
> must be true.
>
> But perhaps I missed something, I won't insist, up to you.
>
> > > If we check PF_EXITING in all of them, we don't need to take ->sigloc=
k in
> > > seccomp_filter_release. Does it sound right?
> >
> > The problem is a single-threaded exiting task. In this case exit_signal=
s()
> > sets PF_EXITING lockless. This means that in this case
> >
> >       - proc_pid_seccomp_cache() can't rely on the PF_EXITING check
> >         but it can be safely removed.
> >
> >       - seccomp_filter_release() needs to take ->siglock to avoid the
> >         race with proc_pid_seccomp_cache().
> >
> > And this chunk from your patch
> >
> >        static void __seccomp_filter_orphan(struct seccomp_filter *orig)
> >        {
> >       +       lockdep_assert_held(&current->sighand->siglock);
> >       +
> >
> > looks unnecessary too, seccomp_filter_release() can just do
> >
> >       spin_lock_irq(siglock);
> >       orig =3D tsk->seccomp.filter;
> >       tsk->seccomp.filter =3D NULL;
> >       spin_unlock_irq(siglock);
> >
> >       __seccomp_filter_release(orig);
> >
> > Right?
> >
> > Oleg.
>

