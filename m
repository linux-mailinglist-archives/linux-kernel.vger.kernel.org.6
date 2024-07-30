Return-Path: <linux-kernel+bounces-267193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A99C1940E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5080A1F238AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B1196D9A;
	Tue, 30 Jul 2024 09:49:19 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6A196C7B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332959; cv=none; b=byephQR0JhwreasRAtSX/h4/V/xeKBxEBzr02jFMn4CEQGI4ChZKOfpQnrpamG6eb5sG2za3HEVIq6ueNpxm91/sMbfxth30WcMxUnTlHsAwkM6SnXyOHl64TqW75QETX/YijVlTStcKM80Jh0Zm1u/AeKumGyytG0+kDoPpbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332959; c=relaxed/simple;
	bh=IhpWm4gfNHBkjcBIwsHm1lQ2cCRzEXfGacHjhRjPNFg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=a1UaUnU9Tns/E04j4BnW7P/GVXU+dRA/hA9l3I/WLtPGynm/pxGlS4q2RHdPagD0pwH5g4E1YGrBnObJJCN0BAUnmIaPSFrETdGLp42Sf3zmFvOKuJ34+fDOWK99daFX2ABnf9bZmIjpzN5Cqk0m66OABZpMdGLu7NBU/3hdEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxrusbt6hm1GMEAA--.15289S3;
	Tue, 30 Jul 2024 17:49:15 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxf8cat6hmnV0GAA--.31800S3;
	Tue, 30 Jul 2024 17:49:15 +0800 (CST)
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation
 instruction
To: Jinyang He <hejinyang@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
 <20240730061901.21485-2-yangtiezhu@loongson.cn>
 <4ac60afc-de6b-acf6-c9e6-1f45c0680dbe@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6ee45e77-eb22-c4ac-ee47-6a329236eeb7@loongson.cn>
Date: Tue, 30 Jul 2024 17:49:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4ac60afc-de6b-acf6-c9e6-1f45c0680dbe@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxf8cat6hmnV0GAA--.31800S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr48uFy5GryrAF1xKw13WrX_yoWfCrcEvF
	Wjyry8Cw1IyF97Zwn0yFyrAr92ga17Xrn8XasFkr9rXa43tFWrWF1SkF1xArZ5JFWvqFnr
	WFW3Xa4UZw1FkosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8vApUUUUUU==

On 07/30/2024 05:28 PM, Jinyang He wrote:
> On 2024-07-30 14:19, Tiezhu Yang wrote:
>
>> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
>> support"), the code flow of do_syscall() was changed when compiled
>> with GCC due to the secondary stack of add_random_kstack_offset(),
>> something like this:
>>
>>    addi.d          $sp, $sp, -32
>>    st.d            $fp, $sp, 16
>>    st.d            $ra, $sp, 24
>>    addi.d          $fp, $sp, 32
>>    ...
>>    sub.d           $sp, $sp, $t1
> Have you checked the ORC info whether is right or tried backtrace which
> passed do_syscall? The "sub.d $sp, $sp, $t1" has modified the $sp so the
> $sp cannot express CFA here. This patch just clear the warning but ignore
> the validity of ORC info. The wrong ORC info may cause illegally access
> memory when backtrace.

I did testing many times before submitting, the call trace is
expected when testing "echo l > /proc/sysrq-trigger".

Thanks,
Tiezhu


