Return-Path: <linux-kernel+bounces-430725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD39E34B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAB285064
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7B20C475;
	Wed,  4 Dec 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw7pgcbY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4020C00C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298601; cv=none; b=OqsVcAz25q0ajYOscQ9zlko/pOS3KxAt5aoWKUDn2qtGlEbGkjCa8d2HOgF9twDe0+M49Z3qWQUXARhZhUuRupJgu2tcePfOqJxSzrp8UVqu1tLYmlwxWubqROUJHKtWUPSYRNytWiW6XuaNdWhmTeLUyz7039gZYM7qfZA2G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298601; c=relaxed/simple;
	bh=Adu58XXV9H5+J/t7envvVjBnaMNTj02DjDWWugq+ZwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8Fcz7dk+uTN+WKjQelSYQkK+kB78xuyjx/OZEWgmSW9ZyWJUAgBgEdRhJaU7MJpsF/IH/Gld+uCCaKFCNM7TRxi82eYeLpZbE78pE7SC1LK6OJ+sbzNTkz2AwKvszJK0F+CopmbN7894UWQrdFdE0Zjd77bpDQ0k2c/zqwZO6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xw7pgcbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U66dxHSg4iIqCI5/yRyoDqAI42q40uNW9nKzWmZRf5M=;
	b=Xw7pgcbYWlEUQ0AxjWCkWgQ7pUd7OR8vv2pUzbn2LWovANrA3NvREqZbjotq7xjL3oyw+/
	ebou5Hf6sd4NX3WQM3nvTZRKbn4rPrtp75PFhAd0iXDp20jCPYOb6up3GFn/+HvH7tqZ8V
	RqEcosvkTTIyzQdceVeyesPC3+eEiOU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-JbIjREoxN760gDkNz5qZUQ-1; Wed,
 04 Dec 2024 02:49:55 -0500
X-MC-Unique: JbIjREoxN760gDkNz5qZUQ-1
X-Mimecast-MFC-AGG-ID: JbIjREoxN760gDkNz5qZUQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BAAE19560B6;
	Wed,  4 Dec 2024 07:49:54 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A20CD1956048;
	Wed,  4 Dec 2024 07:49:51 +0000 (UTC)
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
Subject: [PATCH net-next v2 38/39] rxrpc: Fix request for an ACK when cwnd is minimum
Date: Wed,  4 Dec 2024 07:47:06 +0000
Message-ID: <20241204074710.990092-39-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rxrpc_prepare_data_subpacket() sets the REQUEST-ACK flag on the outgoing
DATA packet under a number of circumstances, including, theoretically, when
the cwnd is at minimum (or less).  However, the minimum in this function is
hard-coded as 2, but the actual minimum is RXRPC_MIN_CWND (which is
currently 4) and so this never occurs.

Without this, we will miss the request of some ACKs, potentially leading to
a transmission stall until a timeout occurs on one side or the other that
leads to an ACK being generated.

Fix the function to use RXRPC_MIN_CWND rather than a hard-coded number.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ecaf3becee40..f934551a9b1c 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -469,7 +469,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_ack_lost;
 	else if (txb->flags & RXRPC_TXBUF_RESENT)
 		why = rxrpc_reqack_retrans;
-	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= 2)
+	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= RXRPC_MIN_CWND)
 		why = rxrpc_reqack_slow_start;
 	else if (call->tx_winsize <= 2)
 		why = rxrpc_reqack_small_txwin;


