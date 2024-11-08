Return-Path: <linux-kernel+bounces-402030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A29C226C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938831C2399F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F67F1F585E;
	Fri,  8 Nov 2024 16:47:25 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD61EF0BD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084445; cv=none; b=g0ORS/QeJ2vV7F6b5IIPhZ1vyzp2bNGuPE9vSEe4v2FDdgoBqMKOmtOBrq+gT+/yU66E8Jv/7G3mqnOfXtGrzfixEqUawpTo3iy6qb/+lOm20SnfMY3SxyEdDgkGc9IFVMTVkAXzmIkmPGRTrugsPB58BkvLKXzNTE2NQ8UL4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084445; c=relaxed/simple;
	bh=y+1c6+u3jNCXoSckB8bLAC6Ldj34LI1Nvtq02kFjUJE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AdJGkGxX9HlCo7HhblJ/67Ap94O+DM7ORCqoudPPuc6SDoViPSY4MujL0CvOt8QTWPzqs9ZwD5tWFv0Vh0ANDtMix/QyLK10jp2qnuqf0PrSnYcLKFAFkLubM+WQjfhq1HcQLrcHbI3hbUvROWQb1tHg8AxyOfdx9RFLWADo9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 810A12003A4;
	Fri,  8 Nov 2024 17:47:16 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 911F640042; Fri, 08 Nov 2024 17:45:32 +0100 (CET)
Date: Fri, 8 Nov 2024 17:45:32 +0100
From: Etienne Buira <etienne.buira@free.fr>
To: Kieran Bingham <kbingham@kernel.org>,
	Etienne Buira <etienne.buira@free.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] gdb: lx-symbols: do not error out on monolithic build
Message-ID: <Zy5ALByQtpO-ddh4@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Kieran Bingham <kbingham@kernel.org>,
	Etienne Buira <etienne.buira@free.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This avoids spurious message:
(gdb) lx-symbols
loading vmlinux
No source file named kernel/module/main.c.

Signed-off-by: Etienne Buira <etienne.buira@free.fr>
---
 scripts/gdb/linux/modules.py | 3 +++
 scripts/gdb/linux/symbols.py | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 298dfcc25eae..fa15f872ddbe 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -19,6 +19,9 @@ from linux import cpus, utils, lists, constants
 module_type = utils.CachedType("struct module")
 
 
+def has_modules():
+    return utils.gdb_eval_or_none("modules") is not None
+
 def module_list():
     global module_type
     modules = utils.gdb_eval_or_none("modules")
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index e8316beb17a7..f6c1b063775a 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -178,6 +178,9 @@ lx-symbols command."""
 
         self.load_all_symbols()
 
+        if not modules.has_modules():
+            return
+
         if hasattr(gdb, 'Breakpoint'):
             if self.breakpoint is not None:
                 self.breakpoint.delete()
-- 
2.45.2


