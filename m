Return-Path: <linux-kernel+bounces-287210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610789524C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935661C22E27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DE1C7B98;
	Wed, 14 Aug 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KJNUTFpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF71BF327
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670865; cv=none; b=NPS2KnFCZ6SnrFZDEiyWCVeQoLgcrptxHi9fxT+Z/XxHvSr9S7dBp8RlrsOh7rUxv+Xct8NNBGUaloRxqGlV/V3dfcFNceBdulhYclzEY7qaqQYRrJxSe5UWSY2co3UNLRz8V9AJg5qmQjBEUHRblbh2sIESpDxh9yNMHxyobG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670865; c=relaxed/simple;
	bh=tSHRw7nbaq8pZSzLIRmR6HgytwCBnaIa5ivF3FO3EHY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GaqGThyA5TIcU8s9zKya/U2ZKu3ezhf1szKzZFOC7LP7p+i7fApG5tgBJonZVnDPrbVDfvIYqvetTH/uIgTPDLwoWwFxkiiszSmHXUaxieh6aDGihSgf5B508zU4cNWsFWJEp99OholQIoCYok3Bvn64qUvPkJlBPC18l7hW1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KJNUTFpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D1DC116B1;
	Wed, 14 Aug 2024 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723670864;
	bh=tSHRw7nbaq8pZSzLIRmR6HgytwCBnaIa5ivF3FO3EHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KJNUTFpmADLv6geBpz336zrVmArJWWS1kGsYFboYRm5tsSLHJA0N8kt1YJWfFVbX1
	 ut1D919hxIk47GYLHgKc/A75dgz2YZ0FjHtlX2UQ0gT1DDdNl2AUYkwrgLzLS5oDno
	 XYOPgdQPN1zKjHcUz8IRGROzVG3zeSurEKb8roKk=
Date: Wed, 14 Aug 2024 14:27:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: liuye <liuye@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function
 isolate_lru_folios
Message-Id: <20240814142743.c8227d72be4c5fd9777a4717@linux-foundation.org>
In-Reply-To: <20240814091825.27262-1-liuye@kylinos.cn>
References: <20240814091825.27262-1-liuye@kylinos.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Aug 2024 17:18:25 +0800 liuye <liuye@kylinos.cn> wrote:

> This fixes the following hard lockup in function isolate_lru_folios
> when memory reclaim.If the LRU mostly contains ineligible folios
> May trigger watchdog.
> 
> watchdog: Watchdog detected hard LOCKUP on cpu 173
> RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
> Call Trace:
> 	_raw_spin_lock_irqsave+0x31/0x40
> 	folio_lruvec_lock_irqsave+0x5f/0x90
> 	folio_batch_move_lru+0x91/0x150
> 	lru_add_drain_per_cpu+0x1c/0x40
> 	process_one_work+0x17d/0x350
> 	worker_thread+0x27b/0x3a0
> 	kthread+0xe8/0x120
> 	ret_from_fork+0x34/0x50
> 	ret_from_fork_asm+0x1b/0x30
> 
> lruvec->lru_lock owner：
> 
> PID: 2865     TASK: ffff888139214d40  CPU: 40   COMMAND: "kswapd0"
>  #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
>  #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
>  #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
>  #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
>  #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
>     [exception RIP: isolate_lru_folios+403]
>     RIP: ffffffffa597df53  RSP: ffffc90006fb7c28  RFLAGS: 00000002
>     RAX: 0000000000000001  RBX: ffffc90006fb7c60  RCX: ffffea04a2196f88
>     RDX: ffffc90006fb7c60  RSI: ffffc90006fb7c60  RDI: ffffea04a2197048
>     RBP: ffff88812cbd3010   R8: ffffea04a2197008   R9: 0000000000000001
>     R10: 0000000000000000  R11: 0000000000000001  R12: ffffea04a2197008
>     R13: ffffea04a2197048  R14: ffffc90006fb7de8  R15: 0000000003e3e937
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>     <NMI exception stack>
>  #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>  #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
>  #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
>  #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
>  #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
> crash>

Well that's bad.

> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node basis")

Merged in 2016.

Can you please describe how to reproduce this?  Under what circumstances
does it occur?  Why do you think it took eight years to be discovered?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1655,6 +1655,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>  	unsigned long skipped = 0;
>  	unsigned long scan, total_scan, nr_pages;
> +	unsigned long max_nr_skipped = 0;
>  	LIST_HEAD(folios_skipped);
>  
>  	total_scan = 0;
> @@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx ||
> -				skip_cma(folio, sc)) {
> +		/* Using max_nr_skipped to prevent hard LOCKUP*/
> +		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
> +			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc))) {
>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
> +			max_nr_skipped++;
>  			goto move;
>  		}

It looks like that will fix, but perhaps something more fundamental
needs to be done - we're doing a tremendous amount of pretty pointless
work here.  Answers to my above questions will help us resolve this.

Thanks.


