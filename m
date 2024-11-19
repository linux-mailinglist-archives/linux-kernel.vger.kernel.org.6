Return-Path: <linux-kernel+bounces-414144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797009D23B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05274B226A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F721C2301;
	Tue, 19 Nov 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr6etpSJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B714AD1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012956; cv=none; b=XRg/sWkTX96oFn9OZitZmbfjoB1QR73wDjz369h+0WhROcho7NVgUY3zbo5I5GUBrn4yxNWrs0EOOnNbfdwSPI/mgyypZPOv4Px5GtT47MlbVAv0ymCOtpphw6laKnI0jKi6gLbnmU5u3LKAuGSs7vGx1vphuf1x7+Rr26zwAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012956; c=relaxed/simple;
	bh=ewe+cfyQwD7+rJCJr16o7cmU5gq054F741Kf/9i6o6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNF5I4QKtvdT3xddSs/aibM+GNvvf3llP4i36N8Zcb5fKJhcdE/6ElMrjSLuJ+L7GtObacUcf6/ILmdqBqUOxR8Kd2QG4L7YiD7+PwRatFpwSoIaktDg5oSljasYC1hyHJpUadEMCy5pwXS7sI/0yReOuO2nJYRWAICCOq3U7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr6etpSJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732012953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOP/RMPMxHHNNNBECV4o0kJqqFs4JqBWrC0Coyjk7xQ=;
	b=fr6etpSJuwv50jN9otYjeVvp3RYZ2IcdngI1lOcfC/xilmFeOJJ4j/qASYcFE+b0Ke3sRb
	+IHbQb6adXosdPC7N1wlGkYxbGVuDIGowazN4B731SNbVeiJvgpLmEvsxxuIybYzviPbiQ
	fjxxB8EFsD+JNVOA8qpLNc/pTr00Oso=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-lzMisnI9OdGEwtteni_h0A-1; Tue, 19 Nov 2024 05:42:29 -0500
X-MC-Unique: lzMisnI9OdGEwtteni_h0A-1
X-Mimecast-MFC-AGG-ID: lzMisnI9OdGEwtteni_h0A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43157e3521dso22191655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012948; x=1732617748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOP/RMPMxHHNNNBECV4o0kJqqFs4JqBWrC0Coyjk7xQ=;
        b=L7C1wN+HqjYh6dXn2azvypTjeYBeAToGnFYuujYVwuN8Nccx4T+GFg7qBze3MTCSbP
         5lJOsxE2Mt2+wfQ8rRUgoIiOpfd52KqqvoR2emkg1HhcjFE3x0I0T1uXhYj+9vT6biXc
         R/hFgacHQw7OXgY72rasaaMdPnkaL74gCTBGDTIb9LWa5w+KJvbDwdnVzu3MTTP7F1OD
         lZkVA9Cs4E9OP9dw4QzCkC9yIPGXr/cUtkyt549sTjfeZYczzkZZAISpVpoJLKQjV/on
         iBAb8kmvU4aAq/d1jU1Q0iRltiCzdqEAm+qLCZa+qwwiUO60yfVVgMIKKbYIEiEsxQPU
         XGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2YIQ0GxSxRfZtEjDQJ6H/8gaRPupNgp7e8BUwYBuQdJxwpLpUAcgM2nopCv6v77U6MtHck+NsH6Vny0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaR6qQe8U5fP6rxXWhCFKYlcIGIue9kAfZtyoTv6isUF8jSqL0
	Lic2/8xDOTjgOzs754Fdqwe3uy4zNo2LAOaLZq4koJ9fbvjWlRwUci/r7Cnm8T1yN3fSNNSKORR
	8/0C1S5xQlI9Hg7BT6wzoJyVWgG7SMpHiAwbwcSMOX+d8kZV0RY0vmeFh7TbsjQ==
X-Received: by 2002:a05:600c:c08:b0:432:7c08:d121 with SMTP id 5b1f17b1804b1-432df741a8bmr145799355e9.12.1732012948091;
        Tue, 19 Nov 2024 02:42:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfHJlIc9PLE+unJO/W7yCVBm8wQp3FJKAGZyEH5HxokmBA6R2bJgaIEHsgK1DXLxfEtANLnA==
X-Received: by 2002:a05:600c:c08:b0:432:7c08:d121 with SMTP id 5b1f17b1804b1-432df741a8bmr145799185e9.12.1732012947777;
        Tue, 19 Nov 2024 02:42:27 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da299dadsm189813325e9.43.2024.11.19.02.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:42:27 -0800 (PST)
Message-ID: <82c02bbc-5d64-464d-83c1-66f1d71a1a44@redhat.com>
Date: Tue, 19 Nov 2024 11:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/4] net: ipv6: ioam6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241118131502.10077-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 14:15, Justin Iurman wrote:
> @@ -387,45 +392,40 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  		goto drop;
>  	}
>  
> -	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> -	if (unlikely(err))
> -		goto drop;
> +	if (unlikely(!dst)) {
> +		struct ipv6hdr *hdr = ipv6_hdr(skb);
> +		struct flowi6 fl6;
> +
> +		memset(&fl6, 0, sizeof(fl6));
> +		fl6.daddr = hdr->daddr;
> +		fl6.saddr = hdr->saddr;
> +		fl6.flowlabel = ip6_flowinfo(hdr);
> +		fl6.flowi6_mark = skb->mark;
> +		fl6.flowi6_proto = hdr->nexthdr;
> +
> +		dst = ip6_route_output(net, NULL, &fl6);
> +		if (dst->error) {
> +			err = dst->error;
> +			dst_release(dst);
> +			goto drop;
> +		}
>  
> -	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
>  		local_bh_disable();
> -		dst = dst_cache_get(&ilwt->cache);
> +		dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
>  		local_bh_enable();
>  
> -		if (unlikely(!dst)) {
> -			struct ipv6hdr *hdr = ipv6_hdr(skb);
> -			struct flowi6 fl6;
> -
> -			memset(&fl6, 0, sizeof(fl6));
> -			fl6.daddr = hdr->daddr;
> -			fl6.saddr = hdr->saddr;
> -			fl6.flowlabel = ip6_flowinfo(hdr);
> -			fl6.flowi6_mark = skb->mark;
> -			fl6.flowi6_proto = hdr->nexthdr;
> -
> -			dst = ip6_route_output(net, NULL, &fl6);
> -			if (dst->error) {
> -				err = dst->error;
> -				dst_release(dst);
> -				goto drop;
> -			}
> -
> -			local_bh_disable();
> -			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
> -			local_bh_enable();
> -		}
> +		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
> +		if (unlikely(err))
> +			goto drop;
> +	}
>  
> -		skb_dst_drop(skb);
> -		skb_dst_set(skb, dst);
> +	skb_dst_drop(skb);
> +	skb_dst_set(skb, dst);

Why the above 2 statements are not done only in case of ip address
match, as in the existing code?

>  
> +	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr))
>  		return dst_output(net, sk, skb);
> -	}


Thanks,

Paolo


