Return-Path: <linux-kernel+bounces-255871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337079345D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05201F23788
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A41878;
	Thu, 18 Jul 2024 01:34:38 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43C10F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266478; cv=none; b=gD5VMIuMJEgEhWub0IImqqsvTRxZVAjBU6j1Fc+494boP2x7GU7xZ2bT9cVWhlDbYqttpRxNhEQDRPDPqvcz/waOeC1VUIlu8/mFsTaoe935HZsgCpXAhvZoEn8yx7IElqsD0LV4TDfTolK0woKGoIKL3hRNQZ4puET+WsU/e0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266478; c=relaxed/simple;
	bh=9kGZsHE+kaX0bg2zb3HpHgSyUQXm6r3Zx68HxAdvhRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf1Xc3nAqlw9wnOZvX5s9iTTbFSO2Oc8AuS0X5IllACp11pjlSeMQcYfETZULuURSyacoCD4UbYS+YiDLT4E4Eg/LE2wpVO3dRDCZen46SnameJtEu8vayveKXkxqLNeMLIkNPyJe2X5mNglFsJE+JoQzb33dT25O1sFNTp07oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [198.18.0.1] (unknown [180.110.112.93])
	by APP-05 (Coremail) with SMTP id zQCowACHj+cfcZhm7IrnAw--.9704S2;
	Thu, 18 Jul 2024 09:34:24 +0800 (CST)
Message-ID: <70bd489b-2a9f-4be3-86db-0a131abee8ab@iscas.ac.cn>
Date: Thu, 18 Jul 2024 09:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: add tracepoints for page fault
To: Matthew Wilcox <willy@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
 <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>
 <ZpfbVzwT5flLqatZ@casper.infradead.org>
From: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
In-Reply-To: <ZpfbVzwT5flLqatZ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHj+cfcZhm7IrnAw--.9704S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWkAF47Zw13XF48JrW3GFg_yoW3KFg_A3
	WxK348C3Wjqw4jgr45tws8Kr9xZ3yav3s5X3Z3Xr9rCFZ3XryxGFn7KwsrJa47XwsrGF97
	u3ZFg340yFWa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbrc-UUUUU=
X-CM-SenderInfo: x2kxxvpqje0q5lvft2wodfhubq/1tbiCRACDGaYT59iaQABsz


On 2024/7/17 22:55, Matthew Wilcox wrote:
> On Wed, Jul 17, 2024 at 08:27:19AM +0000, Zhu Hengbo wrote:
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, address)
>> +		__field(unsigned long, epc)
>> +		__field(unsigned long, cause)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->address	= regs->badaddr;
>> +		__entry->epc		= regs->epc;
>> +		__entry->cause		= regs->cause;
>> +	),
>> +
>> +	TP_printk("user page fault, address=%ps epc=%ps cause=0x%lx",
>> +			(void *)__entry->address, (void *)__entry->epc,
>> +			__entry->cause)
> What is "epc"?  You've made this gratuitously different from x86.
> Never do that.  Always copy what somebody else has done unless you have
> a good reason to be different.
Yes, I have referred to the implementation in x86, but the fields in “struct pt_regs” are quite different between RISC-V and x86


