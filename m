Return-Path: <linux-kernel+bounces-447436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791139F3249
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA91D1679E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561E205E18;
	Mon, 16 Dec 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PXB6+MP9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03615205AA4
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358116; cv=none; b=QuywS3qF4+Xy719GQ2s5BipCjbPmk8E5m7RFHpMGeV99GqGGspuu0nHi5BNvtUBhbAuOjd8q2v50mIn7LTZQtdhoOMK+DBrSYV/wS8JcijdlaLJ9nDC+BmsUSryzEmENKwCQC3BiiD5LH1klpxRVYIDQ4GRXD7T7YhvQxj8O/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358116; c=relaxed/simple;
	bh=OLwe7F4vbnnLiJa8DAhWsJNmWi+pu29hgr+ZBCT3RsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dci6ATtluWabkAbR1xM+HUFUrGOdkF9fs5WVI256PxYLcx4T4dOmOLQA/TtU7bWLcg1hkNABBahGQERub1exKNejm2BlItAe5Cw923aBm8da81zS8wN/Hb9vFCG8BuPharXD+psEbU4BnGrJgvHXCt0J1mTi3f7uZdd//OvIGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PXB6+MP9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso555817466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734358112; x=1734962912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iJRtjCuRf4u/mIVAi/rZXzL1htzVeeHFGJyMVioiTLw=;
        b=PXB6+MP9dtapYkXFfM2+CWbNN/ubudNgVLgdlwUwvCjOfNIeM/vrnjR38A/XlWJhZO
         Lr2m0rWwzpIAC0W9rohj7pgsKMwtaVyEj8H3oBvMf1KD+g+Wko1ZKZTzcP34hsN7Xeci
         Pc9MrRhHz/EfFkTJF+OpoyFljU+Cp8xCLSfFzm6AStpXG9a20LrgBpeHOz1lvnaxoVbg
         vq0MuGLPGjKrXbOoKxb/IargUmcT3rstIyavcwgxr/hkqIos3PO8QFOcEiPUxIbXMLjC
         Kvw0lNdXIFee051u9wU7jwwZHKJyPrqmVkt6sC/dbIuezfPGzQdvuh0PErFkEv399sQj
         rLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358112; x=1734962912;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJRtjCuRf4u/mIVAi/rZXzL1htzVeeHFGJyMVioiTLw=;
        b=P0vlf8OYjlzql4fqbprlegp9fWs3SxxO6mVd8a+uw/UojAvU9AvtrmLABqOWaAfalr
         BTcGJ7P/bkumMO4piF8YOWJxj7R/BViaqS5vy4vWDhaEpdFifqSQAAG6nrfD5xWzOQUg
         P3sVP7/3fVLfgstbAufrIsrsBhWFgxBRqdjl2k44joBzEg6eOtkgYRnzdFZ5liEkWM0b
         7/wCA+zeHkCWKvcLTQgU9g7JCtH7JjGdpHgUd8c/C7+fZnvX8moehVXAAUULoa60zl/e
         OXdvjCZ876uEXz/AfiURwjHLgwXSbWNeslODlLH3EkmvqygUR5SaGr+tzwbB1OCv3BVS
         r1dw==
X-Forwarded-Encrypted: i=1; AJvYcCXb31I7RSqHHlVziN9aKl+ECyb1hUplX8PpwnZI78Gf5rIol6XysZlY/yzFFYsvcd6MbLFfMtgVq7khMVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnorCRDMzDInUd2YUZQzTQJu5seBxqJRA1YMRh1DySVNTgvk1
	97/cOXy8eL+SapFUp7gc89xBAFz3Vbo7iZHVDXrbcAELci7FJ+5PPGsLAmI+p+Q=
X-Gm-Gg: ASbGnctKA96zvIm1N0qJe8wizWcMGbgzSLRaEK3C98dp6Xc3AAkCg8u3iWz7V1e4QMq
	hOsqopCGWZDum/1uJGouD8Cs3pt1DPN8hZiN6W1qFueM8EZ+rSriVWQDlaw4RWdZhzB6e0c9NAL
	oY6Mn4vDDxJadS9QK9ZRGfLlpCDDFQ1aN4pe9Kd7ZfREBwuFejqmDqzB0An6eP2dip0Ll58CGbx
	3+8LGRrDNJNmvdkdL3nJajg69ocDfpTphwCEmefWU0kDOMJ0lGGbNXWwOg7tSz5x3pD/B4tNY8A
	vBpT1B9IFkbCU6Tt
X-Google-Smtp-Source: AGHT+IGfdTYTUcySDV9LOBWc54Ry7kX6f/+3GLeO3z58d81IR1ldh4qf+jwkUVax5wS194tnMt9oUA==
X-Received: by 2002:a17:906:3181:b0:aa6:57aa:1fe9 with SMTP id a640c23a62f3a-aab77ed4311mr1135675166b.51.1734358109003;
        Mon, 16 Dec 2024 06:08:29 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:115:abba:2f54:81d2? ([2001:67c:2fbc:1:115:abba:2f54:81d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960681dbsm332269266b.52.2024.12.16.06.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 06:08:28 -0800 (PST)
Message-ID: <dcb961a8-e0ba-49ea-b1ef-f52439713588@openvpn.net>
Date: Mon, 16 Dec 2024 15:09:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 11/22] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 dsahern@kernel.org
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-11-314e2cad0618@openvpn.net> <Z2AyLOMazyOCDopc@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z2AyLOMazyOCDopc@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2024 14:59, Sabrina Dubroca wrote:
> 2024-12-11, 22:15:15 +0100, Antonio Quartulli wrote:
>> @@ -42,6 +56,31 @@ struct ovpn_peer {
>>   		struct in6_addr ipv6;
>>   	} vpn_addrs;
>>   	struct ovpn_socket *sock;
>> +
>> +	/* state of the TCP reading. Needed to keep track of how much of a
>> +	 * single packet has already been read from the stream and how much is
>> +	 * missing
>> +	 */
> 
> nit: not so accurate since the switch to strp, can probably be dropped
> since @tcp has a kdoc entry

right - dropping it.

> 
>> +	struct {
>> +		struct strparser strp;
>> +		struct work_struct tx_work;
>> +		struct sk_buff_head user_queue;
>> +		struct sk_buff_head out_queue;
>> +		bool tx_in_progress;
>> +
>> +		struct {
>> +			struct sk_buff *skb;
>> +			int offset;
>> +			int len;
>> +		} out_msg;
>> +
>> +		struct {
>> +			void (*sk_data_ready)(struct sock *sk);
>> +			void (*sk_write_space)(struct sock *sk);
>> +			struct proto *prot;
>> +			const struct proto_ops *ops;
>> +		} sk_cb;
>> +	} tcp;
> 
> [...]
>> +static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	if (peer->tcp.out_msg.skb)
>> +		ovpn_tcp_send_sock(peer);
>> +
>> +	if (peer->tcp.out_msg.skb) {
>> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> 
> tx_dropped?

ACK

> 
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	peer->tcp.out_msg.skb = skb;
>> +	peer->tcp.out_msg.len = skb->len;
>> +	peer->tcp.out_msg.offset = 0;
>> +	ovpn_tcp_send_sock(peer);
>> +}
>> +
>> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	u16 len = skb->len;
>> +
>> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
>> +
>> +	bh_lock_sock(peer->sock->sock->sk);
>> +	if (sock_owned_by_user(peer->sock->sock->sk)) {
>> +		if (skb_queue_len(&peer->tcp.out_queue) >=
>> +		    READ_ONCE(net_hotdata.max_backlog)) {
>> +			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> 
> tx_dropped?

ACK

> 
>> +			kfree_skb(skb);
>> +			goto unlock;
>> +		}
>> +		__skb_queue_tail(&peer->tcp.out_queue, skb);
>> +	} else {
>> +		ovpn_tcp_send_sock_skb(peer, skb);
>> +	}
>> +unlock:
>> +	bh_unlock_sock(peer->sock->sock->sk);
>> +}
> 
> [...]
>> +static void ovpn_tcp_close(struct sock *sk, long timeout)
>> +{
>> +	struct ovpn_socket *sock;
>> +
>> +	rcu_read_lock();
> 
> [can't sleep until unlock]
> 
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +
>> +	strp_stop(&sock->peer->tcp.strp);
>> +
>> +	tcp_close(sk, timeout);
> 
> 
>      void tcp_close(struct sock *sk, long timeout)
>      {
>      	lock_sock(sk);
> 
> but this can sleep.

Ouch.. I wonder why I have never seen the might_sleep() trigger this, 
but probably that's due to the fact that we hardly hit this cb in the 
classic use case.

> 
> Is there anything that prevents delaying tcp_close until after
> ovpn_peer_del and rcu_read_unlock?

not really.

> 
>> +	ovpn_peer_del(sock->peer, OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
>> +	rcu_read_unlock();

I will move the tcp_close() here.

>> +}
> 
> [...]
>> +void __init ovpn_tcp_init(void)
>> +{
>> +	ovpn_tcp_build_protos(&ovpn_tcp_prot, &ovpn_tcp_ops, &tcp_prot,
>> +			      &inet_stream_ops);
>> +
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops, &tcpv6_prot,
>> +			      &inet6_stream_ops);
> 
> I don't think that works for CONFIG_OVPN=y and CONFIG_IPV6=m. You can
> either go back to the ugly thing espintcp and tls do, or use the
> traditional Kconfig hack:
> 
> 	depends on IPV6 || !IPV6
> 
> (you can find it sprinkled in various places of drivers/net/Kconfig
> and net/)

I'll go for the Kconfig hack. Hopefully one day IPV6 will become bool..

Thanks!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


