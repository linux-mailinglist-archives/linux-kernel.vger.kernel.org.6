Return-Path: <linux-kernel+bounces-331000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B397A716
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816C71C2090D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B315B10A;
	Mon, 16 Sep 2024 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbmHrc6M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3D15958A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509524; cv=none; b=GRXbJledvV3CtVV8hVTe/39wkXymqxHzjSYqc0NyQr54jIaKn1YZG029fJUSvKIHoOguJKqnQ9jtq6qPBwHW0YNlZZtYXxN16GulG3HBPX3eQAERhQS8qA0Of1cgdVYShOu/lLVlidV/yIhcYQRMFiADpJI1CsEgQme+wq5mZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509524; c=relaxed/simple;
	bh=bJPhYjV1Ia+Z2638ng73cI1m7y7FpPcRshmyKsgcsrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC74S6mrdCE3vSCcLJaHquYR5mFNke6E1nDfEs8xWvpxmjFgeSBlxfdHRk3HZ7JIaU7dmj+OutHVYdQ33Nkb94imNuuJN7bdegVse8JjcJo13JVQKhCTj0w8PNA9KuRTUgcwEkqJ7bk16ZQdQPvorQkeMO9BM1zLpbUdX/tS/l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbmHrc6M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726509521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g83vBmJfBn8qhZUpht5ADDtAOeCHq/XCkkkKewo9hDw=;
	b=JbmHrc6MgrYwqzI/NbYK8k7sMdwEKvwcTFg446SoukC8XlbyRppNgF5Fxo9+gs993pNsNw
	iWQ6Y/9r37yUn3misSLmeyVNRREfZOF6YThgzHE7W9m+qW5JgkRbnmxdkO3YfkOiyQJL0G
	fUse2f0om+rxK+2/9EQ5XsFPw4U+Nvo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-2QkwuvQxPeaBODy0SoxaWg-1; Mon,
 16 Sep 2024 13:58:36 -0400
X-MC-Unique: 2QkwuvQxPeaBODy0SoxaWg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECBA1955DC4;
	Mon, 16 Sep 2024 17:58:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 633123001FEF;
	Mon, 16 Sep 2024 17:58:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Sep 2024 19:58:22 +0200 (CEST)
Date: Mon, 16 Sep 2024 19:58:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] function_graph: remove unnecessary initialization in
 ftrace_graph_ret_addr()
Message-ID: <20240916175818.GA28944@redhat.com>
References: <20240916135643.GA23958@redhat.com>
 <20240916123925.5398abdf@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916123925.5398abdf@rorschach.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

After the commit 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()")
ftrace_graph_ret_addr() doesn't need to initialize "int i" at the start.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..45c02bf18304 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -892,7 +892,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 {
 	struct ftrace_ret_stack *ret_stack;
 	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
-	int i = task->curr_ret_stack;
+	int i;
 
 	if (ret != return_handler)
 		return ret;
-- 
2.25.1.362.g51ebf55



