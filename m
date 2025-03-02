Return-Path: <linux-kernel+bounces-540777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49628A4B4CC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D183AF1A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96321EE7A3;
	Sun,  2 Mar 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RqwS8W55"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BD1EDA27
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949189; cv=none; b=VSbAaWljMcPM2sQWPx43JBStFSC2WSuRl9SiRtV/qgkOYdqEj4jmC5CjBL00+/6Q5waKyJXEz7w8ib+bLyd0UB62aFqITLVa4zGJXcPg2Pb/AUq4Qlv30STXDNI6DesXLZl0GjR+XwV+hMnIUiVJFgwM0EwUmLsEMq2bmy7WC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949189; c=relaxed/simple;
	bh=UYW986QV7x9GVVOTQCKLdz+8BqmmdwkVLUbif8SCopQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5vf2YH0tW3eqO1Ve0dVq2v2RACNGKcAkwq886UyBMe0aH8qRUL2aftn8PzFe2lE5oNz8lK+67BEWfM1qS5p5o8DU7wcnSKoBs+DZSzzWWRvxBUXLIxgY3JXXY6DjPPS4dfm6dxglJ/KfKIKXNvkfVRt8Wt4nqlKsKoDB3ncNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RqwS8W55; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so4425435e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 12:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740949186; x=1741553986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eIX365mkLp+se7cIEzPiJN+EK3+TXPxKlKV4tjiJKpM=;
        b=RqwS8W55mb1WCLAOjihdpqHfWtt8C8EDvLlUp2JpQXyMIzI+NIcmEvonS0QIfVAwSk
         XG6dMK+qzqPhzOOaxCJ2EfOzEYk41WJkwQcI7K3wS0biksN/+O5ecBCIyH80Qseec6V+
         /Ki8qXJ/NGTytwGAPguVdg0YVv1y3mBy016JNCCiUS3bbMFA9diuv+615FPuqmaBnoQN
         Mpp5cTbg0y2Z/Hsid/XUC5Dw6joL4xiVc3FgYhBK3G2nWrt76HUI7AetEKv+o0IZ5qat
         kQUbMnQwIYYG5PkLKwPhvFFRp3ciIYIliwOOGY1wB26Xf57Srt3MgqkqPQviV1T8lA5z
         ASCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949186; x=1741553986;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIX365mkLp+se7cIEzPiJN+EK3+TXPxKlKV4tjiJKpM=;
        b=r9b9ynEh7/F4ZmpURM54jdXbgs7rseYv1FAxHUGwuSIbnwQv9zbQ2iBTTg3XQcyAIU
         E3zdV6bDQqcmLv94damx9pTFSgzI0tum8fTuDEv2qS4gCAJnQCeXtMaKqIVpJ8xbiOzT
         Zawf0DjQr5dwfx0G5W5n72rUWLqhYdCuMWo7YwU//ZarcjDwMNLNgPevW3q4ocpFFEv0
         u+MW58fzmD/SWHsG/2QzKozogYPxvw68K2yT4cYSbRBbiBr7gGpGwAr0YbjT+fgRC4QE
         dDBcvzF7nEu/L8UjrBycVG+qYZ4uGt0v0mVkSCVIGspefwKVIfU/c0r+GEYy/dvmvWl7
         GqWg==
X-Forwarded-Encrypted: i=1; AJvYcCUfigHNtj4Ep2hTtVpYHKYxU8Mk7fWLfls5QoLTdQgIQAydloM/sXEkfBxchnsBspg9qnmSM2kw0GxxvKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCB8KLmrvFV2f+bNdpRyBGspdnSLCXmAjhfJfkAtng8IWiAj6
	DX6b8FRpWKO434QcP0NG3kBQAKFBO0R2xJ4R+lkEWz8iZnT6IG0RwLwdrnZzgq4=
X-Gm-Gg: ASbGncu5SquyxwMXhDyJEWN0Yst+2OfahM/GI/AIHQXGgT4fVIpA4IQr65nN69L7yA/
	hez37RkDi4FEM3yStjZ0KJZUs5gn8XhQaRykqzXnIPGE6t802eelpJLwUFJrBOjPV9ItdESrYiD
	x5uWjjF6WV10cMZmWCj8JqlDSoS39OA0JyCbvU+WXQ/+Okklcu/KemrTUgHwd7PtT3/K3qQairM
	GUlvrQJo0HYuFBUKmZiAK/NdPzuN4lKNA3MpbBmg7W0hXAbvU60DWsRX5IW40euL7ulrM+4MCX6
	yKE+QCCaHh9PuVmln2gM2ugGe6QVAbHZ0RqCKpfQkjqtSZR1wrVlb023MQraz17YGFfT2k/XAUl
	9cqanGiQ=
X-Google-Smtp-Source: AGHT+IHesPQqPxS6NB85GDL49TfW7o2UMgtr4SwfRaXVLC19SqDfXU2eCyslrkZgY6UWK2iHA5Gn0g==
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id ffacd0b85a97d-3910a74d8e6mr1269072f8f.8.1740949186027;
        Sun, 02 Mar 2025 12:59:46 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:6db2:7b02:2c7e:3704? ([2001:67c:2fbc:1:6db2:7b02:2c7e:3704])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm12635757f8f.17.2025.03.02.12.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 12:59:45 -0800 (PST)
Message-ID: <2a677967-da28-430e-b794-26c5c17e9963@openvpn.net>
Date: Sun, 2 Mar 2025 21:59:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 12/25] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 David Ahern <dsahern@kernel.org>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-12-93f363310834@openvpn.net> <Z8SqiJedxrFhGuB9@hog>
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
In-Reply-To: <Z8SqiJedxrFhGuB9@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 19:59, Sabrina Dubroca wrote:
> 2025-02-27, 02:21:37 +0100, Antonio Quartulli wrote:
>> Moreover export tcp_release_cb by means of EXPORT_SYMBOL instead of
>> EXPORT_IPV6_MOD, so that other modules can use it, even if IPV6 is
>> not compiled in.
> 
> Is that really needed? You're saving tcp.sk_cb.prot, so you could just
> call peer->tcp.sk_cb.prot->release_cb? (with a bit of care since it's
> called after peer_put)
> 
> [I don't know what the maintainers' preference is wrt "re-exporting"
> symbols that got moved to EXPORT_IPV6_MOD]

Mh yeah, I like your suggestion as I don't have to change the EXPORT and 
also I don't have to make assumptions on the original value of 
->release_cb as I can just call it.

Will follow your suggestion. Thanks!

> 
> 
> [...]
>> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
>> +{
>> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
>> +
>> +	if (!skb)
>> +		return;
>> +
>> +	if (peer->tcp.tx_in_progress)
>> +		return;
>> +
>> +	peer->tcp.tx_in_progress = true;
>> +
>> +	do {
>> +		int ret = skb_send_sock_locked(sk, skb,
>> +					       peer->tcp.out_msg.offset,
>> +					       peer->tcp.out_msg.len);
>> +		if (unlikely(ret < 0)) {
>> +			if (ret == -EAGAIN)
>> +				goto out;
>> +
>> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
>> +					     netdev_name(peer->ovpn->dev),
>> +					     peer->id, ret);
>> +
>> +			/* in case of TCP error we can't recover the VPN
>> +			 * stream therefore we abort the connection
>> +			 */
>> +			ovpn_peer_del(peer,
>> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> 
> I don't think this works:
> 
> ovpn_peer_del -> unlock_ovpn -> ovpn_socket_release -> might_sleep
> 
> but we can get to ovpn_tcp_send_sock in a few contexts that are not
> allowed to sleep:
> 
> ovpn_tcp_send_skb -> ovpn_tcp_send_sock_skb -> ovpn_tcp_send_sock
> __sk_flush_backlog -> release_cb = ovpn_tcp_release -> ovpn_tcp_send_sock_skb
> release_sock       -> release_cb = ovpn_tcp_release -> ovpn_tcp_send_sock_skb
> 
> 
> (I checked all other paths leading to unlock_ovpn/ovpn_socket_release,
> this is the only one I could find that is not allowed to sleep. So it
> would likely be easier to push this peer_del (or even just the
> handling of release_list) into some other sleepable context than
> trying to reshuffle all the other paths)

ACK (and thanks for double checking all other paths!)
I will do some magic on this peer_del() in order to make it sleep 
without issues.

Thanks!

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


