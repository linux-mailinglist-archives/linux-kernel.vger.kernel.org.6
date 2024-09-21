Return-Path: <linux-kernel+bounces-334808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A820D97DC65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F263281397
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C128399;
	Sat, 21 Sep 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OsifxauJ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A536D1B9
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911052; cv=none; b=bw1WdgyzD13DUNa0h+tYRu6Qyhto7cVyQ7fpWsy7LCPfNhXReUHp9MLnSdP58z+YR+JePOm5KXOGDqjrxd4Bi/awGAmQuhg5Z+w4adgg1xxfF5s+s6RMaCdynSuA6BNj/EivLpkus3uswW1Ny28G7ZEHlTRfvnR6w+XFWzYdk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911052; c=relaxed/simple;
	bh=JwE61o8q0edt07pIbKoZqTxQeKySTvYNmWczW4YEWfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBUa0/uEWKZhskvgwCi08ACCwrMClwD0pONTMvOYr1upf0BoyJBdGs5vaCKBVI0rybFe1ZcoDLa9rjZvevRwB5W7FPgr5G7DL1cP0h6y+L1TipKNQyyWYDdYzrFg/0K72CYr03xjBqjJ95GVMTUnx97GLINsN/jSuQT4RRk7jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OsifxauJ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726911048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1NVT4WVVFlw5e6dUVZZDmk9E4e373jbM0EWgdrWWFA=;
	b=OsifxauJfeHUt14JYBN7UBPug1XZKy3V8bbspYmNqauTgUIBKmu1lI3l52wxWAK6pPPC+c
	rs08KbbH8Uds9//9xAwuYr4DQvfXBbMBe1Wp4vdXleLzyGX+Kk1jDfDgcgYHjy8tzpPjaR
	rbyCj3H0gl1KX+1+6ll59T5ZakkaEaM=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 5/5] sysctl: delete six_hundred_forty_kb to save 4 bytes
Date: Sat, 21 Sep 2024 17:29:04 +0800
Message-Id: <20d67551ed7fa9c774d2b128ad9bc298a0a55c9d.1726910671.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

By directly encoding specific numbers into the min/max field,
unnecessary global variable six_hundred_forty_kb can be removed,
saving 4 bytes

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 05197d46007d..c8460b5e0605 100644
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
+		.min		= 0,
+		.max		= 640 * 1024,
 	},
 	{
 		.procname	= "perf_event_max_contexts_per_stack",
-- 
2.25.1


