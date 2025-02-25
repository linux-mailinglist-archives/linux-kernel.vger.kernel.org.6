Return-Path: <linux-kernel+bounces-531615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E93A442CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92327188DEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887026A1B4;
	Tue, 25 Feb 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="uZKXyjii"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF7126C18
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493629; cv=none; b=aE+bPdsTHbSkrUR4AKAoqDP79F1voheoOIgaSkXdwyfNFeJSWnqv0IEznvKgf7H9gPvW9c/HnsAuuzm8eXja8wM3LZlm/l9O98cyGVDLLxTAT7lnRoIbTJXPA28ay8X8Z0ZlvVRbw6laFgGcYDoUZoVbRMr0u7OO2EpLqARRxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493629; c=relaxed/simple;
	bh=C3ccY3ZwLQzrjCIq91J7594C9RCW7z3ZBoYXdo9TRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qExdYwDgFN0KOx1KpYMyvxEeHA3PzBjSG4XSBWwMmzcJIquhIhOHzrEGr1Y1FsU4kjIqyLFXl+PcqzBPvR36zQf1K7MTYYaZicHiQIiU1HokSRzZvTHTF0boN6lgqyUbPrquMmcRGhiO8ZHv8PiqdjGjDQn0/WsMjvpUdozdeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=uZKXyjii; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso35639215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740493626; x=1741098426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QMi4VwrXU66Ki1nrs6Wu07Na08oHbBCCOqst7KVciY=;
        b=uZKXyjiirVKrZtOv4mtkmz5YbjG90NsdeG1q9ISWkKMi+E06Yf/GnBcR02ARkbNqgD
         OQorZi0DdW+aCHk8fUZum2yqczwUu226l0xEtr0vEw1S1rOBxTwSZDdWFBeH+nGwVcj7
         cdaW6GFS3DlrP+x6/bpzrMM2IsrXYlTFRe1kkg/tqH+dG5xQSregssHVd/ryB/XV4iOk
         E76SfbbE3KZMEN/xZVuEktQJMCfPMogEQqkwVtrSBtZHfFUkUCwG2c+aJL41LjSrdqZ/
         7DUwT1sTjvpGEsD5INGLjuVRE735/5MKLKs97nFKJmzgxHPwUqdeOFNCnH4qsSToYpva
         8jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493626; x=1741098426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QMi4VwrXU66Ki1nrs6Wu07Na08oHbBCCOqst7KVciY=;
        b=G+WQDgpTkXQUlXNZl3QJDdQU7CaH5JYcpDD2OA9QG5alNaUGNCZflAnAWMtWnRfmNC
         bmJes49cetz3WHgD9EVKQa8AuA+1Vw3iwF2yka9yGP2VMOM99ncd2Pv8+UV4n47oeZEj
         uKj4Y49xaVoM0DDhiAI21pVRxuhgzIm0RyMpdCbORqXnp8zF7KnYP2PmbMamVlSiEo1B
         kqWuKIdVdvNsluHtREAf3xfiijBHtxp6Bz0NrXQzlbG85SwCU+1zid17LE7aDcOkL9wH
         3PpnibUnY+EkLkZutMy6pUlDhh2EGMni0tuTzN/o+aB88lQpGdm1Aq7RhDwJwehvVDqD
         z32A==
X-Forwarded-Encrypted: i=1; AJvYcCUI+41bUGDWHIKo+lru/TnUxm1YUIJQzroIy37H8xxDCgNYQzYDcDIhYzcYL+XAnuvu/zBShxaHx87jd5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkKmLQlBCgXvIqIkCc1gaS2zCsJGQWv/OxhYxqu3zA5BgscAo
	8t00wNRtVBOjEJW5o+S//IkfGrSlYmPLLB83pHtoaGVnwRGvV1qGRA5RkQTOP00=
X-Gm-Gg: ASbGncvjIGxeca5nEQ7LX71McHgU+Krh/9E94HAv/xcJuXZL7GVt8B95aLzGazw2DWo
	b7rpXO/o+aik6E7WGgYqJjjQ0e9AdA1k58KEnujYilbPMVfoBcfIdC7nvUr22DODQnJPtMDlGqF
	YM2uNAW9Zr8pEr30cdVmggMEenYG0XO4co9LPMb6FNPXDuZjD3cpeRctlnh2pc3Qk5Kt5+e/U8X
	oL10wHQ4HC0u7I2ETJVU+oJj5O/fCGDXFvryVkIITZQrTsQg+cQRRzj+oYIMMVF57m8qCpUunRI
	0ZS8IV54IkkI7dZCLwrBxdKysOoriCUrCi/ImkrAsVSee0kpUypkNpJyrQ==
X-Google-Smtp-Source: AGHT+IFNcS5uUX050ewRgWcIyhrXix/tCXL61jbnelT4nfWUEiLJOaKXbpfRwTQNi9QiybtpYofh5A==
X-Received: by 2002:a5d:5846:0:b0:38d:dc4d:3473 with SMTP id ffacd0b85a97d-390cc63e06dmr2928097f8f.51.1740493625602;
        Tue, 25 Feb 2025 06:27:05 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fbc31sm2390594f8f.85.2025.02.25.06.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 06:27:05 -0800 (PST)
Message-ID: <70c953c7-f442-4e38-9071-c7bb6ad5fedc@blackwall.org>
Date: Tue, 25 Feb 2025 16:27:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
To: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "jarod@redhat.com" <jarod@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "jv@jvosburgh.net" <jv@jvosburgh.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Jianbo Liu <jianbol@nvidia.com>
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d298da7bc638c323e6d492b2dec7f1b9ea1e1350.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 16:00, Cosmin Ratiu wrote:
> On Tue, 2025-02-25 at 09:40 +0000, Hangbin Liu wrote:
>> The fixed commit placed mutex_lock() inside spin_lock_bh(), which
>> triggers
>> a warning like:
>>
>> BUG: sleeping function called from invalid context at...
>>
>> Fix this by moving the mutex_lock() operation to a work queue.
>>
>> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to
>> mutex")
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Closes:
>> https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>  drivers/net/bonding/bond_main.c | 41 +++++++++++++++++++++++++------
>> --
>>  include/net/bonding.h           |  6 +++++
>>  2 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c
>> b/drivers/net/bonding/bond_main.c
>> index e45bba240cbc..cc7064aa4b35 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -551,6 +551,25 @@ static void bond_ipsec_add_sa_all(struct bonding
>> *bond)
>>  	mutex_unlock(&bond->ipsec_lock);
>>  }
>>  
>> +static void bond_xfrm_state_gc_work(struct work_struct *work)
>> +{
>> +	struct bond_xfrm_work *xfrm_work = container_of(work, struct
>> bond_xfrm_work, work);
>> +	struct bonding *bond = xfrm_work->bond;
>> +	struct xfrm_state *xs = xfrm_work->xs;
>> +	struct bond_ipsec *ipsec;
>> +
>> +	mutex_lock(&bond->ipsec_lock);
>> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> +		if (ipsec->xs == xs) {
>> +			list_del(&ipsec->list);
>> +			kfree(ipsec);
>> +			xfrm_state_put(xs);
> 
> I would expect xfrm_state_put to be called from outside the loop,
> regardless of whether an entry is found in the list or not, because it
> was unconditionally referenced when the work was created.
> 
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&bond->ipsec_lock);
>> +}
>> +
>>  /**
>>   * bond_ipsec_del_sa - clear out this specific SA
>>   * @xs: pointer to transformer state struct
>> @@ -558,9 +577,9 @@ static void bond_ipsec_add_sa_all(struct bonding
>> *bond)
>>  static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>  {
>>  	struct net_device *bond_dev = xs->xso.dev;
>> +	struct bond_xfrm_work *xfrm_work;
>>  	struct net_device *real_dev;
>>  	netdevice_tracker tracker;
>> -	struct bond_ipsec *ipsec;
>>  	struct bonding *bond;
>>  	struct slave *slave;
>>  
>> @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state
>> *xs)
>>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>  out:
>>  	netdev_put(real_dev, &tracker);
>> -	mutex_lock(&bond->ipsec_lock);
>> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> -		if (ipsec->xs == xs) {
>> -			list_del(&ipsec->list);
>> -			kfree(ipsec);
>> -			break;
>> -		}
>> -	}
>> -	mutex_unlock(&bond->ipsec_lock);
>> +
>> +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
>> +	if (!xfrm_work)
>> +		return;
>> +
>> +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
>> +	xfrm_work->bond = bond;
>> +	xfrm_work->xs = xs;
>> +	xfrm_state_hold(xs);
>> +
>> +	queue_work(bond->wq, &xfrm_work->work);
>>  }
>>  
>>  static void bond_ipsec_del_sa_all(struct bonding *bond)
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index 8bb5f016969f..d54ba5e3affb 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -209,6 +209,12 @@ struct bond_ipsec {
>>  	struct xfrm_state *xs;
>>  };
>>  
>> +struct bond_xfrm_work {
>> +	struct work_struct work;
>> +	struct bonding *bond;
>> +	struct xfrm_state *xs;
>> +};
> 
> Also, like Nikolai said, something needs to wait on all in-flight work
> items.
> 
> This got me to stare at the code again. What if we move the removal of
> the xs from bond->ipsec from bond_ipsec_del_sa to bond_ipsec_free_sa?
> bond_ipsec_free_sa, unlike bond_ipsec_del_sa, is not called with x-
>> lock held. It is called from the xfrm gc task or directly via
> xfrm_state_put_sync and therefore wouldn't suffer from the locking
> issue.
> 
> The tricky part is to make sure that inactive bond->ipsec entries
> (after bond_ipsec_del_sa calls) do not cause issues if there's a
> migration (bond_ipsec_del_sa_all is called) happening before
> bond_ipsec_free_sa. Perhaps filtering by x->km.state != XFRM_STATE_DEAD
> in bond_ipsec_del_sa_all.
> 
> What do you think about this idea?
> 
> Cosmin.

I know the question was for Hangbin, but I do like this solution. I missed
the xdo_dev_state_free callback, it could lead to a much simpler solution
with some care.

Cheers,
 Nik


