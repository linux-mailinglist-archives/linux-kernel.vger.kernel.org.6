Return-Path: <linux-kernel+bounces-517674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4582A38463
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AB53AC32A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83D21C9F4;
	Mon, 17 Feb 2025 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGI5w/qr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBC21C9E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797955; cv=none; b=Bo1AwCv+HiQi5EzGVRhngM7+xUSgZPt9Hh0YZSO4fYWs/6dzS/ql0CFA1ni58BqDSrqCExbnxoAbShTPkLgImrB+oZUV+o9ICQnnjsgW+8ctrBIWmGUDuOr50jcU1K7uV93uxGqx2T73HEyHSmSPQaRaHd1Fx4rZGdD55kmayRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797955; c=relaxed/simple;
	bh=7lxebOFXavNgwYliJWTj9B1sZfiJGlwD+50awa3TdEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxevXmPLeouvfgvpMxdWasMe9NtDctSu2eu1F/Y4OB8kMqrRev+SFnwClfvr6n/kfd8g4oQVyAk4DGXfRngzmIw+soxIvfhheDj5y5nZNDDphL8prExYxb2kqRjCVrBdvqqrkcVMpclSPhJhMdF8MvzMJvOlf76ImUajB3HMLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGI5w/qr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739797952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PP1VZXHqFJNyImLW6DDg7WEg0AroZyzUn2EupOxrJE=;
	b=MGI5w/qr9QMmWnvGgJOs/s56Nji1xTyUCSHwfb+23LMNenMNnsaolos7OEbuK0y0NMmq9l
	AgtNW+a0aOwig/1yXiDBfRtRFaLtCxh4H+bGctKvoIIBLSpTfT0jkKMYjSiFW5MPpZ40F7
	a7nahtKJt9l4fu9qaI0ZgdlCf+xBDcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-kwdyYN-mPEWJGUOwGr65JQ-1; Mon,
 17 Feb 2025 08:12:31 -0500
X-MC-Unique: kwdyYN-mPEWJGUOwGr65JQ-1
X-Mimecast-MFC-AGG-ID: kwdyYN-mPEWJGUOwGr65JQ_1739797950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A87D318D95E0;
	Mon, 17 Feb 2025 13:12:29 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 337E61800358;
	Mon, 17 Feb 2025 13:12:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 01/11] tracing: Fix DECLARE_TRACE_CONDITION
Date: Mon, 17 Feb 2025 14:11:52 +0100
Message-ID: <20250217131206.388485-2-gmonaco@redhat.com>
In-Reply-To: <20250217131206.388485-1-gmonaco@redhat.com>
References: <20250217131206.388485-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()") adds
macros to define conditional trace events (TRACE_EVENT_CONDITIONAL) and
tracepoints (DECLARE_TRACE_CONDITION), but sets up functionality for
direct use only for the former.

Add preprocessor bits in define_trace.h to allow usage of
DECLARE_TRACE_CONDITION just like DECLARE_TRACE.

Fixes: 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()")
Link: https://lore.kernel.org/linux-trace-kernel/20250128111926.303093-1-gmonaco@redhat.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/define_trace.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index e1c1079f8c8db..ed52d0506c69f 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -76,6 +76,10 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+#undef DECLARE_TRACE_CONDITION
+#define DECLARE_TRACE_CONDITION(name, proto, args, cond)	\
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
+
 /* If requested, create helpers for calling these tracepoints from Rust. */
 #ifdef CREATE_RUST_TRACE_POINTS
 #undef DEFINE_RUST_DO_TRACE
@@ -108,6 +112,8 @@
 /* Make all open coded DECLARE_TRACE nops */
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)
+#undef DECLARE_TRACE_CONDITION
+#define DECLARE_TRACE_CONDITION(name, proto, args, cond)
 
 #ifdef TRACEPOINTS_ENABLED
 #include <trace/trace_events.h>
@@ -129,6 +135,7 @@
 #undef DEFINE_EVENT_CONDITION
 #undef TRACE_HEADER_MULTI_READ
 #undef DECLARE_TRACE
+#undef DECLARE_TRACE_CONDITION
 
 /* Only undef what we defined in this file */
 #ifdef UNDEF_TRACE_INCLUDE_FILE
-- 
2.48.1


