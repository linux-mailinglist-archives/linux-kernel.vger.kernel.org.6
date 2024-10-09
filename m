Return-Path: <linux-kernel+bounces-357092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB52996B68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4601C22AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAAA192D6A;
	Wed,  9 Oct 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFUX9Hmd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE0291E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479425; cv=none; b=SkyjoRq+SOEGcTvQkIMQZaplH38pukoPDntM3LiO3KcWkJHRJhtfUMLpAnpy4UcE/2OA2t9kdb8JEpAW5Gzktt0tPJJpbuNL96OO0W9O+snjZog+89ZwIweuyZRmVaQ36VNBgWoBqQaOHXd4M75MeK14PJ6//sX0PhLqdW5rkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479425; c=relaxed/simple;
	bh=CWJzYgn/Y/+lUqiztQGewVb+jXOTSYgNUo3XS0WMDrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3k7ChjJMFdAg3jD4yedtDdjw8dNd+cR5JoHYI76wmjjdsC54INHMBIAAzv1r496V/vxivjNQSihvKUefFfybv+OvfITGSTSxN6kL2tR0xwl5NKuk1qz57MVkVhQSflW0R+Vu872Laeq1icC47G5pOrTT7sUEbDUD8udJBDwwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hFUX9Hmd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ESw401B8qGnKFVz+xxl9J4Tihn4ZExqj3WKxS50htgU=; b=hFUX9HmdcVJ3Dski1jbtqJcQOR
	xPrefi4hnplnwIw10DAdVjmHqxpcAgR7cFrhYmwtx0daryM2ZvNbsJ4/lLNtLS9fFVLaxIyyZOBMr
	z+jO/dUBSiDlR7vYIIAdpx4X/Gf8FZoFmMs/DsaXy4mukvdYhpD5Wj3xa4xKikDslz9gov1EkgD+j
	OVqxqyovNhtmSDYlPmevem6H7g30PN2fzucAiFXO87a8s8a818MOEPNNROfVotOHlDL7MtmiGO9J+
	T2Y2YXMrhlBgKVwwXxTqXAuXrR1prTcqqd/nZcQ1njVMUmBLFwHyrf/jrk9TgwNE40bAFk2EZ4zIz
	DfJ1V7ig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syWSF-00000004tUE-3nJV;
	Wed, 09 Oct 2024 13:10:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF7D130057A; Wed,  9 Oct 2024 15:10:15 +0200 (CEST)
Date: Wed, 9 Oct 2024 15:10:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
Message-ID: <20241009131015.GP17263@noisy.programming.kicks-ass.net>
References: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>

On Wed, Oct 09, 2024 at 11:20:31AM +0200, Thomas Hellström wrote:
> When using mutex_acquire_nest() with a nest_lock, lockdep refcounts the
> number of acquired lockdep_maps of mutexes of the same class, and also
> keeps a pointer to the first acquired lockdep_map of a class. That pointer
> is then used for various comparison-, printing- and checking purposes,
> but there is no mechanism to actively ensure that lockdep_map stays in
> memory. Instead, a warning is printed if the lockdep_map is freed and
> there are still held locks of the same lock class, even if the lockdep_map
> itself has been released.
> 
> In the context of WW/WD transactions that means that if a user unlocks
> and frees a ww_mutex from within an ongoing ww transaction, and that
> mutex happens to be the first ww_mutex grabbed in the transaction,
> such a warning is printed and there might be a risk of a UAF.
> 
> Note that this is only problem when lockdep is enabled and affects only
> dereferences of struct lockdep_map.
> 
> Adjust to this by adding a fake lockdep_map to the acquired context and
> make sure it is the first acquired lockdep map of the associated
> ww_mutex class. Then hold it for the duration of the WW/WD transaction.
> 
> This has the side effect that trying to lock a ww mutex *without* a
> ww_acquire_context but where a such context has been acquire, we'd see
> a lockdep splat. The test-ww_mutex.c selftest attempts to do that, so
> modify that particular test to not acquire a ww_acquire_context if it
> is not going to be used.
> 
> v2:
> - Lower the number of locks in the test-ww_mutex
>   stress(STRESS_ALL) test to accommodate the dummy lock
>   introduced in this patch without overflowing lockdep held lock
>   references.

Thanks, I rebased tip/locking/core, which should now have this patch.

