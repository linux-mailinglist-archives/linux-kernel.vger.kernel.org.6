Return-Path: <linux-kernel+bounces-381492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE879AFFE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391441F234C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432441DE3C8;
	Fri, 25 Oct 2024 10:19:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F51D967F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851539; cv=none; b=q+8XjppZeNh3jhUcexaF0VcWN/xrW89amELQwWcIBUZ7LxjGr+5fQ+h/3zyaO5iBbX4gIQJT505K55MT9L/vuKm55t3HEdfaqZI0tnvKYO19Xet7rqbmKGbozxJi4sv2abZuT2UgcZytN6VvFsNYYpHmUTp+NbWltt08BJgKPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851539; c=relaxed/simple;
	bh=rLeO8mNI41AATF8hlKv+eh5i2L/e3kjoAfalXsBhtcY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LNpUoOZ0H8C4gQ6XOjsGhwHhjfNlmGqmgnjs8rySDxbt3P51pMqYjONLM8OqCPTrLnG7A0M6BVWItSpefNcKuK2P0MI5aBNMkD5wbPmRZseJxSqJWN87GtwvtnBEqjaJCG3TO8jAQceLfSUqx9eKVSoauyWdZaHXw1dtyH5nqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E78C4AF09;
	Fri, 25 Oct 2024 10:18:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t4HPx-00000004rfV-2kfd;
	Fri, 25 Oct 2024 06:19:41 -0400
Message-ID: <20241025101941.516467026@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Oct 2024 06:19:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Li Huafei <lihuafei1@huawei.com>
Subject: [for-linus][PATCH 1/2] fgraph: Fix missing unlock in register_ftrace_graph()
References: <20241025101910.054222333@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Li Huafei <lihuafei1@huawei.com>

Use guard(mutex)() to acquire and automatically release ftrace_lock,
fixing the issue of not unlocking when calling cpuhp_setup_state()
fails.

Fixes smatch warning:

kernel/trace/fgraph.c:1317 register_ftrace_graph() warn: inconsistent returns '&ftrace_lock'.

Link: https://lore.kernel.org/20241024155917.1019580-1-lihuafei1@huawei.com
Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410220121.wxg0olfd-lkp@intel.com/
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 41e7a15dcb50..cd1c2946018c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1252,7 +1252,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i = -1;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_initialized) {
 		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
@@ -1273,10 +1273,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	}
 
 	i = fgraph_lru_alloc_index();
-	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
-		ret = -ENOSPC;
-		goto out;
-	}
+	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub))
+		return -ENOSPC;
 	gops->idx = i;
 
 	ftrace_graph_active++;
@@ -1313,8 +1311,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
 	}
-out:
-	mutex_unlock(&ftrace_lock);
 	return ret;
 }
 
-- 
2.45.2



