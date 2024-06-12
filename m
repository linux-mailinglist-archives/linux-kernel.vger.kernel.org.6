Return-Path: <linux-kernel+bounces-212129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615F905B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16641C20E77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E562354656;
	Wed, 12 Jun 2024 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/R0ZZd3"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D756458
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218382; cv=none; b=ntJyqY8FdOXxowWECkVv5dUP2JzSUPIXv5ZVUrNWWJwdHatWwIsEErzhNa0TabV2syCbABOzIkm8cTgqJsNVFvVAczogOiMKIaQozp6Vo46VTLH5pWaB56NXjoPTUOA6mKm6/iLotlNSF0OPI5V/Yel+Q52s0uZ7DBRKFBANDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218382; c=relaxed/simple;
	bh=Mx63kqsX0cNxEp4M5wCZ4rB59bMKuwcFcoHXXPXxxls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKI5XNti87Xzdjd7Hld/iSCq64gS8p3cIS23dnsubL5NeZG5QTt5hSsEnSON+V6eEcFGCW4TwC+Ov/h0l1H6HvbA+LpZDWcpAl+SpNp23XnMrTI2A5uB2OOqUHGV1fQ8KI4awLMLgpdk1k3Ik1AGIhQ0SPddQFioAq2Qb6ORtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/R0ZZd3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-422954bbe29so16705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718218379; x=1718823179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHj6xE+blgxanzI7GEmQ5ONKrZIlqCxdF5mf56MUn2o=;
        b=Z/R0ZZd3lmnmro+nyeEqsbf5rziEr2qblGw6hNtHu5O17fg3vKeL18wqsmHCmkd3ZY
         xLuAfVdSzY/gRzNm/Vj1ec+YOwEyeVQfRxXKLlWEI/TV91hIZLkKAsQ8ryPDl0q9aG4u
         eLqIXqQWoBShi+fSA/qCszeqBsp1vPqhQIAkB+mU63qzbcw1T25se0+o1q9gsWgWGfyD
         OTQLw+GHnHVo3UExdK6wUsPWLD5WQVNkS42OxwD7BZjfQnQ/IE+dSiyvhofvSCDTg29J
         84hkAQV+D41KbermQDQ1Z+ZNc1dQOrxd5SUiYSDU1gCtB1/JeUHBHwty6n4b8WsInsHW
         +Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218379; x=1718823179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHj6xE+blgxanzI7GEmQ5ONKrZIlqCxdF5mf56MUn2o=;
        b=qYrTcjqMgxqMXQ+8EY9VxKCuIYxSwOZYccLUuI8pyBaS29K++oGl0Qn2fLJp8e+osH
         124+bnkrvwajARR0tmBCD7CYLy1n+SZY8ed6RRRbaGPrcWGVenq69boB497CffErmrs6
         prXElosqwZnwgMZVFzxWQ0jHuOBiNWiHGnJ9HMTs4JjGVouFlrJhlVj6pDYWhDaoxGu8
         XDz8m5CpoM06AdmJLCdsf8ORUlf2OBRP8X8PRnkac11/ETte1oOpAoXemPqWEWcn7LWI
         5xcWe+oIN/fCOc5zhJxkfEJ03tRWfhrtLr1615ThCNp8cpAug+pvdgs6B8SJ94L2cm9M
         Jrnw==
X-Forwarded-Encrypted: i=1; AJvYcCVY8tMtKGoXIlczMGcbKRKXaozsbdUjEcxiekSnyEmRsHK6DFYWWDLKY1MsTKuauryJU8UfscFnMzcVQZ7FuYn/8vm/CEIqQaylXQYh
X-Gm-Message-State: AOJu0YycbJskhvmx91xfy01dP1DW5+b9tYWLU2KjY9eNWRvdmKgF7zfk
	QbVtZwEsfLtJPQcjYOhy4T2rSV3BF2u0+p1O/D39ippQ1RzUvYM5C70LwT7r16WbjbE4MYt2Jm9
	yxzT8/7KGey30GqJ5faHxUPQciKwwYyEzNOd0
X-Google-Smtp-Source: AGHT+IGWbqAdYR4vbSlGA7ZFpR5iRtpbOhPa7aMWCCQaLjEECiNxENnq5lCtbed8sr52I7+CS/e9DcTTxYtrWgyEufg=
X-Received: by 2002:a05:600c:1e2a:b0:422:d37:e9f6 with SMTP id
 5b1f17b1804b1-422d4c53a6fmr221485e9.1.1718218378467; Wed, 12 Jun 2024
 11:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320180429.678181-1-hannes@cmpxchg.org> <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
 <20240513160331.GA320190@cmpxchg.org> <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>
 <20240513190400.GA2270702@cmpxchg.org> <CAOUHufb8Daf276SdA2L=fq=LeAWN-JE08F5zW3buC1CBAoS=Ww@mail.gmail.com>
 <20240610152833.GA2298848@cmpxchg.org>
In-Reply-To: <20240610152833.GA2298848@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 12 Jun 2024 12:52:20 -0600
Message-ID: <CAOUHufaWTaeNXDimGFrQhe87JHkGrcnS3ZLBPSxiF3j2F=HibA@mail.gmail.com>
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: multipart/mixed; boundary="00000000000018d93d061ab5e459"

--00000000000018d93d061ab5e459
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 9:28=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jun 04, 2024 at 10:53:55PM -0600, Yu Zhao wrote:
> > On Mon, May 13, 2024 at 1:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > > On Mon, May 13, 2024 at 12:10:04PM -0600, Yu Zhao wrote:
> > > > On Mon, May 13, 2024 at 10:03=E2=80=AFAM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > > On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> > > > > > This series significantly regresses Android and ChromeOS under =
memory
> > > > > > pressure. THPs are virtually nonexistent on client devices, and=
 IIRC,
> > > > > > it was mentioned in the early discussions that potential regres=
sions
> > > > > > for such a case are somewhat expected?
> > > > >
> > > > > This is not expected for the 10 patches here. You might be referr=
ing
> > > > > to the discussion around the huge page allocator series, which ha=
d
> > > > > fallback restrictions and many changes to reclaim and compaction.
> > > >
> > > > Right, now I remember.
> > > >
> > > > > > On Android (ARMv8.2), app launch time regressed by about 7%; On
> > > > > > ChromeOS (Intel ADL), tab switch time regressed by about 8%. Al=
so PSI
> > > > > > (full and some) on both platforms increased by over 20%. I coul=
d post
> > > > > > the details of the benchmarks and the metrics they measure, but=
 I
> > > > > > doubt they would mean much to you. I did ask our test teams to =
save
> > > > > > extra kernel logs that might be more helpful, and I could forwa=
rd them
> > > > > > to you.
> > > > >
> > > > > If the issue persists with the latest patches in -mm, a kernel co=
nfig
> > > > > and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
> > > > > before/during/after the problematic behavior would be very helpfu=
l.
> > > >
> > > > Assuming all the fixes were included, do you want the logs from 6.8=
?
> > > > We have them available now.
> > >
> > > Yes, that would be helpful.
> > >
> > > If you have them, it would also be quite useful to have the vmstat
> > > before-after-test delta from a good kernel, for baseline comparison.
> >
> > Sorry for taking this long -- I wanted to see if the regression is
> > still reproducible on v6.9.
> >
> > Apparently we got the similar results on v6.9 with the following
> > patches cherry-picked cleanly from v6.10-rc1:
> >
> >      1  mm: page_alloc: remove pcppage migratetype caching
> >      2  mm: page_alloc: optimize free_unref_folios()
> >      3  mm: page_alloc: fix up block types when merging compatible bloc=
ks
> >      4  mm: page_alloc: move free pages when converting block during is=
olation
> >      5  mm: page_alloc: fix move_freepages_block() range error
> >      6  mm: page_alloc: fix freelist movement during block conversion
> >      7  mm: page_alloc: close migratetype race between freeing and stea=
ling
> >      8  mm: page_alloc: set migratetype inside move_freepages()
> >      9  mm: page_isolation: prepare for hygienic freelists
> >     10  mm: page_alloc: consolidate free page accounting
> >     11  mm: page_alloc: change move_freepages() to __move_freepages_blo=
ck()
> >     12  mm: page_alloc: batch vmstat updates in expand()
> >
> > Unfortunately I just realized that that automated benchmark didn't
> > collect the kernel stats before it starts (since it always starts on a
> > freshly booted device). While this is being fixed, I'm attaching the
> > kernel stats collected after the benchmark finished. I grabbed 10 runs
> > for each (baseline/patched), and if you need more, please let me know.
> > (And we should have the stats before the benchmark soon.)
>
> Thanks for grabbing these, and sorry about the delay, I was traveling
> last week.
>
> You mentioned "THPs are virtually non-existant". But the workload
> doesn't seem to allocate anon THPs at all.

Sorry for not being clear there: you are correct.

I meant that client devices rarely use 2MB THPs or __GFP_COMP. (They
simply can't due to both internal and external fragmentations, but we
are trying!)

> For file THP, the patched
> kernel's median for allocation success is 90% of baseline, but the
> inter-run min/max deviation from the median in baseline is 85%/108%
> and in patched and 85%/112% in patched, so this is quite noisy. Was
> that initial comment regarding a different workload?

No, in both cases (Android and ChromeOS) we tried, we were hoping the
series could help with mTHP (64KB and 32KB). But we hit the
regressions with their baseline (4KB). Again, 2MB THPs, if they are
used, are reserved (allocated and mlocked to hold text/code sections
after a reboot). So they shouldn't matter, and I highly doubt the
regressions are because of them.

> This other data point has me stumped. Comparing medians, there is a
> 1.5% reduction in anon refaults and a 4.8% increase in file
> refaults. And indeed, there is more files and less anon being scanned.
> I think this could explain the PSI delta, since AFAIK you have zram or
> zswap, and anon decompression loads are cheaper than filesystem IO.
>
> The above patches don't do anything that directly influences the
> anon-file reclaim balance. However, if file THPs fall back to 4k file
> pages more, that *might* be able to explain a shift in reclaim
> balance, if some hot subpages in those THPs were protecting colder
> subpages from being reclaimed and refaulting.
>
> In that case, the root cause would still be a simple THP success rate
> regression. To confirm this theory, could you run the baseline and the
> patched sets both with THP disabled entirely?

Will try this. And is bisecting within this series possible?

> Can you elaborate more on what the workload is doing exactly?

These are simple benchmarks that measure the system and foreground
app/tab performance under memory pressure, e.g., [1]. They open a
bunch of apps/tabs (respectively on Android/ChromeOS) and switch
between them. At a given time, one of them is foreground and the rest
are background, obviously. When an app/tab has been in the background
for a while, the userspace may call madvise(PAGEOUT) to reclaim (most
of) its LRU pages, leaving unmovable kernel memory there. This
strategy allows client systems to cache more apps/tabs in the
background and reduce their startup/switch time. But it's also a major
source of fragmentation (I'm sure you get why so I won't go into
details here. And userspace also tries to make a better decision
between reclaim/compact/kill based on fragmentation, but it's not
easy.)

[1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/+/refs=
/heads/main/src/go.chromium.org/tast-tests/cros/local/bundles/cros/platform=
/memory_pressure.go

> What are
> the parameters of the test machine (CPUs, memory size)? It'd be
> helpful if I could reproduce this locally as well.

The data I shared previously is from an Intel i7-1255U + 4GB Chromebook.

More data attached -- it contains vmstat, zoneinfo and pagetypeinfo
files collected before the benchmark (after fresh reboots) and after
the benchmark.

--00000000000018d93d061ab5e459
Content-Type: application/x-xz; name="log.tar.xz"
Content-Disposition: attachment; filename="log.tar.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_lxc6u1o30>
X-Attachment-Id: f_lxc6u1o30

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
xGf7AgAAAAAEWVo=
--00000000000018d93d061ab5e459--

