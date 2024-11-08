Return-Path: <linux-kernel+bounces-401714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C09C1E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B91B241D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B81EF082;
	Fri,  8 Nov 2024 13:46:38 +0000 (UTC)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501A1E7C20
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073597; cv=none; b=KU92IGT5yzvAeBh6YgyD3jOg6uzwHgkTKAX0lTnrTPRGEIburzgReKv8m5Bz4NnUoUQGOZKNBYSKwwVcmLUyc2VDWh7IhhjHRk8xB1hmBbvNbQpO93gxIih4XzdOVGiq2LjQAU1W2caOkodJ4jbczcZZ21dZXQ3kBTHTC+PM5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073597; c=relaxed/simple;
	bh=l81HqFooBgz0FksI+93rEVd1XWleW93EAvrWDtE1pu8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oLfXxKkdKzDlavgK6IqwzFL2yvuzctAXU+V6rx76Cmfb1cr2PjCabjGB3XLqVqXcrQqiWUur9bV40OKxrIjdmAeJHYrnYIv8ZGjiqn+1vPpOKlcRcGaEXsI3c44MdDiorLFDzyBY47nAK2N7jBzHUFzN0d0JdHMeFfvuG6/SBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 8E271DF91B0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:41:06 +0100 (CET)
Received: from localhost (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 5E1252003AE;
	Fri,  8 Nov 2024 14:40:53 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id 46A9F40042; Fri, 08 Nov 2024 14:39:09 +0100 (CET)
Date: Fri, 8 Nov 2024 14:39:09 +0100
From: Etienne Buira <etienne.buira@free.fr>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Etienne Buira <etienne.buira@free.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gdb: lx-symbols: do not error out on monolithic build
Message-ID: <Zy4UfR0-KR6YroN2@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
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
 scripts/gdb/linux/symbols.py | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index e8316beb17a7..fb0f55d81686 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -178,13 +178,13 @@ lx-symbols command."""
 
         self.load_all_symbols()
 
-        if hasattr(gdb, 'Breakpoint'):
+        if hasattr(gdb, 'Breakpoint') and modules.has_modules():
             if self.breakpoint is not None:
                 self.breakpoint.delete()
                 self.breakpoint = None
             self.breakpoint = LoadModuleBreakpoint(
                 "kernel/module/main.c:do_init_module", self)
-        else:
+        elif modules.has_modules():
             gdb.write("Note: symbol update on module loading not supported "
                       "with this gdb version\n")
 
-- 
2.45.2


