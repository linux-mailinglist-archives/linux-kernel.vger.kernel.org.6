Return-Path: <linux-kernel+bounces-170234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A508BD3E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84221C21B62
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03135157E7A;
	Mon,  6 May 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Iudqc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E915746C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016869; cv=none; b=GdfVeHrPc73Lez49kxCU7ulGqp1s+re6oEgvCyHA3tMwiDO3hA7FrNsuBWyI4SYmRdIFTHwvvV7yGAGUGgcVfG2nAlMJTJ0pFUqCv1uExUzxpNz/7rhPch/Csb+v2ihoA00U4xP9f/7IMLKYTmT1wy3IYrj/Q2zcVl5qyys1T38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016869; c=relaxed/simple;
	bh=N/Cl1VgIzjxIHfpr4FV+iTL6dI3E1P0L0sOAp1/Q/tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQYLjWiNbQtSdDlxmo7pIgdNiMkndcoU22X+2HZwmG9vliZlk9dvTKieEApLZ/YMZeijn/5XoDDWv671zVylL779CalTsDm/g3KKkXrAWDr+oDTo/6lnmWKluBovFq16Kx5xAvi70jlGYlvS6pgaK6ty/ACq6KEbshIvTda+IoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Iudqc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE7BC4DDE1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715016868;
	bh=N/Cl1VgIzjxIHfpr4FV+iTL6dI3E1P0L0sOAp1/Q/tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H8Iudqc/tMmB6Ux07aKW2+nVQIyF2/xi8XFLtbUt4cisTwfIJgMdrGE1TQLvkxT/a
	 ATYzQpgwLdgFbtNdNbNGqj50VV/FiHJWYrNVZzSFHv+8UTX/bs0w/FxVRp4AStKBqv
	 oc9m/a6i8+NemFOaHN+fGSWasfHo98tIiHNveOeKgLAIVdH/e785pCvqTy1fskTBKg
	 pncsNEFIn2o3uM7STR2rMIe2/lVyFJFi7WCmfEuvPttBlPAgEsoNd90aOkd8zeLMnX
	 MBYk4W94sMZik02mxbsvqC1thGhw3T6SiBE9xZ6fxVpYtyvn+gE7pPMB2zfgC3Z51Y
	 eOfWHNmPh9zTw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ef98eee195so497228a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 10:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWThGYwc5zbsByw/9RkMAs+4wpzPrIO5C7KXqZV+ZiWz2prbRTp+Fh7i5U2voWlwVwtsgNcPHGMEyTfYmTpzB3FWzx4tzmzxTEUAJCZ
X-Gm-Message-State: AOJu0YzQbI3CawjBe4i7hVzrzSRklEOvX61GHuQfet+wTk2MBnTCZ9+q
	YaxlTdx6uDZrUuHLoDwKCjH4KE3lZOUYa6thAI8QCsUDRAi3becryTrPEKv9jU8IuOQlwczl0wt
	K46djJea3KMlSH1nyX5/NQUBkRWRUv0Pb/5Th
X-Google-Smtp-Source: AGHT+IGeEkyd9/ecXTKRvSMEhABoiDcgycle+ebD63V9wpAW6Icf2bUBHPTL3WKDxwW/DA9QnCw2BpuJ/GbXWPX4plE=
X-Received: by 2002:a05:6870:1b0a:b0:23b:c31f:ee76 with SMTP id
 hl10-20020a0568701b0a00b0023bc31fee76mr12950767oab.52.1715016868026; Mon, 06
 May 2024 10:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426133310.1159976-1-stsp2@yandex.ru> <CALCETrUL3zXAX94CpcQYwj1omwO+=-1Li+J7Bw2kpAw4d7nsyw@mail.gmail.com>
 <20240428.171236-tangy.giblet.idle.helpline-y9LqufL7EAAV@cyphar.com> <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
In-Reply-To: <CALCETrU2VwCF-o7E5sc8FN_LBs3Q-vNMBf7N4rm0PAWFRo5QWw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 6 May 2024 10:34:16 -0700
X-Gmail-Original-Message-ID: <CALCETrUZp2P1PXwJeL7ryda_qSLGsgHf5X0Zpw8piiT58k-cYg@mail.gmail.com>
Message-ID: <CALCETrUZp2P1PXwJeL7ryda_qSLGsgHf5X0Zpw8piiT58k-cYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Stas Sergeev <stsp2@yandex.ru>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:29=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> Replying to a couple emails at once...
>
> On Mon, May 6, 2024 at 12:14=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> =
wrote:

> > I also find it somewhat amusing that this proposal is to basically give
> > up on multi-user permissions for this one directory tree because it's
> > too annoying to deal with. In that case, isn't chmod 777 a simpler
> > solution? (I'm being a bit flippant, of course there is a difference,
> > but the net result is that all users in the container would have the
> > same permissions with all of the fun issues that implies.)
> >
> > In short, AFAICS idmapped mounts pretty much solve this problem (minus
> > the ability to collapse users, which I suspect is not a good idea in
> > general)?
> >
>
> With my kernel hat on, maybe I agree.  But with my *user* hat on, I
> think I pretty strongly disagree.  Look, idmapis lousy for
> unprivileged use:
>
> $ install -m 0700 -d test_directory
> $ echo 'hi there' >test_directory/file
> $ podman run -it --rm
> --mount=3Dtype=3Dbind,src=3Dtest_directory,dst=3D/tmp,idmap [debian-slim]
> # cat /tmp/file
> hi there
>
> <-- Hey, look, this kind of works!
>
> # setpriv --reuid=3D1 ls /tmp
> ls: cannot open directory '/tmp': Permission denied
>
> <-- Gee, thanks, Linux!

I should add: this is lousy even for privileged use.  On a normal
non-containerized system:

$ ls -ld /var/lib/mysql
drwxr-xr-x. 3 mysql mysql 4096 Sep 20  2023 /var/lib/mysql

This makes perfect sense.

But if I want to run mysql in a container in a sane way, my only real
choice is either to trust the container manager quite strongly (so it
only maps this directory into the correct container) or, if I want to
separate out management of this container into its own UID (which is a
good practice), then I'm forced to do some kind of fragile hack like
making a directory only accessible to the correct UID and then
creating a 0777 directory inside it and bind-mounting *that*.

