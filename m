Return-Path: <linux-kernel+bounces-363923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A099C87C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8391C23AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92F19ABDE;
	Mon, 14 Oct 2024 11:13:08 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062617BECA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904387; cv=none; b=DfCxtp5bfqgPZUtETKkbMQx22Uatq9VG5EoF8bFSvMIuW6I5Jxsd9jn/Mq6pL09b+wQe+JioMXOrE9qmUA5UA+5yfLJo8BTsgUDRG9fkWG/uhJP98LW8dAbA76X3u20oX5LpIHueqlmRq4++eg0KS2sPGgUIwXTQw3LSXbWcv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904387; c=relaxed/simple;
	bh=sf73umAdsshCxjnI1FBaiVERr9V5mGYONtFk0jvxidY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQEMyJeoP3kqRPQTNkI2kPXZCXt6OYSNuNlhRp/h/z08DuCou/qMBqFPEsDGaVonZHyEQ4zdtOvZBtSCPXCVDW3gtVk/eWAMEEXFRzWjde+rKlUfz6xSBppi4AtNgR8eqKXDSd+3ZkWHUl9G66yEeZomkFIjBLDwvOnrULmDWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A82F01C0003;
	Mon, 14 Oct 2024 11:12:53 +0000 (UTC)
Message-ID: <8138c729-8a30-454d-8422-234cead415ab@ghiti.fr>
Date: Mon, 14 Oct 2024 13:12:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: vdso: Prevent gcc from inserting calls to
 memset()
Content-Language: en-US
To: Palmer Dabbelt <palmer@dabbelt.com>, alexghiti@rivosinc.com
Cc: vladimir.isaev@syntacore.com, roman.artemev@syntacore.com,
 guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <mhng-b17acfa9-03e8-4ef7-a24f-a133b2dbf31a@palmer-ri-x1c9>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mhng-b17acfa9-03e8-4ef7-a24f-a133b2dbf31a@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Palmer,

On 17/09/2024 17:41, Palmer Dabbelt wrote:
> On Thu, 04 Jul 2024 23:09:01 PDT (-0700), alexghiti@rivosinc.com wrote:
>> gcc is smart enough to insert a call to memset() in
>> riscv_vdso_get_cpus(), which generates a dynamic relocation.
>>
>> So prevent gcc from doing that by using the
>> -fno-tree-loop-distribute-patterns option.
>
> This option doesn't exist on LLVM (at least on whatever version I'm 
> using), and I'm not getting any memset()s generated locally so I'm not 
> sure what to look for over there.
>

When compiling a rv32_defconfig (still on 6.12), I get:

~/linux$ riscv64-unknown-elf-readelf -r 
build_defconfig_rv32/arch/riscv/kernel/vdso/vdso.so

Relocation section '.rela.dyn' at offset 0x5a0 contains 1 entry:
  Offset     Info    Type            Sym.Value  Sym. Name + Addend
00000314  00000205 R_RISCV_JUMP_SLOT 00000000   memset + 0


> From poking around GCC it looks like we might want -fno-tree-ccp too? 
> That seems to be able to convert assignments into builtins as well...


I gave a try at -fno-tree-ccp, but it did not remove this relocation.

I now see this relocation in llvm too, so it would be nice to find a 
common option or another way to do it, any idea is welcome!

Thanks,

Alex


>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>  arch/riscv/kernel/vdso/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/kernel/vdso/Makefile 
>> b/arch/riscv/kernel/vdso/Makefile
>> index f7ef8ad9b550..c7e40bf36371 100644
>> --- a/arch/riscv/kernel/vdso/Makefile
>> +++ b/arch/riscv/kernel/vdso/Makefile
>> @@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
>>
>>  ccflags-y := -fno-stack-protector
>>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>> +ccflags-y += -fno-tree-loop-distribute-patterns
>>
>>  ifneq ($(c-gettimeofday-y),)
>>    CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

