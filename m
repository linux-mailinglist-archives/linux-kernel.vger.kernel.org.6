Return-Path: <linux-kernel+bounces-540741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98299A4B472
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314C03A85AA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A801EE03B;
	Sun,  2 Mar 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQV7/27I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIErsQBF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145701EDA28
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944211; cv=none; b=eQcEYK8rufWLI5U6uQE3XZo5ZJt5NO0zwbfPXQ8CYqhFGJoySgjCFdqXc1e3W4aJKyo/MS3G6Tb8SZ104gJk0wThJsh6vojBrpiSIHG7MzWvl7e90NGOqocYVMpVh5j4/9EeS2niot/GgsJpVmgRZmAKcVF/js2ByzKr21z3i7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944211; c=relaxed/simple;
	bh=YuCCqu2WJyvGIMJolIDYCOzTiBIB7QWQZ3Kkw08rbs0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=B4lR/gtuENQ7b/+c3IwgfU+fqz66w3rzUkl7c+Or7APj/Nrjej2DJyO7w7lIkEkjq+IA1bkXVSFGj4cmO+/qiBAtvBSp8G7+ZrL1GyHf9oOjeMD1g21IvTAs2VHsbrW8f/WSO2aQbw6D4L84Fc0DGkvij2Hwevurj1IOkGfVoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQV7/27I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIErsQBF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.103677445@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=06e/nLkYRQzPGWTt39F2KrcgBwQj9ajKa6Dm+qJCWzw=;
	b=VQV7/27IS1aIgst+en3u8DwatddEHRHHLXPInufdldiXqr6DNha3qgiFIElcJwGCrkLJoF
	kg20QH+ijJ9bB/T/okeDaQsZL5yWZaU5lYWihg0ELz7DwuSJtdCfiZwfknostrBv/zGWZj
	y5UVoQPsrV/oB+O3II5i0kdVMrRIF0ljQMUEWpHY8LsQF0p5vucwzazmh8X8k+AqczKrjm
	tVTP/kKTV8bUog0uNYvmZKEnLf3FpftMwO93tvMJhYF0eqjBqk2RuWuOjjK3dAGSYun3CX
	3TuJPRKdbJldI6nslQuBHtuPeD+h62kenlDgkMU9LWmye1NBhrB7rxojTDdOaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=06e/nLkYRQzPGWTt39F2KrcgBwQj9ajKa6Dm+qJCWzw=;
	b=PIErsQBFIYWmbY2G241NAoBPyFg8lmiXyqCgIyB7dhRRLut2lR3UbmCfpf9E0OPZ9RkMED
	3MMSh4Of+CwH5gCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 03/17] posix-timers: Cleanup includes
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:47 +0100 (CET)

Remove pointless includes and sort the remaining ones alphabetically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -9,28 +9,22 @@
  *
  * These are all the functions necessary to implement POSIX clocks & timers
  */
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/mutex.h>
-#include <linux/sched/task.h>
-
-#include <linux/uaccess.h>
-#include <linux/list.h>
-#include <linux/init.h>
+#include <linux/compat.h>
 #include <linux/compiler.h>
 #include <linux/hash.h>
+#include <linux/hashtable.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/nospec.h>
 #include <linux/posix-clock.h>
 #include <linux/posix-timers.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
 #include <linux/syscalls.h>
-#include <linux/wait.h>
-#include <linux/workqueue.h>
-#include <linux/export.h>
-#include <linux/hashtable.h>
-#include <linux/compat.h>
-#include <linux/nospec.h>
+#include <linux/time.h>
 #include <linux/time_namespace.h>
+#include <linux/uaccess.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"


