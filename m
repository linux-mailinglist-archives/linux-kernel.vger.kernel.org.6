Return-Path: <linux-kernel+bounces-214058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAA907EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A34283857
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475114C587;
	Thu, 13 Jun 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aNoYeWqf"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72814B94C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317251; cv=none; b=a2SEdAOq41M4QBI2YFHGJeJyjomxB3tEX2KobTup346FliiKzYXbErWtCfuhmWzTUu7prQybWOesMJJRhbt/CVgs3hrLQeX265yQKcdRx23ZqteB7XRM9uXk5oiz0i9OW7innqrgR22HnEVGsOij3IEn1Vn9xLmP0JjQae01Z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317251; c=relaxed/simple;
	bh=LuKEuE0EH4Y7NZvpeCR+GP50oXGsR/1c6kBysvWYwbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHYuOWtcunPmxIZ36k/PqKW/tP0GLICUhXqCf9ErWswdKyaWD9qETdGnM7QUYcrsWW+InkFmoW9sYQytkMJ7uA6ShsM3c1XGRhOT87opQ8er6oe9YAxbHC7KQ6GrsnSSYWRf2kq4evhYrJ3otC/vrFp2G2XVGSOFTEslCPZq6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aNoYeWqf; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: baolin.wang@linux.alibaba.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718317247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DOjRV2qMXSqa61K018XbloRv0Vr29gi1LjCcbNkndkM=;
	b=aNoYeWqfAv7EELvNIqwUVRa+eCDyoTAKU1AXQkLcLwIn5g+sWamK7aVT4qvPOhuiTtstCw
	wfoB7xnTjSrzqyf7+zxF0UD6OvM2xRM26Y2cs0AYPZ5sAs90XKd9dn5kSAQu1TJqKYnC9n
	PNv8TwtyrDzSAnBHwwFNn2A5InoNh7g=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hughd@google.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 13 Jun 2024 15:20:42 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org, 
	nphamcs@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: fix getting incorrect lruvec when replacing a
 shmem folio
Message-ID: <mf3nogu57jxgb3mxlunktykpw4a4dsw6d2qrjkdpafoz7uc7jd@rkfd4ypqiyw6>
References: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c11000dd6c1df83015a8321a859e9775ebbc23e.1718266112.git.baolin.wang@linux.alibaba.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 04:21:19PM GMT, Baolin Wang wrote:
> When testing shmem swapin, I encountered the warning below on my machine.
> The reason is that replacing an old shmem folio with a new one causes
> mem_cgroup_migrate() to clear the old folio's memcg data. As a result,
> the old folio cannot get the correct memcg's lruvec needed to remove itself
> from the LRU list when it is being freed. This could lead to possible serious
> problems, such as LRU list crashes due to holding the wrong LRU lock, and
> incorrect LRU statistics.
> 
> To fix this issue, we can fallback to use the mem_cgroup_replace_folio()
> to replace the old shmem folio.
> 
> [ 5241.100311] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5d9960
> [ 5241.100317] head: order:4 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [ 5241.100319] flags: 0x17fffe0000040068(uptodate|lru|head|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
> [ 5241.100323] raw: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
> [ 5241.100325] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [ 5241.100326] head: 17fffe0000040068 fffffdffd6687948 fffffdffd69ae008 0000000000000000
> [ 5241.100327] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [ 5241.100328] head: 17fffe0000000204 fffffdffd6665801 ffffffffffffffff 0000000000000000
> [ 5241.100329] head: 0000000a00000010 0000000000000000 00000000ffffffff 0000000000000000
> [ 5241.100330] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
> [ 5241.100338] ------------[ cut here ]------------
> [ 5241.100339] WARNING: CPU: 19 PID: 78402 at include/linux/memcontrol.h:775 folio_lruvec_lock_irqsave+0x140/0x150
> [...]
> [ 5241.100374] pc : folio_lruvec_lock_irqsave+0x140/0x150
> [ 5241.100375] lr : folio_lruvec_lock_irqsave+0x138/0x150
> [ 5241.100376] sp : ffff80008b38b930
> [...]
> [ 5241.100398] Call trace:
> [ 5241.100399]  folio_lruvec_lock_irqsave+0x140/0x150
> [ 5241.100401]  __page_cache_release+0x90/0x300
> [ 5241.100404]  __folio_put+0x50/0x108
> [ 5241.100406]  shmem_replace_folio+0x1b4/0x240
> [ 5241.100409]  shmem_swapin_folio+0x314/0x528
> [ 5241.100411]  shmem_get_folio_gfp+0x3b4/0x930
> [ 5241.100412]  shmem_fault+0x74/0x160
> [ 5241.100414]  __do_fault+0x40/0x218
> [ 5241.100417]  do_shared_fault+0x34/0x1b0
> [ 5241.100419]  do_fault+0x40/0x168
> [ 5241.100420]  handle_pte_fault+0x80/0x228
> [ 5241.100422]  __handle_mm_fault+0x1c4/0x440
> [ 5241.100424]  handle_mm_fault+0x60/0x1f0
> [ 5241.100426]  do_page_fault+0x120/0x488
> [ 5241.100429]  do_translation_fault+0x4c/0x68
> [ 5241.100431]  do_mem_abort+0x48/0xa0
> [ 5241.100434]  el0_da+0x38/0xc0
> [ 5241.100436]  el0t_64_sync_handler+0x68/0xc0
> [ 5241.100437]  el0t_64_sync+0x14c/0x150
> [ 5241.100439] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 85ce2c517ade ("memcontrol: only transfer the memcg data for migration")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

One request: please add VM_BUG_ON_FOLIO(folio_test_lru(folio), folio) in
mem_cgroup_migrate().

