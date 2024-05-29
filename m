Return-Path: <linux-kernel+bounces-194725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A9F8D410B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118271F23764
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1801C8FCA;
	Wed, 29 May 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="E2oJ1qVe"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCC169361
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020248; cv=none; b=n5iTMXLSnF0FTrbTP31MYUSQ21m8ss3fDnetJowXIO2MskC+kjv4dersIcaSZwhWyBePk388AGly6dxat4GYAb/HIxtppwXO/zfL7UZqLRzpJi3dez9Vwk+IQDuqnyMH9Hdgn4Jtit/pAyjIxUw3E6BDocO65Rjhlo6tOmMvx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020248; c=relaxed/simple;
	bh=lxfRgnf95liBnRvndxoOwPf+FRV7px+87k++y56Vr08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlnWJEi4ouXGE+lVRNBkOSDPNSizudugz68JRqsX9U9Rjuew8aAFyqofaw4z1qYBJ3iUJsh1iVIGFoQ0PAlOB3D0JUpq3YJ0mSmt/F7f5FS8KOdxUNWvjV5BOGfvAfLJW76TmYAx23AzYLeVHh7JwY0c4GJzuZeF1OI+4Oi8J0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=E2oJ1qVe; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79305314956so18364785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717020246; x=1717625046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNRVbCxzmmEAj6zXCnapG6pKcGSf1C8RmFzEbJ1ADH0=;
        b=E2oJ1qVeMJWNzU3A86QKuj3uRR9q4ctncQ/yz6Mc1KgbH6af3TFzlHIGTXWxoPijLJ
         9c+jUTjzLBXLbKY6z2svdBYTKuwCeDu/eDq+vplIpwucAcB+PywElmM65CkcqNtyIbpC
         nq9G3CYeIMvjhKDf75ce9P2LmiH0GrjktWnLL+F8hnP1BADPUPQrg21jsYDjhWzt9F8A
         EjY3JLUF0HsGGfKXQrIv572ukNtFzeR0uGtidDFPnwQx3kShXvrl57lE2Nk3Nk5viJJl
         2Yq7oHggUzRkpC4uPHJ9v/FlIIcK8RF7IuotC6HqjGbm+4MQ5qq6j3L2AXjCMHaNxNsL
         DHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020246; x=1717625046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNRVbCxzmmEAj6zXCnapG6pKcGSf1C8RmFzEbJ1ADH0=;
        b=tEOi5ByzzIJlUE1yVneQZ5QRifrok4SH5jZqLtIybfih1EkOXhDvfdrnULGEySPA55
         SBKUycSqztWf9OpJNPEOnLehV7GDk3oDqVzPGmL47wcqvOFnEDSHBmqHmGyy4riuVdS5
         FjXrxnomyss7vKnTJhTBuu7Rku6OOTc1E4sUd69fiWKEUwq3gmC0Nh2A4g7sxpbx9LLc
         w3zpQffFKiXCTE438mFhGl8Ijb++sZqwvL7+gn9lZSRB8upGUYPXoIbFzmFjnLHs7IMI
         WyhQyLIoy/OKl+pySiE7ipU1auR6fvWrBK4pnDQM407sNpfoaBMwdTwKIwxDJZeuYYFh
         5+rw==
X-Forwarded-Encrypted: i=1; AJvYcCWmV3ahvl7L6IW52jwou9TXHn0eZuq3pGgro/mZKD/EihPjZYkOAU4kImF5beuHKIX8gEzUQTqPcyTYysCOaT3tHFKnrDikP9H7fbtI
X-Gm-Message-State: AOJu0YwklwCQpiJAidphGaDFimu2pf2DWQZC1wwYouUel0av5i1uNPIP
	I/O6kF6qn6MUY68Zq4U1E9RU8/3ddMxGrIzOu93upTif8kzkVyObIBa0aoQfrkM=
X-Google-Smtp-Source: AGHT+IHDZpmmzmoJ+k9ZbeknnEHLbYmkLEOEN+VjMtD7xnzdtBpnugQ1ISqlpwt1UFzDGTypUKf2rg==
X-Received: by 2002:a05:6214:3c87:b0:6ad:6059:208a with SMTP id 6a1803df08f44-6ae0cb39254mr5890786d6.35.1717020245797;
        Wed, 29 May 2024 15:04:05 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070d8f3dsm58003716d6.33.2024.05.29.15.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:04:05 -0700 (PDT)
Message-ID: <11b3de44-522b-4638-987c-2ca132e84936@sifive.com>
Date: Wed, 29 May 2024 17:04:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Anup Patel <apatel@ventanamicro.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Frank Rowand <frowand.list@gmail.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com>
 <CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAMuHMdVYFFR7K5SbHBLY-JHhb7YpgGMS_hnRWm8H0KD-wBo+4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 2024-05-29 9:22 AM, Geert Uytterhoeven wrote:
> Hi Anup,
> 
> On Thu, Feb 22, 2024 at 10:41 AM Anup Patel <apatel@ventanamicro.com> wrote:
>> The PLIC driver does not require very early initialization so convert
>> it into a platform driver.
>>
>> After conversion, the PLIC driver is probed after CPUs are brought-up
>> so setup cpuhp state after context handler of all online CPUs are
>> initialized otherwise PLIC driver crashes for platforms with multiple
>> PLIC instances.
>>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> 
> Thanks for your patch, which is now commit 8ec99b033147ef3b
> ("irqchip/sifive-plic: Convert PLIC driver into a platform
> driver") in v6.9.
> 
> It looks like this conversion is causing issues on BeagleV Starlight
> Beta.  After updating esmil/visionfive to v6.10-rc1, the kernel usually
> fails to boot. Adding "earlycon keep_bootcon" reveals these differences:
> 
> -riscv-plic c000000.interrupt-controller: mapped 133 interrupts with 2
> handlers for 4 contexts.
> +------------[ cut here ]------------
> +WARNING: CPU: 0 PID: 1 at drivers/irqchip/irq-sifive-plic.c:373
> plic_handle_irq+0xf2/0xf6
> +Modules linked in:
> +CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.10.0-rc1-starlight-02342-g0ba4c76ca0e8-dirty #323
> +Hardware name: BeagleV Starlight Beta (DT)
> +epc : plic_handle_irq+0xf2/0xf6
> + ra : generic_handle_domain_irq+0x1c/0x2a
> +epc : ffffffff8033f994 ra : ffffffff8006319a sp : ffffffc800003f50
> + gp : ffffffff812d63f0 tp : ffffffd8800b8000 t0 : 0000000000000040
> + t1 : 0000000000000000 t2 : 0000000000001000 s0 : ffffffc800003fa0
> + s1 : 0000000000000009 a0 : ffffffd880183600 a1 : 0000000000000009
> + a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> + a5 : 0000000000000000 a6 : ffffffd880400248 a7 : ffffffd8804002b8
> + s2 : ffffffd9f8fac458 s3 : 0000000000000004 s4 : 0000000000000000
> + s5 : ffffffff81293f58 s6 : ffffffd88014ac00 s7 : 0000000000000004
> + s8 : ffffffc800013b2c s9 : ffffffc800013b34 s10: 0000000000000006
> + s11: ffffffd9f8fc1458 t3 : 0000000000000002 t4 : 0000000000000402
> + t5 : ffffffd8800610c0 t6 : ffffffd8800610e0
> +status: 0000000200000100 badaddr: ffffffd9f8fac458 cause: 0000000000000003
> +[<ffffffff8033f994>] plic_handle_irq+0xf2/0xf6
> +[<ffffffff8006319a>] generic_handle_domain_irq+0x1c/0x2a
> +[<ffffffff8033d7aa>] riscv_intc_irq+0x26/0x60
> +[<ffffffff806c92ee>] handle_riscv_irq+0x4a/0x74
> +[<ffffffff806d2346>] call_on_irq_stack+0x32/0x40
> +---[ end trace 0000000000000000 ]---
> +Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000004
> +Oops [#1]
> +Modules linked in:
> +CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> 6.10.0-rc1-starlight-02342-g0ba4c76ca0e8-dirty #323
> +Hardware name: BeagleV Starlight Beta (DT)
> +epc : plic_handle_irq+0x66/0xf6
> + ra : generic_handle_domain_irq+0x1c/0x2a
> +epc : ffffffff8033f908 ra : ffffffff8006319a sp : ffffffc800003f50
> + gp : ffffffff812d63f0 tp : ffffffd8800b8000 t0 : 0000000000000040
> + t1 : 0000000000000000 t2 : 0000000000001000 s0 : ffffffc800003fa0
> + s1 : 0000000000000009 a0 : ffffffd880183600 a1 : 0000000000000009
> + a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> + a5 : ffffffff8033d72a a6 : ffffffd880400248 a7 : ffffffd8804002b8
> + s2 : ffffffd9f8fac458 s3 : 0000000000000004 s4 : ffffffd880183630
> + s5 : ffffffff81293f58 s6 : ffffffff812948a0 s7 : ffffffff80c4e660
> + s8 : ffffffff80d9eea0 s9 : ffffffc800013b34 s10: 0000000000000006
> + s11: ffffffd9f8fc1458 t3 : 0000000000000002 t4 : 0000000000000402
> + t5 : ffffffd8800610c0 t6 : ffffffd8800610e0
> +status: 0000000200000100 badaddr: 0000000000000004 cause: 000000000000000d
> +[<ffffffff8033f908>] plic_handle_irq+0x66/0xf6
> +[<ffffffff8006319a>] generic_handle_domain_irq+0x1c/0x2a
> +[<ffffffff8033d7aa>] riscv_intc_irq+0x26/0x60
> +[<ffffffff806c92ee>] handle_riscv_irq+0x4a/0x74
> +[<ffffffff806d2346>] call_on_irq_stack+0x32/0x40
> +Code: 8b93 d70b 5b17 00f5 0b13 fa8b fc17 00a5 0c13 5a0c (a783) 0009
> +---[ end trace 0000000000000000 ]---
> +Kernel panic - not syncing: Fatal exception in interrupt
> +SMP: stopping secondary CPUs
> +---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> As "mapped 133 interrupts" is no longer printed, it looks like an
> unexpected early interrupt comes in while still in plic_probe().
> 
> Esmil suggested reverting all of:
> a7fb69ffd7ce438a irqchip/sifive-plic: Avoid explicit cpumask allocation on stack
> abb7205794900503 irqchip/sifive-plic: Improve locking safety by using
> irqsave/irqrestore
> 95652106478030f5 irqchip/sifive-plic: Parse number of interrupts and
> contexts early in plic_probe()
> a15587277a246c38 irqchip/sifive-plic: Cleanup PLIC contexts upon
> irqdomain creation failure
> 6c725f33d67b53f2 irqchip/sifive-plic: Use riscv_get_intc_hwnode() to
> get parent fwnode
> b68d0ff529a939a1 irqchip/sifive-plic: Use devm_xyz() for managed allocation
> 25d862e183d4efeb irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
> 8ec99b033147ef3b irqchip/sifive-plic: Convert PLIC driver into a platform driver
> 
> After this, the PLIC is initialized earlier again, and this indeed
> seems to fix the issue for me.
> Before, the kernel booted fine in only ca. 1 out of 5 tries.
> After the reverts, it booted 5/5.
> 
> Do you know what's going on? Is there a simpler fix?

The fact that you hit the warning indicates that plic_handle_irq() was called
before handler->present was set. Previously the PLIC driver was probed very
early, so it is unlikely that some peripheral already had a pending interrupt.
Now, while platform device drivers would not yet be able to request interrupts
(because the irqdomain is not registered yet), they could have programmed the
hardware in a way that generates an interrupt. If that interrupt was enabled at
the PLIC (e.g. by the bootloader), then we could expect plic_handle_irq() to be
called as soon as irq_set_chained_handler() is called.

So the fix is to not call irq_set_chained_handler() until after the handlers are
completely set up.

I've sent a patch doing this:
https://lore.kernel.org/linux-riscv/20240529215458.937817-1-samuel.holland@sifive.com/

Regards,
Samuel


