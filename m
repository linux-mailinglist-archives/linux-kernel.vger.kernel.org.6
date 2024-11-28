Return-Path: <linux-kernel+bounces-425030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4919DBCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67DF281655
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4B1B3921;
	Thu, 28 Nov 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gyhy5hDX"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C87A13A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823221; cv=none; b=ojYnotGSgIYhdwBufgyXrJfgAP1xiiUoobcfNpNL89VIVqAdj0t9P0fvzo4iekhK8i4VsdrEGFXzRvjQMRwXchxdP3hqt+RBg7Mjt+22MrvfAbeGJ645E+5gClyylZ/6SPSuOqweQGdLgcHQqKpVjpHeShGP5zcoyaqZgfHXSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823221; c=relaxed/simple;
	bh=2ELePXYEM3g2x27jUZk9MIdx9Ot+pCc2LJhc59w9m48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6E757NUrSMwku3eLXfdxr1FT6VX9dY//OAkvJCR04znJTW1JTYMfr/Saxya/x3TiaBR0R1/rpIrSYRmjarrlTPMvAs9L9PGMivHClHnn3ie5Fsonx7D9hiHruL6ZFIu1kWRmWd1mRp4s3pduaBvB0GocLxo1TfbEe+FnF/cWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gyhy5hDX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732823218;
	bh=2ELePXYEM3g2x27jUZk9MIdx9Ot+pCc2LJhc59w9m48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyhy5hDXjDMnGrSLW8KjTYCg8BFsEwEdJf4GDepDN1rnr9qczkN1k44GIGziCx8hV
	 dWFMF+jG721UI6S3cYMqrRug+MCgtzVZbQ1L4vtq3LHQ6V6kHprKu08r8/lzTbvDDZ
	 LMJT7eLpCW12ThitnRxjQu+FFjYXVJrcY/QT3qZ5M3/Z5oxzAGIucZ54JUIMDlH/gG
	 +bapxvRqUEfRKy67WY+X0z+DfNcmgiYR37g8ZYrWW5G2vPmaYwRuqdq1rC4nO4dAMe
	 ThPxOPPcQHtwX72Tw1ujMeDtufzBoUwBKbh+Q7X6908f3z6fb1rN37EoE5nz+H+ieE
	 cAINsJ/VenZmg==
Received: from localhost.localdomain (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XzmzQ2bnTzly5;
	Thu, 28 Nov 2024 14:46:58 -0500 (EST)
Date: Thu, 28 Nov 2024 14:46:57 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>
Subject: Re: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:
  will-it-scale.per_thread_ops 13.2% regression
Message-ID: <Z0jIsYsuo_9w16tK@localhost.localdomain>
References: <202411282207.6bd28eae-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411282207.6bd28eae-lkp@intel.com>

On 28-Nov-2024 10:57:35 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_ops on:
> 
> 
> commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm

AFAIU, this commit changes the way TLB flushes are inhibited when
context switching away from a mm. This means that one additional TLB
flush is performed to a given CPU even after it has context switched
away from the mm, and only then is the mm_cpumask cleared for that CPU.

This could result in additional TLB flush IPI overhead in specific
scenarios where the IPIs are typically triggered after a thread has
context-switched out.

May I recommend looking into a scheme similar to rseq mm_cid for this ?
We're already adding a per-mm per-cpu data:

mm_struct:
                /**
                 * @pcpu_cid: Per-cpu current cid.
                 *
                 * Keep track of the currently allocated mm_cid for each cpu.
                 * The per-cpu mm_cid values are serialized by their respective
                 * runqueue locks.
                 */
                struct mm_cid __percpu *pcpu_cid;

struct mm_cid {
        u64 time;
        int cid;
        int recent_cid;
};

I suspect you could use a similar per-cpu data structure per-mm
to keep track of the pending TLB flush mask, and update it simply with
load/store to per-CPU data rather than have to cacheline-bounce all over
the place due to frequent mm_cpumask atomic updates.

Then you get all the benefits without introducing a window where useless
TLB flush IPIs get triggered.

Of course it's slightly less compact in terms of memory footprint than a
cpumask, but you gain a lot by removing cache line bouncing on this
frequent context switch code path.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

