Return-Path: <linux-kernel+bounces-554951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9EA5A3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32A83ADC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B946235371;
	Mon, 10 Mar 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W9chesfJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288B29D0B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634754; cv=none; b=oJobsPzrofmutpLQ3wYve/O/u2Rj6osFQyt3ETYmLsTN9CZJqMkrSeYc9Mbtj4F+4tXk9EgnPhG34e849hWbUnePY6nRDn18WfYHkp7VuxbmpBZX5FpuGcM3/B6CseyeylKWq6EYpm/U4NTqLyFpi9n9RdgqrfEklPUBgKkInUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634754; c=relaxed/simple;
	bh=TkqqFuqokwTuvmnu4mxz6BLe3AvgN5TGoGvCmIiu2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAlEB4ZLR8X4rjRxCg8QaQUaKIjzwZW61MuKXBbAfoG0cktWV1NE/JbuiqEy4YKn+gw5V8y3eG3CRCwhE43IW+MGA41gT62Mefsclx8zXy3M5BF230z7TuU74MQ6KGqUVdCWyDOFnzJQTfqUB8r/MzbISjEysAyK2wjoNan5DQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W9chesfJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741634749;
	bh=TkqqFuqokwTuvmnu4mxz6BLe3AvgN5TGoGvCmIiu2u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9chesfJLumK5PSLlfDprJiWEPiydyLPBC6wW9aQJopJ6eSrqIAN5EkZx51VYZpw7
	 DCn++x4ELDzLYJaFfeqTovaerYYv2IeH5VnyMoVbeeX49PaOKTksHHqIrWBEEP8+p3
	 gdrB0eIlClIyKRoDLbMNoWdrKe+B72J/OjJMAiOKAM6t+U9M9OBqP3A9b6TRcUmmlR
	 WyYQMFjjgGZaFIrld7pcocFmGAWJ0lb1X3m4o0DUjNwjg+6QrTGtDchvKQejfw83L/
	 vRhwE6J8TOquv+4oLzXH+m6gv4dm42x48w18ypuJlY06a2BWDu6wXhmP7VNNwjJjuA
	 3fUMMeMkrVz+Q==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F2BF17E0B12;
	Mon, 10 Mar 2025 20:25:49 +0100 (CET)
Date: Mon, 10 Mar 2025 20:25:43 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC PATCH 3/4] drm/panfrost: Support ARM_64_LPAE_S1 page table
Message-ID: <20250310202543.404e21c0@collabora.com>
In-Reply-To: <ec151d39-2cb2-4f67-a23a-dafc421fff75@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
	<20250226183043.140773-4-ariel.dalessandro@collabora.com>
	<20250227155539.59944e18@collabora.com>
	<ec151d39-2cb2-4f67-a23a-dafc421fff75@collabora.com>
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

On Mon, 10 Mar 2025 12:34:30 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> Hi Boris,
> 
> On 2/27/25 11:55 AM, Boris Brezillon wrote:
> > On Wed, 26 Feb 2025 15:30:42 -0300
> > Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:
> >   
> >> @@ -642,8 +713,15 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
> >>   		.iommu_dev	= pfdev->dev,
> >>   	};
> >>   
> >> -	mmu->pgtbl_ops = alloc_io_pgtable_ops(ARM_MALI_LPAE, &mmu->pgtbl_cfg,
> >> -					      mmu);
> >> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_AARCH64_MMU)) {
> >> +		fmt = ARM_64_LPAE_S1;
> >> +		mmu->enable = mmu_lpae_s1_enable;
> >> +	} else {
> >> +		fmt = ARM_MALI_LPAE;
> >> +		mmu->enable = mmu_mali_lpae_enable;
> >> +	}  
> > 
> > How about we stick to the legacy pgtable format for all currently
> > supported GPUs, and make this an opt-in property attached to the
> > compatible. This way, we can progressively move away from the legacy
> > format once enough testing has been done, while allowing support for
> > GPUs that can't use the old format because the cachability/shareability
> > configuration is too limited.  
> 
> Indeed, that's a better way to go.
> 
> Specifically, what you mean is: keep the same compatible string and add 
> a new property to the `panfrost_compatible` private data for that 
> specific variant?

Exactly.

