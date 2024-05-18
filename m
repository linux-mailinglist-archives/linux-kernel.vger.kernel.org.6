Return-Path: <linux-kernel+bounces-183001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64FD8C9312
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78711C20A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6616CDCC;
	Sat, 18 May 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3OhCE7p"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954438FB9
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716075089; cv=none; b=EGtUwOi0GsiRGiHsB+SF/+rbBfmhlDKp739wggEu2v7Dsz4zSE81HFfs0EFsaO5/X4F5OxohGTIFlqmuOA/k/BHNMnaH9HYBcyQxeKztoiraUj0xAnSGDUb9TymuqhiK6OpTcN4SBvwZO6/2fhcQHg+MmqAXYIihxcFI+Cv1Drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716075089; c=relaxed/simple;
	bh=pPd/g1ahx2EgZLBSSdG/1UWFpzPRQqLD484s0OYtnvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XygB+buvriu6QDXDPqaT/M7ThymkakRnt9WaO8l2h/AQnGGII2irfEyno7KDDCpmT87rcszGaLY41G6eQxlMxJEdDgja8X+wXuWsdYaVg9UkNajwxYLN+KQs8FRJkVseEhwPu66goBJjOCRaDJve5fuxUeW7nFikWcuDdf+G4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k3OhCE7p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3c+zav5RRUM3yh91jgmhYbjJOd21xZVsPB4CAi0Cfzk=; b=k3OhCE7p+QlmQHFC6AZ3SDcEaa
	g4E385k5EQhYbTnHW1lNLu0tuCokHHw6kiS2GtSAKY8POV/+FZMRLjHk3ty4GiPkh7yuKXH7AFTFH
	xzAmLv6I/fAflrVqrrV67JtsUJ1oDIPtGCkSYx5KR4bsjFev8HvGCybi5I6mvMkpSVTI9smw2fUSC
	HaSnNButmTZeSgrPcTrmj0HCRkawDuWZB2D5rDQarnRHEA/MPDMLyEe7UlMqtnKOiW4wdfdXl8GVd
	2aYs45zO7hWdzQ+v+/kksJGIW7o55rLxSM4nLG9V6/dedktrGC6eBOlJVrOHIbq3S4fTL1p1It38i
	/h6EKXdA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8TWK-0000000EXqc-2VQ9;
	Sat, 18 May 2024 23:31:20 +0000
Date: Sun, 19 May 2024 00:31:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lstoakes@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: batch unlink_file_vma calls in free_pgd_range
Message-ID: <Zkk6SCZl70o3WXpW@casper.infradead.org>
References: <20240518062005.76129-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518062005.76129-1-mjguzik@gmail.com>

On Sat, May 18, 2024 at 08:20:05AM +0200, Mateusz Guzik wrote:
> Execs of dynamically linked binaries at 20-ish cores are bottlenecked on
> the i_mmap_rwsem semaphore, while the biggest singular contributor is
> free_pgd_range inducing the lock acquire back-to-back for all
> consecutive mappings of a given file.
> 
> Tracing the count of said acquires while building the kernel shows:
> [1, 2)     799579 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [2, 3)          0 |                                                    |
> [3, 4)       3009 |                                                    |
> [4, 5)       3009 |                                                    |
> [5, 6)     326442 |@@@@@@@@@@@@@@@@@@@@@                               |

This makes sense.  A snippet of /proc/self/maps:

7f0a44725000-7f0a4474b000 r--p 00000000 fe:01 100663437                  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0a4474b000-7f0a448a0000 r-xp 00026000 fe:01 100663437                  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0a448a0000-7f0a448f4000 r--p 0017b000 fe:01 100663437                  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0a448f4000-7f0a448f8000 r--p 001cf000 fe:01 100663437                  /usr/lib/x86_64-linux-gnu/libc.so.6
7f0a448f8000-7f0a448fa000 rw-p 001d3000 fe:01 100663437                  /usr/lib/x86_64-linux-gnu/libc.so.6

so we frequently have the same file mmaped five times in a row.

> The lock remains the main bottleneck, I have not looked at other spots
> yet.

You're not the first to report high contention on this lock.
https://lore.kernel.org/all/20240202093407.12536-1-JonasZhou-oc@zhaoxin.com/
for example.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b6bdaa18b9e9..443d0c55df80 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

I do object to this going into mm.h.  mm/internal.h would be better.

I haven't reviewed the patch in depth, but I don't have a problem with
the idea.  I think it's only a stopgap and we really do need a better
data structure than this.

