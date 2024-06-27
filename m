Return-Path: <linux-kernel+bounces-232817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB191AE99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6AB282097
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F419AA41;
	Thu, 27 Jun 2024 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3ZsIKixe"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB713F441
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510925; cv=none; b=Hf2cEmv7pAGSaWDLyQD6ST/Yc/OZ5SnSCa8XyaltRqOd7gPlvPImfwf3tZv+z6vUkmIGkwzGHjDwJCEFamo7bgQ/q33C1ZFObJPos1MlaP6g99UujNi1I0BQN0Qs7/3PwzlpppzaKgNsBulrtNqL1ZxSCREMA5CWzRQkHF01St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510925; c=relaxed/simple;
	bh=n9FMHY69SRtY2LQY6nVpq3T3yap2DgBWaK5KcwrBmqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CN344dAdxXttXAXHP/fm99p1i7OQDUTbjxDb8IVlGMr62B997UYe3ddiizJ1AlU5YWinqH97Afi8pFatqR1YDQPzuJ7OXRnwrVNjwR42sXT15En7fbjyqWk3aU5zTPgE6zE6gSBO0lTQj4GW7/gxaUTccrSywIWX3LRSUUazgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3ZsIKixe; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-444fa363d1aso16203131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719510921; x=1720115721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwU7QC0bOdPm2F+i9wdfuJ75FiRpUL0sDT0gdpdPtAc=;
        b=3ZsIKixexLdf1GYEkiAIpTKZz9I60nu/0s9g4F36N4eqS/nXlhZR3Mt6tU8DnTKpoG
         2nG+Bhh8TEBvHLTx7lRoXPSXyQGUG0tUNmm/ctqegXBmS4Es/VuaoGkCZdaLuAvngkAP
         rzPA9JbbFZp7D9ZgHPiEJQqDknBj1bK6WCC5jlMptMaH4cf05ZzsoGKmxlAzRYdMwxCJ
         QHC2y1vU/bPD2aY43znreor8hqaFDgCHAqReyfgD/18mnutcmQMM+N4N2W7x4xzDyvoD
         4youpggDg3pbOQJx5HJ8hLeExlwfolnr3RFU6Suj9OVAbyWYWkJdGFxxFV/7t1Wu3ms6
         rOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510921; x=1720115721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwU7QC0bOdPm2F+i9wdfuJ75FiRpUL0sDT0gdpdPtAc=;
        b=w5BXGF38UTzGaQ10lRH4XutfvzpkkfOXPHU/xLpNNb2fYNJamx8TBmUqxzzkLAfsFy
         4tuzOhqJnKaRP3l/adxklxZ5TCAapZUhVgMaJSHb38WlkRAzrie00xrkHrkk7IkKt24M
         kGptpkJjR6NdcUAgUiixBIPbTvin9itImHZwZUflsURpnWIVV/1cYlVLGzG8fzZTJDx+
         2QYBRKqUPkwSs4bG6/sBOGL9Ks3zvJkZs6Az06Nw+PbNa2EDSDZeAZ5ypUk6NJAubBe1
         XSUBJDL49ML3Dmh3LR3hKqH1vXP1oUEyGU/46RrDD40LrUBWwJd1qAXwmAdhuhwCi13Z
         g8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2IoptIZPEutpujgm5RvKvULKU093IFVoS9juwlPB74Gj5HqZ1GGD9UGYUc8jyGlq4DMfxey0pvDZMwLid72RcFPn233zBpZMT30S
X-Gm-Message-State: AOJu0YyZ7ZyH9KszyS7pN1GUCBJURA1nXaC5yWnvJzZTkP9isczRN/mr
	wlD4o+I8LiOOQP3fsYJd3huRv5t+mq4PjObszzyqamhfo4YQMmKth3UQViY1vfo=
X-Google-Smtp-Source: AGHT+IFXL+tGllDhemSbNLp1f+hBQpnWvHis0iUFapHzWL0BcjD07U6I8MdfICAW6Lz7JYRSvHAi6A==
X-Received: by 2002:ac8:5782:0:b0:444:f3ce:1552 with SMTP id d75a77b69052e-444f3ce1a31mr123301341cf.34.1719510921395;
        Thu, 27 Jun 2024 10:55:21 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b28fsm432681cf.73.2024.06.27.10.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:55:21 -0700 (PDT)
Message-ID: <762bb09d-af48-47e0-9d65-f530ff37cbc9@rivosinc.com>
Date: Thu, 27 Jun 2024 13:55:19 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] RISC-V: Use Zkr to seed KASLR base address
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Wende Tan <twd2.me@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Sami Tolvanen <samitolvanen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Chen Jiahao <chenjiahao16@huawei.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240626171652.366415-1-jesse@rivosinc.com>
 <20240626171652.366415-3-jesse@rivosinc.com>
 <20240627-proven-irritably-33594282739f@wendy>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <20240627-proven-irritably-33594282739f@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/27/24 07:45, Conor Dooley wrote:
> Hey Jesse,
> 
> On Wed, Jun 26, 2024 at 01:16:52PM -0400, Jesse Taube wrote:
>> Parse the device tree for Zkr in isa string.
>> If Zkr is present, use it to seed the kernel base address.
>>
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> ---
>>   arch/riscv/kernel/pi/Makefile           |  2 +-
>>   arch/riscv/kernel/pi/archrandom_early.c | 30 ++++++++
>>   arch/riscv/kernel/pi/fdt_early.c        | 94 +++++++++++++++++++++++++
>>   arch/riscv/kernel/pi/pi.h               |  3 +
>>   arch/riscv/mm/init.c                    |  5 +-
>>   5 files changed, 132 insertions(+), 2 deletions(-)
>>   create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
>>
>> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
>> index 1ef7584be0c3..dba902f2a538 100644
>> --- a/arch/riscv/kernel/pi/Makefile
>> +++ b/arch/riscv/kernel/pi/Makefile
>> @@ -33,5 +33,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
>>   $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
>>   	$(call if_changed_rule,cc_o_c)
>>   
>> -obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
>> +obj-y		:= cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
>>   extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
>> diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/pi/archrandom_early.c
>> new file mode 100644
>> index 000000000000..c6261165e8a6
>> --- /dev/null
>> +++ b/arch/riscv/kernel/pi/archrandom_early.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <asm/csr.h>
>> +#include <linux/processor.h>
>> +
>> +#include "pi.h"
>> +
>> +/*
>> + * To avoid rewriting code include asm/archrandom.h and create macros
>> + * for the functions that won't be included.
>> + */
>> +#undef riscv_has_extension_unlikely
>> +#define riscv_has_extension_likely(...) false
>> +#undef pr_err_once
>> +#define pr_err_once(...)
>> +
>> +#include <asm/archrandom.h>
>> +
>> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa)
>> +{
>> +	unsigned long seed = 0;
>> +
>> +	if (!early_isa_str((const void *)dtb_pa, "zkr"))
>> +		return 0;
>> +
>> +	if (!csr_seed_long(&seed))
>> +		return 0;
>> +
>> +	return seed;
>> +}
>> diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
>> index 40ee299702bf..ba76197b44d1 100644
>> --- a/arch/riscv/kernel/pi/fdt_early.c
>> +++ b/arch/riscv/kernel/pi/fdt_early.c
>> @@ -23,3 +23,97 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
>>   	*prop = 0;
>>   	return ret;
>>   }
>> +
>> +/* Based off of fdt_stringlist_contains */
>> +static int isa_string_contains(const char *strlist, int listlen, const char *str)
> 
> The variable names here are needlessly confusing IMO. The function also
> returns a bool, not an int.
> 
>> +{
>> +	int len = strlen(str);
>> +	const char *p;
>> +
>> +	while (listlen >= len) {
>> +		if (strncasecmp(str, strlist, len) == 0)
>> +			return 1;
> 
> How does this handle searching a devicetree containing "rv64ima_zksed_zkr"
> for the extension zks? Hint: https://godbolt.org/z/YfhTqe54e
> I think this works for fdt_stringlist_contains() because it also
> compares the null chars - which you're not doing so I think this also
> brakes for something like riscv,isa-extensions = "rv64ima\0zksed\0zkr"
> while searching for zks.
> 
>> +		p = memchr(strlist, '_', listlen);
> 
> Or how does this handle searching "rv64imafdczkr" for zkr? It's gonna
> run right off the end of the string without finding anything, right?

Yes...

Is that a valid isa,string? I will try to copy how cpufeature.c as close 
as posible.

> 
> Handling "riscv,isa" is not trivial, but at least the search for extension
> approach here skips dealing with some of what has to be done in the "real"
> parser with the version numbers...
> 
> Maybe we just say screw "riscv,isa", as it's deprecated anyway, and only.
I think it's important to have.

> add this new feature for "riscv,isa-extensions" which is far simpler to
> parse and can be done using off-the-shelf fdt functions?
> 
> If not, then I think we should use fdt_stringlist_contains verbatim for
> "riscv,isa-extensions".

Ok I had a notion that riscv,isa-extensions could be upercase they 
cant/wont. I will use fdt_stringlist_contains.

> and introduce a custom function for "riscv,isa"
> only.

That was my original thought I will do that.

> 
>> +		if (!p)
>> +			p = memchr(strlist, '\0', listlen);
>> +		if (!p)
>> +			return 0; /* malformed strlist.. */
>> +		listlen -= (p - strlist) + 1;
>> +		strlist = p + 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Based off of fdt_nodename_eq_ */
> 
> Why can't we just use fdt_nodename_eq?

Because fdt_nodename_eq_ is static.
I will change the comment to "copy of fdt_nodename_eq_".
Oddly there is `of_node_name_eq` but not `fdt_nodename_eq`

> 
>> +static int fdt_node_name_eq(const void *fdt, int offset,
>> +			    const char *s)
>> +{
>> +	int olen;
>> +	int len = strlen(s);
>> +	const char *p = fdt_get_name(fdt, offset, &olen);
>> +
>> +	if (!p || olen < len)
>> +		/* short match */
>> +		return 0;
>> +
>> +	if (memcmp(p, s, len) != 0)
>> +		return 0;
>> +
>> +	if (p[len] == '\0')
>> +		return 1;
>> +	else if (!memchr(s, '@', len) && (p[len] == '@'))
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
>> +
>> +/*
>> + * Returns true if the extension is in the isa string
>> + * Returns false if the extension is not found
>> + */
>> +static bool get_ext_named(const void *fdt, int node, const char *name)
> 
> Could you rename this function please?

Yes.

> Having something named "get" that
> returns a bool, and not an "ext_named" is odd - and it'd be self
> explanatory in that case. Maybe it can just be moved into the sole caller
> and isn't needed?

I have it as a seperate function if in the future there needed to be a 
per cpu check.

>> +{
>> +	const void *prop;
>> +	int len;
>> +
>> +	prop = fdt_getprop(fdt, node, "riscv,isa-base", &len);
>> +	if (prop && isa_string_contains(prop, len, name))
>> +		return true;
> 
> This shouldn't be here, there'll not be an extension in this property.
Will remove.

> 
>> +	prop = fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
>> +	if (prop && isa_string_contains(prop, len, name))
>> +		return true;
>> +
>> +	prop = fdt_getprop(fdt, node, "riscv,isa", &len);
>> +	if (prop && isa_string_contains(prop, len, name))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +/*
>> + * Returns true if the extension is in the isa string on all cpus
> 
> Shouldn't we only be checking CPUs that are not disabled or reserved,
> rather than all CPUs?

Its way easier to just check all the cpus rather then make sure we are 
runing on one thats has the extention. I will add a continue for 
dissabled/reserved cpus.

> To use Zkr for KASLR this is kinda irrelevant
> since really we only care about whether or not the boot CPU has Zkr,
> but in general we only want to consider CPUs that we can actually use.
> For example, if you did this for FPU support with mpfs.dtsi, you'd get
> told that the F/D extensions were not present cos hart 0

Can we assume that the boot hart is always 0?

> doesn't have
> them, even though it's disabled and will not be used by Linux.
> 
>> + * Returns false if the extension is not found
>> + */
>> +bool early_isa_str(const void *fdt, const char *ext_name)
> 
> Could you try to match the naming of the stuff used outside of pi?
> Maybe early_isa_ext_available()?

Yes.

Thanks,
Jesse Taube

> 
> Thanks for the update,
> Conor.
> 
>> +{
>> +	int node, parent;
>> +	bool ret = false;
>> +
>> +	parent = fdt_path_offset(fdt, "/cpus");
>> +	if (parent < 0)
>> +		return false;
>> +
>> +	fdt_for_each_subnode(node, fdt, parent) {
>> +		if (!fdt_node_name_eq(fdt, node, "cpu"))
>> +			continue;
>> +
>> +		if (!get_ext_named(fdt, node, ext_name))
>> +			return false;
>> +
>> +		ret = true;
>> +	}
>> +
>> +	return ret;
>> +}
>> diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
>> index 65da99466baf..26e7e5f84a30 100644
>> --- a/arch/riscv/kernel/pi/pi.h
>> +++ b/arch/riscv/kernel/pi/pi.h
>> @@ -4,6 +4,8 @@
>>   
>>   #include <linux/types.h>
>>   
>> +bool early_isa_str(const void *fdt, const char *ext_name);
>> +
>>   /*
>>    * The folowing functions are exported (but prefixed) declare them here so
>>    * that LLVM does not complain it lacks the 'static' keyword (which, if
>> @@ -11,6 +13,7 @@
>>    */
>>   
>>   u64 get_kaslr_seed(uintptr_t dtb_pa);
>> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>>   bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>>   u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
>>   
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9940171c79f0..bfb068dc4a64 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
>>   #ifdef CONFIG_RANDOMIZE_BASE
>>   extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>>   extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
>> +extern u64 __init __pi_get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>>   
>>   static int __init print_nokaslr(char *p)
>>   {
>> @@ -1045,10 +1046,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>   
>>   #ifdef CONFIG_RANDOMIZE_BASE
>>   	if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
>> -		u64 kaslr_seed = __pi_get_kaslr_seed(dtb_pa);
>> +		u64 kaslr_seed = __pi_get_kaslr_seed_zkr(dtb_pa);
>>   		u32 kernel_size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
>>   		u32 nr_pos;
>>   
>> +		if (kaslr_seed == 0)
>> +			kaslr_seed = __pi_get_kaslr_seed(dtb_pa);
>>   		/*
>>   		 * Compute the number of positions available: we are limited
>>   		 * by the early page table that only has one PUD and we must
>> -- 
>> 2.45.2
>>

