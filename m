Return-Path: <linux-kernel+bounces-322041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE22972341
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB71280CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE2189F3F;
	Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B21836D9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912508; cv=none; b=c2sqvmgWjkx9jxfa1BRuzvHBV5SMMdyWtnPzTBcdaDaqdTLHNsvTq47MkbxgDqlj9/4+8U5u77l+7XdWkrmfeZiB3SJ0u+Qqsxh+cJTa8AgBE1kiaio3xc21CNN8KTfe8KSCe9R6JCYyz1IbVqZZcDABI6cv9jCMQr1Nf/zi3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912508; c=relaxed/simple;
	bh=KmW7WRSo/iGFkcAX6rCPFFaUDhnWuHwnS5jAbrq79mc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Wn9tj4cPBPJ+ulJeqfJxcKqPqGXnorinjDA+JcvOyRz8R6nn+ibmcgzdo/9WJ2NPHXnf6Xy1P1cNW0ZA1darLH6mvdixMQnJ/8xl5kgU5MgLvcMldhgfP2IO6bjxARqoxcdX18lHZvu5mgtQXfyv2A4GZ3B0g4kgOJAA3k4pFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B60C4CEC5;
	Mon,  9 Sep 2024 20:08:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1snkgW-000000009qX-0AYQ;
	Mon, 09 Sep 2024 16:08:28 -0400
Message-ID: <20240909200827.908619234@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 09 Sep 2024 16:07:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Helena Anna" <helena.anna.dubel@intel.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Subject: [for-linus][PATCH 1/2] tracing/osnoise: Fix build when timerlat is not enabled
References: <20240909200747.898018585@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

To fix some critical section races, the interface_lock was added to a few
locations. One of those locations was above where the interface_lock was
declared, so the declaration was moved up before that usage.
Unfortunately, where it was placed was inside a CONFIG_TIMERLAT_TRACER
ifdef block. As the interface_lock is used outside that config, this broke
the build when CONFIG_OSNOISE_TRACER was enabled but
CONFIG_TIMERLAT_TRACER was not.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Helena Anna" <helena.anna.dubel@intel.com>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>
Link: https://lore.kernel.org/20240909103231.23a289e2@gandalf.local.home
Fixes: e6a53481da29 ("tracing/timerlat: Only clear timer if a kthread exists")
Reported-by: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bbe47781617e..7e75c1214b36 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * Runtime information for the timer mode.
@@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
-- 
2.45.2



