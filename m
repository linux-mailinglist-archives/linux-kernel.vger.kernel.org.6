Return-Path: <linux-kernel+bounces-385984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9739B3DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A168B21F29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C951F7556;
	Mon, 28 Oct 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WglAqCzJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45A1EE021
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154851; cv=none; b=A8ciPstWCjEdcJBFYtteZT7fMQ7N4nj1BmXrbaNVDRuijA095x/m5iier2e0AY/LhQKjdeSkTGjQoRfqPSU/Jt7sbRZ3qKk6SH2MrfYtqZNr/FHxuPuQVNCdTAGNWW6ktzvfo+jvZCdzYq2hQNdye2OXKk/tsxrsycF4RMhhb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154851; c=relaxed/simple;
	bh=3ncaw7EBXKhzY7nmLtwJTmOIK0b/Ne51xW05o55N1OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irp9cUrLONufhAazOzp7SLe1bJ3c4BZsoOx1VQyPMRMIsRG30XXVCq/dLHCLUdx2m5ONLSlmbXvdSwWvqFofogcrwDMLZdu10L6SgRA3oyNQTrJrdkYPC9p7h/66RsTdSRY7TAFqKYqybBG75/afC+YbqelpDBPkJFBf3RICsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WglAqCzJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso3296308a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730154848; x=1730759648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBh34PcU2xzgnBJzROxjQ3rfubqym7gNYxhxdbinqVE=;
        b=WglAqCzJGqMoTw/PtTOMdXit1GrmYHsB6ZGMn7J1jBgxr6a+qlWdNf8ntk4RDtGf9u
         xl7M5pPFvpjgKi8cyjnyaMm83qhO/qBNETOgQhGD4rWURu1CgTzOTolJq19e0xN9HY9k
         ewbfRoHgo9DH5FzO7yECyGJJSNWdXAV3+URJTjLmmraBVDSUe1PUxzC9Ilxh9FqbBQBO
         dhzmbqkGJ8k1brqlVMtDF0MYogJw/cadS9BS4c7EgmSq/j2j6IoaA3WOB7InUX/ZVkDZ
         MDf9BcHcBzYCXgMZMSPCeEF4YJnoNIJvm0E0IXu3B+m81b+ncDi/oMVjrx2d3V3XCbWo
         W26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730154848; x=1730759648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBh34PcU2xzgnBJzROxjQ3rfubqym7gNYxhxdbinqVE=;
        b=PSQAxM6LJ0+ITfzzIi52OKuURaXtXUWe/j3v1mR6vGv13m0+ETehFeX+lokdRUreMO
         mSp8mUfjb/NIA8WUQ1ts0XsmkGcqMX3qmplKjb+bUjWbXzgqbJX007eDxIrQyKLbe2KR
         z4xt8U8aksad3kBaiq3E9Lq19GwwnXOxhtWH4u9b6/H6B+5NUyB+QBW+oWJBDBqfFWrN
         5BezAWPGY1U3OqfoUCdBa5gWjUtA3TMbcvcw/bVffCV1jvf/1wyXmYDnUmHQh5Mn+A3r
         bxEHzN4TV9Kft3F2/93lD5CPdMZ8yqgTkUK8BY/FfqGAOGpWJUZr7vKi62sn79VYH0mf
         7fzw==
X-Forwarded-Encrypted: i=1; AJvYcCVHTe5HZCqWrYXLSdSXvstRL8rO1JpvWxSi1K2MfSmRRuJMQZ0GZzkT137XRAVQaH/M/w+2/flF2Nd3wxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ziq8kmu6g8Ufg4rKHUZy/BPhIneXbOc5kVKDDnnjZkn3JlxJ
	Css/issA5Aq9rNu34uE4CxNhc9NcaDOA7DcgKedyOH7qgMJY3Op8AWIpCqLtFyBJZBHaEMm+syT
	nUuNbV2yNIwfzRx4OGg2x2Zm6RqLJYVwR+hZO
X-Google-Smtp-Source: AGHT+IEwRgYheh/sM/joveuSu8hxe7i5aTq85tR9URv4iYxxHGYBDNx6HEgsUAqQpPxOsHZU0KkTRwts5CsuZnrPlBU=
X-Received: by 2002:a05:6a21:458a:b0:1d9:281f:2f27 with SMTP id
 adf61e73a8af0-1d9e1f78375mr12284637.19.1730154847585; Mon, 28 Oct 2024
 15:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com> <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 28 Oct 2024 15:33:29 -0700
Message-ID: <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
Subject: Re: Boot-time initiative (SIG) thoughts and next steps
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 6:30=E2=80=AFPM Bird, Tim <Tim.Bird@sony.com> wrote=
:
>
>
>
> > -----Original Message-----
> > From: Saravana Kannan <saravanak@google.com>
> > On Fri, Oct 25, 2024 at 11:18=E2=80=AFAM Bird, Tim <Tim.Bird@sony.com> =
wrote:
> > >
> > > Hey Linux developers,
> > >
> > > The response to my request to form a Special Interest Group for boot-=
time reduction
> > > for Linux has been really great.  Many people contacted me by e-mail =
and on LinkedIn.
> >
> > Hi Tim,
> >
> > Thanks for organizing this and moving it forward! I'd be interested in
> > contributing to this effort as a lot of work I have done aligns with
> > the goals of this effort and boot time is of obvious value to Android.
>
> Thanks for your interest.  I would love to have developers from Google,
> and from the Android community, involved.
>
> >
> > > I had hoped to push out a script today to start to gather data on boo=
t-time on different
> > > platforms, for people to run who had expressed interest in helping wi=
th this effort. But
> > > I got overwhelmed with other tasks, and I may not get it done today. =
 I'll be in Tokyo next
> > > week for Open Source Summit Japan.  If you are there, please try to c=
atch me and say hi.
> > > Given that, I'll see how soon I can provide the script I'm talking ab=
out, and we can
> > > discuss the goals and design of the script.
> > >
> > > A couple of quick things:
> > > There are lots of things to discuss, but here are a few things to get=
 started with...
> > >
> > > =3D wiki account =3D
> > > The wiki where we'll be maintaining information about
> > > boot time, and about activities of the boot time SIG, is the elinux w=
iki.
> > > The page we'll be focusing on is: https://elinux.org/Boot_Time.
> > > If you are interested in helping update and maintain the information =
there
> > > (which I hope almost everyone is), then please make sure you have a u=
ser
> > > account on the wiki.
> > > If you don't have one, please go here:
> > > https://elinux.org/Special:RequestAccount
> > > I have to manually approve accounts in order to fight spambots.  It m=
ight
> > > take a few days for me to get to your request.  It's very helpful if =
you
> > > put a comment in one of the request fields about this being related t=
o
> > > the boot-time initiative or SIG, so I can distinguish your request fr=
om
> > > spam requests.
> >
> > Can we instead keep this all a part of the kernel docs instead of the
> > wiki? Couple of reasons for that:
>
> Ideally, we would put some material in the wiki, and also
> produce a document - some kind of "boot-time tuning guide" that can
> live in the kernel tree.

This is the part I care most about being in the kernel docs. Eg: what
configs to use. What commandline params to set. Dos and Don'ts for the
drivers, etc. So, good to see that is an acceptable option.

> Some of the material that I think we will
> maintain will refer to boot sequences and operations outside the
> kernel (such as the bootloader or user-space), so the scope of
> the material to document is not just limited to the kernel.

Makes sense.

> Also, there will be a lot of material that will be system-specific.
> Historically, the kernel has avoided documenting things that are
> specific to an individual platform.

A lot of kernel params are arch specific and we still document them in
the kernel. So I don't there's some leeway. But yeah, doesn't make
sense to document stuff like "improve RPi 4 boot time" kinds of stuff
in the kernel. But not sure that makes sense for the elinux.org wiki
either. But we can figure this out as we go.

> Finally, a lot of this information will be ad hoc, which also doesn't
> lend itself to upstreaming.

At least for the kernel params and configs, I don't think it's that
adhoc. The rest, I don't have an opinion.

> See my response to your individual points below.
>
> > - Since the instructions can be kernel version specific (as things
> > change), it makes sense to have the document synced with the kernel.
>
> That's a good point.  The current material suffers from not being synced
> very well with kernel versions.  That is, there is a lot of obsolete mate=
rial.
> My own experience is that kernel documentation also has a bit of an issue
> with being kept up-to-date, but it's not as bad as wikis often get.
>
> It would be good to have some plans and possibly mechanisms to address
> the eventual obsolescence of the material.
>
> > - It's one less account to maintain and less chores for you.
> The cost per developer is one-time, which shouldn't be too bad
> for individual developers.  I already have the role of elinux administrat=
or,
> and so I have to approve accounts anyway.  In either case
> (contributing to a wiki or contributing upstream), there is going to
> be some overhead for reviewing the material.
>
> > - One less business approval to get in terms of contributing to
> > external sources.
> This is an interesting point.  Does Google have rules regarding contribut=
ing
> to wikis?

In all the companies I've worked at, there's always been some level of
sanity check about external contributions to make sure you aren't
accidentally/intentionally signing up the company for something the
company doesn't agree with.

The point is that I don't know what Google's position is wrt
elinux.org and I need to find it out and/or go through any paperwork
that might be necessary to get approval. All that adds a lot of
inertia, at least for me. I know we are okay contributing to LMKL, so
that makes kernel docs a frictionless process from an approval
perspective. And with the other points in mind about bit rot and
keeping things in sync with kernel, I'd prefer the kernel parts of it
being in the kernel docs.

> That is actually related to my plans to use automation to collect
> boot-time data.  My plan is to have tests that automatically send data
> to a central collection server (with data that is put into a shared, publ=
ic database).
> I realize there will be some companies who won't want to share certain
> details of their in-development platforms.  When I publish the first
> script that does that (probably this week or next), we should discuss the
> ramifications of developers needing company consent for this.

My comment wasn't about this part at all. I don't think boot timing
needs to be run on any unreleased device. There are plenty of released
devices to test with. And we are actively adding Pixel 6 support to
upstream.

-Saravana

> > - Less chance of bit rot. As people make changes, the docs are right
> > there to go fix.
> You are right that bit rot is a significant risk with wikis, because ther=
e are
> no mechanisms to automatically update or remove obsolete material.
> I have some plans to fix that with some test instrumentation and upstream
> wiki processes that can automatically detect changes to published data,
> and can recommend review of material, or flag it as obsolete.
>
> My own experience is that it is significantly easier to change
> something on a wiki, than it is to change upstream kernel documentation.
> One requires just changing text using a web form, and the other requires
> an upstream-compatible e-mail based submit/review/approve/release cycle.
>
> I'm interested to learn more about the barriers that developers at Google=
 (or other
> companies) might face in making contributions to a wiki.  Can you describ=
e
> those obstacles in more detail?
>
> Thanks,
>  -- Tim
>
>
>

