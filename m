Return-Path: <linux-kernel+bounces-430686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72E9E346D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2361168755
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BD1925B9;
	Wed,  4 Dec 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFRbcGJ0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B077192580
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298469; cv=none; b=CIidxJmmY5cFAIG3ZAavfHL5000vc/XkYi/qoWpdVu2hHAUXBT/81wl9Y4o7qsU7VlHYRmrIVDlrCQOyidh6i8yisA0E/bukr7XTAtymsfFmNAkf6zfnKcru2J8zyLsurEv+4pxnPeRDvU+hkPA55+AEIY9K1Y+VKanHyUbZKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298469; c=relaxed/simple;
	bh=AZ7lDyNSKB/HD+ctLesXC+cPvo0gwbx5oHUqbI7hpVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9P13I67xXsMloqMEeSmxhlEXG0T6uO09KAPrsVH0taxhucTPITk8eAY2bR1n6vat3cBRDZBgTxIeQpP801RzHDq2NurCm6lu8CLMr6Ka1x/ZkpuhrkCK71YYn606O+IB/9G+Tm4bJGaUHPaURS6RuHh6L+WY/oDfBG03oiF5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFRbcGJ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kXP4fALYJr9uIGcA5czI2cKiY8B4VASJULQ3cokVnw=;
	b=VFRbcGJ0xgAe+yz5n3Tcnv0/cOpnRNKHQV1Zq4yA/4bLmxqvYbDEbMoc1MPaNkay//6Hab
	OiWG+fr/WROOySqhzbetS9s2+yHsZKoRpTn/3rvp4Dcf0ldHTrOI3WcgrjhQ+HjfHXc+Gw
	xIFSqMsKp4uJY1PB6DJ0+VtCswo+Gx0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-kRaEhlarPZK--7Ld8TNxFQ-1; Wed,
 04 Dec 2024 02:47:44 -0500
X-MC-Unique: kRaEhlarPZK--7Ld8TNxFQ-1
X-Mimecast-MFC-AGG-ID: kRaEhlarPZK--7Ld8TNxFQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94FC61955DCA;
	Wed,  4 Dec 2024 07:47:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B0C81956054;
	Wed,  4 Dec 2024 07:47:39 +0000 (UTC)
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
Subject: [PATCH net-next v2 06/39] rxrpc: Show stats counter for received reason-0 ACKs
Date: Wed,  4 Dec 2024 07:46:34 +0000
Message-ID: <20241204074710.990092-7-dhowells@redhat.com>
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

In /proc/net/rxrpc/stats, show the stats counter for received ACKs that
have the reason code set to 0 as some implementations do this.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 3b7e34dd4385..cdf32f0d8e0e 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -508,7 +508,7 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_tx_acks[RXRPC_ACK_DELAY]),
 		   atomic_read(&rxnet->stat_tx_acks[RXRPC_ACK_IDLE]));
 	seq_printf(seq,
-		   "Ack-Rx   : req=%u dup=%u oos=%u exw=%u nos=%u png=%u prs=%u dly=%u idl=%u\n",
+		   "Ack-Rx   : req=%u dup=%u oos=%u exw=%u nos=%u png=%u prs=%u dly=%u idl=%u z=%u\n",
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_REQUESTED]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_DUPLICATE]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_OUT_OF_SEQUENCE]),
@@ -517,7 +517,8 @@ int rxrpc_stats_show(struct seq_file *seq, void *v)
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_PING]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_PING_RESPONSE]),
 		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_DELAY]),
-		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]));
+		   atomic_read(&rxnet->stat_rx_acks[RXRPC_ACK_IDLE]),
+		   atomic_read(&rxnet->stat_rx_acks[0]));
 	seq_printf(seq,
 		   "Why-Req-A: acklost=%u mrtt=%u ortt=%u\n",
 		   atomic_read(&rxnet->stat_why_req_ack[rxrpc_reqack_ack_lost]),


