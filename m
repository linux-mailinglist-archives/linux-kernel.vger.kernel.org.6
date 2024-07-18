Return-Path: <linux-kernel+bounces-255865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BF9345CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390371C21C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CE1C36;
	Thu, 18 Jul 2024 01:30:21 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0510F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266220; cv=none; b=O6AHZRs6PMjCon+jvZLwivF3GDcufwSI4lMgzKdvJMcj3ERB/y1MwQgcbGw8Xqb5dYK5p8Qq6S0HzSRJBJo47af/NXzL5/rwG/v8YrLBABDFs1K04uF89PYdeR9iJ/aD1UlRT7V+PqNsWKeiztH7AFc5zXEeAQXmXwf9eVQc+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266220; c=relaxed/simple;
	bh=zZ6xsWC57pu2p/tQS0vBCKCKUdueopQ2D2kgD9n38X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZczC/6rzthVdcBqopS9I3R9YCfOY2EIN2pw7up+Hoyt5lK29279RXxldKwR51XQPActmLNZbnGx4dswtQfoHxId+ozrNX+/5q/mPm65jCMBAs6mcoxaj3vX4/0wgang+kkK4ISLX0DVEi9viNNwc0xDzTBoHUpP8uYg+VFdS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [198.18.0.1] (unknown [180.110.112.93])
	by APP-05 (Coremail) with SMTP id zQCowAAnUiIMcJhmy2fnAw--.10199S2;
	Thu, 18 Jul 2024 09:29:50 +0800 (CST)
Message-ID: <ae740896-ca8c-482f-8b80-acc3fa60d0c3@iscas.ac.cn>
Date: Thu, 18 Jul 2024 09:29:48 +0800
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
X-CM-TRANSID:zQCowAAnUiIMcJhmy2fnAw--.10199S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWkAF47Zw13XF48JrW3GFg_yoWkCrb_AF
	1Iyryxu3W7Xr47Kr45Kw1Y9r9rJrW2gw1fJ3WkZr9rCFZxJr9xWrs5Kwn3A3WxWwsrGFn3
	uF9Fqw1Iyrya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: x2kxxvpqje0q5lvft2wodfhubq/1tbiBgoCDGaYTG1jIwAAsd


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

“epc” stands for Exception Program Counter, which keeps track of where the CPU is within the code. It is the same as the Instruction Pointer in x86.

For example, here is the encapsulation of accessing the instruction pointer in risc-v:

    /* Helpers for working with the instruction pointer */
    static inline unsigned long instruction_pointer(struct pt_regs *regs)
    {
        return regs->epc;
    }




