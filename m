Return-Path: <linux-kernel+bounces-323857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8097444F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FB4289DED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A91A7058;
	Tue, 10 Sep 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CqAmCP5O"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE21A7076
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001357; cv=none; b=O0euA9VoT+Z0r+CCyjrJjbhB/oMr6ua/IFcOMnIu1L7WuIx9J7gHoATfXoAu/HcxhzPotLxeGi/mQ4veG0zP1MzpeHNsxiC3ZVy1dIni2jYeoW1PKMmhqjVYHFSbGd0YxOrvkVz9boAaCdvEr+a/UkIP0E09U8aSVRuLD5+bnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001357; c=relaxed/simple;
	bh=/sSLbtfrwVeABiJUeQBSaBwJb8hKBmomjLIUb1dAvvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj/2EpUduDLJU7y2Cb64n6s4BBWBrffOq7fVp8e/CyNeYJ8NkQ+XOnT29apf6QEi2rwUBMPIKxhC1Q07r2t1lCfE6ldRv3lu4xivCL1vnpUzJz9vbttC8U41E1zhO9BO9EwILrXgm5HjLUlCY+vTciMQGy+ukg/+q0YLB9o51PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CqAmCP5O; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d4f1d9951fso9790967b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726001354; x=1726606154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYjARXF5iHHpTlh5hyqO8bTT4ZmLx2A0R6UF7JUY+9c=;
        b=CqAmCP5OsuNHVeCyEiNDPnaM3R1UIekUKFiV0fw2r0x+b8m+NI86LznKcvmxzV8r+J
         t0mMfjtHbcha1skBFiKcguBvUdZ9nK4dp3TKW2i/70zcGq0nGtexGiPjOefjpkRkjR3E
         MgJp1PwWjZulVI32knqh73bgE4dOFjkaG5eVNhcQJNdNMWLHN89BWv5evIvK0MFWSmgL
         us0Z4beuHS5f9IC3VhveN0M1O2qhTGAZArXErutGwzun8D+or8uWLGOzGivsWo4XGqAM
         QecjxeqYCyqk3NXJAnrbtNRQbLDk2X+fd1GAmLwamKyAZVpH9O7UiSsw2BUGHx8/ygvW
         2ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001354; x=1726606154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYjARXF5iHHpTlh5hyqO8bTT4ZmLx2A0R6UF7JUY+9c=;
        b=lABh36mBNB/eZWe3BHoJ+ZjS79WCJ5iy/5SbhOrwpr3CMWwNJSIYwIV9vrjlilfdHf
         30da/M6wyx9LRfuEBgYS1BJmaxiLmMQXwO/G9x0baY8rluLrEPpWsksq1J+H6tGcHnMG
         YcI8u3r/sf8EqlRTC1/6CpvKa83ZNx6toFD0fRdWgavIqivBJ6PlHuuAZUUEdePYM0G3
         WPL5Uk2dhpFtAkd5ErpRpn9+IZn799UkFEt+08Gu4RlNQRd/7bda9OjbU99XAUW5Z+Fp
         7MG1apThMZ5VAB0RgYWkS1OqIj+ewMcIn9OPDEhYAkGl8azC0Sn3XEmrmZkAxHn6NhRJ
         1xrA==
X-Forwarded-Encrypted: i=1; AJvYcCWXl20q5tqNf4Sb1vc7swb90gpoYvsl6HNvKQDCuAjdyGlP5rL5l5FXgvp2NKf8vNlIaD8pLl40+Kmh6oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOVMlpleAjCMAZJyrJRZMZwNCZGT/oLSt6wDx/9noyUcUMXHW
	9+n7PtirwsZSrsREwEafDo4VLLSh+NyfcsHYaEDHtbyqVUbTnVrChhFjX/IavOoQ0Xgr8XopQ9D
	7pTjq9g42AnE8DTbAlzddkygq+hE8FQpl+Qzc
X-Google-Smtp-Source: AGHT+IFgMK6PeTDRSiV3IUUm82K2jugYC/SvYQbL/2kIQWJ6vCR0av/sG1KukB6SNfhmqpD5QEYFAa0dGswS6AalsdQ=
X-Received: by 2002:a05:690c:6812:b0:6c9:9341:1c45 with SMTP id
 00721157ae682-6dba6d98f5fmr12360207b3.14.1726001354371; Tue, 10 Sep 2024
 13:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
 <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
 <2494949.1723751188@warthog.procyon.org.uk> <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
In-Reply-To: <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Sep 2024 16:49:03 -0400
Message-ID: <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com>
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

On Thu, Aug 15, 2024 at 4:00=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 15, 2024 at 9:46=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> > Jann Horn <jannh@google.com> wrote:
> >
> > > Rewrite keyctl_session_to_parent() to run task work on the parent
> > > synchronously, so that any errors that happen in the task work can be
> > > plumbed back into the syscall return value in the child.
> >
> > The main thing I worry about is if there's a way to deadlock the child =
and the
> > parent against each other.  vfork() for example.
>
> Yes - I think it would work fine for scenarios like using
> KEYCTL_SESSION_TO_PARENT from a helper binary against the shell that
> launched the helper (which I think is the intended usecase?), but
> there could theoretically be constellations where it would cause an
> (interruptible) hang if the parent is stuck in
> uninterruptible/killable sleep.
>
> I think vfork() is rather special in that it does a killable wait for
> the child to exit or execute; and based on my understanding of the
> intended usecase of KEYCTL_SESSION_TO_PARENT, I think normally
> KEYCTL_SESSION_TO_PARENT would only be used by a child that has gone
> through execve?

Where did we land on all of this?  Unless I missed a thread somewhere,
it looks like the discussion trailed off without any resolution on if
we are okay with a potentially (interruptible) deadlock?

--=20
paul-moore.com

