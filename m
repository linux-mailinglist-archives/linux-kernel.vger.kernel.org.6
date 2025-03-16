Return-Path: <linux-kernel+bounces-563165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB3A637B1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F359188DE8E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A91C8607;
	Sun, 16 Mar 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="cSrS1k8M"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B7199E9A;
	Sun, 16 Mar 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163960; cv=pass; b=rW17pjJJBviV0x847mXSf0a5sdIbzNs03aIdZyYb446ynjBUaCVNMkgJ4133jJ/wPZc7rEvUdaQUNvsJ7fXWfc/SvgavqBPQckQq7uNb05rl1IHJ33/dbQSTmF4fToyWc/I9HZYQVZNGygKRixMeJ+xOWRc3V6OCfdP9+9XqFBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163960; c=relaxed/simple;
	bh=AchUGpGJPCL+V084QppEVLRoXuTVyPDKqmT8Bw7nVho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMVO2D0SbJZ3BqbM4XjG4Y4XpfaGBo9+m9/LOHUJ2SkMNaYPBnMWGCuIZwg8NcF0Zbwxl0LtapPTDD9JJFMDu6xiAlwogCYI6TRlCJXqKLm5OwpGY9k6/dQkRiimh3Mp84TdDb+lFoOUqGB2x23tSoVyEfWLYP7Uf3X2AL26Hzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=cSrS1k8M; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-pdhm.prod.antispam.mailspamprotection.com; s=arckey; t=1742163957;
	 b=HWx2JE8+N1/0aQ6u4EU/QW0gkiX+NDS7MziKonn/SPetUk1Rl6oKJuOftUhAigP7hK9OE3/0sd
	  iP1EE7nboAVOp1zQ1M2UPjuEsYf+4j3nJF3d6wC+BDAY3ZxbiWff7yhaMnbudDNhTdvAgpnMC4
	  g6O/3CtKKWuui/d23/bhHTrDyiJyLMS0fbWI8o3AnMWRIcswpXDhPePCH1Ego6BuhChvnOH0qT
	  vRRVDsKEoAoj91SOduaG+jxKFciFQHpHFPmPQAZ7Zs/UW+1zYZGtbKJ93wcrlin+PVEWOalqyf
	  AP5+3SjTKkZjqyIGDkx/1mke/YNDiHnE2ujDyWdoIbBStQ==;
ARC-Authentication-Results: i=1; instance-europe-west4-pdhm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-pdhm.prod.antispam.mailspamprotection.com; s=arckey; t=1742163957;
	bh=AchUGpGJPCL+V084QppEVLRoXuTVyPDKqmT8Bw7nVho=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	  DKIM-Signature;
	b=e3HYoF9/X6lkLKilJo+KqYj7RvTbW2e1syu/8225Vt2WYZz+QXG3UIamhc8zDAUiYLIxwNm1l/
	  OcEDiYZcqAp5T4Y+G5i2FHFeKTJ8eTFcD9taYiYLug+lXDW582eU5NqLj+RIDdd7xfLCINIqYJ
	  XjeaD1DX76HkjvFhUg1PW0hqPwDLABBdoX85CB0nbEpToLfjYej1eNhcgN54f9eNberguOjQ78
	  OopP/Dy4q31HoE1BViS81ci6K1FMioZaDt7tJAGkOFJ88Rt9QXfOdxuwpbv5v0gSjBK0IR08cr
	  fNPAVyZ3bdRvmfyxLoNyH8m9uuYVmwqAV3tW7Fsnw2vsRQ==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-pdhm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1ttuwU-00000004iVz-1jw4;
	Sun, 16 Mar 2025 20:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=v7sjfrgq8lZr0nHx77awpfMZaCLKOjn8gKszKsmGIIs=; b=cSrS1k8M8r3e68y4OrUg3ZHKhv
	Nw8mirVTQ201BvE5OCpD7yO37ne5L/DdZsVcaYAEsYxEKfPBJ07KI+oC4UH69LOqq7ecly6GiHJ89
	JAuBQuPTP5m418sPwwMrLl/vbHw8EznR9f44y4EUfQ/oBiJEtnxTouEWqrFp3NcB8h1I=;
Received: from [95.233.219.167] (port=60583 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1ttuwQ-00000000GWD-0RVV;
	Sun, 16 Mar 2025 20:50:38 +0000
From: Francesco Valla <francesco@valla.it>
To: linux-kernel@vger.kernel.org,
	linux-embedded@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH] init/main.c: log initcall level when initcall_debug is used
Date: Sun, 16 Mar 2025 21:50:15 +0100
Message-ID: <20250316205014.2830071-2-francesco@valla.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 3b46fe2c4da7b04bca5cf9745b5c5e2b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-pdhm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

When initcall_debug is specified on the command line, the start and
return point for each initcall is printed. However, no information on
the initcall level is reported.

Add to the initcall_debug infrastructure an additional print that
informs when a new initcall level is entered. This is particularly
useful when debugging dependency chains and/or working on boot time
reduction.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 init/main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2a1757826397..80a07563036d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1214,6 +1214,12 @@ trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 		 fn, ret, (unsigned long long)ktime_us_delta(rettime, *calltime));
 }
 
+static __init_or_module void
+trace_initcall_level_cb(void *data, const char *level)
+{
+	printk(KERN_DEBUG "entering initcall level: %s\n", level);
+}
+
 static ktime_t initcall_calltime;
 
 #ifdef TRACEPOINTS_ENABLED
@@ -1225,10 +1231,12 @@ static void __init initcall_debug_enable(void)
 					    &initcall_calltime);
 	ret |= register_trace_initcall_finish(trace_initcall_finish_cb,
 					      &initcall_calltime);
+	ret |= register_trace_initcall_level(trace_initcall_level_cb, NULL);
 	WARN(ret, "Failed to register initcall tracepoints\n");
 }
 # define do_trace_initcall_start	trace_initcall_start
 # define do_trace_initcall_finish	trace_initcall_finish
+# define do_trace_initcall_level	trace_initcall_level
 #else
 static inline void do_trace_initcall_start(initcall_t fn)
 {
@@ -1242,6 +1250,12 @@ static inline void do_trace_initcall_finish(initcall_t fn, int ret)
 		return;
 	trace_initcall_finish_cb(&initcall_calltime, fn, ret);
 }
+static inline void do_trace_initcall_level(const char *level)
+{
+	if (!initcall_debug)
+		return;
+	trace_initcall_level_cb(NULL, level);
+}
 #endif /* !TRACEPOINTS_ENABLED */
 
 int __init_or_module do_one_initcall(initcall_t fn)
@@ -1314,7 +1328,7 @@ static void __init do_initcall_level(int level, char *command_line)
 		   level, level,
 		   NULL, ignore_unknown_bootoption);
 
-	trace_initcall_level(initcall_level_names[level]);
+	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
 		do_one_initcall(initcall_from_entry(fn));
 }
@@ -1358,7 +1372,7 @@ static void __init do_pre_smp_initcalls(void)
 {
 	initcall_entry_t *fn;
 
-	trace_initcall_level("early");
+	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
 		do_one_initcall(initcall_from_entry(fn));
 }
-- 
2.48.1


