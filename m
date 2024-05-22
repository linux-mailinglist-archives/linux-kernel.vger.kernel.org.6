Return-Path: <linux-kernel+bounces-185837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396AD8CBBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3EC1C20F52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5267BAFF;
	Wed, 22 May 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMt2YLAe"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C944374
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716361610; cv=none; b=CAqa0eLFk4ptpZuIsrt5uOVwQW+covsGkoP7f5SDZRvaKtl0sevyc9JEnf4HeKxmsHvmyClXoLCqa9WVf0YStf0CNpK1qVw5xjrV6G9HUhPynl3gOGR/DvwtbBIdNV5poKCJQTUZMERHSCn3ZgM8LohnlpTNC0Xn/OKTMK2Yyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716361610; c=relaxed/simple;
	bh=WwISwpMFMwJIC6EppTp49QjaUSjX9f1RPAknL9LHWIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZuRdBXnGHOy7FHwVvI886wR5VFAmZDIXY7WE/6xaZNACXciL+Xv0jZINpRYFICnDUCddPER3fqnap8NfX7INon1owDh77AbGH6KFjTHUC7fRso46n4OgMLZ4vHaYfIj4sALEZ+Fx1pbLKgCOuFp1ChwLE1dpV9fjTLqriksecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMt2YLAe; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-248f7fdc323so2218129fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716361607; x=1716966407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DiScAt5S4ywxHN3dM0N7e6SR+dsj1XmtD3cPD5hzZs=;
        b=CMt2YLAe63Q9YkddIafQlswbXcV0fidr/NqGrp9/lYjTc2Tu/Qw9GlqUh3geu2Z/na
         U0sxLPKnG5lFEBYRe5JXx4sHghzgIpVW0QLOxOu9Cp5+oiWW99v5MOLws/qp7g6+OyXU
         4dnjBJcAwaoBYfJtUxvG1O5+zo9Cj01R8rx0jKj6VU239Qk6VfJjxHoKs7J+5Yxr0ZQG
         /UkWZztTZ3LxTnpE5qhGTCUxvU4HaffRWRJgpPIQvyz8z7KsA/LOFqWgGXenLXrL6ptc
         DHAvJ7tExj1c0DPpCVgYIly9FCZ/CnwvkUDR5qwj/v4DgCryUEiVJotHylY/v2XfZ1gT
         1Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716361607; x=1716966407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DiScAt5S4ywxHN3dM0N7e6SR+dsj1XmtD3cPD5hzZs=;
        b=GUaTs5Kz9Mz7T3BM0lLJeXTwvCLSoW28tMitL/IfbKGUSnDBbo6B5B96uqYRojx7JV
         Xmd7BGifMZST+Ih4Dmy1PjAJ11ToMktIQCfc1I1DjmAYoelLldNjYaH/pD+8wYM3y9RX
         /bhwjrEzanZVdPlJwAQT4msfCQQ4Ax6Ard+O9Xkkr7VOyaPI6eU3QYhyzS4xIkacBj6r
         Hi+ggOjx5vuhF0yUfXDcYWFpjoVyo1Z+FjICW3ELDpSIQMpX1hqF1LCvlsYcIBBAXU0C
         eCx5qmdReOoE5ovyX57tF/aEC96gE6gbxD/pQuvM9NYlnWwzXKr2Qve+5e9X96Hq72Co
         Po2g==
X-Forwarded-Encrypted: i=1; AJvYcCVL8m1LHQfEI5VbgbvzzWWcEDGA3RD7qjjszuxy01LBf7NIgUtZm56wwdWArr1r312/KgEGFRbumj3e/pXHsP8rVP0jWzoDGcYBLkb2
X-Gm-Message-State: AOJu0Yxx2wdlw9uUxMfheDdZcwiW2E37wi/QsCAj42DVAQy7Feqkza8D
	1EUWJuqCP6iCzGP6Hkd59qqNryE9Tae7EH+HuonxU/q4xk79Y9aaSPSJ+WAGdl0WKYDQHCyTKad
	ZSz/yyMNwDysi/8zJXU2pSbdyk9vpzzJJl2XC
X-Google-Smtp-Source: AGHT+IFGTTvIhZZt3JykVs3DwUA3O+o25qmpOG9As7lO9UBva3+LSJOst94JQ0cJSVnFMIWGWMsvkgKEcjCdXg24yeA=
X-Received: by 2002:a05:6871:722:b0:24c:5dd6:97b4 with SMTP id
 586e51a60fabf-24c68d23727mr2148874fac.39.1716361607356; Wed, 22 May 2024
 00:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514175551.297237-1-avagin@google.com> <20240514175551.297237-3-avagin@google.com>
 <20240515125113.GC6821@redhat.com> <CAEWA0a5dBvRwGAnztL56i=JV-WGGiaTd-GdJYdOxZmq1c+bdpg@mail.gmail.com>
 <20240516093427.GA19105@redhat.com> <20240516130913.GB19105@redhat.com> <CAEWA0a7NGbv32RG3DE=RwuvEUZsjQsfAB=i1f82Rr5oj8drOPA@mail.gmail.com>
In-Reply-To: <CAEWA0a7NGbv32RG3DE=RwuvEUZsjQsfAB=i1f82Rr5oj8drOPA@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Wed, 22 May 2024 00:06:36 -0700
Message-ID: <CAEWA0a6Z+jGKtz1Bdc2tP4YwR6u1zeEhoYY1hYZqdxCZMcgjcg@mail.gmail.com>
Subject: Re: [PATCH 2/3] seccomp: release task filters when the task exits
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, May 16, 2024 at 6:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 05/16, Oleg Nesterov wrote:
> > >
> > > On 05/15, Andrei Vagin wrote:
> > > >
> > > > seccomp_sync_threads and seccomp_can_sync_threads should be conside=
red too.
> > >
> > > Yes. But we only need to consider them in the multi-thread case, righ=
t?
> > > In this case exit_signals() sets PF_EXITING under ->siglock, so they =
can't
> > > miss this flag, seccomp_filter_release() doesn't need to take siglock=
.
> >                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

PF_EXITING is set without holding ->siglock if tsk->signal has the
SIGNAL_GROUP_EXIT flag. I think it can be a case when one thread is in
seccomp_sync_threads and others are exiting. The first thread can check
that PF_EXITING isn't set for another thread. Then, the second thread calls
exit_signals and seccomp_filter_release(), and finally, the first thread
sets its seccomp.filter to the second thread. If seccomp_filter_release tak=
es
siglock, it will be handled properly.

> >
> > Ah, no. seccomp_filter_release() does need to take ->siglock even if we
> > forget about proc_pid_seccomp_cache().
> >
> > Without siglock
> >
> >         orig =3D tsk->seccomp.filter;
> >
> > can leak into the critical section in exit_signals() (spin_unlock is th=
e
> > one-way barrier) and this LOAD can be reordered with "flags |=3D PF_EXI=
TING".
> >
> > Hmm. I thought we have something smp_mb__after_unlock(), but it seems w=
e
> > don't. So we can't add a fast-path

We have smp_mb__after_unlock_lock in include/linux/rcupdate.h.

> >
> >         if (!tsk->seccomp.filter)
> >                 return;
> >
> > check at the start of seccomp_filter_release().
> >
> >
> > Cough... Now that I look at seccomp_can_sync_threads() I think it too
> > doesn't need the PF_EXITING check.
> >
> > If it is called before seccomp_filter_release(), this doesn't really
> > differ from the case when it is called before do_exit/exit_signals.
> >
> > If it is called after seccomp_filter_release(), then is_ancestor()
> > must be true.
> >
> > But perhaps I missed something, I won't insist, up to you.
> >

You are right, this check isn't required in seccomp_can_sync_threads, but
I decided that it is better to be consistent with seccomp_sync_threads.

Thanks,
Andrei

