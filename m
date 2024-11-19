Return-Path: <linux-kernel+bounces-414010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B69D21C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A65AB22D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C019CC14;
	Tue, 19 Nov 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NZFt2fWu"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C6153BFC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005927; cv=none; b=m55VaFTmYFUcxHxiSYFiUXxbmNuvquOxJ3KVDdtk3zr6EJP8OS2ROeUnFtIDpMKFzlG5xmH+M2DusXx88ANVIaHgpjxIUgCV2ZBVjfbO3UQ1PCSw/O7w6sf/vHVnYN9lUxfLN4fml7BfQQ3K8KNVpea3bCVoYIY3XVNVr8alVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005927; c=relaxed/simple;
	bh=S+U+AjJRasPBDpiweR/FNZIR/50o66YkmWzkir4ZW2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8dZ5SeKq3CWVB0r3Hau6NPfPOQS5AItmn3Lwj4S7zJje7E9CnW34t8OA3wuIOo5gcORzsYfCLlpn39HnolxLsxDxyEvjLO0seqyKC3R4OC3wOfjJQB1MTQ5CqSwYfSlHux1HkFLSgxyxStpZjjMhl+cANa2WgrdsEDePUhuoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NZFt2fWu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfd3a7e377so1699223a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732005924; x=1732610724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8fuT97yI4Tuoujm6UUjQklceuyk/9Xj1w4bHDEeWvaU=;
        b=NZFt2fWu8dOjBBBmYCqenDv3ennpH6FbIcESjm/hstKFJns5mBjpG1DO5JFh1FlLHB
         dX3RYgUxDWzzrCE76ZQJUCXVcvWPssKbjP/Rz0cpH3w1SBzy5aNkcAPKkFV8RjTImcvU
         rEBq5oX3J73S533c6A8gEIsy+vSeAxjGRzAxm3r/TzZrjRQEnCkr5s00WlFcGq3B8nMU
         Wy30IYOdMFLKLO1wfgOulROSYXhUfxqc/ZVmPAY+pjmyt3NY45GoaHWp7P4wtzX+IBuk
         GCNf4/abP9q9L9qxBVPMHm8sTTzFh8oSNR6QICf8eoyJGYUxGdOPpT23D8bpjEWH9tVq
         5OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732005924; x=1732610724;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fuT97yI4Tuoujm6UUjQklceuyk/9Xj1w4bHDEeWvaU=;
        b=BXxTpI7tjcNoFrQFiBDjNIFw0+7bwZXevwIMIEW6T3j1Qxw/uUHjl89cp3/bxSrmja
         lxFxHngEqhcQTYj9b24TCmcyiq8eqOqTRIg8Ou8UjI5GmJCymGw7bvYZ8rR23FjbEh77
         SJvlzvKBeEIIpoHDqGIXdM+dJ7S8s+KbvBgh/6Tsb8q3yN2lDAP00djfn7XIyfo0D456
         FR+MsLYEqSaq0MWH/g/3rQ4pvb0ZHxqs6pGQVBm+2z0A17MajClK8661D9cHDasSXEh0
         Rh+ti4kd+PGC4HLH5BeUf5T60Btd69faHYYhUWppLpljJA7JdLUDQUgLSJv9lk+R0v++
         4KLg==
X-Forwarded-Encrypted: i=1; AJvYcCV7QQ31OwZi3pwy/G7G6V5s/PF5BuStmSkDL39ulZ7rS5jrrSqoeO+ywHCAV98cfCHJ3nebpXhu6vrXHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPsaMD71Lo40+HpS2pwIawBo/D2p5TmHP/0UqAKMj+9TdtQo+I
	OOelFpwPcd7SBJfZzjgUx4BCzCANUK82r3VWPgaqUhKpt3YcfkZKtVAcCR9DLtM=
X-Google-Smtp-Source: AGHT+IGWgWvrU3iW9fpLyl65j2i8nKGQqJjCyR6GPI7QRQB3gyIMeqWk8joXLkagDKieL4IvEbilPA==
X-Received: by 2002:a05:6402:2794:b0:5c9:6f20:4cf1 with SMTP id 4fb4d7f45d1cf-5cf8fd04bf8mr13901074a12.27.1732005924036;
        Tue, 19 Nov 2024 00:45:24 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:a2be:8cd5:8845:cfce? ([2001:67c:2fbc:1:a2be:8cd5:8845:cfce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfaca26fdesm3336525a12.47.2024.11.19.00.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 00:45:23 -0800 (PST)
Message-ID: <855e6fee-5f0a-439d-a6c5-6829db4ecbfa@openvpn.net>
Date: Tue, 19 Nov 2024 09:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 04/23] ovpn: add basic interface
 creation/destruction/management routines
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-4-de4698c73a25@openvpn.net>
 <4b6f2e30-5e94-475d-97ec-d59e59f0bf6b@gmail.com>
 <0f19828c-9808-427f-b620-fd3bc9f2e5db@openvpn.net>
 <709d415d-859d-4342-80b7-908c04b28621@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <709d415d-859d-4342-80b7-908c04b28621@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2024 04:08, Sergey Ryazanov wrote:
> On 15.11.2024 16:03, Antonio Quartulli wrote:
>> On 10/11/2024 21:42, Sergey Ryazanov wrote:
>>> Missed the most essential note regarding this patch :)
>>>
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>> +static int ovpn_net_open(struct net_device *dev)
>>>> +{
>>>> +    netif_tx_start_all_queues(dev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int ovpn_net_stop(struct net_device *dev)
>>>> +{
>>>> +    netif_tx_stop_all_queues(dev);
>>>
>>> Here we stop a user generated traffic in downlink. Shall we take care 
>>> about other kinds of traffic: keepalive, uplink?
>>
>> Keepalive is "metadata" and should continue to flow, regardless of 
>> whether the user interface is brought down.
>>
>> Uplink traffic directed to *this* device should just be dropped at 
>> delivery time.
>>
>> Incoming traffic directed to other peers will continue to work.
> 
> How it's possible? AFAIU, the module uses the kernel IP routing 
> subsystem. Putting the interface down will effectively block a client- 
> to-client packet to reenter the interface.

True.
At least part of the traffic is stopped (traffic directed to the VPN IP 
of a peer will still flow as it does not require a routing table lookup).

I circled this discussion through the other devs to see what perspective 
they would bring and we also agree that if something is stopping, better 
stop the entire infra.

Also, if a user is fumbling with the link state, they are probably 
trying to bring the VPN down.

I will go that way and basically perform the same cleanup as if the 
interface is being deleted.

"the party is over"[cit.] :)

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


