Return-Path: <linux-kernel+bounces-427715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010A9E054B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F416BCF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99008205E13;
	Mon,  2 Dec 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/pwKLks"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463420A5C7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149926; cv=none; b=h1Hf0le8RWTQjnT01VxmmuFxo2PNSlos/W8GVLteS8PFV5Eib8wrkOI1WHHsQZ2a4hf2vqUl5MmjHu78rM9QPFniEE2Sz981xzgOkCHRhhjdCP89kZcGkdedriCw2yPwMxXs0t8wWS/Y5GInqOoBgqD6kQ/EFhBzmfpGeHDZcz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149926; c=relaxed/simple;
	bh=CxHY/jNYTRw5lta5ohrvWT2sf01JXofy9GS3sEoa3zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5la/wIcenBc6d4zelcyQDdKQhlFhVyqIch/b0lS0+t6zR1pZf9raAZKKOFwxC5j9/UrwwfnJf3tTRnuVdRYI+A3CB+YcW3bFOinAHybio7kV91VIlEkW3sKQguvZJHbE/Rupp6LALgfCZhCbUSRQUoetCiqHhxONQDyxAN83SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/pwKLks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aUDw250URlX+OBsa9qiv+A9W4GQ14wrdL+2rCjG1IO8=;
	b=N/pwKLksyHy2avnIaZvtO1gs+47Z3iVrPOxuzrkgaNsWOTu8wxTFZ6+SMrVQ7pE1r6k0w1
	Y2mZF2iHeD8nn7+kS6zS5lvA5FYvqiPuJJ+k7YzeFEg0Oz9N4GTYOLq0uBSw+gBRjp3L/y
	GiJ9Mi9/TZR8kJcsWq8bQKpj6s0rDWM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-OyKNjObCPqiqozO83srR5w-1; Mon,
 02 Dec 2024 09:32:00 -0500
X-MC-Unique: OyKNjObCPqiqozO83srR5w-1
X-Mimecast-MFC-AGG-ID: OyKNjObCPqiqozO83srR5w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCFAE18DA858;
	Mon,  2 Dec 2024 14:31:57 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E5F3195605A;
	Mon,  2 Dec 2024 14:31:55 +0000 (UTC)
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
Subject: [PATCH net-next 13/37] rxrpc: Fix injection of packet loss
Date: Mon,  2 Dec 2024 14:30:31 +0000
Message-ID: <20241202143057.378147-14-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 net/rxrpc/output.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 4fc6e48e0e3e..56695c441514 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -543,16 +543,6 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 
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
@@ -578,6 +568,16 @@ static int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *t
 		frag = rxrpc_tx_point_call_data_nofrag;
 	}
 
+	if (IS_ENABLED(CONFIG_AF_RXRPC_INJECT_LOSS)) {
+		static int lose;
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


