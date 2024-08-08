Return-Path: <linux-kernel+bounces-278747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F161194B443
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5011F228A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E14C6C;
	Thu,  8 Aug 2024 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qO94POIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA824440C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723077670; cv=none; b=L2emPYtabpBnCN7GuWm1OlJUzduIjWY9l4M5owyvOej8WmKazBDNwVcqE0W6mZ//3xFmJabHV7xBCS9RuZWLuiSv9ya8+9aXaqrz9ibAODrSXpTpd2gOMgiPuu+lZAcqIuNXqBg8mEQkSiE2yDAX30+d5NvoJqKIjhPaZ6GVx7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723077670; c=relaxed/simple;
	bh=dceKmbz2Mb4+WZwGdUcqTl9hdJs6Y82aU+twQVZH620=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLmCNEHcrkceLawChKCeAPFS9s/bNNEzQmOqCODeFX3ITx8jA0xqf6Heu/nBqteEgDHOyiJL23K+XjkKAjDk3yinkOnDj3h5ShJomq03P8Z5Ia+FtpKiwE4REtcKFc9cK1WHvsv4mHcXISyw104S/Lrju3KrU0EvNyTINsDrFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qO94POIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE2DC4AF0B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723077670;
	bh=dceKmbz2Mb4+WZwGdUcqTl9hdJs6Y82aU+twQVZH620=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qO94POIrtMehwv9SxqQiG8IvlvYNQTtCGHVmG0EdGO8GArq0dqla/kQeFrBFFeS+t
	 JTB3/iLWmeDXytP8uNaN+tFsvQTq5lklSUR6zmaLmIhEYCz8dUTLkzSRfNFbr3cWBz
	 N964qpqjCGnAsstmoSsQx9h9zysbLm7clHFOXjF7b4G9s2YZGeyCU+d8tPWmp3VIO/
	 EP4vJt3OzL7Ps7W8ZxCV/qpCYufd6+U/rOtd/j24TYnhZIKo1ynNMIHdURcpIcd145
	 HBOmkNT4LX/4otgEnfUjPf2DZRkKJG8E2p1neVN5aiYqkiwHV7tGNlWGQBwsy+ZdMr
	 zf5Xw9ZNAWuZQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so443042a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:41:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFMBUERrPXCDj/hSwpmDnl/CO+8No0WvFwo6VgLVLo54yn0U8Z6ASgwfzCoQZuMF+4nnOw1/JdA6yltZ4Firj+SXgRWD1qMMQbDPYr
X-Gm-Message-State: AOJu0YwdfKHrePD5KMJpPArATGLBcQnphFl9nEfXCnrBZVeJgkRpwFxK
	32VhqnE+pvbB1Y9QzECE8evhzoIpLfrQRgumIm2ruk9jxIEbCbwBKjqtKJBZc7gRzjnNhUmoFGP
	OvT0vIH573Qp0TP0rnX5y97S4P9kbHPTm99Iw
X-Google-Smtp-Source: AGHT+IFcGHgngMLoGFMoUU4WpRih9HpN+u3MofT5ZESQAB5cCIETr5Mk4FR2Jp7i9EiY+gYyACRpAZJbIHEcdCvz96M=
X-Received: by 2002:a05:6402:4407:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5bbb23dedd8mr236880a12.25.1723077668986; Wed, 07 Aug 2024
 17:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801171747.3155893-1-kpsingh@kernel.org> <CAHC9VhRO-weTJPGcrkgntFLG3RPRCUvHh9m+uduDN+q4hzyhGg@mail.gmail.com>
 <CACYkzJ6486mzW97LF+QrHhM9-pZt0QPWFH+oCrTmubGkJVvGhw@mail.gmail.com>
 <20240806022002.GA1570554@thelio-3990X> <CAHC9VhTZPsgO=h-zutQ9_LuaAVKZDdE2SwECHt01QSkgB_qexQ@mail.gmail.com>
 <CAHC9VhQpX-nnBd_aKTg7BxaMqTUZ8juHUsQaQbA=hggePMtxcw@mail.gmail.com>
 <CACYkzJ7rdm6MotCHcM8qLdOFEXrieLqY1voq8EpeRbWA0DFqaQ@mail.gmail.com>
 <CAHC9VhQ1JOJD6Eqvcn98UanH5e+s6wJ4qwWEdym4_ycm+vfxmQ@mail.gmail.com> <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
In-Reply-To: <873b04da-7a1e-47b9-9cfd-81db5d76644d@roeck-us.net>
From: KP Singh <kpsingh@kernel.org>
Date: Thu, 8 Aug 2024 02:40:58 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5qSe7f8xPr11dDUjQisbcc3wrC1buJSw9VMRL8MKm6xw@mail.gmail.com>
Message-ID: <CACYkzJ5qSe7f8xPr11dDUjQisbcc3wrC1buJSw9VMRL8MKm6xw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Initialize early LSMs after arch code
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Moore <paul@paul-moore.com>, Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bp@alien8.de, sfr@canb.auug.org.au, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 8/7/24 16:43, Paul Moore wrote:
> > On Wed, Aug 7, 2024 at 6:45=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> >> On Wed, Aug 7, 2024 at 10:45=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>> On Tue, Aug 6, 2024 at 5:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>> On Mon, Aug 5, 2024 at 10:20=E2=80=AFPM Nathan Chancellor <nathan@ke=
rnel.org> wrote:
> >>>
> >>> ...
> >>>
> >>>>> For what it's worth, I have not noticed any issues in my -next test=
ing
> >>>>> with this patch applied but I only build architectures that build w=
ith
> >>>>> LLVM due to the nature of my work. If exposure to more architecture=
s is
> >>>>> desirable, perhaps Guenter Roeck would not mind testing it with his
> >>>>> matrix?
> >>>>
> >>>> Thanks Nathan.
> >>>>
> >>>> I think the additional testing would be great, KP can you please wor=
k
> >>>> with Guenter to set this up?
> >>>
> >>
> >> Adding Guenter directly to this thread.
> >>
> >>> Is that something you can do KP?  I'm asking because I'm looking at
> >>> merging some other patches into lsm/dev and I need to make a decision
> >>> about the static call patches (hold off on merging the other patches
> >>> until the static call testing is complete, or yank the static call
> >>> patches until testing is complete and then re-merge).  Understanding
> >>> your ability to do the additional testing, and a rough idea of how
> >>
> >> I have done the best of the testing I could do here. I think we should
> >> let this run its normal course and see if this breaks anything. I am
> >> not sure how testing is done before patches are merged and what else
> >> you expect me to do?
> >
> > That is why I was asking you to get in touch with Guenter to try and
> > sort out what needs to be done to test this across different
> > architectures.
> >
> > With all due respect, this patchset has a history of not being as
> > tested as well as I would like; we had the compilation warning on gcc
> > and then the linux-next breakage.  The gcc problem wasn't a major
> > problem (although it was disappointing, especially considering the
> > context around it), but I consider the linux-next breakage fairly
> > serious and would like to have some assurance beyond your "it's okay,
> > trust me" this time around.  If there really is no way to practically
> > test this patchset across multiple arches prior to throwing it into
> > linux-next, so be it, but I want to see at least some effort towards
> > trying to make that happen.
> >
>
> Happy to run whatever patchset there is through my testbed. Just send me
> a pointer to it.
>
> Note that it should be based on mainline; linux-next is typically too bro=
ken
> to provide any useful signals. I can handle a patchset either on top of v=
6.10
> or v6.11-rc2 (meaning 6.10 passes through all my tests, and I can apply a=
nd
> revert patches to/from 6.11-rc2 to get it to pass).
>
> Question of course is if that really helps: I don't specifically test fea=
tures
> such as LSM or BPF.

The changes would not be specific to BPF LSM, we just want to check if
our init/main.c refactoring breaks some arch stuff.

I rebased my patches and pushed a branch based on v6.11-rc2:

https://git.kernel.org/pub/scm/linux/kernel/git/kpsingh/linux.git/log/?h=3D=
static_calls

- KP

>
> Thanks,
> Guenter
>

