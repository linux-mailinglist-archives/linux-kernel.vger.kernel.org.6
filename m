Return-Path: <linux-kernel+bounces-576360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE153A70E45
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702EC17801D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91226ADD;
	Wed, 26 Mar 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UfTftsd5"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF118AFC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949692; cv=none; b=LKPGDVJk47opHdWEcyxfF1JfvRrbHj4l9YBfIeUMxNqcYI1h1Qd7ds5iUq8rX81VXtcohyrnYyGvE2znMTOcmJtTh/MVs11W2B7MXJXNFTfi89xy+2U/VhRZXQ8m5NFcPII28i1BC9CKOz8GIUFXTfq+11lgl4OHwGJuQF9xObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949692; c=relaxed/simple;
	bh=YWumwKd4G4TBiNO0hXLJ1NejnHCX233CsJiURFemDnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBul1KtA0TSyz5DdUEcq/wMrH87fy9lQnFtKdUWnAe6cIrxO+tcvjy6x+Tr+1ATfK4Xq2UP+3fc9nOjyfSGtySyuR62emsJnF49x7JSVEat4nunD8J+oKNrXdgJlyfyC8wK15e/DMwLDS6DmPPGpbAhI8/D98/GmZqX+uAQoH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UfTftsd5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so9655104a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742949688; x=1743554488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tovZ5cFxmJGmMnRik3YzsRpLLp2OfHAbvQ5xBsaYf5Y=;
        b=UfTftsd50md2N/XdQgCvXSp/iYG8O5YiHalxzgw119IEzU/ooshDN0e5QFIZs09ErL
         HsWh1ZRBxBeb4aEYlZ79T9MRM4eV74AFqz+uQfAM+lrIL5UMfJBry4gEjFNzJH+KCLq5
         UsHvqXWUWZLTAw/eqi8CAsCAekWg0kAHwxHT2DOiu7Gpn0N4DXC4w7mz/doC0gVAOj0f
         MFhw5wD5R9UUD6gsth0lx8Wh3PFTOtl8LKaFeCYH2qAIHD5qq9nszwFKN/tzNba6WVdT
         8h3imx6vG4YAjLNv53Gh7BfEoAjCfjfQUVfAxNY/qpvJ1SwlzmCg4uGdJ0/rDFfw7tj4
         mUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742949688; x=1743554488;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tovZ5cFxmJGmMnRik3YzsRpLLp2OfHAbvQ5xBsaYf5Y=;
        b=a6/8sge5lEzgwlqSbWSZOt4ym6vZb43InO1wRfWDkdr9g+GUA8jlg5Ye8W8KxBpBIM
         K0ah4HBj8fdQHGpuGnAi9iKEFEaAqd5aOEbmszs0xUVsQE/Zjvh312lEJ30imjDIf9cg
         Hqxv0R35FCS02Go381zAWfGwyXlDMT3TanE3eYzifgscwQV5wBjoG8wWhabq3yhmGnaa
         uLP4xsGg+w4MAWDqB61l9blxywY0o1kix1T6Y2UV9HD8v2tV/O82QU/mAYzbI16tvs61
         r40kwQ6lH8cirPEpNVuNe2MYiJkVltcbUx/Lma1VvV0X9HeV8dMagMkNE7rFzd2ZHHAL
         SCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMASzyc6eNNBwPAAe+zjIjhD77tWxhsIcR6/obgjqkodVzNmqkIxCW7KqD0v5XA+OdBYuz27I5dbU6BCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/Cy0ng6xP4Y8OfJjEnV5HCU6PTgKsDQK4ObSdEjJ3La+MnXV
	TbpZv3lXFLXTVCB2JzI4zErf2zwhYks3G1a5JIFy/ZdszTpIAFQgfIpH1livP8DPxST2F32Scim
	cUsX975DSqsYiZAWSEbbCh5cfUcmPW322M+ra+eidhh3NOFdFdD1X1Lo=
X-Gm-Gg: ASbGncuEnGG2hVFwhOGwOpS3E649Zhu1v7gSllpUDBYiehJhXfQV14wjBHtuQyEh3no
	tP2Kwyx2KQq8gqF81QHU7CNEe8vQzarcOfvZ9DNNvTddPJ8NmiHk6XBWMZZ0Nt6DXcn2504aesw
	1I8Yo/SNH1U7bzbITZ7+ZFhZ9lBfuRHhEh+jMxk1bGxGykTzoCFFSu3MwxthJryB/VA8KLc7Lxh
	yoHnTNDaH6j/9NEJPGPK7Z71PQcLplSSJOSdPHcc2RjFE04qjjc1aIms9dVaj/dShXyz+Q0EhC5
	s8GG8ovcFP+jo+78uQAMbiDmIPbCWZO7NrgnbiRBGLHLdoK1yYk3AVorW0jerJrzU1bdT4DcFvV
	xVbtJRSo=
X-Google-Smtp-Source: AGHT+IHkcDvCiQMvNNFyF7gxf+cJ9l+P8PmWl8/S59vgPhhY/xbkFJqunEt11YTuSiV/26DtQG4iig==
X-Received: by 2002:a17:906:730d:b0:ac1:e881:8997 with SMTP id a640c23a62f3a-ac3f2087ebamr1874042066b.3.1742949688469;
        Tue, 25 Mar 2025 17:41:28 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a7ff:2335:f20b:6389? ([2001:67c:2fbc:1:a7ff:2335:f20b:6389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8676c2sm924409866b.9.2025.03.25.17.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 17:41:27 -0700 (PDT)
Message-ID: <aa409f3c-ba52-4b7d-bc69-9d5259d90ffc@openvpn.net>
Date: Wed, 26 Mar 2025 01:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-18-3ec4ab5c4a77@openvpn.net> <Z-E4i587M54Os5Yo@krikkit>
 <86fea40c-6b8b-4ac3-bb14-4a24c63cf167@openvpn.net> <Z-KL9jKHNayqDLi2@krikkit>
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
In-Reply-To: <Z-KL9jKHNayqDLi2@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2025 11:56, Sabrina Dubroca wrote:
> 2025-03-25, 00:15:48 +0100, Antonio Quartulli wrote:
>> On 24/03/2025 11:48, Sabrina Dubroca wrote:
>>> Hello Antonio,
>>>
>>> A few questions wrt the API:
>>>
>>> 2025-03-18, 02:40:53 +0100, Antonio Quartulli wrote:
>>>> +static bool ovpn_nl_attr_sockaddr_remote(struct nlattr **attrs,
>>>> +					 struct sockaddr_storage *ss)
>>>> +{
>>>> +	struct sockaddr_in6 *sin6;
>>>> +	struct sockaddr_in *sin;
>>>> +	struct in6_addr *in6;
>>>> +	__be16 port = 0;
>>>> +	__be32 *in;
>>>> +
>>>> +	ss->ss_family = AF_UNSPEC;
>>>> +
>>>> +	if (attrs[OVPN_A_PEER_REMOTE_PORT])
>>>> +		port = nla_get_be16(attrs[OVPN_A_PEER_REMOTE_PORT]);
>>>
>>> What's the expected behavior if REMOTE_PORT isn't provided? We'll send
>>> packets do port 0 (which I'm guessing will get dropped on the other
>>> side) until we get a message from the peer and float sets the correct
>>> port/address?
>>
>> I have never seen a packet going out with port 0 :)
> 
> It will if you hack into ovpn-cli to skip OVPN_A_PEER_REMOTE_PORT.
> I don't know how networks/admins react to such packets.
> 
>> But being dropped is most likely what's going to happen.
>>
>> I'd say this is not something that we expect the user to do:
>> if the remote address if specified, the user should specify a non-zero port
>> too.
>>
>> We could add a check to ensure that a port is always specified if the remote
>> address is there too, just to avoid the user to shoot himself in the foot.
>> But we expect the user to pass an addr:port where the peer is listening to
>> (and that can't be a 0 port).
> 
> If we expect that (even if a well-behaved userspace would never do
> it), I have a preference for enforcing that expectation. Since there's
> already a policy rejecting OVPN_A_PEER_REMOTE_PORT == 0, this would be
> more consistent IMO.

Ok, makes sense.

> 
> An alternative would be to select a default (non-zero) port if none is
> provided.

I prefer to enforce having a port, rather tan going with a default that 
may bite us down the road.

> 
>>>
>>>
>>>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>>>> +			       struct nlattr **attrs)
>>>> +{
>>> [...]
>>>> +	/* when setting the keepalive, both parameters have to be configured */
>>>> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
>>>> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
>>>> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
>>>> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
>>>> +		ovpn_peer_keepalive_set(peer, interv, timeout);
>>>
>>> Should we interpret OVPN_A_PEER_KEEPALIVE_INTERVAL = 0 &&
>>> OVPN_A_PEER_KEEPALIVE_TIMEOUT == 0 as "disable keepalive/timeout" on
>>> an active peer?  And maybe "one set to 0, the other set to some
>>> non-zero value" as invalid?  Setting either value to 0 doesn't seem
>>> very useful (timeout = 0 will probably kill the peer immediately, and
>>> I suspect interval = 0 would be quite spammy).
>>>
>>
>> Considering "0" as "disable keepalive" is the current intention.
>>
>> In ovpn_peer_keepalive_work_single() you can see that if either one if 0, we
>> just skip the peer:
>>
>> 1217         /* we expect both timers to be configured at the same time,
>> 1218          * therefore bail out if either is not set
>> 1219          */
>> 1220         if (!peer->keepalive_timeout || !peer->keepalive_interval) {
>> 1221                 spin_unlock_bh(&peer->lock);
>> 1222                 return 0;
>> 1223         }
>>
>> does it make sense?
> 
> Ah, true. Sorry, I forgot about that.  So after _NEW/_SET we'll run
> the work once, and that peer will be ignored. And if there's no other
> peer requiring keepalive, next_run will be 0 and we don't
> reschedule. That's good, thanks.
> 

Cool,
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


