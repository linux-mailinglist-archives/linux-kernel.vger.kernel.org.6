Return-Path: <linux-kernel+bounces-273006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201C94634E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FBBB2189F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF01547C2;
	Fri,  2 Aug 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6OCsT/U"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE742136322
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624039; cv=none; b=C2AB0fCY1b48seTcZIwL7PMl3Kg3Ox5zbgOrBODXWxeWsUlqnWebrfscmgQalQqhyQ67KmXQkKW5A5aVQCA2+fPiUSEfHb92tlRIpIHUoXw4z6iKQWhuShdqZD/Cse93T/HHwgjKM0ZTish6yAg61WhoN1veRngsjeqX9RwC7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624039; c=relaxed/simple;
	bh=bBk8dbvdFkgHztIsamj9A6yqrnV8rALDYulS6Vq771U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYUoZE9HkNZ5PvSnWQLaL+KG6BeFRnjydsa7b2t+73gvTUluYnUYEk6HlWWJ1mQJw91iWqla4ux8cXgdehShyDINKvYN0ml4ps/PNRgmtDXnrvA6qzj2b5bGfs30YsGkc5Pitt2IOrK++gWcphN9IC5uoci0VZk/9xbLnP6NLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6OCsT/U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso58156a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624035; x=1723228835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvGo9T3eyBjc8RzJ3B/6nw2VwxThF3mQa//XCX7dSjQ=;
        b=I6OCsT/URFAZ39H4tJIQ9D+FnQIkN0EAEqXhna1AdaqoY74lPfeKAC0DZk2lD9lTSj
         EZvbiynJSIRNGJwCKfS/sWo2cMkCXLcamrh4MJ1ByL9to5E3vLRgPXQpch1lIZOUZxya
         vNvsBiEeY+yeARIVbELqX8QWDA9uOYBzaLlhdEa8igAowvG84gh5yjFEnDZftlbCLnxI
         QrTAIwl9k3SXnEvBYDmETQ8hvlJlAvvOW7he6R83GMBNYXLU6K+DczdlP42bVebJl9Au
         LEmpvg17Hv8K60htRgWcrJHKbvcS3RRVb61J2PYaniDSuoOZGDJ7TWTto3RNXgKnsM6z
         yEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624035; x=1723228835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvGo9T3eyBjc8RzJ3B/6nw2VwxThF3mQa//XCX7dSjQ=;
        b=FS+Oy1QYCWxLU92xnsbkJIiliEdoaZdaLerlHj2rDTAB4uKcip4kghOYve9o+g48ot
         TJ7UcsP0IcbKSNN3zdnj7Vdvp0jCVzgoeZ9x4FKR9L9CkudKqh26kJanuxpbqV7fy/vS
         PvpAt14CNByTEwhCXOrvqMtDfdAhi+HIyemJMxVl9/702botuA0dDhVIgyDKKvfv2TaG
         O/haYRBQ/3BH3oC3xvXMK5BQwXYbeGPrsDRyQ7wRLyJGhn6Bb5eSMImogx7tnfxXF3tD
         IvGmHJFikSceQqGZHWJhhaeUtXicozrq/2iIJw84x8/uughMwWlTyf+cQ4reJ6Y/uCpD
         1Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCVMsEgQ4K0V+dVY1NVvJMafZ/OVHlD6wbCFEpq4KQ8equI4UiSC5ys5OvPJki8HnwHzzEfWKv+qNNEA3rK5KUH2N19rA33jjJfu20Yf
X-Gm-Message-State: AOJu0YynOlXObz6SO5aLohjY6aXb8d1+tl3CoyVHOmvg9riavB3yFZNz
	1u4QzWWOar7f/fuomDHWFRs6OhFauwfDmCIklrchHxG7/msQO2ZBd0i4PqLDdxmFnHBnDie93bT
	hO7YI3ZjD+WcQyzkwp63kpwikwQBxSF8LEF5Y
X-Google-Smtp-Source: AGHT+IE6a715lvD7e7H+jRBC/YC4Qmp0ZvYcNq+Z2J6Y52jOrAYsO1CDkNEmQVXxr6y4yqKqUpa8HB00+hEb3yiQVGc=
X-Received: by 2002:a05:6402:51cb:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5b99e0a517emr10054a12.3.1722624034462; Fri, 02 Aug 2024
 11:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-remove-cred-transfer-v1-1-b3fef1ef2ade@google.com> <D35ML45KMWK8.1E29IC0VZO4CL@iki.fi>
In-Reply-To: <D35ML45KMWK8.1E29IC0VZO4CL@iki.fi>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 20:39:56 +0200
Message-ID: <CAG48ez1GFY5H1ujaDfcj-Ay5_Pm8MsBVL=vU4tEynXgzg5yduQ@mail.gmail.com>
Subject: Re: [PATCH RFC] security/KEYS: get rid of cred_alloc_blank and cred_transfer
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 8:09=E2=80=AFPM Jarkko Sakkinen <jarkko.sakkinen@iki=
.fi> wrote:
> On Fri Aug 2, 2024 at 4:10 PM EEST, Jann Horn wrote:
> > cred_alloc_blank and cred_transfer were only necessary so that keyctl c=
an
> > allocate creds in the child and then asynchronously have the parent fil=
l
> > them in and apply them.
> >
> > Get rid of them by letting the child synchronously wait for the task wo=
rk
> > executing in the parent's context. This way, any errors that happen in =
the
> > task work can be plumbed back into the syscall return value in the chil=
d.
> >
> > Note that this requires using TWA_SIGNAL instead of TWA_RESUME, so the
> > parent might observe some spurious -EGAIN syscall returns or such; but =
the
> > parent likely anyway has to be ready to deal with the side effects of
> > receiving signals (since it'll probably get SIGCHLD when the child dies=
),
> > so that probably isn't an issue.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > This is a quickly hacked up demo of the approach I proposed at
> > <https://lore.kernel.org/all/CAG48ez2bnvuX8i-D=3D5DxmfzEOKTWAf-DkgQq6aN=
C4WzSGoEGHg@mail.gmail.com/>
> > to get rid of the cred_transfer stuff. Diffstat looks like this:
> >
> >  include/linux/cred.h          |   1 -
> >  include/linux/lsm_hook_defs.h |   3 ---
> >  include/linux/security.h      |  12 ------------
> >  kernel/cred.c                 |  23 -----------------------
> >  security/apparmor/lsm.c       |  19 -------------------
> >  security/keys/internal.h      |   8 ++++++++
> >  security/keys/keyctl.c        | 100 ++++++++++++++++++++++++++--------=
------------------------------------------------------------------
> >  security/keys/process_keys.c  |  86 ++++++++++++++++++++++++++++++++++=
++++++++++++----------------------------------------
> >  security/landlock/cred.c      |  11 ++---------
> >  security/security.c           |  35 ----------------------------------=
-
> >  security/selinux/hooks.c      |  12 ------------
> >  security/smack/smack_lsm.c    |  32 --------------------------------
> >  12 files changed, 82 insertions(+), 260 deletions(-)
> >
> > What do you think? Synchronously waiting for task work is a bit ugly,
> > but at least this condenses the uglyness in the keys subsystem instead
> > of making the rest of the security subsystem deal with this stuff.
>
> Why does synchronously waiting is ugly? Not sarcasm, I genuineily
> interested of breaking that down in smaller pieces.
>
> E.g. what disadvantages would be there from your point of view?
>
> Only trying to form a common picture, that's all.

Two things:

1. It means we have to send a pseudo-signal to the parent, to get the
parent to bail out into signal handling context, which can lead to
extra spurious -EGAIN in the parent. I think this is probably fine
since _most_ parent processes will already expect to handle SIGCHLD
signals...

2. If the parent is blocked on some other killable wait, we won't be
able to make progress - so in particular, if the parent was using a
killable wait to wait for the child to leave its syscall, userspace
=E1=BA=81ould deadlock (in a way that could be resolved by SIGKILLing one o=
f
the processes). Actually, I think that might happen if the parent uses
ptrace() with sufficiently bad timing? We could avoid the issue by
doing an interruptible wait instead of a killable one, but then that
might confuse userspace callers of the keyctl() if they get an
-EINTR...
I guess the way to do this cleanly is to use an interruptible wait and
return -ERESTARTNOINTR if it gets interrupted?

> > Another approach to simplify things further would be to try to move
> > the session keyring out of the creds entirely and just let the child
> > update it directly with appropriate locking, but I don't know enough
> > about the keys subsystem to know if that would maybe break stuff
> > that relies on override_creds() also overriding the keyrings, or
> > something like that.
> > ---
> >  include/linux/cred.h          |   1 -
> >  include/linux/lsm_hook_defs.h |   3 --
> >  include/linux/security.h      |  12 -----
> >  kernel/cred.c                 |  23 ----------
> >  security/apparmor/lsm.c       |  19 --------
> >  security/keys/internal.h      |   8 ++++
> >  security/keys/keyctl.c        | 100 +++++++++++-----------------------=
--------
> >  security/keys/process_keys.c  |  86 +++++++++++++++++++---------------=
--
> >  security/landlock/cred.c      |  11 +----
> >  security/security.c           |  35 ---------------
> >  security/selinux/hooks.c      |  12 -----
> >  security/smack/smack_lsm.c    |  32 --------------
> >  12 files changed, 82 insertions(+), 260 deletions(-)
>
> Given the large patch size:
>
> 1. If it is impossible to split some meaningful patches, i.e. patches
>    that transform kernel tree from working state to another, I can
>    cope with this.
> 2. Even for small chunks that can be split into their own logical
>    pieces: please do that. Helps to review the main gist later on.

There are basically two parts to this, it could be split up nicely into the=
se:

1. refactor code in security/keys/
2. rip out all the code that is now unused (as you can see in the
diffstat, basically everything outside security/keys/ is purely
removals)

[...]
> Not going through everything but can we e.g. make a separe SMACK patch
> prepending?

I wouldn't want to split it up further: As long as the cred_transfer
mechanism and LSM hook still exist, all the LSMs that currently have
implementations of it should also still implement it.

But I think if patch 2/2 is just ripping out unused infrastructure
across the tree, that should be sufficiently reviewable? (Or we could
split it up into ripping out one individual helper per patch, but IDK,
that doesn't seem to me like it adds much reviewability.)

