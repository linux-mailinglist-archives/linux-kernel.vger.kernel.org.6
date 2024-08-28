Return-Path: <linux-kernel+bounces-304384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4B961F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C085B287DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1057315B12F;
	Wed, 28 Aug 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8gvnHEA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D315B0E0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825696; cv=none; b=mNzrPfzkr3+EQ9E3PgWQPjS3GKaC9eS1XUYbrbWlOiNi0GzGBEdcW6/mU12kpKK7KdG7szcKZ92H1LgG4WwHshTswMtak35bxuBuljpHYqOKe3scd5rRst6VH7wzi9grCwp8nWYNkZZa6aZPnNhgHGzspiPsRuqSDtyQiTebfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825696; c=relaxed/simple;
	bh=wwum+Pz7A0L67/p5Ev+IhuufqKTT6fUF+lud3e8SimE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaFtr8G5bcsUjNTj4ufHgSXzNyl5yrok4AJjg7TG6VV9NqfUvFcGolK27kNhm6iZdIR9lDzuiTlTyxG2Y03Aiul2s+JoJ7/7UsVTseK3is8eSPDb/ff7yeHNGYu8TcV8hP2VLpzk4p2+kAlUnAt78zevZqJxsGGDbwnnRlih3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N8gvnHEA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=37w4rrYrJGLfYqbySuDG1B15FhXEgejhie1Mdev3TKs=; b=N8gvnHEAWR6eeMVfox8JlAV37z
	2AjIqzWrXBI1ffSxfqhQ+o/B8fBO/s4hFH/z+RcIkBFhcfa3GWCqbQFHhQsQGbi74Z52yhejgTlpe
	vDx6xshhnxPgsP3MrG+fgg6iSiEg2Ro5dXTFGfQBas94hQyVOsfa8V517kx+x1nrDM0g27PJ3/jcG
	vzObWMOSV7OJ7gxWwlMbxefV5QpfjreV31bIlK8oQWV80VzRkFPtlsa/vlVEgDQmUI68/msvoICM4
	58JYnQY4bLpKq8KREvdBWQ6Ho6BuG6gVD9tyaF7CPKVAuP3ru4n1Iri/9uKdEM0TWCui75xA/gxVF
	VSLhPnCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjBx7-0000000E2i6-3CPE;
	Wed, 28 Aug 2024 06:14:45 +0000
Date: Tue, 27 Aug 2024 23:14:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/EISA: Use memremap() to probe for the EISA BIOS
 signature
Message-ID: <Zs7AVTEiW2R_vB-f@infradead.org>
References: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2408242025210.30766@angie.orcam.me.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Aug 24, 2024 at 11:17:10PM +0100, Maciej W. Rozycki wrote:
> -	void __iomem *p;
> +	void *p;
>  
>  	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  		return 0;
>  
> -	p = ioremap(0x0FFFD9, 4);
> +	p = memremap(0x0FFFD9, 4, MEMREMAP_WB);
>  	if (p && readl(p) == 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
>  		EISA_bus = 1;

readl requires and __iomem pointer.  If this is just a memory region you
can and should directly dereference the address instead.

Note that sparse will complain about the above as well.


