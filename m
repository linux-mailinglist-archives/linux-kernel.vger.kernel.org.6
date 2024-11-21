Return-Path: <linux-kernel+bounces-417479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F59D5492
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2E91F22D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E41CD1EE;
	Thu, 21 Nov 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Pq8MKWNY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19D199FC9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223805; cv=none; b=ugA2Hzstb0/AQqqtvLWygu1fqHiJrMExd29VTQ3kJV3ZhPPCtNMnaP2JnRPrOFMgHkwUMXNXe4wA8nJ5jETiKN9ExyXVdfyIW1R3zHwvyccyu8XN2r1vbSrHiX8iIr+hfHECVbZ/+j2Tm+0HrwgQcblrUjCfy67RPFf/2QuU1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223805; c=relaxed/simple;
	bh=Vkpe9SiYwYEfwd2jAqagSpsgL2Q7SeaVN0WSbS/uiV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6W1NjfhRnTSM7r7E5MNaI9e8FKZ6kbUFEkcAJfAcnMq5RkPCMNJgbUTBrkq9IJY1R1XP55HJays1/4tzr/0Ks5hG9e1GV84gqXJRJO6A3nCLhDNHVuaiGq3YE1l4lChsSP4w+WSNpgA/t/IEXYDoSFV/lhsTg14WN7DIEncTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Pq8MKWNY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a850270e2so270028666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732223801; x=1732828601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADSLCsVi1Tznb0EIsL+X0OVrkFRGd+TpY9WIHeu9ve0=;
        b=Pq8MKWNYvdQIhqxYq8pOKtjBytNGMdPekxWhE/C/nAwknp9eYlFcRJ9HeguJbd01yo
         5OmcXtjk4xoU7rHUwoCybr1b17C48RzsXli4LlhpeJrKh792FzkeTVHEqaFvensmHGJb
         vj+nyVFJnYvP35KGhkhzqNM3WAQuiKnls07WfECsQFNzgyFGTeatO4BOlbZfbyOQI2HY
         luXTP4NRrBrDNwEG5oX8f6E9pBhyZPtKTbRfXYUPsZFbhfvUTGviBb/wi2SgQuQDJek4
         lzsa8BYUW5am0ZtgoL4wrTEXZo+fWvtyU7AfQL00wmem2yDKNg0+JFJj1RT6kIXnw3xf
         lbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732223801; x=1732828601;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADSLCsVi1Tznb0EIsL+X0OVrkFRGd+TpY9WIHeu9ve0=;
        b=D3xqIwWrDLjV85pruJovxj4ifDHOIENUulwqcyG96f5toH+fcDiM8vGWV9pvqXX9WR
         q+RfcCcix8y7KXuXlDTk0GibIszWHAnvGy+FJZsyc1PdOdpY0EjbG4pgBaSSs/o9Fx1w
         IFPWlh8kVDtIXkbl9HLdZNR9XD8XunCyudjYY/2fbjrxhxH97QwvunBCvZnxuhvdMd8L
         XdtRu3xU/e9hiJL5Bt1Da9kelnvFpVy71QZII/hTdEMbv/m9ulEWMijZkGtbTEaAq8al
         UtCLxYSkeqLYoRVwF76uQF93y0MFHhV5Wsnwg8n/MjfJuMhWDRLEoc/V0ZLSD6E40F1v
         wzzg==
X-Forwarded-Encrypted: i=1; AJvYcCV0bgGfjOnldejoZExMPhQRl8T3iRL6Up010V1cs5ICx1tHc2IdzlNv2wxttukzDufDN7odI6Nnj7akEks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8AES+VdxIqPEZIDVzmhojZOqrttAx0wf88SQEKUARyhhQQnl
	BtlmUDdW10Q8uxnqrLZnHjp9L+XBpllAMPevU0Y98JY0vydiTZK3t9ubXGC23Xo=
X-Gm-Gg: ASbGncuJKOHJUoXj25sOeRhj6lUTfIF4apspN3npcF8JBdNq5Di5zosf5uwzqAQFiQl
	b3h+uKKI6ATn8a2aHob6OhRRVWsFlHCujcBGXfBJuJHbFEvUXfK2mjQbb7zz1tpHYgjtUOpW16C
	ctPmtCTGAgfFjjn2zaDrKpgfU9e4k+G9eNISyDA9xhan6J7hI5JG6ZcFbIApnKSnTqo10eP23LV
	mFMBn0K4NHKHNof2pUBVja9uNmu48bdhAygwd6Mb/XCQSeV+7WOeOeOZCPsmTaKuRhUqd+qWfRe
	2ohq23EqQQ==
X-Google-Smtp-Source: AGHT+IFYIEgIv1nc2MpvgqvQW89q6p0R6+ss6JlPvxYa0sC6IXhy8g7BLk1uIpGhOW4wVc3nHcwe/w==
X-Received: by 2002:a17:907:84c2:b0:a99:f675:b672 with SMTP id a640c23a62f3a-aa50997f07amr43234166b.29.1732223801292;
        Thu, 21 Nov 2024 13:16:41 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b842csm14640866b.194.2024.11.21.13.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:16:40 -0800 (PST)
Message-ID: <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
Date: Thu, 21 Nov 2024 22:17:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
 <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/11/2024 23:56, Sergey Ryazanov wrote:
> On 15.11.2024 16:13, Antonio Quartulli wrote:
>> On 09/11/2024 02:11, Sergey Ryazanov wrote:
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>> An ovpn interface will keep carrier always on and let the user
>>>> decide when an interface should be considered disconnected.
>>>>
>>>> This way, even if an ovpn interface is not connected to any peer,
>>>> it can still retain all IPs and routes and thus prevent any data
>>>> leak.
>>>>
>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>> ---
>>>>   drivers/net/ovpn/main.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>> index 
>>>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>>>> --- a/drivers/net/ovpn/main.c
>>>> +++ b/drivers/net/ovpn/main.c
>>>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
>>>>   static int ovpn_net_open(struct net_device *dev)
>>>>   {
>>>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>>>> +     * configuration upon disconnection. This way it can prevent leaks
>>>> +     * of traffic outside of the VPN tunnel.
>>>> +     * The user may override this behaviour by tearing down the 
>>>> interface
>>>> +     * manually.
>>>> +     */
>>>> +    netif_carrier_on(dev);
>>>
>>> If a user cares about the traffic leaking, then he can create a 
>>> blackhole route with huge metric:
>>>
>>> # ip route add blackhole default metric 10000
>>>
>>> Why the network interface should implicitly provide this 
>>> functionality? And on another hand, how a routing daemon can learn a 
>>> topology change without indication from the interface?
>>
>> This was discussed loooong ago with Andrew. Here my last response:
>>
>> https://lore.kernel.org/all/d896bbd8-2709-4834-a637- 
>> f982fc51fc57@openvpn.net/
> 
> Thank you for sharing the link to the beginning of the conversation. 
> Till the moment we have 3 topics regarding the operational state 
> indication:
> 1. possible absence of a conception of running state,
> 2. influence on routing protocol implementations,
> 3. traffic leaking.
> 
> As for conception of the running state, it should exists for tunneling 
> protocols with a state tracking. In this specific case, we can assume 
> interface running when it has configured peer with keys. The protocol 
> even has nice feature for the connection monitoring - keepalive.

What about a device in MP mode? It doesn't make sense to turn the 
carrier off when the MP node has no peers connected.
At the same time I don't like having P2P and MP devices behaving 
differently in this regard.
Therefore keeping the carrier on seemed the most logical way forward (at 
least for now - we can still come back to this once we have something 
smarter to implement).

> 
> Routing protocols on one hand could benefit from the operational state 
> indication. On another hand, hello/hold timer values mentioned in the 
> documentation are comparable with default routing protocols timers. So, 
> actual improvement is debatable.
> 
> Regarding the traffic leading, as I mentioned before, the blackhole 
> route or a firewall rule works better then implicit blackholing with a 
> non-running interface.
> 
> Long story short, I agree that we might not need a real operational 
> state indication now. Still protecting from a traffic leaking is not 
> good enough justification.

Well, it's the so called "persistent interface" concept in VPNs: leave 
everything as is, even if the connection is lost.
I know it can be implemented in many other different ways..but I don't 
see a real problem with keeping this way.

A blackhole/firewall can still be added if the user prefers (and not use 
the persistent interface).

Regards,

> 
> Andrew, what do you think? Is the traffic leaking prevention any good 
> justification or it needs to be updated?
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


