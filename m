Return-Path: <linux-kernel+bounces-552764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2859A57DDA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA9188D00A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF917A5BD;
	Sat,  8 Mar 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xMDx7hLj"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF231392
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463232; cv=none; b=GsehM/5R0cM0duQ4ghx3ofplWAN//pdR/7rbsN31fCFp1a0cBQ39SP3VOAVsr/Nh/IPzWjSTfJBkkXRWBywmLr1fqWQIa8VcIR65k6LWOyQNggmwz188XXsReNapg6Em9ntNYYfbJIRjHeAmFozQUv+7k6oA1wCxfmATzFArFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463232; c=relaxed/simple;
	bh=NXcByO8e5AUKQNfZRgHIJRWjXfcWfMjuacKTD2xvuVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5KvqgnjBlpTaxnpHPM3h3Q/YQ3S47pK5lGSHd8Ushny/e7v2gvdxmWb07reCielkpJScBTsO68Yb6S4fusPywc7MRZj8zcZFfVUUc9f5YXt13gYIpOFTCVv69gN19GUOxydYW/eEGaKqqf8/YCFHyxxV7jnkV9wuJpyp0WIOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMDx7hLj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741463226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3QbJam/t2edM6YxRdQTQO8Mkh9a0H/CFHQLFiR8pKDg=;
	b=xMDx7hLjzCW62XQPNCxwQmRgdreKDf4XgBrfjNR71s7jS7VZHylHXIgOsGDisW8fe64yZV
	Lr/gygVpGQk5Rz3gTrrmwWFi+WRoTAZhlKpY4+tRrQ/9LShfZ1dFwXVUMpU8rOBeTNOecq
	RTZy6qid4AlonTPqkTwDUKPtNYdsxzQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Remove unnecessary size argument when calling strscpy()
Date: Sat,  8 Mar 2025 20:46:32 +0100
Message-ID: <20250308194631.191670-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() unnecessary. Remove it to
shorten and simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..e690f46a7ea7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -795,8 +795,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	async_synchronize_full();
 
 	/* Store the name and taints of the last unloaded module for diagnostic purposes */
-	strscpy(last_unloaded_module.name, mod->name, sizeof(last_unloaded_module.name));
-	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
+	strscpy(last_unloaded_module.name, mod->name);
+	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false));
 
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
-- 
2.48.1


