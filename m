Return-Path: <linux-kernel+bounces-430692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0879E3479
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF5F280D83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF619F120;
	Wed,  4 Dec 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqdLdXA8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B1190678
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298499; cv=none; b=qnECLofWM6FuyaxXre/FuKkU8UVfrPKpAsS9e8dXfCUxGRwG9Ky2gEXOPkOBu9NHDod1EfI74zc/nNec9bvgYB+KcRt7HoYv3yYO3ql9AHQ/dwGHAAaCCR2upAAjMFO8d7/Tc3HmHPXncGgNjSuWjmmKP7NZy6xKUy/8G0BO1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298499; c=relaxed/simple;
	bh=rQ3W2F3r6HiohVE0vY/OBK/76HhFWdieLGVWaORhDMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgaQY2IX5WS6vmPr3w01cR7GgagMg+is0ukGF2eCxjWoKwdcUaL1TwcFnobiaTBDcy8Nrxo2JmVx7nENFgAUQUGGPwfvO63xK3HyVN97sIrhjeVbQIbp8DjuGv83WWhT6zMRV2XVmh/c6tje8OMZw64HNYcHxicJq5spOqkgb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqdLdXA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obq27x78dLFVc+cuRfM1jM6wMytnV14P+u4LaoDA4AU=;
	b=HqdLdXA8cgJ41qJ9M6979lVGI7wcVlOs1/9wewDUjDOBCLabo8x8Khdf2z17aH5DPpjUy5
	Xs2VFUDhkBPns9pBlquTtgJKeRuCx5IxhUPXVhnoFPKTr4eOSLZ4oEM9cTsl9E87xC6ZE2
	RY3N4ilxqQFv2xto59Zz+Qx8mDy2O64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-BMBAKCGQPB2UVxq5r-mOOg-1; Wed,
 04 Dec 2024 02:48:10 -0500
X-MC-Unique: BMBAKCGQPB2UVxq5r-mOOg-1
X-Mimecast-MFC-AGG-ID: BMBAKCGQPB2UVxq5r-mOOg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1763E1956054;
	Wed,  4 Dec 2024 07:48:09 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D4F41955D7F;
	Wed,  4 Dec 2024 07:48:05 +0000 (UTC)
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
Subject: [PATCH net-next v2 12/39] rxrpc: Add a tracepoint to show variables pertinent to jumbo packet size
Date: Wed,  4 Dec 2024 07:46:40 +0000
Message-ID: <20241204074710.990092-13-dhowells@redhat.com>
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

Add a tracepoint to be called right before packets are transmitted for the
first time that shows variable values that are pertinent to how many
subpackets will be added to a jumbo DATA packet.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 41 ++++++++++++++++++++++++++++++++++++
 net/rxrpc/call_event.c       |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 9dcadad88e76..71f07e726a90 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -903,6 +903,47 @@ TRACE_EVENT(rxrpc_txqueue,
 		      __entry->tx_winsize)
 	    );
 
+TRACE_EVENT(rxrpc_transmit,
+	    TP_PROTO(struct rxrpc_call *call, int space),
+
+	    TP_ARGS(call, space),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	call)
+		    __field(rxrpc_seq_t,	seq)
+		    __field(u16,		space)
+		    __field(u16,		tx_winsize)
+		    __field(u16,		cong_cwnd)
+		    __field(u16,		cong_extra)
+		    __field(u16,		in_flight)
+		    __field(u16,		prepared)
+		    __field(u16,		pmtud_jumbo)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call	= call->debug_id;
+		    __entry->seq	= call->tx_bottom;
+		    __entry->space	= space;
+		    __entry->tx_winsize	= call->tx_winsize;
+		    __entry->cong_cwnd	= call->cong_cwnd;
+		    __entry->cong_extra	= call->cong_extra;
+		    __entry->prepared	= call->tx_prepared - call->tx_bottom;
+		    __entry->in_flight	= call->tx_top - call->acks_hard_ack;
+		    __entry->pmtud_jumbo = call->peer->pmtud_jumbo;
+			   ),
+
+	    TP_printk("c=%08x q=%08x sp=%u tw=%u cw=%u+%u pr=%u if=%u pj=%u",
+		      __entry->call,
+		      __entry->seq,
+		      __entry->space,
+		      __entry->tx_winsize,
+		      __entry->cong_cwnd,
+		      __entry->cong_extra,
+		      __entry->prepared,
+		      __entry->in_flight,
+		      __entry->pmtud_jumbo)
+	    );
+
 TRACE_EVENT(rxrpc_rx_data,
 	    TP_PROTO(unsigned int call, rxrpc_seq_t seq,
 		     rxrpc_serial_t serial, u8 flags),
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 3379adfaaf65..1f716f09d441 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -259,6 +259,8 @@ static void rxrpc_decant_prepared_tx(struct rxrpc_call *call)
 		if (list_empty(&call->tx_sendmsg))
 			break;
 
+		trace_rxrpc_transmit(call, space);
+
 		spin_lock(&call->tx_lock);
 		do {
 			txb = list_first_entry(&call->tx_sendmsg,


