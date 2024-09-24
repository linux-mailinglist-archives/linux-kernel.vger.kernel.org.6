Return-Path: <linux-kernel+bounces-337677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F7E984D65
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A993B223C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E57146D78;
	Tue, 24 Sep 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0SDUTNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B7146A7A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215693; cv=none; b=LRLcPO95mnWhmoMNKrTE9HPtCBBXWPEb4KC80J+M2N+Ygq5V+DXghBTtmF0b2qbu3cjTUhPw/bLC3L5hMWh+bc+nXo5ycfoBIVGDFNMr7iEyA9y3lkuYI7fjZKT4hlZT6EBPVV04jgyMIBEjNGOVWQAthVX7waiZ1SxnShXpNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215693; c=relaxed/simple;
	bh=XM1R/E+GZDsbMYwzwuScBr/8Mynr9WZp9/04dFBHH5I=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ldIe7EMpYar6vsrOUJ3IsinygOtAjPy6mjAvPJJOJ93muYzrpa3aT9DXvm6oSf2WwSVDrEJZUIpOLQuOBE6uUWfnZ6mK6LuG5wSoIS9nAx/6iG3Su30xUBr8eoCV1mztVEftWXSn350E3zCror7HbwSwYLlBRhJt1+KnliDIA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0SDUTNv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727215690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ze6Jh1dkudzhCy2kThDzWDTT7ZR0+ZKc4btmmg9o7DY=;
	b=T0SDUTNvzrCNaqLnrhv/Ah+PtZuOGib3w/7ujEE5RfKbuclXd9d8yqxYEmPbKcAlMGQ3zi
	pWt+NQZgTULnffqKQ53lyGTxWMna3wWOS7G6juL98DAH8qtjuJ/bOZF54r3zpuZIOKa4gU
	442HidUs67uAFk8AfR7rXI1bryAmZR4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-xV7ma4d9MJWHIH60R_6Wuw-1; Tue,
 24 Sep 2024 18:08:06 -0400
X-MC-Unique: xV7ma4d9MJWHIH60R_6Wuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B30118E68D2;
	Tue, 24 Sep 2024 22:08:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6754719560AD;
	Tue, 24 Sep 2024 22:08:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, yuxuanzhe@outlook.com,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix a race between socket set up and I/O thread creation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1210176.1727215681.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2024 23:08:01 +0100
Message-ID: <1210177.1727215681@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
thread that will handle it.  This is a problem, however, as there's a gap
between the two phases in which a packet may come into rxrpc_encap_rcv()
from the UDP packet but we oops when trying to wake the not-yet created I/=
O
thread.

As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
no I/O thread yet.

A better, but more intrusive fix would perhaps be to rearrange things such
that the socket creation is done by the I/O thread.

Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue and=
 I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
cc: yuxuanzhe@outlook.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h  |    2 +-
 net/rxrpc/io_thread.c    |    7 ++++---
 net/rxrpc/local_object.c |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 80d682f89b23..d0fd37bdcfe9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1056,7 +1056,7 @@ bool rxrpc_direct_abort(struct sk_buff *skb, enum rx=
rpc_abort_reason why,
 int rxrpc_io_thread(void *data);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
-	wake_up_process(local->io_thread);
+	wake_up_process(READ_ONCE(local->io_thread));
 }
 =

 static inline bool rxrpc_protocol_error(struct sk_buff *skb, enum rxrpc_a=
bort_reason why)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 0300baa9afcd..5c0a5374d51a 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -27,8 +27,9 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff =
*skb)
 {
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local =3D rcu_dereference_sk_user_data(udp_sk);
+	struct task_struct *io_thread =3D READ_ONCE(local->io_thread);
 =

-	if (unlikely(!local)) {
+	if (unlikely(!local || !io_thread)) {
 		kfree_skb(skb);
 		return 0;
 	}
@@ -47,7 +48,7 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff =
*skb)
 #endif
 =

 	skb_queue_tail(rx_queue, skb);
-	rxrpc_wake_up_io_thread(local);
+	wake_up_process(io_thread);
 	return 0;
 }
 =

@@ -565,7 +566,7 @@ int rxrpc_io_thread(void *data)
 	__set_current_state(TASK_RUNNING);
 	rxrpc_see_local(local, rxrpc_local_stop);
 	rxrpc_destroy_local(local);
-	local->io_thread =3D NULL;
+	WRITE_ONCE(local->io_thread, NULL);
 	rxrpc_see_local(local, rxrpc_local_stopped);
 	return 0;
 }
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 504453c688d7..f9623ace2201 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -232,7 +232,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local=
, struct net *net)
 	}
 =

 	wait_for_completion(&local->io_thread_ready);
-	local->io_thread =3D io_thread;
+	WRITE_ONCE(local->io_thread, io_thread);
 	_leave(" =3D 0");
 	return 0;
 =


