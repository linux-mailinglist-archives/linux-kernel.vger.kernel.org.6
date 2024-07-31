Return-Path: <linux-kernel+bounces-269815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8F94371D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770932837A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C427161B43;
	Wed, 31 Jul 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dy+5Q9Mu"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C5148FF3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457769; cv=none; b=OqZWLjRoMtjqyziy5Ij1s93Za+MyeIa5k4h2ZvrYdmyS7/JAAlqXpb1LzQHMPJHHg2mDeehvLPkIuYwF1SsxW6gDsY0eAOTnH9UIUpc7iNwE5/UayZ82GQ4v7kBsXaY6lNecoL8fgwRyETdTI/C3hkvXx/Ms7deeg/dqqIo9sNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457769; c=relaxed/simple;
	bh=55Y2FiMTrimrMXILYu++IX6+eHQpPUGeTFOVYaQNTmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgkH9N4BQIf9WtARy1WKKgUudYNXMr4lhjWhqSL5ow0J1IPg+qpwtUAdSNnrDc72KoZFR+Hj+I0gtF4iyXB443zUBCBqlIEQpPooUziQzmzvVkYEH4DqHLajQ4FSvxErTjydsyolskPRcd7nZ7E3phA9wVC3qyRjYNAml6WzhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dy+5Q9Mu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e087264e297so5134832276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722457767; x=1723062567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSX1c8Ru/j8yxo/auh47ofyUjGotjeSFELYrAnjtnVo=;
        b=Dy+5Q9Mux2ZsOfD1GqlkaSzT/PqVOBeeKfhR1reRfMuPCSW2uUIcTgHX+gfKkZfeyS
         p68xfw5+GU61gSQw9LlgVjmsFnNfy/yzq8rjr8XF5N4sK9GLgJREhv3OmteOn29PSwnZ
         WUDOXtPFwvhk6RKtaqMJtW0MMDYvO3ROxg4YhBqxu7QqhGgDPHPZCrsiE3x3nvlOH3SB
         UEZ7w6P63cTy3fmuBZgbROAZA5EJdLH8lN2NAOD2PD6R50AzxyihNh1Bm53nuafY8aNr
         7uLSVR7FKuPpvhGZALj8AD11rLZm/hpCzUAAV4ELQy+cC1Lpj8zNWvrZjI9c+gRTXzdB
         PYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722457767; x=1723062567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSX1c8Ru/j8yxo/auh47ofyUjGotjeSFELYrAnjtnVo=;
        b=sZ5NJEnOycWlHp+AYRY/ysWSipIkBFaPJT+Rz5y1vgaciY/gEd+C0gkT/iwyQVH7P6
         w0gVAcDoqxWTs9DUvjJOvg9mjgaC+binRR5Jn9sHdsV7GbJPwwM8pVr4UrKJyU2r0KR+
         hV82Okx227jYRBbiP3XcqRDEHpkrV63r13nQs/xNNgFyK/f8k4VnkgumJdnUw5IpPt+f
         YHhSa+x7MJA3izTLJna2/gQgK+xw2Kg9PuBG/LVDZnH4vCPz72rW3kANo/pGoxXcQ6Bj
         NeKvh631stm4NO9qxtWdZ1f1xRI0NqLikbkPEpv2rSHpFW9glx9+hf1hZsa3JF6aBOdE
         AoHg==
X-Forwarded-Encrypted: i=1; AJvYcCXuTi7BKhMMlMersmZZLjVp4UsiXRAqdLksBQ2DuVo2CxRjoA6g2uF0gEvIMfuT8Cy1HuZITalzF09y6BtA6vITplCH9MtmfyQvx1wj
X-Gm-Message-State: AOJu0Yzr3M14ghtUec0mS0fh/6a//kH/0ncrCzDLX3aAKSnJsF9PY3vu
	sVxLCjVUeXfZJ9z/vg8YvA9n5gJFnYMsQMPG3k7vMDP+PYJ9DByv1v3rJCly0prr0a/FwBBfVtl
	5tidWSDYveNReeC3o3+hngkmGvTYvOWCDsg0T
X-Google-Smtp-Source: AGHT+IFx10AYMBAygpAsRMReCo80r71LTCsmoGAG8m/NF9tKd5CFmX1RfasNmH6AK1pKP7GjMtINChhEtHlz600Jia4=
X-Received: by 2002:a05:6902:210f:b0:e08:655c:af14 with SMTP id
 3f1490d57ef6-e0bcd3fdbb9mr165982276.36.1722457767336; Wed, 31 Jul 2024
 13:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729125846.1043211-1-mic@digikod.net> <CAG48ez3DzxGMWN9GDhSqpHrDJnZDg2k=VEMD_DFiET5yDr07rw@mail.gmail.com>
 <20240729.cho6saegoHei@digikod.net> <CAG48ez1=xbGd8az4+iNJ_v1z4McMN8dsvWff-PH=ozLYnbzPqg@mail.gmail.com>
 <20240729.rayi3Chi9aef@digikod.net> <CAG48ez2HdeKXwwiCck9cvcoS1ZhbGD8Qs2DzV7F6W_6=fSgK5Q@mail.gmail.com>
 <20240729.roSo6soogho8@digikod.net>
In-Reply-To: <20240729.roSo6soogho8@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 16:29:16 -0400
Message-ID: <CAHC9VhRmZOMLwY4AvV+96WU3jyqMt6jX5sRKAos75OjWDo-NvA@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Mon, Jul 29, 2024 at 05:06:10PM +0200, Jann Horn wrote:
> > On Mon, Jul 29, 2024 at 5:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Mon, Jul 29, 2024 at 04:21:01PM +0200, Jann Horn wrote:
> > > > On Mon, Jul 29, 2024 at 4:09=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > On Mon, Jul 29, 2024 at 03:49:29PM +0200, Jann Horn wrote:
> > > > > > On Mon, Jul 29, 2024 at 2:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > > A process can modify its parent's credentials with
> > > > > > > KEYCTL_SESSION_TO_PARENT when their EUID and EGID are the sam=
e.  This
> > > > > > > doesn't take into account all possible access controls.
> > > > > > >
> > > > > > > Enforce the same access checks as for impersonating a process=
.
> > > > > > >
> > > > > > > The current credentials checks are untouch because they check=
 against
> > > > > > > EUID and EGID, whereas ptrace_may_access() checks against UID=
 and GID.
> > > > > >
> > > > > > FWIW, my understanding is that the intended usecase of
> > > > > > KEYCTL_SESSION_TO_PARENT is that command-line tools (like "keyc=
tl
> > > > > > new_session" and "e4crypt new_session") want to be able to chan=
ge the
> > > > > > keyring of the parent process that spawned them (which I think =
is
> > > > > > usually a shell?); and Yama LSM, which I think is fairly widely=
 used
> > > > > > at this point, by default prevents a child process from using
> > > > > > PTRACE_MODE_ATTACH on its parent.
> > > > >
> > > > > About Yama, the patched keyctl_session_to_parent() function alrea=
dy
> > > > > check if the current's and the parent's credentials are the same =
before
> > > > > this new ptrace_may_access() check.
> > > >
> > > > prepare_exec_creds() in execve() always creates new credentials whi=
ch
> > > > are stored in bprm->cred and then later committed in begin_new_exec=
().
> > > > Also, fork() always copies the credentials in copy_creds().
> > > > So the "mycred =3D=3D pcred" condition in keyctl_session_to_parent(=
)
> > > > basically never applies, I think.
> > > > Also: When that condition is true, the whole operation is a no-op,
> > > > since if the credentials are the same, then the session keyring tha=
t
> > > > the credentials point to must also be the same.
> > >
> > > Correct, it's not a content comparison.  We could compare the
> > > credential's data for this specific KEYCTL_SESSION_TO_PARENT call, I
> > > guess this should not be performance sensitive.
> >
> > Yeah, though I guess keyctl_session_to_parent() is already kind of
> > doing that for the UID information; and for LSMs that would mean
> > adding an extra LSM hook?
>
> I'm wondering why security_key_session_to_parent() was never used: see
> commit 3011a344cdcd ("security: remove dead hook key_session_to_parent")

While I was looking at this in another off-list thread I think I came
around to the same conclusion: I think we want the
security_key_session_to_parent() hook back, and while I'm wearing my
SELinux hat, I think we want a SELinux implementation.

Micka=C3=ABl, is this something you want to work on?

--=20
paul-moore.com

