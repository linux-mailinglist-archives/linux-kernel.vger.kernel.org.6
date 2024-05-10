Return-Path: <linux-kernel+bounces-176070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F98C298F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2AD1B2514F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E851CF83;
	Fri, 10 May 2024 17:53:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E91BDCF
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363583; cv=none; b=muyEzxt2/yXyVW1rGcCBtq3Dst0Gx9XHOUNi/1myKewPkXjfAEcr+EM7Rwns1UkmjG1N++XUz+1r/XUEA80TeuQNWrLCtuqozCBc7Xx5aSIO98rOckimkfY05Gj2MFZ+qPm7MMVdbX34l87r9vUKpd1g+D8pvCgXoJztT5zlRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363583; c=relaxed/simple;
	bh=q3TrzDS55l9J6UMQ36bleJhhFObCuaaoaHrIrZTYPyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZzFOl1BKgIlXTvhGt8KPYTt5R0grOeqVd2i0YwCZWMhppawrLTK/1n+Udr3tUrpal/gydK4agajd1f46YeGGKEpKGXSqmslAtN842tPwFqbfZn0fMSViisGhdSk5Tv7QfrTPXMojYCkmkPn8wuUuIQilAX4AeuOSHJ1jbzlnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E918F339;
	Fri, 10 May 2024 10:53:25 -0700 (PDT)
Received: from [10.57.3.158] (unknown [10.57.3.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88BE83F6A8;
	Fri, 10 May 2024 10:52:58 -0700 (PDT)
Message-ID: <7dd13232-b5c0-42b1-b096-f374dd9bef85@arm.com>
Date: Fri, 10 May 2024 18:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dma-mapping: benchmark: avoid needless
 copy_to_user if benchmark fails
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240504114713.567164-1-pchelkin@ispras.ru>
 <20240504114713.567164-3-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240504114713.567164-3-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-04 12:47 pm, Fedor Pchelkin wrote:
> If do_map_benchmark() has failed, there is nothing useful to copy back
> to userspace.

I guess there could be some valid partial data if for instance it failed 
due to OOM in the middle of running, but the standard tool is still 
going to ignore that if the ioctl() returns an error, so meh.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 2478957cf9f8..a6edb1ef98c8 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -256,6 +256,9 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>   		 * dma_mask changed by benchmark
>   		 */
>   		dma_set_mask(map->dev, old_dma_mask);
> +
> +		if (ret)
> +			return ret;
>   		break;
>   	default:
>   		return -EINVAL;

