Return-Path: <linux-kernel+bounces-564670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B2A6592D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBECB88681B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDFD1A3BC0;
	Mon, 17 Mar 2025 16:47:26 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AC1A255C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230046; cv=none; b=A+6TDHiG7lpkfvF27Rgs6nMcdc1uk8LTpr3VJb6Jf4NAQZvXAy3wa3z8F2i/3NRW2Z7WynELnnAbXPngtWBg68f+u8Vaut6x48vNwY8H8ShPYmYffSFDdlbIv/gDkNwQPVPJxbIg2m93nV4aW3ewqMQRsCymqlRZ2NT2MQKalyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230046; c=relaxed/simple;
	bh=jwOTwlsAwVrR1HbXPCZjYqzaL4dNCXSzEJhenSYGWQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbvaXYr0fekdcr+vo2tW8+0oB9ONg1LFf31GwLGukYmIRLMFPcg8PRUV3Zku10FDhNQYEVoZeiiM7U/s7AiznIHVHD7iUo0EIycfNDxDLqUijjmuMRAZ4be55+g0raTElom6ncALquXYUKZ+J6px3DMQE1TtvASa+qBHtLJixeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDE4E441C3;
	Mon, 17 Mar 2025 16:47:20 +0000 (UTC)
Message-ID: <b7969702-5e88-4891-bd0e-8728562ff5f5@ghiti.fr>
Date: Mon, 17 Mar 2025 17:47:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] riscv: iommu: Support Svnapot
Content-Language: en-US
To: Xu Lu <luxu.kernel@bytedance.com>, akpm@linux-foundation.org,
 jhubbard@nvidia.com, kirill.shutemov@linux.intel.com, tjeznach@rivosinc.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: lihangjing@bytedance.com, xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250311122510.72934-1-luxu.kernel@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250311122510.72934-1-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedttdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhugihurdhkvghrnhgvlhessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhhuhgssggrrhgusehnvhhiughirgdrtghomhdprhgtphhtthhopehkihhrihhllhdrshhhuhhtvghmohhvsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhjvgiinhgrtghhsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrt
 ghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Xu,

You did not +cc linux-mm on your series, it would be nice to have 
feedback from them. I'd say it would be easier to resend the whole 
patchset with them in +cc.

Thanks,

Alex

On 11/03/2025 13:25, Xu Lu wrote:
> According to the RISC-V IOMMU hardware spec, the IOMMU implementation
> has the same translation process as MMU and supports Svnapot standard
> extension as well. These patches add support for Svnapot in the IOMMU
> driver to make 64K also an available page size during DMA mapping.
>
> Changes in V2:
> 1. Supply more details about huge pte issue in follow_page_pte().
> 2. Fix some style problems.
>
> Xu Lu (4):
>    mm/gup: Add huge pte handling logic in follow_page_pte()
>    iommu/riscv: Use pte_t to represent page table entry
>    iommu/riscv: Introduce IOMMU page table lock
>    iommu/riscv: Add support for Svnapot
>
>   arch/riscv/include/asm/pgtable.h |   6 +
>   drivers/iommu/riscv/iommu.c      | 258 +++++++++++++++++++++++++------
>   include/linux/pgtable.h          |   8 +
>   mm/gup.c                         |  17 +-
>   4 files changed, 233 insertions(+), 56 deletions(-)
>


