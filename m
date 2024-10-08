Return-Path: <linux-kernel+bounces-355496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCB995320
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B821F26BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E21DF275;
	Tue,  8 Oct 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b9ligKLw"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576E1E048F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400659; cv=none; b=SPCEP6EbP/6IqCqHogLAFWVgR365f+AzVVxtSGzjGjZQ08/9QvZYviB0vleNjm3tcK6hsWOjuqMFlAUt/43MD6fj/MgWGGczGgxgIFpujE3xr8fU4I48tbHYp84ezPyAOwnbuWyOAvj3NW6hqyMjHFa1jEoitMf07jro2Zim9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400659; c=relaxed/simple;
	bh=T3GldDOFhUWBJ2biZPCYKw05Uo8+TqI/hbq80bxSfZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpSQSsOzWVwmT9EpGZ8ydpDYgVW6UcEbiknhyfRo/CjZMpe0ZM7CiknaEz9fwPEHMONHsNzWBQ7+WiBtg3lL0YHCerfVR2OxB1dgnD3k+EuWriTLubtmvTlpffDO1U22syRdrWN6qTitx5dL4sjv/sO3XjT48DzPdDRga8ZQdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b9ligKLw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728400655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bWHqjOELOWE9vLZrRmf/09or4tmrdFcp8GvUzAK+AxA=;
	b=b9ligKLwgXqQPezu6NO84L1SuMlBJaKX1ePlcETOjs7JOoDBJ0jeB/M9oOlm8boQ3aZj5t
	K9YEV27/lQ1gKy38Q67H68rmpdkEHMIz86vB9kT/FSCOrFxaxdXeZTWIzgJEZPM0J2z34L
	tfLtQaoT63KOgOqJCe8FFyg0Dy+/Y6M=
From: Wen Yang <wen.yang@linux.dev>
To: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [RESEND PATCH v4 5/5] sysctl: delete six_hundred_forty_kb to save 4 bytes
Date: Tue,  8 Oct 2024 23:17:00 +0800
Message-Id: <20241008151700.12588-1-wen.yang@linux.dev>
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


