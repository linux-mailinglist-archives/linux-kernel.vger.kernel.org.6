Return-Path: <linux-kernel+bounces-430694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11039E3499
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03196B2B29A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96B1AAE17;
	Wed,  4 Dec 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWdM34vJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C681A3AB9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298503; cv=none; b=lWiZYMKogf6SeELxz6uMj/FJwX/RsbBCSFTNQUhhxo0DngolgDF3l1247pPbluSOKw5cX7+P5afnix1hrNw3AC5DMMiGBGXYlYEIR7/PrHO3rok0Jum+y382Tr4a427OtSzosB9YDhuZ5ld+uzF/ep2fMUUGHubNfcrfQkyWcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298503; c=relaxed/simple;
	bh=VMD9mWtrBmV7Zm/dSnkNbPv+VhBSXBtb83ceLg8MVpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXdKdfia6kBmZUB2U+sqIWSoL/EVboR70pzTgGsFxa7wQ/eklSSQP+QJ/tFt7K1G0HejSUZETXbWXXjOH8CXLmg7i0B66H/rurzlamBMJpn8tCIIhBjDr3sge0pMb0XC+hVETWWpjWLK5SUtPJBsnqHflon9w4asMRaHugp5JUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWdM34vJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QtepLyz9mX56IHlh2IlnxSf+nKmI3dlpCTIXv5ukb04=;
	b=XWdM34vJqX4hmw1Rt2Bzb0QL8n4BEeKx3e0nf34gjohiKMhm2BhiCkOsdE6xiU/C4E1SVc
	cHDju8B1TSXACcQ0n3oYeORXa+U21tzx5NL+G9v5q2ez16VbW8QgwmYcBQAZ8VSlaZ/SAl
	5SRIIXsAAE+fUznxqe65vwk9cCtC3G0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-FuEtMJZUPviFoMg6bDAKRg-1; Wed,
 04 Dec 2024 02:48:19 -0500
X-MC-Unique: FuEtMJZUPviFoMg6bDAKRg-1
X-Mimecast-MFC-AGG-ID: FuEtMJZUPviFoMg6bDAKRg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F13D1955F65;
	Wed,  4 Dec 2024 07:48:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F6DC1956096;
	Wed,  4 Dec 2024 07:48:14 +0000 (UTC)
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
Subject: [PATCH net-next v2 14/39] rxrpc: Fix injection of packet loss
Date: Wed,  4 Dec 2024 07:46:42 +0000
Message-ID: <20241204074710.990092-15-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix the code that injects packet loss for testing to make sure
call->tx_transmitted is updated.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index aededdd474d7..ca0da5e5d278 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -544,16 +544,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
 	len = rxrpc_prepare_data_packet(call, txb, n);
 
-	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
-		static int lose;
-		if ((lose++ & 7) == 7) {
-			ret = 0;
-			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
-					    txb->flags, true);
-			goto done;
-		}
-	}
-
 	iov_iter_kvec(&msg.msg_iter, WRITE, call->local->kvec, n, len);
 
 	msg.msg_name	= &call->peer->srx.transport;
@@ -579,6 +569,17 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
+	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
+		static int lose;
+
+		if ((lose++ & 7) == 7) {
+			ret = 0;
+			trace_rxrpc_tx_data(call, txb->seq, txb->serial,
+					    txb->flags, true);
+			goto done;
+		}
+	}
+
 retry:
 	/* send the packet by UDP
 	 * - returns -EMSGSIZE if UDP would have to fragment the packet


