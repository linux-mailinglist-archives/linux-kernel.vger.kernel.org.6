Return-Path: <linux-kernel+bounces-541461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D18A4BD22
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AC116457A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EF1F417A;
	Mon,  3 Mar 2025 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S578nHK3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038D1E376C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999267; cv=none; b=e36of+Oh4WMFJp4kFuoelqo3+zLIODuz64zP7wwB7xm7Iie4E53Hrgbf+ngeWDrcTAQ5AVNkBvuqLS/dh7y3KqvxxRhZWNmAy4lz4qjQ4ePVkS6Vl8PwveAbcT+IuXj2My4zOyHGBCNrWTxbRO4/0bSeG0SEYWmv7TjXZH6Y/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999267; c=relaxed/simple;
	bh=9jTT5pz6d+coRvcpp/jRjNgkqpPeEeFdBIFinroIosI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myEAiMzaN+ILWJUNfJf586ul1EJnwwVimN0J1hDhOGBGj9YHpu2EYl5+pLR8XVYf2oq3tcCytGi7t7kdNRMoO/07iyKfGAxt0+l6n+fP9uu34zJ6ho5wTKSF3rWPE5m6HrMCFHOotFOZxw28whkrZ3g3LMuWY/pQRb6+WTcld1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S578nHK3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1QY4yVosA0u+JGKpsM5NK2InUutN93mSDb0zskWO42U=; b=S578nHK3Y8TzxQzRnxWhZfLsH/
	HqjKHuWOTpRCp2Ou/hGQQDImBXDZHsuNHo3KWtG/ONpZGSkwedWWN/Q2k5ec5jFtnTYo5QWdsVC5m
	+Mpn1E7TKt9khqXZucuKdtyiIPiTheXQBxlWEgr4ieH38PZNdowQgga7gUt3WE9LDf+XoT6gm1nbT
	E6ABiOlR1B6pFlre2hLd7iWdrTQtyz8CTylfraEkrWRY4WNFQ1dvW2Hj9Hxf8YJK8H3l74ksTbFQf
	o3nO04823QnbXShe0Y7VP1zFnJxCQ7UpHW1m1D4nynh8HLKjM5QOIRKPF3vo6zv6qK/FHhZDalN2W
	2kuvlVPw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp3RB-0000000BUza-2cE6;
	Mon, 03 Mar 2025 10:54:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C106C30049D; Mon,  3 Mar 2025 11:54:16 +0100 (CET)
Date: Mon, 3 Mar 2025 11:54:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250303105416.GY11590@noisy.programming.kicks-ass.net>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>

On Tue, Feb 25, 2025 at 06:09:03PM +0100, Sebastian Andrzej Siewior wrote:

> Sebastian Andrzej Siewior (11):
>   futex: fixup futex_wait_setup [fold futex: Move futex_queue() into
>     futex_wait_setup()]
>   futex: Create helper function to initialize a hash slot.
>   futex: Add basic infrastructure for local task local hash.
>   futex: Hash only the address for private futexes.
>   futex: Allow automatic allocation of process wide futex hash.
>   futex: Decrease the waiter count before the unlock operation.
>   futex: Introduce futex_q_lockptr_lock().
>   futex: Acquire a hash reference in futex_wait_multiple_setup().
>   futex: Allow to re-allocate the private local hash.
>   futex: Resize local futex hash table based on number of threads.

Right, I've been going over this and been poking at the patches for the
past few days, and I'm not quite sure where to start.

There's a bunch of simple things, that can be trivially fixed, but
there's also some more fundamental things.

I've written a pile of patches on top of this while playing around with
things. The latest pile sits in:

  queue/locking/futex

I'm not sure I should post the patches as a reply to this email (I can,
if people want), but let me try and summarize what I did and why.


Primarily, the reason I started poking at it is that I think the prctl()
as implemented is completely useless. Notably its effect is entirely
ephemeral, one pthread_create() call can re-size the hash, destroying
the user requested size. Also, I still feel one should be able to set
the hash size to 0 and have it revert to global hash.

Finally prctl() should not return until the rehash is complete.

I think my implementation now does all that -- but I've not tested it
yet -- I've to write a prctl() testcase and it was too nice outside :-)


So, on the way to reworking the prctl(), I ran into:

 - naming; hb_p is a terrible name, the way I read that is
   hash-bucket-private, or hash-bucket pointer, neither make much sense,
   because they're a pointer to struct futex_private_hash, which is a
   hash-table.

   I've very uninspired done s/hb_p/fph/g with the exception of
   hb->hb_p, which is now hb->priv.

 - more naming; you had:

    hb = __futex_hash(key);
    futex_hash_get(hb);
    futex_hash_put(hb);

    fph = futex_get_private_hash();
    futex_put_private_hash();

   which is all sorts of inconsistent, and I've made that:

    hb = __futex_hash(key);	/* hash, no get */
    hb = futex_hash(key)	/* hash and get */
    futex_hash_get(hb);		/* get */
    futex_hash_put(hb);		/* put */

    fph = futex_private_hash();
    futex_private_hash_get(fph);
    futex_private_hash_put(fph);

 - There was some superfluous state; notably, AFAICT
   futex_private_hash::{initial_ref_dropped,released} are unneeded and
   made the code unnecessarily complicated.

   You can drop the initial ref when phash && !phash_new, eg on the
   first time around when you allocate a new hash-table.

   We don't need to track released because we can simply check for that
   state using rcuref_read() == 0.

 - As alluded to in a previous point, there was no means of only
   hashing, the fph get was both non-obviously hidden inside the private
   hash and unconditional. Untangled that.

My current prctl() thing does:

 - reject !power-of-two and 1
 - accepts 0
 - returns once rehash is done

Notably, having done a prctl() disables the auto-sizing.

When allocating a new private hash table and there is already one
pending, it compares the tables. The compare function checks in order:

 - custom (user provided / prctl())
 - zero size
 - biggest size

IOW, any user requested size always wins, a 0 size is final otherwise
go with the largest.


After that I rebased my FUTEX2_NUMA patch on top of all this and added
a new FUTEX2_MPOL, which is something Christoph Lameter asked for a
while back, and something we can now actually do sanely, since we have
lockless vma lookups working.

Anyway, the entire stack builds and boots, but is otherwise very much
untested.

WDYT?

