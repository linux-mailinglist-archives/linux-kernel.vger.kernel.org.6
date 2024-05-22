Return-Path: <linux-kernel+bounces-186583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391198CC5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84341F2247F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC35145A11;
	Wed, 22 May 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFsEC2S7"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBA46AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400749; cv=none; b=orpPohSrmTaMBTAw2bcoEXJs2T0bkTZdkHBvj/QRlUKVYqDTMaHgbe3wSQ5ciAAeC32HFSfyiDFacHwEwqOMmQzjyfkWiais/tQXecpiva8RsX7idNw28vCVizWRzvofLx7Hl8Bzz/EgIzHc5xEiKSOFo5NkTLMHiAArBKnuFVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400749; c=relaxed/simple;
	bh=SOWOHYqG1LF8X0cgojVEeC1HbwnHu0BnpdcaFoYtpOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKM+0awh70Mk5S7ixd50f4OOMwpoDrNrOSfheTMbSnUTm/IXwiIhvyhTEot8JR9ZAGePDrYLgTNQRioGTnbn4QTysrTBYlMRrKcPi0isNY504nvEhDptV1jqmLUiDmaa3cRtrng5rnN4evLWg7LuW9H16Nj9OC2/sMWrgyCLhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFsEC2S7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e716e302bdso48018981fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716400746; x=1717005546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkY2zCKj0rH560r132+SkB6lM4KVc9auRQua4/wMef4=;
        b=aFsEC2S7meCNWtmpXrN7exr9tJftghqlQ5hVkFPgzkkp9UAIct3+t2uLfhUO9JiPg9
         UznwjysD3m+A1IpMkrOl2Iy2FD0uoYc+oSlay3DboX0a054Mnv6JjVAuTui6GuKusz/T
         WTboyY0BUpVg/R7XWlwOKkXttAc9Hr0Ayg7Tue6tXvneQDyd2XJ3Zr1WBUiiC+ohFjHp
         xLsxLCLR/X8Dai+lQMGEkTn0Gbw2mg+fdRQEqOsqIkykWZ3QCqSkIkMrVIous16Ozrf9
         LOb0Tt61Sf2MQCx9Ks1WO9S9oUBIzzThjrIFENTMdLSGh23Dn6xQakzIqXQyQa5GMu+q
         6svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400746; x=1717005546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkY2zCKj0rH560r132+SkB6lM4KVc9auRQua4/wMef4=;
        b=q9Fz11MU3iZs5brnkiKxhIM8Sg5XY3bENzMujvXPm7/zl1AkTRouoTXemKJ1pLMSiW
         v57bzeHTULNBqLeeI4POb6Jcj68Wsa1iCbnh8TSYP6KF67YjxpOEgkbCAYwha7U+/+Ay
         0BrAqFZ1f+oNqyrAdB6K5YwYukRduPbLxHduJtcr3+aNVyTSlawBL6Dra1Tr5U9c5dz5
         CaE72rWwuOsBv5us4uEAW+Msdj5FZxoWhgUGUyD0XU+cjozlsZknT4pZnu3VbD21sfcy
         GFLoPj544rB/AjyBJrMLZl0qItvufBkiXMVA2T1B4k6Gjap4P/kH8KDmpl84mvVcAX1K
         E38A==
X-Forwarded-Encrypted: i=1; AJvYcCWQLDxjBO95F9y9n8yEdiu/JgQWrRoRlzzuyJQMc2Zyb3gbXAwm18Bt//nVNqeAbzzredlO4721dnZLQKf4yOQKXw6MOQdKpszq+lxi
X-Gm-Message-State: AOJu0YzSKoh9iEmTEiI0m3z4JIkgbk6Ki4xME1Sv1EpX9VvHVCGr+jzX
	tz/H0WDTAPtVOeGOpzG2NiIBO++g2huVPiUL1LWAiJk6Fc0KCW+6Cv8BeUXAIQhUdpxcI+qngg9
	0Zi7WIo47y4KPtuOLBGUMWWMsjsRRNhml/C8=
X-Google-Smtp-Source: AGHT+IGp6atU+fl+TD0KSvFFSZu3dqO1SHwmise3SbvYgZ7eIk4FgRYkgFDVVUfHepH47yUMfDgV/D5f88YVVCMnTHY=
X-Received: by 2002:a2e:b043:0:b0:2e5:685a:cd24 with SMTP id
 38308e7fff4ca-2e949583e90mr16371131fa.6.1716400745826; Wed, 22 May 2024
 10:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509034138.2207186-1-roman.gushchin@linux.dev> <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
In-Reply-To: <jf44dfyaenz6xmn2hcodaginrshw5d5hfhmakdxtj4x6szk6b2@cr2rxamkgj2m>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 23 May 2024 01:58:49 +0800
Message-ID: <CAMgjq7ARr0=OG8GQOJvzLtfdrtiwvJ19-mx1snxqmLE0Za+QCw@mail.gmail.com>
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and put
 under config option
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gthelen@google.coma, rientjes@google.com, 
	Chris Li <chrisl@kernel.org>
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
>

Hi,

Sorry for joining the discussion late, but I'd like to add some info
here: We are using the "memsw" feature a lot. It's a very useful knob
for container memory overcommitting: It's a great abstraction of the
"expected total memory usage" of a container, so containers can't
allocate too much memory using SWAP, but still be able to SWAP out.

For a simple example, with memsw.limit =3D=3D memory.limit, containers
can't exceed their original memory limit, even with SWAP enabled, they
get OOM killed as how they used to, but the host is now able to
offload cold pages.

Similar ability seems absent with V2: With memory.swap.max =3D=3D 0, the
host can't use SWAP to reclaim container memory at all. But with a
value larger than that, containers are able to overuse memory, causing
delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
out of balance, especially with compress SWAP backends.

Cgroup accounting of ZSWAP/ZRAM doesn't really help, we want to
account for the total raw usage, not the compressed usage. One example
is that if a container uses tons of duplicated pages, then it can
allocate much more memory than it is limited, that could cause
trouble.

I saw Chris also mentioned Google has a workaround internally for it
for Cgroup V2. This will be a blocker for us and a similar workaround
might be needed. It will be great so see an upstream support for this.

