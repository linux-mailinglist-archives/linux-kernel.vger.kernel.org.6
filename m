Return-Path: <linux-kernel+bounces-423085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E6C9DA299
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5462841AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CF1474B2;
	Wed, 27 Nov 2024 07:01:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9013C816
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690900; cv=none; b=LlGRyPOxReIXLrnCFfBBpEIDlcckfFT9dH5hZxSxdTlho+fQb0FVp/eNSihooGYAag/Kxt7Ui8PyWAqKL+lPCh2d5a+28iVRYMe3k2HjujTnyap5/xw7qNVJY0Yno4V2YNETdvyv++pA6W3ryf7dteOLvbYzTU/WPCz3zUFNgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690900; c=relaxed/simple;
	bh=gWyFNicxctPBg9J4e26jnWJduJq5hCPP0tXpiqu81B8=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W5DW8oZ29pxsGserYzq8L4/pBcCNkpgQ+xGWPeGPDzoyPNsCNtRlGqEUA1wcPHksMQDUddiqaeseQA2lXuol6hir/5DPQvGG0NEXP80oAEIpHA6U1goz5uSoxw3RdAueUy5aijLyAFKyO5NAuhEo+3a4wLGUjCnhgEQbsDiwAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxyuDPw0ZnyqdJAA--.11929S3;
	Wed, 27 Nov 2024 15:01:35 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxVcDNw0ZnkJBpAA--.44731S3;
	Wed, 27 Nov 2024 15:01:34 +0800 (CST)
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
 <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
 <20241127012042.by4g34m4twlfmove@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <53677c5f-2ea5-a227-66f7-b27c27665f6b@loongson.cn>
Date: Wed, 27 Nov 2024 15:01:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241127012042.by4g34m4twlfmove@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxVcDNw0ZnkJBpAA--.44731S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtrW5Ww15Wr1ktry8Jw4xAFc_yoWfCwb_ur
	1I9F4DWayDJF1kG3Wqyws7JF4jgw1UXa1jqr4Iyr4qvwnxZrWv9w4xuFyS9345J3ZFgr90
	g3WqqFWxuw4jgosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFE__UUUUU=



On 11/27/2024 09:20 AM, Josh Poimboeuf wrote:
> On Tue, Nov 26, 2024 at 09:28:19PM +0800, Tiezhu Yang wrote:
>>> +		/* Handle the special cases compiled with Clang on LoongArch */
>>> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
>>> +		    reloc->sym->type == STT_SECTION && reloc != table &&
>>> +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
>>> +			break;
>>
>> I think it can be generic, like this:
>>
>>                 /* Check for the end of the table: */
>>                 if (reloc != table && reloc == next_table)
>>                         break;
>>
>>                 if (reloc != table &&
>>                     reloc_offset(reloc) == reloc_offset(table) +
>> rodata_table_size)
>>                         break;
>>
>> What do you think?
>
> I'm not sure, this patch is hard to review because it uses
> insn->table_size which doesn't get set until the next patch.
>
> Maybe this patch should come after patches 7 & 8, or maybe they should
> be squashed?

OK, I will squash the changes into patch #7.


