Return-Path: <linux-kernel+bounces-287772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532A952C66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A912B1C203B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B017E44F;
	Thu, 15 Aug 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4Nsxl5B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E11714C4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716048; cv=none; b=Cu1E3Bu6aeOGGUTrt65rKcroqJXvGL4SY8Uy2zEeEUaehpY4SbjBNYR6LEIa+0lR/AC5DPg8o95ZmSIIGvzuzq3y/owOtt+MbGV/1WOiny4fyBAT89TAyWtgaFub9JnwBMuNNtUgTVaUu/6IGYO8LBgsV+j2gNkQ0CeSQz/ndDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716048; c=relaxed/simple;
	bh=5/CQNvLxQFoeAnRFoQafzP+JcE7z0R+s7OsIoIWaaeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHY3payYw3z2SXK5gzyLgGmoTyUyuQVUm5wIsxNEv9AVYy8KNAOUeHsNMucZC3FTkLa18xEpXkhaa3pq98SAJJG0jgowO4v++NdyBj0rdVczSsF4cidttE0C5T4XaY6OVr1Ihkv9SavWy4ufgx23vdoTuvCHHR2BnULHXHhiKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4Nsxl5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDb6GNX3vOwuU98VN/SEplLulkRUAIt+sW7YYE4YmTM=;
	b=f4Nsxl5BLuSgaXnnGzhLtFbnM9lnZj8z1RqYdW3l9iN6tUCsIUuKaTSpTdfzAxuMDR6JFB
	5w9MC37K4OvV7iOa3iMT3+3z744EPXtcb6VcT+oCihWfAF6wKWT7l71vy13fF1QxjXVT9Q
	S63g8jEwluqXokdPIh5eOttl/8r8l/w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-GaGPVc1UOcaslpnMzxj2rQ-1; Thu, 15 Aug 2024 06:00:44 -0400
X-MC-Unique: GaGPVc1UOcaslpnMzxj2rQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808f5d220so1180815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716043; x=1724320843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDb6GNX3vOwuU98VN/SEplLulkRUAIt+sW7YYE4YmTM=;
        b=LibgYwc50L3frIfOs8QxqXdZz6zrKoLgRipoK82CjwKV2qqDmRTUbeJjvSZQJU5TOX
         1GIXJPQ3kk6d1ZCtER1EvSVVizPLmBDw0RSE/0PUw5ZEYqEbR4OEjaMPoKfiAO1dFY+H
         HjJ6XVXTbGSpJvEb+6jvQY5rlK94IAmg2JIktPbginMiiiuTqultQRyRuE5CcmH3GSS9
         8qLTlL8jojHc5ifK1br0G41q7nRgndnOKue1v7/ncygRF0zY88gPRQVKKIJt5O0CPmPt
         26drUrAfr7zVY4KQfej7dwQRYb1cqU48aJztGuOYjGkHMiXRBAtFIOp9uWEMZNnjw+CH
         bTYA==
X-Forwarded-Encrypted: i=1; AJvYcCXmgVPsLX/xpRrILP3DsTGxyAZqSl72UVUm2/qLdI0CDzWcbAU3uMUAs6QvT06ryP2t38IcwWQu+9PoW24=@vger.kernel.org
X-Gm-Message-State: AOJu0YypRzf2Yopp4XE7sHzA2UZpQ+7I0i+WG/e1H4PcOSy4lUMQ30om
	a8Vrw/yvI+j0xPrNFEvIKVcEmjG9sepa6oM/IXywJztVhU9JphVM96/wtlSYjsctnoKpQh4os+c
	rIMBnzXBMEkPVuRqw/kEiH/8XZCZJlW1joUIGWpDfknx5JP70Ql1hlv8coQVh3Q==
X-Received: by 2002:a05:600c:1c23:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-429e0f5be95mr14363355e9.2.1723716042917;
        Thu, 15 Aug 2024 03:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfGyY9sJWRMdsj2O7AcKX5GLCUo+hMEsGgOfgNDPFXCG8fhKxt8YuNlc9i8Oi+q9lTCUs/w==
X-Received: by 2002:a05:600c:1c23:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-429e0f5be95mr14363135e9.2.1723716042423;
        Thu, 15 Aug 2024 03:00:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7ead3sm44363415e9.47.2024.08.15.03.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:00:41 -0700 (PDT)
Message-ID: <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
Date: Thu, 15 Aug 2024 12:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815084330.166987-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815084330.166987-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 10:43, sunyiqi wrote:
> When enters tcp_splice_read, tcp_splice_read will call lock_sock
> for sk in order to prevent other threads acquiring sk and release it
> before return.
> 
> But in while(tss.len) loop, it releases and re-locks sk, give the other
> thread a small window to lock the sk.
> 
> As a result, release/lock_sock in the while loop in tcp_splice_read may
> cause race condition.

Which race condition exactly? do you have a backtrace?

> 
> Fixes: 9c55e01c0cc8 ("[TCP]: Splice receive support.")
> Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
> ---
>   net/ipv4/tcp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..7a2ce0e2e5be 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -856,8 +856,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>   
>   		if (!tss.len || !timeo)
>   			break;
> -		release_sock(sk);
> -		lock_sock(sk);

This is needed to flush the sk backlog.

Somewhat related, I think we could replace the pair with sk_flush_backlog().

Thanks,

Paolo


