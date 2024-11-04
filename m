Return-Path: <linux-kernel+bounces-394721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411969BB328
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723191C22260
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF261BFE05;
	Mon,  4 Nov 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e5/Mmyf5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FF1BE871
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719014; cv=none; b=NmKZ5FgM2Z5ieD4ye292zHOax2FADfA9qVCxembeZ+HYfWRT2E4ryq3MOS4hdu9QFJXFzRpABq4yD7qLX1AqkE9aoKvF67+3nsiI0vAtqJ4wJBpwqGBFCY+osSBBKERiLMQ0Lb8sqfSRME5NNM0qQwnvGAXXvB6cqOXeBFW0hCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719014; c=relaxed/simple;
	bh=9BP+eWaq1O97MOubpRPLduCs3ZPH8Qsc0wSP9LJs5e4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeiBGWXbyN8Gb/+guv54AdjpOIGllq8sy8IlIXDYz3Z2L+PO3WIaacoZZ0GfAnAjc/25U27puo9f99u6ctiVgxmS6S3wwSbYsX47gGkSbcgq8hU1LoMaU6QHmYXyIJLniXjyeloJ+QddcMeh/9V0Fv2XYS6wcYH0bv5Z42T1F5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e5/Mmyf5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730719010;
	bh=9BP+eWaq1O97MOubpRPLduCs3ZPH8Qsc0wSP9LJs5e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5/Mmyf5uo6G1GNKyO/Spwr1ya/OiCEB/sKm3TxUN8bhm0lUxzFyhAQ5ukPA2pHWH
	 bhjWfsXVza98aciYSxxXyZWv06TbTB/AG0y2Aak5+OUDBLdpxBXtckd5tOe1A/cMcK
	 cwYUYraLc8uWruUCwDd+FSaKOk5ontgPvqamPiGh6w2eIof8soRWoqF0g5VNMhzkFn
	 GkwlotH4UAfQ/8Te4dygy1I2KEAfaKc33dPMSKnmSeHzPdGuS5biHWY85/ROG3qEg5
	 RdBOHK9XEzii2Ai3hL7VY5hGlHTTeJVHfu0EtwT3ZnYxCnvMblp8lsT/tr5obMAhHq
	 yL821Nok73CNg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00EB517E35E0;
	Mon,  4 Nov 2024 12:16:49 +0100 (CET)
Date: Mon, 4 Nov 2024 12:16:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer
 objects
Message-ID: <20241104121646.687cae93@collabora.com>
In-Reply-To: <40c9a0a3-81e4-4ecc-b9a0-d55523f5f594@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-4-akash.goel@arm.com>
	<20241024173935.6430159e@collabora.com>
	<40c9a0a3-81e4-4ecc-b9a0-d55523f5f594@arm.com>
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

Hi Akash,

On Thu, 31 Oct 2024 21:42:27 +0000
Akash Goel <akash.goel@arm.com> wrote:

> I assume you also reckon that there is a potential problem here for arm64.

It impacts any system that's not IO-coherent I would say, and this
comment seems to prove this is a known issue [3].

> 
> Fully agree with your suggestion that the handling needs to be at the 
> drm_gem_shmem level. I was not sure if we really need to do anything, as 
> I didn't observe any overwrite issue during the testing. So thought 
> better to limit the change to Panthor and get some feedback.

Actually, I wonder if PowerVR isn't papering over the same issue with
[1], so it looks like at least two drivers would benefit from a fix at
the drm_gem_shmem level.

> 
> shmem calls 'flush_dcache_folio()' after clearing the pages but that 
> just clears the 'PG_dcache_clean' bit and CPU cache is not cleaned 
> immediately.
> 
> I realize that this patch is not foolproof, as Userspace can try to 
> populate the BO from CPU side before mapping it on the GPU side.
> 
> Not sure if we also need to consider the case when shmem pages are 
> swapped out. Don't know if there could be a similar situation of dirty 
> cachelines after the swap in.

I think we do. We basically need to flush CPU caches any time
pages are [re]allocated, because the shmem layer will either zero-out
(first allocation) or populate (swap-in) in that path, and in both
cases, it involves a CPU copy to a cached mapping.

> 
> Also not sure if dma_sync_sgtable_for_device() can be called from 
> drm_gem_shmem_get_pages() as the sg_table won't be available at that point.

Okay, that's indeed an issue. Maybe we should tie the sgt allocation to
the pages allocation, as I can't think of a case where we would
allocate pages without needing the sg table that goes with it. And if
there are driver that want the sgt to be lazily allocated, we can
always add a drm_gem_shmem_object::lazy_sgt_alloc flag.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/imagination/pvr_gem.c#L363
[2]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L177
[3]https://elixir.bootlin.com/linux/v6.11.6/source/drivers/gpu/drm/drm_gem_shmem_helper.c#L185

