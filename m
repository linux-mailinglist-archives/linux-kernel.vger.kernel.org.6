Return-Path: <linux-kernel+bounces-427711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4F9E06B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4067DB660FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8434205AC3;
	Mon,  2 Dec 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SovWGLjV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FC205AB6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149900; cv=none; b=ubq/90MhNzLVv5xzTYAX0i5fgOoGI3NtL7ZoyoMXOxQ7d6fF/TVI1FZWgPr4euUrR2aPP32zO3UPm6r1YU9JKDuR6yREVVOLYWodbOySpbez5wZPX+93aX4Q0eLNLz71/eHw2KFRQs/2ZqoYWZtzrDM5sHXQcANqMz++AX1nafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149900; c=relaxed/simple;
	bh=CYaWNczilBQQxRybIYsmO8leO0udzco+8cHBIiXxTAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2n+fTj8w0gFQo9Kb8xrW+obKPHj6tRUXaUoAnYuOz10ZjpJdVMQSfNtsqS4DLcVC8vEDAuNjX4h4YRNDjUFaSDUcPoGZ0tmayfjug9kQF+q8amR4l8V+81mgOVm57JhMNMJr0hp41fqM/LI56znzjqSrUwq1MN1ZD40PeHddIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SovWGLjV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12Usz2LdbarC0pVr9mHGx07BN0BAEeux0RoFdQjq1WE=;
	b=SovWGLjVmBp3lOmFUlverXq04qWyICB0WSv9y2WIstspTdM0Okg1gwA2IKTnKcwFJajNbh
	9BbuR27HHAskGAEDj48FZb5BtsTTJtuQK6Xk84fge2CbiiCDOZLL+A9zBOP9MFFIFUwLfp
	qI/+XouOivKZxl7jlurbLwYoVqLkNm0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-LYtdVBhdPKimdQVQhzx4Yg-1; Mon,
 02 Dec 2024 09:31:31 -0500
X-MC-Unique: LYtdVBhdPKimdQVQhzx4Yg-1
X-Mimecast-MFC-AGG-ID: LYtdVBhdPKimdQVQhzx4Yg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C47B1944AA9;
	Mon,  2 Dec 2024 14:31:29 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 653BF1955F56;
	Mon,  2 Dec 2024 14:31:26 +0000 (UTC)
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
Subject: [PATCH net-next 06/37] rxrpc: Request an ACK on impending Tx stall
Date: Mon,  2 Dec 2024 14:30:24 +0000
Message-ID: <20241202143057.378147-7-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Set the REQUEST-ACK flag on the DATA packet we're about to send if we're
about to stall transmission because the app layer isn't keeping up
supplying us with data to transmit.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 1 +
 net/rxrpc/ar-internal.h      | 2 +-
 net/rxrpc/output.c           | 7 ++++++-
 net/rxrpc/proc.c             | 5 +++--
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 62064f63d6eb..d86b5f07d292 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -452,6 +452,7 @@
 
 #define rxrpc_req_ack_traces \
 	EM(rxrpc_reqack_ack_lost,		"ACK-LOST  ")	\
+	EM(rxrpc_reqack_app_stall,		"APP-STALL ")	\
 	EM(rxrpc_reqack_more_rtt,		"MORE-RTT  ")	\
 	EM(rxrpc_reqack_no_srv_last,		"NO-SRVLAST")	\
 	EM(rxrpc_reqack_old_rtt,		"OLD-RTT   ")	\
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index fcdfbc1d5aaf..d0fd37bdcfe9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -110,7 +110,7 @@ struct rxrpc_net {
 	atomic_t		stat_tx_acks[256];
 	atomic_t		stat_rx_acks[256];
 
-	atomic_t		stat_why_req_ack[7];
+	atomic_t		stat_why_req_ack[8];
 
 	atomic_t		stat_io_loop;
 };
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 50d5f2a02458..b93a5d50be3e 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -330,7 +330,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
-	bool last;
+	bool last, more;
 	u8 flags;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
@@ -345,6 +345,9 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	last = txb->flags & RXRPC_LAST_PACKET;
 
+	more = (!list_is_last(&txb->call_link, &call->tx_buffer) ||
+		!list_empty(&call->tx_sendmsg));
+
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
@@ -366,6 +369,8 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 		why = rxrpc_reqack_more_rtt;
 	else if (ktime_before(ktime_add_ms(call->peer->rtt_last_req, 1000), ktime_get_real()))
 		why = rxrpc_reqack_old_rtt;
+	else if (!last && !more)
+		why = rxrpc_reqack_app_stall;
 	else
 		goto dont_set_request_ack;
 
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index cdf32f0d8e0e..ce4d48bdfbe9 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -520,10 +520,11 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]),
 		   atomic_read(&rxnet->stat_rx_acks[0]));
 	seq_printf(seq,
-		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u\n",
+		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u stall=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_more_rtt]),
-		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]));
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_old_rtt]),
+		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_app_stall]));
 	seq_printf(seq,
 		   "Why-Req-A: nolast=%u retx=%u slows=%u smtxw=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_no_srv_last]),


