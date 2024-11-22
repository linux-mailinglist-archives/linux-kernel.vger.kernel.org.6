Return-Path: <linux-kernel+bounces-418732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31379D64CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A1E282E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B13178CEC;
	Fri, 22 Nov 2024 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26YOuE0N"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A0175A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306633; cv=none; b=gTGSe+aEhxfL8a8ctMjRQ5UcMqFS4rAWIWvkXBF7WJ1tpujIvhCCmwOs43U3V8swSfB6olMy4i9vtGMwnp1RrPUGaD8Qjx/pHosAps7MPbI7VJcvAxBDNbVEVnbZRNBgJFgvxjLy6AIf4F6YXB57IGg9TIDqgLnPqMdtYiY2VcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306633; c=relaxed/simple;
	bh=KmeFhdBtuaq6g3lkgDM2V/1Ngqeol4WqkFh8u2leAiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqWiZRTiHI39BUco6Di7x5mjBCOJZAYM/8AQlT/46jF8D1wvHzpVWBjk3QUZl4xUoR0NtYeL8/2WcwmUwWhYmyDhNvCtxq+3aYdNdapqRPf/RCw8gvtwD30FDPKKxyXD/SPyS8mfgKi8moUAk/Qfabl16sOZ3M3lsgaq6BupP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26YOuE0N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4319399a411so23026885e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732306630; x=1732911430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG3kEeD4o5WMVUrR5MGaMLkHMAvK8n76S6L6z1qKop8=;
        b=26YOuE0NvnpJFeapZ3G1YoXydvUwuATpnUQRRhbRTzJ3QFxU+PfqXiZygrUVBQjfPX
         Dtmk+1fzg/pyc3F392Z1qzlSZVUiXBQgDsDRPAFnJQHlpYI5FWhNGoa86n4iTvxlukWD
         Ard6BW0aIKNFF0+54qX/WAuSjdwB9m9wu40tEQOD9iSd0srKMw/My+seA1qGhdiVv3Qx
         t+AXhVx3Nwkn36ULx1HLkb6vyOCe9ZougFBrb0ItunkV4CO/lUjli496oxzfYu2XXr8v
         x8fv/6meaq34CphqblhMI3M4UbCJmd4NwX/+RyjP4djYq79tiINSKE1uYAaxewceFeDR
         NjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732306630; x=1732911430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG3kEeD4o5WMVUrR5MGaMLkHMAvK8n76S6L6z1qKop8=;
        b=FNGZDI+dGpfP7bc1ocxEQkBfnoVUZe08San3bAlQ2Uuo3zMIME0fOtWACXUUjfLHs0
         uouQM3ItRozzLEz2j4wywi1JApjGL1dNXvQAivH/Cqthk7XbI9meuzEx6C6wKhwCF4IN
         OnjKcDkry2Ezbd7plLYdiPO4z7siWd8yITtcrQUY4IsTmpHPiz+4aL79+V5EKqVTL5A7
         PZUnMlmw8GQT44GqPpo2yx65VKg5/i+6tkvcw3kdbB+zkiTckucjD6g6VOl5g05dMXko
         QVMcZt6KvbriXm7gJKDo2eB23KL1cXUox/jEc4c+Xdal03+75j6roWCbk9UYa6P3YIsv
         jIcw==
X-Forwarded-Encrypted: i=1; AJvYcCUxlY2qPoWuooc61yFRQ57SrvcWcnWeUdtjWSVOi8hambJT1FKC/frdggCQA8wUT5EAe6Ph/BwEfxV+I0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+vkJxB3TPvlt4QLLPvlX89D/nnkMM7Arq4xFJf1+p3RGN86B
	J/suoFz2n65mJQwjJKVvqW6E0AX8pOZPCNbQxYPr7RhlBuXisI26aKHPJi/fb/uTWUjiCVdjOyb
	AWd9GRWi+W83B+I/Bytl6zIprf9/3/HYyclaA
X-Gm-Gg: ASbGncvFUeT4WRDKTUt/G8soFJ9s/sX2vk0z23ltzmqcFqD25z8H4JUQaWx3hKdiC/D
	a75TwOr2eeSI9y2HGARezckxCWA5uVL9w
X-Google-Smtp-Source: AGHT+IFWqePFuP+tQF+WkpAWE/TYTHdWg7sF/rMtGjGKkKfM5BVl/SGktBjFR20250IpBmxLobH9zw/Mk8zzOzHVBm8=
X-Received: by 2002:a5d:5849:0:b0:382:2f62:bd4b with SMTP id
 ffacd0b85a97d-38260b86b74mr3165216f8f.33.1732306629848; Fri, 22 Nov 2024
 12:17:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com> <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
 <6740d8be.050a0220.30b282.4f2e@mx.google.com> <Z0Dbvbj39c87EQTq@casper.infradead.org>
 <CAH5fLgippKab6Qarc7go8pz8XPrvEOoi_FvzMNAJXzr8v3qqjA@mail.gmail.com> <Z0Dhi3LDfxFGtAQn@casper.infradead.org>
In-Reply-To: <Z0Dhi3LDfxFGtAQn@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 21:16:58 +0100
Message-ID: <CAH5fLgjow4x=qH3HDRZwQVus7maZZN9a6cpQ3tPabVWepj8H5Q@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Matthew Wilcox <willy@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 8:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 22, 2024 at 08:43:33PM +0100, Alice Ryhl wrote:
> > On Fri, Nov 22, 2024 at 8:30=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, Nov 22, 2024 at 11:17:15AM -0800, Boqun Feng wrote:
> > > > > I don't think this is a problem? As long as a thread exists somew=
here
> > > > > with `current` being equal to the task, we should be fine?
> > > > >
> > > >
> > > > I think I had a misunderstanding on what you meant by "operations
> > > > that are only valid on the current task", you mean these operations=
 can
> > > > be run by other threads, but it has to be *on* a task_struct that's
> > > > "currently running", right? BTW, you probably want to reword a bit,
> > > > because the "current" task may be blocked, so technically it's not
> > > > "running".
> > > >
> > > > Basically, the operations that `CurrentTask` have are the methods t=
hat
> > > > are safe to call (even on a different thread) for the "current" tas=
k, as
> > > > long as it exists (not dead or exited). In that definition, not bei=
ng
> > > > `Sync` is fine.
> > > >
> > > > But I have to admit I'm a bit worried that people may be confused, =
and
> > > > add new methods that can be only run by the current thread in the
> > > > future.
> > >
> > > I agree, I think CurrentTask should refer to "current".  Or we'll
> > > confuse everyone.  Would ActiveTask be a good name for this CurrentTa=
sk?
> >
> > I mean, it does refer to current. Any time you have a `&CurrentTask`,
> > then you know that you got the pointer by reading the value of
> > `current`, and that the task you got it from hasn't returned to
> > userspace (or otherwise exited) yet.
> >
> > But the name ActiveTask also makes sense I guess.
>
> OK, I'm going to be all rust newbie about this (zoea?)
>
> Given that there are operations that we can do on 'current' that aren't
> safe to do if we pass current to another thread, is the right thing
> to say that we have Task, and you can get a (Rust) reference to Task
> either by it being 'current', or by getting a refcount on it using
> get_task_struct()?  And I think that's called a typestate?

There are essentially three important types here:

* ARef<Task>
* &Task
* &CurrentTask

The first one is using the pointer type ARef<_> to hold ownership over
a refcount to the task. When variables of type ARef<Task> go out of
scope, put_task_struct() is called in the destructor. And constructing
a new ARef<Task> involves a call to get_task_struct().

Now, the second type &Task is a reference to a task. A reference is
when you *don't* have ownership over a refcount. They're used whenever
there is *any* mechanism keeping the value alive; the actual mechanism
in question is not part of the type. The way references work is that
they are annotated with a compile-time concept called a lifetime,
which is essentially a region of code that the reference is not
allowed to escape. The compiler generally enforces this. For example,
given an ARef<Task>, you can obtain a &Task without touching the
refcount. Attempting to use the &Task after the ARef<Task> is
destroyed is a hard compiler error. In this case, the ARef<_> keeps a
refcount alive, so accessing the task through the &Task is always okay
even though the &Task doesn't have a refcount.

Another mechanism is `current`. The way that Rust's `current!()` macro
works is essentially by defining a local variable which goes out of
scope at the end of the current function, and giving you a &Task where
the reference's lifetime is bounded by that local variable. So by
ensuring that the &Task is bounded by the current function scope, we
ensure that we're not using it after current becomes invalid.

With this change, the `current!()` macro instead gives you a
`&CurrentTask` whose lifetime is bounded to the function scope in the
same way. Given a &CurrentTask, you can deref it to a normal &Task
with the same lifetime, so you can also access the normal Task methods
on a &CurrentTask.

And what's happening here is basically that ... you can use the
&CurrentTask as long as the function you created it in has not yet
returned. So if you spawn something on the workqueue and sleep until
the workqueue finishes executing the job, then technically that
satisfies the requirement and Rust will not prevent you from using the
&CurrentTask within that workqueue job. And this is technically also
okay from a C perspective, since the address space isn't going to go
away as long as the function doesn't return.

Alice

