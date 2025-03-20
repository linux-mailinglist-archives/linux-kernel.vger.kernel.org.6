Return-Path: <linux-kernel+bounces-569953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C91A6AA18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4159D3AECED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FB1E98F3;
	Thu, 20 Mar 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1U/AATt0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3151E2858
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485307; cv=none; b=U5R5FEyBvbJYghiRdty5ICmRkFH4dFh8seSqebISASbwQ2pekx1ta3egdyg5kEvhcM3QmB/E9lK+JoKXHsMJthGzKvcOYvAM7ok3BPVwzDv0GeETRW+OWB6PcjZkhedA/0ho5o2BuOBuEl+4j9LaiInT5FL7r62XVYmT79/X3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485307; c=relaxed/simple;
	bh=SwzN4rsNO+8yq0gB9kYdl+eu93RIZ2WSiBjET65clOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spw8rDDOObz6IRQYDxlSgj7VMxdQJiFbniXMqb8TPO/0jbZqglY2tNaS4wSEjkeuFU5BnDt5sd71bWONoAX45jfs5QwDSuyWhxGq8wqZGJMFPs0E3fvWPQIbEcyYwTgk6UENwMipzkEQHaw0iBx0NPhWMyp1FAGsparEm2IU/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1U/AATt0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YH8NMYy0CZP6enlttApaJU7aUE5w6jDlUhfkMzIiI7A=; b=1U/AATt0kBpkEhxO2ToduoWXQj
	+xlELDPKYbHti4hUO/e7vGAWCr5J/8TAb1srdfgAxD2UIXUEVwa8ewWPQvCFQ9w/ajrt/iPmSLmNk
	h0HQ+SKqv+yLmVrsTkeSqYugonNYGMICFPl3xxpQkMuBbGOZHD72jX7Z42ECAporjEBfKttUcHRzj
	QXWeL1ez5mv6Xb7Op6Csvi+FADHOL8sk/Ujqt54DC7Rdf3YOByuFlcWUHUkxygKpPucPCmyn8EIK7
	vxWgBF+bBwWPAuOcx1bNcmvryqd+i/NY2IAbTv9RBclTqRuTOAvKxVmmjGKRGNRKHT2OV80b5MQox
	GZ3t8k5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvI1V-0000000CZ6M-01Db;
	Thu, 20 Mar 2025 15:41:33 +0000
Date: Thu, 20 Mar 2025 08:41:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, anshuman.khandual@arm.com, akpm@linux-foundation.org,
	mingo@kernel.org, catalin.marinas@arm.com, ryan.roberts@arm.com,
	kirill.shutemov@linux.intel.com, namcao@linutronix.de,
	bjorn@rivosinc.com, arnd@arndb.de, stuart.menefy@codasip.com,
	luxu.kernel@bytedance.com, vincenzo.frascino@arm.com,
	samuel.holland@sifive.com, christophe.leroy@csgroup.eu,
	dawei.li@shingroup.cn, rppt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: introduce the ioremap_prot() function
Message-ID: <Z9w3LL8oZixBKM3t@infradead.org>
References: <20250320084428.51151-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320084428.51151-1-cuiyunhui@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +{
> +	phys_addr_t addr = PFN_PHYS(pfn);
> +
> +	/* avoid false positives for bogus PFNs, see comment in pfn_valid() */
> +	if (PHYS_PFN(addr) != pfn)
> +		return 0;
> +
> +	return memblock_is_map_memory(addr);
> +}
> +EXPORT_SYMBOL(pfn_is_map_memory);

This should not be exported or even exposed.  Please just open code it
in the only caller.

> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   pgprot_t pgprot)
> +{
> +	/* Don't allow RAM to be mapped. */
> +	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
> +		return NULL;

Or just use pfn_valid as that's what we usually use for that check.
Or am I missing something specific here?

It would also be nice to just life this to common code.

