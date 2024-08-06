Return-Path: <linux-kernel+bounces-277053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E852E949BA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FA8B27340
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BE17557C;
	Tue,  6 Aug 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/m35OfZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9A166315
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984987; cv=none; b=NGORQCsqFRfahL0/hAiA9yPWx8VcW3g8ZfheEhRA0uWaQO3kBHB67vc09ZBK7gQmRTD+5OjztqTdXhIzv8U5MLaT1rZ3ykdoq+I2rQLmH6HssBYETxgaH1Dhe8PPdzVBfQVASzks5qWK+NFRq7QxlugFW4KCZedGxYz7DrBe8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984987; c=relaxed/simple;
	bh=aNMyv5u4iRth1dAkJiP4aTC7V9ydb+rlkqz1X9ydnK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDVsOiED8th9j6Lk7R7OBwAfclFUfrRmzvCuUrp0ncNey21dbRHp7qpUNvbsGuAmf1j2hxf4AA3HTjihYyDt+8CBgJ8hrYYN30i9SMrynCx30u+cUSIsS0PDDe/9RBiHTqHvmvZEyYLbe5ZENLM+lAsaXyK6MF+PKsSq9TC06Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/m35OfZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so21079a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722984984; x=1723589784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+9ez+DbuNqwjVco5Cgno4xixSp6vmg4G3LS18N1p4E=;
        b=V/m35OfZsuNpmq8PIr0kQSKYm34xKKfsEi443ZRE4HoGr6vAHSX9l3qrZW6eG75P8T
         x+hZd4pVYXRtEo0oRKdbC8ESWKfIPnr/ASf5NElUcNl4JjVfd3SqdzZk6U74iXwKnYA+
         OxM1Hs12zxQyRdMH39BIrKOOjyk5QvgUI73DhECCtrHvNMIblDMoQBRsFKyO2EE/Owvt
         hQJhUhZpSEq50cMugjxLTdsno0dvT67XuD4rb9+ItQWTgTxPsDl8+sYxXbV/uBoP273k
         1spBHVDtxVBURlCbWgVm+1KcKbIU/QqXmn6uL0ZrgQ9/SmWqLYHXE7g37gd+WOZrTle2
         u+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984984; x=1723589784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+9ez+DbuNqwjVco5Cgno4xixSp6vmg4G3LS18N1p4E=;
        b=f2jv7n0uET8oywJEq4MmFSk1WpvDAH7qMbUTBZ8smzNDg+5aGO9jk9EJdTt+Byl3NW
         t817K0PfxGCi6jiU41oqiD1V9zreOAoCeR8ILqSXHes9vWos1X2Y0aicTzAQeI1u/UTJ
         7dFbm6o7GmpSnB7ak6cjS5clPTD1KiDBp946TOaAR1+O3AayeWGyQP1IoCUec7RlX1F0
         n9yg9pftiGguH+gIOURMzytuKuNzyJx5NEEPUrhPKCM7FABJ1xcLxp/Am/YH6YCHRRay
         8NpnJ1bDqldNVQG/RG1szAZEx+gvo/Rg0u2qxR+bjWSA07fhWRkPRdUG8ZH8KzBdjCVa
         kriw==
X-Forwarded-Encrypted: i=1; AJvYcCW1DF/5iVHSLKN78oyYPNDCYBdhhKFXrYb2rXKhZpgx9tzj4Bc5C3EBqLpNWCXPhhH9s0M4YZF3YvL7ed1HFYxWj5wgDRJ9CvwCI8F0
X-Gm-Message-State: AOJu0YxOlli0ZDahjp6qXu3qPid21xLGPIBe0E0YPr0+tAVfFQT8rkrT
	QiFM3dnpwJsmO1aqrGsej0PFwMFrkJSZOjzKYe1eWvIjTTriS8y3OXwUBPRmv29oQ/THiz5vjje
	uEBbO8iyoyElgrcd/pMBYto35soSwZQkMNALi
X-Google-Smtp-Source: AGHT+IHdmoaV9xaEO4CcjSrPjVW5K+oaFl6xpiEgDz/ZpLfq51hclYinP1LbziYkKWQvucGfpgIXsD28vskGEw7k1zU=
X-Received: by 2002:a05:6402:51cb:b0:5a0:d4ce:59a6 with SMTP id
 4fb4d7f45d1cf-5bba2837e46mr75708a12.2.1722984982752; Tue, 06 Aug 2024
 15:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722966592.git.fahimitahera@gmail.com> <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com> <ZrKc4i1PhdMwA77h@tahera-OptiPlex-5000>
In-Reply-To: <ZrKc4i1PhdMwA77h@tahera-OptiPlex-5000>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Aug 2024 00:55:46 +0200
Message-ID: <CAG48ez2OmOdMo7TCn4M8tSPSdXVwMDty6fMsHc9Q+NFQ-sfBUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Landlock: Add signal control
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Aug 7, 2024 at 12:00=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.c=
om> wrote:
> On Tue, Aug 06, 2024 at 08:56:15PM +0200, Jann Horn wrote:
> > On Tue, Aug 6, 2024 at 8:11=E2=80=AFPM Tahera Fahimi <fahimitahera@gmai=
l.com> wrote:
> > > +       if (is_scoped)
> > > +               return 0;
> > > +
> > > +       return -EPERM;
> > > +}
> > > +
> > > +static int hook_file_send_sigiotask(struct task_struct *tsk,
> > > +                                   struct fown_struct *fown, int sig=
num)
> > > +{
> > > +       bool is_scoped;
> > > +       const struct landlock_ruleset *dom, *target_dom;
> > > +       struct task_struct *result =3D get_pid_task(fown->pid, fown->=
pid_type);
> >
> > I'm not an expert on how the fowner stuff works, but I think this will
> > probably give you "result =3D NULL" if the file owner PID has already
> > exited, and then the following landlock_get_task_domain() would
> > probably crash? But I'm not entirely sure about how this works.
> I considered since the file structure can always be obtained, then the
> file owner PID always exist.

I think the file owner "struct pid" always exists here; but I think
the PID does not necessarily point to a task_struct.

I think you can have a scenario where userspace does something like this:

int fd =3D <open some file descriptor somehow>;
fcntl(fd, F_SETOWN, <PID of some other process>);
pid_t child_pid =3D fork();
if (child_pid =3D=3D 0) {
  /* this executes in the child process */
  sleep(5);
  <do something on the fd that triggers send_sigio() or send_sigurg()>
  sleep(5);
  exit(0);
}
/* this continues executing in the parent process */
exit(0);

At the fcntl(fd, F_SETOWN, ...) call, a reference-counted reference to
the "struct pid" of the parent process will be stored in the file
(this happens in "f_modown", which increments the reference count of
the "struct pid" using "get_pid(...)"). But when the parent process
exits, the pointer from the parent's "struct pid" to the parent's
"task_struct" is removed, and the "task_struct" will eventually be
deleted from memory.

So when, at a later time, something triggers send_sigio() or
send_sigurg() and enters this LSM hook, I think
"get_pid_task(fown->pid, fown->pid_type)" can return NULL.

> I can check if we can use the credentials
> stored in struct file instead.

(sort of relevant: The manpage
https://man7.org/linux/man-pages/man2/fcntl.2.html says "Note: The
F_SETOWN operation records the caller's credentials at the time of the
fcntl() call, and it is these saved credentials that are used for the
permission checks.")

You mean the credentials in the "f_cred" member of "struct file", right? If=
 so:

I don't think Landlock can use the existing credentials stored in
file->f_cred for this. Consider the following scenario:

1. A process (with no landlock restrictions so far) opens a file. At
this point, the caller's credentials (which indicate no landlock
restrictions) are recorded in file->f_cred.
2. The process installs a landlock filter that restricts the ability
to send signals. (This changes the credentials pointer of the process
to a new set of credentials that points to the new landlock domain.)
3. Malicious code starts executing in the sandboxed process.
4. The malicious code uses F_SETOWN on the already-open file.
5. Something causes sending of a signal via send_sigio() or
send_sigurg() on this file.

In this scenario, if the LSM hook used the landlock restrictions
attached to file->f_cred, it would think the operation is not filtered
by any landlock domain.

> > I think the intended way to use this hook would be to instead use the
> > "file_set_fowner" hook to record the owning domain (though the setup
> > for that is going to be kind of a pain...), see the Smack and SELinux
> > definitions of that hook. Or alternatively maybe it would be even
> > nicer to change the fown_struct to record a cred* instead of a uid and
> > euid and then use the domain from those credentials for this hook...
> > I'm not sure which of those would be easier.
> Because Landlock does not use any security blob for this purpose, I am
> not sure how to record the owner's doamin.

I think landlock already has a landlock_file_security blob attached to
"struct file" that you could use to store an extra landlock domain
pointer for this, kinda like the "fown_sid" in SELinux? But doing this
for landlock would be a little more annoying because you'd have to
store a reference-counted pointer to the landlock domain in the
landlock_file_security blob, so you'd have to make sure to also
decrement the reference count when the file is freed (with the
file_free_security hook), and you'd have to use locking (or atomic
operations) to make sure that two concurrent file_set_fowner calls
don't race in a dangerous way...

So I think it's fairly straightforward, but it would be kinda ugly.

> The alternative way looks nice.

Yeah, I agree that it looks nicer. (If you decide to implement it by
refactoring the fown_struct, it would be a good idea to make that a
separate patch in your patch series - partly because that way, the
maintainers of that fs/fcntl.c code can review just the refactoring,
and partly just because splitting logical changes into separate
patches makes it easier to review the individual patches.)

> > > +       /* rcu is already locked! */
> > > +       dom =3D landlock_get_task_domain(result);
> > > +       target_dom =3D landlock_get_task_domain(tsk);
> > > +       is_scoped =3D domain_IPC_scope(dom, target_dom, LANDLOCK_SCOP=
ED_SIGNAL);
> > > +       put_task_struct(result);
> > > +       if (is_scoped)
> > > +               return 0;
> > > +       return -EPERM;
> > > +}

