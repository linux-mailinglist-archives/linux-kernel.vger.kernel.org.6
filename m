Return-Path: <linux-kernel+bounces-528502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D2A41875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2522A3B1F74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4D1253B67;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsrVLo0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCA2475C7;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=FXlvfxN3uMkSSFKDu0WxqRxlSNyzETNZ7YI9HRafT93/b9U6XpDTDGLU5ZXVBrQF6CGJRgL3ZEIgD5qinPyIvGFEhvZ+cByyr6ZlIOMlsnGoXAXBNsluRs0RdooLyfCdM1XqrCy3PTuw26/Cpacz40lf9e9wVq5r0hd1yqjTPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=IpThprTfJ/pbtHwAeyiILQ0MdhJxWk9SeTU5TEeUoNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc2UDfUjdJjqew/QZcF349bPHo+BIdQqzfd+hTPdP0Dewca04+FyAQz9c19fWfRnch7AQr8yIevUsXLk47auVyXg3qLel03qeeXkzv6g1L23tOzjsA/vkgw0VgXn/s+5NhaRlBU+ZgWADkZiFRZuD8ho9DhX8zYhedwVX1igJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsrVLo0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD52C116C6;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=IpThprTfJ/pbtHwAeyiILQ0MdhJxWk9SeTU5TEeUoNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsrVLo0G7Rglf1TxWKWKtqL8JAhipBdKRAcqPlq1E9nn4d8A6eYulJjQRBPVngDak
	 ly4Xh15mZ5Yj0IJPpPvN5oiv0B5LSrfN2VF7J0ITYlSTyYICP3JyaS1XT9ef5IAdyJ
	 1QGRcp+2yEkw0PUEb8bg5C4jNp/9M2h81LNlY0bAKJlN9P3JrfvlJ8rExuAoAYbvGX
	 1L1wScwAV4MS2u0rMcS9o5oNts/aroPlQihN2yPpuDrbRLiDJG8ompRSNFEHHrRTza
	 jm2dg1s+xaSjtphN8M3pCAFCBVO8FxbW3eHJ8ranRYcuygLgYYG7tcdAUfwXo7ARJv
	 BzMUZHVsDXY5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4e-1JGU;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/39] scripts/kernel-doc.py: implement support for -no-doc-sections
Date: Mon, 24 Feb 2025 10:08:25 +0100
Message-ID: <5292a5419c95f7754706e4d7ee59f74bf8d876b5.1740387599.git.mchehab+huawei@kernel.org>
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

The venerable kernel-doc Perl script has a number of options that
aren't properly documented. Among them, there is -no-doc-sections,
which is used by the Sphinx extension.

Implement support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           | 8 ++++++--
 scripts/lib/kdoc/kdoc_files.py  | 5 +++--
 scripts/lib/kdoc/kdoc_output.py | 7 ++++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index a687a7abb3b9..d700451e9541 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -164,10 +164,13 @@ def main():
     sel_mut.add_argument("-s", "-function", "--symbol", action='append',
                          help=FUNCTION_DESC)
 
-    # This one is valid for all 3 types of filter
+    # Those are valid for all 3 types of filter
     parser.add_argument("-n", "-nosymbol", "--nosymbol", action='append',
                          help=NOSYMBOL_DESC)
 
+    parser.add_argument("-D", "-no-doc-sections", "--no-doc-sections",
+                        action='store_true', help="Don't outputt DOC sections")
+
     parser.add_argument("files", metavar="FILE",
                         nargs="+", help=FILES_DESC)
 
@@ -209,7 +212,8 @@ def main():
 
     for t in kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
                           internal=args.internal, symbol=args.symbol,
-                          nosymbol=args.nosymbol):
+                          nosymbol=args.nosymbol,
+                          no_doc_sections=args.no_doc_sections):
         msg = t[1]
         if msg:
             print(msg)
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 4a6e75dbdbdd..c215ae3047b8 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -237,7 +237,7 @@ class KernelFiles():
         return self.out_style.msg(fname, name, arg)
 
     def msg(self, enable_lineno=False, export=False, internal=False,
-            symbol=None, nosymbol=None):
+            symbol=None, nosymbol=None, no_doc_sections=False):
         """
         Interacts over the kernel-doc results and output messages,
         returning kernel-doc markups on each interaction
@@ -256,7 +256,8 @@ class KernelFiles():
         self.out_style.set_config(self.config)
 
         self.out_style.set_filter(export, internal, symbol, nosymbol,
-                                  function_table, enable_lineno)
+                                  function_table, enable_lineno,
+                                  no_doc_sections)
 
         for fname, arg_tuple in self.results:
             msg = ""
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 91f6e356d03d..8729dc58e13c 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -69,6 +69,7 @@ class OutputFormat:
         self.symbol = None
         self.function_table = set()
         self.config = None
+        self.no_doc_sections = False
 
         self.data = ""
 
@@ -76,7 +77,7 @@ class OutputFormat:
         self.config = config
 
     def set_filter(self, export, internal, symbol, nosymbol, function_table,
-                   enable_lineno):
+                   enable_lineno, no_doc_sections):
         """
         Initialize filter variables according with the requested mode.
 
@@ -86,6 +87,7 @@ class OutputFormat:
         """
 
         self.enable_lineno = enable_lineno
+        self.no_doc_sections = no_doc_sections
 
         if symbol:
             self.out_mode = self.OUTPUT_INCLUDE
@@ -116,6 +118,9 @@ class OutputFormat:
     def check_doc(self, name):
         """Check if DOC should be output"""
 
+        if self.no_doc_sections:
+            return False
+
         if self.out_mode == self.OUTPUT_ALL:
             return True
 
-- 
2.48.1


