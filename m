Return-Path: <linux-kernel+bounces-187355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCB8CD096
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D261F23AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F606144D15;
	Thu, 23 May 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLSk0J6A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5D143740
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461083; cv=none; b=WeYUvL8sqdPr1UbG1U42dO68/x8WaYRXyAqjWgVks2yxxUQQx0zQZgtBxo3idDapPXk81iRIA6sas0Xh1X4Mbf/QHrDaS5LdO4p3GNceY3dr9W7uoLqnmNzdIYcbVL07joJdoverbuPUpfQawBrVF0fvj8rH50VR7QLS6M70VWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461083; c=relaxed/simple;
	bh=8J5hGb0K/YyvM6E2DOrFaBEUfUsOqvbKT6LuI8BfOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCoHvnxXszB0B2hIjE/W0CRvYgUiHnmRkYSXAB5h3BBQVlehMzJRV/wbDUCcUjTXL7QZjoZut10oUW4u5mLc0+auFmPJcPHFiibTc2ypXFIxVt9h894XCbQsZcrDU2Twi+HHFuYdynbbP0lTkRiGegCyocsZCLDDsH1sXGLlurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLSk0J6A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yv5h7KKLQiB1kTjmD5ZvIpsXpj/cTIUbqVMlOTTEPnc=;
	b=hLSk0J6ApFVvgw1nYsP6vh20h0fmtGVyDXcAnmcJLmPfXON41DCZu4qnnXDh7kycslrnd0
	wERYSeiBuXyhVfoNmw5mPfUvn/JWLl7bkpidQfhdLWR7QyssKtplOPJbvaGHrlu72DtmDQ
	F4wZxQFoXZLrUuqZFzoZM2S8j3BX8fo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-r3xAOFO0Ph64j_C784cg0A-1; Thu, 23 May 2024 06:44:40 -0400
X-MC-Unique: r3xAOFO0Ph64j_C784cg0A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43d7cfc45abso183512791cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461079; x=1717065879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv5h7KKLQiB1kTjmD5ZvIpsXpj/cTIUbqVMlOTTEPnc=;
        b=uouy3WlY+LZG7YlTj0YmaWEf0HeLIZixikqmcL5pCnjd3XXfE78uRs/wlNUEZN5NfN
         fiG4C88ISWNKf/hSXZbvlLBMtv0lZrSERE7F83ZkqwcRwVgOoO70JjiZ5COb0gQM2fhV
         RMtVCmOxT3/wWkrDcpRIMkHLS097XGD041jidaYrE9c6F6hlghvyRjQDgVo3d6wwcu8K
         kfbkgg/tpG3D/QF2RiRnejG5D6Hi+0R7t6Fad4ixm6mUhNkkJvTz9H0f/QsbGutOQ08D
         bI2xoEWzeKeJ8kRtBik3sAd2rzLmODhlRmlOR+s4kj5FTme0A2jprdhLVRNbxzzghWKa
         P8fA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8u0EFtZSSk6Ohtj9iuP7b0HmKuoqpA5uwZ0nv5VGDCF/yttFmbI7ycFsCmkPUn3fBzONAcjAUCslG2dOyRxSme/t5jNKkN+cs3q3
X-Gm-Message-State: AOJu0YxIaB4U0PMtvtLO/KVb0CBsDPRvBCrcIQMdgHvqGzSgMkH5iRdZ
	CfqTOGH49sRYSAhuaC5s6bqquY/4E4pmcYuL3/IA6swh7T0d5KhgZ1zx9iFrZPTY08GMHmX+9CE
	9xqU4v5pPGc20GfNWnGjZusjQJI7PUhwkGPyNKYfsUy9XrdlV2DJTcn2XyzD1pw==
X-Received: by 2002:a05:6214:4909:b0:6ab:8d61:935a with SMTP id 6a1803df08f44-6ab8d619555mr24589336d6.48.1716461079520;
        Thu, 23 May 2024 03:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8AKYQ5aBJwwFLP+wiuytZldYqFzGqblzNbgk345xMFrhYXMS5dN3vaWwMS1u48yV6ypIjLw==
X-Received: by 2002:a05:6214:4909:b0:6ab:8d61:935a with SMTP id 6a1803df08f44-6ab8d619555mr24589186d6.48.1716461079196;
        Thu, 23 May 2024 03:44:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f179534sm142431096d6.17.2024.05.23.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:44:38 -0700 (PDT)
Date: Thu, 23 May 2024 12:44:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 4/5] vsock: seqpacket_allow adapts to multi-devices
Message-ID: <kkwdf7i27epcpv6zyuzsdgmpjfpswlpdtadnzkcighq7gyqosz@ylymoh6rsezn>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-5-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240517144607.2595798-5-niuxuewei.nxw@antgroup.com>

On Fri, May 17, 2024 at 10:46:06PM GMT, Xuewei Niu wrote:
>Adds a new argument, named "src_cid", to let them know which `virtio_vsock`
>to be selected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/net/af_vsock.h           |  2 +-
> net/vmw_vsock/af_vsock.c         | 15 +++++++++++++--
> net/vmw_vsock/virtio_transport.c |  4 ++--
> net/vmw_vsock/vsock_loopback.c   |  4 ++--
> 4 files changed, 18 insertions(+), 7 deletions(-)

Same for this.

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 0151296a0bc5..25f7dc3d602d 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -143,7 +143,7 @@ struct vsock_transport {
> 				     int flags);
> 	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 size_t len);
>-	bool (*seqpacket_allow)(u32 remote_cid);
>+	bool (*seqpacket_allow)(u32 src_cid, u32 remote_cid);
> 	u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
>
> 	/* Notification. */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index da06ddc940cd..3b34be802bf2 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -470,10 +470,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> {
> 	const struct vsock_transport *new_transport;
> 	struct sock *sk = sk_vsock(vsk);
>-	unsigned int remote_cid = vsk->remote_addr.svm_cid;
>+	unsigned int src_cid, remote_cid;
> 	__u8 remote_flags;
> 	int ret;
>
>+	remote_cid = vsk->remote_addr.svm_cid;
>+
> 	/* If the packet is coming with the source and destination CIDs higher
> 	 * than VMADDR_CID_HOST, then a vsock channel where all the packets are
> 	 * forwarded to the host should be established. Then the host will
>@@ -527,8 +529,17 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		return -ENODEV;
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
>+		if (vsk->local_addr.svm_cid == VMADDR_CID_ANY) {
>+			if (new_transport->get_default_cid)
>+				src_cid = new_transport->get_default_cid();
>+			else
>+				src_cid = new_transport->get_local_cid();
>+		} else {
>+			src_cid = vsk->local_addr.svm_cid;
>+		}
>+
> 		if (!new_transport->seqpacket_allow ||
>-		    !new_transport->seqpacket_allow(remote_cid)) {
>+		    !new_transport->seqpacket_allow(src_cid, remote_cid)) {
> 			module_put(new_transport->module);
> 			return -ESOCKTNOSUPPORT;
> 		}
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 998b22e5ce36..0bddcbd906a2 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -615,14 +615,14 @@ static struct virtio_transport virtio_transport = {
> 	.can_msgzerocopy = virtio_transport_can_msgzerocopy,
> };
>
>-static bool virtio_transport_seqpacket_allow(u32 remote_cid)
>+static bool virtio_transport_seqpacket_allow(u32 src_cid, u32 remote_cid)
> {
> 	struct virtio_vsock *vsock;
> 	bool seqpacket_allow;
>
> 	seqpacket_allow = false;
> 	rcu_read_lock();
>-	vsock = rcu_dereference(the_virtio_vsock);
>+	vsock = virtio_transport_get_virtio_vsock(src_cid);
> 	if (vsock)
> 		seqpacket_allow = vsock->seqpacket_allow;
> 	rcu_read_unlock();
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 6dea6119f5b2..b94358f5bb2c 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -46,7 +46,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> 	return 0;
> }
>
>-static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_seqpacket_allow(u32 src_cid, u32 remote_cid);
> static bool vsock_loopback_msgzerocopy_allow(void)
> {
> 	return true;
>@@ -104,7 +104,7 @@ static struct virtio_transport loopback_transport = {
> 	.send_pkt = vsock_loopback_send_pkt,
> };
>
>-static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
>+static bool vsock_loopback_seqpacket_allow(u32 src_cid, u32 remote_cid)
> {
> 	return true;
> }
>-- 
>2.34.1
>


