Return-Path: <linux-kernel+bounces-288250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE669537E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031731F253E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE461B29B9;
	Thu, 15 Aug 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9JtHuXL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC771AED29
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738050; cv=none; b=TBFQK+/dRD/A9aVnJm2dOzw1AyZIJBx4AGCtLiTX6lEVfw8uUaGgNWCC8SYUB4JGAxAsUIRD59L1FVe3NLQIMRxlFmoTtlwVgxh4C9nsJzyba1/VW/Nzg0LLOO51EYkNr74O1MRlwNR7E/N1yGDoRUvsk9rOx+iNxxgZLkJtums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738050; c=relaxed/simple;
	bh=wivKBbq7m6MnAo1S63dqLIlcOVpSTV0vtYnRO43Lv2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNW162gNOEeR9gWwH4sgrVj5QXxd928ZZWui92lrh1+O080CX7UQluObvNZaD5df4MmdSGz+e5JINCFmiYz0uWPxUcIz6HH7C/Hz1AAkTC+r60MQC+RRRTxhLaXVbRfEo7SOuDj6Uc9LJa4BRQQqdNJ00tqG6rVSXE+nJmw1JJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9JtHuXL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723738047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ses1uKixdgQtNiGimjb1zDfrKwz9AjSaL3ncN3fkUhg=;
	b=c9JtHuXLUu5CIVO/14MxuQe8sfPPJAOtT2uB+ch9VXrXIxkJHYgvZ2uwDHWac+1IiZzZiT
	fGNgcu4srt+kqfrioNNBgmArvmm30ycuUb1Vyd1BpP/n5OzMvyjGzYn1SU8oHucBpgLKG8
	wUjNf8+ybw+muwCuEvPgucn2xdHe+UU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-v21fe-QKPXOyzfafxpIBGA-1; Thu, 15 Aug 2024 12:07:24 -0400
X-MC-Unique: v21fe-QKPXOyzfafxpIBGA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b1fe1cd9eso214088a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738043; x=1724342843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ses1uKixdgQtNiGimjb1zDfrKwz9AjSaL3ncN3fkUhg=;
        b=khj7sKS1YDy3Yd6jV9cuJmdyqCJ/gHuIdEugzdOUZz374cJjnf1WKRajExoaYpEi+5
         SD3Kct37LpbzrlBdAEZtfbGud2HZviPwscYEly5cUbSUv///lSToNm15VMdJRYosP5CW
         mA9UwDtFtmlYwbyfXMcfZ9xrj22XNbwofGwQhlpJktqY79wj6ZjinhQQ91qoDrg28rEK
         J/QMZ19GAy63zTDhh9KS1RUlaFjTwHS90hTXBciTe0SaqJfkeK4f9dZl6YBIb563wWyS
         TETYprwYAJtMEXKaT3YIGJi+rsgLeeE5hBjfdpOX0Y78iw14Vgh8aDqJNB1ZLsU5uUN6
         gxvA==
X-Forwarded-Encrypted: i=1; AJvYcCX9hJZPQ6U0sZVBdkv9YjaId279XZA1VftOiKFJ8heT4UiGYIKQYb6Tkd8s4RpCZkicfmcNNXGXXSNW/JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfp2Fx+5i3uicCU5YY0NNC0A2P1W9LvWYcL6OR1WavKACj/xPs
	opG4DP6ACYAh75qXwMTOcAGDBxsPBzhq7KH2fzdn2bAC7iz+kn0GwxkKu9Mk/mnKeLwst0R1rLu
	qpxy2fGw6m3dteC9LkI1ri2H+Chk6tre5QCFud1bA45jiW+1wRUOyUWu/PiW2QQ+zEl5A1q86
X-Received: by 2002:a17:907:2d29:b0:a7a:9447:3e88 with SMTP id a640c23a62f3a-a8392a85220mr2355166b.10.1723738043253;
        Thu, 15 Aug 2024 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7q3BOKq5iuA0sBzogi6xCRY8dbXTnDTQZ96ReIyWABx/p+JfoG0hGKHqXxkfavnSj9ljL5Q==
X-Received: by 2002:a17:907:2d29:b0:a7a:9447:3e88 with SMTP id a640c23a62f3a-a8392a85220mr2353366b.10.1723738042637;
        Thu, 15 Aug 2024 09:07:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010::f71? ([2a0d:3344:1711:4010::f71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c682sm119943766b.196.2024.08.15.09.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:07:22 -0700 (PDT)
Message-ID: <2cf128ed-cd74-4025-8ae8-28934abbf25a@redhat.com>
Date: Thu, 15 Aug 2024 18:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
References: <20240809161935.3129104-1-leitao@debian.org>
 <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
 <ZruChcqv1kdTdFtE@gmail.com>
 <2e63b0aa-5394-4a4b-ab7f-0550a5faa342@redhat.com>
 <Zr4GxjRf5la7wBXM@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zr4GxjRf5la7wBXM@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 15:46, Breno Leitao wrote:
> On Wed, Aug 14, 2024 at 12:06:48PM +0200, Paolo Abeni wrote:
>> I fear the late cleanup could still be dangerous - what if multiple,
>> consecutive, enabled_store() on the same target fails?
>>
>> I *think* it would be safer always zeroing np->dev in the error path of
>> netpoll_setup().
>>
>> It could be a separate patch for bisectability.
>>
>> Side note: I additionally think that in the same error path we should
>> conditionally clear np->local_ip.ip, if the previous code initialized such
>> field, or we could get weird results if e.g.
>> - a target uses eth0 with local_ip == 0
>> - enabled_store() of such target fails e.g. due ndo_netpoll_setup() failure
>> - address on eth0 changes for some reason
>> - anoter enabled_store() is issued on the same target.
>>
>> At this point the netpoll target should be wrongly using the old address.
> 
> Agree with you. I think we always want to keep struct netpoll objects
> either initialized or unitialized, not keeping them half-baked.
> 
> How about the following patch:

Overall LGTM, a couple of minor comments below.

>      netpoll: Ensure clean state on setup failures
>      
>      Modify netpoll_setup() and __netpoll_setup() to ensure that the netpoll
>      structure (np) is left in a clean state if setup fails for any reason.
>      This prevents carrying over misconfigured fields in case of partial
>      setup success.
>      
>      Key changes:
>      - np->dev is now set only after successful setup, ensuring it's always
>        NULL if netpoll is not configured or if netpoll_setup() fails.
>      - np->local_ip is zeroed if netpoll setup doesn't complete successfully.
>      - Added DEBUG_NET_WARN_ON_ONCE() checks to catch unexpected states.
>      
>      These changes improve the reliability of netpoll configuration, since it
>      assures that the structure is fully initialized or totally unset.
>      
>      Suggested-by: Paolo Abeni <pabeni@redhat.com>
>      Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index a58ea724790c..348d76a51c20 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -626,12 +626,10 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>   	const struct net_device_ops *ops;
>   	int err;
>   
> -	np->dev = ndev;
> -	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
> -
> +	DEBUG_NET_WARN_ON_ONCE(np->dev);
>   	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
>   		np_err(np, "%s doesn't support polling, aborting\n",
> -		       np->dev_name);
> +		       ndev->name);
>   		err = -ENOTSUPP;
>   		goto out;
>   	}
> @@ -649,7 +647,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>   
>   		refcount_set(&npinfo->refcnt, 1);
>   
> -		ops = np->dev->netdev_ops;
> +		ops = ndev->netdev_ops;
>   		if (ops->ndo_netpoll_setup) {
>   			err = ops->ndo_netpoll_setup(ndev, npinfo);
>   			if (err)
> @@ -660,6 +658,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>   		refcount_inc(&npinfo->refcnt);
>   	}
>   
> +	np->dev = ndev;
> +	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
>   	npinfo->netpoll = np;
>   
>   	/* last thing to do is link it to the net device structure */
> @@ -681,6 +681,7 @@ int netpoll_setup(struct netpoll *np)
>   	int err;
>   
>   	rtnl_lock();
> +	DEBUG_NET_WARN_ON_ONCE(np->dev);

This looks redundant

>   	if (np->dev_name[0]) {
>   		struct net *net = current->nsproxy->net_ns;
>   		ndev = __dev_get_by_name(net, np->dev_name);
> @@ -782,11 +783,14 @@ int netpoll_setup(struct netpoll *np)
>   
>   	err = __netpoll_setup(np, ndev);
>   	if (err)
> -		goto put;
> +		goto clear_ip;
>   	rtnl_unlock();
>   	return 0;
>   
> +clear_ip:
> +	memset(&np->local_ip, 0, sizeof(np->local_ip));

I think it would be better to clear the local_ip only if np->local_ip 
was set/initialized/filled by netpoll_setup() otherwise the sysfs 
contents could suddenly/unexpetedly change on failure.

Thanks,

Paolo


