Return-Path: <linux-kernel+bounces-531471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A1A440FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C497C1644CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36C26982D;
	Tue, 25 Feb 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RbZyabTS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B526A0AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490212; cv=none; b=lc9NklyMClWj8XWM34bU8MULYs7aB9eqZgSoFWizMgRAvPCLfbTlzk9vIKHFMYlIgP2B0Fl6Je5zHj6i3jee21fx9ooKR2yanhh9ZBh2b4p8f5dy4nvu7bDAZIJzv+mCIdjdHzJdc+D0/G8g9QmYisH5VFzer8AeKfcMDJA0Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490212; c=relaxed/simple;
	bh=hvLj0F4Uwm40bxLfNRVMTVx2jzkCvz6JcDf1yH4Ju1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWT3lVbH7fKQkFGD7uEVc7UXJ1rnYfaDDbmlpsh5zSjFaA/jKZG0oo1fnnEqAMxFYsg+CQPZHrJjeVfQWKYMn6TuIu3lo4CCNmyQU8vuDg/UtTAfFgV6SDMWjhfoL5VQABF/pLvyWhOWmC2KkJplDCHoOy/72PY5qhTiSJSQM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RbZyabTS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7520028bso749786666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740490209; x=1741095009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWPAKB8cSPuv3a8g0C1bOw8Zay5mwFkNm0SF2AsIuEQ=;
        b=RbZyabTSnrz9r84fjBO10x8bHkBJaQaMnhl2FqSeyxsPXLPEjyGU8yBFo25wa2a8kc
         Q4q5Lgmr3JgrRItPy3hKveqN7yzjHCX85oLRVq2BELG+XnecdKnjQ88Phz9+WG577KMX
         5b3+kOY22Hd+jgNZuBLPR/8IPlYFEkJUIrR09ttu0rZLbJPjad4JBtdH5wHcg3vA6U6u
         YsJi24IXOolHpdnPlAGjyisZn+SZEeM4QwmhXYrWSnio/CMY9qae/8bkx1K3PWvKoVQe
         aD8u36rZGDuqARWgqz4yOqE+UOjd0EzwpmOdHKOH/8gc/BTVQd79eIlMO2+ncNDEfH1W
         ZmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490209; x=1741095009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWPAKB8cSPuv3a8g0C1bOw8Zay5mwFkNm0SF2AsIuEQ=;
        b=Uc/aImIE1XfWIv340BV2CEkhidzz0v0N6ei7+LopndVqvGmam8gZMtWhfxYfupaFrD
         BcY685KP9HbnfMnvi8VQmYn7VJT6foeKsFTnl9wuuEigKmZlF1Va566P4JZgOaLdgCxy
         fl9BxXGmj1bNohTh90ikCjWb04to/GArDMCPpaqcoMki7eoza4i7K9S5RRtXHuu3K7Ns
         q21GYuR8Lk4VFqCkSHTCs8AdS6UblRbv5lIDk00ijdL42W7PFNpHt+T3yPP4kEzBqAvD
         f9dwOHkbhvLHOQ7wG4ogMv9aRywMOq6mg7JydQpOPuP3pP1qSKH3W4oGgfRG1TILN/bW
         BJqA==
X-Forwarded-Encrypted: i=1; AJvYcCW1vCKIWlC8eru3ONaRyXLdml++F9hVNUluNKsPPvW3n9RW8DXoYzuEVNnJed6loWlC1wR6gMme35nfSJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3Eeux6Nt/G4j4YDeNo3XW2sy8WlXyUrb2FSCB1RpNfBn1ZUK
	tdtBOM9Nso/Lme+coYkKmGAq1DqAy2fk2azYLE6Ztj3Ik709kNXEsQj5lXndh+k=
X-Gm-Gg: ASbGncsGBOA6hgvC1Eg4Uykb0TR+ieUEtLsImHywBTIRrJGdFMaYTfzygMFsfANpUAi
	KZWad4yDkp6miiin/sAnnVpdE15doYc5OSgvCJmA6xyuutbClLFnyR4tRM1/Is3CWlgZBtiFU+D
	nFujLeTyudfDJqakzqwhF5LEQ9f9QE/5kF19AOA8b2B0EwF4lAAnySKiiazxG4vNpWzSw+wJAf/
	zKQxl6YEizihXuKMN8uS8Vv/18gWM4WcoKnB7Hc5PHpma/3e2OTfoPDts12LgAZnCdpfAreG7W/
	P2bNogVscMGM/+Rhde+sHTmOvAj0QIqR2vALA1SweZ10lJ87Kj7DbZhT1g==
X-Google-Smtp-Source: AGHT+IGt1d9HYoncPo/XlY2JEaN6xcouJm1b6mDBrkdkRB6XvWdMBX+M9vXDwh/uV+eQuDAPmnCDIA==
X-Received: by 2002:a17:907:9722:b0:aab:daf9:972 with SMTP id a640c23a62f3a-abc09ac1bd0mr1636694466b.28.1740490208363;
        Tue, 25 Feb 2025 05:30:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204f6edsm139335666b.128.2025.02.25.05.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:30:07 -0800 (PST)
Message-ID: <72827395-743d-488f-af12-39eead3a0650@blackwall.org>
Date: Tue, 25 Feb 2025 15:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>
 <Z73CBzgTVucuOMMb@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z73CBzgTVucuOMMb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 15:13, Hangbin Liu wrote:
> On Tue, Feb 25, 2025 at 01:05:24PM +0200, Nikolay Aleksandrov wrote:
>>> @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>>  out:
>>>  	netdev_put(real_dev, &tracker);
>>> -	mutex_lock(&bond->ipsec_lock);
>>> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>> -		if (ipsec->xs == xs) {
>>> -			list_del(&ipsec->list);
>>> -			kfree(ipsec);
>>> -			break;
>>> -		}
>>> -	}
>>> -	mutex_unlock(&bond->ipsec_lock);
>>> +
>>> +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
>>> +	if (!xfrm_work)
>>> +		return;
>>> +
>>
>> What happens if this allocation fails? I think you'll leak memory and
>> potentially call the xdo_dev callbacks for this xs again because it's
>> still in the list. Also this xfrm_work memory doesn't get freed anywhere, so
>> you're leaking it as well.
> 
> Yes, I thought this too simply and forgot free the memory.
>>
>> Perhaps you can do this allocation in add_sa, it seems you can sleep
>> there and potentially return an error if it fails, so this can never
>> fail later. You'll have to be careful with the freeing dance though.
> 
> Hmm, if we allocation this in add_sa, how to we get the xfrm_work
> in del_sa? Add the xfrm_work to another list will need to sleep again
> to find it out in del_sa.
> 

Well, you have struct bond_ipsec and it is tied with the work's lifetime
so you can stick it there. :)
I haven't looked closely how feasible it is.

>> Alternatively, make the work a part of struct bond so it doesn't need
>> memory management, but then you need a mechanism to queue these items (e.g.
>> a separate list with a spinlock) and would have more complexity with freeing
>> in parallel.
> 
> I used a dealy work queue in bond for my draft patch. As you said,
> it need another list to queue the xs. And during the gc works, we need
> to use spinlock again to get the xs out...
> 

Correct, it's a different kind of mess. :)

>>
>>> +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
>>> +	xfrm_work->bond = bond;
>>> +	xfrm_work->xs = xs;
>>> +	xfrm_state_hold(xs);
>>> +
>>> +	queue_work(bond->wq, &xfrm_work->work);
>>
>> Note that nothing waits for this work anywhere and .ndo_uninit runs before
>> bond's .priv_destructor which means ipsec_lock will be destroyed and will be
>> used afterwards when destroying bond->wq from the destructor if there were
>> any queued works.
> 
> Do you mean we need to register the work queue in bond_init and cancel
> it in bond_work_cancel_all()?
> 
> Thanks
> Hangbin

That is one way, the other is if you have access to the work queue items then
you can cancel them which should be easier (i.e. cancel_delayed_work_sync).

Regardless of which way you choose to solve this (gc or work in bond_ipsec), there will
be some dance to be done for the sequence of events that will not be straight-forward.

Cheers,
 Nik


