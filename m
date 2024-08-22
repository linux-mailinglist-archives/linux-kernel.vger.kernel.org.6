Return-Path: <linux-kernel+bounces-296332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A198F95A956
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF09B21B84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4B79FD;
	Thu, 22 Aug 2024 01:09:58 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F7320B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288998; cv=none; b=jIK1bOGgtDxyaMhFtTOash8H0DMj3PcU7hpvn4gYR+ksyS9G50FwWlNZGS9ICfrWa7ndbTbQCiBHM4TNKGgxrK3IMDnerHrilkIYkSBpP1C1eZkOYIZUqQx0go+lsHyiGhGnn7ZfX7DrHp1FSWLy/LoN5R7KB0Vc3VxJM3taBH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288998; c=relaxed/simple;
	bh=qafS7+sBdjv3I7dGrBgxG4xDdtda1/hablsJwC2R42Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=e6R6a33kaXpoZiaRfis7OR+jZ1R7ouDngpg7YySoNnMs5FCioMmmpYtpWASZdf/x9V+9TaQqJmQXV3t5TP7Qc5Mg1r/cOk57uDMP558tofPgiMRgbB6kzU4dY6Fna/UZLwlOubKYff90sA+MUL38aX5BskQxk9R8ayShpkzSbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxSurej8ZmFrYbAA--.59461S3;
	Thu, 22 Aug 2024 09:09:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMBxZODdj8ZmXEcdAA--.62921S3;
	Thu, 22 Aug 2024 09:09:49 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: Add ifdefs to fix LSX and LASX related
 issues
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
 <20240820123731.31568-3-yangtiezhu@loongson.cn>
 <1d23bbfe-dd36-b2ff-c4b3-cf69396ea53f@loongson.cn>
 <882d3aa3-24cf-9866-7e00-161e94893811@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <57818c31-c767-e8f4-2ea9-765e2dbbe1ba@loongson.cn>
Date: Thu, 22 Aug 2024 09:09:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <882d3aa3-24cf-9866-7e00-161e94893811@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxZODdj8ZmXEcdAA--.62921S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1UAFy7WryxXFW7ur18tFc_yoW8tFy3pr
	97AFWDJrWrCr1kAr1DJw1DWF90yr18J3WUXr1UJFyUJws8Jr4aqr4jgF1jgryUWr48J3WS
	yFW8Xw1avryUJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==



On 2024/8/21 下午6:07, Tiezhu Yang wrote:
> On 08/21/2024 09:12 AM, maobibo wrote:
>>
>>
>> On 2024/8/20 下午8:37, Tiezhu Yang wrote:
>>> There exist some issues when building kernel if CONFIG_CPU_HAS_LBT is 
>>> set
>>> but CONFIG_CPU_HAS_LSX and CONFIG_CPU_HAS_LASX are not set. In this 
>>> case,
>>> there are no definitions of _restore_lsx and _restore_lasx and there are
>>> also no definitions of kvm_restore_lsx and kvm_restore_lasx in fpu.S and
>>> switch.S respectively, just add some ifdefs to fix the issues.
> 
> ...
> 
>> It is hard to understand to put CONFIG_CPU_HAS_LASX inside
>> CONFIG_CPU_HAS_LBT, in general option CONFIG_CPU_HAS_LBT has nothing
>> with CONFIG_CPU_HAS_LASX.
>>
>> Would you like to add parameter func in macro fpu_restore_csr like this?
>>
>> --- a/arch/loongarch/include/asm/asmmacro.h
>> +++ b/arch/loongarch/include/asm/asmmacro.h
>> @@ -55,10 +55,11 @@
>>  #endif
>>         .endm
>>
>> -       .macro fpu_restore_csr thread tmp0 tmp1
>> +       .macro fpu_restore_csr thread tmp0 tmp1 func
>>         ldptr.w         \tmp0, \thread, THREAD_FCSR
>>         movgr2fcsr      fcsr0, \tmp0
>>  #ifdef CONFIG_CPU_HAS_LBT
>> +       STACK_FRAME_NON_STANDARD        \func
>>         /* TM bit is always 0 if LBT not supported */
>>         andi            \tmp0, \tmp0, FPU_CSR_TM
>>         beqz            \tmp0, 2f
>> @@ -282,10 +283,10 @@
>>         lsx_save_data           \thread, \tmp0
>>         .endm
> 
> For the record, I modified the related code as you suggested and tested 
> with various configs, it works well.
> 
> But as we discussed offline, these current changes are small relatively
> and the STACK_FRAME_NON_STANDARD related code may be removed if there
> is a proper possible way, so just leave it as is in my opinion.
Just be curious, what is the proper possible way to remove this, is it 
solved with new gcc/binutil version?  Do we plan to drop latest 
gcc/binutils support in near future only in order to remove these 
STACK_FRAME_NON_STANDARD code?

Regards
Bibo Mao
> 
> Thanks,
> Tiezhu
> 


