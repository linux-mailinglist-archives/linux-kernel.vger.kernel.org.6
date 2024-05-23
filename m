Return-Path: <linux-kernel+bounces-187969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C728CDB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D5B2838B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44884D35;
	Thu, 23 May 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJxBMj1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5D28F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495986; cv=none; b=N2zl++lb8l+krQchdfNgsc861BratQive/UmR7r1+kHXPS2rui7grBDg4g15G9a9+2Oy7no20JVo+e5xTV5SsUah31HdZVKZMiW1xSmPC+SSEuf4k43Nx7r3ihDnwJrgfM9hyuZhzg7TYTDyRoBzamK/QASFLjOf/oJHK6I7SRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495986; c=relaxed/simple;
	bh=JnrUkGmHC75Gk19tpLIyKV+pZYcgqu/foMs9FSsCvpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhqVAPnemkmGE7/I6tQs4q9HG9uApR9l0cBPUyaW4CKyTNKGhoZHKqLUV+/JmIz2tGAZb6JkIT5teXN2bnRcOolwWhxCqg+HnVHyfjam82z/4oseIVlSWtR2xXdlSvTMRtcTIH9IP6mJY8JYqClQE4Z8pXW48GCmT/k2J9h6ZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJxBMj1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC7AC4AF0A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716495985;
	bh=JnrUkGmHC75Gk19tpLIyKV+pZYcgqu/foMs9FSsCvpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sJxBMj1iBdiVHZAY07bHX/exqJs43SnQIwAcdFGS6uxB/qrzKkm6ybVpsbWRsfG+f
	 ckQpacOOGp85cIBPhnIUdFaUQuOqjwLaIAhXHspvauZu2iQGQ0Om89JVSHnqlS5S37
	 UtmZRHVo9akZNni0M+WYCE5vvu5noHTgbGtMHvTM2OSTPleahAgT8z5doJyq8agCPB
	 /+xdyR1bSZWIG4eRVBOBq6kI2hUWlhV7rka3FpGY+Up3WpvlLsMXQKEA6s+iYm0s52
	 4g0G3RPp0ak07rjj5efTX106/prRE+XW64CS4S7VjDj91r4AUMBc3USGxGDMjj9tzn
	 X84nNhVEQlonQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295eb47b48so126374e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:26:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWODIi0GAS/gi76EfmXBTbe73kK3xpVJ6adeloLUnBYlviP43Zmf503QMnlNRFvHGAwUVUMYC9uJstr5WnBebVur5tD1gxaJO1WG7CP
X-Gm-Message-State: AOJu0YzIc/uNxqyFIUVdfIH903EV/NeQ8rzKpd2tCqb+8iIYyXdjHNjD
	PMcF3vA3npNdfK3uvGnT1VFWX8Q3K7lOF+RhaEbBbZ8p94xpKTOen35JuAfE4acKm4ldpddmaK6
	5lx250aByODN8KJXRxTxi9drN6g==
X-Google-Smtp-Source: AGHT+IEuR1DxhXdiaoN5V+oe7jhw9uz8fupqmqOjSxM977L1TpJN8Xe6r6d7xTSuZXtPQgH0a8lnRyt7hiqhEfGsfgI=
X-Received: by 2002:a05:6512:b1a:b0:51d:68fb:5d73 with SMTP id
 2adb3069b0e04-529645e2436mr126990e87.8.1716495984097; Thu, 23 May 2024
 13:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CAMgjq7ARr0=OG8GQOJvzLtfdrtiwvJ19-mx1snxqmLE0Za+QCw@mail.gmail.com> <Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Zk-fQtFrj-2YDJOo@P9FQF9L96D.corp.robot.car>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 23 May 2024 13:26:10 -0700
X-Gmail-Original-Message-ID: <CANeU7Qmc0JoJY=w9YiX=Q5yJ1WJJyjX=gQQb6dxb=jAuyT-53w@mail.gmail.com>
Message-ID: <CANeU7Qmc0JoJY=w9YiX=Q5yJ1WJJyjX=gQQb6dxb=jAuyT-53w@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Kairui Song <ryncsn@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	gthelen@google.coma, rientjes@google.com, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:56=E2=80=AFPM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Thu, May 23, 2024 at 01:58:49AM +0800, Kairui Song wrote:
> > On Thu, May 9, 2024 at 2:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
dev> wrote:
> > >
> > > On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > > > Cgroups v2 have been around for a while and many users have fully a=
dopted them,
> > > > so they never use cgroups v1 features and functionality. Yet they h=
ave to "pay"
> > > > for the cgroup v1 support anyway:
> > > > 1) the kernel binary contains useless cgroup v1 code,
> > > > 2) some common structures like task_struct and mem_cgroup have neve=
r used
> > > >    cgroup v1-specific members,
> > > > 3) some code paths have additional checks which are not needed.
> > > >
> > > > Cgroup v1's memory controller has a number of features that are not=
 supported
> > > > by cgroup v2 and their implementation is pretty much self contained=
.
> > > > Most notably, these features are: soft limit reclaim, oom handling =
in userspace,
> > > > complicated event notification system, charge migration.
> > > >
> > > > Cgroup v1-specific code in memcontrol.c is close to 4k lines in siz=
e and it's
> > > > intervened with generic and cgroup v2-specific code. It's a burden =
on
> > > > developers and maintainers.
> > > >
> > > > This patchset aims to solve these problems by:
> > > > 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1=
c file,
> > > > 2) putting definitions shared by memcontrol.c and memcontrol-v1.c i=
nto the
> > > >    mm/internal.h header
> > > > 3) introducing the CONFIG_MEMCG_V1 config option, turned on by defa=
ult
> > > > 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> > > > 5) putting unused struct memory_cgroup and task_struct members unde=
r
> > > >    CONFIG_MEMCG_V1 as well.
> > > >
> > > > This is an RFC version, which is not 100% polished yet, so but it w=
ould be great
> > > > to discuss and agree on the overall approach.
> > > >
> > > > Some open questions, opinions are appreciated:
> > > > 1) I consider renaming non-static functions in memcontrol-v1.c to h=
ave
> > > >    mem_cgroup_v1_ prefix. Is this a good idea?
> > > > 2) Do we want to extend it beyond the memory controller? Should
> > > > 3) Is it better to use a new include/linux/memcontrol-v1.h instead =
of
> > > >    mm/internal.h? Or mm/memcontrol-v1.h.
> > > >
> > >
> > > Hi Roman,
> > >
> > > A very timely and important topic and we should definitely talk about=
 it
> > > during LSFMM as well. I have been thinking about this problem for qui=
te
> > > sometime and I am getting more and more convinced that we should aim =
to
> > > completely deprecate memcg-v1.
> > >
> > > More specifically:
> > >
> > > 1. What are the memcg-v1 features which have no alternative in memcg-=
v2
> > > and are blocker for memcg-v1 users? (setting aside the cgroup v2
> > > structual restrictions)
> > >
> > > 2. What are unused memcg-v1 features which we should start deprecatin=
g?
> > >
> > > IMO we should systematically start deprecating memcg-v1 features and
> > > start unblocking the users stuck on memcg-v1.
> > >
> > > Now regarding the proposal in this series, I think it can be a first
> > > step but should not give an impression that we are done. The only
> > > concern I have is the potential of "out of sight, out of mind" situat=
ion
> > > with this change but if we keep the momentum of deprecation of memcg-=
v1
> > > it should be fine.
> > >
> > > I have CCed Greg and David from Google to get their opinion on what
> > > memcg-v1 features are blocker for their memcg-v2 migration and if the=
y
> > > have concern in deprecation of memcg-v1 features.
> > >
> > > Anyone else still on memcg-v1, please do provide your input.
> > >
> >
> > Hi,
> >
> > Sorry for joining the discussion late, but I'd like to add some info
> > here: We are using the "memsw" feature a lot. It's a very useful knob
> > for container memory overcommitting: It's a great abstraction of the
> > "expected total memory usage" of a container, so containers can't
> > allocate too much memory using SWAP, but still be able to SWAP out.

+Michal,

Just FYI, we do have companies like Tensent using the V1 combine memsw
limitation as well. Google is not the only company using this API.

> >
> > For a simple example, with memsw.limit =3D=3D memory.limit, containers
> > can't exceed their original memory limit, even with SWAP enabled, they
> > get OOM killed as how they used to, but the host is now able to
> > offload cold pages.
> >
> > Similar ability seems absent with V2: With memory.swap.max =3D=3D 0, th=
e
> > host can't use SWAP to reclaim container memory at all. But with a
> > value larger than that, containers are able to overuse memory, causing
> > delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> > out of balance, especially with compress SWAP backends.
> >
> > Cgroup accounting of ZSWAP/ZRAM doesn't really help, we want to
> > account for the total raw usage, not the compressed usage. One example
> > is that if a container uses tons of duplicated pages, then it can
> > allocate much more memory than it is limited, that could cause
> > trouble.
>
> So you don't need separate swap knobs, only combined, right?
>
> > I saw Chris also mentioned Google has a workaround internally for it
> > for Cgroup V2. This will be a blocker for us and a similar workaround
> > might be needed. It will be great so see an upstream support for this.
>
> I think that _at least_ we should refactor the code so that it would
> be a minimal patch (e.g. one #define) to switch to the old mode.

That would be great to have a path forward to allow cgroup V2 to
provide the combined memsw limitations.

>
> I don't think it's reasonable to add a new interface, but having a
> patch/config option or even a mount option which changes the semantics
> of memory.swap.max to the v1-like behavior should be ok.

Using sysctl or a slightly different cgroup API is fine. The feature
needs to be there.

> I'll try to do the first part (refactoring this code), and we can have
> a discussion from there.

Looking forward to it.

Thanks

Chris

