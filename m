Return-Path: <linux-kernel+bounces-224435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037D8912260
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A551C23CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548117165F;
	Fri, 21 Jun 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiuAqeFq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jK2ruPAm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4D171648
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965675; cv=none; b=nbCqQShf9E+VqesAt9DoMa8XwWLoZT99o108d+hqsa+J+8z/GSmErBi6rpBLWWKvGXbIEfd4Fm+9t3bL+xb6e4Hsd2yzOVo2Ux5DxvbxpGG6SrgFrySsBgiWFDHlluonoKv2h093cioyEdbfRfOEnhmnBSQl8EU3cxrtO1yVbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965675; c=relaxed/simple;
	bh=vX6766KVeDrs57+GhKpOA3CLUMJydrejz343YFGbSKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E9y0y57XBq2f2YaFYUfNBSM6RvGsbl/du4m9MFvPZn+2Qi3qnhlM/jCWbMCQxQ+cXhWTSHg4VYfIDNSiGAIDggKyhqer78stwadt10XX8VrNEyP5QPIbfKUQAlDGnWb9tgK76hai3WAaHopwislkXBZL/NuWL8xYNLeDYtfPwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kiuAqeFq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jK2ruPAm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 12:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718965672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GgFSOzfsu/oBizQdGAbP6Dy2S2N7Pd0FwWEKVSEsrsQ=;
	b=kiuAqeFqnVJkBKu40mK6tIUM6NCMZC4C3AQwjOiqe/0QDo5TuNLXXOycbvrzD0k81eQA7k
	oIjDFVfvvWBgt2qv7HaVNj/HlzhN+87VyNHWaJq4Il9YI35yAWEzE+MVree6KaYwKSSZC3
	dt4bj3SI3K/KzB0ypapRrYouWi886KR7aVcA4Y3ahBp2vX25WD8RuzTzg68dB6HWKvVLWx
	BjXab08+F2GgXYhgwOX7d1bMHGQZvhXfGGSfMznxtqNQa4XJFIxIhr012sYtfRqfvYvzub
	vVnPcPb8jurKiQGHMJ5I61gXSy9LzNGC4LozfU69NxOEM87CkStgbLMzTGYMIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718965672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GgFSOzfsu/oBizQdGAbP6Dy2S2N7Pd0FwWEKVSEsrsQ=;
	b=jK2ruPAmQp3Fhf5lYRhPcjgSA7PZzms4ODCtS9adgzLwQYyf5w44IngHNKHdLI4jnusPYI
	o4OXusk195bkC/BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/task_struct: Move alloc_tag to the end of the struct.
Message-ID: <20240621102750.oH9p1FQq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The alloc_tag member has been added to task_struct at the very
beginning. This is a pointer and on 64bit architectures it forces 4 byte
padding after `ptrace' and then forcing another another 4 byte padding
after `on_cpu'. A few members later, `se' requires a cacheline aligned
due to struct sched_avg resulting in 52 hole before `se'.

This is the case on 64bit-SMP architectures.
The 52 byte hole can be avoided by moving alloc_tag away where it
currently resides.

Move alloc_tag to the end of task_struct. There is likely a hole before
`thread' due to its alignment requirement and the previous members are
likely to be already pointer-aligned.

Fixes: 22d407b164ff7 ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6d..d76c61510ef1d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -770,10 +770,6 @@ struct task_struct {
 	unsigned int			flags;
 	unsigned int			ptrace;
 
-#ifdef CONFIG_MEM_ALLOC_PROFILING
-	struct alloc_tag		*alloc_tag;
-#endif
-
 #ifdef CONFIG_SMP
 	int				on_cpu;
 	struct __call_single_node	wake_entry;
@@ -1553,6 +1549,9 @@ struct task_struct {
 #ifdef CONFIG_USER_EVENTS
 	struct user_event_mm		*user_event_mm;
 #endif
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+	struct alloc_tag		*alloc_tag;
+#endif
 
 	/*
 	 * New fields for task_struct should be added above here, so that
-- 
2.45.2


