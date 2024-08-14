Return-Path: <linux-kernel+bounces-287205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000795249B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95071F22B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707C1BF327;
	Wed, 14 Aug 2024 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jUtCI6LB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847013BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670176; cv=none; b=CUmtdYhrgxu5MUNfiBna/qzOOiZzUpJ1J5YpMKTBsqkiPW2/N8lZhMOq4ZIdfMh6BN6ZvbczaFWXYhHc7eiO3JQAJ0QVlob0d9XlNUEwAfyYreNWwF3q8BK0bTxx+CCd7+8vnzy26tXM/k0v5dS097cPbRFZxlvwOK/uAFj16mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670176; c=relaxed/simple;
	bh=arcrQUXCs+GsDc20YERmB/02EaM59ZtcKl2ujmgBtDA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PcxG8PaTEfiQlv+CwETnPJ+oT7C+O1WZ0ltYWPvw8F/5c3Xdgg+vxM5xqGRQeEXW8BFpoiXldGPIxbj7rTAfOkhwv9iyc1hFCwGRcIZYLgkQso4LIdTgVNACDSAz7bN6mjf2oxiKx8fBBXb9EoDhUdXpjPjNntjSIw4kPXYQ3DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jUtCI6LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AB6C116B1;
	Wed, 14 Aug 2024 21:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723670175;
	bh=arcrQUXCs+GsDc20YERmB/02EaM59ZtcKl2ujmgBtDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUtCI6LBRlGakJIwoFUmJz4H/qsFz4MJ1w/EA6jDmvr54VcgFsxIegdnPMVpSfZWd
	 CEoitFafRq8YN4a//6HU96MTJGY8k9g2gQ0bIOcC9ZCJWwrEqx+wIOTdXCHsdr82MG
	 Vm1cAAvQ035+KWqdZJLg6it4j23r1VuEgAlzQ0rk=
Date: Wed, 14 Aug 2024 14:16:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: npiggin@gmail.com, david@redhat.com, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: whack now bogus comment in pmd_install() concerning
 a fence
Message-Id: <20240814141614.56337d7cd3f0671d8edc7676@linux-foundation.org>
In-Reply-To: <20240814145256.1683498-1-mjguzik@gmail.com>
References: <20240814145256.1683498-1-mjguzik@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 16:52:56 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> Commit 362a61ad6119 ("fix SMP data race in pagetable setup vs walking")
> added the following:
> 
> +       smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> +
>         spin_lock(&mm->page_table_lock);
> 
> However, over the years the fence along with the comment got moved
> around the file, eventually landing in a spot where it is *NOT* followed
> by a lock acquire (or any other operation which might happen to provide
> any fence on a given arch), rendering the comment stale.
> 
> ...
>
> I fully concede I could not be arsed to check if the fence is still
> needed to begin with, I ran into this while looking at something else.
> The comment puzzled me for a minute suggesting pmd_populate has an
> immediate lock acquire inside.
> 
> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -436,7 +436,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>  		 * seen in-order. See the alpha page table accessors for the
>  		 * smp_rmb() barriers in page table walking code.
>  		 */
> -		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> +		smp_wmb();
>  		pmd_populate(mm, pmd, *pte);
>  		*pte = NULL;
>  	}

It's best to document all such barriers, so the preferred patch would
be to fix the comment rather than removing it.

And if the barrier now does nothing then of course removing the thing
would be best.

So I'd suggest that the wrong comment be left there, if only to tell
developers why the barrier used to be there!

