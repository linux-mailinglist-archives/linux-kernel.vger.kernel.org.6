Return-Path: <linux-kernel+bounces-561267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892ADA60F76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397661B63446
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE21FCFE3;
	Fri, 14 Mar 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuzodXDN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4B1FCFD3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949848; cv=none; b=fJlYu2IkUFJL8KSvByWQBMTPZp/mQjpAFc2AOQghDF0IE12m7zh5dTFd1U7KzkF4q6H9EDIKlMliD3dvUS9Vq7hDj/D4z/+KXM953+6rFQAflMbwIMJw8uAMYZNb884ddlq3zeaz44OVz2csvLM6yO7jEuyr4BF7DObtdjDakpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949848; c=relaxed/simple;
	bh=VDMVz0ygP2KxN7rJB74IuIxcRwkE7FZ1RL/MHtWeBcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/TX2g1Jmh6ckZhggQh4xP6ui6YGCZ2XxWMz6HAtesnkXq/9WRp45oovyyYuk9Ah4zAjTaJIePJEdPB/rOTcwkMhViISbUA8Z06iDCVTW1eDrEFaP05WxABlsR2QIu0845fDvFGAiSZrOrudFFFFDf5tkYtEw+J7FBrdDQ5aSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuzodXDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2D0C4CEE3;
	Fri, 14 Mar 2025 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949847;
	bh=VDMVz0ygP2KxN7rJB74IuIxcRwkE7FZ1RL/MHtWeBcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KuzodXDNGxII0Gh6/oiQ9CtoH/OllxVlWSbX8dueZKKQTiTcVqrwIZMFYiIUkftb1
	 HGdB8wMyr2n/P7L/dh9zg5DEnV3VTEe+YOGQw8fAjthXcGd1vK/uCO7fUu/6q+VgrI
	 CKhh5f/TRzXf06e2VnaMFkasXy5OH/F9BpNx7ihJgD73sEQrq4m0GhuoUsBVK/KUZg
	 4S+gRF9W/Rqo1Y9cZn1u1lc+TG2NkhvNFxiTGxnTvZeane2KFnHg8VF1RcWf5yuDpG
	 D12p26i3l3XGoag0TWJ58uI1VNAtvlHtoU5LX+CSnOf99aAPhJuQ9fTwUsCqBAmAIV
	 Y0WdNy6XFm26A==
Message-ID: <1e1ffb3a-3354-4c35-b73f-787da014f758@kernel.org>
Date: Fri, 14 Mar 2025 11:57:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/46] genirq/irqdesc: Switch to lock guards
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
References: <20250313154615.860723120@linutronix.de>
 <20250313155914.010145118@linutronix.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250313155914.010145118@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13. 03. 25, 16:59, Thomas Gleixner wrote:
> Replace all lock/unlock pairs with lock guards and simplify the code flow.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/irq/irqdesc.c |  136 +++++++++++++++------------------------------------
>   1 file changed, 42 insertions(+), 94 deletions(-)
> 
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -266,104 +266,68 @@ static ssize_t per_cpu_count_show(struct
>   }
>   IRQ_ATTR_RO(per_cpu_count);
>   
> -static ssize_t chip_name_show(struct kobject *kobj,
> -			      struct kobj_attribute *attr, char *buf)
> +static ssize_t chip_name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> -	ssize_t ret = 0;
> -
> -	raw_spin_lock_irq(&desc->lock);
> -	if (desc->irq_data.chip && desc->irq_data.chip->name) {
> -		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
> -				desc->irq_data.chip->name);
> -	}
> -	raw_spin_unlock_irq(&desc->lock);
>   
> -	return ret;
> +	guard(raw_spinlock_irq)(&desc->lock);
> +	if (desc->irq_data.chip && desc->irq_data.chip->name)
> +		return scnprintf(buf, PAGE_SIZE, "%s\n", desc->irq_data.chip->name);
> +	return 0;

FWIW I consider this ^^^ ...

>   }
>   IRQ_ATTR_RO(chip_name);
>   
> -static ssize_t hwirq_show(struct kobject *kobj,
> -			  struct kobj_attribute *attr, char *buf)
> +static ssize_t hwirq_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> -	ssize_t ret = 0;
> -
> -	raw_spin_lock_irq(&desc->lock);
> -	if (desc->irq_data.domain)
> -		ret = sprintf(buf, "%lu\n", desc->irq_data.hwirq);
> -	raw_spin_unlock_irq(&desc->lock);
>   
> -	return ret;
> +	guard(raw_spinlock_irq)(&desc->lock);
> +	return desc->irq_data.domain ? sprintf(buf, "%lu\n", desc->irq_data.hwirq) : 0;

... more readable than this ^^^. (Ie. I would preserve the 'if'. Even 
though here is only a simple condition.)

>   }
>   IRQ_ATTR_RO(hwirq);

> -static ssize_t name_show(struct kobject *kobj,
> -			 struct kobj_attribute *attr, char *buf)
> +static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> -	ssize_t ret = 0;
>   
> -	raw_spin_lock_irq(&desc->lock);
> -	if (desc->name)
> -		ret = scnprintf(buf, PAGE_SIZE, "%s\n", desc->name);
> -	raw_spin_unlock_irq(&desc->lock);
> -
> -	return ret;
> +	guard(raw_spinlock_irq)(&desc->lock);

You do guard() ...

> +	return desc->name ? scnprintf(buf, PAGE_SIZE, "%s\n", desc->name) : 0;
>   }
>   IRQ_ATTR_RO(name);
>   
> -static ssize_t actions_show(struct kobject *kobj,
> -			    struct kobj_attribute *attr, char *buf)
> +static ssize_t actions_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>   {
>   	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
>   	struct irqaction *action;
>   	ssize_t ret = 0;
>   	char *p = "";
>   
> -	raw_spin_lock_irq(&desc->lock);
> -	for_each_action_of_desc(desc, action) {
> -		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
> -				 p, action->name);
> -		p = ",";
> +	scoped_guard (raw_spinlock_irq, &desc->lock) {

... but scoped_guard<space>(). Unlike in internals.h where you do 
scoped_guard(). Any reason for that?

> +		for_each_action_of_desc(desc, action) {
> +			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s", p, action->name);
> +			p = ",";
> +		}
>   	}
> -	raw_spin_unlock_irq(&desc->lock);
> -
> -	if (ret)
> -		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
>   
> -	return ret;
> +	return ret ? ret + scnprintf(buf + ret, PAGE_SIZE - ret, "\n") : 0;
>   }
>   IRQ_ATTR_RO(actions);
...
> @@ -573,12 +532,12 @@ static int alloc_descs(unsigned int star
>   	return -ENOMEM;
>   }
>   
> -static int irq_expand_nr_irqs(unsigned int nr)
> +static bool irq_expand_nr_irqs(unsigned int nr)
>   {
>   	if (nr > MAX_SPARSE_IRQS)
> -		return -ENOMEM;
> +		return false;
>   	nr_irqs = nr;
> -	return 0;
> +	return true;

This is sort of unrelated to $SUBJ ^^^. In any case:

> @@ -681,14 +638,13 @@ static inline int alloc_descs(unsigned i
>   
>   static int irq_expand_nr_irqs(unsigned int nr)

s/int/bool/ here too.

>   {
> -	return -ENOMEM;
> +	return false;
>   }

thanks,
-- 
js
suse labs

