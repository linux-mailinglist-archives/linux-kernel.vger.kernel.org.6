Return-Path: <linux-kernel+bounces-423073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F59DA268
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3950E28591E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547F4146019;
	Wed, 27 Nov 2024 06:39:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F36F9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689561; cv=none; b=GLU0NfnHxkOk5T/M+FqSak7WA5FoVE1wK0bggQ5p9xHttmjJ2iJPfawzqh57E7p4M/K3XzHqhNZ6Nhpcl1RHACz1kLr2KChl+UDjlFZE4TiZWOvQDgC1ldScJALwyHah3k8f95iQVVskc7Mx+F+6mSvhkMSAXQbo8hCJlpFx3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689561; c=relaxed/simple;
	bh=QzXjNuaetxZpAnx67AbI2GUQH5dA91HczpHtXRg7S9A=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GmlUpZ8E/rOpc0iU6gJa8XuTPceZZ1DvGbPvr9xcziqfCJEiAq427zMq4gxzHc/yXrFT7GDfAX2lACyb0gcmRx857B+FzN6/jNj1DnLUvP21LIZSHzAMBXSk8MV7E1kB6KAGcVnvcNxbgc01DmCDXBfW8MsnsddohGr3rg3lM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxC+KTvkZnZKRJAA--.12458S3;
	Wed, 27 Nov 2024 14:39:15 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBx_uCRvkZnNotpAA--.21910S3;
	Wed, 27 Nov 2024 14:39:15 +0800 (CST)
Subject: Re: [PATCH v4 01/10] objtool: Handle various symbol types of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-2-yangtiezhu@loongson.cn>
 <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
 <75f6e90b-4d04-5627-395e-58982a84d7c1@loongson.cn>
 <20241127005208.luhtjy2qhk3bza7a@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f1bcff28-dc9c-2878-10c7-6e653516e66d@loongson.cn>
Date: Wed, 27 Nov 2024 14:39:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241127005208.luhtjy2qhk3bza7a@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMBx_uCRvkZnNotpAA--.21910S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWxAw4ftFW3uw45uFy8WFX_yoW8Gr4UpF
	ZxAa15Jrnayr17Wanavan7u3Z3J3s7GFn8Gr4kKryrJry2gw15ta95GF45Ca4kGr1SvF47
	Zr4Fqw1fZw4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 11/27/2024 08:52 AM, Josh Poimboeuf wrote:
> On Tue, Nov 26, 2024 at 06:41:29PM +0800, Tiezhu Yang wrote:
>> On 11/26/2024 02:44 PM, Josh Poimboeuf wrote:
>>> On Fri, Nov 22, 2024 at 12:49:56PM +0800, Tiezhu Yang wrote:
>>>> @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>>
>>> 'prev_offset' needs to be updated as well.
>>
>> I am not sure I understand your comment correctly, I can not see
>> what should to do about 'prev_offset'.
>
> Further down the function there is
>
>   prev_offset = reloc_offset(reloc);
>
> which needs to be changed to
>
>   prev_offset = offset;
>
> as part of the patch.

If I understand correctly, reloc_offset(reloc) is different with
reloc->sym->offset + reloc_addend(reloc), tested on x86 and readelf
shows that their values are different, reloc_offset(reloc) is the
first column of .rela.rodata, reloc->sym->offset is the second to
last column of .rela.rodata, reloc_addend(reloc) is the last column
of .rela.rodata.

If do the above change as you suggested, there will be some objtool
warnings on x86. I think it should be:

   prev_offset = reloc_offset(reloc);

rather than:

   prev_offset = offset;

That is to say, no need to change "prev_offset".
Could you please check it again, please let me know if I am wrong.

Thanks,
Tiezhu


