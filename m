Return-Path: <linux-kernel+bounces-362150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1613499B197
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D5F1F22CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B612139CE9;
	Sat, 12 Oct 2024 07:35:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B1D528
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718500; cv=none; b=igDqNCKV12XAvCRS4JIYyq0JJuNG2yfCX7IYHROMC1tfJUpFZ8WsVvGwG+mX/zB20bhWcK12X0ptNFIj90UGeONZh4VouiOczZGA0clf7heU1kD8/Pcs2D3fTs5zYM4lMfD98NqTGJ5UaNva3sjalnZgkF+4s1v8kQu+IzE69pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718500; c=relaxed/simple;
	bh=0Veh/TXk1UubfNtn8vfiHeiI+xk32OOk8L4IpIfTAbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/RJ0b1e5zOKrUoVWmeOBFqUE1lNOfZYepUPTsCBGR2YfLuTdzt47OUlgjh1yXSfN+ABM2OEo3eyOO06xLGPqyo8U8FPsgdtYxnCiIpQmB0KOQQLHzGIsnAEV9mDXR8ehqB5ext9qeyb6hZ9o8RwOjfaQgjtPC8kB0+92eTWlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQZy46qMjz4f3lDK
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:34:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AB8B21A0A22
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:34:54 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMidJgpnw0B7Dw--.47329S3;
	Sat, 12 Oct 2024 15:34:54 +0800 (CST)
Message-ID: <3754e1b2-598e-b3dc-7aa5-942e1c0feb94@huaweicloud.com>
Date: Sat, 12 Oct 2024 15:34:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/unwind/orc: Fix unwind for newly forked tasks
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
 samitolvanen@google.com, kees@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ye Weihua <yeweihua4@huawei.com>
References: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>
 <20240913231108.a3ukhoyhp2xactdq@treble>
 <afae0e1f-7033-858c-ea5d-2b4a5383e9c6@huaweicloud.com>
 <20241011153938.knk2yp46ajjo27gj@treble>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20241011153938.knk2yp46ajjo27gj@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXTMidJgpnw0B7Dw--.47329S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUGrWUWFy5JrykWw48WFg_yoW8Xr48pr
	WfAFnxtFZ5try0yFn3tw1aqrn8tr4xJr1jgr13try3uasIg3yxtrWrua1UuFnIgFykGwnr
	CrWag343W3Z0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/10/11 23:39, Josh Poimboeuf wrote:
> On Fri, Oct 11, 2024 at 02:50:32PM +0800, Zheng Yejian wrote:
>> On 2024/9/14 07:11, Josh Poimboeuf wrote:
>>> On Fri, Sep 13, 2024 at 10:45:01AM +0800, Zheng Yejian wrote:
>>>> When arch_stack_walk_reliable() is called to unwind for newly forked
>>>> tasks, the return value is negative which means the call stack is
>>>> unreliable. This obviously does not meet expectations.
>>>>
>>>> The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
>>>>    ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
>>>> to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
>>>> unwind, it is incorrectly interprets not as a "signal" one because
>>>> 'ret_from_fork' is still used to determine the initial "signal" (see
>>>> __unwind_start()). Then the address gets incorrectly decremented in the
>>>> call to orc_find() (see unwind_next_frame()) and resulting in the
>>>> incorrect ORC data.
>>>>
>>>> To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
>>>> __unwind_start().
>>>>
>>>> Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
>>>> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
>>>
>>> Thanks!
>>>
>>> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
>>>
>>
>> Hi, Josh, thanks for your ack!
>> Will this patch go into mainline soon?
> 
> Sorry about that, I'll go ahead and queue this up.
> 

Thanks!

Zheng Yejian


