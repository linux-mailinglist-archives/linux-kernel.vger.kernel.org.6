Return-Path: <linux-kernel+bounces-287751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCD1952C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416E91C23B21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FBB1BDABD;
	Thu, 15 Aug 2024 09:29:09 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3215572E;
	Thu, 15 Aug 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714148; cv=none; b=nWZxcC3pErhcRDfowyTikMAEAd4Q/N+hJdlqaXqbaYcXMw6EogFIaPxqdQPNlupL1SugZ/O8CYdmKVJev/v/yF+Xq0pzvBJtGdsfB2g+d0qoMsvN6RKdEc7ZwJwz7Rvo076eNaGx8jPFihhhPiGl3YHkNUDWe/6VeLuAcfq1gv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714148; c=relaxed/simple;
	bh=4VWThXqIQQdRRX7OwaQQqHqIAcoEUVfv/LoMIV62GS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kupd9U2TRQ53p+sJbBH9I2plb9+niBSda12EUq/XHbPoUcC8wFgIg7xg7l3vBp3DY9yEth9ThqD/xhAE1FOcoG3VdsOnldEod/sKWQx4eGwwDmB6XSDEcFL7mGe8SIGcMgVwv8JNsG5nhNrZEliEO2S/Bq+lmcc2I/G6bF14Q90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6379C0007;
	Thu, 15 Aug 2024 09:29:01 +0000 (UTC)
Message-ID: <384451e5-e2af-44f7-a5b5-894049232e09@ghiti.fr>
Date: Thu, 15 Aug 2024 11:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: misaligned: Restrict user access to kernel memory
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: stable@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Ben Dooks <ben.dooks@codethink.co.uk>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240815005714.1163136-1-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240815005714.1163136-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 15/08/2024 02:57, Samuel Holland wrote:
> raw_copy_{to,from}_user() do not call access_ok(), so this code allowed
> userspace to access any virtual memory address.
>
> Cc: stable@vger.kernel.org
> Fixes: 7c83232161f6 ("riscv: add support for misaligned trap handling in S-mode")
> Fixes: 441381506ba7 ("riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/kernel/traps_misaligned.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index b62d5a2f4541..1a76f99ff185 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -417,7 +417,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>   
>   	val.data_u64 = 0;
>   	if (user_mode(regs)) {
> -		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
> +		if (copy_from_user(&val, (u8 __user *)addr, len))
>   			return -1;
>   	} else {
>   		memcpy(&val, (u8 *)addr, len);
> @@ -515,7 +515,7 @@ int handle_misaligned_store(struct pt_regs *regs)
>   		return -EOPNOTSUPP;
>   
>   	if (user_mode(regs)) {
> -		if (raw_copy_to_user((u8 __user *)addr, &val, len))
> +		if (copy_to_user((u8 __user *)addr, &val, len))
>   			return -1;
>   	} else {
>   		memcpy((u8 *)addr, &val, len);


We could even do the access_ok() *before* even calling 
handle_misaligned_load() in do_trap_load_misaligned() to back off 
earlier. But unless you think it is important, I'm fine with this patch, 
it's on my list for -fixes!

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


