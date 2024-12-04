Return-Path: <linux-kernel+bounces-431507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B69E3E51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C48284201
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022CB20C017;
	Wed,  4 Dec 2024 15:29:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994871F6691
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326169; cv=none; b=fAWsy5cpq3xHz9gZ2iybtmaWPDlolASeMBQ10B9QL8wpS+TkRnGpy3D7NJex3HjFR2WzE0xEdQHzLP9y7p6OiUrIyZiYLY5jC1KmGGQxEbRHvWURVR2Tjv/1uPxEe+OU07ka4YI9B9yEC7isSHb4g4LKaoUUMmybAn8HJvIlvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326169; c=relaxed/simple;
	bh=kU7TKuQLnTJjbPsnNCquzJ2GqPFyfU4N6+bw7inG1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZXpEcjyU3HPGPrvzceN/V0defn4f9WTu3io0WXhK2M9fzTKbVNMYa6AsKEYZxSHgJtLaT+5CvE+miiepRuj3zXHQbMIn03Tu512UMPFfoOz1XEAf/BVT5ma99Wv5JrUY3NVr6C5YRc/e7RPYOc0nUsZqLrvdtzZ4/z802JFYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9298C4CECD;
	Wed,  4 Dec 2024 15:29:27 +0000 (UTC)
Date: Wed, 4 Dec 2024 15:29:25 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: David Hildenbrand <david@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
Message-ID: <Z1B1VS8PayXsXDzl@arm.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap>
 <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
 <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
 <6aec1d44-4a89-4acf-a16b-4493626b93bb@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aec1d44-4a89-4acf-a16b-4493626b93bb@os.amperecomputing.com>

On Mon, Dec 02, 2024 at 08:22:57AM -0800, Yang Shi wrote:
> On 11/28/24 1:56 AM, David Hildenbrand wrote:
> > On 28.11.24 02:21, Yang Shi wrote:
> > > > > diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> > > > > index 87b3f1a25535..ef303a2262c5 100644
> > > > > --- a/arch/arm64/mm/copypage.c
> > > > > +++ b/arch/arm64/mm/copypage.c
> > > > > @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct
> > > > > page *from)
> > > > >         if (!system_supports_mte())
> > > > >             return;
> > > > > -    if (folio_test_hugetlb(src) &&
> > > > > -        folio_test_hugetlb_mte_tagged(src)) {
> > > > > -        if (!folio_try_hugetlb_mte_tagging(dst))
> > > > > +    if (folio_test_hugetlb(src)) {
> > > > > +        if (!folio_test_hugetlb_mte_tagged(src) ||
> > > > > +            !folio_try_hugetlb_mte_tagging(dst))
> > > > >                 return;
> > > > >             /*
> > > > I wonder why we had a 'return' here originally rather than a
> > > > WARN_ON_ONCE() as we do further down for the page case. Do you seen any
> > > > issue with the hunk below? Destination should be a new folio and not
> > > > tagged yet:
> > > 
> > > Yes, I did see problem. Because we copy tags for all sub pages then set
> > > folio mte tagged when copying the data for the first subpage. The
> > > warning will be triggered when we copy the second subpage.
> > 
> > It's rather weird, though. We're instructed to copy a single page, yet
> > copy tags for all pages.
> > 
> > This really only makes sense when called from folio_copy(), where we are
> > guaranteed to copy all pages.
> > 
> > I'm starting to wonder if we should be able to hook into / overload
> > folio_copy() instead, to just handle the complete hugetlb copy ourselves
> > in one shot, and assume that copy_highpage() will never be called for
> > hugetlb pages (WARN and don't copy tags).
> 
> Actually folio_copy() is just called by migration. Copy huge page in CoW is
> more complicated and uses copy_user_highpage()->copy_highpage() instead of
> folio_copy(). It may start the page copy from any subpage. For example, if
> the CoW is triggered by accessing to the address in the middle of 2M. Kernel
> may copy the second half first then the first half to guarantee the accessed
> data in cache.

Still trying to understand the possible call paths here. If we get a
write fault on a large folio, does the core code allocate a folio of the
same size for CoW or it starts with smaller ones? wp_page_copy()
allocates order 0 AFAICT, though if it was a pmd fault, it takes a
different path in handle_mm_fault(). But we also have huge pages using
contiguous ptes.

Unless the source and destinations folios are exactly the same size, it
will break many assumptions in the code above. Going the other way
around is also wrong, dst larger than src, we are not initialising the
whole dst folio.

Maybe going back to per-page PG_mte_tagged flag rather than per-folio
would keep things simple, less risk of wrong assumptions.

-- 
Catalin

