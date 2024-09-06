Return-Path: <linux-kernel+bounces-319232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468796F988
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A95B21BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02C71CE6F8;
	Fri,  6 Sep 2024 16:46:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3143AB7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641188; cv=none; b=TKcTqgkEqMM9Jx3UqxVeZqh79NbHruqrPqVi3KNDkgIrPpdo4zuBj2Nv9W6PfRC391eBuY2Arle13n9wesrynk1IaNIhu1WX2+BJ4lICOdSrf/QhfWV3kXgpgjE0nt9fsYhtEzh8vdVjsZG1xI1lhHrqJ+62Fa9b/dE0HcI8FxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641188; c=relaxed/simple;
	bh=8Ekj3taX4jGaUct9LG7FXMLugd/2xGc8zp8qhlVaT4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onqSZw4/NH8Fshxo2y1Fb4aqCHutA4aO3OLpgZqr0rO+FJy20mI7oqlENNuRPgumxPomPatbIFmxm1mGn0I8qczWaue+gOKh6Vq8mblpw0GxhQod5K2SZkI9Tzk6vFbZdLoc5EwV0LKU1Dsa7tX6Re6Xmw6WK7aJezwSRoLjkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D33C4CEC4;
	Fri,  6 Sep 2024 16:46:26 +0000 (UTC)
Date: Fri, 6 Sep 2024 17:46:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Rely on genpool alignment
Message-ID: <Ztsx4ER5tLTFGGUM@arm.com>
References: <20240905091738.28544-1-steven.price@arm.com>
 <20240905091738.28544-3-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905091738.28544-3-steven.price@arm.com>

On Thu, Sep 05, 2024 at 10:17:38AM +0100, Steven Price wrote:
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 557214c774c3..49aacf96ade2 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -700,7 +700,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_node *its,
>  	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
>  
>  	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
> -	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
>  
>  	its_encode_cmd(cmd, GITS_CMD_MAPD);
>  	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
> @@ -3495,7 +3494,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>  	 */
>  	nr_ites = max(2, nvecs);
>  	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
> -	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
> +	sz = max(sz, ITS_ITT_ALIGN);

Even without the gen_pool patch, I think the only problem was the slob
allocator which we got rid of.

>  	itt = itt_alloc_pool(its->numa_node, sz);

With gen_pool created with a min order of get_order(ITS_ITT_ALIGN), I
don't think we even need the sz = max(...) above. It's harmless though.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

