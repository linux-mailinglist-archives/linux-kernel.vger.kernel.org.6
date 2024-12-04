Return-Path: <linux-kernel+bounces-430768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BC9E3546
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A329116900D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF5197512;
	Wed,  4 Dec 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LiO819uu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57500195FE8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300897; cv=none; b=fkCwo6Q/XwF0zqfnkfYDnlQRBU4j7GZF7rTwSvpWETsLMVGxz+m7dwlXWFs0r64JPb48quga++sjBq/qV+AAU9lzym6F90j2FREjJZWdRJ4tIn1Zq0DzLt56oBzhvocy44M6v5Y5QCw8ruoR8lZY2IJphiush5llTv1Spsw2YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300897; c=relaxed/simple;
	bh=xm0k3LEm/t5M1MhNV+r7aSDNktedE8gni5rubf6B7/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqmNDhLeXtmq565VCru0nZVV4A1ftPx8LkhzpZPYDYlyAwvNiZQJUn55jom9QH09lcWJCPiF0u3+lTjXVydFae48fmeWJyDO4WGAelJkDODW3et1Wz7JQSk+IBnUXHpmAS+H1fUe9XdViB4DVAHFG5v5YAYtNAcM67JMtLXlZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LiO819uu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so53440195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 00:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733300893; x=1733905693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WeS45cgVmn2kwwFzIeql6x4TqJo7vj7WPWgPDrbwPRU=;
        b=LiO819uuy0XklS2qe2vud88SQ6U4FiBGYWOPIFiLSZzdjKe08tlEOWyPb5Izzdem31
         qrK2JElPrpGokHtXOXlUTDk/fpJgvyw5l+RrRRJpZbRwvypnEHAldumdVyU/EWFozjxG
         0IxCdrG+yZbTjYQ8tOdTwzHyOCGbMNHprdSQ+bccMUFRKiZ9TrWpdGXlitR6cHhCMQOE
         dfcSQCHfzo9yZGTQTWKFjh0nOFy0l+gVzwi0ec/LiVeLb5hdaPuYg5/IvZMMMmP+dhsv
         gSIGMQF/YSXmmTZCjEHLWKtleM+eAG/fkYD1U9ZUq/BASxye4nsCQobvU3ymPvV4LqxE
         cb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300893; x=1733905693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeS45cgVmn2kwwFzIeql6x4TqJo7vj7WPWgPDrbwPRU=;
        b=QfAx7PvJvFVyHElO7i/JD5ijfdWGLeGek3B7E7WATNkFWlQTcPWYwPdeko/vUmMOIK
         TdgIM/QDbHuFPgdr0yQ62sVAOiMHJoWsH9c+uhQxonPyvg0L21ocGAdmEHGbiyfPAoFm
         MbWjWd20klcP8HVFNK/Kq6837s4F3B/qXEdbMOXo40+qD+1KZP1o2JrfT+xcc4jnVvTD
         u/P2v7Ew/a8a0JxGJrOr40YwpRGVDMH5qk3u9k6Twm1Xattr2vQr3ZhwCIYBooQEFCt3
         6Rg627aWrCPIppDzHZtHqvVqV3IPlaQg/II6FG7vqxklDTKKG9HeV3xG1nmbu6j+SIjl
         +5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVnE4kqSSj95o2xFuHvKEsmySE7O5dPhtYf7AQ+VYDDvsLePdsCw/WNazVqylm9JskB1MQktEdVDyd40+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLdFRL2wFs7f5GBYmhlOCBgYWN5EAWXT+r/gT5njdUyGtCYRA
	QItmgfKbrHW6+iJ15zB6oquqvuJPJiGF7/87vUwonMN5j7TB+BWKpOAo8U0dMK4=
X-Gm-Gg: ASbGncsJLPhhU+abCCXzZzhFVJGMhX6tT44XNIXXWGzkguz3hcvBzhZxsc28+RiR0Jz
	auD+rzANSXtKSXgsIxI3KnSzAGwaerJhE/JNaqwyfZOEQ2mxkSpxWPzm58YdAKaCf681HHLvf0I
	ajmRSU9SW93iZf2nuxZUqeCX+4sKMMWXyQmEeEY5k7Ln0bFOdcyFmoz0yBC5G5q4eVfF/TsYsas
	7ls6rWnvdTh5D6FwwU4xOwSFO3vT6vN0AaY95SyglOWgt8ghjhmn24nlGMHVW+KudfhjnzhOQOj
	WpMEzFthqaYb
X-Google-Smtp-Source: AGHT+IEykHctrD2RKYq1Gcn8ZUF7UtPR5ZkVnFwioxhJG8cLUVd6W+FybTnNT85zSh/QrkEd9zItJw==
X-Received: by 2002:a05:6000:184c:b0:385:df73:2f24 with SMTP id ffacd0b85a97d-385fd418d72mr4857428f8f.39.1733300893570;
        Wed, 04 Dec 2024 00:28:13 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:85f4:5278:b2f6:64fb? ([2001:67c:2fbc:1:85f4:5278:b2f6:64fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e429ebccsm11891236f8f.10.2024.12.04.00.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:28:13 -0800 (PST)
Message-ID: <b4627d32-8d17-4253-8687-a451d7a1052e@openvpn.net>
Date: Wed, 4 Dec 2024 09:28:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/22] ovpn: implement peer lookup logic
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 ryazanov.s.a@gmail.com, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
 <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net> <Z08tV5vQe2S4iawi@hog>
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
In-Reply-To: <Z08tV5vQe2S4iawi@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 17:09, Sabrina Dubroca wrote:
> 2024-12-03, 15:58:17 +0100, Antonio Quartulli wrote:
>> On 02/12/2024 16:07, Antonio Quartulli wrote:
>> [...]
>>> +#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({	\
>>> +	typeof(_tbl) *__tbl = &(_tbl);			\
>>> +	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);	\
>>> +})
>>> +
>>> +#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
>>> +	typeof(_tbl) *__tbl = &(_tbl);				\
>>> +	&(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];	\
>>> +})
>>
>> clang a reporting various warnings like this:
>>
>> ../drivers/net/ovpn/peer.c:406:9: warning: variable '__tbl' is uninitialized
>> when used within its own initialization [-Wuninitialized]
>>    406 |         head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
>>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    407 |                                   sizeof(peer_id));
>>        |                                   ~~~~~~~~~~~~~~~~
>> ../drivers/net/ovpn/peer.c:179:48: note: expanded from macro
>> 'ovpn_get_hash_head'
>>    179 |         &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];  \
>>        |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>> ../drivers/net/ovpn/peer.c:173:26: note: expanded from macro
>> 'ovpn_get_hash_slot'
>>    173 |         typeof(_tbl) *__tbl = &(_tbl);                  \
>>        |                       ~~~~~     ^~~~
>>
>> Anybody willing to help me understand this issue?
>>
>> I have troubles figuring out how __tbl is being used uninitialized.
>> I wonder if the parameters naming is fooling clang (or me) somehow.
> 
> Not really a solution to this specific issue, but do you actually need
> ovpn_get_hash_slot as a separate macro? AFAICT all users could also be
> converted to ovpn_get_hash_head, then you can merge ovpn_get_hash_slot
> into ovpn_get_hash_head and maybe clang won't get confused?
> 
> No guarantee that this fixes anything (except saving one or two lines
> in a few functions).

This is what it used to be before (and no error was reported), but I had 
to split the macro because I need to isolate the slot computation for 
nulls comparison. So there are some users for ovpn_get_hash_slot()

I will quickly try changing the naming and see if clang gets happier.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


