Return-Path: <linux-kernel+bounces-180605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1428A8C70B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 05:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9AB284015
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73264696;
	Thu, 16 May 2024 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6L2Vri1"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B784411
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715830596; cv=none; b=tosIdDRzzPDvM0BVnie9FQUCFkQlME+pAQ00L55ICUaQiWiR2K8xq1VRvfrMwd5E5H7Ni3oXi6DQJc4jPf5PsSlAtmK+suRMyWeBcvQ/c4QsboADoDnCNi13av1O70LQRe3eq0ibYLrmoeC3+OWCSMmyeGsR3Lcy8GRJnwZE+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715830596; c=relaxed/simple;
	bh=/O3JjSXdLRgsmm7VItmCafT7/DOhUzW48/cbes8EzX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsC0V/Yc/biYPtmPhlXHt696I8WHbsIhh2beaRQ+MYe+vh5Z4BcbKeMvw270/L235u65dboAYmWpTasCbwp9Mnc/jxyNE4J2ok13BuxX1l/dujlzwRWNpFqqKP4IycyHauwaGaLeEA2fKnmyJ6wPAO+II1PAWjw4Di+Cwkg/2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6L2Vri1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a077a861e7so54275286d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715830594; x=1716435394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWc8JJQxlxGEETOHoMDodWpK/v1HjwSNgwsdZCmzeV0=;
        b=T6L2Vri1iCd0UzX4NKiimB88fvS07ohthxLL0ITDW+Ioc1nZUH8i1BXjeUXDXxm80c
         oQKqRhr++oYSVQyFRR5u+S53sUR2uUjTH3QCtKcUDlws4uVxFIJVp28/xzZlFkOzZ6ya
         SkpWnX0ZNaS6FnPyZz34lWz+Wtj7ZAZIc6NiD8N4wIxvsIjLq9AESnYqSvlREQUHlwn4
         9tdzILgBnY8xh/I/DIuaMgotkJtoGciirowk3njFE2xsQ8vp2YvXjww0VtXCvfSSG6PE
         moxcMjF4f9ZDJnjU3+hx0gyFqGqL07azdPdOpP3VRkUmSoZixaZ7d3bQKaevHj7bVrqX
         xuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715830594; x=1716435394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWc8JJQxlxGEETOHoMDodWpK/v1HjwSNgwsdZCmzeV0=;
        b=GTOSf31/n/kWca79slFeK6aUaS29/ds3pRyPKP3rwwRoch35EWiqOFrhdPIf/FfEs4
         8DM97QEMv4tumJTDeWXq0ngj9y/Wb/EFY2B6Sm7YJ2dmE+uJtbDSMReogFyIrbK26C0y
         T5ixoXnaudBvLAt03y4mdYOsWuCpuGZKpHOw45dT8nHaQUVmGNdbNDstq12tbJmDiWpJ
         2uLnA7iwR9cZnDnRkYNvPSNSR6CvBkzgnUItjrUEcDw35gQ9T2/u34QnltyNpciXX4iQ
         6jjlt8gVrsX8e43B1R/hEbUIJh3kbDBOLrawD3CvgMvxAC/VZ9+GTaFXOx5hugNjExez
         U47A==
X-Forwarded-Encrypted: i=1; AJvYcCUrY5iO2lwDEtyonvgYGnKT7toMtKYBcmDY2sClZZVu5LJZFL9KGIw5x5N1MhTG5+6a3oGFE1x1BfZlroKa7RE/+BBDo9T/OomFYDba
X-Gm-Message-State: AOJu0YzcESj2PFvDT73ZkdvZ3+4hLH5KT0suzvnfxB9u4ZI5cIG+NDBv
	pkJpduHSkLobw1gwbZwjIAxEBSHaFRZfS9J++G6n/cB9SckawwAOagA72vEts53uY6wOavZFg6r
	5jNTy3b5qmMn4fddSMC3n9nwWl8A=
X-Google-Smtp-Source: AGHT+IHWOwFNDVSCskdy4Caj7SrKTUmz/j6xyhyvlFvAIJH32D+C3DzVnIl2uW9iwMKW8KwonaWTOxkRCPZK4xUq/oQ=
X-Received: by 2002:a05:6214:5a07:b0:6a0:d3ef:2a7e with SMTP id
 6a1803df08f44-6a16825bd31mr246840826d6.61.1715830594239; Wed, 15 May 2024
 20:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev> <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
In-Reply-To: <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 May 2024 11:35:57 +0800
Message-ID: <CALOAHbC0AATe5iMAm84Y_obOs4ePZYEW3X2a2OmjTCt_A3xXMQ@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gthelen@google.coma, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:33=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > Cgroups v2 have been around for a while and many users have fully adopt=
ed them,
> > so they never use cgroups v1 features and functionality. Yet they have =
to "pay"
> > for the cgroup v1 support anyway:
> > 1) the kernel binary contains useless cgroup v1 code,
> > 2) some common structures like task_struct and mem_cgroup have never us=
ed
> >    cgroup v1-specific members,
> > 3) some code paths have additional checks which are not needed.
> >
> > Cgroup v1's memory controller has a number of features that are not sup=
ported
> > by cgroup v2 and their implementation is pretty much self contained.
> > Most notably, these features are: soft limit reclaim, oom handling in u=
serspace,
> > complicated event notification system, charge migration.
> >
> > Cgroup v1-specific code in memcontrol.c is close to 4k lines in size an=
d it's
> > intervened with generic and cgroup v2-specific code. It's a burden on
> > developers and maintainers.
> >
> > This patchset aims to solve these problems by:
> > 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c f=
ile,
> > 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into =
the
> >    mm/internal.h header
> > 3) introducing the CONFIG_MEMCG_V1 config option, turned on by default
> > 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set
> > 5) putting unused struct memory_cgroup and task_struct members under
> >    CONFIG_MEMCG_V1 as well.
> >
> > This is an RFC version, which is not 100% polished yet, so but it would=
 be great
> > to discuss and agree on the overall approach.
> >
> > Some open questions, opinions are appreciated:
> > 1) I consider renaming non-static functions in memcontrol-v1.c to have
> >    mem_cgroup_v1_ prefix. Is this a good idea?
> > 2) Do we want to extend it beyond the memory controller? Should
> > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> >    mm/internal.h? Or mm/memcontrol-v1.h.
> >
>
> Hi Roman,
>
> A very timely and important topic and we should definitely talk about it
> during LSFMM as well. I have been thinking about this problem for quite
> sometime and I am getting more and more convinced that we should aim to
> completely deprecate memcg-v1.
>
> More specifically:
>
> 1. What are the memcg-v1 features which have no alternative in memcg-v2
> and are blocker for memcg-v1 users? (setting aside the cgroup v2
> structual restrictions)
>
> 2. What are unused memcg-v1 features which we should start deprecating?
>
> IMO we should systematically start deprecating memcg-v1 features and
> start unblocking the users stuck on memcg-v1.
>
> Now regarding the proposal in this series, I think it can be a first
> step but should not give an impression that we are done. The only
> concern I have is the potential of "out of sight, out of mind" situation
> with this change but if we keep the momentum of deprecation of memcg-v1
> it should be fine.
>
> I have CCed Greg and David from Google to get their opinion on what
> memcg-v1 features are blocker for their memcg-v2 migration and if they
> have concern in deprecation of memcg-v1 features.
>
> Anyone else still on memcg-v1, please do provide your input.

Hi Shakeel,

Hopefully I'm not too late.  We are currently using memcg v1.

One specific feature we rely on in v1 is skmem accounting. In v1, we
account for TCP memory usage without charging it to memcg v1, which is
useful for monitoring the TCP memory usage generated by tasks running
in a container. However, in memcg v2, monitoring TCP memory requires
charging it to the container, which can easily cause OOM issues. It
would be better if we could monitor skmem usage without charging it in
the memcg v2, allowing us to account for it without the risk of
triggering OOM conditions.


--=20
Regards
Yafang

