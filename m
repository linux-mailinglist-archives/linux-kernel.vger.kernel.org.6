Return-Path: <linux-kernel+bounces-187394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75338CD12F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2384A1C21923
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A611474B6;
	Thu, 23 May 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JQLKM0vm"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41C2746F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463507; cv=none; b=Vpc2D4nqFBxVJR9YcQIVJlLRhuSuyiRPnAGlstSCCE55isex5xd295+X3EFu6K9pd5NTmnQv3RGlTuemVGVICghP/kf4XtZbiKexsGijbgntKLwtnoYQPEZJNV/XFC6f5YCMOHNK0raSr/ryX8nErtzxh/H9ypofxWjsZChSDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463507; c=relaxed/simple;
	bh=wVoiOdM1e88Oro+D0GZXjKOg70saQD3b27grWmj2enM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBKHvQr+lwRP+YF3/eO00SxrZLM1Nnh9gt152em1naWN785rp8nBLUk1s5fN63757mq/hNHIlM2vorVDjsKYp4vDrLLB1sk24f+F14jfrkShPL9SAynHfs8kvE7VxT7sQNiSPE80MSNtPb099UjRc6FPX9gGCkxEHeNXynX5O90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=JQLKM0vm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716463503;
	bh=xz5HmwISGE6JPRBQj3ZIbQI4h9QCSU4QHSIcfScVatg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JQLKM0vmOL055TJl+XXGRzzbmUvRLCww8tlf6nddVcsrtzh+WvpCorTP+wKrHCjgk
	 CKPEjguPEXgyQ6lX9w4lfTqTk3GV3lUWMf7zFzz4NZGRmNiXA8pfbq6nSKdmi1+rcF
	 9fjamtltw2z0Y4NHnL94nwlifGqvjyUNaBOdZgz18tmOsxobeguHV6rUnuHuunbaAO
	 G5JdBc6IAQrt+8Bgdbh10jDHGwpcIkcsUmeJYJB+bkyv7BbIAXdR/XucRU/Do9Ivh/
	 /sa8oFuB6ITwLPSXlbch2gfXNjws6fkbLdLZUXxe+VpOgJ4f2w73grRTKIydwQvOET
	 3jaBF9LmQY4xA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VlQnV2GSdz4wb0;
	Thu, 23 May 2024 21:25:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>, akpm@linux-foundation.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
 naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 julia.lawall@inria.fr, javier.carrasco.cruz@gmail.com, Prabhav Kumar Vaish
 <pvkumar5749404@gmail.com>
Subject: Re: [PATCH next] arch: powerpc: platforms: Remove unnecessary call
 to of_node_get
In-Reply-To: <20240522194250.1165568-1-pvkumar5749404@gmail.com>
References: <20240522194250.1165568-1-pvkumar5749404@gmail.com>
Date: Thu, 23 May 2024 21:25:01 +1000
Message-ID: <87h6eo3h4i.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Prabhav Kumar Vaish <pvkumar5749404@gmail.com> writes:
> `dev->of_node` has a pointer to device node, of_node_get call seems
> unnecessary.

Sorry but it is necessary.

> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>  arch/powerpc/platforms/cell/iommu.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 4cd9c0de22c2..5b794ce08689 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -780,14 +780,13 @@ static int __init cell_iommu_init_disabled(void)
>  static u64 cell_iommu_get_fixed_address(struct device *dev)
>  {
>  	u64 cpu_addr, size, best_size, dev_addr = OF_BAD_ADDR;
> -	struct device_node *np;
> +	struct device_node *np = dev->of_node;
>  	const u32 *ranges = NULL;
>  	int i, len, best, naddr, nsize, pna, range_size;
>  
>  	/* We can be called for platform devices that have no of_node */
> -	np = of_node_get(dev->of_node);
>  	if (!np)
> -		goto out;
> +		return dev_addr;
>  
>  	while (1) {
>  		naddr = of_n_addr_cells(np);

		nsize = of_n_size_cells(np);
		np = of_get_next_parent(np);
		if (!np)
			break;

of_get_next_parent() drops the reference of the node passed to it (np).

So if you actually tested your patch you should see a recount underflow.

cheers

