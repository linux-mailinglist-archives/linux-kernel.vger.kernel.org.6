Return-Path: <linux-kernel+bounces-269845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECEA94376D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FA11F22EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B43D168C26;
	Wed, 31 Jul 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWMGofBp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A16087B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459254; cv=none; b=stPxKMCfTUXh4kxPPR6z7/MImuVCFwfk7s6Giq3SvdrFmP9OrWB1vl7hYKYa0oKCrA/Y6Dch6frpdE9Wkc5NTPoIwP1j0U/FdvmcxJty4gu840CZxpiXozGGusTIINPVBbiGnfwZWZYUzXJFaNBS5qx2zVWFWn1xHAnwk1W7PrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459254; c=relaxed/simple;
	bh=5ygHEV9Xf2MWcBnN1GGdI4uec+twOGAgqOtUspJE+sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuZQ6+oksTSjQURqGM12i3foN6nmLZGQwRYSGByTBkKYRfXKcEcUFKdxzxGriX/dlS1kH36cNm3Fdg2Y0ktVkpKgFEpwfQrP25nGGzPSe9KlR9t1NXvudKcdvMIDDgTfVFJ1vXcxmEXZeH0qT9mVwwQGvwM3W8ar9BUEYFHCkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YWMGofBp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso28622a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722459251; x=1723064051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+gszA19U6BJ1g716Sog5LgzCr1u8Y0SO/35mfMYtTU=;
        b=YWMGofBpQ3TICTsEByR8khrkEZ8i2cY2g+zKCDiuVox++JsO/9HbzEa2SKUGtfDH/6
         daZd1cDxCuYZBd5B9nqMrEphHPiE/lv5EudXzNOPlZFGqwXmVP1JgKvRoOvdIvBKtIWL
         oVIIxN0Jve4WVjv7GRH2QWAdJ+Pxb8WEuYho0R2bNOCWFeBZJHotb2Y/F3x7MDa+fio0
         lv4/+Qrf0NA4V7szs6s7+sWmhiNVBDPmxm13TtC+XYSzken6F/lvORmRxsIHi6oOuj6H
         qwDkrwEbatcMjGVUG7XzE1iI0mRA6qBkhZkf5ajkPry+DS9OwmrVfkpecJxXYnp8f1bu
         alXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459251; x=1723064051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gszA19U6BJ1g716Sog5LgzCr1u8Y0SO/35mfMYtTU=;
        b=IAqKqE6+bmHFpcWVSL0zIuJXPcY4UpmOkReAKX95bOApTVJ9GgOFzxy9lpots4zLVT
         koTUFgpNhRk7Ul7EsefRY16e84JI21+52NlPy16oBwTPobHHQeU3q2Ah9wGQLUzYyi6C
         ChV9obxW7zwjlePA0dZJ2pJ7gUoPIBogdUWtdmpHkf4l+9HJIO2RjnMag7EfAym/FQ6M
         J4jtie8Fb08PIjpey3KqE1HHTQUjUUo+094AXkjqSf4kd8FssHyClprNLdOXqO5ANgM6
         4gR23ieR3UtVQ6xdUGKyzDQe+lEAlp5qxuqiYYNzS0fqgnrjoo3x+mJHGdDJf4kkb5Ha
         2l/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsTnB6BUFVD23AXpqnrsol2W1ugexJ7bKwrtOncnCk6I/EnGQUBOtd3vwiNqRU6ikJi4yO7O3WcDn0GsduBtsBNfLTcc7ak/pEmePF
X-Gm-Message-State: AOJu0YyWhbCh+m0vY+ZL3QK2fOT9BB79cS6vrRmCgAcPoiofh5lRrsku
	DRcUB9V6NRMqpw/nRjXAn/8pf1p3zIPxNwk8De/KwbpOreWHKb4nNpXVuPP9DCT2deynaMuxnkc
	hLgJnqySGdxVg2it/zBeX+A7tAMWMOt0U27wW
X-Google-Smtp-Source: AGHT+IFFyRxG08zaQKhJ3fh/dwim/QR46tcLanqoEgsLZgkh0jNTAu3TdJAgV3n3cl6ajWcjRFwSLUDp01nZn/LDa4g=
X-Received: by 2002:a05:6402:430b:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5b5b534235cmr282372a12.5.1722459250663; Wed, 31 Jul 2024
 13:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729125846.1043211-1-mic@digikod.net> <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
 <20240729.cho6saegoHei@digikod.net> <CAG48ez1=xbGd8az4+iNJ_v1z4McMN8dsvWff-PH=ozLYnbzPqg@mail.gmail.com>
 <20240729.rayi3Chi9aef@digikod.net> <CAG48ez2HdeKXwwiCck9cvcoS1ZhbGD8Qs2DzV7F6W_6=fSgK5Q@mail.gmail.com>
 <20240729.roSo6soogho8@digikod.net> <CAHC9VhRmZOMLwY4AvV+96WU3jyqMt6jX5sRKAos75OjWDo-NvA@mail.gmail.com>
In-Reply-To: <CAHC9VhRmZOMLwY4AvV+96WU3jyqMt6jX5sRKAos75OjWDo-NvA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 31 Jul 2024 22:53:34 +0200
Message-ID: <CAG48ez2bnvuX8i-D=5DxmfzEOKTWAf-DkgQq6aNC4WzSGoEGHg@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Mon, Jul 29, 2024 at 11:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > On Mon, Jul 29, 2024 at 05:06:10PM +0200, Jann Horn wrote:
> > > On Mon, Jul 29, 2024 at 5:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > > On Mon, Jul 29, 2024 at 04:21:01PM +0200, Jann Horn wrote:
> > > > > On Mon, Jul 29, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn =
<mic@digikod.net> wrote:
> > > > > > On Mon, Jul 29, 2024 at 03:49:29PM +0200, Jann Horn wrote:
> > > > > > > On Mon, Jul 29, 2024 at 2:59=E2=80=AFPM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > > > A process can modify its parent's credentials with
> > > > > > > > KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the s=
ame.  This
> > > > > > > > doesn't take into account all possible access controls.
> > > > > > > >
> > > > > > > > Enforce the same access checks as for impersonating a proce=
ss.
> > > > > > > >
> > > > > > > > The current credentials checks are untouch because they che=
ck against
> > > > > > > > EUID and EGID, whereas ptrace_may_access() checks against U=
ID and GID.
> > > > > > >
> > > > > > > FWIW, my understanding is that the intended usecase of
> > > > > > > KEYCTL_SESSION_TO_PARENT is that command-line tools (like "ke=
yctl
> > > > > > > new_session" and "e4crypt new_session") want to be able to ch=
ange the
> > > > > > > keyring of the parent process that spawned them (which I thin=
k is
> > > > > > > usually a shell?); and Yama LSM, which I think is fairly wide=
ly used
> > > > > > > at this point, by default prevents a child process from using
> > > > > > > PTRACE_MODE_ATTACH on its parent.
> > > > > >
> > > > > > About Yama, the patched keyctl_session_to_parent() function alr=
eady
> > > > > > check if the current's and the parent's credentials are the sam=
e before
> > > > > > this new ptrace_may_access() check.
> > > > >
> > > > > prepare_exec_creds() in execve() always creates new credentials w=
hich
> > > > > are stored in bprm->cred and then later committed in begin_new_ex=
ec().
> > > > > Also, fork() always copies the credentials in copy_creds().
> > > > > So the "mycred =3D=3D pcred" condition in keyctl_session_to_paren=
t()
> > > > > basically never applies, I think.
> > > > > Also: When that condition is true, the whole operation is a no-op=
,
> > > > > since if the credentials are the same, then the session keyring t=
hat
> > > > > the credentials point to must also be the same.
> > > >
> > > > Correct, it's not a content comparison.  We could compare the
> > > > credential's data for this specific KEYCTL_SESSION_TO_PARENT call, =
I
> > > > guess this should not be performance sensitive.
> > >
> > > Yeah, though I guess keyctl_session_to_parent() is already kind of
> > > doing that for the UID information; and for LSMs that would mean
> > > adding an extra LSM hook?
> >
> > I'm wondering why security_key_session_to_parent() was never used: see
> > commit 3011a344cdcd ("security: remove dead hook key_session_to_parent"=
)
>
> While I was looking at this in another off-list thread I think I came
> around to the same conclusion: I think we want the
> security_key_session_to_parent() hook back, and while I'm wearing my
> SELinux hat, I think we want a SELinux implementation.

FYI: Those checks, including the hook that formerly existed there, are
(somewhat necessarily) racy wrt concurrent security context changes of
the parent because they come before asynchronous work is posted to the
parent to do the keyring update.

In theory we could make them synchronous if we have the child wait for
the parent to enter task work... actually, with that we could probably
get rid of the whole cred_transfer hack and have the parent do
prepare_creds() and commit_creds() normally, and propagate any errors
back to the child, as long as we don't create any deadlocks with
this...

> Micka=C3=ABl, is this something you want to work on?

