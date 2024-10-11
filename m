Return-Path: <linux-kernel+bounces-360600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBED999D12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FF41C22C92
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974F20899E;
	Fri, 11 Oct 2024 06:50:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0319923C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629440; cv=none; b=qV6oXaYHEXu1kuNA8iH7aBfH8CK3gWmn9z3RKVptUnAUukDFkfUPFMkwNXT17AdV6o7M5L0Rc0d/9PV7skBQPAHI+6TiDukaQaUmxB8mF4FzmlN/2k6egH/i6hGlGbVU1jK9V7RUd7mJdQYPz/yE7EIvRBAd9dpDQ44GQ9vWgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629440; c=relaxed/simple;
	bh=vlJ3qjbJ9KoHaAGlPBX6PfzhVWD4hl4afC7xYRnLNzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hz1S2imK6J0TXu3ZgOdUbkWvIL0+loIF6U1NjWzIKYJO7plRgGbQ1q0ztLleasolVUXrK3NduNrNWDDUOrD8tHUL8fwzihvLdHp/4btLKW9BGw38nZbcirPOeC7WjCjvc4fwv6F61wwe4GO6oC7rpXpNXMab/MdOIlnFNQ2t9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPy1M5xPgz4f3n6M
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:50:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E64F1A018D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:50:33 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMi4yghnb0AbDw--.13427S3;
	Fri, 11 Oct 2024 14:50:33 +0800 (CST)
Message-ID: <afae0e1f-7033-858c-ea5d-2b4a5383e9c6@huaweicloud.com>
Date: Fri, 11 Oct 2024 14:50:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/unwind/orc: Fix unwind for newly forked tasks
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, brgerst@gmail.com,
 samitolvanen@google.com, kees@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ye Weihua <yeweihua4@huawei.com>
References: <20240913024501.1337327-1-zhengyejian@huaweicloud.com>
 <20240913231108.a3ukhoyhp2xactdq@treble>
Content-Language: en-US
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240913231108.a3ukhoyhp2xactdq@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXTMi4yghnb0AbDw--.13427S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtF1kGF17uFW8uw48Xr4kXrb_yoW8Jry7pr
	WfA3W3trZ5try0vFn3tw4avr90yrs3tw1UKr43Gryfua43W3yIyrWruas0kFnIgFykGwnF
	krZI9345Kan8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/9/14 07:11, Josh Poimboeuf wrote:
> On Fri, Sep 13, 2024 at 10:45:01AM +0800, Zheng Yejian wrote:
>> When arch_stack_walk_reliable() is called to unwind for newly forked
>> tasks, the return value is negative which means the call stack is
>> unreliable. This obviously does not meet expectations.
>>
>> The root cause is that after commit 3aec4ecb3d1f ("x86: Rewrite
>>   ret_from_fork() in C"), the 'ret_addr' of newly forked task is changed
>> to 'ret_from_fork_asm' (see copy_thread()), then at the start of the
>> unwind, it is incorrectly interprets not as a "signal" one because
>> 'ret_from_fork' is still used to determine the initial "signal" (see
>> __unwind_start()). Then the address gets incorrectly decremented in the
>> call to orc_find() (see unwind_next_frame()) and resulting in the
>> incorrect ORC data.
>>
>> To fix it, check 'ret_from_fork_asm' rather than 'ret_from_fork' in
>> __unwind_start().
>>
>> Fixes: 3aec4ecb3d1f ("x86: Rewrite ret_from_fork() in C")
>> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> 
> Thanks!
> 
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 

Hi, Josh, thanks for your ack!
Will this patch go into mainline soon?

-- 
Thanks,
Zheng Yejian


