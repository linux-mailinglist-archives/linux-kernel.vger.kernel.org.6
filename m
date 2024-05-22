Return-Path: <linux-kernel+bounces-186093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8008CBFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BFE283720
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753AD82494;
	Wed, 22 May 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H7VLo6p0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95980C07
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376109; cv=none; b=fmyVvwaWfVO+sfSybcFSJ8IYDnXIp7sAfHN/+vSwLKD80qPtIcTPRvDuSanYVpk+RFV2gaiDv5AYuV+yygR/lWJ+dJ+KGXuATbcUMyhFC3cuu2OebV6F0T/1jplrTvrl/16NHAHbEO9yTiQ6pN2g79ERYeHWYqhopnRGF7Oh2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376109; c=relaxed/simple;
	bh=qJbxok2RXCvg8Xmc0EqfuWa3u1mbM8EWeVr/fPpJxpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gINfyNyGi7FP/4S4MJ3TpbQyzZg3lkZ72h8jqUqEbgAu4Hw1uLU1l3+mWyHcpc0GJSzQ6jISYojI53uCr/rd3njcYSJOeW2Hk97hKUj1rYv+Wsc+ceAJLEnPilcBWwCS3m8AQGCryngFiTj5jeXnqxfgEjtluEbYI1uC1IQNvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H7VLo6p0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5766cd9ca1bso4612029a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716376106; x=1716980906; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AigFP8gra5sqHHAhUzQePWg8R97to/QQ9wJssdBsNYE=;
        b=H7VLo6p0/xOcDIoOB3ydUxdNTkuASXUAOIUdYS5rqjbc8zF2Waa50VEps0DYWqaMOp
         E/kEL2mB4ddjS9k9CDWAya0P5/3KRAkk05KFZgkosICIzATwc2SiDWdppSRECj5ROxR4
         F+UabFbOr/hbtoT2aqc3IFy8X1QzFLtyyVHuFkK+kAPnz8KgkLhP1qS6+v5+VfjfgDMi
         XyNRzdZjgDtkovx8ynME1eQpV02gkmmuTFANPrWsFlZjXG4M+CJZ1VmXVZNpoLVNnEDg
         iuPghZzJkOkEaDbFWxRneBFrVt+RbXdcz2j9aRgtj5Y0M05RUP6SPhGbS9TU4inG8MaT
         fjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376106; x=1716980906;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AigFP8gra5sqHHAhUzQePWg8R97to/QQ9wJssdBsNYE=;
        b=MBpIZRGu2uIcaRniae/t1nk8G8V+CPx/xZX3xNpzk09/vnYqBY4qtiTkPLkU6vHq4J
         DQcr7mEo/OthEzuLGQ99SuW0AjpwHRBNZlgGWhWi5apixASZZWlEFkNt5qFpZ4Jz7CRM
         vQN4EcrQzG/JQ38jBCm6XtIJVJxYBqcK+tRBl2EkwQ+ZHBmF3e17SQRah1S2KrlvRdVZ
         qHZ53Q6F0cHWtfcDJmlFT24OD2lzGelF/UrdptIdH5WVuaThDyDRtX7p4LAwh4MuGvLk
         QDPwfSC1u7A637IXOUtHZj1GeO8Pmljeg1yjIaStMzVotHBMq0EvOekeJ8BTjRdD9bOV
         RRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJQoX/ItqiHmrS0n9QdyARWMu4iVGXvRwxKW2cGp4+5gAVNZrY/BckeufaNL7NBx3q1cYEzo34hW06uUTlQeNi5NxboIA3CxRNRW0
X-Gm-Message-State: AOJu0YzhhLtim/4Fqe9JYADsVpvC+1Q2bd7mK+2tL86XUXv/6FaYs0u/
	J70EP+wdbK/4gENCLoncZfh6qyxC+WdDhCpp5VCYjEClsXrekS3jKA392U1Tqd0=
X-Google-Smtp-Source: AGHT+IF1l0SLei32L9sBMLYeuwOqzM23rfU8NLW8508I+T5hHBu7h4Tcbf6ZGf2coR6OsgYzFxYXJA==
X-Received: by 2002:a17:906:fc10:b0:a59:c319:f1db with SMTP id a640c23a62f3a-a622802805bmr110369666b.1.1716376105851;
        Wed, 22 May 2024 04:08:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5d34e6727csm623375466b.80.2024.05.22.04.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:08:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Linus Torvalds <torvalds@linux-foundation.org>,
  bpf <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>,  Hillf
 Danton <hdanton@sina.com>,  "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
In-Reply-To: <f77290fe-a94e-498b-bbbf-429ba0ce49c2@I-love.SAKURA.ne.jp>
	(Tetsuo Handa's message of "Wed, 22 May 2024 19:30:58 +0900")
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
	<20240521225918.2147-1-hdanton@sina.com> <877cfmxjie.fsf@cloudflare.com>
	<f77290fe-a94e-498b-bbbf-429ba0ce49c2@I-love.SAKURA.ne.jp>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 13:08:23 +0200
Message-ID: <87v836w1co.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22, 2024 at 07:30 PM +09, Tetsuo Handa wrote:
> On 2024/05/22 18:50, Jakub Sitnicki wrote:
>> On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
>>> On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
>>>> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> --- a/net/core/sock_map.c
>>>>> +++ b/net/core/sock_map.c
>>>>> @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
>>>>>         bool strp_stop =3D false, verdict_stop =3D false;
>>>>>         struct sk_psock_link *link, *tmp;
>>>>>
>>>>> +       rcu_read_lock();
>>>>>         spin_lock_bh(&psock->link_lock);
>>>>
>>>> I think this is incorrect.
>>>> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>>>
>>> Could you specify why it won't be safe in rcu cs if you are right?
>>> What does rcu look like in RT if not nothing?
>> 
>> RCU readers can't block, while spinlock RT doesn't disable preemption.
>> 
>> https://docs.kernel.org/RCU/rcu.html
>> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-rt
>> 
>
> I didn't catch what you mean.
>
> https://elixir.bootlin.com/linux/latest/source/include/linux/spinlock_rt.h#L43 defines spin_lock() for RT as
>
> static __always_inline void spin_lock(spinlock_t *lock)
> {
> 	rt_spin_lock(lock);
> }
>
> and https://elixir.bootlin.com/linux/v6.9/source/include/linux/spinlock_rt.h#L85 defines spin_lock_bh() for RT as
>
> static __always_inline void spin_lock_bh(spinlock_t *lock)
> {
> 	/* Investigate: Drop bh when blocking ? */
> 	local_bh_disable();
> 	rt_spin_lock(lock);
> }
>
> and https://elixir.bootlin.com/linux/latest/source/kernel/locking/spinlock_rt.c#L54 defines rt_spin_lock() for RT as
>
> void __sched rt_spin_lock(spinlock_t *lock)
> {
> 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> 	__rt_spin_lock(lock);
> }
>
> and https://elixir.bootlin.com/linux/v6.9/source/kernel/locking/spinlock_rt.c#L46 defines __rt_spin_lock() for RT as
>
> static __always_inline void __rt_spin_lock(spinlock_t *lock)
> {
> 	rtlock_might_resched();
> 	rtlock_lock(&lock->lock);
> 	rcu_read_lock();
> 	migrate_disable();
> }
>
> . You can see that calling spin_lock() or spin_lock_bh() automatically starts RCU critical section, can't you?
>
> If spin_lock_bh() for RT might sleep and calling spin_lock_bh() under RCU critical section is not safe,
> how can
>
>   spin_lock(&lock1);
>   spin_lock(&lock2);
>   // do something
>   spin_unlock(&lock2);
>   spin_unlock(&lock1);
>
> or
>
>   spin_lock_bh(&lock1);
>   spin_lock(&lock2);
>   // do something
>   spin_unlock(&lock2);
>   spin_unlock_bh(&lock1);
>
> be possible?
>
> Unless rcu_read_lock() is implemented in a way that is safe to do
>
>   rcu_read_lock();
>   spin_lock(&lock2);
>   // do something
>   spin_unlock(&lock2);
>   rcu_read_unlock();
>
> and
>
>   rcu_read_lock();
>   spin_lock_bh(&lock2);
>   // do something
>   spin_unlock_bh(&lock2);
>   rcu_read_unlock();
>
> , I think RT kernels can't run safely.
>
> Locking primitive ordering is too much complicated/distributed.
> We need documentation using safe/unsafe ordering examples.

You're right. My answer was too hasty. Docs say that RT kernels can
preempt RCU read-side critical sections:

https://docs.kernel.org/RCU/whatisRCU.html?highlight=rcu_read_lock#rcu-read-lock


