Return-Path: <linux-kernel+bounces-429672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C89E1F90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436E32825E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365871F4704;
	Tue,  3 Dec 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dbfc73WQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632821F667A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236693; cv=none; b=n85vU5cH/LCEgAQKfT+KX19Ct39cC6UjZsdWXhtbrwEuo5Do24CGVPoSjbDthz5rFN5TVEMYG2shGFfQdEn7CSxRI+HbnCfgb6u62FxCH2Z1K99zTpmzoKpFznQg2kOFqLnhoryGxRYsBL3ID+JcRQnlld/Mk62EDYuNGkoOrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236693; c=relaxed/simple;
	bh=1xSwGntOs483IXpes9RE41VqWC/DkA82mYEGpp84DXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8euTvTEqpIHj4Xn0piqNUgsi2EAG6qAJ7p4i5cO8cj/eAmmX1tc+y0v3JtpajlHkANKoZ5hgztK2c/TfvjmofNNc+l2swaMW4xPf+2V+a/b6QEDzumwx3ICKd4I5HFtKoRzQ7CQBANi8UoXurYUj8TlyKS27ey/RdMkCMKKs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dbfc73WQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa5b0d8bd41so704526666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733236690; x=1733841490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AcMk8p/L4xS8bpKaq3E7c7KWsNOhXEOOyWlE091hFNk=;
        b=dbfc73WQfd5MtO4Nr14caIpbEltoWwNM1OxdNZKAW6Ig3e5eNg9tvJH9e1SXhrUTll
         fifNX/Xj/eMVh57Smdws9oqDgTKjg7KZVXhrDdmPv+A4KoztFxzQeA8MQyxifmvtZKZ8
         IbJhDSYECQu6vGbpWFg4OrBWrxAe2difUcS2A5kJBDR5COLVvYv7hCJtUyXHKFRHz7LV
         V83HkBfxsGB9OMgPN33dqbGhtscx7tss5kjHMawx7YL7GFFpysMUo9hx9+HVKJne3Gf/
         s1z46ayGsq0zmx+KLsmfz0XEze8hLmRdI9GZEdxssuqqXC+qnmeX0og84ypBXMA41Yik
         fAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236690; x=1733841490;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcMk8p/L4xS8bpKaq3E7c7KWsNOhXEOOyWlE091hFNk=;
        b=O71yhWbFo3n7PfD9sQTa1Mn22j3QGZ5oJAF9nztbodWEUMqC2QzPMxErdQi3y8MHgh
         7UUnVr1c9T+lYx/1d5OCm2RjDJ5COxeTi7K+inF0GUjGjEVSd5OqVjdkFaNF43nTVtKB
         vEMGYIcUllf/Zdv6L4pdNTM2YKH5OmEiviDTKBP4Qa9urxoQ8CTTf41sEOY65V3wWo3B
         eyv5QZOjVfFW5UA+eG29PfKiB5QHg77TcKwl+qdTIdtiZns8yAPRnsoHWZ8URTxFxS5O
         MVNzFzkwrCXZF/Vz2KwPxm1/y19vRvcIXdWWBZN0jXXQZmSTgTbBEnyKCf6fAbIMtXJe
         My9A==
X-Forwarded-Encrypted: i=1; AJvYcCUyYG+Do51U30lNxzEzdi5bXePxVXJUQejiL98Jquw/kTclijlmGV9cni/8BTYhfeo/2ARvVbv3J7Fhu8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWWS54T55MdMMO4BCFXOKdKCICG3ZsLTrnKckyW4tN6Iwgtsd
	Euuazcu6QYjpIeCfh5PUjepaVezMNmmdlRWHSBHNnS5p585MhD+2cUsOKnxFL2k=
X-Gm-Gg: ASbGnct4aCtLT9ef/HETbnO22F4Byg1xn3ES+mxmtvCyQHO6OCCa4xlRGnzfuOJkYTt
	XvvtqrcUXUxnfxni9kXArg5KGhUEhRfRx3U5EKexV2RmrhIkFoR7rjMh5PUOFEUk8B20gcjgaFG
	klTGv3tvpNQVn9XGtoMk+FKCCh7cvRS6gxYPKq4rOvFgh0m84D59TUbCKdvj/PKr/iZy9ROHoMT
	z8cs1YI4zv2F+9lYmx6ZQTgBJpOZBuHTP1gRdjgUbbWha/qtNCOT88rVA4QV6j8OsywTrKKEIlG
	6FkV28rIIjgN
X-Google-Smtp-Source: AGHT+IHXMgrAw8DvP9mNiokY+5wRvDcA6G6RMXPkdhouMrvAnOORvb3XV1avC+WUIz9UgC2FTICSrA==
X-Received: by 2002:a17:906:3151:b0:aa5:3853:5541 with SMTP id a640c23a62f3a-aa5f7f0b007mr188305766b.41.1733236689712;
        Tue, 03 Dec 2024 06:38:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:138c:c1e3:75bf:72b5? ([2001:67c:2fbc:1:138c:c1e3:75bf:72b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953c81sm624432466b.184.2024.12.03.06.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:38:09 -0800 (PST)
Message-ID: <411ee201-4248-4452-af00-0b2d2eca4369@openvpn.net>
Date: Tue, 3 Dec 2024 15:38:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/22] ovpn: implement basic RX path (UDP)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-8-239ff733bf97@openvpn.net>
 <c49582ff-5fe6-4d0a-8d03-7b3297cadd6b@redhat.com>
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
In-Reply-To: <c49582ff-5fe6-4d0a-8d03-7b3297cadd6b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2024 15:34, Paolo Abeni wrote:
[...]
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	unsigned int pkt_len;
>> +	int ret;
>> +
>> +	/* we can't guarantee the packet wasn't corrupted before entering the
>> +	 * VPN, therefore we give other layers a chance to check that
>> +	 */
>> +	skb->ip_summed = CHECKSUM_NONE;
>> +
>> +	/* skb hash for transport packet no longer valid after decapsulation */
>> +	skb_clear_hash(skb);
>> +
>> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
>> +	 * interface, based on __skb_tunnel_rx() in dst.h
>> +	 */
>> +	skb->dev = peer->ovpn->dev;
>> +	skb_set_queue_mapping(skb, 0);
>> +	skb_scrub_packet(skb, true);
>> +
>> +	skb_reset_network_header(skb);
>> +	skb_reset_transport_header(skb);
>> +	skb_probe_transport_header(skb);
> 
> This is a no-op after the previous call. You should drop it.

Thanks Paolo, I'll drop it.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


