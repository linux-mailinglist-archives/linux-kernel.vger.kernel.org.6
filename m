Return-Path: <linux-kernel+bounces-173695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6E8C0445
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D47B247A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921112C814;
	Wed,  8 May 2024 18:25:49 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC11292E5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192749; cv=none; b=BxvFxZ+zpkdnKtFqunkJQaSgcJkSmRwUbZe6+Prgh7nUagnYhe+4Dlt8FxRm5U7Syu+ih7hb8WJeZLRTyAw2TOTShX+SSF5sM44T0Tt5V5a97n2diQzOqO0QJC4y6THaV4/gCJXPE8J3Vm3r5t/LW1A12ztAzXwllnhk2xXLAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192749; c=relaxed/simple;
	bh=ItrjONTKazFM54mQO0cKmmhKMQAKqNk0ljaWbS5eIHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIorcUFSBt4ELJ7TvsE+eQpl9T1+h3AdP+GiDMqKslL2dGwVCpyiW8bskOHIwYz9k8e4PJuk1is3CE9+Pd5LQGe7GeCEJE2y+006JYplouXoofw4Czxk+SXQ4wRfu4SruXf8Hoxs6wprGRmajU7gxpvgXvwz7FwmTKouY8ps3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10E491C0005;
	Wed,  8 May 2024 18:25:36 +0000 (UTC)
Message-ID: <3bb94ee6-622d-4dd8-ac11-b8bd2b2849ef@ghiti.fr>
Date: Wed, 8 May 2024 20:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-mm@kvack.org
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
 <20240508092756.58fba60e4b6ce0986e8f5f73@linux-foundation.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240508092756.58fba60e4b6ce0986e8f5f73@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

Hi Andrew,

On 08/05/2024 18:27, Andrew Morton wrote:
> On Wed,  8 May 2024 13:18:20 +0200 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>
>> This patchset intends to merge the contiguous ptes hugetlbfs implementation
>> of arm64 and riscv.
>>
>> ...
>>
>>   arch/arm64/Kconfig                  |   1 +
>>   arch/arm64/include/asm/pgtable.h    |  56 +++++-
>>   arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>>   arch/riscv/Kconfig                  |   1 +
>>   arch/riscv/include/asm/hugetlb.h    |   2 +-
>>   arch/riscv/include/asm/pgtable-64.h |  11 ++
>>   arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>>   arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>>   arch/riscv/mm/pgtable.c             |   6 +-
>>   mm/Kconfig                          |   3 +
>>   mm/Makefile                         |   1 +
>>   mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>>   12 files changed, 480 insertions(+), 544 deletions(-)
>>   create mode 100644 mm/contpte.c
> Hits three subsystems, so I guess mm.git is the place.  I'll await
> reviewer/tester input and let's look at getting this into mm.git after
> 6.10-rc1?


Sure, fine by me :)

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

