Return-Path: <linux-kernel+bounces-272591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B696E945E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618B21F211BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9861E4856;
	Fri,  2 Aug 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1BTIsiQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4591E3CDC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604405; cv=none; b=mfht6qqA4qARbE3VC0oPk5ARSG+MWaP1ieDq3m/6hJ9w2z2CUK6JkK1EglR+BvXIUZdgkEOdOlNUJTsIIRfpTVA4KTvzjGYhe36J/lQ0eH7JqTyD/qiXSY6inNcZE5llV0wr+HyBFCn62b5eW6C2Je+6eLJsfMW2Ahra89mrbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604405; c=relaxed/simple;
	bh=BwTpX4R7zkKwhLkBtH/hZIhBc3WcCtukHgkLY/3CyXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9xNxc4c9qh/I8xykDDUrBRYozvMgauc4ENF2Uj3tGQbIZNJwEyHmh5XjSROKCF+KCoC3umnov/Zqiuj9F8w/9uENAZxLdq9nKFTG1LgZiz1faStbRFzzcvM3jzuY0uItpI5gsyPkMdGiDMj6dMscd8I4rrGQnar6TzkpS+qVNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1BTIsiQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso59055a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722604402; x=1723209202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1lsq1MbHixArH6n0xuStRjT/KO7g8bnFRsAbnZpGsc=;
        b=S1BTIsiQu2+g9uCop3KOzEhU9ET8TDRf7tdg6HXU+ydnzfUnhMNWpRlYCFRp+h+gHJ
         VGJ1Fk3jhweevDoKmMWqzQ3fpehZwyClv07VnNaBH51ffWZdbhjf9KniIgeyWILBnXO2
         HZ0JZ96BSTID90wmaroPV/mujRMZpc+UnEMaCi5yHoN4Icnln7CcOdCHCwZ62QGoGdlo
         yAR5+qxn+NSNDe7r7LYG5RwRYVxOJC6pk6nsLk/PTj3PDfCN+sIt/ndyqJ86fafgQgry
         lSPmXGZV/jIy9G6lgMDpynJ9Jl6hMIJf1y3QtTUlncTNb4WN9KLAzm51yMDqeHw5Aro5
         9umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604402; x=1723209202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1lsq1MbHixArH6n0xuStRjT/KO7g8bnFRsAbnZpGsc=;
        b=W32829neBr7TbAQRsZe4Q+KaALX5RosTwjr+7Cd+/Fl0uX64al2kvNB+bCnu/iB4i6
         znMQH2zckN+HJlMUKNJK6BxLk1L/lwSzsaTqpBBYHRBgzSGihj3rJwudUHyfbTawhHR/
         2MPvbR6snad1gF5ITff/UFMx4E35FSiUwFWE+zExOzGokKHizy6bUqI3pHADn8OMJxVk
         4Db4amns90AMnA79aWOGk+B34jEgKLh21nnEJlhlwmpmfuv5A4YsnTJrf+FaNUtIm7Gr
         9/SDpT0X3rhbwVCbt5Fq+LTUAdqnIjpVOICVS8ARfu2XbThv7LT16bzEhLNBB8c9ppjg
         WwFw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjdR6B0R74nOJ4qAJE2/DDm/0o7F9T6CQtu93iIlr47oO3NEGagQxAtTjjkzLgAetKEKuq/nqCbWY0dW4Ljsim+UVEvDwhC9+mPR9
X-Gm-Message-State: AOJu0YwD8v6JJivyWtXjCGlDV7xiLl6Rmqw5G/gN0r6+RKkU4h0LiBJ/
	jrwYWdXPgOMEKzExmrHenwNWsh4Yl6pBldZUO6A/5jZV6dErmRrWbrBcaSPhMUFEz8yvKTxrb7X
	SI/qMOaqp4kw62BEUw5ZSEbuxYAIIUiD6B9aH
X-Google-Smtp-Source: AGHT+IFYTrXmYI0k6b24zjW3CqG747URvtVJaY0p2tHnlsWe90ww1rp4IvxsCnMquQC7lV9N8ZofPfYaGnlnTfzCud4=
X-Received: by 2002:a05:6402:268d:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b870f72be0mr116158a12.7.1722604401009; Fri, 02 Aug 2024
 06:13:21 -0700 (PDT)
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
 <CAG48ez2bnvuX8i-D=5DxmfzEOKTWAf-DkgQq6aNC4WzSGoEGHg@mail.gmail.com>
 <CAHC9VhTk4X61K72FubR8ahNeGyzWKkF=vJZD+k-8+xO7RwZpgg@mail.gmail.com> <CAG48ez0RVMpMY2vfWqrCDYjFj7zZx5HCP+h-EaeNW1-0_EU0mg@mail.gmail.com>
In-Reply-To: <CAG48ez0RVMpMY2vfWqrCDYjFj7zZx5HCP+h-EaeNW1-0_EU0mg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 15:12:43 +0200
Message-ID: <CAG48ez2TVGzqS4RPSLJpLEsuqEPsxKfy+CoamGBD-1L8sWSAQQ@mail.gmail.com>
Subject: Re: [PATCH v1] keys: Restrict KEYCTL_SESSION_TO_PARENT according to ptrace_may_access()
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	James Morris <jmorris@namei.org>, Kees Cook <kees@kernel.org>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> On Wed, Jul 31, 2024 at 11:27=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Jul 31, 2024 at 4:54=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > > FYI: Those checks, including the hook that formerly existed there, ar=
e
> > > (somewhat necessarily) racy wrt concurrent security context changes o=
f
> > > the parent because they come before asynchronous work is posted to th=
e
> > > parent to do the keyring update.
> >
> > I was wondering about something similar while looking at
> > keyctl_session_to_parent(), aren't all of the parent's cred checks
> > here racy?
>
> Yeah...
>
> > > In theory we could make them synchronous if we have the child wait fo=
r
> > > the parent to enter task work... actually, with that we could probabl=
y
> > > get rid of the whole cred_transfer hack and have the parent do
> > > prepare_creds() and commit_creds() normally, and propagate any errors
> > > back to the child, as long as we don't create any deadlocks with
> > > this...
> >
> > Assuming that no problems are caused by waiting on the parent, this
> > might be the best approach.  Should we also move, or duplicate, the
> > cred checks into the parent's context to avoid any races?
>
> Yeah, I think that'd probably be a reasonable way to do it. Post task
> work to the parent, wait for the task work to finish (with an
> interruptible sleep that cancels the work item on EINTR), and then do
> the checks and stuff in the parent. I guess whether we should also do
> racy checks in the child before that depends on whether we're worried
> about a child without the necessary permissions being able to cause
> spurious syscall restarts in the parent...

I hacked up an RFC patch for this approach:
https://lore.kernel.org/r/20240802-remove-cred-transfer-v1-1-b3fef1ef2ade@g=
oogle.com

