Return-Path: <linux-kernel+bounces-518665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C568BA392C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1137A2C94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9521B0F1B;
	Tue, 18 Feb 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JxKlG4ty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707C17333F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857424; cv=none; b=HNXxyjIa0UXTxcLKD1dKHDKdlIvOeTLTqGIEbvF+V3qkS+5sM0lWxvfeUmj+a09pE4D+RIcRudo886pc+kGV3ked2hOVK7ZjICBLgINawU+J3qz2BC7twYffkcba6KPsEilZw+0q5CYpl5VlJl3Hy2ozwJVlNk7lFDzNGbQ/hks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857424; c=relaxed/simple;
	bh=c8ugb5vVheAc9cwzUUjLFQj1ORaS84bus1ywYNJikEk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a9qfQpOhIKpLZ9lAazBTUq5fFYy7SC7N26/BeyIBIw+PV26wtLSOmq6ZsEJzMn3eRWS7ybWBLGCUOfTkJ2I3FRLM5nAXNdz4WE5Osg83p8xI+59dCLixKW/aCqNIPD0WXK1gZcuj3yQGI/qOUBIcrLtOgiS/s/qKJOaX/Pf37Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JxKlG4ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17365C4CEE2;
	Tue, 18 Feb 2025 05:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739857423;
	bh=c8ugb5vVheAc9cwzUUjLFQj1ORaS84bus1ywYNJikEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxKlG4tynKxz73PrXuKmzSI6fg8+Z5K+EBp7nBkjy5TDpovYV6EFQ1Mh4gnxO0+Fc
	 nOB5es7L1w+XidGc9lvyjuNpM7isman+mtxeFBW8aye5s0rmSYbzrxNH5Xa89jqfsB
	 EVNsqmdBYP986dJCYBSVd1E20h7kjJ1HrKg8nuiY=
Date: Mon, 17 Feb 2025 21:43:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com>
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 linux-kernel@vger.kernel.org, osalvador@suse.de, byungchul@sk.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 max.byungchul.park@sk.com, max.byungchul.park@gmail.com
Subject: Re: [PATCH 1/1] x86/vmemmap: Use direct-mapped VA instead of
 vmemmap-based VA
Message-Id: <20250217214342.33b4fcc4e775cf5ca70053a0@linux-foundation.org>
In-Reply-To: <Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
References: <20250217114133.400063-1-gwan-gyeong.mun@intel.com>
	<20250217114133.400063-2-gwan-gyeong.mun@intel.com>
	<Z7QaPwI1eMPEwHii@MacBook-Air-5.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 14:27:27 +0900 "Harry Yoo (Oracle)" <42.hyeyoo@gmail.com> wrote:

> > page table when accessing a vmemmap-based virtual address before this sync.
> > 
> > Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
> > Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> I think this fix is reasonable without changing existing code too much.
> Any thoughts from x86 folks?
> 
> > Cc: Byungchul Park <byungchul@sk.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> Shouldn't we add Cc: <stable@vger.kernel.org>?

I'd say so, yes.  For many subsystems, a Fixes: means that -stable
maintainers will automatically scoop it up.  For mm patches they have
been asked to not do that - such patches require an explicit cc:stable
(the MM developers wish to determine what is backported).

An explicit cc:stable removes all doubt.

Also, this patch should have cc'ed linux-mm, please.

Anyway, I'll grab it pending additional review and I'll add the
cc:stable, thanks.


