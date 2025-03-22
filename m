Return-Path: <linux-kernel+bounces-572594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C81A6CBF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3803A8EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D823315A;
	Sat, 22 Mar 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyI4sCRh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E71AA791;
	Sat, 22 Mar 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670752; cv=none; b=j6cJ8WiGrtKAvv0xbUFnzyFdIGRdsIGNUGegeZLQ0RP5++NqH8UBve/NL85+ikhY0lVKYGGv01KHTIRlfLQyPXSi5VqbHcajhIEMZAUJdvLFi7FUHcTPJGdxvRdOtK3Zjd5YGJRDDliueRVBj6fz7UM5h+2qjcH5pEO2zhdLAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670752; c=relaxed/simple;
	bh=hd78eeVosTOd4KlACodssv3XvVVN9zb3Aq9MsxkmGP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI1ZNrPK4yvzlMeS6chWbFVsB9tJDrLHK5NUI7eBBo5i0Rqx9fVFkl9+v+C4oHuR4J8h/HuUL5mjT3t3uA71RuDX14kwztZTYarEaPynbSuladCysjLhcyyI03B9NEYNldOTwBgD8VDz1LHS0d7jldrRgoYMZxhUdi7Wq5hME/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyI4sCRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6FEC4CEDD;
	Sat, 22 Mar 2025 19:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742670751;
	bh=hd78eeVosTOd4KlACodssv3XvVVN9zb3Aq9MsxkmGP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyI4sCRhX+wu+c82pLY5Dfs7mZt0ZonmFNJOxL8M1IVxv3HYH0tgIPU22CTgpZGvb
	 yU8CbZ9/hVu7m9ofuVRiJjaeapqr3YF2RVUBClPDNcsVD8oNweJQywUYhnV9t5lf/p
	 p16YBH3vAafJN32d7BmPXS+iJbxa/ymBFNEZKMBfh2fXO8xKpsJn4LAo+QY+VmbSbL
	 pTmlAfrb43SSsx8tKqn9n99/3fsN0qFoR+dgIk9ZAONTiuE0lcI3GqGzdWqAKZNE2E
	 P2nIkP7uUBe0lMxqdGdYLrF5iKd9mkfgg1Va4uJjSSIM2lXyoFWsO9LNnOCHZ1pcoC
	 GiRSBlpr3jx1w==
Date: Sat, 22 Mar 2025 15:12:26 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z98Lmo50h5RboFXq@kernel.org>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321134629.GA252045@nvidia.com>

On Fri, Mar 21, 2025 at 10:46:29AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 19, 2025 at 06:55:44PM -0700, Changyuan Lyu wrote:
> >
> > +static void deserialize_bitmap(unsigned int order,
> > +			       struct khoser_mem_bitmap_ptr *elm)
> > +{
> > +	struct kho_mem_phys_bits *bitmap = KHOSER_LOAD_PTR(elm->bitmap);
> > +	unsigned long bit;
> > +
> > +	for_each_set_bit(bit, bitmap->preserve, PRESERVE_BITS) {
> > +		int sz = 1 << (order + PAGE_SHIFT);
> > +		phys_addr_t phys =
> > +			elm->phys_start + (bit << (order + PAGE_SHIFT));
> > +		struct page *page = phys_to_page(phys);
> > +
> > +		memblock_reserve(phys, sz);
> > +		memblock_reserved_mark_noinit(phys, sz);
> 
> Mike asked about this earlier, is it work combining runs of set bits
> to increase sz? Or is this sort of temporary pending something better
> that doesn't rely on memblock_reserve?

This hunk actually came from me. I decided to keep it simple for now and
check what are the alternatives, like moving away from memblock_reserve(),
adding a maple_tree or even something else.

> > +		page->private = order;
> 
> Can't just set the page order directly? Why use private?

Setting the order means recreating the folio the way prep_compound_page()
does. I think it's better to postpone it until the folio is requested. This
way it might run after SMP is enabled. Besides, when we start allocating
folios separately from struct page, initializing it here would be a real
issue.
 
> Jason

-- 
Sincerely yours,
Mike.

