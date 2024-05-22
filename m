Return-Path: <linux-kernel+bounces-186534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA098CC54E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D002826C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034F11422DF;
	Wed, 22 May 2024 17:05:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C41F17B;
	Wed, 22 May 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397537; cv=none; b=dln0lB1/rdve/SuN+eEN3AiE5S9XaIxy/Wf2zg1o4a3iKK0bZibDJg4Fz5A2WQS1JyL8eb3s6dCewpj2Dq2mImex354/MBnyK8KRwtxz3vCuOrPoB04CEcUgLjgGXpWrdIxBLBDyCApOk2b908F/P8AFbBQcuAL0uEEYigEB/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397537; c=relaxed/simple;
	bh=mwwMo0Vvvhtk4BnzEWt4A3iCr981iZe9k75eEk/w0xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT0zFNwQOh9MJTr6S43dnGpuSfOo9zs3WVhTirWfe0wy1dBEH98mwLyIdEUtGJ9cINuucT6MZhgm7B5BkQz8+qsAouGWVWKJwEYKAQda5939Ngaup5Qj2nKZ6k+6a+j8ZC4v+s0c39CuRTA9FSVieittqqYGudjTSg4n6DaTjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ABEC32789;
	Wed, 22 May 2024 17:05:34 +0000 (UTC)
Date: Wed, 22 May 2024 18:05:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v2 12/14] arm64: realm: Support nonsecure ITS emulation
 shared
Message-ID: <Zk4l2xFBDW_3ImFD@arm.com>
References: <20240412084213.1733764-1-steven.price@arm.com>
 <20240412084213.1733764-13-steven.price@arm.com>
 <ZkSV7Z8QFQYLETzD@arm.com>
 <74011ac1-34e0-4ee3-a00d-f78ad334fce2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74011ac1-34e0-4ee3-a00d-f78ad334fce2@arm.com>

On Wed, May 22, 2024 at 04:52:45PM +0100, Steven Price wrote:
> On 15/05/2024 12:01, Catalin Marinas wrote:
> > On Fri, Apr 12, 2024 at 09:42:11AM +0100, Steven Price wrote:
> >> @@ -3432,7 +3468,16 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
> >>  	nr_ites = max(2, nvecs);
> >>  	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
> >>  	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
> >> -	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
> >> +	itt_order = get_order(sz);
> >> +	page = its_alloc_shared_pages_node(its->numa_node,
> >> +					   GFP_KERNEL | __GFP_ZERO,
> >> +					   itt_order);
> > 
> > How much do we waste by going for a full page always if this is going to
> > be used on the host?
> 
> sz is a minimum of ITS_ITT_ALIGN*2-1 - which is 511 bytes. So
> potentially PAGE_SIZE-512 bytes could be wasted here (minus kmalloc
> overhead).

That I figured out as well but how many times is this path called with a
size smaller than a page?

-- 
Catalin

