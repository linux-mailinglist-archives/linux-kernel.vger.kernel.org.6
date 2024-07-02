Return-Path: <linux-kernel+bounces-237247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2391EDDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4951B1C2270C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E5374DD;
	Tue,  2 Jul 2024 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="efEIVzFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977E2D02E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894373; cv=none; b=m0tYqAp2MxqCLbss5b3BwbI0w5bYAcB7kGbFEJRcH1AVcmbWuRPuWMHFraqs6B5yvugOEIFkKeCDrfxo2wCtUtd7BDuI2dt9JSI36NSVbj9tKOcpw7iyg/bcjQ09I5FdiFEUDNgwzQHNRg7AqYyH9v0hW8TSOc7xZkBHArLELkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894373; c=relaxed/simple;
	bh=mXk/dDsaB3RUk9IqSGE1UNdo/ml+kaPBA0LPGgiRkt8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m5mbb/5UYeeFpA7jqrwhAVxA30NqssX6HdSjz95BY+uwqpYnD7qQy/+/ZRfxENpbQBjPHHjHyLARjd7tA1MOsB8GlipKcU2weneiJzviWGEgCgXeILJDdNvHpIQFHWr+6rxRyQrZpV1EjyDCRai10f+QB43RN+dMVjEwSpvKe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=efEIVzFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F1C116B1;
	Tue,  2 Jul 2024 04:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719894372;
	bh=mXk/dDsaB3RUk9IqSGE1UNdo/ml+kaPBA0LPGgiRkt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efEIVzFgZ/QOpV9BycdHyIowGAxoa+2+Pm2lgILHi5HzRIVyH1l5TMNhdEUVbM2E3
	 NwCIsgZKu+fhuPRAc6sQKKNEfhSY2/bHfq3HYJ3AlUVNhdcqQokb2OdFP9yHeRRUAq
	 rnCK6Rq/Yhwq3i7mBiRjvnRKKK5/lhd+6TvwxkrA=
Date: Mon, 1 Jul 2024 21:26:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: brauner@kernel.org, oleg@redhat.com, mjguzik@gmail.com,
 tandersen@netflix.com, linux-kernel@vger.kernel.org, Mike Rapoport
 <rppt@kernel.org>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] kernel/fork.c: get totalram_pages from memblock
 to calculate max_threads
Message-Id: <20240701212611.a0a977160c892818a7057615@linux-foundation.org>
In-Reply-To: <20240701013410.17260-1-richard.weiyang@gmail.com>
References: <20240701013410.17260-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 01:34:09 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> Since we plan to move the accounting into __free_pages_core(),
> totalram_pages may not represent the total usable pages on system
> at this point when defer_init is enabled.

Yes, things like totalram_pages() are very old, and were a good idea at the
time, but things moved on.

> Instead we can get the total usable pages from memblock directly.
> 
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -44,6 +44,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/memblock.h>
>  #include <linux/nsproxy.h>
>  #include <linux/capability.h>
>  #include <linux/cpu.h>
> @@ -999,7 +1000,7 @@ void __init __weak arch_task_cache_init(void) { }
>  static void set_max_threads(unsigned int max_threads_suggested)
>  {
>  	u64 threads;
> -	unsigned long nr_pages = totalram_pages();
> +	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());

The result of this subtraction has meaning.  Even if it is only used
once, I suspect it should be in a standalone function which has
documentation which describes that meaning.  Having fork.c make an
open-coded poke into memblock internals seems wrong, no?


