Return-Path: <linux-kernel+bounces-388521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDB9B60AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C9C1F2403B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA11E47BB;
	Wed, 30 Oct 2024 10:59:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D011E411D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285942; cv=none; b=bCAuskQsP3SQmHU9TcHpms087IBsTWTE+v8u3rVX5FlXV3QHNi3z8Xsulpu3c5WPOZ9salb5D3PwPPltkwdB96mbV6s4NDCplE2DX1/vv7dbaT00Z6C2mrVUSRrtsKpvvaTyHHsJmZz4FCgjUFC7ilQp9ToFMGoYvLEHy5sR7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285942; c=relaxed/simple;
	bh=6GznzaElKzmY+QIcesOnQLip4iSZjEl02mWz8yuuspY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVO31lz43RboxG4VqmoZZR2nM4vRkkNs7jLnwRi5cFRbycJ4fkzSOiEumOw0L02JEMj4gada19DA/3Hu50YuFNsk9oxmjwLCP68IbHF01BQJ+ufiWBimNYcbKwVFjalqiCh5I4s9BLbqxBAH8SPdbvzB92sv6R8yqAE31SHmqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408BF113E;
	Wed, 30 Oct 2024 03:59:28 -0700 (PDT)
Received: from arm.com (RQ4T19M611.cambridge.arm.com [10.1.32.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D703F66E;
	Wed, 30 Oct 2024 03:58:55 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:58:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <ZyIRbbA-_8duD2hH@arm.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>

On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
> On 10/29/24 19:11, Lorenzo Stoakes wrote:
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -6,6 +6,8 @@
> > 
> >  #ifndef BUILD_VDSO
> >  #include <linux/compiler.h>
> > +#include <linux/fs.h>
> > +#include <linux/shmem_fs.h>
> >  #include <linux/types.h>
> > 
> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >  }
> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> > 
> > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> > +						   unsigned long flags)
> >  {
> >  	/*
> >  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
> >  	 * filesystem supporting MTE (RAM-based).
> 
> We should also eventually remove the last sentence or even replace it with
> its negation, or somebody might try reintroducing the pattern that won't
> work anymore (wasn't there such a hugetlbfs thing in -next?).

I agree, we should update this comment as well though as a fix this
patch is fine for now.

There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
should still work after the above change but we'd need to move it over
here (and fix the comment at the same time). We'll probably do it around
-rc1 or maybe earlier once this fix hits mainline. I don't think we have
an equivalent of shmem_file() for hugetlbfs, we'll need to figure
something out.

> >  	 */
> > -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> > +	if (system_supports_mte() &&
> > +	    ((flags & MAP_ANONYMOUS) || shmem_file(file)))
> >  		return VM_MTE_ALLOWED;
> > 
> >  	return 0;
> >  }

This will conflict with the arm64 for-next/core tree as it's adding
a MAP_HUGETLB check. Trivial resolution though, Stephen will handle it.

-- 
Catalin

