Return-Path: <linux-kernel+bounces-322527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F53972A48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3BF1F249A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4717C220;
	Tue, 10 Sep 2024 07:09:47 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B1417BB28
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952187; cv=none; b=kWkyaJf8aTFlTjBjV8pvtkDtCaBYm5NKZjkBPYxdRIn8hSPjggBBaWbFRJxJA4v8m+m0pWXDxb2k42czgCCpcS8opy1yJ6vAkrXCqaBtdz5qVHb47SiJczlZ9KiylJF2NKfUOWI+DUMC/yISYRmCv+1Wewl7BVx7RrPT9ijhqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952187; c=relaxed/simple;
	bh=7x2cPYDAWoFuWThlDmRXtgIJdha17zt5R25t3YfY2xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUL9/7A7UU02sAMT0EbsRb+NZ7BJnRa4hYTKZWayZzB9kK9MN1q0PxYn++9EnxGrSCDrlu/CPSyIydWgkR+gAFz3ZxOPlPM1yxaX1KqoHBd8xmdFUi94oQmh/7qfC0S8WrBT43wHOEWtymDXT+3D6pq7zQ3OpLVL4Z/m5CUE4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D1AFE0005;
	Tue, 10 Sep 2024 07:09:40 +0000 (UTC)
Message-ID: <f6915c21-1dbd-44f6-a118-7e3a5c442e64@ghiti.fr>
Date: Tue, 10 Sep 2024 09:09:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: remove useless pc check in stacktrace handling
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240830084934.3690037-1-cleger@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240830084934.3690037-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Clément,

On 30/08/2024 10:49, Clément Léger wrote:
> Checking for pc to be a kernel text address at this location is useless
> since pc == handle_exception. Remove this check.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>
> ---
>   arch/riscv/kernel/stacktrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index c6d5de22463f..f934c573c087 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -72,7 +72,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>   			pc = ftrace_graph_ret_addr(current, &graph_idx, frame->ra,
>   						   &frame->ra);
>   			if (pc == (unsigned long)handle_exception) {
> -				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> +				if (unlikely(!fn(arg, pc)))
>   					break;
>   
>   				pc = ((struct pt_regs *)sp)->epc;


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


