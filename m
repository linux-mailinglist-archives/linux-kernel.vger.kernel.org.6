Return-Path: <linux-kernel+bounces-168891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6078BBF52
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6963AB21104
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72C33D8;
	Sun,  5 May 2024 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXewCOpK"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1081869
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714886790; cv=none; b=g/M51nNb4AJQGDqEPOqWSJw7BJTy6rpwCqX7YnkpEaQdxp5HusbtWyg8Qj4kzWvBg6/K6MW0RB2BFTIDYB9QH9HxVVrhtWmFuzFRA4pT5733sSQDS4cOACq/GjXcrjzpBqnxpg8ix+5GILaD1hWs7K8dF+ZQtefdie3zqEI/Eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714886790; c=relaxed/simple;
	bh=aIicpjFZ9Th/Wo46DDLxYWOsLnOy7PMn1pzOwCFTXwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAPw4a+ddM6Y2y++xrHcNS/QdSXyYhDLBc2fQVfz6RULDnIpQjPFxb+bDkRWddGQd7VfBdZNKaPCUxw3bjCXxMMLb5e6S2sW11LIJwuxyJaHPsL3ey3WyG4ev6JwJjkoZaxWrH/vaYqzK6hd28huTFICnx4Ue7mInN8bTQiLnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXewCOpK; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436ed871225so221121cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714886788; x=1715491588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb/EPhjcbAC4KAB4gdgqUAeq8oCgWvlhJ9vOj/P63R8=;
        b=DXewCOpK9oHYpbuYDG7+0MOuSEZFOin+bFs7/Qrh9T1cue1SRIf5xKwClhK6kCrh06
         FOCz7/50MQtDa60hmkakTMjIyVQKV8TyfQShDp2VAT4mqKbF/TFbm97WoPiak6a6+328
         jjDGW2xvdHQplrZB0XsFBSQLl4dww6yyGVYMxO4mzacl9B7RjMVUhEzIpbcg58aYEXwW
         4y8RlbyAjEqI7DOJd6rU+HsDER4SGY+o4vvsT+dXKKYvRbi0POHOZjxxEQeerr0RMcny
         e3EJUlwBrU/Zfv49JDT/OiXavUSoFUgzyegALAeC0SkAjuLNSX79IjMDMxlstD0EzzkI
         YPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714886788; x=1715491588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb/EPhjcbAC4KAB4gdgqUAeq8oCgWvlhJ9vOj/P63R8=;
        b=JoDm6bRDeDlpHY0RjwJEUhwSPNA9/DWvjS4OwNvE8nigXkHeFwQe12KaK60P3KCgy7
         0sYXAy9TnmYhilaaw+XGkkwMzvmDLtsQrkVgLiE8ghNC89mdeM5DArrs7xu6lxz3xwSr
         Yg7dJrwFfEODmCw9M4QfNVpV5hyBIV6dMbLksfKuMWRjFriNBsLoxopr5M50I6WvUiT1
         zyraMpeBZKUw0UiDRqRcQcbnghSoXIUpmYztwo9Pn+jZmu6DWTn1WGQS45VFaq7W/arM
         Ew0YMmH2RsmzsUnFbExlooMwiw4kCLPij31DkVe8ALz60U1buM22qeubIlNs3enXnaTy
         BTLw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjvtZ79JaWeepTCBx5GfPZMCS0hH0uH9EpoHDCdSuvG1H4RYvOVobMZ6x/5PFJ3T0i3UytYrDya2wZAFBhrNvprewjvSqG6MEUAFf
X-Gm-Message-State: AOJu0YzhzFNTwbcV+mqhhx4KZgmxtBJqsBLwHzuL7Bp7VNOrfTkhTgv5
	AJAv59RmOZLnCgRRQTdu+FoxhGS5SNEbjqOWoyYQ2q+hE1dc67D1Tv4w4yym003nJArBDQDG24/
	BDueY4UeJDjcRtGs+FFvT5XE9bn0gcjncUeVv
X-Google-Smtp-Source: AGHT+IG/zlrczb1H5X6lo6ctQdhFV8VmRyTeunZU4W3zP3ofbT54pBnHB9dhcXJHuB/0kmY7mhPIE4g+wjaH12P2Sn4=
X-Received: by 2002:a05:622a:1305:b0:43a:2e2b:eec with SMTP id
 d75a77b69052e-43d030b28f1mr2462581cf.2.1714886787525; Sat, 04 May 2024
 22:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org>
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 May 2024 22:26:16 -0700
Message-ID: <CAP-5=fV+K9-ggiaPR7xTVP2p=enLZf0ARBcjb4QG+7kv-00q7w@mail.gmail.com>
Subject: Re: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 5:30=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Implement binary ioctl()-based interface to /proc/<pid>/maps file to allo=
w
> applications to query VMA information more efficiently than through textu=
al
> processing of /proc/<pid>/maps contents. See patch #2 for the context,
> justification, and nuances of the API design.
>
> Patch #1 is a refactoring to keep VMA name logic determination in one pla=
ce.
> Patch #2 is the meat of kernel-side API.
> Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
> Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/ma=
ps to
> optionally use this new ioctl()-based API, if supported.
> Patch #5 implements a simple C tool to demonstrate intended efficient use=
 (for
> both textual and binary interfaces) and allows benchmarking them. Patch i=
tself
> also has performance numbers of a test based on one of the medium-sized
> internal applications taken from production.
>
> This patch set was based on top of next-20240503 tag in linux-next tree.
> Not sure what should be the target tree for this, I'd appreciate any guid=
ance,
> thank you!
>
> Andrii Nakryiko (5):
>   fs/procfs: extract logic for getting VMA name constituents
>   fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
>   tools: sync uapi/linux/fs.h header into tools subdir
>   selftests/bpf: make use of PROCFS_PROCMAP_QUERY ioctl, if available
>   selftests/bpf: a simple benchmark tool for /proc/<pid>/maps APIs

I'd love to see improvements like this for the Linux perf command.
Some thoughts:

 - Could we do something scalability wise better than a file
descriptor per pid? If a profiler is running in a container the cost
of many file descriptors can be significant, and something that
increases as machines get larger. Could we have a /proc/maps for all
processes?

 - Something that is broken in perf currently is that we can race
between reading /proc and opening events on the pids it contains. For
example, perf top supports a uid option that first scans to find all
processes owned by a user then tries to open an event on each process.
This fails if the process terminates between the scan and the open
leading to a frequent:
```
$ sudo perf top -u `id -u`
The sys_perf_event_open() syscall returned with 3 (No such process)
for event (cycles:P).
```
It would be nice for the API to consider cgroups, uids and the like as
ways to get a subset of things to scan.

 - Some what related, the mmap perf events give data after the mmap
call has happened. As VMAs get merged this can lead to mmap perf
events looking like the memory overlaps (for jits using anonymous
memory) and we lack munmap/mremap events.

Jiri Olsa has looked at improvements in this area in the past.

Thanks,
Ian

>  fs/proc/task_mmu.c                            | 290 +++++++++++---
>  include/uapi/linux/fs.h                       |  32 ++
>  .../perf/trace/beauty/include/uapi/linux/fs.h |  32 ++
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/procfs_query.c    | 366 ++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.c      |   3 +
>  tools/testing/selftests/bpf/test_progs.h      |   2 +
>  tools/testing/selftests/bpf/trace_helpers.c   | 105 ++++-
>  9 files changed, 763 insertions(+), 70 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/procfs_query.c
>
> --
> 2.43.0
>
>

