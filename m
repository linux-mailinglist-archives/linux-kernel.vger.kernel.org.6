Return-Path: <linux-kernel+bounces-276151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EB948F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC80286407
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370971C4612;
	Tue,  6 Aug 2024 12:38:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C11BE240
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947932; cv=none; b=cEqyaR6dfOOo6ZH/3fFnmbk0hVMB8E37hhOuazuqFGu6mE4w3yQyHUTqOvBvnUL9aQI81yrJWYyWQiFQdLLU4+LobGIAWk3mNBFrZCf2CA1CYGpr9gSeUpYbF6e3ryDloH0kqTnh5cIeFwNS6E5F10Hb3lkeT+G2H/50q7BJcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947932; c=relaxed/simple;
	bh=F89bbNBt02CIsoqTwElidN/E6oHTR4Q6GDCYm9oC+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCGOrJaEVpl5f6TMTMjFH+DQptwHwf6ket/iV7I6iCEHXNeyxsUpkDL64xrVdDuFn0soDkYxkKh91VAmUuJVT+Jg/gC/LR84yjtoyF4iSS6uWndrp0D/N4YiqOiIF7aU80JZwQrlCKsehCV4tFa6pdy69MJWvbY2vzrwlRx3z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C48EA68CFE; Tue,  6 Aug 2024 14:38:38 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:38:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rik van Riel <riel@surriel.com>
Cc: Christoph Hellwig <hch@lst.de>, Breno Leitao <leitao@debian.org>,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma,debug: avoid deadlock between dma debug vs printk
 and netcons
Message-ID: <20240806123838.GA9975@lst.de>
References: <20240805140844.6a863c76@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805140844.6a863c76@imladris.surriel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 05, 2024 at 02:08:44PM -0400, Rik van Riel wrote:
> index a6e3792b15f8..dc96e414be38 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -417,7 +417,7 @@ static unsigned long long phys_addr(struct dma_debug_entry *entry)
>   * other hand, consumes a single dma_debug_entry, but inserts 'nents'
>   * entries into the tree.
>   */
> -static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
> +static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);

This looks reasonable, but please add a comment here to explain why
this is using __GFP_NOWARN so that future readers don't have to wonder
about it and look into git history.


