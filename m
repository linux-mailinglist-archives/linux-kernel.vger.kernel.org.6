Return-Path: <linux-kernel+bounces-565738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25CA66E56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C023A38D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9A1DF260;
	Tue, 18 Mar 2025 08:33:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B2749C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286816; cv=none; b=lM3ii4+RnkKykcND1xIizzpVQoBHmy+lPlH7TOEDJVIQmPKP7kcwZ5yLgYIipbCo0/apmSpJm0Jmr6d4/CQs++I//lKZXF9vLjmDleMUe11mVNrg09h4kSF3JDVZSiWA30O5OUegYq19reCdzdeSuv9akC4wxA6Ci6ukhBwZdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286816; c=relaxed/simple;
	bh=k+jhoDGf0CtbnXKWHyWGrWpKW7UFfmRs59cee1LMCEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfDnfEQ8Az3pSG8NGq4IiEpdefulJRVEvMYZeN4CLAh6tbwwBYjZ6YUJG77Wq4JwvzzF6ASJLO/zE+hKxuDakHBWvvDmvPBxsRjGEgMZG+ogy6sqdO4yueTmnmnpEhNFoBb4hDlAb3Rsu1q2hjq2c3jbh9lCKItV5fvpoavdK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C08A968AFE; Tue, 18 Mar 2025 09:33:30 +0100 (CET)
Date: Tue, 18 Mar 2025 09:33:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Huan Yang <link@vivo.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
	bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
	opensource.kernel@vivo.com, rppt@kernel.org, ryan.roberts@arm.com,
	urezki@gmail.com, ziy@nvidia.com, vivek.kasireddy@intel.com
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250318083330.GB18902@lst.de>
References: <20250317055304.GB26662@lst.de> <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com> <20250318064805.GA16121@lst.de> <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 04:20:17PM +0800, Huan Yang wrote:
> This prevents us from properly invoking vmap, which is why we have turned to using vmap_pfn instead.
>
> Even if a folio-based vmap is implemented, it still cannot handle mapping multiple folio ranges of physical
>
> memory to vmalloc regions. A range of folio is important, it maybe an offset in memfd, no need entire folio.
>
> So, I still consider vmap_pfn to be the optimal solution for this specific scenario. :)

No, vmap_pfn is entirely for memory not backed by pages or folios,
i.e. PCIe BARs and similar memory.  This must not be mixed with proper
folio backed memory.

So you'll need a vmap for folios to support this use case.

>
>> historically backed by pages and now folios.
>
> So by HVO, it also not backed by pages, only contains folio head, each tail pfn's page struct go away.

And a fully folios based vmap solves that problem.


