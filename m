Return-Path: <linux-kernel+bounces-528499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF81A41870
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9317B1897552
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D925291F;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ukiRqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D62451F1;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=FPQWM5aqZsukR3P/UUvrsWKCHCBvP1/JPI3XzzNMzKLmHZrbKAPvxYibBIDUm7CuA00ynFfLVoVlpTENrjFXDqcxGxblibfkbRoQvNUw+3kdoPhm//OcRUg2R3+hw+ohHEomGtfyQaF3FtRhmyZg/lqEfOtU5NXH4Ggpc3VPj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=Q2bW4rHBvXUepqtRYw3jrHwqyqtoRshTMOAzsCvXTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM0XZv6TtIJEX2tbDr0tfqld2zEYddrU8c0qlsGVp3p3TLYTmhBUzeklaGveWVdhAm++nu1UuPpIoqCRrh7mWeVA3omkHZO/YnXqEEqZI4pNpbyvWCB1wj44rbHJjxFWP0/8wuP2+ika3RqcJ8bsWtDPZYVl1hxr94P9TDd93RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ukiRqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07319C116B1;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=Q2bW4rHBvXUepqtRYw3jrHwqyqtoRshTMOAzsCvXTFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+ukiRqkDheAfPTbdOd1Rp1TLQIOKK6x+IkXEjtY6cC5zP0J3nBeysHhgUTsHCdEE
	 1K22KwOwwCVap320NOiLJjrdzeV4M0F8OWHKX4LodbzwjLwLjeqPOSOF5uxXB37ztC
	 EiO18FDTxRWOHN4kbaa56AoB55PP3pp9QwZMYj0cmMiwDiG1t+xGN7Q/WHbLcAFeUa
	 XBVLAW0Hk0ncwc8vK05jIyHCZrQ+i7cz3pte9eGUo1nN9lnLIryr7WZOYaCKwSxhIm
	 pdnGuc3XIHHAEI3UdlzBqtVQTf08Oqud6R6AUEW87ru9Mx3FsRA7kY9Z+Y5w6k5HwM
	 09oje9xOIPWdA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4a-1CAZ;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/39] scripts/kernel-doc.py: move file lists to the parser function
Date: Mon, 24 Feb 2025 10:08:24 +0100
Message-ID: <2080b6bb99a30146a7fe4eb8527aa78121b988eb.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead of setting file lists at __init__ time, move it to
the actual parsing function. This allows adding more files
to be parsed in real time, by calling parse function multiple
times.

With the new way, the export_files logic was rewritten to
avoid parsing twice EXPORT_SYMBOL for partial matches.

Please notice that, with this logic, it can still read the
same file twice when export_file is used.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py          |  7 +++----
 scripts/lib/kdoc/kdoc_files.py | 37 ++++++++++++++++------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 6c3179a2da65..a687a7abb3b9 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -199,14 +199,13 @@ def main():
     else:
         out_style = RestFormat()
 
-    kfiles = KernelFiles(files=args.files, verbose=args.verbose,
+    kfiles = KernelFiles(verbose=args.verbose,
                          out_style=out_style, werror=args.werror,
                          wreturn=args.wreturn, wshort_desc=args.wshort_desc,
                          wcontents_before_sections=args.wcontents_before_sections,
-                         modulename=args.modulename,
-                         export_file=args.export_file)
+                         modulename=args.modulename)
 
-    kfiles.parse()
+    kfiles.parse(args.files, export_file=args.export_file)
 
     for t in kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
                           internal=args.internal, symbol=args.symbol,
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 434fc66a9dad..4a6e75dbdbdd 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -123,7 +123,7 @@ class KernelFiles():
         self.config.log.error("Cannot find file %s", fname)
         self.config.errors += 1
 
-    def __init__(self, files=None, verbose=False, out_style=None,
+    def __init__(self, verbose=False, out_style=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
                  logger=None, modulename=None, export_file=None):
@@ -180,51 +180,48 @@ class KernelFiles():
         self.config.src_tree = os.environ.get("SRCTREE", None)
 
         self.out_style = out_style
-        self.export_file = export_file
 
         # Initialize internal variables
 
         self.config.errors = 0
         self.results = []
 
-        self.file_list = files
         self.files = set()
+        self.export_files = set()
 
-    def parse(self):
+    def parse(self, file_list, export_file=None):
         """
         Parse all files
         """
 
         glob = GlobSourceFiles(srctree=self.config.src_tree)
 
-        # Let's use a set here to avoid duplicating files
+        # Prevent parsing the same file twice to speedup parsing and
+        # avoid reporting errors multiple times
 
-        for fname in glob.parse_files(self.file_list, self.file_not_found_cb):
+        for fname in glob.parse_files(file_list, self.file_not_found_cb):
             if fname in self.files:
                 continue
 
-            self.files.add(fname)
-
             res = self.parse_file(fname)
+
             self.results.append((res.fname, res.entries))
-
-        if not self.files:
-            sys.exit(1)
+            self.files.add(fname)
 
         # If a list of export files was provided, parse EXPORT_SYMBOL*
-        # from the ones not already parsed
+        # from files that weren't fully parsed
 
-        if self.export_file:
-            files = self.files
+        if not export_file:
+            return
 
-            glob = GlobSourceFiles(srctree=self.config.src_tree)
+        self.export_files |= self.files
 
-            for fname in glob.parse_files(self.export_file,
-                                          self.file_not_found_cb):
-                if fname not in files:
-                    files.add(fname)
+        glob = GlobSourceFiles(srctree=self.config.src_tree)
 
-                    self.process_export_file(fname)
+        for fname in glob.parse_files(export_file, self.file_not_found_cb):
+            if fname not in self.export_files:
+                self.process_export_file(fname)
+                self.export_files.add(fname)
 
     def out_msg(self, fname, name, arg):
         """
-- 
2.48.1


