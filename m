Return-Path: <linux-kernel+bounces-385043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC89B31AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CEB1C21894
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56F1DC748;
	Mon, 28 Oct 2024 13:29:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3B1DC734
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122153; cv=none; b=qe0fWLaInlWVswvjACzFwoKU8ImSdRki3Y97UnRkTAeYnBbCQujXni65V7aiEsNA6Y5j9GqRdaTJQ/guINmBRiuz5Nc66gi/FFGoAHvvmbmx4XXGWkCUlooZe5mpyMpH07P6ElMM1FwBWuKCPZHwnrYNJ4vqyGGjs+R1faZH40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122153; c=relaxed/simple;
	bh=mLO4sHkjjgqpMWZHhmi3y/M3MSZ7sNZpYWTIWg5667o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbFk8Ysoec8lydzRlOsRUQ1zr0GBgTXCW6HgJiVb3CW5NRmIsgnriJpJApcZofK/0JsAPQFLtbz2IOxfmRIDHEYZSKF5abc68GzLc4Yiyj9s4w/g1EU7mK/LFKyQM7GR/l/tUutK/7zkaBd09JRZqy8AGXeAczFtU18sszdVXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C492497;
	Mon, 28 Oct 2024 06:29:39 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 493D93F66E;
	Mon, 28 Oct 2024 06:29:08 -0700 (PDT)
Message-ID: <c4e1b5c8-4830-4835-86b5-22171450f1b2@arm.com>
Date: Mon, 28 Oct 2024 13:29:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdso: change PAGE_MASK to signed on all 32-bit
 architectures
To: Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <20241024133447.3117273-1-arnd@kernel.org>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20241024133447.3117273-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/10/2024 14:34, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With the introduction of an architecture-independent defintion of
> PAGE_MASK, we had to make a choice between defining it as 'unsigned
> long' as on 64-bit architectures, or as signed 'long' as required for
> architectures with a 64-bit phys_addr_t.
> 
> To reduce the risk for regressions and minimize the changes in behavior,
> the result was using the signed value only when CONFIG_PHYS_ADDR_T_64BIT
> is set, but that ended up causing a regression after all in the
> early_init_dt_add_memory_arch() function that uses 64-bit integers for
> address calculation.
> 
> Presumably the same regression also affects mips32 and powerpc32 when
> dealing with large amounts of memory on DT platforms: like arm32, they
> were using the signed version unconditionally.
> 
> The two most sensible options that I see for addressing the regiression
> are either to go back to an architecture specific definition, using a
> signed constant on arm/powerpc/mips and unsigned on the others, or to
> use the same definition everywhere.
> 
> Use the simpler of those two and change them all to the signed version,
> in the hope that this does not cause a different type of bug. Most
> of the other 32-bit architectures have no large physical address
> support and are rarely used, so it seems more likely that using the
> same definition helps than hurts here.
> 
> In particular, x86-32 does have physical addressing extensions, so it
> already changed to the signed version after the previous patch,
> so it makes sense to use the same version on non-PAE as well.
> 
> Fixes: efe8419ae78d ("vdso: Introduce vdso/page.h")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: Alex Bennee <alex.bennee@linaro.org>,
> Link: https://lore.kernel.org/lkml/CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com/

Thanks Arnd, I tested it this morning and seems working correctly with qemu 9.1.1.

With this:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/vdso/page.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/vdso/page.h b/include/vdso/page.h
> index 4ada1ba6bd1f..710ae2414e68 100644
> --- a/include/vdso/page.h
> +++ b/include/vdso/page.h
> @@ -14,13 +14,14 @@
>  
>  #define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
>  
> -#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_64BIT)
> +#if !defined(CONFIG_64BIT)
>  /*
> - * Applies only to 32-bit architectures with a 64-bit phys_addr_t.
> + * Applies only to 32-bit architectures.
>   *
>   * Subtle: (1 << CONFIG_PAGE_SHIFT) is an int, not an unsigned long.
>   * So if we assign PAGE_MASK to a larger type it gets extended the
> - * way we want (i.e. with 1s in the high bits)
> + * way we want (i.e. with 1s in the high bits) while masking a
> + * 64-bit value such as phys_addr_t.
>   */
>  #define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
>  #else

-- 
Regards,
Vincenzo

