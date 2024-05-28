Return-Path: <linux-kernel+bounces-192801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E48D2253
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE01C22D09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56984174EC2;
	Tue, 28 May 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXM+sufj"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542E7D07D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916844; cv=none; b=u9s99XLf3+KvwSBcAyyXIlgdahqIzX9pw8czHnyi9lnbomGEARqPc+uoY7mfWNEKLTKXcWG3FUfINYtcPxMw0kdmqzbuoywP07s8X5nqATx0OyGjHkwoLM6vBgccsnfU8yhv+gYYTribveDwiREzybpfiRs+n5pzRJ7y+ArxV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916844; c=relaxed/simple;
	bh=GBOiXtNcUPVSQaWVNDT05G5ov+7Ccstqn4m/nkr13e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBY6Kvc3EpQVB8hp+6yPq5Al2gDHnLE8kSYb5njPt+Yvyz66PZkaWjILfw9tjGQASMMV0OIfaEvtRuscSl05V66fRzIOA39XqFJ3eM1jWMJw9PXs24B7/klIgCEwcujzmBfxosbOSjyO/HeYwN70SWYQZrgNpPg7Tej7MLGdaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXM+sufj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e9819a630fso17486371fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716916841; x=1717521641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdiIr55oW9SirwSwnLEbCzgNCUW3ZQwPnbBonMmTJ/k=;
        b=MXM+sufjLs2PsFYlLLnopjC52KMR8G1yQD7g1/oTaWmLBrMIbehgtY2BI8ynBAT7En
         HNyeXUmt5EDdYtp5wo4PXbUNKW3eajcaVerwyyFtZFq641qwZzp5sZD4RKbthe6lnNJG
         xSCx/WaHjEhQ1PX6FjyKuYMyi0bbuXonh4+e4/UvzA6LwDBscKec3nC2RY54j1YGYCZH
         Il2c2lrqr9J4/fNNQnc8L5YZd8Rb3gnRxtKAPITuRcxEZgH7eL0oovYllYDdxWzERgws
         ZUXz45rSRouBV26zdHv1b8I8oGGzA30EHw0AtZnlmUelUukoOFMWHgl4R7DDLlmikm7k
         2eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916841; x=1717521641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdiIr55oW9SirwSwnLEbCzgNCUW3ZQwPnbBonMmTJ/k=;
        b=ArnbRu8WGuDRlKC73cjRLBb9C++0Aa6mrjR/cix7PMJXbiAt7RofzFzUmk/vFWKo5O
         pHfXSn5tM6sCKrCFGAAXXlhjuGo80bIhHZqENEIEzu9jaDTQVmYUwVof8ln8QZ8DW4Kk
         yNIbwTNJhm5hKWmjXoDunADkixjnX3LU9GA6LYXS/X5L33B7AN6aQtJGYAkSZx1SJz03
         i+wV2hF2PRNZMReQbyJoFVqxddwkXldsIqQdszDTHuV7gvZ5FkLfTJ5WwZ6YfRN8S98w
         dGeSYVLvWZdD7RJtJUfU7WY0frQFJBVn6o0QmKWD/jOQH8ylHqSpHBgE/aWlsYbjF925
         BEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCXNAOrsm/JdFP4ZaAUGTKsTKJYQ2s/WFI5LE+GYpVcKVExTiSeRb5ucIVPx0sNZPEGqIXntJEbDXtbML7bWLJzdviCHx4JTlK4KXd
X-Gm-Message-State: AOJu0YwzndoppKFwmA43IiNNRNUQyM7kOxAYB+mKD2xFwlaMNf4BZokv
	jZObjwcbRAOoBINLvnkuxOBKuJa4S5WhZYyDpdqJFq8x6BGKiJINeUNHt+nSCT6iVlSAE93cUhG
	uqz/WrYiaWQylBSlZYl3uaG+RJ5Y=
X-Google-Smtp-Source: AGHT+IFhj2dNDHXsQzSVwQ/3bSZznNzhhZTFGmdJPfV4MwMaaknuJ0ICXqJHWmQRX0kJAgHsuZs5Ncsu+kyIpQKawt8=
X-Received: by 2002:a2e:820b:0:b0:2e5:4c78:1227 with SMTP id
 38308e7fff4ca-2e95b0c241amr90788531fa.31.1716916840491; Tue, 28 May 2024
 10:20:40 -0700 (PDT)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 May 2024 01:20:23 +0800
Message-ID: <CAMgjq7AYA91f4g-bknUZOMg6hApTD-X5LqjcTBN2u-Lu8pjs+w@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gthelen@google.coma, rientjes@google.com, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:55=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
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

Yes, currently we use either combined or separate knobs.

> > I saw Chris also mentioned Google has a workaround internally for it
> > for Cgroup V2. This will be a blocker for us and a similar workaround
> > might be needed. It will be great so see an upstream support for this.
>
> I think that _at least_ we should refactor the code so that it would
> be a minimal patch (e.g. one #define) to switch to the old mode.
>
> I don't think it's reasonable to add a new interface, but having a
> patch/config option or even a mount option which changes the semantics
> of memory.swap.max to the v1-like behavior should be ok.
>
> I'll try to do the first part (refactoring this code), and we can have
> a discussion from there.

Thanks, that sounds like a good start.

