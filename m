Return-Path: <linux-kernel+bounces-196233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC528D5935
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2451F25560
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6233BBC9;
	Fri, 31 May 2024 04:05:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB633C9
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717128349; cv=none; b=mmyoIB5jMNguy6C+Q7EnVjCy758CLMuscqpg2utgv2h2iY1DgqJ939ogvsi+v9jad8pnXcgqWkBbF33f+OVqC+S+ebeL5Yl/VSOgx6H3cUUvzhDz6fz7A+P1TooLdgROTiW4JLpeAK8sUhQdJq+bEtONCa+vO2vi7Bk9bfsJsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717128349; c=relaxed/simple;
	bh=OdjpInGiHUr863daWuAQoy/PnJlO+T3esnvR7MSs2qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZkeuksvBUNK6vFrmnJA6FEN2Z3w+TiKPOWH0b/XypqXO/loRF6nSNKfaxgyHgxDY1tBiCEEqBuwK/PhupVA4FZB1I7mOrGRrfZFNRyvMaVkJh78bDqQbcgLYxqDI9/OzGGeN0QN4T/O71nrF9wGXKjkf6f6aG85mdITAnni0kfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vr8ZV57fbz1S8K9;
	Fri, 31 May 2024 12:01:54 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 409AD140258;
	Fri, 31 May 2024 12:05:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 31 May 2024 12:05:43 +0800
Message-ID: <51c9752c-5390-43a2-a800-7dc1043ac93c@huawei.com>
Date: Fri, 31 May 2024 12:05:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: mm: accelerate pagefault when badaccess"
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, <linux-riscv@lists.infradead.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <surenb@google.com>,
	<akpm@linux-foundation.org>, <alexghiti@rivosinc.com>, <jszhang@kernel.org>,
	<ben@decadent.org.uk>, Bjorn Topel <bjorn@rivosinc.com>,
	<willy@infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240530164451.21336-1-palmer@rivosinc.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240530164451.21336-1-palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/31 0:44, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> I accidentally picked up an earlier version of this patch, which had
> already landed via mm.  The patch  I picked up contains a bug, which I
> kept as I thought it was a fix.  So let's just revert it.
> 
> This reverts commit 4c6c0020427a4547845a83f7e4d6085e16c3e24f.


Yes, this one is the wrong v1.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>


> 
> Fixes: 4c6c0020427a ("riscv: mm: accelerate pagefault when badaccess")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>   arch/riscv/mm/fault.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index b3fcf7d67efb..5224f3733802 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -293,8 +293,8 @@ void handle_page_fault(struct pt_regs *regs)
>   	if (unlikely(access_error(cause, vma))) {
>   		vma_end_read(vma);
>   		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> -		tsk->thread.bad_cause = SEGV_ACCERR;
> -		bad_area_nosemaphore(regs, code, addr);
> +		tsk->thread.bad_cause = cause;
> +		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
>   		return;
>   	}
>   

