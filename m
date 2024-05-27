Return-Path: <linux-kernel+bounces-191252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B98D08D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F88B27514
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772C73441;
	Mon, 27 May 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmRdsKbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A261FE1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827670; cv=none; b=O/7rbnSuCWG/Zlt9LvrkeJ/yQUpMSmHX2QIXGUSwe/rb5DBk6eAwQ6bTR78XCp9U3wd329omMJsp6WNAVx40e/7NtGTmCOGy1feGEzI8JUz4PGTBhEsxGduS/cTZuB6wdd4qZoOKK2GXE01bUPjJmbl0ibyfd8XGXMD7KCh8eCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827670; c=relaxed/simple;
	bh=bl8ZlK/CAMRWrVdQ/hpu/WdQl8FR7dw4nzTZlB2IpRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7wcEsdDgkA19NIyWZ8ry14MvX5x+ZaQ02eowzli+QSdOMil3WBuxpKJJBKVmR32Qb2nI5sxfHIN+RJUlauMwgdVgWMK/zP9QUvG2vtbFH9cXkMi2M3fdpnRD3zlRT2nffCT/kSAIxJf0RRTiseMF/87DVicyBvD0yG+gCI6bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmRdsKbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB960C2BBFC;
	Mon, 27 May 2024 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827669;
	bh=bl8ZlK/CAMRWrVdQ/hpu/WdQl8FR7dw4nzTZlB2IpRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XmRdsKbgJbzTQX3HxnL8ihxsExEVY+oGZ4ReTwSwnp+tJFDu3yBrEMuz3760IFes7
	 ftNoC5Dy98t6wKQJbFQdyXxBRpJSNishbkLEEdvTma/Zpsad9qmi+RWU+JUwrJ9uwq
	 pPaInLLIzJDZDuMIiyelzlQDs8k09AFn0pnajkhdnn1S9LNSGXrSF+oh82vxwuR5rb
	 6bmhS51qTKvsLCXyBRJEvY3e4s2o5SsPUbQGZjZXdjHB4nBNss50VRArMOzeY2/6tU
	 FNjkdwcXtDOxdMgyMYYgKyOmUvDM2c1gzYzda6Hy98ns3/ePIXCfU84oUxA+6cZN9I
	 B0bkFNRqGa09g==
Message-ID: <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
Date: Mon, 27 May 2024 18:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240527152200.P1rU7FaG@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/24 5:22 PM, Sebastian Andrzej Siewior wrote:
> On 2024-04-20 16:25:05 [-0700], Shakeel Butt wrote:
>> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
>> and with always irq disabled. So, replace it with the irq disabled
>> version and add an assert that irq is disabled in the caller.
> 
> unless PREEMPT_RT is enabled. In that case IRQs are not disabled as part
> of local_lock_irqsave(&memcg_stock.stock_lock, …) leading to:

But then the "interrupts are handled by a kernel thread that can sleep" part
of RT also means it's ok to just have the stock_lock taken with no
interrupts disabled as no actual raw interrupt handler will interrupt the
holder and deadlock, right?

> | ------------[ cut here ]------------
> | WARNING: CPU: 0 PID: 1 at mm/memcontrol.c:3150 __mod_objcg_mlstate+0xc2/0x110
> | CPU: 0 PID: 1 Comm: systemd Not tainted 6.10.0-rc1-rt0+ #17
> | Call Trace:
> |  <TASK>
> |  mod_objcg_state+0x2b3/0x320
> |  __memcg_slab_post_alloc_hook+0x13c/0x340
> |  kmem_cache_alloc_lru_noprof+0x2bd/0x2e0
> |  alloc_inode+0x59/0xc0
> |  iget_locked+0xf0/0x290
> 
> suggestions?

So in that case the appropriate thing would be to replace the assert with
lockdep_assert_held(&memcg_stock.stock_lock);
?

It seems all the code paths leading here have that one.

> Sebastian
> 


