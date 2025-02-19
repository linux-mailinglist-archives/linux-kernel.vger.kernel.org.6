Return-Path: <linux-kernel+bounces-521101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB5A3B439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B3E3B024C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2B1DF26A;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIpWHncw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322F1D6DAD;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=uIv3pEnNlntQMezXsQj6PnWnS5EHgU09USJgamXEuI6eohVGEhFpbfgdRysTfoyN2SXbv52/jAZ2d0ZelQF1nq7PwMlm0QakN/wc8LKoX9WPRMBtzhyfiEW+434uOrMKQ+rqxcWItoXlmD/fJqudqoaHFzBv5ksKicldh/R6Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=Q2bW4rHBvXUepqtRYw3jrHwqyqtoRshTMOAzsCvXTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMkPncGjLaXSsB7SuFntci9pGqTZsGedKZWr3/ScbO5q7MNzfjQlFCvyWad3z/7NzEitP38cR9sK1JAGg4y7oKXF/7CWGgsTbCzCRV7TSp6fFez1UF5lMgROOAnCxWir7l4oPRnmu6EOsXp8ZvdkGEPC8QsHovyrEpq5BIrPVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIpWHncw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4517CC116B1;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=Q2bW4rHBvXUepqtRYw3jrHwqyqtoRshTMOAzsCvXTFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kIpWHncwKDu947B17a0ctNBsPEJInGdEIUGgSitnv8ydhWqi50jYS2Tu4qiUncVsO
	 M2XGvh2eVltRu2wOCPMowVIc/A9QndTNnauM39CWbgtUFsoT+/9Plpl4yMCs5Ygk0O
	 n765C60hy0wFihmyqlFbxZj1M2qVUfVQBiQoPIU0MYnsEwHNFzyDb8zF3fTtE7S057
	 KW7QNp95NClzKWt2Vry81DEU0W8XxDLs1NuGYvATMB1haKtgB0cyRY6NA+Xw6sOg9g
	 nnQLvzzxS2DQvEYJN9TwyhsITuA/MuPwVj6lbDAVFYbc9p+4a+CxKsAt6GyU9xYlNt
	 sIsfP0h/w0njg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5R-1ktQ;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/27] scripts/kernel-doc.py: move file lists to the parser function
Date: Wed, 19 Feb 2025 09:32:34 +0100
Message-ID: <c28104b85c933892c4d9ce89042654821c6430f4.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
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


