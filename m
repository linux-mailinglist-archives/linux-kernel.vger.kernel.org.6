Return-Path: <linux-kernel+bounces-525664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C2A3F2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878E97AAA02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773420767A;
	Fri, 21 Feb 2025 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjrva0Wm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39172AE89
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137190; cv=none; b=sBwUFH95vO0BYfcsAfIvYf2CaSBAeH44NkFw6gO4bfXPhQ+AgJLP1EI5GHqkwINka65F9CfqwwqwrJtSDPUs1kfF3hZDWxI3CO+JVo3D3DQJMQIgmLkcZMeKjqo2l45uMj23E57iYQlHE0nAxD+8KwTH30X6i1mxREyElTGU4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137190; c=relaxed/simple;
	bh=uCaoV8ieBoq865Aj57HbN0qiQTi5jg6DIIv1wdMIPpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci3QKmVjwrlHxmC4mgqeOyIgnTcfXtE6QS+zQOabPbsMsMhJ3gdu06NYaQAr32qCywY0pqcxwmnVS8XHvEvg9Vu1bSG7kR3u4T7Xb4DE3VB1tYCrSDB2zBtURqhIG4Yscf7ghOGOJ6PtZ0zSdwcE7oSSvZgwDHYJ1l/mJg55u2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjrva0Wm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740137188; x=1771673188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uCaoV8ieBoq865Aj57HbN0qiQTi5jg6DIIv1wdMIPpg=;
  b=fjrva0Wm1H/EKAFTK48PURHyu9zRvE/XPAl+rvk9u4rPtRiCxw4oVH+7
   6MH3ubvhqokpZ+jBlk717G2z8cyccB/tGZ6yW/vxZmD6s80cYTO7pnzQq
   JCSwTuiiv1E378qypZql0pmsjsxFR4ZMwP8cuTTuL3nTouQd3apBRpInz
   CcYDUa1/aV0LA/eObTe1zcM1yQeJ0efGc0b+MFsadH1SJ7JV/3bMmoel5
   qEoKNSEVDk2MrSQVsNkFDBsxekmykshKaVrOS3m1oe5kdVlpR6j1GS7u7
   nTLa9R/NA/WNQzDHqR8B+uQsZk/swcU+YEz+jl5rB/M00jQDFId3r3P+n
   g==;
X-CSE-ConnectionGUID: afYTY8s3RVeXzfF4P3zJfA==
X-CSE-MsgGUID: rSR5R8iUSNm9veJVZdMb3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66316033"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66316033"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:26:27 -0800
X-CSE-ConnectionGUID: aJZxBnQZRxO9vVuEPSoBdw==
X-CSE-MsgGUID: XtTsBYe2RTK1o27w8Io8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="115066363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:26:25 -0800
Date: Fri, 21 Feb 2025 13:26:21 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Message-ID: <Z7hi3cHDlvctTwnV@black.fi.intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>

On Fri, Feb 21, 2025 at 11:15:47AM +0100, Arnd Bergmann wrote:
> On Fri, Feb 21, 2025, at 06:08, Raag Jadav wrote:
> > In a wider effort to improve build speeds, we're attempting to split/cleanup
> > core headers.
> >
> > This series attempts to cleanup io.h with "include what you need" approach.
> >
> > This depends on earlier modifications available in immutable tag[1]. Feel
> > free to carry your subsystem patches with it, or let Andy know if you'd
> > rather let him carry them.
> >
> > [1] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com/
> >
> > v2: Fix drm_draw.c build errors
> 
> Hi Raag,
> 
> I think your patch is to linux/io.h is correct and we should
> eventually apply it, but I think the header file cleanup needs
> to be done in a little more structured way or it ends up causing
> a lot of extra work for very little gain.
> 
> As you already found, removing an old indirect #include that is
> no longer needed usually leads to some files breaking. The more
> impactful your change is in terms of build speed, the more
> things break! I think in this case, removing linux/err.h and
> linux/bug.h made very little difference because they are very
> small files in terms of what else they include.
> 
> The approach that I would suggest you take is:
> 
> 1. identify a header file that is included indirectly in a lot
>    of places and also has a ton of indirect inclusions inside it
> 2. split it up in a way that most indirect inclusions can be
>    replaced with a much smaller varient
> 3. repeat step 1 and 2 for additional headers, splitting them
>    up but leaving the inclusions in place for the moment
> 4. test thousands of randconfig builds across architectures
>    with the unnecessary indirect inclusions removed, send
>    fixup patches for the drivers to add the missing direct
>    #include statements, one patch per subsystem
> 5. once the known regressions are fixed, actually propose
>    removing the extra #include statements and fix the remaining
>    regressions
> 
> If you are looking for a good place to start with step 1, 
> the way I've done this in the past is to calculate for each
> header file how often it gets included in a particular build
> and how large the preprocessed files are, then sort them
> by the product of the two. These are the top entries I
> see for an arm64 defconfig
> 
> #incl #lines file
> 7054 41901 include/linux/module.i
> 7146 39685 include/linux/fs.i
> 7057 39996 include/linux/elf.i
> 5667 44323 include/linux/energy_model.i
> 5667 44322 include/linux/device.i
> 5668 42467 include/linux/device/driver.i
> 4707 47776 include/linux/mm.i
> 7151 29653 include/linux/kobject.i
> 7151 29494 include/linux/sysfs.i
> 7146 29090 include/linux/percpu-rwsem.i
> 7152 28963 include/linux/rcuwait.i
> 7154 28929 include/linux/sched/signal.i
> 7151 28608 include/linux/kernfs.i
> 3713 55040 include/linux/kprobes.i
> 3707 55113 include/linux/kgdb.i
> 3718 54591 include/linux/ftrace.i
> 7366 27519 include/linux/slab.i
> 7146 28276 include/linux/ioprio.i
> 7190 28029 include/linux/radix-tree.i
> 7159 28137 include/linux/idr.i
> 7146 28098 include/linux/iocontext.i
> 3390 59188 include/linux/bio.i
> 7146 28073 include/linux/list_lru.i
> 7192 27842 include/linux/xarray.i
> 3390 58566 include/linux/blk_types.i
> 3176 62442 include/linux/writeback.i
> 7366 26873 include/linux/percpu-refcount.i
> 3538 55872 include/linux/highmem.i
> 7054 27934 include/linux/kmod.i
> 7382 26691 include/linux/gfp.i
> 7054 27925 include/linux/umh.i
> 3538 55255 include/linux/cacheflush.i
> 7382 26416 include/linux/topology.i
> 3053 63637 include/linux/memcontrol.i
> 7193 27010 include/linux/sched/mm.i
> 7382 26210 include/linux/mmzone.i
> 7382 26210 include/linux/memory_hotplug.i
> 4707 40968 include/linux/huge_mm.i
> 3428 56061 include/linux/bvec.i
> 3713 49335 include/linux/rethook.i
> ...
> 5159 28781 include/linux/io.i
> 
> You can pick any one of these and try to analyze why the
> header gets included absolutely everywhere, and why it is
> so huge, then try to come up with an idea for how to
> improve that based on what you found.
> 
> When you do the analysis for linux/io.h, you find that
> it's only on #72 on that list (for arm64 defconfig), and
> that almost all of its 28781 lines come from one of these
> indirectly included files (sorted by number of lines after
> preprocessing), not from bug.h or err.h:
> 
> 27569 include/linux/pgtable.h
> 24636 include/linux/mmu_notifier.h
> 24217 include/linux/page-flags.h
> 23860 include/linux/mmap_lock.h
> 23670 include/linux/mm_types.h
> 21468 include/linux/srcu.h
> 21355 include/linux/uprobes.h
> 20746 include/linux/workqueue.h
> 20091 include/linux/timer.h
> 19950 include/linux/ktime.h
> 19949 include/linux/timekeeping.h
> 19536 include/linux/jiffies.h
> 19428 include/linux/timex.h
> 19428 include/linux/time.h
> 19427 include/linux/time32.h
> 18716 include/linux/percpu_counter.h
> 18595 include/linux/percpu.h
> 18390 include/linux/sched.h
> 16879 include/linux/maple_tree.h
> 16699 include/linux/seqlock.h
> 16527 include/linux/kref.h
> 16472 include/linux/completion.h
> 16429 include/linux/swait.h
> 16388 include/linux/wait.h
> 16364 include/linux/rwsem.h
> 
> Note that a lot of these are indirectly included multiple
> times below linux/io.h. Almost none of the above have any
> business being included in linux/io.h.

Excellent! Thanks for laying out a great analysis and points worth
considering. It seems this will require extensive study and motivation,
and is definitely not as obvious and simple as this series, but I'll
surely look into it later on.

Raag

