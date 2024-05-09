Return-Path: <linux-kernel+bounces-174172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7548C0B34
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1141F1C22BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B651494BC;
	Thu,  9 May 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="gHpqON40"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812414900A;
	Thu,  9 May 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233945; cv=none; b=UueAXjKCHuKVStP0kF4CY4K6bXaiaG+0lsAhvaCAFNRllLNk9DqvTElfdoRcQ/wtybJbhNVM7StIaxKFD/mRo4sKtMuKIVg2fgDRxRVNdJgLivcqIH15SHtM52oJmACW5RUFtklB076qQBk5rlKFDEbWJGxjcGtLZ81aK3vHxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233945; c=relaxed/simple;
	bh=E0bYqZXYKsYzhCt6xLzwDSqYDsXqTDkvQq1kvUFpseo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oj3tfD1+XKMWfSFy7KU/YBaisGGKrJNZv8Nh69iwfJEWFCP6TkB2D63kcYwBGzLBfsGV98ilobbABeR8MaEUolfc+C9HIhI7qXOiDWsEF8LbTce1qotBQNdV0dsGfKaHQ6a0OYsLNmyWVGDfif6DTVD0w9T4BCnjnJdwQ0fYQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=gHpqON40; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1F41C1C3DAA;
	Thu,  9 May 2024 07:52:13 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715233933; bh=XpiPVFUL+AaGJMDdFMi7dziozT/Ubs4Tq5hF/a2lG8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gHpqON40rBh3O0oITSADi1Eh1LZPdaNDKFVDkAL9DmvmC7WzomSKTTwLZilKGxHTf
	 ajJevWgtbi3Fdwn4OqY6Qz/RzNENkDQVLLzSoQ1YhEkOHZvgYFAsicGCMhJZwWQDKG
	 R2WYEXR142Qpq/dpgDJBk2HCn2/UmpubyKSc6FqukPqMa0CJoQAUrcla7TzjUx1hQJ
	 +DCZqEIA4JgKyDH5sMkH4PHmkSeG/ghY/HCMdV//KfGa+lwlQ3UvPZR7z1wb1DxU2T
	 Qi5zSBV8Jy2HzPq5jWX6H6JeqMrlRk0YOT3At+/soXJ7LD2l8wLldaF5S8RyHhuDFk
	 RfHqen49kfmBg==
Date: Thu, 9 May 2024 07:52:12 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, mhklinux@outlook.com, robin.murphy@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] doc: swiotlb: iommu/dma: Clarify swiotlb=force
 option applies only to dma-direct
Message-ID: <20240509075212.33e521a8@meshulam.tesarici.cz>
In-Reply-To: <20240507013502.3095744-1-tjmercier@google.com>
References: <20240507013502.3095744-1-tjmercier@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 01:34:58 +0000
"T.J. Mercier" <tjmercier@google.com> wrote:

> IOMMU implementations now sometimes bounce memory through SWIOTLB to
> achieve cacheline alignment [1], or prevent DMA attacks by untrusted
> devices [2]. These uses of SWIOTLB differ conceptually from historical
> use which was a solution to the problem of device addressing
> limitations that prevent DMA to some portion of system memory
> (typically beyond 4 GiB). IOMMUs also solve the problem of device
> addressing limitations and therefore eliminate the need for SWIOTLB for
> that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
> purposes.
> 
> The swiotlb=force kernel command line parameter does not impact IOMMU
> related use of SWIOTLB, and that is intentional. IOMMUs cannot be forced
> to use SWIOTLB for all buffers. Update the documentation for the swiotlb
> parameter to clarify that SWIOTLB use can only be forced in scenarios
> where an IOMMU is not involved.
> 
> [1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marinas@arm.com
> [2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.intel.com/
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Looks good to me now.

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  Documentation/arch/x86/x86_64/boot-options.rst  | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 213d0719e2b7..84c582ac246c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6486,6 +6486,7 @@
>  				 to a power of 2.
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
> +			         where a hardware IOMMU is not involved
>  			noforce -- Never use bounce buffers (for debugging)
>  
>  	switches=	[HW,M68k,EARLY]
> diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documentation/arch/x86/x86_64/boot-options.rst
> index 137432d34109..a37139d1752f 100644
> --- a/Documentation/arch/x86/x86_64/boot-options.rst
> +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> @@ -292,6 +292,9 @@ implementation:
>          Prereserve that many 2K slots for the software IO bounce buffering.
>        force
>          Force all IO through the software TLB.
> +        Hardware IOMMU implementations can use SWIOTLB bounce buffering in
> +        some circumstances, but they cannot be forced to always use them, so
> +        this option only has an effect when no hardware IOMMU is involved.
>        noforce
>          Do not initialize the software TLB.
>  


