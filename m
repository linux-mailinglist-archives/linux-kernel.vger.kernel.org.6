Return-Path: <linux-kernel+bounces-534125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB307A4630E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4273B1E80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9199722154E;
	Wed, 26 Feb 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm6HjVih"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED1221D8E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580653; cv=none; b=Cry/7b41sWerOAUq7iBz9fNprSZy2VY3yhzNan0NoukBGiKGJYGja1V0ZFHGYenOmBtv/WNn9j3RUaM36Z6VbDk7tXqU3OXA4VUcSNxaGfgQMnovQChoj4ok6/3HCKq4ODmLU9zBgEkCdWJyXBbgmqUzpItDkqhbwuD8/jb6DMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580653; c=relaxed/simple;
	bh=07sjqsty034Cb3vv2DEW8eHi8LMzRz6ZjPX04zHO+hA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fFFULglaDdf+jKg+gkQF6NLqXRAvxtpepbDnYckdyUWSSsCkmu9oZxVoEqoqTHRemUjhWKEoYAjOxdr1POeMsRHxCFw2dHcESqnonC+E46bV9XAVFQLg5WYkqoCo4prtcodDGw2Nrw6UjabWPtxm3yHuLY5KZjMy0s8s89ktwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm6HjVih; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740580649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xkw+IZTTdc38YKX9Z1vDKzQiXbPhWgPhuZKvhwxphJo=;
	b=Bm6HjVihSGCR2TLO05Z8KPhaC0Qipj6Vkt1+6IKvsyIyy4XhhWZGeR7a/1QNbIuy5p63yG
	pbUyVhRQi+jaKKiJAvJpiJt0aWlTFY+uddRP+IlkIjo4XnnTB0xtcHdzMSwzpO0LdRNdoP
	/6S4p+iA6SJ9SPnWNxiKOm/6RJ0SOys=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-cC8SICjCNvOi-YKcuc7lbw-1; Wed, 26 Feb 2025 09:37:28 -0500
X-MC-Unique: cC8SICjCNvOi-YKcuc7lbw-1
X-Mimecast-MFC-AGG-ID: cC8SICjCNvOi-YKcuc7lbw_1740580648
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-47207b66f3eso134669401cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580648; x=1741185448;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkw+IZTTdc38YKX9Z1vDKzQiXbPhWgPhuZKvhwxphJo=;
        b=FdfD73XHpcjKE8hpn4Ht2tD3CH2mfBJbjLwnZIBQ18BsQ5ptQvajFxryM9IvZKo40a
         ZmKCTBDEC2iL360fvBV+DNH+BMmYwU985DhVIlwRiEAEkjvJXA3fwmZo6sMIlYvximWJ
         Glndh1xjw5RJXrdPRnfSoQyPhi6fYaZ1Mge8DJVtubDlzETB9EfGasEwhNPnhQ0jFxE3
         +KYlR3HqV7aE5GaRa5kn7pKwod5CiiUpHUdbTsyS4piC9rAK+062ceQ6EInES7yY68VZ
         wG5GFpobx1bvMClRsGU6efKWV/5e9kzkGn4cadAidXLA/hrZfzsTm7tD3d/9fMoPC1z6
         3p8w==
X-Gm-Message-State: AOJu0YysLGuA8W9SCIEKwRKDdrOXT0Q758e+tST4go2IPH6daD15OCgS
	MtCur90pu1BuTNnWAxdXFVSb8d/W1XsKwFR1Im3/BGLiQr5j5SsuguBLEFUMP2PeUMSbdTBjziM
	hWEbDf4l1lIS0iAhUVtDKvkqsY4LBd7LrVBI0I+Fq/S+GJ3Y4zvaSgx9PV+izeg==
X-Gm-Gg: ASbGncs9fTVGM/jhib2or2McPBHFUweFB2jHgcjjpitpuDcD/cJynWxCfMvt5jlSi3v
	QguH14I2UlmuxRBdU+0T2x+j7Aw+SyCgR1Fes47Z0Ct8OQVVkIJDxvDT6H4L11uz++fxQNzsFl2
	IMm1nnuIhYoTuiU31mAklaWSQL6sqp/W3sQLpCIMPAreMShRoVlKo/IbSxd8ypAjbvMwDvQ5asx
	u1cXL64SihktaeJ/Y954tAjpV0l6+opGXF/LlofPl0OtybM3gyjH1/Lm0bB4S4DOyF3E17wzr3/
	IP4ldp3CInFyIDX1pOtIG49eqy2RrGBcY+DSo+6PRPq2u8zikUoP5/E68yY=
X-Received: by 2002:a05:622a:1387:b0:472:ebe:a77b with SMTP id d75a77b69052e-4722491ec9dmr341257371cf.44.1740580647882;
        Wed, 26 Feb 2025 06:37:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZwdAM90ycZZZ3sTxVoxTQYi4bWrDpo9DyFNGaXjQUA2WT4OfZoqy4lJAQm+5mw6Whk5k0Kg==
X-Received: by 2002:a05:622a:1387:b0:472:ebe:a77b with SMTP id d75a77b69052e-4722491ec9dmr341257021cf.44.1740580647552;
        Wed, 26 Feb 2025 06:37:27 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e15b90sm24527521cf.30.2025.02.26.06.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 06:37:27 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <44f36f13-4ce6-47ce-9423-9e4cceda7443@redhat.com>
Date: Wed, 26 Feb 2025 09:37:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: Use a hashmask instead of hashsize.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250226091057.bX8vObR4@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250226091057.bX8vObR4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 4:10 AM, Sebastian Andrzej Siewior wrote:
> The global hash uses futex_hashsize to save the amount of the hash
> buckets that have been allocated during system boot. On each
> futex_hash() invocation this number is substracted by one to get the
> mask. This can be optimized by saving directly the mask avoiding the
> substraction on each futex_hash() invocation.
>
> Rename futex_hashsize to futex_hashmask and save the mask of the
> allocated hash map.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> Split from the "local hash" series.
>
>   kernel/futex/core.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index 3db8567f5a44e..cca15859a50be 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -50,10 +50,10 @@
>    */
>   static struct {
>   	struct futex_hash_bucket *queues;
> -	unsigned long            hashsize;
> +	unsigned long            hashmask;
>   } __futex_data __read_mostly __aligned(2*sizeof(long));
>   #define futex_queues   (__futex_data.queues)
> -#define futex_hashsize (__futex_data.hashsize)
> +#define futex_hashmask (__futex_data.hashmask)
>   
>   
>   /*
> @@ -119,7 +119,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
>   	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
>   			  key->both.offset);
>   
> -	return &futex_queues[hash & (futex_hashsize - 1)];
> +	return &futex_queues[hash & futex_hashmask];
>   }
>   
>   
> @@ -1127,27 +1127,28 @@ void futex_exit_release(struct task_struct *tsk)
>   
>   static int __init futex_init(void)
>   {
> +	unsigned long hashsize, i;
>   	unsigned int futex_shift;
> -	unsigned long i;
>   
>   #ifdef CONFIG_BASE_SMALL
> -	futex_hashsize = 16;
> +	hashsize = 16;
>   #else
> -	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
> +	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
>   #endif
>   
>   	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
> -					       futex_hashsize, 0, 0,
> +					       hashsize, 0, 0,
>   					       &futex_shift, NULL,
> -					       futex_hashsize, futex_hashsize);
> -	futex_hashsize = 1UL << futex_shift;
> +					       hashsize, hashsize);
> +	hashsize = 1UL << futex_shift;
>   
> -	for (i = 0; i < futex_hashsize; i++) {
> +	for (i = 0; i < hashsize; i++) {
>   		atomic_set(&futex_queues[i].waiters, 0);
>   		plist_head_init(&futex_queues[i].chain);
>   		spin_lock_init(&futex_queues[i].lock);
>   	}
>   
> +	futex_hashmask = hashsize - 1;
>   	return 0;
>   }
>   core_initcall(futex_init);

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>


