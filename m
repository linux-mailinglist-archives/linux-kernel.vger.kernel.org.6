Return-Path: <linux-kernel+bounces-290065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF2954F02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A147B22B11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA71BD00B;
	Fri, 16 Aug 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BALNaDHU"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39A1BCA1C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826331; cv=none; b=A/GWqJaWarIYmYLDyIY+m05/kZr/wA6WErd5eD5ozxKQxUPu2lNGDfFyNww8Eo3ZcWJC/pc16CWXwLHcK6zVuwgtmWETLlKOWLDbo00dm2iqWzcNODhP0Xm4o/dI6/+tWiLFH9jpczQbwETBrFTKVG+5YETNncLYeRJ87HOSmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826331; c=relaxed/simple;
	bh=DMuyEFK3cmUpuS8u+TITRwUj7w74Y7+Pqpaz/zNH3wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjATrndJrfI0x8SaJvHX7lAEM+KO94EETlGpdol491BemjqADn556yUbEMUyrkJSL9aP1rpF1EjeVvfEvkxH390+A7Y4NmozXW+S0DXBduX5VsVgnLuzmazbW++ooTbCZEqNcxOvttN1gF5lw/23P9/c5tPrx8kwXj5Zfx4pAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BALNaDHU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC. (unknown [50.53.30.84])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88BD720B7165;
	Fri, 16 Aug 2024 09:38:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88BD720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723826328;
	bh=bIzzFxwaG7ZBRfhFz9fLGTSKI4TDBzR08/JY618cF4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BALNaDHUD+WhhCRqP+PGxACBtWUZzXZ4hFD3yMe16qzyURA4TZjvu3D6Avb2kI8XN
	 ZTYfHhdWHzHyPmbMK3VM2AtKz4LrYfRC4oQq6AFZLcML5LuD4J2Nfzw/xkY1xDFJt8
	 CFrrOFy9nUTv8fawry+TG+iesQRr/kz4tyZu7CX0=
Date: Fri, 16 Aug 2024 09:38:46 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iommu/vt-d: Introduce batched cache invalidation
Message-ID: <20240816093846.40dbd623@DESKTOP-0403QTC.>
In-Reply-To: <20240815065221.50328-5-tina.zhang@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
	<20240815065221.50328-5-tina.zhang@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:52:21 +0800
Tina Zhang <tina.zhang@intel.com> wrote:

> @@ -270,7 +343,8 @@ static void cache_tag_flush_iotlb(struct
> dmar_domain *domain, struct cache_tag * u64 type = DMA_TLB_PSI_FLUSH;
>  
>  	if (domain->use_first_level) {
> -		qi_flush_piotlb(iommu, tag->domain_id, tag->pasid,
> addr, pages, ih);
> +		qi_batch_add_piotlb(iommu, tag->domain_id,
> tag->pasid, addr,
> +				    pages, ih, domain->qi_batch);
>  		return;
>  	}
>  
> @@ -287,7 +361,8 @@ static void cache_tag_flush_iotlb(struct
> dmar_domain *domain, struct cache_tag * }
>  
>  	if (ecap_qis(iommu->ecap))
> -		qi_flush_iotlb(iommu, tag->domain_id, addr | ih,
> mask, type);
> +		qi_batch_add_iotlb(iommu, tag->domain_id, addr | ih,
> mask, type,
> +				   domain->qi_batch);
>  
If I understand this correctly, IOTLB flush maybe deferred until the
batch array is full, right? If so, is there a security gap where
callers think the mapping is gone after the call returns?

