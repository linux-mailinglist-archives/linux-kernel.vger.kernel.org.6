Return-Path: <linux-kernel+bounces-424191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E24729DB177
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C14B20F34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50428481B1;
	Thu, 28 Nov 2024 02:28:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BBC13C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760888; cv=none; b=rYKiOi3HcTQFRm8CB/zE44CAQwdlzb4ZKHYMoruJqHPirzYB2fxg4g2YhsUvP7w5kRN/Ijrhc9xashP97M+CkKiIqTmKGrAoExBs9mR2krC2Pd4jbO0xxF5YpBt2FlO77NkZyOAm7+oznLfeKw+MO55d7LUxjdQSBURhzBeXomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760888; c=relaxed/simple;
	bh=XUvF8BOx52ZbomoxewOyXdDZ9MMTtE5Of6ogPgU08gk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZzlcVHUOzDwT+t9fvRoO4zbCUT/QwAwWCzpyXGKyVcMgUg47TZ/RRCoilbRumDWZqTbB+si+1ohgpzOZiQM1EkF0hAn7jRCZFo/HGVydkClXYEC+6CI8lcL5V8EAcOcfx+TVxYsv12RaCMIyFc5sJKKFbk6lB/kJCn7Mhu6YG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx2uE01UdnClZKAA--.16422S3;
	Thu, 28 Nov 2024 10:28:04 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCx60Yx1Udn8tZqAA--.47370S3;
	Thu, 28 Nov 2024 10:28:02 +0800 (CST)
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
 <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
 <20241128001011.sjedpn2zhrhy6y6i@jpoimboe>
 <20241128001627.5czdlst5rd76qwsd@jpoimboe>
 <20241128010034.u3b7gkh4wqgb7d2s@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <19af5a40-9bf7-bab6-2a69-02fba652a7df@loongson.cn>
Date: Thu, 28 Nov 2024 10:28:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241128010034.u3b7gkh4wqgb7d2s@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCx60Yx1Udn8tZqAA--.47370S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1DtF4xuw1rKry8XryfXwc_yoW8uF15pF
	W5AFW8trs8tr1UtFnrtw1vkF13tw1UJF98X34DJr18t3sFvryfKFW8CrW5uF98Xrn8Kr4a
	qr47tr93ArW8X3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==

On 11/28/2024 09:00 AM, Josh Poimboeuf wrote:
> On Wed, Nov 27, 2024 at 04:16:29PM -0800, Josh Poimboeuf wrote:
>> On Wed, Nov 27, 2024 at 04:10:18PM -0800, Josh Poimboeuf wrote:
>>> On Wed, Nov 27, 2024 at 03:01:33PM +0800, Tiezhu Yang wrote:
>>>>
>>>>
>>>> On 11/27/2024 09:20 AM, Josh Poimboeuf wrote:
>>>>> On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:
>>>>>>> +		/* Handle the special cases compiled with Clang on LoongArch */
>>>>>>> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
>>>>>>> +		    reloc->sym->type == STT_SECTION && reloc != table &&
>>>>>>> +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
>>>>>>> +			break;
>>>>>>
>>>>>> I think it can be generic, like this:
>>>>>>
>>>>>>                 /* Check for the end of the table: */
>>>>>>                 if (reloc != table && reloc == next_table)
>>>>>>                         break;
>>>>>>
>>>>>>                 if (reloc != table &&
>>>>>>                     reloc_offset(reloc) == reloc_offset(table) +
>>>>>> rodata_table_size)
>>>>>>                         break;
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> I'm not sure, this patch is hard to review because it uses
>>>>> insn->table_size which doesn't get set until the next patch.
>>>>>
>>>>> Maybe this patch should come after patches 7 & 8, or maybe they should
>>>>> be squashed?
>>>>
>>>> OK, I will squash the changes into patch #7.
>>>
>>> I remembered Ard already solved a similar problem when he prototyped x86
>>> jump table annotation.  Can you pull this patch into your series:
>>>
>>> https://lore.kernel.org/20241011170847.334429-12-ardb+git@google.com
>>
>> Actually, I think I'm going to merge patches 2-5 from Ard's series as
>> they're a nice cleanup.  Let me do that and then you can base your next
>> version off tip/objtool/core once it gets updated with Ard's and Peter's
>> patches.
>
> Still talking to myself here, I think we'll only merge the above patch,
> since we don't know what the generic annotations are going to look like
> yet.

OK, my next version will be based on tip/objtool/core after
the merge window, by that time, hope the tree include Ard's
and Peter's patches to avoid conflicts.

Thanks,
Tiezhu


