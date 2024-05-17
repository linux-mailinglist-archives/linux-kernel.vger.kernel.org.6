Return-Path: <linux-kernel+bounces-181698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A28C7FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954801F21F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE988F6A;
	Fri, 17 May 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC80696n"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F458F54
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715912501; cv=none; b=fJFI7CFFxaL6GJ21UKdXKQGzayG/ebhbPunoqDJeNwV6lEF4UYuzua6FuKrEo1JSvVztFZXXuHVfKW2VKWhEK7qFzyMLs6EvWbnTsdfv+QNA4fT1kvn3PghcipWXf131G6mOABn1QAc1Z94N8cpKBg10TVrmidmR/MfVLtk0dUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715912501; c=relaxed/simple;
	bh=/RSwW/Q5V8K9mEYOg8aTlCaIdGS2uoYoHQis6OkfeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqqbDIb6wBoOvf/QicRsQ+Mv/Xclpza7/nIH77RSo1Mrv0urhEd74NN+7az2DiRQFMQB0LLTJ8rr99Ya6DIxYDOwyid7w6Y8BlTrZLUZzJUwxdR0nUYjBW3y8Av4yzfzpocjB2MMTaP1/WRqKdAGuARk/dPX85715zHGSF5I/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC80696n; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de4665b4969so8776980276.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715912499; x=1716517299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2kNiqWce50N3wzSAZPVVQzi32Ss+5CvUe/kUi/ijtk=;
        b=YC80696nGX0tkOnW/rCj/t8cewlQm7wX1oia0RXio66SAqXjSKEprSHxc0/U3k3KG0
         mqSfo1Ud9LFRkGu3IV5kVOXKsnamu9L+TycHOVDBYp3wDjZi15ePey7BzI4cugnEW9P/
         AZdFWU6spoJVjAt8HlOyuRry5V+YN6FdY6ow/I33ZwpcyQNSOZqfyVPtr/MocgByz/5s
         pRlzS9GMrK9rAMaY4p1DgMNc8TAcAMoJu4GAUhq8MUPJz9yVmVNzQ4Cgdzt4H2b9luTA
         aBzELXGT0w75r1ZvfI/mD20X6lZBsS/4oWbU1Wa82Zj/uOUGVDHZU6Y3Ot9UMuilNekM
         c51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715912499; x=1716517299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2kNiqWce50N3wzSAZPVVQzi32Ss+5CvUe/kUi/ijtk=;
        b=FcRj8N/fU5Kl+1yjCYTTaF5Yk6pZubLhMZw0nUQHmaATSJijZm/5GdaXU64lVC98PK
         xNB6o+ZB8EglMI+qSU8xNzaF8TRjrg5F/4o0iN6gJvTG/D1NSfkHT19A3XJPjRZO7cJR
         qguzqWcp3TdM7mMm9spEK0xebPDEoHne5b6LFKXe8KLLeP444H20oJGs0hSp+k/4AFDp
         23V7rSXQU40bBSC3RrLAl+Qrf6krj1gbdrSfOSJJJ9nkL2/l4M/IoDbOzo93ah8yotkv
         UbrGQwICya0jj/5jtYna0p/GJDgK8Q5vZ2Oo/Qzd+AmqgURNngQppLfcDvQso/qtYQpP
         fJvA==
X-Forwarded-Encrypted: i=1; AJvYcCXZHMapRG92KHkWAyryZRqPw1LdprPiHWReRvqNPxxIh58n5MGEGsraH34RQ8eKSXbdskwy36jgEVxGaxfvG1bIu64ivOygsDkkcDCQ
X-Gm-Message-State: AOJu0Yy8FE35REoPDeErJHq4Tgw7Okl5lrHJPMZPhCi5PcHfXwDOzP2L
	bkJ9r4Wy0eQHmnOg2ht2YDjDM9m1wldRVxQst317mjpCdNDcRdWLURcdwH7DnR/TlhkYFZ5RwOZ
	ueudl0bwsj30GN/u0ocu7EQMrvAg=
X-Google-Smtp-Source: AGHT+IGTVt5SLoCsm5aUVOJ0dhn4ZQGXPMwJfFfPApDghZLzCvMEzlEAKE0Xf5kS7eo6yjAal/9UI3SiVcggjWOkOjo=
X-Received: by 2002:a25:5502:0:b0:de0:deb0:c363 with SMTP id
 3f1490d57ef6-dee4f35b99fmr24598331276.31.1715912498612; Thu, 16 May 2024
 19:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
 <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com> <ZkZCizXXqVlkIoze@P9FQF9L96D>
In-Reply-To: <ZkZCizXXqVlkIoze@P9FQF9L96D>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 17 May 2024 10:21:01 +0800
Message-ID: <CALOAHbCqO6_kVJHLu9=vZVme2vhm7N70UN+0HSKA1Q2Zxq5SzQ@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	gthelen@google.coma, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 1:29=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Thu, May 16, 2024 at 11:35:57AM +0800, Yafang Shao wrote:
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
> >
> > Hi Shakeel,
> >
> > Hopefully I'm not too late.  We are currently using memcg v1.
> >
> > One specific feature we rely on in v1 is skmem accounting. In v1, we
> > account for TCP memory usage without charging it to memcg v1, which is
> > useful for monitoring the TCP memory usage generated by tasks running
> > in a container. However, in memcg v2, monitoring TCP memory requires
> > charging it to the container, which can easily cause OOM issues. It
> > would be better if we could monitor skmem usage without charging it in
> > the memcg v2, allowing us to account for it without the risk of
> > triggering OOM conditions.
>
> Hi Yafang,
>
> the data itself is available on cgroup v2 in memory.stat:sock, however
> you're right, it's charged on pair with other types of memory. It was
> one of the main principles of cgroup v2's memory controller, so I don't
> think it can be changed.
>
> So the feature you need is not skmem accounting, but something quite
> opposite :)
>
> The question I have here: what makes socket memory different here?
>
> Is it something specific to your setup (e.g. you mostly use memory.max
> to protect against memory leaks in the userspace code, but socket memory
> spikes are always caused by external traffic and are legit) or we have
> more fundamental problems with the socket memory handling, e.g. we can't
> effectively reclaim it under the memory pressure?

It is the first case.

>
> In the first case you can maintain a ~2-lines non-upstream patch which wi=
ll
> disable the charging while maintaining statistics - it's not a perfect, b=
ut
> likely the best option here. In the second case we need collectively fix =
it
> for cgroup v2.
>

Thank you for your advice. Currently, we do not have any immediate
plans to migrate to cgroup v2. If we are required to use cgroup v2 in
the future, we will need to maintain non-upstream patches.

By the way, is there any reason we cannot keep this behavior
consistent with memcg v1 in the upstream kernel? That would save us
from having to maintain it locally.

--=20
Regards
Yafang

