Return-Path: <linux-kernel+bounces-546224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B4A4F7F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C0E16B1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4421EDA34;
	Wed,  5 Mar 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Smgtu85i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AD1EC00B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159958; cv=none; b=TVYSQNkdOK18y0n3B8hgDnGXcxe63Jblt0rDbWn4aEaSKB5KXcuGl4NaWEcUs8Rmnj0/DOn3RljE88zpCdw5+Z7tYD+3ClMIvB4MyGbw99GmUSy+nSoUs6rxBxNKS2uFbNGCo7N4nZHau0Ldl/HvsPU8Y29X6WEm0IH/tn+OQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159958; c=relaxed/simple;
	bh=ezSdVZ718sdEaDQu0Fq/XI8XEZdrCCN0rNCOCek4stU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgN1nBVZ3sgn7ezkhQ4apmfqzsgWgxz78ChmV1UDDka6xAlh9K65I6HU8UnZjfQwoWUnninGwc2Nkris4ci++wsjE243pKJ1V4wZqzhe6KAEluOTzzdURnmqjmsONx4RSu6F8/pimkQSRV4i6slM6V0oTK9c1aHvQ0xZBmQMDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Smgtu85i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741159954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B92v00k/V01VL77HQY6vg/m3aT0mMegJuzU2AaL6Z2w=;
	b=Smgtu85i0uT1pRLlOtfCzTmyhYn8K7d54xUuKjlClPw/CJOQvcvhMU7u284NluaChrzNdf
	D4v/pQWJV8WOetCqNfjC2ba3YxK8lzyVBE7bjhFbkZi2y60+8P2B5rZzoPMSniG3k8EGzy
	N3lY7twLpHiFCf2lf1TubyyIV9ty60g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SBrNIlm9MvO7-ThBWMzULA-1; Wed, 05 Mar 2025 02:32:20 -0500
X-MC-Unique: SBrNIlm9MvO7-ThBWMzULA-1
X-Mimecast-MFC-AGG-ID: SBrNIlm9MvO7-ThBWMzULA_1741159940
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3911218d81cso2044709f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159939; x=1741764739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B92v00k/V01VL77HQY6vg/m3aT0mMegJuzU2AaL6Z2w=;
        b=A0ONxUkEjWw+s8urNgS76lD6/lkE3Ly+gK9XXgLTM+WtJW/8B0CTPXgvLBa7PzmH3z
         E2AWpCaBQvY/cdn+/CO+4emHUsB7fnsx9QDI6TMOeUmytIyruAPOW3EjewWMR1Pd8rQ9
         E+A7ZH4k8g1z2um+coiBGtetrVcy86NQRvH8N63zMIt5zy1N4dTcY417gTNOKL9SzYVH
         h/s6DB0MrBJ9+O6oGMT1JofxtPtYhSVlNK5hl+UPsQvq6/dJ0M1r+KQwY/9/gAbm75+O
         ppmd3QL0YvSmJxppP4EFOR8QGeiPEF8e1w95P3pl+iAvXY9Ds86xMAusAvfeE2vlh3ma
         H2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVXI++qwEI1TeiYR1AbYLfMj5gGUY2E1DgmUQGTDcre8UR81JgYxJpMvhXOwgOCdp4mEi9yKOHNuouzRs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWzAeVzOJX2VFXlmFYrjUN6RNJqYLWSYeTTIYN2tA69cI+RHM
	JvHI2/rgpua1t6M1fsg5aheCnX6nXVXaLQ8851GEw0Yat06QHN/z7qwhxcbYAdjK76qndLorKPC
	RgefPw8yFc6PEjKCCQjf6aFpCz2APHJAtgR8mlYGQ31COSLZlI+D9xh0iH6SFsQ==
X-Gm-Gg: ASbGncukj6m8feTyw+O3pLxJCfVFmxDWK5fCBVVmRhM77ZH2Q9ntydpAS7SFwYaKqUs
	W8usU8V4ABC9Jfs2YaqyzdMdUeatiIkS7KckVZyvCEtAF23wyxOneYoY6TNNrQiIoPd2DyWaHKN
	2L3Z/1riTH67pEHk4TU76Le+vili/Z8gHXaXVer4IqJAaF2TDQuEWPlvoTTGmWIHReA//K5XbDu
	yJa5Q8Oa7omheA+hj7NXq+Hg3K7a7akrwguYuJWO3lrSBfuYurZ2rm6aKzd9eAnIGxLzFHY6KbE
	HKMatbbgYw==
X-Received: by 2002:a05:6000:2d06:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-3911f7c1122mr1161806f8f.43.1741159939498;
        Tue, 04 Mar 2025 23:32:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk8WTzHsuUmhU/0K1rTWcYvDhcGCuvNs3rRLqLCF7rnAIU2e61Q/xLcDIeoz+Rfzh0eCKIvQ==
X-Received: by 2002:a05:6000:2d06:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-3911f7c1122mr1161780f8f.43.1741159939093;
        Tue, 04 Mar 2025 23:32:19 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm20392609f8f.32.2025.03.04.23.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:32:18 -0800 (PST)
Date: Wed, 5 Mar 2025 02:32:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20250305022900-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116172428.311437-2-sgarzare@redhat.com>

On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> This patch adds a check of the "net" assigned to a socket during
> the vsock_find_bound_socket() and vsock_find_connected_socket()
> to support network namespace, allowing to share the same address
> (cid, port) across different network namespaces.
> 
> This patch adds 'netns' module param to enable this new feature
> (disabled by default), because it changes vsock's behavior with
> network namespaces and could break existing applications.
> G2H transports will use the default network namepsace (init_net).
> H2G transports can use different network namespace for different
> VMs.


I'm not sure I understand the usecase. Can you explain a bit more,
please?

> 
> This patch uses default network namepsace (init_net) in all
> transports.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> RFC -> v1
>  * added 'netns' module param
>  * added 'vsock_net_eq()' to check the "net" assigned to a socket
>    only when 'netns' support is enabled
> ---
>  include/net/af_vsock.h                  |  7 +++--
>  net/vmw_vsock/af_vsock.c                | 41 +++++++++++++++++++------
>  net/vmw_vsock/hyperv_transport.c        |  5 +--
>  net/vmw_vsock/virtio_transport_common.c |  5 +--
>  net/vmw_vsock/vmci_transport.c          |  5 +--
>  5 files changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index b1c717286993..015913601fad 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -193,13 +193,16 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
>  void vsock_insert_connected(struct vsock_sock *vsk);
>  void vsock_remove_bound(struct vsock_sock *vsk);
>  void vsock_remove_connected(struct vsock_sock *vsk);
> -struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
> +struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net);
>  struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
> -					 struct sockaddr_vm *dst);
> +					 struct sockaddr_vm *dst,
> +					 struct net *net);
>  void vsock_remove_sock(struct vsock_sock *vsk);
>  void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
>  int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>  bool vsock_find_cid(unsigned int cid);
> +bool vsock_net_eq(const struct net *net1, const struct net *net2);
> +struct net *vsock_default_net(void);
>  
>  /**** TAP ****/
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9c5b2a91baad..457ccd677756 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -140,6 +140,10 @@ static const struct vsock_transport *transport_dgram;
>  static const struct vsock_transport *transport_local;
>  static DEFINE_MUTEX(vsock_register_mutex);
>  
> +static bool netns;
> +module_param(netns, bool, 0644);
> +MODULE_PARM_DESC(netns, "Enable network namespace support");
> +
>  /**** UTILS ****/
>  
>  /* Each bound VSocket is stored in the bind hash table and each connected
> @@ -226,15 +230,18 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>  	sock_put(&vsk->sk);
>  }
>  
> -static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
> +static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr,
> +					      struct net *net)
>  {
>  	struct vsock_sock *vsk;
>  
>  	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
> -		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
> +		if (vsock_addr_equals_addr(addr, &vsk->local_addr) &&
> +		    vsock_net_eq(net, sock_net(sk_vsock(vsk))))
>  			return sk_vsock(vsk);
>  
>  		if (addr->svm_port == vsk->local_addr.svm_port &&
> +		    vsock_net_eq(net, sock_net(sk_vsock(vsk))) &&
>  		    (vsk->local_addr.svm_cid == VMADDR_CID_ANY ||
>  		     addr->svm_cid == VMADDR_CID_ANY))
>  			return sk_vsock(vsk);
> @@ -244,13 +251,15 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>  }
>  
>  static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
> -						  struct sockaddr_vm *dst)
> +						  struct sockaddr_vm *dst,
> +						  struct net *net)
>  {
>  	struct vsock_sock *vsk;
>  
>  	list_for_each_entry(vsk, vsock_connected_sockets(src, dst),
>  			    connected_table) {
>  		if (vsock_addr_equals_addr(src, &vsk->remote_addr) &&
> +		    vsock_net_eq(net, sock_net(sk_vsock(vsk))) &&
>  		    dst->svm_port == vsk->local_addr.svm_port) {
>  			return sk_vsock(vsk);
>  		}
> @@ -295,12 +304,12 @@ void vsock_remove_connected(struct vsock_sock *vsk)
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_connected);
>  
> -struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
> +struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr, struct net *net)
>  {
>  	struct sock *sk;
>  
>  	spin_lock_bh(&vsock_table_lock);
> -	sk = __vsock_find_bound_socket(addr);
> +	sk = __vsock_find_bound_socket(addr, net);
>  	if (sk)
>  		sock_hold(sk);
>  
> @@ -311,12 +320,13 @@ struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr)
>  EXPORT_SYMBOL_GPL(vsock_find_bound_socket);
>  
>  struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
> -					 struct sockaddr_vm *dst)
> +					 struct sockaddr_vm *dst,
> +					 struct net *net)
>  {
>  	struct sock *sk;
>  
>  	spin_lock_bh(&vsock_table_lock);
> -	sk = __vsock_find_connected_socket(src, dst);
> +	sk = __vsock_find_connected_socket(src, dst, net);
>  	if (sk)
>  		sock_hold(sk);
>  
> @@ -488,6 +498,18 @@ bool vsock_find_cid(unsigned int cid)
>  }
>  EXPORT_SYMBOL_GPL(vsock_find_cid);
>  
> +bool vsock_net_eq(const struct net *net1, const struct net *net2)
> +{
> +	return !netns || net_eq(net1, net2);
> +}
> +EXPORT_SYMBOL_GPL(vsock_net_eq);
> +
> +struct net *vsock_default_net(void)
> +{
> +	return &init_net;
> +}
> +EXPORT_SYMBOL_GPL(vsock_default_net);
> +
>  static struct sock *vsock_dequeue_accept(struct sock *listener)
>  {
>  	struct vsock_sock *vlistener;
> @@ -586,6 +608,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
>  {
>  	static u32 port;
>  	struct sockaddr_vm new_addr;
> +	struct net *net = sock_net(sk_vsock(vsk));
>  
>  	if (!port)
>  		port = LAST_RESERVED_PORT + 1 +
> @@ -603,7 +626,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
>  
>  			new_addr.svm_port = port++;
>  
> -			if (!__vsock_find_bound_socket(&new_addr)) {
> +			if (!__vsock_find_bound_socket(&new_addr, net)) {
>  				found = true;
>  				break;
>  			}
> @@ -620,7 +643,7 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
>  			return -EACCES;
>  		}
>  
> -		if (__vsock_find_bound_socket(&new_addr))
> +		if (__vsock_find_bound_socket(&new_addr, net))
>  			return -EADDRINUSE;
>  	}
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index b3bdae74c243..237c53316d70 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -201,7 +201,8 @@ static void hvs_remote_addr_init(struct sockaddr_vm *remote,
>  
>  		remote->svm_port = host_ephemeral_port++;
>  
> -		sk = vsock_find_connected_socket(remote, local);
> +		sk = vsock_find_connected_socket(remote, local,
> +						 vsock_default_net());
>  		if (!sk) {
>  			/* Found an available ephemeral port */
>  			return;
> @@ -350,7 +351,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  		return;
>  
>  	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
> -	sk = vsock_find_bound_socket(&addr);
> +	sk = vsock_find_bound_socket(&addr, vsock_default_net());
>  	if (!sk)
>  		return;
>  
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index d9f0c9c5425a..cecdfd91ed00 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1088,6 +1088,7 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
>  void virtio_transport_recv_pkt(struct virtio_transport *t,
>  			       struct virtio_vsock_pkt *pkt)
>  {
> +	struct net *net = vsock_default_net();
>  	struct sockaddr_vm src, dst;
>  	struct vsock_sock *vsk;
>  	struct sock *sk;
> @@ -1115,9 +1116,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	/* The socket must be in connected or bound table
>  	 * otherwise send reset back
>  	 */
> -	sk = vsock_find_connected_socket(&src, &dst);
> +	sk = vsock_find_connected_socket(&src, &dst, net);
>  	if (!sk) {
> -		sk = vsock_find_bound_socket(&dst);
> +		sk = vsock_find_bound_socket(&dst, net);
>  		if (!sk) {
>  			(void)virtio_transport_reset_no_sock(t, pkt);
>  			goto free_pkt;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 4b8b1150a738..3ad15d51b30b 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -669,6 +669,7 @@ static bool vmci_transport_stream_allow(u32 cid, u32 port)
>  
>  static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
>  {
> +	struct net *net = vsock_default_net();
>  	struct sock *sk;
>  	struct sockaddr_vm dst;
>  	struct sockaddr_vm src;
> @@ -702,9 +703,9 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
>  	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
>  	vsock_addr_init(&dst, pkt->dg.dst.context, pkt->dst_port);
>  
> -	sk = vsock_find_connected_socket(&src, &dst);
> +	sk = vsock_find_connected_socket(&src, &dst, net);
>  	if (!sk) {
> -		sk = vsock_find_bound_socket(&dst);
> +		sk = vsock_find_bound_socket(&dst, net);
>  		if (!sk) {
>  			/* We could not find a socket for this specified
>  			 * address.  If this packet is a RST, we just drop it.
> -- 
> 2.24.1


