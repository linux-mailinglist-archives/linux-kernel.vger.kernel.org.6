Return-Path: <linux-kernel+bounces-443936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C199EFDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41886166CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2B1CCEF7;
	Thu, 12 Dec 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMci/AnF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605F1D88DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037249; cv=none; b=NSyrTLGVqrGm/RLKTFKbTIJwBbzo2/EQpmsbEMIhFiXVYeIpfcWsGJPYmm6DYoyVUYuSzj8FT14r3pKO7Rl4plSZ/UxbgP8FUOo6GYP8m5rkXPrl9WrGqnHtahOA+b3FUoY3a/OJrVZzEJbQE5fgwumROD/1c/zut5eSIyn4Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037249; c=relaxed/simple;
	bh=mCxjbuKIiSpqirO2ikeRly0lHqVcOMbZjGyeVtXu4iw=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=u8cRWJJHOptr/7OO6QjrDAuFbU89WPQprxmu7xtX5s+JZ50EgGmzoj1qI1eUQ/efYrHn53XjwcHzwYVAWKHVa2MjkEL2QAkqoNUzLhJ6VZ1MEnDGkYAs9PyCJYsYc1lvKg590gRlP7Xu0ytVJaNToQIO053zi7fGwQOiCzuPSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMci/AnF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734037246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tmb1jWowLlCd0jZgM7/9HiZklevZ5eWN6YC/v1oFOAk=;
	b=cMci/AnFFYpS6Zw598GG6KZjvwFsdNQJRnzlihKWz15afrOF8lgBbp/0TUQKmW675ZqxxS
	NQGqYHS9VwImKf7+RYyjgArz6xyPAcyyB78tDSZ9tGuZeLkWPGHLUl49XLOYeBSIvbntPp
	jzP8Way23CbVb1Vanjti+E4PtKQGp0o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-ST-56M6aO0GP86PuPVKm4w-1; Thu,
 12 Dec 2024 16:00:41 -0500
X-MC-Unique: ST-56M6aO0GP86PuPVKm4w-1
X-Mimecast-MFC-AGG-ID: ST-56M6aO0GP86PuPVKm4w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9272D1955E85;
	Thu, 12 Dec 2024 21:00:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 829B3195395A;
	Thu, 12 Dec 2024 21:00:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: Fix ability to add more data to a call once MSG_MORE deasserted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2870276.1734037236.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Dec 2024 21:00:36 +0000
Message-ID: <2870277.1734037236@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

    =

When userspace is adding data to an RPC call for transmission, it must pas=
s
MSG_MORE to sendmsg() if it intends to add more data in future calls to
sendmsg().  Calling sendmsg() without MSG_MORE being asserted closes the
transmission phase of the call (assuming sendmsg() adds all the data
presented) and further attempts to add more data should be rejected.

However, this is no longer the case.  The change of call state that was
previously the guard got bumped over to the I/O thread, which leaves a
window for a repeat sendmsg() to insert more data.  This previously went
unnoticed, but the more recent patch that changed the structures behind th=
e
Tx queue added a warning:

        WARNING: CPU: 3 PID: 6639 at net/rxrpc/sendmsg.c:296 rxrpc_send_da=
ta+0x3f2/0x860

and rejected the additional data, returning error EPROTO.

Fix this by adding a guard flag to the call, setting the flag when we queu=
e
the final packet and then rejecting further attempts to add data with
EPROTO.

Fixes: 2d689424b618 ("rxrpc: Move call state changes from sendmsg to I/O t=
hread")
Reported-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6757fb68.050a0220.2477f.005f.GAE@google.=
com/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+ff11be94dfcd7a5af8da@syzkaller.appspotmail.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/sendmsg.c     |    8 ++++++++
 2 files changed, 9 insertions(+)

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


