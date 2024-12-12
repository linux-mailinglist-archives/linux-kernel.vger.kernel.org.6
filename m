Return-Path: <linux-kernel+bounces-442462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C379EDD21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8204283434
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672A61FD7;
	Thu, 12 Dec 2024 01:35:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683012CD88
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967304; cv=none; b=Ll9Wk/s2WSML38zngC1Y6sRvO8p47yhju1aC359fESw6gcagqoLqQRslC/eG3x9AlIFFyAJO61VNeiQcPqRoHW6JIqNbXIrbC3dqzHrcBxoJP2lN45F6JhsJXJ9cud/C+twMpt7tB25XzjYXeJkGcYxupuTXWDifsCmES0+KvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967304; c=relaxed/simple;
	bh=Dxz/vEydMyAurUmt046xw8DfWq8+XQ39ARsEvBNBuqo=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FSewykWO6nH2vfSBeNopAXMLVEr/CvAu45tzeJQWoQCEBSCwd6LJdOH7v79DPjhC1p4+VI7EyGNee5M17Gorn+O0Et+LfUri6yl9rUMA+QtXnxnF2pDRHqNNCWVbpK8Isz+jZ/+ZWnhX2qpYk7wurt4RyRerSx7p0YGIpw3QZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxUa_EPVpnz+hVAA--.36549S3;
	Thu, 12 Dec 2024 09:35:00 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxXUfCPVpn_x2AAA--.8630S3;
	Thu, 12 Dec 2024 09:34:58 +0800 (CST)
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
 <20241209203544.axetpzva7vg3hsc5@jpoimboe>
 <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>
 <20241212003526.2kutif7m2svtbp6l@jpoimboe>
 <20241212003917.vqnqmkrjgfl2cqd6@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <85da9f4a-206b-d458-4b79-943a72a78209@loongson.cn>
Date: Thu, 12 Dec 2024 09:34:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212003917.vqnqmkrjgfl2cqd6@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMBxXUfCPVpn_x2AAA--.8630S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZry5Gr18AF18XF1xtr45XFc_yoW8Jr43pF
	Wj9a9rtFs5ta97JwsIgw4vqFyF93ykXas8Wr90kr10kwnxZw1Fgay8K3yY9FyDJr10yry2
	va1I93WDXa18G3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5xhLUUUUU=

On 12/12/2024 08:39 AM, Josh Poimboeuf wrote:
> On Wed, Dec 11, 2024 at 04:35:27PM -0800, Josh Poimboeuf wrote:
>> On Wed, Dec 11, 2024 at 11:16:33AM +0800, Tiezhu Yang wrote:
>>> When compiling on LoongArch, there are some PC relative relocation types
>>> for rodata, it needs to calculate the symbol offset with "S + A - PC" in
>>> this case according to the spec of "ELF for the LoongArch Architecture",
>>> the "PC" is the index of each jump table which is equal with the value
>>> of reloc_offset(reloc) - reloc_offset(table).
>>>
>>> I will add the above description to the commit message to make it clear.
>>
>> I understand how PC-relative addressing works.
>>
>> The oddity here is that "PC" is the jump table's base address rather
>> than the entry address.  That has nothing to do with the ELF spec or
>> even how R_LARCH_32_PCREL is implemented.  Rather it seems to be a quirk
>> related to how loongarch jump table code expects the entries to be.
>>
>> So the arch_adjust_offset() name seems wrong, as this is specific to
>> the jump table implementation, rather than relocs in general.
>>
>> Instead call it arch_jump_table_sym_offset()?
>
> BTW, do both GCC and Clang have this same behavior for loongarch?

Yes.


