Return-Path: <linux-kernel+bounces-417320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B09D5276
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E554284138
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033F1A76CD;
	Thu, 21 Nov 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WJIKJtfx"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82D132103
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213543; cv=none; b=Obuagl2Vd0T6Bxb7BZVFBtrRdh62m6KYeGrbF33PhlHZGTSLtneN7KlhXOoipKNyXN2KFRazhY5jUKX/OSe9FAGVsl42px2nqzBLBqWr+cS9q0P91YWSmhV7D+h6Fc2fqkicRb5ic7W2wDSP1wyBKPohakKla7jLYF+k3xjvf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213543; c=relaxed/simple;
	bh=0wE3l4m1m0hNwd/Un5FYT9Yj4dq6U/EdkDXFWkje3XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c31TsyhD3W1lDUZ6/urjm3kO7+wNsWODX8Wi/7+Jd7qZ2qc8IJ0F4wuIhAyHDyd3/VT/Wg/P5hTDsSOIMdwhquKLzSR2ixO+JGdEcvy3Dyzz0XNH7RF3+vXt2oeBTaMnxDqS309KbINxcAUYhZSsuMuIaFW3F0lhZP8gME9QN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WJIKJtfx; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Nov 2024 10:25:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732213534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ihkFpriMDTn2R0Csp6uPIGw12MhtUrO0pmOXiS0fygo=;
	b=WJIKJtfxJw6Tz2pnpC6xE1Aq42D6R3khV5PxF1ZUKlQPDYIleYJB3h1hCY2dHlvoFOYsDG
	y0gLxXQJQNjPW9zBdiMbDsrIZxOl7/NbaF26QTv7fZ42XN3jX8olhmfsy/VxlN4X80HJIG
	Rykl7Xr6u7FUxcdg6x8w+Al7STALnA8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, oleg@redhat.com, 
	dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v4 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <dqr5leslr2mesdzkgk6s7tb2nzrzbov37lisfufxe6ouwrlmc7@sgqolm5gmcjf>
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-3-surenb@google.com>
 <zfd7xdkr5dkvvx3caqao3oorh2pxxifhdhwsw2iyxcuzbevo3n@sobu7xhw24vv>
 <CAJuCfpFAh-gw_BVCaEB4+saedVC6aPB7HfyPikvTujyGRLXPwQ@mail.gmail.com>
 <wnwfgk32wyvx7tzd522ajwk5uixls7iayksrtho6c3dkvgdpek@25yqv3ohljzc>
 <CAJuCfpGx6LCd7qCOsLc6hm-qMGtyM3ceitYbRdx1yKPHFHT-jQ@mail.gmail.com>
 <iw34akksaz6wjlygwuztlkvto3aiduekrhw6rjlqq4lr7vzmug@tprkddvgrj3e>
 <CAJuCfpHVQyVGR9sPtKLYt4a7rQUUopX0cBfk53=3RqpYK4=V8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHVQyVGR9sPtKLYt4a7rQUUopX0cBfk53=3RqpYK4=V8w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 21, 2024 at 09:05:21AM -0800, Suren Baghdasaryan wrote:
[...]
> 
> Sorry, I should have been more clear. It's ok if some fields which are
> rarely accessed in the pagefault path are placed in the same cacheling
> with vm_lock. In fact I've done that to pack them better in the
> previous version of this patchset here:
> https://lore.kernel.org/all/20241111205506.3404479-5-surenb@google.com/
> (removed for now based on the feedback). So, vm_lock being the only
> field on the cacheline is not my goal. After this patchset I'm
> planning to try packing the members better and save some memory.
> 

Nah, my bad, somehow I thought you want vm_lock to be on a cacheline
alone.

