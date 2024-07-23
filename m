Return-Path: <linux-kernel+bounces-259522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E39397CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCCAB21D18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33E1339A4;
	Tue, 23 Jul 2024 01:14:03 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BEFBE6C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697243; cv=none; b=bGij4kBNCRMpjbepweEiJLOxZluWdNuHlHhBoFXmCgjVkEKkrJZOUqhSpHx2espbeiH5JT9VT2Z6SiPSvx97HGCgyFpLG+q1YyaIMw0X1PKDLeW4CfWbCix8LV683Plz5KOpSO3GMBlZjg/kRUZkUTDktEvnhdZddagq/EakBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697243; c=relaxed/simple;
	bh=oSvBJoEAtJpEpK2Z/fZV70eEhXrrHaKG3f2zZcoWcVk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=miXN4CDB/Y6qarvZh19PPECelof/XrB58BwkBhtv7irF9UOyvJsnPuBuHTloFuClaeSfbX8EjORVhzWx+72CgumTQM8wfaj7SrPzKi2Rfx9yfkUnGKzSdWoBZTrQ6t9KNwkb1lx6Aio+pd9B9Me2LyFBWOzxkmjUG8ZR/6V+0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMfOA59m6AZVAA--.58919S3;
	Tue, 23 Jul 2024 09:13:52 +0800 (CST)
Subject: Re: [PATCH] locking/pvqspinlock: Correct the type of "old" variable
 in pv_kick_node()
To: Waiman Long <longman@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240721164552.50175-1-ubizjak@gmail.com>
 <62c029b7-13dc-f4fc-d67a-7bd86f973e2f@loongson.cn>
 <64b0aba3-6eab-4418-9019-a7e1123fba96@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <d1055946-4d42-a247-1ca6-5e6c65179f9e@loongson.cn>
Date: Tue, 23 Jul 2024 09:13:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64b0aba3-6eab-4418-9019-a7e1123fba96@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMfOA59m6AZVAA--.58919S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWftFWfGF18GrWxAF1fJFb_yoW5ArWUpa
	yvkF92ka9xJr40vw10ga4jka4Utws7Gw1fGrnxWry5trZFqr1agrnrZFy5uF10vFZ7KFs0
	yr1jyF1kZayUXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
	r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xU2xR6UUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/



On 2024/7/22 下午11:13, Waiman Long wrote:
> 
> On 7/22/24 02:54, maobibo wrote:
>> Uros,
>>
>> Sorry for late reply because of weekend time. This modification works 
>> well for me.
>>
>> In later I want to define pv_node::state as int type on LoongArch 
>> because there is only int32/int64 cmpxchg is better supported on the 
>> system, however that is another issue.
> 
> I thought about changing pv_node::state to int, but that requires 
> changing the pv_wait() call to use int too. That doesn't work because 
> pv_wait() is also used to monitor the state of the lock byte of the 
> qspinlock. In essence, we can't use pvqspinlock if 8-bit cmpxchg isn't 
> supported.
Hi Longman,

yes, your are right. pv_wait also monitors the state of the qspinlock 
lock byte, so the parameter type about pv_wait must be u8.

LoongArch supports byte cmpxchg, only that word cmpxchg has higher 
efficiency. By the draft kernel compiling test, pvqspinlock can improve 
performance greatly when pCPU is shared by multiple vCPUs.

And thanks for your remaindering.

Regards
Bibo Mao
> 
> Cheers,
> Longman
> 
>>
>> Tested-by:Bibo Mao <maobibo@loongson.cn>
>>
>> On 2024/7/22 上午12:45, Uros Bizjak wrote:
>>> "enum vcpu_state" is not compatible with "u8" type for all targets,
>>> resulting in:
>>>
>>> error: initialization of 'u8 *' {aka 'unsigned char *'} from 
>>> incompatible pointer type 'enum vcpu_state *'
>>>
>>> for LoongArch. Correct the type of "old" variable to "u8".
>>>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in 
>>> qspinlock_paravirt.h")
>>> Reported-by: Bibo Mao <maobibo@loongson.cn>
>>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>>> Closes: 
>>> https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/ 
>>>
>>> ---
>>>   kernel/locking/qspinlock_paravirt.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/locking/qspinlock_paravirt.h 
>>> b/kernel/locking/qspinlock_paravirt.h
>>> index f5a36e67b593..ac2e22502741 100644
>>> --- a/kernel/locking/qspinlock_paravirt.h
>>> +++ b/kernel/locking/qspinlock_paravirt.h
>>> @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock 
>>> *node, struct mcs_spinlock *prev)
>>>   static void pv_kick_node(struct qspinlock *lock, struct 
>>> mcs_spinlock *node)
>>>   {
>>>       struct pv_node *pn = (struct pv_node *)node;
>>> -    enum vcpu_state old = vcpu_halted;
>>> +    u8 old = vcpu_halted;
>>>       /*
>>>        * If the vCPU is indeed halted, advance its state to match 
>>> that of
>>>        * pv_wait_node(). If OTOH this fails, the vCPU was running and 
>>> will
>>>
>>
> 


