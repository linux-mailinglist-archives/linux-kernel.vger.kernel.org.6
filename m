Return-Path: <linux-kernel+bounces-275793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E29489DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114C11F20CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243AD165F1F;
	Tue,  6 Aug 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIodtuAx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A8161327
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928708; cv=none; b=lej17/OVuZ2Nz56gSL5/UJ8NZhjmbDM5fTcAFrLC40qcZyOOh80jH40LNetP5N9eMHC5uAPx08S6vgDRagzFiCIjNcOEDGUV/c0STsaGtHvsk0oHiDwwOZGq1D1ilOtl3mAZgt3EiBReZGgXcT7noB/qomjRgtHtmnpUBNy0GyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928708; c=relaxed/simple;
	bh=lSKfMiUV/OedeMlh5vZ4l532fxP921Uo9Ij3qcktGSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgwbSYnUNv2w6iAyGqvLo/dkHh20EQEx0JP019jQNX38TZhsNfTK9SAO7RESTuHfn9qcfzBUk+CCe3xjZ5d0KIIh9ghCm3aU6BSU6zcoQxl3HGys/Opkl77kqN35eePZX7BDgmn9OtQXShVWEbDwlyP3Sg6uddUQaaxWsUi4N9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIodtuAx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722928708; x=1754464708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lSKfMiUV/OedeMlh5vZ4l532fxP921Uo9Ij3qcktGSk=;
  b=FIodtuAxXuh3dBmrEa7AKnR9+Aqr2bBHmFhi/kxusCt8+lr0BFBUy55H
   uaDIsN3C85oAs1gE8+zGDAUKoZQuZZvwl7v1awHezOfxBX5ruk031nV8U
   h+A1fbcPcCQI6KWIm5NZ3Z7Y5zldIqnjHBsSyjf3EJa+AY1rNTEAk6l6m
   UVmYmUT/d0VaOVJeHyw1UyAonnzWhoOW5ND2AszuVtaGOIeaRP63f6YTq
   w+AXIs2zFIoWgX13oKUCoG7351EuZUHF2dmdhTZ6f/RKrcvbJd53PNXJn
   nVQr5a62gdESUtWMLB3Y7KsFJ9o0gzcB7dzkHcENY5s8oWRckicT6KJEG
   Q==;
X-CSE-ConnectionGUID: qPcbmU34TsKopyycfRrSjQ==
X-CSE-MsgGUID: HjbHYTM6SPuv+4DyuPTiGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20893245"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20893245"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 00:18:27 -0700
X-CSE-ConnectionGUID: 6P+s3OG+Tcm1p0PSrRcB+w==
X-CSE-MsgGUID: vuCwHbhbQ0O4wDrTPDB2AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56085767"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2024 00:18:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CBB0A13F; Tue, 06 Aug 2024 10:18:20 +0300 (EEST)
Date: Tue, 6 Aug 2024 10:18:20 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"legion@kernel.org" <legion@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ytcoode@gmail.com" <ytcoode@gmail.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"Yao, Yuan" <yuan.yao@intel.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"John.Starks@microsoft.com" <John.Starks@microsoft.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Cui, Dexuan" <decui@microsoft.com>, "oleg@redhat.com" <oleg@redhat.com>, 
	"bhe@redhat.com" <bhe@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, 
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "cho@microsoft.com" <cho@microsoft.com>
Subject: Re: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Message-ID: <rtqr63t6lyehdkj4ezobhgw5o7hyewoaqnhmxgxbfbrjxzyyo4@5v3thwohmzse>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
 <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>

On Mon, Aug 05, 2024 at 10:40:55PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2024-08-05 at 15:29 +0200, Alexey Gladkov (Intel) wrote:
> > +       vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > +
> > +       if (user_mode(regs)) {
> > +               if (mmap_read_lock_killable(current->mm))
> > +                       return -EINTR;
> > +
> > +               ret = valid_vaddr(ve, mmio, size, vaddr);
> > +               if (ret)
> > +                       goto unlock;
> > +       }
> > +
> 
> In the case of user MMIO, if the user instruction + MAX_INSN_SIZE straddles a
> page, then the "fetch" in the kernel could trigger a #VE. In this case the  
> kernel would handle this second #VE as a !user_mode() MMIO I guess.
> 
> Would something prevent the same munmap() checks needing to happen for that
> second kernel #VE? If not, I wonder if the munmap() protection logic should also
> trigger for any userspace range ve->gpa as well.

That's an interesting scenario, but I think we are fine.

The fetch is copy_from_user() which is "REP; MOVSB" on all TDX platforms.
Kernel rejects MOVS instruction emulation for !user_mode() with -EFAULT.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

