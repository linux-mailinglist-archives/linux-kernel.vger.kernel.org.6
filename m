Return-Path: <linux-kernel+bounces-511940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE2A331C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E722167CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458F202F67;
	Wed, 12 Feb 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLvtDQW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DC1FF1DF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397324; cv=none; b=UtN5N7yE57ICZyf3cVYUyl5myJIUzfv+woCosqBvw7zF61XuL+HNjaTt6/CgtYKLfVcX+v10oLRtwD0Ma2n+DyrC1gCgpv33Bi6YYWbgf4jgwfUasE0J8Bjx39DtlX08qzRBCLJ1xG22ekas28KYV27XyFaMiSHFMT/ajwDH/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397324; c=relaxed/simple;
	bh=BG7jBjVDTxh0gXoX7PXr17H61em92053j0md+OCuxtw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zo2AngAA74PEtdaAbkILwnFxEOQmgiJ8B9nfqpR62svMdPctToQA+geCBIZAXY5IgX+w5qNZlI0Xt8nGnRXr3nPpQn2DxY7PdUlJzBWH6Dpd7XR0iNarAbP4h9onlmhgVMMbfsGAhRVwoHhmUHscxN3/JARCfKwMyAHC1G/L2GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLvtDQW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F321EC4CEDF;
	Wed, 12 Feb 2025 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397323;
	bh=BG7jBjVDTxh0gXoX7PXr17H61em92053j0md+OCuxtw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BLvtDQW2yPGdBtoPTUHRMA7Smaa+BTYLuFSbWP1z47x3VF6l8a41NGZtukIykb+L/
	 gK/5HjsyNapHYThfkhUkYT+6ozVYLysboTSZPuGa5BQ/trLzar2NlKQmYisbU42Aft
	 JmE2fAqRkl0T1eV4u9tRPawKWdl7wMqXRatvBVMuP0wfNFYoi3lLOtMs7SM7sIbI8x
	 LjzUzzXr+TD12qDUTJHcgMhixkn+ubmszVqyEmkDt5B+qYTCu79Ri4/9U/KtfxY7cY
	 UGUQpeOcgEAQIdje+gM7+x7iWHzJgLiqao9TnnYWyI3wnv38x0ACwi4AW+AIetzJ12
	 nWyXZ5dAVfj9w==
Date: Wed, 12 Feb 2025 13:55:21 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jan Beulich <jbeulich@suse.com>
cc: lkml <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH] Xen/swiotlb: mark xen_swiotlb_fixup() __init
In-Reply-To: <e1198286-99ec-41c1-b5ad-e04e285836c9@suse.com>
Message-ID: <alpine.DEB.2.22.394.2502121354280.619090@ubuntu-linux-20-04-desktop>
References: <e1198286-99ec-41c1-b5ad-e04e285836c9@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Feb 2025, Jan Beulich wrote:
> It's sole user (pci_xen_swiotlb_init()) is __init, too.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -111,7 +111,7 @@ static struct io_tlb_pool *xen_swiotlb_f
>  }
>  
>  #ifdef CONFIG_X86
> -int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
> +int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
>  {
>  	int rc;
>  	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
> 

