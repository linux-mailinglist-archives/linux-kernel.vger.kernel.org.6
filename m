Return-Path: <linux-kernel+bounces-278702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5AE94B3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F361C20DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57315665C;
	Wed,  7 Aug 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bxHDZ1PF"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615D155C83
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074252; cv=none; b=amESxdoLQvY1Kc//3Sz7NSu0QPnSSjy/UqvJl5xiV8iBVi85xlM4berNGHtrgZzAtncMX187zHCe7LDncVVnSMhPFRIBHP/NkVZoDiK6vEohX7yPqHmCD5sxmdvUiEeNBgzYF0fuF3lhbyDtnwIMSv789qDdf7/zyeE5wVjuSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074252; c=relaxed/simple;
	bh=qDQiKEv6k9UML3kamA1nH5tNqN81EHmMEWsFVFxtecI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoTrid5ig4xtsTYafQR3rgav0Mlo8tXZn9P47WBUGGe4Bfe+E0BPH1p7Q28HQJxPNE6qbHI0B/jdsyCYTA3Mw7WIBvtw330MX9y/lywpnFMivjxqFyr3v9nnUtb4wineBgBr07Ag7oSybcQkOXg9fyk46I/TnwWQnCTuibei9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bxHDZ1PF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so405770276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723074250; x=1723679050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dX9h7u30CCZYgKeYGhflIbAKtLicQOaB5Q+NrRVtTA=;
        b=bxHDZ1PFApFGr8g5xcakA1kcqZ3e93oPwpgcXQFluQ41jf29IDrhdB9nD5UVcK4sCD
         I474DG5yoEy9YbRRPHpw103Ou6SR4BLJ86Flp85ryYQR8O/qd/Q2nOO0rUcBPsrT3oix
         Hr9Lflz44BZm7Z7zI5Wgr60tkyvtIx2c4EBoSxKit92ieddSHJMkKyebaEMGtfOoPefZ
         M9dk9hVSwqgAfJ66eez56sLggO+6Me5juSy4SJ03w2vgyQc3quWBoDs8Fb31PV81Wtsm
         dgkEpt3N6e55UdnwcWWtDqzsTjB0hHoY9Qu/XainbK3QaMdXpRMQV9X57T/z8QopGmR8
         QyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723074250; x=1723679050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dX9h7u30CCZYgKeYGhflIbAKtLicQOaB5Q+NrRVtTA=;
        b=tjLfwP4uR9cPlTDeB9E4sp+BVSvo2SCMxWVDmGvrJxG1z/C4ND8rRNpw/TDfypnQC5
         6Xmh3WOyJxV2iwv+i0rA4MnBA6rJ+deh5YWeNIkUuWpYLtaPpu4S3D6I+QJwIg8Im9d7
         Hij6mR3F2sFr19p9VTAslZYbREZfTmWNsOsI8+xngfnmCskhLglCU0bddVs2wk9so0ZZ
         nJhz2BhBnt0goqozChrRttBa1UAUqhFKTB6cHPb8uB3UoDMlIWAHPS+u+NpOzWKSQK46
         SqdX8nbH8rhtPXPAJfZu8M66+p0LsuUFAE5DXHGM9eXljP6vJVITqWydYkXt4z5reZBK
         1/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT2+0whOp85DQDWTaYvOFtVh4QAm5McuqcvLlbSTmn/HZo7WwFri/8fiyw9EDttN/Dk3EKoU30RKBWeys7jJhiT+pWk45mt+xj/34G
X-Gm-Message-State: AOJu0Yy/+DLSYON2Meukfo/gtjcU3uRh+aYbH5SyEkIjrDF0PqaSBfx7
	r8CAfjPJabPn1meXioOT8Hv/NS7AIdzIZG+4XI8ISubPDgwd9qhef4GrMFy3Buyt3tGMfzIALPx
	y/RtONNFR4QIcb6yYSqQNpxpb5T80Pgo1hZ2+
X-Google-Smtp-Source: AGHT+IEHjqPNJl4NBLXpmlk8UH1R7GzDMR74vtPfZk/5xC8XSotD1uI2NHd2yLQyMszK3pEoXURs00deXIOJmJ8ZyXM=
X-Received: by 2002:a05:6902:240f:b0:e0e:499f:3d88 with SMTP id
 3f1490d57ef6-e0e9db13681mr250205276.26.1723074249935; Wed, 07 Aug 2024
 16:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com> <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Aug 2024 19:43:59 -0400
Message-ID: <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: KP Singh <kpsingh@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:45=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@ker=
nel.org> wrote:
> >
> > ...
> >
> > > > For what it's worth, I have not noticed any issues in my -next test=
ing
> > > > with this patch applied but I only build architectures that build w=
ith
> > > > LLVM due to the nature of my work. If exposure to more architecture=
s is
> > > > desirable, perhaps Guenter Roeck would not mind testing it with his
> > > > matrix?
> > >
> > > Thanks Nathan.
> > >
> > > I think the additional testing would be great, KP can you please work
> > > with Guenter to set this up?
> >
>
> Adding Guenter directly to this thread.
>
> > Is that something you can do KP?  I'm asking because I'm looking at
> > merging some other patches into lsm/dev and I need to make a decision
> > about the static call patches (hold off on merging the other patches
> > until the static call testing is complete, or yank the static call
> > patches until testing is complete and then re-merge).  Understanding
> > your ability to do the additional testing, and a rough idea of how
>
> I have done the best of the testing I could do here. I think we should
> let this run its normal course and see if this breaks anything. I am
> not sure how testing is done before patches are merged and what else
> you expect me to do?

That is why I was asking you to get in touch with Guenter to try and
sort out what needs to be done to test this across different
architectures.

With all due respect, this patchset has a history of not being as
tested as well as I would like; we had the compilation warning on gcc
and then the linux-next breakage.  The gcc problem wasn't a major
problem (although it was disappointing, especially considering the
context around it), but I consider the linux-next breakage fairly
serious and would like to have some assurance beyond your "it's okay,
trust me" this time around.  If there really is no way to practically
test this patchset across multiple arches prior to throwing it into
linux-next, so be it, but I want to see at least some effort towards
trying to make that happen.

--=20
paul-moore.com

