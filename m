Return-Path: <linux-kernel+bounces-572734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57844A6CDE4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBC73AA9E1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5D2010E3;
	Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D875136E3F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742706535; cv=none; b=luqKcTYKYjuObxggHGzwdcM1KlNaVUPwTA7BZZSPUVaK0616In1n3mHHypw7RwiaX0a1MMF2JhT23ukqFiVqLPpkkKtCOw7f2fxG5jjU5WJFmTTpjAOZ5qAAqwc5kn5meBaYmZLj1OMzJ8crj0t56ofW1v4EmbYT7/SxJYRKIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742706535; c=relaxed/simple;
	bh=P50jUIRYNPDF1+7DYvV/qhb2YN3tv7N1DLLjMTixseI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rnJLxZMHhol+TycV5MqNiRjQOVKh7BMgyTmJueMUPe2Tuy87HmiGTzRqS5vJpzhqwvFpQD6c28FpLVet8Ef2KJKTP+6OVLoDzfz2F5FveqWGAdVjnp8dr5prVqBlLm/h6qMGPQqymcPmmz2t0pto6DZRLpw7iNIe4KCmHMc5+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED812C4CEE2;
	Sun, 23 Mar 2025 05:08:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1twDaX-00000001wzc-2RMf;
	Sun, 23 Mar 2025 01:09:33 -0400
Message-ID: <20250323050933.430831510@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 23 Mar 2025 01:09:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/4] tracing: Fix a compilation error without CONFIG_MODULES
References: <20250323050914.459621318@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

There are some code which depends on CONFIG_MODULES. #ifdef
to enclose it.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/174230515367.2909896.8132122175220657625.stgit@mhiramat.tok.corp.google.com
Fixes: dca91c1c5468 ("tracing: Have persistent trace instances save module addresses")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..68abea81e51a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6001,6 +6001,7 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+#ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6025,6 +6026,12 @@ static int save_mod(struct module *mod, void *data)
 
 	return 0;
 }
+#else
+static int save_mod(struct module *mod, void *data)
+{
+	return 0;
+}
+#endif
 
 static void update_last_data(struct trace_array *tr)
 {
-- 
2.47.2



