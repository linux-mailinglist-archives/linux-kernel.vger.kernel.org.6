Return-Path: <linux-kernel+bounces-258720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE56938C20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EF51C212E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5916C445;
	Mon, 22 Jul 2024 09:33:48 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9A2168497
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640828; cv=none; b=LwgTOB7Qgq7+LglIGrII3EescSHH/oUQCROoGPxjUk3N+4zVGya7fsSpP670l5xXGdJbKAD7jwThkUYjWztjDstAl9FrUHd8ha55MofD7psZwb1Fxz2Ee9EoR0SG2+5LZgJLbwSwnEQnvbNRt2mxLCj8HUwzlARbXwgXsa93Ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640828; c=relaxed/simple;
	bh=oXNhXWirLughLvnpUpxnzDcj0TihYm2jssStkD8xCP0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fm153+dj/0n68qr4xy0qkS02/rxEjFWC5eLfWQqYCt2aoqc+oU60iX6P37WLN7LUrRVYZxxPjv3VRLI7kDsXRoAe5XvRoG7YkbWuTvJCE7VkSkdr6g/0thD4elhNlgo/mbpwsbB2rKctKuTLR5EM2V+TJd6jyt96ftA5Ye2soQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx28YxAp5mJclTAA--.55001S3;
	Mon, 22 Jul 2024 14:54:43 +0800 (CST)
Subject: Re: [PATCH] locking/pvqspinlock: Correct the type of "old" variable
 in pv_kick_node()
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
References: <20240721164552.50175-1-ubizjak@gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <62c029b7-13dc-f4fc-d67a-7bd86f973e2f@loongson.cn>
Date: Mon, 22 Jul 2024 14:54:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240721164552.50175-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx28YxAp5mJclTAA--.55001S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar48tr1xur4kCF4kuryUKFg_yoW8Cw1xpa
	y3CFsagasrtF409w1vg34j9ayFqws7Gr1fGFn2gr15tr9Iqr15GF1DAa13ZF10vFWxKFsx
	tF1jvF1vyayxZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
	c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
	489tUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/

Uros,

Sorry for late reply because of weekend time. This modification works 
well for me.

In later I want to define pv_node::state as int type on LoongArch 
because there is only int32/int64 cmpxchg is better supported on the 
system, however that is another issue.

Tested-by:Bibo Mao <maobibo@loongson.cn>

On 2024/7/22 上午12:45, Uros Bizjak wrote:
> "enum vcpu_state" is not compatible with "u8" type for all targets,
> resulting in:
> 
> error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *'
> 
> for LoongArch. Correct the type of "old" variable to "u8".
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Fixes: fea0e1820b51 ("locking/pvqspinlock: Use try_cmpxchg() in qspinlock_paravirt.h")
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Closes: https://lore.kernel.org/lkml/20240719024010.3296488-1-maobibo@loongson.cn/
> ---
>   kernel/locking/qspinlock_paravirt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index f5a36e67b593..ac2e22502741 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>   static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>   {
>   	struct pv_node *pn = (struct pv_node *)node;
> -	enum vcpu_state old = vcpu_halted;
> +	u8 old = vcpu_halted;
>   	/*
>   	 * If the vCPU is indeed halted, advance its state to match that of
>   	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
> 


