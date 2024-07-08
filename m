Return-Path: <linux-kernel+bounces-244893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6D92AAFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B3A1C2178B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C114EC65;
	Mon,  8 Jul 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sxvikd6F"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC04503B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473385; cv=none; b=Zqh+0lcvsyE+QHcu6xe1ayTE1DAsO9LOOasZ+oyxd9hDOHzZ1TWTtAO2luXCgekivIlNSnFfd6WmqtxpUbMBft9iIUL981R35jDkN6BVOEey9qv4XGdqlNOAOxmAJVUHZKlVBjvvxpz1X1eVP83HrnQrwXqj7tGhVNHy3bSNf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473385; c=relaxed/simple;
	bh=Lko4dT+F7IMfBxfuOgUPzzm5iqitFaWcuOHFWpSiCKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akiZ/wtViS/jK1b2en6uAEGvMsBUa+VHdgDDcggZYfPZy+tqowpkeVYhNSTAJwlbkW22TFx5eypnabKXnNWhWcNPn6kHu4AdkJmMa7eVZJqFNPb8g59LKwuYP2VccsNNkwlgC8Cbnz8m9AdTh3sbrT6HEFAQrAUDFOKoKdJRu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sxvikd6F; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so1921a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720473382; x=1721078182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KpIsYE0TleTo0yrVtdXZlELh9EVGU12iXRlWXjkGvo=;
        b=Sxvikd6Fq2T1KY0SbzNbuL+xicuGGbFKjG4OL40BfBe4nKCLd3UM9pWzfXLU1+MfhD
         DHL4coD9TpkCghauNxCxl9FaMHZQzppgyPCExcfVVHo6g+Hq+PNPOU7/AdyAz8X6QjGu
         7nf67e3IjXxV1mKzfmbx/HCPa4EnqUC+PT2vl3c5sd9w3NUSCFh2NyipHZW2Els/Lrq/
         RERm9qLTPiUL9DiwQSqxw4EzTYDjOW8K/fHgO/M9vDonz9fgFTdWWn4avIkxF/J4DJVe
         udoaG3KRZka/5g7+4ZWr+JzQt8YpksBOqAg5SvUykwiRqY6783ogqmRGrbcM0AE3ZoNf
         T5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473382; x=1721078182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KpIsYE0TleTo0yrVtdXZlELh9EVGU12iXRlWXjkGvo=;
        b=EXlQV50OoPizi+/ZaRP0jBEraw0o8ioVCJEwPqK1vcXkMs0/xDOFcJmAZ+ghRwpZST
         PYC/rPm+4DntAVZZ2ZSmcTAyArda/Qc4sMj4Exbz+oL21A1eKC3TfgUB/oaM5tAEomoi
         IR3so7tDa3uORfN8LXGfYi4JyGVbFS7d+wF+dRKwJWyxQpr9bm7eRiWL7KDq5wEXaSgT
         WzrKlfSwXZnKuGtYc6LEREFWK1eX8XtbJl1wZiAG2WMwuTqawSp7byD4pQzjDLsWOvhm
         tcc+AW3SttOrGpcelfOLBSibQR/lMm3FZLXWeKxgzBA8nDBdEkhYmmX1EiLz4QY0kbWM
         QCaA==
X-Forwarded-Encrypted: i=1; AJvYcCVBb2bj5afHGfHFCAUkwa8e9jSl9z4SvzMgxDoPXNvL9QGhD3OQdi8hrRpvoGRR63h08ko4rDU0x0xoV2Q1c6SPPuJgtyvFQXZbggVe
X-Gm-Message-State: AOJu0YzDMjZ5x1xnUIa5S8HeFdahRQcF43EzThqpngzXDbBs7DbZG/7J
	mu1FE71C4U+c2EfdYifQZfhbH81lBU6ndS6gHk5ZOP7NmcNJIxH1EWRuifpscWWfu4m9jFxYGNQ
	8JfQ5t0AZP4KQun5l47mBY8XIdE//LplaVPbi
X-Google-Smtp-Source: AGHT+IGIbhNOycFNQM/zvKsAwdxOR5lJu+RnC4Q2RqfPBJWNKrAOZPLOqS1TPq3cJ2dEe8dfI7ztR942V4cI/hLtfXM=
X-Received: by 2002:a50:d703:0:b0:58b:93:b623 with SMTP id 4fb4d7f45d1cf-594f8aec609mr14200a12.5.1720473381700;
 Mon, 08 Jul 2024 14:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com> <20240708.quoe8aeSaeRi@digikod.net>
In-Reply-To: <20240708.quoe8aeSaeRi@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 14:15:44 -0700
Message-ID: <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:48=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Mon, Jul 08, 2024 at 10:53:11AM -0700, Jeff Xu wrote:
> > On Mon, Jul 8, 2024 at 9:17=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrot=
e:
> > >
> > > Hi
> > >
> > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > >
> > > > These new SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT, an=
d
> > > > their *_LOCKED counterparts are designed to be set by processes set=
ting
> > > > up an execution environment, such as a user session, a container, o=
r a
> > > > security sandbox.  Like seccomp filters or Landlock domains, the
> > > > securebits are inherited across proceses.
> > > >
> > > > When SECBIT_SHOULD_EXEC_CHECK is set, programs interpreting code sh=
ould
> > > > check executable resources with execveat(2) + AT_CHECK (see previou=
s
> > > > patch).
> > > >
> > > > When SECBIT_SHOULD_EXEC_RESTRICT is set, a process should only allo=
w
> > > > execution of approved resources, if any (see SECBIT_SHOULD_EXEC_CHE=
CK).
> > > >
> > > Do we need both bits ?
> > > When CHECK is set and RESTRICT is not, the "check fail" executable
> > > will still get executed, so CHECK is for logging ?
> > > Does RESTRICT imply CHECK is set, e.g. What if CHECK=3D0 and RESTRICT=
 =3D 1 ?
> > >
> > The intention might be "permissive mode"?  if so, consider reuse
> > existing selinux's concept, and still with 2 bits:
> > SECBIT_SHOULD_EXEC_RESTRICT
> > SECBIT_SHOULD_EXEC_RESTRICT_PERMISSIVE
>
> SECBIT_SHOULD_EXEC_CHECK is for user space to check with execveat+AT_CHEC=
K.
>
> SECBIT_SHOULD_EXEC_RESTRICT is for user space to restrict execution by
> default, and potentially allow some exceptions from the list of
> checked-and-allowed files, if SECBIT_SHOULD_EXEC_CHECK is set.
>
> Without SECBIT_SHOULD_EXEC_CHECK, SECBIT_SHOULD_EXEC_RESTRICT is to deny
> any kind of execution/interpretation.
>
Do you mean "deny any kinds of executable/interpretation" or just
those that failed with "AT_CHECK"  ( I assume this)?

> With only SECBIT_SHOULD_EXEC_CHECK, user space should just check and log
> any denied access, but ignore them.  So yes, it is similar to the
> SELinux's permissive mode.
>
IIUC:
CHECK=3D0, RESTRICT=3D0: do nothing, current behavior
CHECK=3D1, RESTRICT=3D0: permissive mode - ignore AT_CHECK results.
CHECK=3D0, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, no excepti=
on.
CHECK=3D1, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, except
those in the "checked-and-allowed" list.

So CHECK is basically trying to form a allowlist?
If there is a need for a allowlist, that is the task of "interruptor
or dynamic linker" to maintain this list, and the list is known in
advance, i.e. not something from execveat(AT_CHECK), and kernel
shouldn't have the knowledge of this allowlist.
Secondly, the concept of allow-list  seems to be an attack factor for
me, I would rather it be fully enforced, or permissive mode.
And Check=3D1 and RESTRICT=3D1 is less secure than CHECK=3D0, RESTRICT=3D1,
this might also be not obvious to dev.

Unless I understood the CHECK wrong.

> This is explained in the next patch as comments.
>
The next patch is a selftest patch, it is better to define them in the
current commit and in the securebits.h.

> The *_LOCKED variants are useful and part of the securebits concept.
>
The locked state is easy to understand.

Thanks
Best regards
-Jeff

> >
> >
> > -Jeff
> >
> >
> >
> >
> > > > For a secure environment, we might also want
> > > > SECBIT_SHOULD_EXEC_CHECK_LOCKED and SECBIT_SHOULD_EXEC_RESTRICT_LOC=
KED
> > > > to be set.  For a test environment (e.g. testing on a fleet to iden=
tify
> > > > potential issues), only the SECBIT_SHOULD_EXEC_CHECK* bits can be s=
et to
> > > > still be able to identify potential issues (e.g. with interpreters =
logs
> > > > or LSMs audit entries).
> > > >
> > > > It should be noted that unlike other security bits, the
> > > > SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT bits are
> > > > dedicated to user space willing to restrict itself.  Because of tha=
t,
> > > > they only make sense in the context of a trusted environment (e.g.
> > > > sandbox, container, user session, full system) where the process
> > > > changing its behavior (according to these bits) and all its parent
> > > > processes are trusted.  Otherwise, any parent process could just ex=
ecute
> > > > its own malicious code (interpreting a script or not), or even enfo=
rce a
> > > > seccomp filter to mask these bits.
> > > >
> > > > Such a secure environment can be achieved with an appropriate acces=
s
> > > > control policy (e.g. mount's noexec option, file access rights, LSM
> > > > configuration) and an enlighten ld.so checking that libraries are
> > > > allowed for execution e.g., to protect against illegitimate use of
> > > > LD_PRELOAD.
> > > >
> > > > Scripts may need some changes to deal with untrusted data (e.g. std=
in,
> > > > environment variables), but that is outside the scope of the kernel=
.
> > > >
> > > > The only restriction enforced by the kernel is the right to ptrace
> > > > another process.  Processes are denied to ptrace less restricted on=
es,
> > > > unless the tracer has CAP_SYS_PTRACE.  This is mainly a safeguard t=
o
> > > > avoid trivial privilege escalations e.g., by a debugging process be=
ing
> > > > abused with a confused deputy attack.
> > > >
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > Link: https://lore.kernel.org/r/20240704190137.696169-3-mic@digikod=
.net
> > > > ---

