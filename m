Return-Path: <linux-kernel+bounces-430696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7B9E347F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671BE165EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF718F2D4;
	Wed,  4 Dec 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmvMuBIz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9031ADFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298513; cv=none; b=NUB4G6LIIbTFGN7w/EfE2byN5J4z1DCRgPUNYqpZedeeu8qO65LUigr17TrIFf+5GneHC0FNGJJoQasH+/H+NfdFro8krX4xCqMqzYY9AxWq9SS542uICkpRihbeilmWbA3SSl3qlDwWaAAe7lVrwAl8P7S+783GqJuBNmknHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298513; c=relaxed/simple;
	bh=LMN8Ulwf59aLgyl4A1j1+zjAzdJwNO938nCa3KYT1UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbl5Q0BSe29D93leflHfu9Euh22wVb4gBA1kk1HBmy0mOzK6QGM5AMbdEhuZieKVktMkllIc15GI5pt+bX+dxAZHi0O19mhoYxqcuOpQZNkDtrOq3Ge/IFvLDkVvFgkIe5MEBc0oFHHTgC4AFRsOhOvKRQv4bv02ecCB/FcM6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmvMuBIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9x8r4zhIkxB5FDvVdvdm+yMP8eMcmsqzxa/soPgL/c=;
	b=CmvMuBIzzT69eKszZFVqsyjNfQOTSxcwZ9DpBtQgj4Qec0eNEXoLI8jCxBYjP23o7Hy/5j
	dRM3wNjYXetKOIyt+ioVFcUNhdsPQFJQz0VS99JtzTjIH3LQlHmz3I4UeAgwHrDopMEGS8
	bI6L6e4hUJZG4M1zjOGFBlV8JiBoGxw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-Nsi335YWNZKeu5eHReALGA-1; Wed,
 04 Dec 2024 02:48:26 -0500
X-MC-Unique: Nsi335YWNZKeu5eHReALGA-1
X-Mimecast-MFC-AGG-ID: Nsi335YWNZKeu5eHReALGA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 564F81955D53;
	Wed,  4 Dec 2024 07:48:25 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C09B83000199;
	Wed,  4 Dec 2024 07:48:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 16/39] rxrpc: Timestamp DATA packets before transmitting them
Date: Wed,  4 Dec 2024 07:46:44 +0000
Message-ID: <20241204074710.990092-17-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Move to setting the timestamp on DATA packets before transmitting them as
part of the preparation.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 56 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 3d992023f80f..400c3389d492 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -377,7 +377,8 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
  */
 static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_txbuf *txb,
 					   rxrpc_serial_t serial,
-					   int subpkt, int nr_subpkts)
+					   int subpkt, int nr_subpkts,
+					   ktime_t now)
 {
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	struct rxrpc_jumbo_header *jumbo = (void *)(whdr + 1) - sizeof(*jumbo);
@@ -437,8 +438,9 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc
 	rxrpc_inc_stat(call->rxnet, stat_why_req_ack[why]);
 	trace_rxrpc_req_ack(call->debug_id, txb->seq, why);
 	if (why != rxrpc_reqack_no_srv_last) {
-		txb->flags |= RXRPC_REQUEST_ACK;
 		flags |= RXRPC_REQUEST_ACK;
+		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
+		call->peer->rtt_last_req = now;
 	}
 dont_set_request_ack:
 
@@ -474,49 +476,25 @@ static size_t rxrpc_prepare_data_packet(struct rxrpc_call *call, struct rxrpc_tx
 {
 	struct rxrpc_txbuf *txb = head;
 	rxrpc_serial_t serial;
+	ktime_t now = ktime_get_real();
 	size_t len = 0;
 
 	/* Each transmission of a Tx packet needs a new serial number */
 	serial = rxrpc_get_next_serials(call->conn, n);
 
 	for (int i = 0; i < n; i++) {
-		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n);
-		serial++;
-		txb = list_next_entry(txb, call_link);
-	}
-
-	return len;
-}
-
-/*
- * Set timeouts after transmitting a packet.
- */
-static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbuf *txb, int n)
-{
-	rxrpc_serial_t serial;
-	ktime_t now = ktime_get_real();
-	bool ack_requested = txb->flags & RXRPC_REQUEST_ACK;
-	int i;
-
-	call->tx_last_sent = now;
-
-	for (i = 0; i < n; i++) {
 		txb->last_sent = now;
-		ack_requested |= txb->flags & RXRPC_REQUEST_ACK;
-		serial = txb->serial;
+		len += rxrpc_prepare_data_subpacket(call, txb, serial, i, n, now);
+		serial++;
 		txb = list_next_entry(txb, call_link);
 	}
 
-	if (ack_requested) {
-		rxrpc_begin_rtt_probe(call, serial, now, rxrpc_rtt_tx_data);
-
-		call->peer->rtt_last_req = now;
-		if (call->peer->rtt_count > 1) {
-			ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
+	/* Set timeouts */
+	if (call->peer->rtt_count > 1) {
+		ktime_t delay = rxrpc_get_rto_backoff(call->peer, false);
 
-			call->ack_lost_at = ktime_add(now, delay);
-			trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
-		}
+		call->ack_lost_at = ktime_add(now, delay);
+		trace_rxrpc_timer_set(call, delay, rxrpc_timer_trace_lost_ack);
 	}
 
 	if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags)) {
@@ -527,6 +505,7 @@ static void rxrpc_tstamp_data_packets(struct rxrpc_call *call, struct rxrpc_txbu
 	}
 
 	rxrpc_set_keepalive(call, now);
+	return len;
 }
 
 /*
@@ -538,6 +517,7 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	enum rxrpc_tx_point frag;
 	struct msghdr msg;
 	size_t len;
+	bool new_call = test_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags);
 	int ret;
 
 	_enter("%x,{%d}", txb->seq, txb->pkt_len);
@@ -605,20 +585,18 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	rxrpc_tx_backoff(call, ret);
 
-done:
-	if (ret >= 0) {
-		rxrpc_tstamp_data_packets(call, txb, n);
-	} else {
+	if (ret < 0) {
 		/* Cancel the call if the initial transmission fails,
 		 * particularly if that's due to network routing issues that
 		 * aren't going away anytime soon.  The layer above can arrange
 		 * the retransmission.
 		 */
-		if (!test_and_set_bit(RXRPC_CALL_BEGAN_RX_TIMER, &call->flags))
+		if (new_call)
 			rxrpc_set_call_completion(call, RXRPC_CALL_LOCAL_ERROR,
 						  RX_USER_ABORT, ret);
 	}
 
+done:
 	_leave(" = %d [%u]", ret, call->peer->max_data);
 	return ret;
 }


