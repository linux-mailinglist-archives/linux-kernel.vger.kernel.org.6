Return-Path: <linux-kernel+bounces-443608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3849EFA32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED751169FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4282210DE;
	Thu, 12 Dec 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2H25xck"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823871714BF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026257; cv=none; b=B8uC+bnVGbPzAq7o0BFtmyWcEM8L/5aO7OwEiAm8K7G+R5dY0fy0IbbIBWkObdh0ManGeewVCnWCZzFvOOD2xXRBOZb3ZnnAPoMQzULooOObe2w31MjBhoPPEyicYIfhGYQE7rcQ/QmHrnMuOjJ4atb9m/eH+DAlR+V83MCKRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026257; c=relaxed/simple;
	bh=SGWnhwCG7bUdH5/37zwwvjA/kYJvfqd/Sma6xg8mQ6Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eBOM28DFegHu/KInw8OCgIntCRLyBTE2UIaxaqqmavByZFd3Y9ZkoqFvLKbgVh6Wv8T8kKA78FzRN5lTNcE/fvjc/pbokA+5CyVjbK7KmPKQVLHNszaBm+G5eloOXOTTR/YIKZLyXOIwiasFiooq24WoLKqqfD7I8tMXVyLUXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2H25xck; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734026253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axCqQipikx9VXzzcJh4oGO9nT1q/4Een70xLtWcBooA=;
	b=d2H25xck8AsE051Cf0BHGegcew1MEfQQjtJ0YrVics0kbWvieP4Ry9DEPgDKLXedHhq3wD
	Up7g8F9F+vXUMIh6sFPp6v6RMwf1PyDLGw6pgTkELztX98wzmuUDQp0fEaTrjMYAa0oOCS
	zEiqgx0GzWGgr8aGHGN+FjAET28/pjg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-vdy2jl5rONidR9tRfZuZpQ-1; Thu,
 12 Dec 2024 12:57:30 -0500
X-MC-Unique: vdy2jl5rONidR9tRfZuZpQ-1
X-Mimecast-MFC-AGG-ID: vdy2jl5rONidR9tRfZuZpQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D03119560AE;
	Thu, 12 Dec 2024 17:57:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 737891953953;
	Thu, 12 Dec 2024 17:57:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6757fb68.050a0220.2477f.005f.GAE@google.com>
References: <6757fb68.050a0220.2477f.005f.GAE@google.com>
To: syzbot <syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com,
    horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] WARNING in rxrpc_send_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2863837.1734026244.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Dec 2024 17:57:24 +0000
Message-ID: <2863838.1734026244@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.g=
it main

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 0c0a3c89dba3..718193df9d2e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -571,6 +571,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_RX_LAST,		/* Received the last packet (at rxtx_top) */
 	RXRPC_CALL_TX_LAST,		/* Last packet in Tx buffer (at rxtx_top) */
 	RXRPC_CALL_TX_ALL_ACKED,	/* Last packet has been hard-acked */
+	RXRPC_CALL_TX_NO_MORE,		/* No more data to transmit (MSG_MORE deasserted=
) */
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
 	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index c4c8b718cafa..0e8da909d4f2 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -266,6 +266,7 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, =
struct rxrpc_call *call,
 	/* Order send_top after the queue->next pointer and txb content. */
 	smp_store_release(&call->send_top, seq);
 	if (last) {
+		set_bit(RXRPC_CALL_TX_NO_MORE, &call->flags);
 		rxrpc_notify_end_tx(rx, call, notify_end_tx);
 		call->send_queue =3D NULL;
 	}
@@ -329,6 +330,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	bool more =3D msg->msg_flags & MSG_MORE;
 	int ret, copied =3D 0;
 =

+	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		return -EPROTO;
+	}
+
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 =

 	ret =3D rxrpc_wait_to_be_connected(call, &timeo);


