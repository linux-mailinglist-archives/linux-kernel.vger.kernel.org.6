Return-Path: <linux-kernel+bounces-345966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C898BD7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E9A1C237C8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79191C57BF;
	Tue,  1 Oct 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnP/FjqM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA311C57B4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789243; cv=none; b=Q/B7Sy7JcztnQBLB746e1p6DdqWsYMYh7P8mQTkSQRtsrfw8FOHd7/oD4iSkSo0HZ4cfr6s01+iUmSi5XmA73nK80MHTG3xR46seO0Bv9O7w+26OM32QOkK7/ulSli65KSPn9XqMJKPkNYsH1/u0U2GWdX71L30wVCAAzZ3B2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789243; c=relaxed/simple;
	bh=JNzAp1yMKbV8lpc6uCr8lJxmSscW4K2GTVrGuzAx3SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX+0bCLI3e0fWR7c2FvwfuI9t2sBeFwv87IqCIRKy3CNikgOhUSwVnTAaENJKGOHOd/ggtX8UvtaiC9QEUg3WxI3hV3q2EpjJdgtXnXaT2W9yQePFA3QPTL1lf9/jrIulx3Kk9DwlhR13sCdVE0mTrpyI3W37fY5N14HSQ5oud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnP/FjqM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727789240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+K/uFnjY9rI4dQD1VXRi5j3BHKaMNfn7A9yy5gGESz4=;
	b=FnP/FjqMtRKtkm9h9nbwb3K5YTzWsGspRTn7p2YMj9lGw5BtuNe35iJ/jiWQ2wD8fzr504
	jLiuhW3LCtGAQk/jHxtw8gSrnNki2KqPI1K9gNIV6nMGqbL0PhK0IOMysqCkL9S41wboTN
	XCC66ahRSOa6oEtmTeCnoNhu48hxLFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-aMLXcemqPdW0D3y3Ac5Upg-1; Tue,
 01 Oct 2024 09:27:17 -0400
X-MC-Unique: aMLXcemqPdW0D3y3Ac5Upg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 214941943CDC;
	Tue,  1 Oct 2024 13:27:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AD113003DEC;
	Tue,  1 Oct 2024 13:27:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net 2/2] rxrpc: Fix uninitialised variable in rxrpc_send_data()
Date: Tue,  1 Oct 2024 14:26:59 +0100
Message-ID: <20241001132702.3122709-3-dhowells@redhat.com>
In-Reply-To: <20241001132702.3122709-1-dhowells@redhat.com>
References: <20241001132702.3122709-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the uninitialised txb variable in rxrpc_send_data() by moving the code
that loads it above all the jumps to maybe_error, txb being stored back
into call->tx_pending right before the normal return.

Fixes: b0f571ecd794 ("rxrpc: Fix locking in rxrpc's sendmsg")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2024-October/008896.html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 894b8fa68e5e..23d18fe5de9f 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -303,6 +303,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
+	txb = call->tx_pending;
+	call->tx_pending = NULL;
+	if (txb)
+		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
+
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		goto maybe_error;
@@ -329,11 +334,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			goto maybe_error;
 	}
 
-	txb = call->tx_pending;
-	call->tx_pending = NULL;
-	if (txb)
-		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
-
 	do {
 		if (!txb) {
 			size_t remain;


