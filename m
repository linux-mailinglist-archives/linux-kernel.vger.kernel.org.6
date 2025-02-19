Return-Path: <linux-kernel+bounces-521103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC124A3B4AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A558164D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9C1CAA9C;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9faGlxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2D1CCEF0;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=FCcbfvMLXsJe8zJMUDhrvsrYLrOmtSs9mOcpCgXubmD6geOEUtO2St/B2crMjqYc6QYCqJRRTi+Pvqqdx1BjcT5tNNkNI1EwAHvxeoGG1fRkOos3g20nfr6hqpAdoRbUkOV/7snulOQq/oj6t+9oTIp/2zzqcumGP6fK4SPb+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=IpThprTfJ/pbtHwAeyiILQ0MdhJxWk9SeTU5TEeUoNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ0alw7RUPibgGQcmRQHC/chZPeKL8cNQ4e3UVCwhM132A/ulKrsFYUZQg8kL5g+rdhwfktemkJ7m3gxSfYVKgW1IVl+hbyqVSLcbN+hrdCn7RIOdzWUe9v4WGD0KRJ5tEtds4L3A1oDBVzxBXgIxYQFWJwETmvx6m8ciZg/+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9faGlxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D95C113D0;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=IpThprTfJ/pbtHwAeyiILQ0MdhJxWk9SeTU5TEeUoNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9faGlxqxHrqr7dzrGSvo+gxHsWQ64ynVCsdJ+lymjr0H1W5PFhLCvyy8ixgCJXkW
	 /0FC2tqOdjZye73uIinvtCHMkEZeZAHJciwjY8f9gdOdfspQw++fGLciDgWFQ2U4pv
	 CJxDB1RbFbsQ6KQZogtDZaxUUzSAnHSVTQYtN6fxZsaHuuV0ZWyOBD8gOGFsj9684a
	 C02fjz/M+Csk5INFjaOEeen2CLDoO8d/y174JX27Glnu+5Sh84fGhmONSFOJQLdls5
	 adY7qAiMkOy0zlv+v1SfVC8H0LtGlp+U8KGf+2gB9JpZyFy3qoJCLsdFQ0qIhMuOg+
	 qfAoxEAw++6ww==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5V-1rhZ;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/27] scripts/kernel-doc.py: implement support for -no-doc-sections
Date: Wed, 19 Feb 2025 09:32:35 +0100
Message-ID: <21d60f48197a03781154755418a38e870a24de5d.1739952783.git.mchehab+huawei@kernel.org>
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


