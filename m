Return-Path: <linux-kernel+bounces-380495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE009AEF92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B8283799
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634792003CE;
	Thu, 24 Oct 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AR5miBzy"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD81D3195
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793950; cv=none; b=uwEl9LQy9e+kVpaUDe9cNqPokyd/3HNd9xZCwX9vvP+JNKvPny9Ij9AmzFbxtRwLQb+kc85EwSaLVbVCtBxPn5Mx/LYXBc5SDlzi+E94EArqCXLW1z5mAuHFiKli/8b6zShNDipzFTMvV22+OrRyeTxGg620h7u+czoQbK637Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793950; c=relaxed/simple;
	bh=CH8vMW1/zpkG7zSqbe9PVXIyeHGTmLRmHDa4jG4zZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSSYI4i98DYPBU95U8+uGM7aqvPjB0dWND+h6VkUUy3pHvuGhoypRVYujmup0fD9XxxciSUJx2NclirXzNqDaxTbRj1Fo83F3En+NTmRfbKLzr0MBVqhS6NuiTCEu/PmW66dsBzXP4IZR1Tu2IVda6iVvaEhp918apLQ2VC0xlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AR5miBzy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebbed44918so853049eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729793947; x=1730398747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZBytGE7ZuTkGms+2TTJHzCJ6rcb64F+IbygfHjIlxo=;
        b=AR5miBzyBcqPKU7U97g1DSTMpT2tSF9yCp3TmS4l3Lh74647R0tL3vjQnIeDq4xqAg
         6SAajy6iC1I7H3f/MyWxW4J/1grkcBk0vdc0gmJXCZbc7itJA2vo1AVu0842uubt112R
         eVf69A3PrXED3faIvhP9ftc98PCqMo69dk04HEC2Fjyd2oVnkUtCfYTK5JNa5Z2n9QHU
         4SLhDDuprpq2biUvyvEE6bUlZa18EMV/yn3bSyPnCw8VFIYtdVi3J1iPwSWl9wHVP+YJ
         VEStulca4g5hgP6aHMykmDGyzt/baRPKX14zJBHG0GKWHUx5mFENrVIn4iZZAHsaDBGI
         dSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793947; x=1730398747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZBytGE7ZuTkGms+2TTJHzCJ6rcb64F+IbygfHjIlxo=;
        b=MGlDLQFH2YzvmtlYnTA2Vwt86VvOLIsLqH5T1oUrlhAkSRjAJV5Dmyp6GGP4llnwYq
         Wt1oHdkt3cc5SAFXLUMYutmva4pn8zkaZAMk/Gy1ANGA20AuZWxi/KczkxeMIbjVjYaX
         BvabUhC+WBKKolUCvX+Gk5OtaFtChPOXdvturpDZUWwf6gWCZ0xqCPQ1ZgGtXoy2YN91
         zaRCCkOP7sMefeGvOOzmHmnSX3Y7cHdBRktoiD9aDehQrtMGMTXl82HC6+HnaS065Gs0
         EH1IOwaIQO5xZbtEE1rzOzKqyjFVhblpaBg6haGKUbIZFnarojumRZYFgB1wQIozlViU
         Wl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXie8WyX0C0Q4LQFBBEQg2zJ+eZ5ty+vF4MbK44voL+EZUR2/WwATjtGB9l2mAOFCQXsY9kbWHFDZlGS8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKuiPWAh0HeXNP6K8xgEc70fzJk1c6XVSIWodX9oLO0h5ryErl
	EFb1H85ZJWYFl8Gow57LkLQc23VC2OCYo/OF/cyROYV03t/ucaSaOL3fitcA8uCWXuQ6fjXkQXd
	x
X-Google-Smtp-Source: AGHT+IEjicTJUCagFJHVWThr9j6tOLmSf7uLfErGeRucuprxKLTVc9VjM+4CMkaK7H0akWzhPiSqsQ==
X-Received: by 2002:a05:6358:60c3:b0:1c3:8215:164c with SMTP id e5c5f4694b2df-1c3d80d4610mr558532255d.1.1729793946767;
        Thu, 24 Oct 2024 11:19:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c3fe1csm53700741cf.10.2024.10.24.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:19:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t42QJ-000000005sw-3YfU;
	Thu, 24 Oct 2024 15:19:03 -0300
Date: Thu, 24 Oct 2024 15:19:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1: vfio: avoid unnecessary pin memory when dma map io
 address space 0/2]
Message-ID: <20241024181903.GA20281@ziepe.ca>
References: <cover.1729760996.git.qinyuntan@linux.alibaba.com>
 <20241024110624.63871cfa.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024110624.63871cfa.alex.williamson@redhat.com>

On Thu, Oct 24, 2024 at 11:06:24AM -0600, Alex Williamson wrote:
> On Thu, 24 Oct 2024 17:34:42 +0800
> Qinyun Tan <qinyuntan@linux.alibaba.com> wrote:
> 
> > When user application call ioctl(VFIO_IOMMU_MAP_DMA) to map a dma address,
> > the general handler 'vfio_pin_map_dma' attempts to pin the memory and
> > then create the mapping in the iommu.
> > 
> > However, some mappings aren't backed by a struct page, for example an
> > mmap'd MMIO range for our own or another device. In this scenario, a vma
> > with flag VM_IO | VM_PFNMAP, the pin operation will fail. Moreover, the
> > pin operation incurs a large overhead which will result in a longer
> > startup time for the VM. We don't actually need a pin in this scenario.
> > 
> > To address this issue, we introduce a new DMA MAP flag
> > 'VFIO_DMA_MAP_FLAG_MMIO_DONT_PIN' to skip the 'vfio_pin_pages_remote'
> > operation in the DMA map process for mmio memory. Additionally, we add
> > the 'VM_PGOFF_IS_PFN' flag for vfio_pci_mmap address, ensuring that we can
> > directly obtain the pfn through vma->vm_pgoff.
> > 
> > This approach allows us to avoid unnecessary memory pinning operations,
> > which would otherwise introduce additional overhead during DMA mapping.
> > 
> > In my tests, using vfio to pass through an 8-card AMD GPU which with a
> > large bar size (128GB*8), the time mapping the 192GB*8 bar was reduced
> > from about 50.79s to 1.57s.
> 
> If the vma has a flag to indicate pfnmap, why does the user need to
> provide a mapping flag to indicate not to pin?  We generally cannot
> trust such a user directive anyway, nor do we in this series, so it all
> seems rather redundant.

The best answer is to map from DMABUF not from VMA and then you get
perfect aggregation cheaply.
 
> What about simply improving the batching of pfnmap ranges rather than
> imposing any sort of mm or uapi changes?  Or perhaps, since we're now
> using huge_fault to populate the vma, maybe we can iterate at PMD or
> PUD granularity rather than PAGE_SIZE?  Seems like we have plenty of
> optimizations to pursue that could be done transparently to the
> user.

I don't want to add more stuff to support the security broken
follow_pfn path. It needs to be replaced.

Leon's work to improve the DMA API is soo close so we may be close to
the end!

There are two versions of the dmabuf patches on the list, it would be
good to get that in good shape. We could make a full solution,
including the vfio/iommufd map side while waiting.

Jason

