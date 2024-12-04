Return-Path: <linux-kernel+bounces-430695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1F9E347E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BB32811E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC151AD3E1;
	Wed,  4 Dec 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3Eg+JNt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89591AC8AE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298508; cv=none; b=OoVk/lPmqXvG6R5Cp74+JbpQXzUUnnx/VaOgD6Si2r6Vgtu9QNHAGZSgD/eCNbhHTMs2mqTfquViGXOreQz/6VqoCVw1LOYM5TfYDqXqCekaHY8isN+yIQOgNt6feUk0x4J7JEs+C0mU6HyovpeoeOpgssXzclsm6lALKqFYNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298508; c=relaxed/simple;
	bh=kwWNJon5tF+ZpO4VrTE0syMyju+rtDmEaAbMdLuwYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtAO+/DWOhtbv1v/j8RWI5DHu89hwzNHvVtrCns0pruBPtaCrd9LhVVN7S60S76Usc8R8OlY4peKzIuS8zNvmV7whgBaeSeJUlZScEkMUG1qv0w/rYc8KprXGdoh+1EKl6wR+iETG9UBPBD+W4qm4IeI2Ua9wVOmea5Ta6wTFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3Eg+JNt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTcDYAEKtlW5jKg5FtPGQRlYX8oFH03zEIRGRCv7L3E=;
	b=I3Eg+JNtfjz+aNmkEEWUuo2lV+BVBqpeFKmhyW5gFkdw2ej8ZLsy+3kMKTnLjeKsFMM9mE
	ElLsrow7upe7+XPyBsUstxAlGeuNN3c/5Jpy34CYCkANuDSy0D3adnXIJUsC3fwHbgPyWs
	HAlRvaJhchDaXU2xGTfyIgj7NIEae7k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-m9lI8ngFNASOAUFoILV2cA-1; Wed,
 04 Dec 2024 02:48:22 -0500
X-MC-Unique: m9lI8ngFNASOAUFoILV2cA-1
X-Mimecast-MFC-AGG-ID: m9lI8ngFNASOAUFoILV2cA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5155B1954AF2;
	Wed,  4 Dec 2024 07:48:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A55B1956054;
	Wed,  4 Dec 2024 07:48:18 +0000 (UTC)
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
Subject: [PATCH net-next v2 15/39] rxrpc: Only set DF=1 on initial DATA transmission
Date: Wed,  4 Dec 2024 07:46:43 +0000
Message-ID: <20241204074710.990092-16-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Change how the DF flag is managed on DATA transmissions.  Set it on initial
transmission and don't set it on retransmissions.  Then remove the handling
for EMSGSIZE in rxrpc_send_data_packet() and just pretend it didn't happen,
leaving it to the retransmission path to retry.

The path-MTU discovery using PING ACKs is then used to probe for the
maximum DATA size - though notification by ICMP will be used if one is
received.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h |  1 +
 net/rxrpc/output.c      | 32 ++++++++++++++++----------------
 net/rxrpc/proc.c        |  5 +++--
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 55cc68dd1b40..84efa21f176c 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -98,6 +98,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_data_send;
 	atomic_t		stat_tx_data_send_frag;
 	atomic_t		stat_tx_data_send_fail;
+	atomic_t		stat_tx_data_send_msgsize;
 	atomic_t		stat_tx_data_underflow;
 	atomic_t		stat_tx_data_cwnd_reset;
 	atomic_t		stat_rx_data;
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ca0da5e5d278..3d992023f80f 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -552,16 +552,11 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	msg.msg_controllen = 0;
 	msg.msg_flags	= MSG_SPLICE_PAGES;
 
-	/* Track what we've attempted to transmit at least once so that the
-	 * retransmission algorithm doesn't try to resend what we haven't sent
-	 * yet.
+	/* Send the packet with the don't fragment bit set unless we think it's
+	 * too big or if this is a retransmission.
 	 */
-	if (txb->seq == call->tx_transmitted + 1)
-		call->tx_transmitted = txb->seq + n - 1;
-
-	/* send the packet with the don't fragment bit set if we currently
-	 * think it's small enough */
-	if (len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
+	if (txb->seq == call->tx_transmitted + 1 &&
+	    len >= sizeof(struct rxrpc_wire_header) + call->peer->max_data) {
 		rxrpc_local_dont_fragment(conn->local, false);
 		frag = rxrpc_tx_point_call_data_frag;
 	} else {
@@ -569,6 +564,13 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
+	/* Track what we've attempted to transmit at least once so that the
+	 * retransmission algorithm doesn't try to resend what we haven't sent
+	 * yet.
+	 */
+	if (txb->seq == call->tx_transmitted + 1)
+		call->tx_transmitted = txb->seq + n - 1;
+
 	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
 		static int lose;
 
@@ -580,7 +582,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		}
 	}
 
-retry:
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet
 	 *   to go out of the interface
@@ -591,7 +592,11 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	conn->peer->last_tx_at = ktime_get_seconds();
 
-	if (ret < 0) {
+	if (ret == -EMSGSIZE) {
+		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_msgsize);
+		trace_rxrpc_tx_packet(call->debug_id, call->local->kvec[0].iov_base, frag);
+		ret = 0;
+	} else if (ret < 0) {
 		rxrpc_inc_stat(call->rxnet, stat_tx_data_send_fail);
 		trace_rxrpc_tx_fail(call->debug_id, txb->serial, ret, frag);
 	} else {
@@ -599,11 +604,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 	}
 
 	rxrpc_tx_backoff(call, ret);
-	if (ret == -EMSGSIZE && frag == rxrpc_tx_point_call_data_nofrag) {
-		rxrpc_local_dont_fragment(conn->local, false);
-		frag = rxrpc_tx_point_call_data_frag;
-		goto retry;
-	}
 
 done:
 	if (ret >= 0) {
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 44722c226064..249e1ed9c5c9 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -473,10 +473,11 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 	struct rxrpc_net *rxnet = rxrpc_net(seq_file_single_net(seq));
 
 	seq_printf(seq,
-		   "Data     : send=%u sendf=%u fail=%u\n",
+		   "Data     : send=%u sendf=%u fail=%u emsz=%u\n",
 		   atomic_read(&rxnet->stat_tx_data_send),
 		   atomic_read(&rxnet->stat_tx_data_send_frag),
-		   atomic_read(&rxnet->stat_tx_data_send_fail));
+		   atomic_read(&rxnet->stat_tx_data_send_fail),
+		   atomic_read(&rxnet->stat_tx_data_send_msgsize));
 	seq_printf(seq,
 		   "Data-Tx  : nr=%u retrans=%u uf=%u cwr=%u\n",
 		   atomic_read(&rxnet->stat_tx_data),


