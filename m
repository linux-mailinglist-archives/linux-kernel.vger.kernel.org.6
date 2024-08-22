Return-Path: <linux-kernel+bounces-296777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97295AF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE91287BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713291885B7;
	Thu, 22 Aug 2024 07:14:50 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E171885A4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310890; cv=none; b=Qph3Zp+ddChP1aR7+nkX/9CzHTmN4KLQ0vwf8tFpflYBV5H1LHx4Cmg6BvVlADAITBYCo2qQ2NMCQHd/ZsUGvIJ+TOazy+rGvTJ2E51FbmynAIHNN//1ng1AFyz9u8tekxN5oSRtMXtaVGlxZiIbtTvFKYXdGbYZEnQR44ScV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310890; c=relaxed/simple;
	bh=k4YLC8qVtdFqenFkrMNJ2tu1cgMK7Q2kM2c+DNaE0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T10GuexeaXW3Dok3d485h4WCUJluC3F6nqYEBERUepwZG+MCqe2Nvl/DuM/TBwnKs+kRMipePDEWLy+NLh9U9Yqe4zP7ot+4imBNe484o9ryi2vVj3guq1fZ4aM9ZQo+3fJgyTXNPCY3IDmFsxIwnDV9GGFbdWyxdW5F6kA0cV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52DA0227AAA; Thu, 22 Aug 2024 09:14:44 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:14:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Message-ID: <20240822071443.GA6395@lst.de>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com> <20240822053238.GA2028@lst.de> <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 22, 2024 at 06:39:33AM +0000, LEROY Christophe wrote:
> powerpc has a magic instruction 'dcbz' which clears a full cacheline in 
> one go. It is far more efficient than a loop to store zeros, and since 
> 2015 memset(0) has been implemented with that instruction (commit 
> 5b2a32e80634 ("powerpc/32: memset(0): use cacheable_memzero"))
> 
> But that instruction generates an alignment exception when used on 
> non-cached memory (whether it is RAM or not doesn't matter). It is then 
> emulated by the kernel but it of course leads to a serious performance 
> degradation, hence the warning added by commit cbe654c77961 ("powerpc: 
> warn on emulation of dcbz instruction in kernel mode"). Until now it 
> helped identify and fix use of memset() on IO memory.
> 
> But if memset() is expected to be used with non-cached RAM, then I don't 
> know what to do. Any suggestion ?

I'd suggest two things:

 1) remove the warning.  The use case is perfectly valid and everything
    using uncached memory is already slow, so people will just have to
    deal with it.  Maybe offer a trace point instead if people care about
    it.
 2) figure out a way to avoid this case in the dma-coherent allocator,
    which is probably the only case where it happens frequently
    (a few drivers also zero or re-zero coherent memory, but most of the
     time that is cargo cult programming and not actually needed)

For 2 I can think of two options:

 a) provide a arch hook for zeroing the dma memory that defaults to
    memset, but which powerpc can override
 a) figure out a way to clear the memory before marking it uncached
    if we can

a) it obviously easier to verify, but b) is probably going to give
   way better performance.

Below is an untested implementation of b) for dma-direct, I just need to
find out if there is any architecture that requires the memory to be
zeroed after it іt has been remapped.  The iommu drivers might also
need similar treatment.

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e087..66e94b32ab0081 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -275,6 +275,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		if (force_dma_unencrypted(dev))
 			prot = pgprot_decrypted(prot);
 
+		if (!PageHighMem(page))
+			memset(page_address(page), 0, size);
+
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -283,14 +286,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
+		if (PageHighMem(page))
+			memset(ret, 0, size);
 	} else {
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
 			goto out_leak_pages;
+		memset(ret, 0, size);
 	}
 
-	memset(ret, 0, size);
-
 	if (set_uncached) {
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);

