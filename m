Return-Path: <linux-kernel+bounces-290147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55119954FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8805C1C211F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0280638;
	Fri, 16 Aug 2024 17:30:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7D1C2317
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829408; cv=none; b=fjI69HnsrlvdtVEAwqu9ditJxNduZqcJDEjxVGZwI6nmM430ytEGtGdACaXRGvTcMlAdNCg9bdZFQkPSgt1ICFnCGjYE7gdCCFTwrNlvw4EbMr1KWCvYyvYO5gM8NbfL++1aXmRFXKlkAMq/a5NLmlDXwol/vtGEyLf0oUv8+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829408; c=relaxed/simple;
	bh=HDKVq/7kh3cg8+DZYsi7+UHyE2VlDVgogEa9PyY+HSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqSw/3SmIRIPb/KPuRvyUIejdd5JauFarvLm0QChMWZBTcAZ3xJ0f6FgLb4x1sgqqGjtB3vKkUNoM+WRkkU4rdZJCfEUOU3Jo2G7ZUXVJdcoP1b0JVNq2TM0jPPMFGH97ewU/mUPHu4kUJe3Hk7b3pSqtY3TeN280nzDbJi7rNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8FDE40002;
	Fri, 16 Aug 2024 17:29:55 +0000 (UTC)
Message-ID: <abec162e-f3f2-488c-83d9-be17257a5df8@ghiti.fr>
Date: Fri, 16 Aug 2024 19:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org
References: <20240321230131.1838105-1-samuel.holland@sifive.com>
 <20240813-pony-truck-3e7a83e9759e@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240813-pony-truck-3e7a83e9759e@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 13/08/2024 22:26, Conor Dooley wrote:
> On Thu, Mar 21, 2024 at 04:01:25PM -0700, Samuel Holland wrote:
>> These are useful for measuring the latency of SBI calls. The SBI HSM
>> extension is excluded because those functions are called from contexts
>> such as cpuidle where instrumentation is not allowed.
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> I seem to have bisected a boot failure on v6.11-rc# to this commit,
> with a crash before the kernel ever gets to output anything - even on
> the bootconsole. For one of these crashes I got the below (which is
> actually U-Boots exception handler), but most of the time - nothing at
> all. I'll try to decodecode that tomorrow and fish out a config, because
> this is either config or toolchain dependant (I saw it in work, with a
> slightly different config etc to what I have here).
>
>
> Starting kernel ...
>   
> Unhandled exception: Load access fault
> EPC: 000000008020e09c RA: 000000008020e510 TVAL: ffffffff81cbf1f0
> EPC: 00000000408a009c RA: 00000000408a0510 reloc adjusted
>   
> Code: 3597 01a4 b583 1f45 5613 0035 9a61 95b2 (618c)
>   
>   
> resetting ...
> reset not supported yet
> ### ERROR ### Please RESET the board ###
>
>
> Cheers,
> Conor.


So I have just hit a similar issue while debugging the syzkaller 
failure. The problem is visible with KASAN, TRACEPOINTS and 
RISCV_ALTERNATIVE_EARLY.

The latter is important since this is where the very early sbi call is 
made in riscv_fill_cpu_mfr_info() 
(https://elixir.bootlin.com/linux/v6.11-rc3/source/arch/riscv/kernel/alternative.c#L32).

And since kernel/sbi.c is compiled with KASAN instrumentation, it fails 
to access the KASAN region as it is not yet set up (the MMU is not up 
yet). So the following fixes the issue:

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..3b926c9444d0 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -31,6 +31,7 @@ endif
  ifdef CONFIG_KASAN
  KASAN_SANITIZE_alternative.o := n
  KASAN_SANITIZE_cpufeature.o := n
+KASAN_SANITIZE_sbi.o := n
  endif
  endif

But I don't like this solution as it removes instrumentation everywhere 
in this file. I'd rather move the __sbi_ecall() into its own file and 
remove the instrumentation here.

@Conor Can you give the diff above a try and see if it fixes your issue?

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

