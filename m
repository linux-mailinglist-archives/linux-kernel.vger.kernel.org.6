Return-Path: <linux-kernel+bounces-213554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC91A9076D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16D41C2422B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED812DDAB;
	Thu, 13 Jun 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KAKMpKF5"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFBD12D762
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293176; cv=none; b=WvHFp0V59urGrqlsH5xV0OqTW3N6bmBGuigZ3CJjivrlxr8Arn41sva0/QMc5NgdRDo6zCpelGJfYYKbKgfhUWGTVYvq1TkBpI6kYUYmjq/Ms9w3HjYIwO57fX8ToWCe9kYjB0F1fiWFWLoUV9+t5Q6NqnxBkogI4OHZLaWLG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293176; c=relaxed/simple;
	bh=nl65yuCVbL4gwAu3giZOxoyFAKY9n/pBDDU0q+Aquic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNA9g8q6w7kZgYvibGvPRhhLqFwUPQTuoEMYdRKIaweZY2aI1NGcxpP6+/7x0W2MhND48ZIm1GEHMZBOO7wR5+v/crZEXzJJIZ6a55x0QMaRtPW3tUNXgloAjYcm4u+bpNZExFgt9GvXHI+rRlBsYa0wJIzNGWPLl967eAsZyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KAKMpKF5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44052a479c0so5804241cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1718293171; x=1718897971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LfFFJbbjt06WvTRyHaJEe4S3TUky/i2t+Fxf91/8534=;
        b=KAKMpKF5Ywn6wcuzyKYVj8nwiCU4ov+tEgW8Zwy9FG1x88FXotH8Cf2aaSqqmvRsrs
         V8je0/DfDSpsj5H0H6gCAD+QBFI4/wk+sTKLZZjUdwtOlbGywMlhno35L466IgyVsJq7
         mHvse01p0tlfemIOr5ZrwuEGl2oDlfbnZSfl+PInFGMKmZN9XfJxMo7ZDZfrUn1fgyOb
         MEFo4Mg3DJx880RUE5bNsWg1ip+54kb+QtDsYWOsI5e5TcqTmsdpNCBEbti7McQzJtwW
         X+sWqfPBxTR++lrXEW8bW5t/nWJZOlNtPQkrNaLU6tNdycHEfraEKNNMsaBIMDNezhsW
         lazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293171; x=1718897971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfFFJbbjt06WvTRyHaJEe4S3TUky/i2t+Fxf91/8534=;
        b=bAmNQdYWFnxL9LcGU1ZuTwt2LXf4BJCeYDRiFWP9wSOODO/imaxm+5OClHoW5ABPhq
         whN38E2hy7aHeLm+AKrkOmuJ6GTyDuZwG/fM4lekrY+bTORDAT68J945zMWjgGy3u9Jh
         eSedLkNtdybbzg/HDzV0a+9gXudRndXgKBBDfbnkmDhDfZ0j9G+VQSduuXdy8SGL1fDB
         AwJYGsYNpw26W3aXV8nwop/r8AXc1IO6zSfMjPYQxuEArDHuXdOF8ZPhqYslsv5YMKLx
         8qBIOH+e6PJmambgm0VcR8gYRHHdhJSLrjz5UMSgFlLTD25AlfFJeKARsxle8GgPEzoQ
         p/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5K6muXy2vFb8H8NkQ6ZuY7AgrxJUocEyABsAfGkKPkQGqOPL9shgwrUO+nbV7VJJdVIH6viubfbGUqjHjTaC7yiy+t1rsCHARHQ8L
X-Gm-Message-State: AOJu0YxBLow3yNJsVu7jeIHdcPKU2FcuNAcIWgvmCkDOaRXd+l0+MVPe
	eopDGd6DyrzRvIwNM6Rnum8ho4485RjKYTXSpnIHfWjDeF8yYMmGoInJnHq1NfQ=
X-Google-Smtp-Source: AGHT+IHkHZGyR1BYfTJR6VsOeOw3QifqwLesRT/kRKpCw5I75fGyV1derufnQITPgcQ6NVOuhug7zw==
X-Received: by 2002:ac8:5e51:0:b0:441:5704:af5a with SMTP id d75a77b69052e-4415ac97b43mr48926601cf.46.1718293171255;
        Thu, 13 Jun 2024 08:39:31 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4eefaesm7177721cf.21.2024.06.13.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:39:30 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:39:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
	Chun-Tse Shao <ctshao@google.com>
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20240613153924.GA3168233@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <CAOUHufbOP-RLmxmG_7Dp1vWAz8TTHvbmyfuR_mtceg0KgZoSnA@mail.gmail.com>
 <20240513160331.GA320190@cmpxchg.org>
 <CAOUHufaCQPW=p_r-Sg4oeDgtxwEGp6E5j1MhU3OCrTLUZTymZA@mail.gmail.com>
 <20240513190400.GA2270702@cmpxchg.org>
 <CAOUHufb8Daf276SdA2L=fq=LeAWN-JE08F5zW3buC1CBAoS=Ww@mail.gmail.com>
 <20240610152833.GA2298848@cmpxchg.org>
 <CAOUHufaWTaeNXDimGFrQhe87JHkGrcnS3ZLBPSxiF3j2F=HibA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufaWTaeNXDimGFrQhe87JHkGrcnS3ZLBPSxiF3j2F=HibA@mail.gmail.com>

On Wed, Jun 12, 2024 at 12:52:20PM -0600, Yu Zhao wrote:
> On Mon, Jun 10, 2024 at 9:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Jun 04, 2024 at 10:53:55PM -0600, Yu Zhao wrote:
> > > On Mon, May 13, 2024 at 1:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > On Mon, May 13, 2024 at 12:10:04PM -0600, Yu Zhao wrote:
> > > > > On Mon, May 13, 2024 at 10:03 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > > On Fri, May 10, 2024 at 11:14:43PM -0600, Yu Zhao wrote:
> > > > > > > This series significantly regresses Android and ChromeOS under memory
> > > > > > > pressure. THPs are virtually nonexistent on client devices, and IIRC,
> > > > > > > it was mentioned in the early discussions that potential regressions
> > > > > > > for such a case are somewhat expected?
> > > > > >
> > > > > > This is not expected for the 10 patches here. You might be referring
> > > > > > to the discussion around the huge page allocator series, which had
> > > > > > fallback restrictions and many changes to reclaim and compaction.
> > > > >
> > > > > Right, now I remember.
> > > > >
> > > > > > > On Android (ARMv8.2), app launch time regressed by about 7%; On
> > > > > > > ChromeOS (Intel ADL), tab switch time regressed by about 8%. Also PSI
> > > > > > > (full and some) on both platforms increased by over 20%. I could post
> > > > > > > the details of the benchmarks and the metrics they measure, but I
> > > > > > > doubt they would mean much to you. I did ask our test teams to save
> > > > > > > extra kernel logs that might be more helpful, and I could forward them
> > > > > > > to you.
> > > > > >
> > > > > > If the issue persists with the latest patches in -mm, a kernel config
> > > > > > and snapshots of /proc/vmstat, /proc/pagetypeinfo, /proc/zoneinfo
> > > > > > before/during/after the problematic behavior would be very helpful.
> > > > >
> > > > > Assuming all the fixes were included, do you want the logs from 6.8?
> > > > > We have them available now.
> > > >
> > > > Yes, that would be helpful.
> > > >
> > > > If you have them, it would also be quite useful to have the vmstat
> > > > before-after-test delta from a good kernel, for baseline comparison.
> > >
> > > Sorry for taking this long -- I wanted to see if the regression is
> > > still reproducible on v6.9.
> > >
> > > Apparently we got the similar results on v6.9 with the following
> > > patches cherry-picked cleanly from v6.10-rc1:
> > >
> > >      1  mm: page_alloc: remove pcppage migratetype caching
> > >      2  mm: page_alloc: optimize free_unref_folios()
> > >      3  mm: page_alloc: fix up block types when merging compatible blocks
> > >      4  mm: page_alloc: move free pages when converting block during isolation
> > >      5  mm: page_alloc: fix move_freepages_block() range error
> > >      6  mm: page_alloc: fix freelist movement during block conversion
> > >      7  mm: page_alloc: close migratetype race between freeing and stealing
> > >      8  mm: page_alloc: set migratetype inside move_freepages()
> > >      9  mm: page_isolation: prepare for hygienic freelists
> > >     10  mm: page_alloc: consolidate free page accounting
> > >     11  mm: page_alloc: change move_freepages() to __move_freepages_block()
> > >     12  mm: page_alloc: batch vmstat updates in expand()
> > >
> > > Unfortunately I just realized that that automated benchmark didn't
> > > collect the kernel stats before it starts (since it always starts on a
> > > freshly booted device). While this is being fixed, I'm attaching the
> > > kernel stats collected after the benchmark finished. I grabbed 10 runs
> > > for each (baseline/patched), and if you need more, please let me know.
> > > (And we should have the stats before the benchmark soon.)
> >
> > Thanks for grabbing these, and sorry about the delay, I was traveling
> > last week.
> >
> > You mentioned "THPs are virtually non-existant". But the workload
> > doesn't seem to allocate anon THPs at all.
> 
> Sorry for not being clear there: you are correct.
> 
> I meant that client devices rarely use 2MB THPs or __GFP_COMP. (They
> simply can't due to both internal and external fragmentations, but we
> are trying!)

Ah, understood. So this is nominally a non-THP workload, and we're
suspecting a simple 4k allocation issue in low memory conditions.

Thanks for clarifying.

However, I don't think 4k alone would explain pressure just yet. PSI
is triggered by reclaim and compaction, but with this series type
fallbacks are still allowed to the full extent before entering any
such remediation. The series merely fixes type safety and eliminates
avoidable/accidental mixing.

So I'm thinking something else must still be going on. Either THP
(however limited the use in this workload); or the userspace feedback
mechanism you mention below...

> > For file THP, the patched
> > kernel's median for allocation success is 90% of baseline, but the
> > inter-run min/max deviation from the median in baseline is 85%/108%
> > and in patched and 85%/112% in patched, so this is quite noisy. Was
> > that initial comment regarding a different workload?
> 
> No, in both cases (Android and ChromeOS) we tried, we were hoping the
> series could help with mTHP (64KB and 32KB). But we hit the
> regressions with their baseline (4KB). Again, 2MB THPs, if they are
> used, are reserved (allocated and mlocked to hold text/code sections
> after a reboot). So they shouldn't matter, and I highly doubt the
> regressions are because of them.

Ok.

> > This other data point has me stumped. Comparing medians, there is a
> > 1.5% reduction in anon refaults and a 4.8% increase in file
> > refaults. And indeed, there is more files and less anon being scanned.
> > I think this could explain the PSI delta, since AFAIK you have zram or
> > zswap, and anon decompression loads are cheaper than filesystem IO.
> >
> > The above patches don't do anything that directly influences the
> > anon-file reclaim balance. However, if file THPs fall back to 4k file
> > pages more, that *might* be able to explain a shift in reclaim
> > balance, if some hot subpages in those THPs were protecting colder
> > subpages from being reclaimed and refaulting.
> >
> > In that case, the root cause would still be a simple THP success rate
> > regression. To confirm this theory, could you run the baseline and the
> > patched sets both with THP disabled entirely?
> 
> Will try this. And is bisecting within this series possible?

Yes. I built and put each commit incrementally through my test
machinery before sending them out. I can't vouch for all
configurations, of course, but I'd expect it to work.

> > Can you elaborate more on what the workload is doing exactly?
> 
> These are simple benchmarks that measure the system and foreground
> app/tab performance under memory pressure, e.g., [1]. They open a
> bunch of apps/tabs (respectively on Android/ChromeOS) and switch
> between them. At a given time, one of them is foreground and the rest
> are background, obviously. When an app/tab has been in the background
> for a while, the userspace may call madvise(PAGEOUT) to reclaim (most
> of) its LRU pages, leaving unmovable kernel memory there. This
> strategy allows client systems to cache more apps/tabs in the
> background and reduce their startup/switch time. But it's also a major
> source of fragmentation (I'm sure you get why so I won't go into
> details here. And userspace also tries to make a better decision
> between reclaim/compact/kill based on fragmentation, but it's not
> easy.)

Thanks for the detailed explanation.

That last bit is interesting: how does it determine "fragmentation"?
The series might well affect this metric.

> [1] https://chromium.googlesource.com/chromiumos/platform/tast-tests/+/refs/heads/main/src/go.chromium.org/tast-tests/cros/local/bundles/cros/platform/memory_pressure.go
> 
> > What are
> > the parameters of the test machine (CPUs, memory size)? It'd be
> > helpful if I could reproduce this locally as well.
> 
> The data I shared previously is from an Intel i7-1255U + 4GB Chromebook.
> 
> More data attached -- it contains vmstat, zoneinfo and pagetypeinfo
> files collected before the benchmark (after fresh reboots) and after
> the benchmark.

Thanks, I'll take a look.

