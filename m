Return-Path: <linux-kernel+bounces-515075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1BA35F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB2B188C611
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59340264FB9;
	Fri, 14 Feb 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dYMmzSj+"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D8263C9B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541265; cv=none; b=gImA30t23oP2vOwWcv4Op1X0bmMG4lw0C8MzentxLeS8pPowvwPqG7sWUW52fRRRB2W0yXEU8LbRqTv9Vcin8uo5aIhRN1rjxkP6OHbsUKfec8k2AO2A5dgUFIdSjuv0wX42TuPHYznHw6+n2X0HZlA+19ixkMHPdiYSASYAFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541265; c=relaxed/simple;
	bh=QskIIUY3abCHEQqr+ZBO02qBkdcjQaMWhVVTfD1ktoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jzr0EP4p+DhFiZsUy53GwvPIExzhDaUlbnzwA4nXOmrqCJOuvTgaKfTzGeaY5lO+26Y07hvy5aNYK17B+3yEHd6vA7skMxM90oA2lJPeqtIbEiQgG4A0PDqt/VOFs/WsXVWscCc4iIuSC1LQI7cQv1FG6xCztrtHlYZUBLqRFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dYMmzSj+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso2080686f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739541262; x=1740146062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toWHVNWxJVyn5ES/h46Z050KFfTtE9z+8q/ixpftoXQ=;
        b=dYMmzSj+uyk5TL/dl5EwvUHVdCQ3S1OYsC7xJWoGCKQH5fcB+PD8TSB7Y2dXgCHvhl
         a4udnkfu5GdPw1RDpspVYz9z7JVhO+/H6IFijdlvpseBJrVguqLtOP2csCwevO9LrZ8i
         4+cxKf2Xqx1LSl3BvPUiLPu5eErCfLfFYblzLXTKbxVXydvgkctp5/M/VxImW84lZ4g8
         Ljc+Qjgx8D4MFynab5V6tRtalKvbNaT6Z1SOfs1mFTRFiiZFr9Cgrg7Q1OsGwCdSEwYv
         0T3e21TWsKtHbhyk7xzKTxgBj7DU/uYhkPZ8YkMR1o4BfcynOSIu3OsJfJubAQFsqCfh
         lRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541262; x=1740146062;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=toWHVNWxJVyn5ES/h46Z050KFfTtE9z+8q/ixpftoXQ=;
        b=hecZHuEFiyLKt89R4gOk30VyevUyMhD5wylUnoPdPj9JyEmBunvCTxjfer34KnJ4jl
         B/+aGHDm1wKiB8ynpREGs/qeDpkJIL/NcGUG+2ka5Aqkuqx+cIwRzsoT8npXVNIgDzsR
         2kIARAnS7xeSZQ1NGzU/LLFsIRwAkCc9ocYsQs39/6ZlaGuJvcwojNd4od/HAkloXudM
         UIUpPB2n4K4Da6uPjKtbldOkaUYULRzTvYCzjpwXVGyrLueNuQ2S6HNaWG7Eu/q6BU8v
         u0OC51E/FRPsbpN9NPQU4MQwHszRarOQMmmaSfP/VOcw2zJyNL9994rvA9DVp2L6Bnko
         jEbA==
X-Forwarded-Encrypted: i=1; AJvYcCVgaq0sgFByOLp4QFhC9DaHYp53A29CCPFM0d0xwkZGDez1HMRRpaifpjzvveHW2V/j9k26+npvEB5gISU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlrrxOPLFBA0KD1NbOo+XXyD533sdsPrnU9idkK86CbjVE6iVW
	hkC1Uest2ueAnJtf143NppdXS+xzyK5UJC64YUjBZKJcCbNXhSoUnMfLUAQFcnw=
X-Gm-Gg: ASbGncsdtkYnQqzmNnyhpcrBtYWPcb7AsTenhHamgMZJqfbvvzvdv2fnwmkV5MaVFIP
	zDQ2g4uWmnYRWlku3VrV0uhV52b1BYRHijh+OqtvInoqbtinREhJCds2QkiuRMnpv6jn+6Swfim
	f2ikwqiNAvvaX0R1CAFHg5397LT88dh2OOBUa+x82jFm1V2IRLThV0IdvteL6lZmtgh3sLN7yZN
	YkqzBNFjUeX2/wEvwK61yVxKParrjwskcaUKap9e9FJ0+gamz+TpmsZ3xCfFFWCcGGpUgZV+pi4
	qonceAVE6EjaUTmmRq4dxvjB2TcvXxxH+mn8lj1aFLID1dCiZ0hrkg==
X-Google-Smtp-Source: AGHT+IGkDAoesNnj7fFlL42H4EVhyCcHo9D7iDEiKI1TAQsgS558sccl4nN3f3aKaXXhWN9NPT7ZkA==
X-Received: by 2002:a5d:6d0a:0:b0:38d:e363:494b with SMTP id ffacd0b85a97d-38f24cfa3f1mr9673966f8f.8.1739541261655;
        Fri, 14 Feb 2025 05:54:21 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:cd14:b9de:fda8:dc6d? ([2001:67c:2fbc:1:cd14:b9de:fda8:dc6d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2580fe7dsm4733240f8f.0.2025.02.14.05.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 05:54:21 -0800 (PST)
Message-ID: <507c0388-8ce4-47fa-90b3-b46ae170045a@openvpn.net>
Date: Fri, 14 Feb 2025 14:54:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
 <Z60wIRjw5Id1VTal@hog> <090524ac-724d-4915-8699-fe2ae736ab8c@openvpn.net>
 <Z64Tw02PO433bob8@hog> <0c0de58a-4dac-4b3b-9fc5-2a58a145d5ab@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <0c0de58a-4dac-4b3b-9fc5-2a58a145d5ab@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2025 20:40, Antonio Quartulli wrote:
> On 13/02/2025 16:46, Sabrina Dubroca wrote:
>> 2025-02-13, 12:46:34 +0100, Antonio Quartulli wrote:
>>> On 13/02/2025 00:34, Sabrina Dubroca wrote:
>>>> Hello,
>>>>
>>>> 2025-02-11, 01:39:53 +0100, Antonio Quartulli wrote:
>>>>> All minor and major reported problems have been finally addressed.
>>>>> Big thanks to Sabrina, who took the time to guide me through
>>>>> converting the peer socket to an RCU pointer.
>>>>
>>>> Something is off (not sure if it's new to this version): if I use
>>>> test-tcp.sh to setup a set of interfaces and peers (I stop the test
>>>> just after setup to keep the environment alive), then remove all netns
>>>> with "ip -all netns delete", I expect all devices to go away, but they
>>>> don't. With debug messages enabled I'm seeing some activity from the
>>>> module ("tun0: sending keepalive to peer 3" and so on), and
>>>> ovpn_net_uninit/ovpn_priv_free never got called.
>>>
>>> I can reproduce it. If later I rmmod ovpn I then get all the 
>>> "Deleting peer"
>>> messages.
>>> So instances are not being purged on netns exit.
>>>
>>> Will dive into it.
>>
>> I think the socket holds a ref on the netns, so it's not getting
>> destroyed, simply "removed" from iproute's point of view. And the
>> socket isn't going away as long as it's used by a peer.
> 
> After a deep dive I was getting to the same conclusion:
> cleanup_net() is never invoked because we lack an invocation of put_net().
> sk_alloc() invokes get_net(), so this is the ref that is not being 
> released.
> 
>>
>> If I delete the peer(s) for the ovpn device and then the netns it was
>> in, the netns is fully removed, and the ovpn device is gone. Also no
>> issue if I delete the ovpn device before its netns, then everything is
>> destroyed as expected.
>>
>> I'm not sure that can be solved, as least under the current refcount
>> scheme.
> 
> I went back to v12 of the patchset (which is pre-refcount-restructuring) 
> and indeed the problem there doesn't exist.
> 
> However, it's unclear to me how in v12 the socket release was happening 
> upon netns delete. Who was triggering that? ovpn still needed to call 
> sockfd_put() in order to let it go.
> 
> Will investigate some more and think about a solution.
> 

I may have done something wrong, but today I tried again and I am 
reproducing this issue also on v8 + 6.11.

I am indeed wondering how it could have ever worked: if we don't delete 
the peer, we don't detach the socket, hence the following chain:

sockfd_put() -> sk_destructor() -> put_net()

does not happen.

Shouldn't we be notified somehow that the netns is going away?

For example in wireguard/device.c the socket is released in 
pernet_operations.pre_exit().

But pre_exit() is invoked in cleanup_net(), which is invoked ONLY if the 
net refcount has reached 0...but how can it be zero before the sockets 
have been released?

I must be missing something, because this seems to be a reference loop.


I'll keep digging..

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


