Return-Path: <linux-kernel+bounces-405447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35909C517C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8231F2104D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D820C481;
	Tue, 12 Nov 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WWuG/WXt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CF1F7092
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402470; cv=none; b=pm6tk4K1rfNilzgYkf5CCmUhE61yVzHDlrf9ds7mk+Hju1nknmaennlfHBUU17fhnjhfj9hb7HAgKg2d12EHCrv4J6NV/Onj+8qDn+2dgmRPXdZnz3OpqEO+0HO1yqVF7NNFrhSAzLMB3faUh4sBFg081JAc6FR5tuUHcdxCH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402470; c=relaxed/simple;
	bh=dBxgPXuWudSCqG/C8Kwnetk9UUhBnsVsH1Yu2p6FKIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePvAOG8QJRppBZJ2Rs0sL30Ick4Lcm+H1StK18DZ2ORL5WvNXHiqSQehHbcNbOarUDIQNdW95FEroWfZrqj/V3gg6VoZdE3G0E9nmOmD/vs/j7BECBSCX5j0nd1tyKnoCBEHRmkAJ5IDxdil0cYr7H5/GRzLVWbGVZh/qU+l7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WWuG/WXt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731402460;
	bh=dBxgPXuWudSCqG/C8Kwnetk9UUhBnsVsH1Yu2p6FKIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWuG/WXthZmOlzHyKCG6SSmkMeDxwP8uf1QE61n19xthF0KTEN9ruW7RFigjEueFT
	 GcFKz21lhQMcLFmQeD621MU7P+FEIA6v3rquWwyiZNkni8rRTbxTTOO6DXv/PMYeMl
	 728Wr72P5Fq7BC9uagKIp/YFXSeAcVk/nh0yPtSjtfR2qgzKvZoQWB+myzxXT0eSJl
	 YELNu4ODcsnzEz1DEAqsazmxSWqQLUEtl3+cLBAzV5xshODU/3xBOohBnovMJGjUY6
	 kxA+zd/WqTlXoqKbb/c+fOVvs8oKUO57W2sopeTDUuzmOdN8IvQ+kpllEICZ9fqlg0
	 cwKFJCFnDIHRw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3942A17E13A2;
	Tue, 12 Nov 2024 10:07:40 +0100 (CET)
Date: Tue, 12 Nov 2024 10:07:36 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Akash Goel <akash.goel@arm.com>, liviu.dudau@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix handling of partial GPU mapping of BOs
Message-ID: <20241112100736.10b4873b@collabora.com>
In-Reply-To: <bff9ae58-8587-4f44-a797-d919770978aa@arm.com>
References: <20241111092621.763285-1-akash.goel@arm.com>
	<bff9ae58-8587-4f44-a797-d919770978aa@arm.com>
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

On Mon, 11 Nov 2024 11:31:12 +0000
Steven Price <steven.price@arm.com> wrote:

> On 11/11/2024 09:26, Akash Goel wrote:
> > This commit fixes the handling of partial GPU mapping of buffer objects
> > in Panthor.
> > VM_BIND ioctl allows Userspace to partially map the BOs to GPU.
> > To map a BO, Panthor walks through the sg_table to retrieve the physical
> > address of pages. If the mapping is created at an offset into the BO,
> > then the scatterlist(s) at the beginning have to be skipped to reach the
> > one corresponding to the offset. But the case where the offset didn't
> > point to the first page of desired scatterlist wasn't handled correctly.
> > The bug caused the partial GPU mapping of BO to go wrong for the said
> > case, as the pages didn't get map at the expected virtual address and
> > consequently there were kernel warnings on unmap.
> > 
> > Signed-off-by: Akash Goel <akash.goel@arm.com>  
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> Thanks,
> Steve
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index d8cc9e7d064e..6bc188d9a9ad 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -957,6 +957,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
> >  
> >  		paddr += offset;
> >  		len -= offset;
> > +		offset = 0;
> >  		len = min_t(size_t, len, size);
> >  		size -= len;
> >    
> 


