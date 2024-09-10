Return-Path: <linux-kernel+bounces-323556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D040B973F47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BE71C256DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934371A4AAA;
	Tue, 10 Sep 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9InMk0/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DF1A4ABC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988846; cv=none; b=Tc5EXCcabWMCi+H07pOP3eTeHGXiPKgBHRDqx1Kwdbkx6BWKy7l1Uu2/Eu372Z50Cdi+NJAYqcKqqpoNv4LaNBA7uhlGDM/unstyf4F+AfjrBW4IbHngfWWWLVdYQbYnvD+zBmrdCoBPeX36f53FfqBuM0L+asiPY7p7/VT7/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988846; c=relaxed/simple;
	bh=O93Rw1E277qhSF7bH5agqyi6+nvKYYCU8Nk4kqBhcGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1dEP5E5iJpA7XGMBarP6GAgpe3ZGA7TUDgZFpJAO0V7PzhKZiA6kwuRCSiJV8rM+8dXkvK2qfmU495MweUthQ/S+ntnYYnEspinsKf0lujfh6coLUBIFOJYXg6pR4jJRq8O/Y9h+FH5JNkUkGM7WlDsWKBe43LzFLxSP6qBajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i9InMk0/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OjKqo8IT8Dm4G10bvKkMI+1QL7t06KGHpM+aIqqBOtI=; b=i9InMk0/8QoG2hGeu9bjCkGgot
	K71BplXZ6thqiZtpju1UR6soh7R+uybndCA+nr8tz1DjJGdMY9d07CQTHy9A9nxBNyEzGzb6EAr3T
	uUlaV25ZoPNOowoROO7WXS6+G/Y4TyKV1vD1qaJ0GFO3kj8gNKE8y0x5CjweQTz852lm6L/Qbil1r
	vSUYds2EF1Xgug2gwg+6D38LOTJtILqumaXoDS1U2gmx8YOHjgOnoIqRmuQZeXT1NxBmolmHiNwf6
	bYvaDuovStcN5zymNoqBSFyNQFqlaaDCDBBD4h+M43zGDK66dpqYNqoxEnNtd2lRTpzFpDqG0i8Ie
	4mlgzmaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1so4Xf-0000000DE92-1IdE;
	Tue, 10 Sep 2024 17:20:39 +0000
Date: Tue, 10 Sep 2024 18:20:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Drop unused set_pte_safe()
Message-ID: <ZuB_524Dd1tezlX6@casper.infradead.org>
References: <20240910090409.374424-1-anshuman.khandual@arm.com>
 <cae9c32d-c96e-463e-9375-91d9a7ad196a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae9c32d-c96e-463e-9375-91d9a7ad196a@arm.com>

On Tue, Sep 10, 2024 at 10:08:10AM +0100, Ryan Roberts wrote:
> On 10/09/2024 10:04, Anshuman Khandual wrote:
> > All set_pte_safe() usage have been dropped after the commit eccd906484d1
> > ("x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page")
> > This just drops now unused helper set_pte_safe().
> 
> It would be good to add some comment here to mention that the macro was buggy
> due to doing direct dereferencing of the pte, and that if it were to be kept, it
> should have been updated to use a single call to ptep_get().

I'm not sure that the _macro_ would have been buggy in such a scenario.
If I understand correctly, the _caller_ would have been buggy:

/*
 * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
 * TLB flush will be required as a result of the "set". For example, use
 * in scenarios where it is known ahead of time that the routine is
 * setting non-present entries, or re-setting an existing entry to the
 * same value. Otherwise, use the typical "set" helpers and flush the
 * TLB.
 */

so if *ptep changes between the two calls, that's the caller's bug,
right?

Otherwise, set_pmd_safe() would be buggy ...

> With that:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Thanks,
> Ryan
> 
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/pgtable.h | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 2a6a3cccfc36..aeabbf0db7c8 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -1058,12 +1058,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
> >   * same value. Otherwise, use the typical "set" helpers and flush the
> >   * TLB.
> >   */
> > -#define set_pte_safe(ptep, pte) \
> > -({ \
> > -	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
> > -	set_pte(ptep, pte); \
> > -})
> > -
> >  #define set_pmd_safe(pmdp, pmd) \
> >  ({ \
> >  	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
> 
> 

