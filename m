Return-Path: <linux-kernel+bounces-394958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFA9BB680
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1841C21F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F225776;
	Mon,  4 Nov 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ajIXj+uL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7908BEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727719; cv=none; b=t+Tq7fXZvyzxJs+XmWRyAi513Q+bElOr0bg0dAaRaCazXtKJ6kvuGBvyoxQCn7DlaZKG9Z14ER5bhe1PnAdxc5a6g7JB0+OmlZAifUOMylQ54iHGE2WMQaK5PSH2mTYBNdbOy2W6lOMlKn0xsNy3zBXCNxk33jTg6yMfl6lNfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727719; c=relaxed/simple;
	bh=HXZuZel12bVsiYfz0H601Bs/k+63sw8yp3si4WDZxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmtW0LrIzkrO4FagS7UPxQzx+2JPUqzQHQt0/6Zbf6eHfquw1OHVY6b9iymMjA8DcKsP90S3UMc5qAZiQGahymjFeIfCOiLGW2+WVPtNahyRgEGGnsc7DjdRyrvLU9DcjdR/gOmn+0n7W3zaajiThL9mD/nJc5a/j//VBs0xYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ajIXj+uL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730727715;
	bh=HXZuZel12bVsiYfz0H601Bs/k+63sw8yp3si4WDZxQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ajIXj+uLHLbds8I7uNKG/L/ug3xj013bMhPApnxuz17nP4JI//LM1Cw6HG2X6qezA
	 2xjJbHYvILqMwsh9OB8ZJKyjapNO3d+USbG2yJFP+FE9uS0yw1SVjbHgSj2jRSUA1N
	 wV6wMJzbbTedxUXqdluW/g3Ve172VZeZh7uM/sekM7MLHAMOfM3cn/LkbdgCuXpOQg
	 OOJiBLBH9RBySAS1a6pUqCydZGnzxR0XCLHmzp3OjKoyScIa/heW8R6TlgDqhlTPtP
	 xGc7z/pH1C2PS2FCI4sqjNJqBrUSoecFVkD0fxmYi75RJ1pzniDVHflYoP+uv0Mo7P
	 geth8KaP/KpPA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 553E917E3638;
	Mon,  4 Nov 2024 14:41:55 +0100 (CET)
Date: Mon, 4 Nov 2024 14:41:50 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer
 objects
Message-ID: <20241104144150.65c6887c@collabora.com>
In-Reply-To: <ca33d9b9-683d-4c09-951a-1bc48287bdde@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-4-akash.goel@arm.com>
	<20241024173935.6430159e@collabora.com>
	<40c9a0a3-81e4-4ecc-b9a0-d55523f5f594@arm.com>
	<20241104121646.687cae93@collabora.com>
	<ca33d9b9-683d-4c09-951a-1bc48287bdde@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 12:49:56 +0000
Akash Goel <akash.goel@arm.com> wrote:

> On 11/4/24 11:16, Boris Brezillon wrote:
> > Hi Akash,
> > 
> > On Thu, 31 Oct 2024 21:42:27 +0000
> > Akash Goel <akash.goel@arm.com> wrote:
> >   
> >> I assume you also reckon that there is a potential problem here for arm64.  
> > 
> > It impacts any system that's not IO-coherent I would say, and this
> > comment seems to prove this is a known issue [3].
> >   
> 
> Thanks for confirming.
> 
> Actually I had tried to check with Daniel Vetter about [3], as it was 
> not clear to me that how that code exactly helped in x86 case.
> As far as I understand, [3] updates the attribute of direct kernel 
> mapping of the shmem pages to WC, so as to be consistent with the 
> Userspace mapping of the pages or their vmapping inside the kernel.
> But didn't get how that alignment actually helped in cleaning the dirty 
> cache lines.

Yeah, I was not referring to the code but rather the fact that x86,
with its IO coherency model, is a special case here, and that other
archs probably need explicit flushes in a few places.

> >>
> >> shmem calls 'flush_dcache_folio()' after clearing the pages but that
> >> just clears the 'PG_dcache_clean' bit and CPU cache is not cleaned
> >> immediately.
> >>
> >> I realize that this patch is not foolproof, as Userspace can try to
> >> populate the BO from CPU side before mapping it on the GPU side.
> >>
> >> Not sure if we also need to consider the case when shmem pages are
> >> swapped out. Don't know if there could be a similar situation of dirty
> >> cachelines after the swap in.  
> > 
> > I think we do. We basically need to flush CPU caches any time
> > pages are [re]allocated, because the shmem layer will either zero-out
> > (first allocation) or populate (swap-in) in that path, and in both
> > cases, it involves a CPU copy to a cached mapping.
> >   
> 
> Thanks for confirming.
> 
> I think we may have to do cache flush page by page.
> Not all pages might get swapped out and the initial allocation of all 
> pages may not happen at the same time.

If the pages are mapped GPU-side, it's always all pages at a time (at
least until we add support for lazy page allocation, AKA growing/heap
buffers). You're right that GPU buffers that have only been mapped
CPU-side with mmap() get their pages lazily allocated, though I'm not
really sure we care about optimizing that case just yet.

> Please correct me if my understanding is wrong.

Eviction should be rare enough that we can probably pay the price of a
flush on the entire BO range.

