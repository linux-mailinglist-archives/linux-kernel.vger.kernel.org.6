Return-Path: <linux-kernel+bounces-398262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18979BECF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2AB1F217EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628081F76B5;
	Wed,  6 Nov 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnPd16El"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438E1EE01C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898056; cv=none; b=rDYfFP2rVc6jKbQvgHSaiRaAxaZn8zJnIx/g39cDaex/aBTwUMvDeVbbYGnStMs2XJW6t9fdCjFYjpDXrQK6jh1Eo2xc/8j3pHl9VJZbkgkUskOWdScq9gxiqt1kEEkUEC+DejD7jseiU3f/GvfVatgenJ4q0t48rJIlFQ8njDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898056; c=relaxed/simple;
	bh=QQCqKvtPt8YinCEAsZUCxcrG2xQJRRuu3P8vQdgq1Cs=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=H7gP6CBkc+gDfw3HX2Kxww0aBqRp4eB0bqXL5aGZj9j7PnNFRIzUBMZ3xlEUqXwmlheykgvw5bYi456EftDJE57YxhfL5gM+xjYw5u4mdiL8axc3c7FgXPPHBorvpqvxpAZD2JD766ONzmQQevPN4YcQGX4g+s72Vzsubk52rWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnPd16El; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730898054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7zc2UPyvhc/gaG96Z14+cpV1YeG2vT5ilG2eZvzA9MI=;
	b=MnPd16Elh3BeDIKx2gkwxMjjcUHsUebBQMrC4kkSWurPClyF9jH+70UzLbInzNIBqntuCY
	Y54f8QkwKnYBzvY3WKGsVPSduWhCARXIuulsL46HEMq1AVpk0mcR1zw7xxTVUikHGBX/SX
	iI22pZVF/DiMvjQB0UTfQql9ne0UCys=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-ee2LlgR9O5KgykoE8c0VTg-1; Wed,
 06 Nov 2024 08:00:50 -0500
X-MC-Unique: ee2LlgR9O5KgykoE8c0VTg-1
X-Mimecast-MFC-AGG-ID: ee2LlgR9O5KgykoE8c0VTg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECBCC19560A2;
	Wed,  6 Nov 2024 13:00:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F66330000DF;
	Wed,  6 Nov 2024 13:00:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rxrpc: Add a tracepoint for aborts being proposed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726355.1730898045.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Nov 2024 13:00:45 +0000
Message-ID: <726356.1730898045@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a tracepoint to rxrpc to trace the proposal of an abort.  The abort is
performed asynchronously by the I/O thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h |   25 +++++++++++++++++++++++++
 net/rxrpc/sendmsg.c          |    1 +
 2 files changed, 26 insertions(+)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index a1b126a6b0d7..c2f087e90fbe 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -772,6 +772,31 @@ TRACE_EVENT(rxrpc_rx_done,
 	    TP_printk("r=3D%d a=3D%d", __entry->result, __entry->abort_code)
 	    );
 =

+TRACE_EVENT(rxrpc_abort_call,
+	    TP_PROTO(const struct rxrpc_call *call, int abort_code),
+
+	    TP_ARGS(call, abort_code),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call_nr)
+		    __field(enum rxrpc_abort_reason,	why)
+		    __field(int,			abort_code)
+		    __field(int,			error)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call_nr	=3D call->debug_id;
+		    __entry->why	=3D call->send_abort_why;
+		    __entry->abort_code	=3D abort_code;
+		    __entry->error	=3D call->send_abort_err;
+			   ),
+
+	    TP_printk("c=3D%08x a=3D%d e=3D%d %s",
+		      __entry->call_nr,
+		      __entry->abort_code, __entry->error,
+		      __print_symbolic(__entry->why, rxrpc_abort_reasons))
+	    );
+
 TRACE_EVENT(rxrpc_abort,
 	    TP_PROTO(unsigned int call_nr, enum rxrpc_abort_reason why,
 		     u32 cid, u32 call_id, rxrpc_seq_t seq, int abort_code, int error),
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 23d18fe5de9f..6abb8eec1b2b 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -29,6 +29,7 @@ bool rxrpc_propose_abort(struct rxrpc_call *call, s32 ab=
ort_code, int error,
 		call->send_abort_why =3D why;
 		call->send_abort_err =3D error;
 		call->send_abort_seq =3D 0;
+		trace_rxrpc_abort_call(call, abort_code);
 		/* Request abort locklessly vs rxrpc_input_call_event(). */
 		smp_store_release(&call->send_abort, abort_code);
 		rxrpc_poke_call(call, rxrpc_call_poke_abort);


