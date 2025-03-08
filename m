Return-Path: <linux-kernel+bounces-552624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8FA57C18
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020A916DA3F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB11F5841;
	Sat,  8 Mar 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KWH6PSfy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YH+RQgpy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647A1EB5E0
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452505; cv=none; b=hWzCX2PkyY5PX24Bp1f0B5eivtXxky2sK+aS1/DcSe6MlqTu8p8pdGMgxUAbqxXov/CUT8zU/XXAQznXmRltu9Wk9QyHVMn/9fk/+EFbRxxAPhBGmL5eBwP8nxGImZwmQCkWXhDK2qGpbCC5xD2SrTqzMwtuWhkuLy1i1S/Om6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452505; c=relaxed/simple;
	bh=v1ZQb0CLMsf+4NMtv8z9vh1bq4XwnUUI1Mq85vu/yoM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=l1wlymMbkU3MY7mP8KcirGHplqzIeVBW9+Y6ncS9ibLFOvPr/RjcbX93FxYyo73uWeTbVVkal6G6DK/Qmzl+ReIuarjAWAgyHsryPkl+cAX5IerBLSa63tPY5FpD8Q0sd8NSCzogrd5xVk79cMr9/g3GEhPA1hNcYCBncOeDJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KWH6PSfy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YH+RQgpy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.701301552@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lUqtxlbBdGdbkk7RdEECXGsUd/xNQguaG0zDCu2fH+M=;
	b=KWH6PSfyHomUZaL3dZmZEktWM+C/Q4NjPLciuzf5n6ysvCfZRLyl3JoQYhvnzDqZEuJfTp
	FJMcssCo0oXSZ5j8A/3XyfRA/ZHHkCn59rRf2Evh3R1Es9WxlG/fqI71dRJXFRwPH2uGCl
	jwSaS72tEr/aAhwyHgzw/ar0RbUUxi0Hm8uZtFyC5qNRz9Eb/z9VtI8tpg4sf53uuGB9Gv
	Flh77itDPRNhwtBziPlR3vozSzHUV03hsqupjCdAk5dAw8PErqVmknQDH/6zJTDREEwE36
	+umjcqcg5RyQhNEct5SE3okIol41YVjlUOTWGz43ZGaQwGese2XYAvg2GltX0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lUqtxlbBdGdbkk7RdEECXGsUd/xNQguaG0zDCu2fH+M=;
	b=YH+RQgpyfIxzd0v66oMDZq2lAkEGBhvv9DN0wXHVQcliMJy2FslVqzzZtDAPVxDHUZujC1
	Oc4fAMiCKuDb1gCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 04/18] posix-timers: Cleanup includes
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:20 +0100 (CET)

Remove pointless includes and sort the remaining ones alphabetically.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>

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




