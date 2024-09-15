Return-Path: <linux-kernel+bounces-329657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EA979454
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603BF1F21D73
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7091E1B85E7;
	Sun, 15 Sep 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dbixe1oy"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469DAEAE7
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366229; cv=none; b=BF2rPIQSWluf4zUhqDdJ7zLY8nxEd2ALnLHmsWYYvcJ8lO/7PUfKA5nwPanrQkCoUmePOL1Gg2ix6Bzk0RYLE9xG+/mFhVUIedPnFPrt63TjNt97nHD4LpF3qCb+8rO7po+5JDnUltuLJGfSPd4FDJOE7Ha3cBgEIwNCmTzpC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366229; c=relaxed/simple;
	bh=RHVUgBL8W4f3kC/MaUMlbi8UpCu8cHLEklQbok+aygc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0piZIkHbtuzVrtNySE5Kazzewy+YKgABNm/SfYIKVtjee5EbCLYTE7+wjJL26l4Z9VfXYJrF2vCwivd8NVOvnZKRIn1ESxvOxQ6s5iDVGx4tjbpclF0DpKTu2AaMY2t2zoXLydsoofpdV4ZVHQCaoKT1OKAc2JJU8WO46+9i+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dbixe1oy; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726366226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2wNQu8I8yTujCkKssEV3O6B+7E2ic9BaAtLUJTkld4=;
	b=dbixe1oy4mA7ZHFMYLoMdt7UeBIsAA5YPYerWpr5hFicDg6sbhKNURifXTxaIrxflkP0dX
	c8mEYT54GxoJd86mzi3y2luvGhacNs/jbFXcTgpZl3kHLsip7Esm1HzXuoWlW0wMCKoLej
	/yAKyt2KtqTGtTBAN6XnjsyW4FGmcp4=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v3 5/5] sysctl: delete six_hundred_forty_kb to save 4 bytes
Date: Sun, 15 Sep 2024 10:08:31 +0800
Message-Id: <747bae0b9c3a947ea8b0e93cf8c0fbe672ff9a94.1726365007.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726365007.git.wen.yang@linux.dev>
References: <cover.1726365007.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By directly encoding specific numbers into the min/max field,
unnecessary global variable six_hundred_forty_kb can be removed,
saving 4 bytes

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 05197d46007d..7affb1ad7065 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -90,13 +90,6 @@ EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
 #if defined(CONFIG_SYSCTL)
 
-/* Constants used for minimum and maximum */
-
-#ifdef CONFIG_PERF_EVENTS
-static const int six_hundred_forty_kb = 640 * 1024;
-#endif
-
-
 static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
@@ -1964,10 +1957,10 @@ static struct ctl_table kern_table[] = {
 		.procname	= "perf_event_max_stack",
 		.data		= &sysctl_perf_event_max_stack,
 		.maxlen		= sizeof(sysctl_perf_event_max_stack),
-		.mode		= 0644,
+		.mode		= 0644 | SYSCTL_FLAG_MIN | SYSCTL_FLAG_MAX,
 		.proc_handler	= perf_event_max_stack_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&six_hundred_forty_kb,
+		.min		= SYSCTL_NUM_ZERO,
+		.max		= 640 * 1024,
 	},
 	{
 		.procname	= "perf_event_max_contexts_per_stack",
-- 
2.25.1


