Return-Path: <linux-kernel+bounces-429735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E210A9E226B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C50F1678A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070821F757D;
	Tue,  3 Dec 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAmdzjr6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619621F6696
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239194; cv=none; b=u+tXPk9hh0OjQp2IyGUTQTxiPGKkXgDnTxYddNmwyeejrXe2xJ4zusxAhOrTpWMwu6ENXDnV7SKItA8biAn6M4ivbLHjE2Zl+T14E4TTpeKgQdNxfBmMpXkffvHWBNUP1Zi/RnUsK8darPuGqVaKV0Pd8489iffnV3yRCI+g95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239194; c=relaxed/simple;
	bh=W8qGrXe3bRj1Y5AJQrHiF87Sh1brFktXiqV8GbPDha0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrG3C9zrQsIicQPPbT0mObAoMgO5LKDVBnUUEnAKHAQZV65+Bff/zDckXK+mGUIXW1V+vCt01tgKbeoNNJkKO9RWHEHdccBM6n3TpZqpESkUc8KS2cNuy+Ocy6tBozCLMR2jahoG06rna0PEqpV8oycRKVy782umOJTvC8lDSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAmdzjr6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733239191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66p4s8wP06Z+ogr+u1zv8IffffNMECDmCGEmHoHtmxU=;
	b=cAmdzjr6uWYk7jIpublioV5/U7NmEhi82q2DY7Z8Y6fkn/5Fm72ASZ/XJqWJECoF8kbJC3
	Zyk1lVncdmmnlvajnjK9c+OW6furDw9RTFvB2VDHwdp5rVLaVrmnDjbuHd/AU4UGewgkIC
	v3Gb1iF0g6WsI25Fud4GIYUlZxSsoqM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-q4K9ca4UPmWsONcYjYInVw-1; Tue, 03 Dec 2024 10:19:50 -0500
X-MC-Unique: q4K9ca4UPmWsONcYjYInVw-1
X-Mimecast-MFC-AGG-ID: q4K9ca4UPmWsONcYjYInVw
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6676f4361so549051485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239190; x=1733843990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66p4s8wP06Z+ogr+u1zv8IffffNMECDmCGEmHoHtmxU=;
        b=XrZMUNeV2IiM5ZlXKQcEcVrWEUaj/Yz78TIyCBpG4kwuNlELhCjp6mALCkV42DYokk
         QztB6GQalcRQRz/ZDLNzvW5B8uQY1KxAylTgVKHkuERpbZbVVzrB3xomEsOy/We7eyk0
         CACFYoDDXz/n29pqKWH/cJ7g0eA9wf5glIl2m74XEpEEt19NDUFvR39u2jov6E7YGv3w
         RmzH9VlbibQv1qvINN3YNVSeyoFIHkGyB9TOZ/U5W6KDMQ6IL5Uo39cr9AfUbayU1xJl
         QNEVp2X/PjhxH3zC2pnNGPhnUmjNCwfxBJS80dq8ovzrWpo6w2BZMpcnEdR3IJnmBccz
         1PnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPsd/2fmxQqK6yRhbCqRM0taZB9uGpB1b2tk10ycR/TmcZ+tmgFAGFdmrsBv72Pv9qGugmjRoDlJUhHMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Fyw26D6wnPEd5XFiCmgEhuw5aTct8GYuacMLqYbVJyT8J544
	XyndnV4Yzg8Mu8paiEg7rj4Wf/F85LVmQF0sTNWa0PnKeIwtxmHK+ctLXOJj3VrqibvfA9ydkDm
	pHY1ppYhsVR4XISQjhiQo+4aWpqkf2GYfuO/JdvrBS/ITQL43k8zEwfTX7i5/PA==
X-Gm-Gg: ASbGncueiSLJABwjQoHgzs/Z8yVLeRsUSHNdQ3GC4LSqjfpi0DBX7HA2kbIxzPPYv9G
	IHwVoOzGwJ21ayPBIv7TV7Qv4T6Tf/0E4FjzV7ZDazImr712JarwYAMn1DermIBy/9cgEN2ZpFD
	dhuLwj7j8ccmZ5W0IC9swHzEfIzLzDd1KqssRIF15/QDjuypXif4wSRa65y1tQx4vxOlkkqbI/O
	f/cTYFdDgCMza2PckbMl788YCRdd0gmpya6AG4+ttnsfJOfE1xkQu2eqhqxZsK7rSkLUBifXmfB
X-Received: by 2002:a05:620a:4898:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b6a5d43dc9mr330905285a.13.1733239189735;
        Tue, 03 Dec 2024 07:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUd+tgeqmGfFLGSGU9BwPAgdjbHK6XPidUMe3MK0uD8X6Akeg8tfjhHGyj6L7JiVZaV5sTgQ==
X-Received: by 2002:a05:620a:4898:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7b6a5d43dc9mr330900685a.13.1733239189325;
        Tue, 03 Dec 2024 07:19:49 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492f180sm517904385a.44.2024.12.03.07.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:19:48 -0800 (PST)
Message-ID: <784fddc4-336c-4674-8277-c7cebea6b94f@redhat.com>
Date: Tue, 3 Dec 2024 16:19:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/22] ovpn: implement TCP transport
To: Antonio Quartulli <antonio@openvpn.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-b4-ovpn-v12-11-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 16:07, Antonio Quartulli wrote:
> +void ovpn_tcp_socket_detach(struct socket *sock)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	struct ovpn_peer *peer;
> +
> +	if (!sock)
> +		return;
> +
> +	rcu_read_lock();
> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> +
> +	if (!ovpn_sock->peer) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	peer = ovpn_sock->peer;
> +	strp_stop(&peer->tcp.strp);
> +
> +	skb_queue_purge(&peer->tcp.user_queue);
> +
> +	/* restore CBs that were saved in ovpn_sock_set_tcp_cb() */
> +	sock->sk->sk_data_ready = peer->tcp.sk_cb.sk_data_ready;
> +	sock->sk->sk_write_space = peer->tcp.sk_cb.sk_write_space;
> +	sock->sk->sk_prot = peer->tcp.sk_cb.prot;
> +	sock->sk->sk_socket->ops = peer->tcp.sk_cb.ops;
> +	/* drop reference to peer */
> +	rcu_assign_sk_user_data(sock->sk, NULL);
> +
> +	rcu_read_unlock();
> +
> +	barrier();

It's unclear to me the role of the above barrier. A comment would help

> +	/* cancel any ongoing work. Done after removing the CBs so that these
> +	 * workers cannot be re-armed
> +	 */
> +	cancel_work_sync(&peer->tcp.tx_work);
> +	strp_done(&peer->tcp.strp);
> +	skb_queue_purge(&peer->tcp.out_queue);
> +
> +	ovpn_peer_put(peer);
> +}
> +
> +static void ovpn_tcp_send_sock(struct ovpn_peer *peer)
> +{
> +	struct sk_buff *skb = peer->tcp.out_msg.skb;
> +
> +	if (!skb)
> +		return;
> +
> +	if (peer->tcp.tx_in_progress)
> +		return;
> +
> +	peer->tcp.tx_in_progress = true;
> +
> +	do {
> +		int ret = skb_send_sock_locked(peer->sock->sock->sk, skb,
> +					       peer->tcp.out_msg.offset,
> +					       peer->tcp.out_msg.len);
> +		if (unlikely(ret < 0)) {
> +			if (ret == -EAGAIN)
> +				goto out;
> +
> +			net_warn_ratelimited("%s: TCP error to peer %u: %d\n",
> +					     netdev_name(peer->ovpn->dev),
> +					     peer->id, ret);
> +
> +			/* in case of TCP error we can't recover the VPN
> +			 * stream therefore we abort the connection
> +			 */
> +			ovpn_peer_del(peer,
> +				      OVPN_DEL_PEER_REASON_TRANSPORT_ERROR);
> +			break;
> +		}
> +
> +		peer->tcp.out_msg.len -= ret;
> +		peer->tcp.out_msg.offset += ret;
> +	} while (peer->tcp.out_msg.len > 0);
> +
> +	if (!peer->tcp.out_msg.len)
> +		dev_sw_netstats_tx_add(peer->ovpn->dev, 1, skb->len);
> +
> +	kfree_skb(peer->tcp.out_msg.skb);
> +	peer->tcp.out_msg.skb = NULL;
> +	peer->tcp.out_msg.len = 0;
> +	peer->tcp.out_msg.offset = 0;
> +
> +out:
> +	peer->tcp.tx_in_progress = false;
> +}
> +
> +static void ovpn_tcp_tx_work(struct work_struct *work)
> +{
> +	struct ovpn_peer *peer;
> +
> +	peer = container_of(work, struct ovpn_peer, tcp.tx_work);
> +
> +	lock_sock(peer->sock->sock->sk);
> +	ovpn_tcp_send_sock(peer);
> +	release_sock(peer->sock->sock->sk);
> +}
> +
> +static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	if (peer->tcp.out_msg.skb)
> +		ovpn_tcp_send_sock(peer);
> +
> +	if (peer->tcp.out_msg.skb) {
> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	peer->tcp.out_msg.skb = skb;
> +	peer->tcp.out_msg.len = skb->len;
> +	peer->tcp.out_msg.offset = 0;
> +	ovpn_tcp_send_sock(peer);
> +}
> +
> +void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
> +	u16 len = skb->len;
> +
> +	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);
> +
> +	bh_lock_sock(peer->sock->sock->sk);

Are you sure this runs in BH context? AFAICS we reach here from an AEAD
callback.



> +	if (sock_owned_by_user(peer->sock->sock->sk)) {
> +		if (skb_queue_len(&peer->tcp.out_queue) >=
> +		    READ_ONCE(net_hotdata.max_backlog)) {
> +			dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> +			kfree_skb(skb);
> +			goto unlock;
> +		}
> +		__skb_queue_tail(&peer->tcp.out_queue, skb);
> +	} else {
> +		ovpn_tcp_send_sock_skb(peer, skb);
> +	}
> +unlock:
> +	bh_unlock_sock(peer->sock->sock->sk);
> +}

[...]

> +static void ovpn_tcp_build_protos(struct proto *new_prot,
> +				  struct proto_ops *new_ops,
> +				  const struct proto *orig_prot,
> +				  const struct proto_ops *orig_ops);
> +
> +/* Set TCP encapsulation callbacks */
> +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct strp_callbacks cb = {
> +		.rcv_msg = ovpn_tcp_rcv,
> +		.parse_msg = ovpn_tcp_parse,
> +	};
> +	int ret;
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	if (sock->sk->sk_user_data)
> +		return -EBUSY;
> +
> +	/* sanity check */
> +	if (sock->sk->sk_protocol != IPPROTO_TCP) {
> +		net_err_ratelimited("%s: provided socket is not TCP as expected\n",
> +				    netdev_name(peer->ovpn->dev));
> +		return -EINVAL;
> +	}
> +
> +	/* only a fully connected socket are expected. Connection should be
> +	 * handled in userspace
> +	 */
> +	if (sock->sk->sk_state != TCP_ESTABLISHED) {
> +		net_err_ratelimited("%s: provided TCP socket is not in ESTABLISHED state: %d\n",
> +				    netdev_name(peer->ovpn->dev),
> +				    sock->sk->sk_state);
> +		return -EINVAL;
> +	}
> +
> +	lock_sock(sock->sk);
> +
> +	ret = strp_init(&peer->tcp.strp, sock->sk, &cb);
> +	if (ret < 0) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		release_sock(sock->sk);
> +		return ret;
> +	}
> +
> +	INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
> +	__sk_dst_reset(sock->sk);
> +	skb_queue_head_init(&peer->tcp.user_queue);
> +	skb_queue_head_init(&peer->tcp.out_queue);
> +
> +	/* save current CBs so that they can be restored upon socket release */
> +	peer->tcp.sk_cb.sk_data_ready = sock->sk->sk_data_ready;
> +	peer->tcp.sk_cb.sk_write_space = sock->sk->sk_write_space;
> +	peer->tcp.sk_cb.prot = sock->sk->sk_prot;
> +	peer->tcp.sk_cb.ops = sock->sk->sk_socket->ops;
> +
> +	/* assign our static CBs and prot/ops */
> +	sock->sk->sk_data_ready = ovpn_tcp_data_ready;
> +	sock->sk->sk_write_space = ovpn_tcp_write_space;
> +
> +	if (sock->sk->sk_family == AF_INET) {
> +		sock->sk->sk_prot = &ovpn_tcp_prot;
> +		sock->sk->sk_socket->ops = &ovpn_tcp_ops;
> +	} else {
> +		mutex_lock(&tcp6_prot_mutex);
> +		if (!ovpn_tcp6_prot.recvmsg)
> +			ovpn_tcp_build_protos(&ovpn_tcp6_prot, &ovpn_tcp6_ops,
> +					      sock->sk->sk_prot,
> +					      sock->sk->sk_socket->ops);
> +		mutex_unlock(&tcp6_prot_mutex);

This looks like an hack to avoid a build dependency on IPV6, I think the
explicit

#if IS_ENABLED(CONFIG_IPV6)

at init time should be preferable

> +
> +		sock->sk->sk_prot = &ovpn_tcp6_prot;
> +		sock->sk->sk_socket->ops = &ovpn_tcp6_ops;
> +	}

[...]

> +static void ovpn_tcp_close(struct sock *sk, long timeout)
> +{
> +	struct ovpn_socket *sock;
> +
> +	rcu_read_lock();
> +	sock = rcu_dereference_sk_user_data(sk);
> +
> +	strp_stop(&sock->peer->tcp.strp);
> +	barrier();

Again, is not clear to me the role of the above barrier, please document it.

Thanks,

Paolo


