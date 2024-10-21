Return-Path: <linux-kernel+bounces-373996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A627D9A6065
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7C41C209E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE51E283D;
	Mon, 21 Oct 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCucMIuB"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC81E2608
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503722; cv=none; b=pFsQYVxSB/UCnhGscDmRgA+Tm5cPgL5jiDgGLV/zVJqlLhEPj3qPCIRWGy1gWQN2JtujfY19RAuC/k2/KrBTPoRlS62we4kV3NJtEYRG22DliX/pNzPBAZzgYvRi72F2qZ8tHKVTIAa8xqMI0482LKfmIY3PagFOIc3YT4VbiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503722; c=relaxed/simple;
	bh=uD5mT3DV8yNGDcs1WRENn5nkfh+IdY3U21VkoTJy1yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7ZIL2KoRyF+z4t65mZZ3rAByTFw5LAw3psMUHsgzNT/Opeoem8A27n70ksywUgKuIhZCOHOMM8fB9ayKTmOWbNZjbw8N72oIVItxPBxrwa7v+E2KKV7zLdznYGbpJcbhjfRbhVp00rIhtu1XToFuQYiLBxnv3bc+yxZK5+W4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCucMIuB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0200145-deaa-4db1-810a-827b4b11103c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729503717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6l9K0VABXE+0LeImmfqPp/nt0looAfEbAGIBgXZDPI=;
	b=jCucMIuBRLRE4hZMwwRR9BBJT7sIplWy8LiattcyQH+egx1uMiD9e52iFp1QG3SOcil1qQ
	gNC+9B25VGIAiHtOFBKlgJw8FT7sh7tbcJoFJPfEpR/vO/XqLc6ABIZ4uqyB0wPzelphwG
	8Gl/MyQWxKjOkOscJiOMJi9Ul0/4sKk=
Date: Mon, 21 Oct 2024 17:41:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: drm/lsdc: Request PCI BAR
To: Philipp Stanner <pstanner@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241021091116.14368-1-pstanner@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20241021091116.14368-1-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,  thanks

On 2024/10/21 17:11, Philipp Stanner wrote:
> lsdc currently just ioremaps its PCI BAR with pcim_iomap(). Performing
> a region regquest additionally can make the driver more robust.
>
> Replace pcim_iomap() with the managed function pcim_iomap_region() which
> performs the request and ioremaps the BAR.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>


> ---
>   drivers/gpu/drm/loongson/lsdc_drv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
> index adc7344d2f80..592d01b6767e 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -230,9 +230,9 @@ lsdc_create_device(struct pci_dev *pdev,
>   	lsdc_gem_init(ddev);
>   
>   	/* Bar 0 of the DC device contains the MMIO register's base address */
> -	ldev->reg_base = pcim_iomap(pdev, 0, 0);
> -	if (!ldev->reg_base)
> -		return ERR_PTR(-ENODEV);
> +	ldev->reg_base = pcim_iomap_region(pdev, 0, "lsdc");
> +	if (IS_ERR(ldev->reg_base))
> +		return ldev->reg_base;
>   
>   	spin_lock_init(&ldev->reglock);
>   

-- 
Best regards,
Sui


