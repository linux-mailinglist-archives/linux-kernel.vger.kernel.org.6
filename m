Return-Path: <linux-kernel+bounces-330739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1697A3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE58B28D11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1F158D63;
	Mon, 16 Sep 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auUZxqA5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15395158A3D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495079; cv=none; b=rQOscUwGh/N2Ay3Ta4h23TpRsOMUHPdw5AsUhlEyw2trWxtOW4tH+ZkLdzIxxIP7HMnhbMvJuEegqo9eqqWHghC1EgTIj+Br4gS5d+36xkjwErNb9IBZ6GuhX2+ANMDsHxFk5e9Gki89HQwn7c6l9D9nYLoU4wjOq4CzLTyLrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495079; c=relaxed/simple;
	bh=bhLUWtKpFgWNf+sO48JGdTVG5DI4mhzhIdCqbtGu7Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=caKq6C0CbscTu8MUKLMR5Y8k83qxuXXgCzEgqLb/roL0KOvdQUpy2x+sNG0z4uy/DWqnThbKy4tMR6apndoS1mRAFIsoZ2VgM1FX1jQivc5wD7nD/+y42ns1GOxyMubCklHqmyYWoenoahQ1/Mdnds3hBXN2Qh19wXvj8XVlMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auUZxqA5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726495077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qSe9nFsajjGVrtPKEEXutUfChv6Aj3O/z4jWE4PSPPE=;
	b=auUZxqA59MMUGgAKFn7D0T3xrVIB430hOb/u3SEbSsTC1we6s2q7O8Bvq+XWQAL1nFBvgp
	AYziRZujx4S9+gkJLMXfW3ni41AIVM12+3G8NyXnA8ocIm4NPNaFDrDaM2pbDIK8Wn+NFu
	kaKNaKirOF7N7wCB5CBBqOwq2O2DHQQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-zye9ehsvMAG4Fe_pf_1wSA-1; Mon,
 16 Sep 2024 09:57:51 -0400
X-MC-Unique: zye9ehsvMAG4Fe_pf_1wSA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB6E19772F5;
	Mon, 16 Sep 2024 13:56:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.82])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3143A19560AA;
	Mon, 16 Sep 2024 13:56:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Sep 2024 15:56:47 +0200 (CEST)
Date: Mon, 16 Sep 2024 15:56:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] function_graph: remove unnecessary initialization in
 ftrace_graph_ret_addr()
Message-ID: <20240916135643.GA23958@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After the commit 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()")
ftrace_graph_ret_addr() doesn't need to initialize "int i" at the start.

While at it, move the declaration of "ret_stack" into the main loop.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/trace/fgraph.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f..d45a8bc97997 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -890,9 +890,8 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp)
 {
-	struct ftrace_ret_stack *ret_stack;
 	unsigned long return_handler = (unsigned long)dereference_kernel_function_descriptor(return_to_handler);
-	int i = task->curr_ret_stack;
+	int i;
 
 	if (ret != return_handler)
 		return ret;
@@ -902,7 +901,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 	i = *idx ? : task->curr_ret_stack;
 	while (i > 0) {
-		ret_stack = get_ret_stack(task, i, &i);
+		struct ftrace_ret_stack *ret_stack = get_ret_stack(task, i, &i);
 		if (!ret_stack)
 			break;
 		/*
-- 
2.25.1.362.g51ebf55



