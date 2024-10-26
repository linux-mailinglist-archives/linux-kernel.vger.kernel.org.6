Return-Path: <linux-kernel+bounces-383005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE829B1618
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94502282D06
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2C18870B;
	Sat, 26 Oct 2024 07:45:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685562CA8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928714; cv=none; b=IWAVSOP2JzPpjmBRXGP8Dn1VOaJpzmEaBRiMsPEuPeWeMNfFyXc45BftVzR4s792fuqOSEz7ylFhsBcII/LDFwaigWbBZRhXghxO3mb3ZVVKCMy6bWAiW1r1CS3eZi4ZRNhUUcxKU81TIuPP+5kvSKKmksNYI9Rv/9fj8vGAsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928714; c=relaxed/simple;
	bh=ck5ggRD0az/wSVwPS550Rzh7aUtRcOhIelfQBElqYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jJxVvsTXgRHgH2Mom92zROi536mgPpLVTI6I2Mqj14cx6deKOv/mdl1fQpJhYmGzwRaNa9zpBiN30rRDGozEgdm2SShQ9MB8UvAmHW27ASJWJWvaFkZRaRYTAO8noWZQB4KXH6BvuL/52yaRwmJz72C7bwUHGtQsmwRdeUnWYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10A7C4CEC6;
	Sat, 26 Oct 2024 07:45:10 +0000 (UTC)
Date: Sat, 26 Oct 2024 03:45:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Li Huafei
 <lihuafei1@huawei.com>
Subject: [GIT PULL] ftrace: Function graph fixes for 6.12
Message-ID: <20241026034506.2fe3e1aa@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Fixes for function graph:

- Fix missing mutex unlock in error path of register_ftrace_graph()

  A previous fix added a return on an error path and forgot to unlock the
  mutex. Instead of dealing with error paths, use guard(mutex) as the mutex
  is just released at the exit of the function anyway. Other functions
  in this file should be updated with this, but that's a cleanup and not
  a fix.

- Change cpuhp setup name to be consistent with other cpuhp states

  The same fix that the above patch fixes added a cpuhp_setup_state() call
  with the name of "fgraph_idle_init". I was informed that it should instead
  be something like: "fgraph:online". Update that too.


Please pull the latest ftrace-v6.12-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.12-rc4

Tag SHA1: 8f6be7ca396ba3c46995234d3b17f61bb99a3a20
Head SHA1: a574e7f80e86c740e241c762923f50077b2c2a30


Li Huafei (1):
      fgraph: Fix missing unlock in register_ftrace_graph()

Steven Rostedt (1):
      fgraph: Change the name of cpuhp state to "fgraph:online"

----
 kernel/trace/fgraph.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 41e7a15dcb50..69e226a48daa 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1252,10 +1252,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	int ret = 0;
 	int i = -1;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (!fgraph_initialized) {
-		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph:online",
 					fgraph_cpu_init, NULL);
 		if (ret < 0) {
 			pr_warn("fgraph: Error to init cpu hotplug support\n");
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
 

