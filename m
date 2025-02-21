Return-Path: <linux-kernel+bounces-525588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F5A3F1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5333BDEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE58206F2B;
	Fri, 21 Feb 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mqpDUrLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4h4zbgNU"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB77205AA3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132982; cv=none; b=hHeIYItjZCZR1rzeHSnt8aym65+T54BORFCVpb0bqD7SJsYp+zlhaS5mSnpseYvGTFx0MeAFehayKBWTlqQD+CqHZQynOHaLzUXptpa7W1Wrnp0HLBYQul+Eg7lRLVlbBE7TmSqFYl+N2xS824XaucOYq7ZlSG4GcVEIF4wlj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132982; c=relaxed/simple;
	bh=v0KF5nl/E80VuWUoDnDl0lanYMhQKsrbKgqxZYYP57Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G/Q312pIp1owit5ZfJ1cN+RKYVJ3fVbF8oYtjmJc6TsKZkVImJ64ScxH6o/fLDYKTflQfEfX7cpCSvowZd3Gvq0WdA6jGDr4vBahNKWIhVnEiDgotFtyiQd81EfQ+SwvgxEE7ajthHFlv4PgLiRzmGOZjTw6TD+/u9HqnUyNARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mqpDUrLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4h4zbgNU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B0541140107;
	Fri, 21 Feb 2025 05:16:19 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 21 Feb 2025 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740132979;
	 x=1740219379; bh=luQEs76vOLabUNRk9LB0YtmKI0bn22gDmeAG79bgLhE=; b=
	mqpDUrLJOjBSFkL0akp75AmGuQcSPIj0YznvHgnukMCdNVhhV8NpsaomyZ+9MWTp
	kdAD+GHo17k4/bI2vGIUkWsC+e9Pwxc1/Sz6Fd7msKjBGY4v58AeCXIoYgbZEvGT
	uSgd5f7PnkiaC/cQpOvTXMqRj++ki2bYZ16pOcG6RZAFLlZ39FvxuWwqN08uQLuZ
	jPEVhlqT9666rjFaINWYeu+k0hHYadT4JRsnAjHZV0WUq5hYeDKjTiB1KriYgD6V
	R9uS/nChGPImcWLV99eK5mfq8K+pWRzIjj/bfAkoEHmSpIeiXrRWKbVLyJKfTITC
	H9usiIWLiFdikeP4WcBO/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740132979; x=
	1740219379; bh=luQEs76vOLabUNRk9LB0YtmKI0bn22gDmeAG79bgLhE=; b=4
	h4zbgNU3fzNdzzpqlg6LM4WD7t9a3ws2hHwRe/y6x45/5eMRlso0GhUDHPVttTPS
	ia5zYjh1BPMmVktvhTO4ZeBxPugxkuv4Y2CbhJVqXYQdprB5+5CMR7N1tt/N4v0c
	tKeMlKKVMm/tJ2pLqSreumjVQfGpyfwMjkMuVjE5ag1VqwFbHkYSeujytKUNpLR0
	soknzQdsdVLqrJx/95GKMB+Y8H+1Bv3m5j0ERGd9jG+W1keDQG4FTh1OiXCqIDyH
	r4Oni4gpOWVM0O84HWMjzCq5JJZBcmpnmCPzddJEEfGNA1bhn0o9/mM9MWXRjVoR
	m9QpXWjYC1KuGOOEuhzYQ==
X-ME-Sender: <xms:clK4Z2GWNA7h2ijtapmrWmV8dDgGwYMsOVitF5acBOkeJBcmq57-hA>
    <xme:clK4Z3VJ4VKttsrZnn6UE2KFjk6KIZm-rdGRYhzB8WG5-1Hxq1VH2_f9yVjc_fFSN
    4YnJZQ_Ot-sHVjvT4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlhhivggu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrrghgrdhjrggurghvsehinhhtvghlrd
    gtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgv
    vgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:clK4ZwK9J9d9tebGoGRWdU25lXg7d8CAc4axA8cIgEGlg5NCsfwuJA>
    <xmx:clK4ZwGydo4vkJH7ATLeHqRf8L8ibqeKswHwK8wDTCgcpzdwzQS2-Q>
    <xmx:clK4Z8V0pn_VpE6EqIPraYrzRpaWYEwpmc1wKtbz38BX37JOP6-QxQ>
    <xmx:clK4ZzNSS-MxW8hYvBncbRir8qjso-P-C_ucaMA63MMtAHhcSu33KA>
    <xmx:c1K4Z-JV6DOZtJaFZIWOJXREgN3Itl_kwEYdSIYf0OpcpfoCcNj2DNDK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 124972220072; Fri, 21 Feb 2025 05:16:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 11:15:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Raag Jadav" <raag.jadav@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com>
In-Reply-To: <20250221050804.2764553-1-raag.jadav@intel.com>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
Subject: Re: [PATCH v2 0/2] Cleanup io.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2025, at 06:08, Raag Jadav wrote:
> In a wider effort to improve build speeds, we're attempting to split/cleanup
> core headers.
>
> This series attempts to cleanup io.h with "include what you need" approach.
>
> This depends on earlier modifications available in immutable tag[1]. Feel
> free to carry your subsystem patches with it, or let Andy know if you'd
> rather let him carry them.
>
> [1] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com/
>
> v2: Fix drm_draw.c build errors

Hi Raag,

I think your patch is to linux/io.h is correct and we should
eventually apply it, but I think the header file cleanup needs
to be done in a little more structured way or it ends up causing
a lot of extra work for very little gain.

As you already found, removing an old indirect #include that is
no longer needed usually leads to some files breaking. The more
impactful your change is in terms of build speed, the more
things break! I think in this case, removing linux/err.h and
linux/bug.h made very little difference because they are very
small files in terms of what else they include.

The approach that I would suggest you take is:

1. identify a header file that is included indirectly in a lot
   of places and also has a ton of indirect inclusions inside it
2. split it up in a way that most indirect inclusions can be
   replaced with a much smaller varient
3. repeat step 1 and 2 for additional headers, splitting them
   up but leaving the inclusions in place for the moment
4. test thousands of randconfig builds across architectures
   with the unnecessary indirect inclusions removed, send
   fixup patches for the drivers to add the missing direct
   #include statements, one patch per subsystem
5. once the known regressions are fixed, actually propose
   removing the extra #include statements and fix the remaining
   regressions

If you are looking for a good place to start with step 1, 
the way I've done this in the past is to calculate for each
header file how often it gets included in a particular build
and how large the preprocessed files are, then sort them
by the product of the two. These are the top entries I
see for an arm64 defconfig

#incl #lines file
7054 41901 include/linux/module.i
7146 39685 include/linux/fs.i
7057 39996 include/linux/elf.i
5667 44323 include/linux/energy_model.i
5667 44322 include/linux/device.i
5668 42467 include/linux/device/driver.i
4707 47776 include/linux/mm.i
7151 29653 include/linux/kobject.i
7151 29494 include/linux/sysfs.i
7146 29090 include/linux/percpu-rwsem.i
7152 28963 include/linux/rcuwait.i
7154 28929 include/linux/sched/signal.i
7151 28608 include/linux/kernfs.i
3713 55040 include/linux/kprobes.i
3707 55113 include/linux/kgdb.i
3718 54591 include/linux/ftrace.i
7366 27519 include/linux/slab.i
7146 28276 include/linux/ioprio.i
7190 28029 include/linux/radix-tree.i
7159 28137 include/linux/idr.i
7146 28098 include/linux/iocontext.i
3390 59188 include/linux/bio.i
7146 28073 include/linux/list_lru.i
7192 27842 include/linux/xarray.i
3390 58566 include/linux/blk_types.i
3176 62442 include/linux/writeback.i
7366 26873 include/linux/percpu-refcount.i
3538 55872 include/linux/highmem.i
7054 27934 include/linux/kmod.i
7382 26691 include/linux/gfp.i
7054 27925 include/linux/umh.i
3538 55255 include/linux/cacheflush.i
7382 26416 include/linux/topology.i
3053 63637 include/linux/memcontrol.i
7193 27010 include/linux/sched/mm.i
7382 26210 include/linux/mmzone.i
7382 26210 include/linux/memory_hotplug.i
4707 40968 include/linux/huge_mm.i
3428 56061 include/linux/bvec.i
3713 49335 include/linux/rethook.i
...
5159 28781 include/linux/io.i

You can pick any one of these and try to analyze why the
header gets included absolutely everywhere, and why it is
so huge, then try to come up with an idea for how to
improve that based on what you found.

When you do the analysis for linux/io.h, you find that
it's only on #72 on that list (for arm64 defconfig), and
that almost all of its 28781 lines come from one of these
indirectly included files (sorted by number of lines after
preprocessing), not from bug.h or err.h:

27569 include/linux/pgtable.h
24636 include/linux/mmu_notifier.h
24217 include/linux/page-flags.h
23860 include/linux/mmap_lock.h
23670 include/linux/mm_types.h
21468 include/linux/srcu.h
21355 include/linux/uprobes.h
20746 include/linux/workqueue.h
20091 include/linux/timer.h
19950 include/linux/ktime.h
19949 include/linux/timekeeping.h
19536 include/linux/jiffies.h
19428 include/linux/timex.h
19428 include/linux/time.h
19427 include/linux/time32.h
18716 include/linux/percpu_counter.h
18595 include/linux/percpu.h
18390 include/linux/sched.h
16879 include/linux/maple_tree.h
16699 include/linux/seqlock.h
16527 include/linux/kref.h
16472 include/linux/completion.h
16429 include/linux/swait.h
16388 include/linux/wait.h
16364 include/linux/rwsem.h

Note that a lot of these are indirectly included multiple
times below linux/io.h. Almost none of the above have any
business being included in linux/io.h.

      Arnd

