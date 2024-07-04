Return-Path: <linux-kernel+bounces-241174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E539277CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4EA285028
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB911AEFDD;
	Thu,  4 Jul 2024 14:08:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4851AED5F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102137; cv=none; b=etiZDtzMJ17aYy47POy25912K8dUQwVDTnMf3UBrsvvr7SYdvM8hpbMOggv0GHuMCOPkyp42sob2QrNG3ZeMrPQVYHI9kyXDNRaw2TwC4kCNtzoHQngmA/VZ7ulXgleclOXWrnQC4ZwvDNT9Kc3CvTJxG62i1SS/RfRWHNxTWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102137; c=relaxed/simple;
	bh=uHYJt87bnSQ3GbKcUHWE6Dnc9MYbDQlJOZ46YD2boTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFV+SHIUu2Vt7WThcyxdHySPK69+/y0xMBAz34bjLAu7Qu8YubiJDg8gHRAZiiimnpijwAhLxYOcUcOus/9WzeNGn9fmObWMlIWjs1CtAPVg+jD7oh4wALH6hhMVMOnPQG7yIbd9jqj7V+QeyQpm3fBsu03N66bY13hWxNLElHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75B8C3277B;
	Thu,  4 Jul 2024 14:08:55 +0000 (UTC)
Date: Thu, 4 Jul 2024 15:08:53 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] arm64: limit MAX_PHYSMEM_BITS based on vmemmap
Message-ID: <Zoas9V3sLEOzULhs@arm.com>
References: <20240703210707.1986816-1-scott@os.amperecomputing.com>
 <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com>

On Thu, Jul 04, 2024 at 08:42:52AM +0530, Anshuman Khandual wrote:
> On 7/4/24 02:37, D Scott Phillips wrote:
> > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > index 8a8acc220371c..8387301f2e206 100644
> > --- a/arch/arm64/include/asm/sparsemem.h
> > +++ b/arch/arm64/include/asm/sparsemem.h
> > @@ -5,7 +5,7 @@
> >  #ifndef __ASM_SPARSEMEM_H
> >  #define __ASM_SPARSEMEM_H
> >  
> > -#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> > +#define MAX_PHYSMEM_BITS	ilog2(VMEMMAP_RANGE)
> 
> Just wondering if there is another method, which avoids selecting physical
> memory ranges not backed with vmemmap. Also will reducing MAX_PHYSMEM_BITS
> below ARM64_PA_BITS have other side effects ? Do other platforms have this
> exact same co-relation between MAX_PHYSMEM_BITS and vmemmap range ?

That's indeed a pretty weird workaround. MAX_PHYSMEM_BITS, as the name
implies, is about the physical bits supported for memory while
VMEMMAP_RANGE tells us the virtual address range. There is a correlation
between them but they are different things conceptually.

The memory hotplug code uses arch_get_mappable_range(). This should be
called from the amdgpu code rather than changing MAX_PHYSMEM_BITS.

-- 
Catalin

