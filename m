Return-Path: <linux-kernel+bounces-210398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60E904321
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B481F2581F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35959155;
	Tue, 11 Jun 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dFW0x7S7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D238FA1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129185; cv=none; b=t7guIURdK6QCkW0sK0i4mwrkxDmWVkBBgB78Si8pdWXqJxIwM+Xq/FU8zAkclwFThrSuqQGmhEg3eaiPCRgC5jDoU/JnbMlbPrC2j2UG45RmBN7gSyMicCg2yQOQj+NC56mYh7H00fC9bJznQqT1Bpp327jrJS0np087jgxuL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129185; c=relaxed/simple;
	bh=5V3/7kPRGhX2TYIGvhBMIKpEQCAwbPW0sZckSsfrzWs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iCKPHsDN7Zx7sxqh3IoV9OLhV350jeRLT34PG6hah2n7OFtPw87oU0SqiEMGEEQt479gI03MyhfERO+NT4zgGw3H++TSi+MCB0HmyfPYynzMOuaqrHtTbrCv5Ngk9vqx4U2m6olIibjDOtTVPZXFrJ4JwsUgZ/v+8Xa63IykJnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dFW0x7S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81075C2BD10;
	Tue, 11 Jun 2024 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718129183;
	bh=5V3/7kPRGhX2TYIGvhBMIKpEQCAwbPW0sZckSsfrzWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFW0x7S7mNWIQoARVeWzcpBEbSVee/D78573Rn20SoA7QdQg5VWRYHZnXXTnlI2Ns
	 4dF0/tF11libYL2OiyoLWM+d5UIYem7jje89glD+BfzhyG5pQz4+C6Ur9VPRt8atl/
	 cwMw7GsBr0A9G630qeNkvmiTkA37sdkINghyA1YI=
Date: Tue, 11 Jun 2024 11:06:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-Id: <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>
In-Reply-To: <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
	<8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 11.06.24 17:32, Andrew Bresticker wrote:
> > The requirement that the head page be passed to do_set_pmd() was added
> > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > finish_fault() and filemap_map_pages() paths if the page to be inserted
> > is anything but the head page for an otherwise suitable vma and pmd-sized
> > page.
> > 
> > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > ---
> >   mm/memory.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0f47a533014e..a1fce5ddacb3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> >   		return ret;
> >   
> > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> >   		return ret;
> > +	page = &folio->page;
> >   
> >   	/*
> >   	 * Just backoff if any subpage of a THP is corrupted otherwise
> 
> Acked-by: David Hildenbrand <david@redhat.com>

You know what I'm going to ask ;) I'm assuming that the runtime effects
are "small performance optimization" and that "should we backport the
fix" is "no".


