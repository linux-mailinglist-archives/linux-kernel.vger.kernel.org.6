Return-Path: <linux-kernel+bounces-333384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724397C7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D9B2874F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253691990C6;
	Thu, 19 Sep 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOZRppXG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AD1862B5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740370; cv=none; b=c6uMMnL4PIZLgdjd7cqQhnUnRWk2Rx9aApGkYLhag2W/zWoco4no/H1qWQdbaGB+8hs/eulUGQMM7ZNu+Xta9dQLrRsVvxD/r9JVvlccwh3cm2InPP0OY/McZFPPZlW9j0JogFngsjY6nk6vXHueeboL1uw6zBIpL98Y5q785m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740370; c=relaxed/simple;
	bh=XCSshaxJzznqVzATTj4/9h1+YuItLrY1TyGGv+lOYiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nPrXEKiVfHN6yALGfzotnCWMqiBVt7UFWOFj5dO11JC0OXtccW/jjhC9tZ/jAkMtWR29JsLUZ7sFQqlxdLt8S/0/WaTQc8FThCY4xiROqoHqKFpYBeUQcwgiIA8rGb2xJcJCiLjP0PwIVL+8TfLoqnEVwSatXO5TJbrQsJ228i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOZRppXG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726740367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8sw9chzh6V0ldGfmUwBiAZ2jnRMPFw7mVDSc3g8Bgc=;
	b=hOZRppXG9tmrJQW+4jf8MbgAtTildR1aheXZOulgxFI0xI+bpNxLA/eoUyG7h0W5FZ5GX0
	q07/m80KyzQ2U9g4fhgnQub4kzEqonRFcGoUzsVomxn1r5TCxovkw4eEb1OGsXETg7oERS
	dTYAmkKAQqkORh3/vBqgPRloBVV0hug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-OXbF-IB7Oc-Kw1ROOZ_8Qg-1; Thu, 19 Sep 2024 06:06:06 -0400
X-MC-Unique: OXbF-IB7Oc-Kw1ROOZ_8Qg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cbcf60722so4731075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726740365; x=1727345165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8sw9chzh6V0ldGfmUwBiAZ2jnRMPFw7mVDSc3g8Bgc=;
        b=T5WUkRwtImf8xXPzHM3WKV7Xap6s1awVLI2yG8eMEjh3LHOC2L9RbnSgRu4ZS7QF3U
         6MUYod1kd1mIrO0fj12cltZGY/E9Zemyeo7Fv+ZwxZVj3NxGi7K6ooIQZf3ciopYQkr1
         Hp4mAW2Rhx2K0hovih4zlyLHJc5t3HY5h4EnVhcvZAMlKN7vho5RsLMmCXCqXsTkojDp
         uwlpw3Bh95/uP+auO+raTXxeNpGD9Vr4Gbq+HHHcTISuS1gOOwwyp0p+UMFgIq/3L9Iu
         7KouiM6LJl4rwQypNeCTDdFuFK1Gxt0/9vqErIzgBbThAETj4yljDKYe1UPk8l/ROZbN
         yT3A==
X-Forwarded-Encrypted: i=1; AJvYcCU6+wYesU8azeDv6gWtXPQMQtE7ACqkIKWo0tZ/JkXLASLeLfGx4HuiqmZwxS0HxsDK8jnB31IHNWTwLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74lEb27QuqZ3+p3gFFPPSF8VdrSzvyWb7pDIFDRHfwMtsu0/I
	ThNk0Wzya3sJup2K/tOpSQY6bDl9kGdMrVD1MrX7ld/GfYzyO8Fhap2paw4nP2sf2e1Vzwowc6V
	3Ttl2YV8fvZMy+octsYXiJEi+WtaQrEZYcScGXfDatuTO5O/D0KPK5Ft0wVaLPYOGePKqR8GxVh
	s=
X-Received: by 2002:a05:600c:45ce:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42cdb586d9fmr198605165e9.22.1726740364770;
        Thu, 19 Sep 2024 03:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCQb+yDIF3c7yHLOLlyuOP1obKRz9WHSVtK0x+cI/W3HDiqwFW29UxH0o8W4i4Ib8pkExQlw==
X-Received: by 2002:a05:600c:45ce:b0:428:18d9:9963 with SMTP id 5b1f17b1804b1-42cdb586d9fmr198604895e9.22.1726740364282;
        Thu, 19 Sep 2024 03:06:04 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754256c8sm17803525e9.14.2024.09.19.03.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 03:06:03 -0700 (PDT)
Message-ID: <49d32698-e226-46b5-bee8-46e9aad5754b@redhat.com>
Date: Thu, 19 Sep 2024 12:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net:ipv4:ip_route_input_slow: Change behaviour of
 routing decision when IP router alert option is present
To: Guy Avraham <guyavrah1986@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912141440.314005-1-guyavrah1986@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240912141440.314005-1-guyavrah1986@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/12/24 16:14, Guy Avraham wrote:
> When an IP packet with the IP router alert (RFC 2113) field arrives
> to some host who is not the destination of that packet (i.e - non of
> its interfaces is the address in the destination IP address field of that
> packet) and, for whatever reason, it does not have a route to this
> destination address, it drops this packet during the "routing decision"
> flow even though it should potentially pass it to the relevant
> application(s) that are interested in this packet's content - which happens
> in the "forwarding decision" flow. The suggested fix changes this behaviour
> by setting the ip_forward as the next "step" in the flow of the packet,
> just before it (previously was) is dropped, so that later the ip_forward,
> as usual, will pass it on to its relevant recipient (socket), by
> invoking the ip_call_ra_chain.
> 
> Signed-off-by: Guy Avraham <guyavrah1986@gmail.com>
> ---
> The fix was tested and verified on Linux hosts that act as routers in which
> there are kerenls 3.10 and 5.2. The verification was done by simulating
> a scenario in which an RSVP (RFC 2205) Path message (that has the IP
> router alert option set) arrives to a transit RSVP node, and this host
> passes on the RSVP Path message to the relevant socket (of the RSVP
> deamon) even though upon arrival of this packet it does NOT have route
> to the destination IP address of the IP packet (that encapsulates the
> RSVP Path message).
> 
>   net/ipv4/route.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 13c0f1d455f3..7c416eca84f8 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2360,8 +2360,12 @@ out:	return err;
>   
>   	RT_CACHE_STAT_INC(in_slow_tot);
>   	if (res->type == RTN_UNREACHABLE) {
> -		rth->dst.input= ip_error;
> -		rth->dst.error= -err;
> +		if (IPCB(skb)->opt.router_alert)
> +			rth->dst.input = ip_forward;
> +		else
> +			rth->dst.input = ip_error;
> +
> +		rth->dst.error = -err;
>   		rth->rt_flags	&= ~RTCF_LOCAL;
>   	}
>   

I think this is not the correct solution. At very least you should check 
the host is actually a router (forwarding is enabled) and someone has 
registered to receive router alerts. At that point you will be better 
off processing the router alert in place directly calling 
ip_call_ra_chain().

However I'm unsure all the above is actually required. It can be argued 
your host has a bad configuration.

If it's a AS border router, and there is no route for the destination, 
the packet not matching any route is invalid and should be indeed 
dropped/not processed.

Otherwise you should have/add a catch-up default route - at very least 
to handle this cases. If you really want to forward packets only to 
known destination, you could make such route as blackhole one.

Cheers,

Paolo


