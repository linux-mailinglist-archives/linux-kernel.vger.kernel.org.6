Return-Path: <linux-kernel+bounces-528674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A7A41A96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5469A17246E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D12512DB;
	Mon, 24 Feb 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qf/VzE6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zBT+udGT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56224F5A4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392130; cv=none; b=uiL+c6kzRf+Z6yJwZQPtVY+Vu+N3EqFQQXetG4D8OZEqL9TXfRVgwA80JMQutIwl7S6dkIRaGMGrvZROh/wuULXRlt8czBs1cdW8G17HOC91k3x3NFV1NW9ibKpvWR4BX8C2cbP8yA9r8THHzzmL9AlWzABv8Se+D1NqQRlzBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392130; c=relaxed/simple;
	bh=YuCCqu2WJyvGIMJolIDYCOzTiBIB7QWQZ3Kkw08rbs0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XGS0wJVGccy8MlXsdUCP+3E5MJhF4Yl4H1zPt3ZKu1WYXXlkNH07NsIJTANTleDiS/TZpY42zksGCyZ6DoSFEODxOIXyjjCOuIirrDAi/4Vl/l9j/SXtcjH/HXEvOHTCjiujclmF/AB98tw/nNa20Ply1tUONsVeTGnhTqhpDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qf/VzE6g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zBT+udGT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.145414888@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=06e/nLkYRQzPGWTt39F2KrcgBwQj9ajKa6Dm+qJCWzw=;
	b=qf/VzE6goSJCERBuFz1Y/5vwJX9qrf09SzHBhUOJF+ZmgTYg7tLnXGdGg3wOX5ii5lcpft
	A7cQMw5DBDukhHXHXZgxE9u67xDIdc3SWBmIYlkckzJjVmOJ87w8/FqspqDfmLZuvJZuUI
	CmXWrDdjRTzQ7UlVMMUnzsTRifQ/FDS3zbWee+OHtWhuGjSfxtAkWwANF5OYKcXrLV6bFP
	5Rntb4AshqL1DPy2pwXLqjpfd7nw9w+HzPIBmceg502RU6hRU/tPz/A2MeckJfhG60VFpG
	PAnGhPIWSJeHjFa5N9DyZFwVhonFA8zBWhzAkZ7sr8OpYpEL5bmSvpaY8rJRoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=06e/nLkYRQzPGWTt39F2KrcgBwQj9ajKa6Dm+qJCWzw=;
	b=zBT+udGTCIOKpU92GttOixVsjED9IeuN4yqvOITytL3SjA7jVlePLCaCPFVA1vIe1jdiO/
	/R9ZcU4dcc3IxoBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 03/11] posix-timers: Cleanup includes
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:26 +0100 (CET)

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


