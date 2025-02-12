Return-Path: <linux-kernel+bounces-511521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16BCA32C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53104163468
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616221A424;
	Wed, 12 Feb 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddx6DbYb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE51DEFDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378739; cv=none; b=bfFgdqfMyaroff1iBJxsnMwT569TTg8Ys3kTkNJl751RBDwuAwx3vPPgde1+fno+2WPvimmSU0iMQmrpHWyccrVeqwPZysYkKDba38ktjGSKd9nesWkIOyHNxXr48GaoShQotj3rJhCZIe9L3XnpNcFwyvgGYxexhtxqzxCJxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378739; c=relaxed/simple;
	bh=zzL8nKmEl7mUsFySGq8JdfqK+nVRCyFYNnXZm3QmYqc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dstbur8hB8PJLWXD2/twBkNeTeYJPXtTPL0y2xc1n+2qJap2UckVf8q5+76WxeIrDCnCRKLbVIUE1J8OP6iHkbtcpLJYrDxK2kfgulEPdGvLH1vr562ficmHhm9LSkVlJtDMSz8YGYs58HTrdryXUhDf6joiuZPGHtuAdw5j88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ddx6DbYb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739378735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1WAuyWxvwyV3SeoHQOj40jpsEN4sl/ZLjBygIFkTNE=;
	b=Ddx6DbYb8WCs+xGWu9aUHpcguckP/3MQTjGzah5YwLJutk/3NrgW8un5W8nMBRd+WeZP2t
	kunM5BjgJezhdkrgPatCML2m+fN1vEy0cZx2BeOhokFRe2d/9E5xxm/3ZuX9+6cIlMBIP6
	xCVjqLk9jD2l3eyT7HKoks8g3csTa2c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-GbkGvA72NRSzXSBBW_hc3g-1; Wed, 12 Feb 2025 11:45:34 -0500
X-MC-Unique: GbkGvA72NRSzXSBBW_hc3g-1
X-Mimecast-MFC-AGG-ID: GbkGvA72NRSzXSBBW_hc3g
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-471aa567902so31208881cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378734; x=1739983534;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1WAuyWxvwyV3SeoHQOj40jpsEN4sl/ZLjBygIFkTNE=;
        b=OuIMmNVt3SZlaJmoK7O8DpN8ywH8CAjxRFp5G718cJqJruvqe2OGSqOirTDMdKF/iF
         9Voz6CMs8KOMN0Uv8gxkQYgELOvFhtfQGAUGRRvrRkJfQGpsoyR2Mc/zL6iiMn79DZA5
         u5bzaDhbjo+ghD+XsYxZZsbeUqZeG/1+9dPPJAyDdJajASXnlFKFfSqUtRfFFcyYu+Iy
         Fct02Vo0qBjul5+A/ED0baOUqpyp46uk4QPPhXb5kX6FecuxjhMTTb3agOioeRnuneq4
         sEhXxmVIL58E7eUbygaKhmwDizWdJzEib9EmiFcbjTH2LFUthBtDPe7vZRl73v6m7gIP
         BtVw==
X-Forwarded-Encrypted: i=1; AJvYcCUU6DydW8jQKbhtCI2J84239aYL5bho+Lm/LetKsmPaP0gFe0hZ8DaCuX4xK149+ZH6f6Jt+dA2VqvUsQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHkLYvJXqndnjCYSTremY5aXKrpLgc4LbANkteJj137gFpwvN
	vZjsMyYBXKet/c5pOFTauwmsF6Kk7y1TnIpI+3Vli2s3sykL2Um/0OOZkvYq1DTGa6l2YcEBWe0
	oI7x0nJtkddFNx0ctvotpg8yuNcBhVvCjXAwk1VHOgMlyNAiZxX4kxoBuG2di5g==
X-Gm-Gg: ASbGncszUx6+DvU2iaCdryuNnrHgfNPS6JdjPkXS1OSToXKn0PC4m3n8MtYB/pMHzIR
	4ij6ZHqzjeT2YDeZN2Mzskjidp4jZsWW1uyxVbzilxH+QHCdjjraMMyBagiiaPN/bF413HhaN7K
	YlQpUgtBY1z4mymt6QN0qdU3jwP2cgEcgMui+nVGhpC5RmATSd7pi6CJzhPk5rll7na9zcSuLaq
	m3AM4UZHGQC1dotqiNrT84sdlLfSbtmiDFEGKmvmi4F1YiZ98SV7lZJsoyw/KChMMhsjsVUgADn
	b1KK+lZQHpMEtHQKbSaXzD76P7twAdB9B3oBqPqT49Scwgg0
X-Received: by 2002:a05:622a:648:b0:471:97db:60d4 with SMTP id d75a77b69052e-471afeee7d7mr59054581cf.45.1739378733715;
        Wed, 12 Feb 2025 08:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGArrt9raZS1kCVfk5aMGGEWPc4R/M8+iszkJcLkTxoo7QnAdpj44TX2N231zdbRI11QqG7Sg==
X-Received: by 2002:a05:622a:648:b0:471:97db:60d4 with SMTP id d75a77b69052e-471afeee7d7mr59053771cf.45.1739378733046;
        Wed, 12 Feb 2025 08:45:33 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718cb6d2b0sm47264591cf.16.2025.02.12.08.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:45:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <efbe0c96-2bc6-4520-a90d-57e273f9f613@redhat.com>
Date: Wed, 12 Feb 2025 11:45:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <20250127013127.3913153-1-longman@redhat.com>
 <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com> <Z6w1cvz29NkMZh9b@Mac.home>
 <5f518ef0-2dbc-4d14-82ce-ad310a780598@redhat.com> <Z6zOlw2moxw0OAsZ@Mac.home>
Content-Language: en-US
In-Reply-To: <Z6zOlw2moxw0OAsZ@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/12/25 11:38 AM, Boqun Feng wrote:
> On Wed, Feb 12, 2025 at 09:10:25AM -0500, Waiman Long wrote:
>> On 2/12/25 12:45 AM, Boqun Feng wrote:
>>> On Tue, Feb 11, 2025 at 09:18:56PM -0500, Waiman Long wrote:
>>>> On 1/26/25 8:31 PM, Waiman Long wrote:
>>>>> A circular lock dependency splat has been seen involving down_trylock().
>>>>>
>>>>> [ 4011.795602] ======================================================
>>>>> [ 4011.795603] WARNING: possible circular locking dependency detected
>>>>> [ 4011.795607] 6.12.0-41.el10.s390x+debug
>>>>> [ 4011.795612] ------------------------------------------------------
>>>>> [ 4011.795613] dd/32479 is trying to acquire lock:
>>>>> [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
>>>>> [ 4011.795636]
>>>>> [ 4011.795636] but task is already holding lock:
>>>>> [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
>>>>>
>>>>>      the existing dependency chain (in reverse order) is:
>>>>>      -> #4 (&zone->lock){-.-.}-{2:2}:
>>>>>      -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
>>>>>      -> #2 (&rq->__lock){-.-.}-{2:2}:
>>>>>      -> #1 (&p->pi_lock){-.-.}-{2:2}:
>>>>>      -> #0 ((console_sem).lock){-.-.}-{2:2}:
>>>>>
>>>>> The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
>>>>> while holding the console.sem raw_spinlock. This dependency can be broken
>>>>> by using wake_q to do the wakeup instead of calling try_to_wake_up()
>>>>> under the console_sem lock. This will also make the semaphore's
>>>>> raw_spinlock become a terminal lock without taking any further locks
>>>>> underneath it.
>>>>>
>>>>> The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
>>>>> spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
>>>>> the debug_objects_fill_pool() helper function in the debugobjects code.
>>>>>
>>>>> [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
>>>>> [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
>>>>> [ 4011.795655]        lock_acquire.part.0+0x258/0x630
>>>>> [ 4011.795657]        lock_acquire+0xb8/0xe0
>>>>> [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
>>>>> [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
>>>>> [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
>>>>> [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
>>>>> [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
>>>>> [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
>>>>> [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
>>>>> [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
>>>>> [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
>>>>> [ 4011.795684]        allocate_slab+0x320/0x460
>>>>> [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
>>>>> [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
>>>>> [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
>>>>> [ 4011.795692]        fill_pool+0xf6/0x450
>>>>> [ 4011.795697]        debug_object_activate+0xfe/0x360
>>>>> [ 4011.795700]        enqueue_hrtimer+0x34/0x190
>>>>> [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
>>>>> [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
>>>>> [ 4011.795707]        hrtimer_interrupt+0x316/0x760
>>>>> [ 4011.795709]        do_IRQ+0x9a/0xe0
>>>>> [ 4011.795712]        do_irq_async+0xf6/0x160
>>>>>
>>>>> Normally raw_spinlock to spinlock dependency is not legit
>>>>> and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
>>>>> but debug_objects_fill_pool() is an exception as it explicitly
>>>>> allows this dependency for non-PREEMPT_RT kernel without causing
>>>>> PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
>>>>> legit and not a bug.
>>>>>
>>>>> Anyway, semaphore is the only locking primitive left that is still
>>>>> using try_to_wake_up() to do wakeup inside critical section, all the
>>>>> other locking primitives had been migrated to use wake_q to do wakeup
>>>>> outside of the critical section. It is also possible that there are
>>>>> other circular locking dependencies involving printk/console_sem or
>>>>> other existing/new semaphores lurking somewhere which may show up in
>>>>> the future. Let just do the migration now to wake_q to avoid headache
>>>>> like this.
>>>> I can also add the following as another instance where deadlock can happen.
>>>>
>>>> Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
>>>>
>>> FWIW, I already queued in my lockdep-for-tip branch, will send it in a
>>> PR to Peter in one or two weeks (in case he hasn't taken it before
>>> then).
>>>
>>> BTW, do we need a "Fixes" tag for stable kernels?
>> After some more thought, I realize that this patch doesn't really fix the
>> circular lock dependency problem, it just remove console_sem.lock from it.
>> The problem is that printk() can be called in any context. To really solve
>> the problem, we will need some kind of deferred wakeup using workqueue, for
>> instance. As printing to the console is inherently slow, adding some more
> Hmm... but your patch does remove the dependency console_sem.lock ->
> pi_lock, right? So it does fix the circular lock dependency problem. Or
> do you mean that it doesn't fix all the deadlocks that may cause by
> printk()?

Right, it doesn't  fix all the deadlocks that may be caused by printk(). 
Similar circular lock dependency splat will still happen. It will start 
with pi_lock instead of console_sem.lock and will have one less lock in 
the circular list. It is caused by waking up process within the printk() 
context. That is why I think the proper solution is to have a deferred 
wakeup. It will be specific to the printk() use cases.

Cheers,
Longman


