Return-Path: <linux-kernel+bounces-305617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021B96313B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636E11C23BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C41AC43F;
	Wed, 28 Aug 2024 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bAqfn67/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A874125BA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874572; cv=none; b=cH50HSI9WYktCJDC4rqKryhbcIwyAQ885AH7wYevmJkG9QvTnOtSIZOJ5jWvmV9V6YWvag/cdhns7ZNicASyElKNl47khzeVXBonCi+qaE2o9lPlHKMSFq0dNFSZlqY4SRUs8ebR2skrRuyvy9UQPWOACsjlQdoGCOjIUz4jc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874572; c=relaxed/simple;
	bh=uDcyA+6qAGpnE7k34XCBcDJUi1OcpU22jJPtmtYD+cE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M/Z+fLwrDK0fBO84GoxywX356HerBNPmJrte3CFb95PGOSLfcmlGLdCnigbmbmaFT1GOE68m/Q84BBOt3NnDPRhKDHbT5q/9wYeIu7b54jqDTf3pKELBWWpttPAs/Ji0azS3IOmZju3lNx+/OvUEkI7iB4vGxLT0Rfnspe1d2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bAqfn67/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCF1C4CEC0;
	Wed, 28 Aug 2024 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724874571;
	bh=uDcyA+6qAGpnE7k34XCBcDJUi1OcpU22jJPtmtYD+cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bAqfn67/dDcTgES+k7FqIUMgXnc/WDD1hNBIq5/avDt5Vbjx2Eoq+W1RAC9vJWQLP
	 BCOIBFSfrDXHLxehVeIMf6qHDiDbAPhzt/a2QhbzGNHcQhMg6JAH9yzad/8E+6MvEx
	 9/pTw74pqILRUSjQNKKr3lef+Wn3S9aSiK4kuVPw=
Date: Wed, 28 Aug 2024 12:49:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: muchun.song@linux.dev, dave@stgolabs.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetlb: sort out global lock annotations
Message-Id: <20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
In-Reply-To: <20240828160704.1425767-1-mjguzik@gmail.com>
References: <20240828160704.1425767-1-mjguzik@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 18:07:04 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> The mutex array pointer shares a cacheline with the spinlock:
> ffffffff84187480 B hugetlb_fault_mutex_table
> ffffffff84187488 B hugetlb_lock

Fair enough.  My x86_64 defconfig now has

num_fault_mutexes:
	.zero	4
	.globl	hugetlb_lock
	.section	.data..cacheline_aligned,"aw"
	.align 64
	.type	hugetlb_lock, @object
	.size	hugetlb_lock, 4
hugetlb_lock:
	.zero	4
	.section	.init.data
	.align 32
	.type	default_hugepages_in_node, @object
	.size	default_hugepages_in_node, 256
default_hugepages_in_node:
	.zero	256
	.type	parsed_default_hugepagesz, @object
	.size	parsed_default_hugepagesz, 1

which looks good.

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -72,14 +72,14 @@ static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
>   * free_huge_pages, and surplus_huge_pages.
>   */
> -DEFINE_SPINLOCK(hugetlb_lock);
> +__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
>  
>  /*
>   * Serializes faults on the same logical page.  This is used to
>   * prevent spurious OOMs when the hugepage pool is fully utilized.
>   */
> -static int num_fault_mutexes;
> -struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
> +static __ro_after_init int num_fault_mutexes;
> +__ro_after_init struct mutex *hugetlb_fault_mutex_table;

It's conventional (within MM, at least) to put the section thing at the
end of the definition, so tweak:

--- a/mm/hugetlb.c~mm-hugetlb-sort-out-global-lock-annotations-fix
+++ a/mm/hugetlb.c
@@ -72,14 +72,14 @@ static unsigned int default_hugepages_in
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
  */
-__cacheline_aligned_in_smp DEFINE_SPINLOCK(hugetlb_lock);
+DEFINE_SPINLOCK(hugetlb_lock) __cacheline_aligned_in_smp;
 
 /*
  * Serializes faults on the same logical page.  This is used to
  * prevent spurious OOMs when the hugepage pool is fully utilized.
  */
-static __ro_after_init int num_fault_mutexes;
-__ro_after_init struct mutex *hugetlb_fault_mutex_table;
+static int num_fault_mutexes __ro_after_init;
+struct mutex *hugetlb_fault_mutex_table __ro_after_init;
 
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
_



