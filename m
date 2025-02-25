Return-Path: <linux-kernel+bounces-531169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF1A43D02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0AF173B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5AF264A99;
	Tue, 25 Feb 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="GhDBSjHS"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047E207DED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481531; cv=none; b=N5PFQfzwxUyVgGRnPfQybcypeiQL2r2WyFR7ebnl1FnsxIKzJqmAVDFVuWo05qztYL7UtqyMqJO1SPzvIxgR8Oe2O9qqdmBaTZoi359wKOni83oe9ZFdwJmDHDE/eoktljTOIOmqZi2w/Lo6yDQwyfUPhbalIwVRYF2KiY1Efag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481531; c=relaxed/simple;
	bh=aEXBdctr5lNL6y49esuCSJvaeiXkXyVBBu5rr2gf1mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIE8pQh0cF+QQ46yXlhfBJBjUIs1bmHrIFDxK8nn2pirZ3S4xyYEUwnj/hvdS5KhmOH8Dx2md4xA6soci786r8Eb9/WDvaMIsj0xXpHHAaEEtHWqc/QUofHZ3LXzY/uxokaptRbP5yk2ZeY/91C+IaKR+DHI+pFhutyR9L8AgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=GhDBSjHS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f504f087eso4287685f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740481528; x=1741086328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oijdNUsjFcALDUXEJZ3Jn2gl36QQtJ0DV7NEsfpNP/g=;
        b=GhDBSjHSCNCvn8PhfCXLlDQ+odAZA6EQrlW/wyslfhO1BhEIYRi95Q0pJM24xtU8Gr
         oKxu6k+wd+pLiUAagGoICEy0HMvf/1zXUOJgaPDfPD4oU8NRa72/2UMwGjPQz7lgIbON
         sN9BwFehjZRyqrQ7BOwPxHt5Ihdi6vFFySZ3TfkcDztcxWEpVqdznov39sSNa9boeDYy
         FwUUTf8XKdKGKkSEKe3HIU13hDeG3oB48r32R+WA/ujtwNJ9EPelDDHhxjvOIo5h1/2R
         8/mM8CUjHRE5pLRnD5KqxhZhxSUvN52PQAXrauMXHwaIP0lOszW78BeGQg14hY/TblWE
         Hufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481528; x=1741086328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oijdNUsjFcALDUXEJZ3Jn2gl36QQtJ0DV7NEsfpNP/g=;
        b=S3UL2QxnL2Yx21xwXOVi2nPzIK3NJoxWcRcWYm9v8KUzcrpqDs9J+Ig1dWuvQ6TJlP
         RQqd9Xm7F+40CAGhFw28Byesh7PWNn7bkeebfa99osiRmtltlNkydXbeeWVUkxYcoq1e
         pQV8Nkn71oJAckHnHvUEyQOCR3JmKgIcTEGs7osH80KpKYPBKTyskGvhaBNKocZwltou
         HpDvJja/kjBygXDQKf3aA71vGT/eic+Ij7jbxWInPbUGdeZeqQcOXxViLJ/ZQd69VyBc
         iGZl3c08qUKYnQs+9rdXuvH9p577AziJWGVyjhs5rthVg/dDE49cRrrpLEaOpCFk1brM
         JruA==
X-Forwarded-Encrypted: i=1; AJvYcCX6Sf1EUa9JHU7Bw6pv+jKzAWrusOgiJDNaM/eCv5tBWYaZVCCDOHz9cqPxLap5Msyy68ZTc/bRrjBXaWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMj7NEQGWGbXSQhJXzxFA0FTQ+hMqf3Uk0dL6wKBJTooJ9Nde
	agUTWx+28EsI/m/EbxxIBGf34n0b0KvgI8+GuJpX2f2LqLdBkbTP0GArJvcI6IgORv0A+AW148X
	7EXY=
X-Gm-Gg: ASbGncuddaCI3iEaFMGk27A+zLQ2N0iQ4PhF5W1QTEtQG5aubx0GhDJ3Cmc4bBQglrL
	UWSvOiiFHwKxupdySC5ZNRCpJV/0JpCgtk1qvaWZr7293xdg262fbJFJD7fParQ70PajijQ3qaS
	/Iiq2RaQ8nZRUuN1zQKC/MQh2JSUYC7tq9FuLWaWphIZZCKmARACjVJUZiHhXIuCB1VtijdMm7N
	/XeqLRZnV/VYvrRBZrOFNMe7bbryi2uww5PQ5R7d1tilqxG7IXyHqksZKtXVw9P7HtDPYmzVFaC
	KBs0lZq97iX6lJnYOuq6x5Wikh3D8NtBYgLw25PyU0zpPRsF6ZBzlGB0kQ==
X-Google-Smtp-Source: AGHT+IG2xH9B5u1dDk4QWKBV/GBsT+RYSX6ctwfXsQLP5EsocYKyv24QKv5mom87WEbHTozESZO4yg==
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id ffacd0b85a97d-38f6e95d5famr14803550f8f.21.1740481527619;
        Tue, 25 Feb 2025 03:05:27 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fc1f9sm1840718f8f.88.2025.02.25.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:05:27 -0800 (PST)
Message-ID: <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>
Date: Tue, 25 Feb 2025 13:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225094049.20142-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 11:40, Hangbin Liu wrote:
> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> a warning like:
> 
> BUG: sleeping function called from invalid context at...
> 
> Fix this by moving the mutex_lock() operation to a work queue.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 41 +++++++++++++++++++++++++--------
>  include/net/bonding.h           |  6 +++++
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 

Hi,
I think there are a few issues with this solution, comments below.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..cc7064aa4b35 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -551,6 +551,25 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	mutex_unlock(&bond->ipsec_lock);
>  }
>  
> +static void bond_xfrm_state_gc_work(struct work_struct *work)
> +{
> +	struct bond_xfrm_work *xfrm_work = container_of(work, struct bond_xfrm_work, work);
> +	struct bonding *bond = xfrm_work->bond;
> +	struct xfrm_state *xs = xfrm_work->xs;
> +	struct bond_ipsec *ipsec;
> +
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			xfrm_state_put(xs);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
> +}
> +
>  /**
>   * bond_ipsec_del_sa - clear out this specific SA
>   * @xs: pointer to transformer state struct
> @@ -558,9 +577,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  {
>  	struct net_device *bond_dev = xs->xso.dev;
> +	struct bond_xfrm_work *xfrm_work;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> -	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (ipsec->xs == xs) {
> -			list_del(&ipsec->list);
> -			kfree(ipsec);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&bond->ipsec_lock);
> +
> +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
> +	if (!xfrm_work)
> +		return;
> +

What happens if this allocation fails? I think you'll leak memory and
potentially call the xdo_dev callbacks for this xs again because it's
still in the list. Also this xfrm_work memory doesn't get freed anywhere, so
you're leaking it as well.

Perhaps you can do this allocation in add_sa, it seems you can sleep
there and potentially return an error if it fails, so this can never
fail later. You'll have to be careful with the freeing dance though.
Alternatively, make the work a part of struct bond so it doesn't need
memory management, but then you need a mechanism to queue these items (e.g.
a separate list with a spinlock) and would have more complexity with freeing
in parallel.

> +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
> +	xfrm_work->bond = bond;
> +	xfrm_work->xs = xs;
> +	xfrm_state_hold(xs);
> +
> +	queue_work(bond->wq, &xfrm_work->work);

Note that nothing waits for this work anywhere and .ndo_uninit runs before
bond's .priv_destructor which means ipsec_lock will be destroyed and will be
used afterwards when destroying bond->wq from the destructor if there were
any queued works.

[snip]

Cheers,
 Nik


