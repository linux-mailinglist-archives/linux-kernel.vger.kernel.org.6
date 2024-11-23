Return-Path: <linux-kernel+bounces-419296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F29D6BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EFB161ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94081AB500;
	Sat, 23 Nov 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GOhaNMa2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E219B3E2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732402351; cv=none; b=tWHwbKnVbYyIQP6IDl3GujpRKIaP9Ykh8wsjvOzEfLmN/zrMBN0pomPesasqTLJbSC4/3HcfFPH0YWg/ZNeJP+dQQRUPDpKR4JLLx7mIc9BBe/C3EF8WYmDISMg2kfit9L2tfpobxxk0nCSET2aXI+ez4ioNDkTYlp/pkVbfm4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732402351; c=relaxed/simple;
	bh=p7MNL6jHpcuyZWGLrv3Z1MDrEieaZfIQ46HRxJh697w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0xfmpXU0hIB2idGMyK2C0Wz8nqxwNuXBPSiDIhD2kkZMFEn1rLCJPT75V/afMDr5SJLTNEOhKBsHJmGBkw3xxjaavFNSVCqQqU7XqhRB0E47149OQWnYhtFAiN+b59dWlFTYN4r/ockz1sY4/Yvzjk8+uOUsacTvqA926pCP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GOhaNMa2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315eac969aso17990225e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 14:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732402346; x=1733007146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WvDNxvRaOiW7T1LuR+Csr/bQz5Vx+iz53NLwjHy84wI=;
        b=GOhaNMa2vOUOBM4cEJBM4QxQlCr/5TLvmZOXj8oBAbjk2gxp6ld2bZ0TVztK36uNJ9
         t1KU2UkEVmic5+BaSDElcyAFMTjrUVSYRP34AdO6U3gfm5+Pm/BLv7ZEeqVkENk7Qm6Q
         rfyVAWjnIb8T+rt1GwJBF1e8w3URCYLXwajihRMK4Hxt6rxCbVYAL3+30n3FC41AK2AF
         w1+NGpG2gG/YMORtsR9swtJb9cMccPnx5bdKD9UURmt6EdXd4S1pCrqxJOHSofaXdugE
         7Y+uiWUqaM6mtT5ZLqV8Oo0FJGFijd2x34Vir6sf2tUQykwnheDx6GoAjnnuQ7R2kPKA
         Y4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732402346; x=1733007146;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvDNxvRaOiW7T1LuR+Csr/bQz5Vx+iz53NLwjHy84wI=;
        b=MzjmORlzPW/ZmnA9ThMxTQxtt7GwtorC2TcO4J84ZAdXO+Fel+iSKGTswcI4JQQrYJ
         brulpywW6OK8fRxLrDFl5i6zsEo1n4aYlOti2c5GK/0vMaTSwBN51AoiQ+lf2O3LLLLT
         ZbXdpybtko7DstDORzopZyWpeqRxWF3ub7pL86pAuESSknSP8JISIzoTFRS/0J1Vu+ol
         4nX/uYh6fNEj8yVBN1p3VCSEjpZhLF3Ue6IMctDigju7OeNX3Y2iopjFr3QQ9NeyLrQg
         0bV8mjvJ1VCsPIhJ/oiNUo9ZV1WTmfXQkIcCaJQ220KU2Tc35d3bORLzhtuewTF1rjqS
         9tmA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJl8THtVGqBeCPoSMDnU9lVojWHVVAEvqNw5gq0GyRtUKfIvcuDp0qD+8ts2jB3I4jLbQwOf91qEvsJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6UQWjWt6k+StjdPZbrFmfT8cYJ1jLjbuaoD0fReDucuFFBOjv
	gvXcfgOTH9g3aEhiDkb101AHPHZFHOuVKU3Ybu+TlgAs3J03ZUZaC6/NOp6tNNw=
X-Gm-Gg: ASbGncsDsAtZiztxnyxxZmCctwdgnyTkRQwxylP333GjedsKkezjai77CPYuaR39yOg
	uqHp4uIQc+drnqRvT9Ze02qHTmbldtZRxzcMRRSF/0VZfX8Lm+/e4G8S1NT4Rai5J6O9oOZRQwM
	J6qbA8PQ0u7dt6CSBZtRPjBLGnUw5Bp/IbOJwiA+Rv6/+priu8j2kBe+ZtqTU5q2NLHCQoIoHQF
	oixmEmiPaopHjcAp2w430gVBERKKvsYytNg9cKXCx38zLDOa4magCE6xqVCQbbgDt3C1amHeAMQ
	nrupcSvIYNMZ
X-Google-Smtp-Source: AGHT+IHZhT3iHQCXJ0WEd9bgGVULidIeHpvRqU589plXhJqUJCgaEmukWn+aX9MlMeLK3iTsbr0cvw==
X-Received: by 2002:a7b:cb4e:0:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-433c5c8895amr104872065e9.3.1732402345751;
        Sat, 23 Nov 2024 14:52:25 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:bc8e:433b:87c2:d22e? ([2001:67c:2fbc:1:bc8e:433b:87c2:d22e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde9800fsm73761805e9.40.2024.11.23.14.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 14:52:24 -0800 (PST)
Message-ID: <c9185b5b-942d-4927-8171-f3460619aed1@openvpn.net>
Date: Sat, 23 Nov 2024 23:52:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
 <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
 <89ae26a2-0a09-4758-989e-8f45a707a41b@openvpn.net>
 <e2caab8a-343e-4728-b5a7-b167f05c9bb9@gmail.com>
 <c933e2bf-b19c-4f8b-b2c0-44de50eb4141@openvpn.net>
 <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <1cf97615-a38d-48c3-9e23-4ba82012b32d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/11/2024 23:25, Sergey Ryazanov wrote:
> On 21.11.2024 23:17, Antonio Quartulli wrote:
>> On 20/11/2024 23:56, Sergey Ryazanov wrote:
>>> On 15.11.2024 16:13, Antonio Quartulli wrote:
>>>> On 09/11/2024 02:11, Sergey Ryazanov wrote:
>>>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>>>> An ovpn interface will keep carrier always on and let the user
>>>>>> decide when an interface should be considered disconnected.
>>>>>>
>>>>>> This way, even if an ovpn interface is not connected to any peer,
>>>>>> it can still retain all IPs and routes and thus prevent any data
>>>>>> leak.
>>>>>>
>>>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>>> ---
>>>>>>   drivers/net/ovpn/main.c | 7 +++++++
>>>>>>   1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>>>> index 
>>>>>> eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
>>>>>> --- a/drivers/net/ovpn/main.c
>>>>>> +++ b/drivers/net/ovpn/main.c
>>>>>> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device 
>>>>>> *net)
>>>>>>   static int ovpn_net_open(struct net_device *dev)
>>>>>>   {
>>>>>> +    /* ovpn keeps the carrier always on to avoid losing IP or route
>>>>>> +     * configuration upon disconnection. This way it can prevent 
>>>>>> leaks
>>>>>> +     * of traffic outside of the VPN tunnel.
>>>>>> +     * The user may override this behaviour by tearing down the 
>>>>>> interface
>>>>>> +     * manually.
>>>>>> +     */
>>>>>> +    netif_carrier_on(dev);
>>>>>
>>>>> If a user cares about the traffic leaking, then he can create a 
>>>>> blackhole route with huge metric:
>>>>>
>>>>> # ip route add blackhole default metric 10000
>>>>>
>>>>> Why the network interface should implicitly provide this 
>>>>> functionality? And on another hand, how a routing daemon can learn 
>>>>> a topology change without indication from the interface?
>>>>
>>>> This was discussed loooong ago with Andrew. Here my last response:
>>>>
>>>> https://lore.kernel.org/all/d896bbd8-2709-4834-a637- 
>>>> f982fc51fc57@openvpn.net/
>>>
>>> Thank you for sharing the link to the beginning of the conversation. 
>>> Till the moment we have 3 topics regarding the operational state 
>>> indication:
>>> 1. possible absence of a conception of running state,
>>> 2. influence on routing protocol implementations,
>>> 3. traffic leaking.
>>>
>>> As for conception of the running state, it should exists for 
>>> tunneling protocols with a state tracking. In this specific case, we 
>>> can assume interface running when it has configured peer with keys. 
>>> The protocol even has nice feature for the connection monitoring - 
>>> keepalive.
>>
>> What about a device in MP mode? It doesn't make sense to turn the 
>> carrier off when the MP node has no peers connected.
>> At the same time I don't like having P2P and MP devices behaving 
>> differently in this regard.
> 
> MP with a single network interface is an endless headache. Indeed. On 
> the other hand, penalizing P2P users just because protocol support MP 
> doesn't look like a solution either.

On the upper side, with "iroutes" implemented using the system routing 
table, routing protocols will be able to detect new routes only when the 
related client has connected. (The same for the disconnection)

But this is a bit orthogonal compared to the oper state.

> 
>> Therefore keeping the carrier on seemed the most logical way forward 
>> (at least for now - we can still come back to this once we have 
>> something smarter to implement).
> 
> It was shown above how to distinguish between running and non-running 
> cases.
> 
> If an author doesn't want to implement operational state indication now, 
> then I'm Ok with it. Not a big deal now. I just don't like the idea to 
> promote the abuse of the running state indicator. Please see below.
> 
>>> Routing protocols on one hand could benefit from the operational 
>>> state indication. On another hand, hello/hold timer values mentioned 
>>> in the documentation are comparable with default routing protocols 
>>> timers. So, actual improvement is debatable.
>>>
>>> Regarding the traffic leading, as I mentioned before, the blackhole 
>>> route or a firewall rule works better then implicit blackholing with 
>>> a non-running interface.
>>>
>>> Long story short, I agree that we might not need a real operational 
>>> state indication now. Still protecting from a traffic leaking is not 
>>> good enough justification.
>>
>> Well, it's the so called "persistent interface" concept in VPNs: leave 
>> everything as is, even if the connection is lost.
> 
> It's called routing framework abuse. The IP router will choose the route 
> and the egress interface not because this route is a good option to 
> deliver a packet, but because someone trick it.

This is what the user wants.
OpenVPN (userspace) will tear down the P2P interface upon disconnection, 
assuming the --persist-tun option was not specified by the user.

So the interface is gone in any case.

By keeping the netcarrier on we are just ensuring that, if the user 
wanted persist-tun, the iface is not actually making decisions on its own.

With a tun interface this can be done, now you want to basically drop 
this feature that existed for long time and break existing setups.

> 
> At some circumstance, e.g. Android app, it could be the only way to 
> prevent traffic leaking. But these special circumstances do not make 
> solution generic and eligible for inclusion into the mainline code.

Why not? We are not changing the general rule, but just defining a 
specific behaviour for a specific driver.

For example, I don't think a tun interface goes down when there is no 
socket attached to it, still packets are just going to be blackhole'd in 
that case. No?

> 
>> I know it can be implemented in many other different ways..but I don't 
>> see a real problem with keeping this way.
> 
> At least routing protocols and network monitoring software will not be 
> happy to see a dead interface pretending that it's still running. 

They won't know that the interface is disconnected, they will possibly 
just see traffic being dropped.

> Generally speaking, saying that interface is running, when module knows 
> for sure that a packet can not be delivered is a user misguiding.

Or a feature, wanted by the user.

> 
>> A blackhole/firewall can still be added if the user prefers (and not 
>> use the persistent interface).
> 
> The solution with false-indication is not so reliable as it might look. 
> Interface shutdown, inability of a user-space application to start, 
> user-space application crash, user-space application restart, each of 
> them will void the trick. Ergo, blackhole/firewall must be employed by a 
> security concerned user. What makes the proposed feature odd.

Yeah, this is what other VPN clients call "kill switch".
Persist-tun is just one piece of the puzzle, yet important.

> 
> To summaries, I'm Ok if this change will be merged with a comment like 
> "For future study" or "To be done" or "To be implemented". But a comment 
> like "to prevent traffic leaking" or any other comment implying a 
> "breakthrough security feature" will have a big NACK from my side.

What if the comment redirects the user to --persist-tun option in order 
to clarify the context and the wanted behaviour?

Would that help?

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


