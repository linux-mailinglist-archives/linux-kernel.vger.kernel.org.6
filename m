Return-Path: <linux-kernel+bounces-196302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630288D59FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033C61F2515C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6EF446B4;
	Fri, 31 May 2024 05:45:57 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847851FA1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717134356; cv=none; b=Rv725d7oc82rw43EatuDKUGYE2Yj2ZE9y7KN/Ysn1hhwoqAH54DUc3k01SVu1bWZYOGrCPyvmU1KLyzTFzOjrgNXFvm/la0I+KxYPBDWIiopowEhp9+4e8cguETIDcomAUfwLHp4QO0gwBh13fi4InO33OTU/tj5AJaAxNJSFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717134356; c=relaxed/simple;
	bh=dSGGG9jfRUQbGQ5msnaX0lDM4XMbZF87UCR4efj7Lis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjNoFd5dl1juhgAoOScVpDSc0JC4A7oC0QWv53Nqbh8e57h/AI+l0JGP75GKmPNUBmWIw9p0YzHoYWtAFVUOkX9l/9GZKGIzQB4/Um6pYNP8GY3MNw5XF9YYFXFUTjfIlzlnGE/At8e2c/rNlW7eJVsyCj9MGa1BOHHW/05sABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2B94FF804;
	Fri, 31 May 2024 05:45:43 +0000 (UTC)
Message-ID: <e3cfd2f2-5d30-455f-8d10-66a2a71c13c7@ghiti.fr>
Date: Fri, 31 May 2024 07:45:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "riscv: mm: accelerate pagefault when badaccess"
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
 surenb@google.com, akpm@linux-foundation.org, alexghiti@rivosinc.com,
 wangkefeng.wang@huawei.com, jszhang@kernel.org, ben@decadent.org.uk,
 Bjorn Topel <bjorn@rivosinc.com>, willy@infradead.org,
 linux-kernel@vger.kernel.org
References: <20240530164451.21336-1-palmer@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240530164451.21336-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 30/05/2024 18:44, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I accidentally picked up an earlier version of this patch, which had
> already landed via mm.  The patch  I picked up contains a bug, which I
> kept as I thought it was a fix.  So let's just revert it.
>
> This reverts commit 4c6c0020427a4547845a83f7e4d6085e16c3e24f.
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


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


