Return-Path: <linux-kernel+bounces-192730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE28D215B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F6F1F21028
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134C171E76;
	Tue, 28 May 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="St328rec"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C832C60
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912760; cv=none; b=lsPiekqfLkQ6J0DmhNPWFj3/OKrwOZORUhvzVxKemQMNtefCd6mFzOLA/P0XPD/cr/msPTDT2jda9i4qHIBxmg4KDtQtsxoOOiZ0BR6hFl+bFAUBFBzcdR+rmg/IytCiFgxSIfp6HvdghxnWhBzQqieFeWlH8mNLctk/4jf9NNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912760; c=relaxed/simple;
	bh=gQDaCc1TaJ0vEa9tQkxi/WzhJi3IevxHcvvqqCvnO+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+032wC1iK2p9h1H/jGBA26VFXu6qmcgnIcOvlxTQtiQ3ckKaVfo2qemabWjOnQQl5oIh2YqnEZ9XyJCxaupj97kqcNcf6rNf5pJC/XYGBfan+k19yFQM3P73Dgfq6i/drCQnvMTRpH7dR5rpulKMpgiA78DF44YqgXZXUYiGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=St328rec; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g9mito6xvD+dhaYJ6IPUwATO98QSzshKvXNpGy6GRMQ=; b=St328recDzOi7dXNBaqbRlh3R2
	/pedsYfD1JqYVLdPpAT8SeB2lr4J48VRm5ZQSS8mQviwNEzKcZCNZcCDCVguTu7WGGayqbhAPyKGt
	4M5Qil4VqUnaW6wY8qFoBNrhjZ/oMhmmWhxLr/Bt1WTZExw2BYL/NtgGo7UzzhHbu0gCRO5EGK5Wa
	bahw6LTMDT2rPdso07WuRytqrhXz9NnsFQ345MfJR7NfRIqX87z5B18M7Nc9K4JMxAfTxF1L0Egox
	Tz9C+mEMlYABn4g0HeTv/x14YaatExwYVruw5c1OS5vky95d+hKebElo5K+TjjVHoCDqRslr9oCpc
	KLqWfaqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzRA-00000008oIV-1NR1;
	Tue, 28 May 2024 16:12:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF5E230058E; Tue, 28 May 2024 18:12:31 +0200 (CEST)
Date: Tue, 28 May 2024 18:12:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 08/35] entry: handle lazy rescheduling at user-exit
Message-ID: <20240528161231.GD26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-9-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-9-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:54PM -0700, Ankur Arora wrote:
> The scheduling policy for TIF_NEED_RESCHED_LAZY is to allow the
> running task to voluntarily schedule out, running it to completion.
> 
> For archs with GENERIC_ENTRY, do this by adding a check in
> exit_to_user_mode_loop().
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/entry-common.h | 2 +-
>  kernel/entry/common.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index b0fb775a600d..f5bb19369973 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -65,7 +65,7 @@
>  #define EXIT_TO_USER_MODE_WORK						\
>  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
>  	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 ARCH_EXIT_TO_USER_MODE_WORK)
> +	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)

Should we be wanting both TIF_NEED_RESCHED flags side-by-side?

