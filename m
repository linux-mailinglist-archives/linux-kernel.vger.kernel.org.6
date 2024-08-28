Return-Path: <linux-kernel+bounces-304462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC496206C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092528176A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE281586F6;
	Wed, 28 Aug 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0JjGoM4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDB328DB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829253; cv=none; b=BMcgeNAAgtGtZrQIxVQ4Bn+BiHX5RPk4k6jKE9VJDojoRsG6C6JBsWjgamNnUsmYBm0TQVGpstInweDw1ppDizZkZ64FCnKxw7SBfoDsS5i1lX+OJrQo3UzOAaTuy89bGB5R2YS68i5BDxTgdfczHsZnEEyF4+/7PxsnK+0QbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829253; c=relaxed/simple;
	bh=nN9u0FuWZJTZMX77+VruQ3lEfJqEuLjyfL2+b/3TX3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD1UCVAhyA3e8n0Ox/to2kO7oTbw9UzbhxJc0DnnOnzgsgVuuKpO+EVrm5EohMywrRhUdyswMv2RaotbjvIKFIy6bkdXpR+rUv4nalXHLbQR9Va8AQUk3BPZ/3YcOggHYa9DlCa5B0u8RZforWerJf5dVLyWukqFeqGMqw5hY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0JjGoM4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724829251; x=1756365251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nN9u0FuWZJTZMX77+VruQ3lEfJqEuLjyfL2+b/3TX3s=;
  b=g0JjGoM46z2rYT2QhJuvjslDolPWDk+DZLwGBFXaUplXaJllHGiD0rWX
   Van+3EXHJCugt02DaUp2aWTHGfVYF2nmjMpieHCc5tSUUxfj6OoKcVAvF
   U9AQ6EoATYx5EBkej9WgGNaY41BNXYioo+bzAfYPwQR2iJdJK1mnO0DZR
   STRnmXDTuEtHGYvjXvPBPu+8po+loiTp2IhhBYfAM4rkcs741TVLUpnJM
   eO6LTRC48766oxdbooOuB9dPFWWrRzh+1yu4H7g0mCvIia49wR/5BPtq0
   1DQ9BxwIPX6aJimdGJ2zMTvAbN+XigfFKRaMs7DAXgM0ySErvG8tVIls2
   w==;
X-CSE-ConnectionGUID: WZkC19tjRnaShTCeRuYLfQ==
X-CSE-MsgGUID: b4dTBk4mTKuygumDQDux/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23467696"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23467696"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 00:14:11 -0700
X-CSE-ConnectionGUID: ow2sH+BgSsC5LbB76ahTUQ==
X-CSE-MsgGUID: l40XmDk0QhqoxHSkK6Czzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63090059"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 28 Aug 2024 00:13:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0F24142; Wed, 28 Aug 2024 10:13:34 +0300 (EEST)
Date: Wed, 28 Aug 2024 10:13:34 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
Message-ID: <pmskepgrtwhs5owjr4ok3i32655jyrkbmja7mew357occwlumx@hpd2mqndpkey>
References: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
 <Zs7AVTEiW2R_vB-f@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7AVTEiW2R_vB-f@infradead.org>

On Tue, Aug 27, 2024 at 11:14:45PM -0700, Christoph Hellwig wrote:
> On Sat, Aug 24, 2024 at 11:17:10PM +0100, Maciej W. Rozycki wrote:
> > -	void __iomem *p;
> > +	void *p;
> >  
> >  	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> >  		return 0;
> >  
> > -	p = ioremap(0x0FFFD9, 4);
> > +	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
> >  	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
> >  		EISA_bus = 1;
> 
> readl requires and __iomem pointer.  If this is just a memory region you
> can and should directly dereference the address instead.
> 
> Note that sparse will complain about the above as well.
 
See v2:

https://lore.kernel.org/all/alpine.DEB.2.21.2408261015270.30766@angie.orcam.me.uk


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

