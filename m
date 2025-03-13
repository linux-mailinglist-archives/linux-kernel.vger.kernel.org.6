Return-Path: <linux-kernel+bounces-559603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B147CA5F5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1839188716A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A64267B14;
	Thu, 13 Mar 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pxY93nuP"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D406267AF8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872734; cv=none; b=W/SkaZWHeLZFvXUI2p6FnhqR8gTWBD1GrFf/b9WABrPUE0YG7JFhEBrYbHuwXNf79oBWzFgxSVh250eqXCIF8nBqr1J/Pa1iXd3QbsAF0LiAY6rLclYHXCwvPcLqDN569m56mdoY8+Oyi0aABgDbS+YoKKwbbND1zpn0NMMqQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872734; c=relaxed/simple;
	bh=AECcWww6Tf2VbVqFmnGwEIKamySDLJ1qqx+m5Bfribo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHjsoDnvZl4jzFYNxyyBf9nR8uMLqjqMovEhN/i66VtWpmM8lIOvYDc+djf/peQNpMt+jFHMmk1AVcfRUErWd6dBqH/NBZDfAy/4NMC0JzZWBOGncEkNeHtEItubU2eh4Alo6r61Uxk+gDcduK72g95xLhiNPDDu3qBAc/KzEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pxY93nuP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741872730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1tAC6FrZfssFC8hLTnPDxdfC5S49p/m9V+OqiWaLwGE=;
	b=pxY93nuPkhxkVqBmB96EE6MQ9mnMcU9ZWWsVhhfdsTihqTjC5KLb9u2iVbcSbVLseLs5bA
	7SaH1HZ26fwBPMjjSw6IliMyrcvtyQ9QssI+KvuwdNKuARJBeMAny7IRsU1y9pJ448V6Km
	71QeU5W9CEgknVEV/jnZvurjH058mGk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog/perf: Optimize bytes copied and remove manual NUL-termination
Date: Thu, 13 Mar 2025 14:30:02 +0100
Message-ID: <20250313133004.36406-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, up to 23 bytes of the source string are copied to the
destination buffer (including the comma and anything after it), only to
then manually NUL-terminate the destination buffer again at index 'len'
(where the comma was found).

Fix this by calling strscpy() with 'len' instead of the destination
buffer size to copy only as many bytes from the source string as needed.

Change the length check to allow 'len' to be less than or equal to the
destination buffer size to fill the whole buffer if needed.

Remove the if-check for the return value of strscpy(), because calling
strscpy() with 'len' always truncates the source string at the comma as
expected and NUL-terminates the destination buffer at the corresponding
index instead. Remove the manual NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/watchdog_perf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 59c1d86a73a2..b81167cb0dfc 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -294,12 +294,10 @@ void __init hardlockup_config_perf_event(const char *str)
 	} else {
 		unsigned int len = comma - str;
 
-		if (len >= sizeof(buf))
+		if (len > sizeof(buf))
 			return;
 
-		if (strscpy(buf, str, sizeof(buf)) < 0)
-			return;
-		buf[len] = 0;
+		strscpy(buf, str, len);
 		if (kstrtoull(buf, 16, &config))
 			return;
 	}
-- 
2.48.1


