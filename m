Return-Path: <linux-kernel+bounces-381196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752839AFBD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67271C20C63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2B1C0DD3;
	Fri, 25 Oct 2024 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbw6vaNS"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA619993F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843326; cv=none; b=BHWeCBa9N9JNbALGYxXUr0ixJuIogD4FaKCdu0bE3NVc6qvXoWUxImtW561hn6/H6fXMlq8XetHTjqwb1yLrBpQvfP9CORQQut2sD4zp44pJt0tDn4LWAWzJoE5IuQ8A2fyTE6UurL68vaJQjrRIZW0sU71dHYPa9KTJmgDsGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843326; c=relaxed/simple;
	bh=FDq7yD0hF6lOS2LXDPRtGG2v2ZB1qM35KTgg1ZmT1a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvYvfdzQPvNVSfC/5yaDWJ4aJ/G71UGuORptLiglC3T721NBTVpn4lcOmvQS68uyBn7ouRw3GuHg186N/O3ilZYdurBhbrWrUNs9BTqMEsAn1KVhhE4zJTqJ1zotJUeC33TSFhy9Bzdb3LYSMGe5D0AapvRA/ZSF7Kb9Q+p9MtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gbw6vaNS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bQyEv6w0dS6Sjo/cnKh1bWjpD+CvKaIoOZsUuJry4Ek=; b=gbw6vaNS6qHRUFhSy4bke0JNUv
	NLacseUjPM/kpv5T/VBN7RegfVFB8MR6nFz51azOz3lXKmXK/Oo6b7oYAlwZgc0Zlzuq9VJbuqsGj
	DAKd5kUMszciNIPv9dgvqrYH5FpgsILRdIyilRQ7/tgZg2zWPawdYooWkVYqQUpwAjbBYReJzHJwl
	cXSb+FHyYSJXrYlrlDFFDOPHtsDPvzQhXgtPmruYxhnwTsAY5Z1NXJrY30qkxn/cFFBEqXnswEdDy
	0B93fiKLzygb8l5VoFEZ8e4HtFmzdd7yM66YnnjHuHxDZeEGeSG2sRgcA0cvGiRS5tBuXfmRCYmHc
	WMNAScmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4FGj-00000008rDb-1eON;
	Fri, 25 Oct 2024 08:02:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12BCE30083E; Fri, 25 Oct 2024 10:02:01 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:02:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/osq_lock: Use atomic_try_cmpxchg_release() in
 osq_unlock()
Message-ID: <20241025080200.GD14555@noisy.programming.kicks-ass.net>
References: <20241001114606.820277-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001114606.820277-1-ubizjak@gmail.com>

On Tue, Oct 01, 2024 at 01:45:57PM +0200, Uros Bizjak wrote:
> Replace this pattern in osq_unlock():
> 
>     atomic_cmpxchg(*ptr, old, new) == old
> 
> ... with the simpler and faster:
> 
>     atomic_try_cmpxchg(*ptr, &old, new)
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after the CMPXCHG.  The code
> in the fast path of osq_unlock() improves from:
> 
>  11b:	31 c9                	xor    %ecx,%ecx
>  11d:	8d 50 01             	lea    0x1(%rax),%edx
>  120:	89 d0                	mov    %edx,%eax
>  122:	f0 0f b1 0f          	lock cmpxchg %ecx,(%rdi)
>  126:	39 c2                	cmp    %eax,%edx
>  128:	75 05                	jne    12f <...>
> 
> to:
> 
>  12b:	31 d2                	xor    %edx,%edx
>  12d:	83 c0 01             	add    $0x1,%eax
>  130:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
>  134:	75 05                	jne    13b <...>
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Thanks!

