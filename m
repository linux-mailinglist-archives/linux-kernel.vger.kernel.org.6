Return-Path: <linux-kernel+bounces-404010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C199C3DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A58B22364
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3517C227;
	Mon, 11 Nov 2024 12:03:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1341D17C91
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326613; cv=none; b=SqvJmr+yZqOd/Y2FpOLVYrKOmWN4AxPk/+6Mmuqg4+Cmrv2YtqgDhqnkLXRbNshVSnUsSJ7by5Of/ZNav8oDxYTj3ISO0rM7xrIVpAOJCa98rjrx5H46fezkekKCgPB+QCzijbhLtD4EPwexPnn1DLRWNfGAdBStMIpKCFJ76p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326613; c=relaxed/simple;
	bh=lYJCCpdn5eSybFFLKxg9AJoCD0I4NcjlaOkdbJOughE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+FDZ0JqiPsfQB+UBzaxsIOqVBZZf5dAP8GfjJmxvOLr0zgohzC/GtwhCEqm4NBkVyxD4PoeOZHGOmQXrewAD9aiUJU9VBOH1af4Nw2Ju/cm7DakX/g0iQPVqhTAUj+Y5HPOiL87ZJdptNEK8uEEKidbARUd8TtBcZDLX/qxi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211FD11FB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:03:59 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F24473F6A8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:03:28 -0800 (PST)
Date: Mon, 11 Nov 2024 12:03:24 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com, ketil.johnsen@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix handling of partial GPU mapping of BOs
Message-ID: <ZzHyjJRCbicx1aJl@e110455-lin.cambridge.arm.com>
References: <20241111092621.763285-1-akash.goel@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111092621.763285-1-akash.goel@arm.com>

On Mon, Nov 11, 2024 at 09:26:21AM +0000, Akash Goel wrote:
> This commit fixes the handling of partial GPU mapping of buffer objects
> in Panthor.
> VM_BIND ioctl allows Userspace to partially map the BOs to GPU.
> To map a BO, Panthor walks through the sg_table to retrieve the physical
> address of pages. If the mapping is created at an offset into the BO,
> then the scatterlist(s) at the beginning have to be skipped to reach the
> one corresponding to the offset. But the case where the offset didn't
> point to the first page of desired scatterlist wasn't handled correctly.
> The bug caused the partial GPU mapping of BO to go wrong for the said
> case, as the pages didn't get map at the expected virtual address and
> consequently there were kernel warnings on unmap.

Maybe it's just me, but I would find it easier to figure out what's being
fixed here if commit message said something like:

When the BO being mapped spans multiple scatterlists, offset is not cleared
after the starting scatterlist, leading to holes in the mapping.


If I understand it correctly you found this based on some WARN() being triggered,
so maybe adding the dump here would've helped too.


> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d8cc9e7d064e..6bc188d9a9ad 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -957,6 +957,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
>  
>  		paddr += offset;
>  		len -= offset;
> +		offset = 0;
>  		len = min_t(size_t, len, size);
>  		size -= len;

Again, my preference so feel free to ignore, but I would put the resetting of offset at the
end of for_each_sgtable_dma_sg() loop, after the if (!size) break lines. That way it is clear
that it applies to the next iteration of the loop.

Regardsless of the changes you're going to make,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

