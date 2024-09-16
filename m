Return-Path: <linux-kernel+bounces-330523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092A979FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE674B21016
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8206154C19;
	Mon, 16 Sep 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZF/CBSDL"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54FC14F114
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483584; cv=none; b=PKWBPtINK1awoQ+XJAbKiPXGs59Jvtw6D0t9dkrci3kXql5ATA8ttJerb23WDc1Tkl4oiAF3pDLtF7fCeEWuwJOS7JwwiDsC+1EkebsBmtjsispu0l1YOTXxHZ+R4SRhOMm7HCEwzBICL6QVyQ66zp1VVwv+J5tzDeDrFX0tYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483584; c=relaxed/simple;
	bh=mV9du04VKGKk1nPwWEovpDjsnvZZeLOYjvudwBnQ87c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPjpuWpbLxbsf2qwWLL2WnOZ442L7zjAr2FU+ZXSnDWpIkGQSm+68wZR4oMTIlbuyZMQ+Yf404ynpj6qK+LF/hppElrUh9yuIfDtn2HYvo4bcDF1ULKaiL6odB9GQkOhDTlIdgW/qkwkeiz4UKWH9pc6jTLb+wFOtX8BL6/4lTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZF/CBSDL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so2449500276.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726483582; x=1727088382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOot1WAmO0n8LqJvNiku2kLrm8KQvY7N+dDNwBSEg74=;
        b=ZF/CBSDLw30DFYzkwvHzm2IktN8jmz0b7vNZq0DWTGZAVFfcfFcP/wIXl0Tvj+ujnp
         GbkaPj0CXymhl6axTdGscnGJQph5P/lxaOYhn7ebYVqaA4nOxHUUJNuBdtKqhxhHoPpk
         VZRjlhm5ad7OJYYX9V4jmqM5qpBr7Q7XDdqcBMJqy/PXxY8qKwnG+J8T/mqJLYqIS+YL
         GxSWeR9JIBw9hDX8iHDe1/htoiETqUVtz9xY2QAJC3sQEnTqWmIKOk/9uSXcQAPz/04i
         XR70Zq/8CDOmKPO9mdnZk57XNSW/d5Tf/Ju0ftptKSA/ti6NofGU+jdV8vfZB9pqzlkh
         0MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483582; x=1727088382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOot1WAmO0n8LqJvNiku2kLrm8KQvY7N+dDNwBSEg74=;
        b=S26wTYKabrbpjg98hDXdoTu6eew9ieZFWyQppaW//8u34mi/E5O5ayEKYsQAKNw0p5
         g0WzQpv+j5Ky6vTS8lRsFCtckdglUhM0ls3oPjYY3a4CL3XHe9AE0biXgv5e1DkzU4hG
         A2i/J9ANqDgcbZtnjzN5B+h2NaNO7SaWN2KGcbUSQWXh9WAmo8Uwq0MstbF3/f/sl891
         oSHpF7rp02LjDLcXS4jz0ICaYRxHLLsQWC6BnJcUqs8LpJkWZLPW49kXZ9tPP4Eu6AbN
         3uaxnooSEqneEFs3yDf4tSXFK4319IKTsIU06cEghKcc7hj+Q+17Y3EEUZ27ZapR0m0U
         4fCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrRdHOq3OgfXkMlVZ88RVHjcocPyqSmnBMqIujKq7HvV577zqx3gZ0HO9mPJR2kl4/byx8+A7qkkSO82k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/4S6r2MTF0lehRrTP5jHrwyNI0ZNauKZtzDZuSCM3Zpaf4+R
	T6YBl3KNCWPwVwuR5Z5Z8MxZQaluAZBmT2sA8QAsFeyYbqkDVkUZ+sG202hYMlJMBEWLMHkxKuH
	fCv673q8q3FtLh/Px75uccoJps4RPPaYL/hlE
X-Google-Smtp-Source: AGHT+IFPT7p70pyzFPnGYf9oumwIpGAwqpVNEQ2qCQe0d4QnaPMyQB86xSQEpMCg12204Y4OQ+FOje+z2iOX3Dd9gQg=
X-Received: by 2002:a05:6902:1883:b0:e1a:8e31:e451 with SMTP id
 3f1490d57ef6-e1daff6229bmr8957471276.10.1726483581486; Mon, 16 Sep 2024
 03:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
 <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
 <2494949.1723751188@warthog.procyon.org.uk> <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
 <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com>
In-Reply-To: <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Sep 2024 06:46:10 -0400
Message-ID: <CAHC9VhS5ar0aU8Q6Ky133o=zYMHYRf=wxzTpxP+dtA=qunhcmw@mail.gmail.com>
Subject: Re: Can KEYCTL_SESSION_TO_PARENT be dropped entirely? -- was Re:
 [PATCH v2 1/2] KEYS: use synchronous task work for changing parent credentials
To: Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>
Cc: Jeffrey Altman <jaltman@auristor.com>, openafs-devel@openafs.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Aug 15, 2024 at 4:00=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Thu, Aug 15, 2024 at 9:46=E2=80=AFPM David Howells <dhowells@redhat.=
com> wrote:
> > > Jann Horn <jannh@google.com> wrote:
> > >
> > > > Rewrite keyctl_session_to_parent() to run task work on the parent
> > > > synchronously, so that any errors that happen in the task work can =
be
> > > > plumbed back into the syscall return value in the child.
> > >
> > > The main thing I worry about is if there's a way to deadlock the chil=
d and the
> > > parent against each other.  vfork() for example.
> >
> > Yes - I think it would work fine for scenarios like using
> > KEYCTL_SESSION_TO_PARENT from a helper binary against the shell that
> > launched the helper (which I think is the intended usecase?), but
> > there could theoretically be constellations where it would cause an
> > (interruptible) hang if the parent is stuck in
> > uninterruptible/killable sleep.
> >
> > I think vfork() is rather special in that it does a killable wait for
> > the child to exit or execute; and based on my understanding of the
> > intended usecase of KEYCTL_SESSION_TO_PARENT, I think normally
> > KEYCTL_SESSION_TO_PARENT would only be used by a child that has gone
> > through execve?
>
> Where did we land on all of this?  Unless I missed a thread somewhere,
> it looks like the discussion trailed off without any resolution on if
> we are okay with a potentially (interruptible) deadlock?

As a potential tweak to this, what if we gave up on the idea of
returning the error code so we could avoid the signal deadlock issue?
I suppose there could be an issue if the parent was
expecting/depending on keyring change from the child, but honestly, if
the parent is relying on the kernel keyring and spawning a child
process without restring the KEYCTL_SESSION_TO_PARENT then the parent
really should be doing some sanity checks on the keyring after the
child returns anyway.

I'm conflicted on the best way to solve this problem, but I think we
need to fix this somehow as I believe the current behavior is broken
...

--=20
paul-moore.com

