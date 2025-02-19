Return-Path: <linux-kernel+bounces-521107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89BCA3B448
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2DE176C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9C1CCEF0;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAv9YyDT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC331DC04A;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=G+/Lpz9eMqXNCd9f49o6nXBDcLm67Q8Rs2Kon2hPhVE73kk7hHOUNMkf4WvoT6Il0a9PfI69nleDpNNfQRAYZVbJRrbt0Q9bg05YsNv2cYHip/zydNl+R2f0Sx7vBMyS0jtVVDRerqTJAQ51JQAid98IoEKbTxmCtDc9K43a4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=2+Yr/2kIpnCitwTGtyjeQMnDH8wv+vGuRcW8RKqXkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLUlkreF4SexHslc9qLyWjvh6cNaJJajrHWV5jngFxmOZV3V7swgHOWCj9lwVgwRw8Xb41p8Nhzeyrk2CsRN2cxkxxEGSHCm7ZV8ZF3hpnWJaJcpsouz2pdf7G2RyKNNSV2cCQTX7SiMT4gMjfNWWZDwL7ptStmD9gZCu4MpnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAv9YyDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D1C4CEFD;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=2+Yr/2kIpnCitwTGtyjeQMnDH8wv+vGuRcW8RKqXkZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JAv9YyDTuiprHRGNMZ1qjSEkGj5oa4aBfrz++fFKJtI/ZIdmEmWythQGKFXJXdmGk
	 FgZn2VLwTTpIV4cc9f2zHjBQhctoYGHldwnhrM5AMO9u7qiXCTCTtGxBy7/bFIUYNv
	 qyB//s3GynHuz7+lB4oTJnvAi8JRAZdthit9ARfSGranTS2hEPSaS2AtTOqBMoCaa8
	 hjkQn87O9EuTexMMa88OYIXlhP4dSicmx52SUag2UuNvitVu+fX7vVewcd3djyS9KX
	 misqQe3v7ne663QT6uCDeSNtLdUjbjLMsrwIWzcysynzOyJwYlcPguV7xxO0Gvwhzd
	 PMwhQw88NODKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5F-1PUT;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/27] scripts/kernel-doc.py: move KernelFiles class to a separate file
Date: Wed, 19 Feb 2025 09:32:31 +0100
Message-ID: <f2e97492fcf32247a8ebe72b90f776d57248f63a.1739952783.git.mchehab+huawei@kernel.org>
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

The KernelFiles class is the main dispatcher which parses each
source file.

In preparation for letting kerneldoc Sphinx extension to import
Python libraries, move regex ancillary classes to a separate
file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py          | 220 +--------------------------
 scripts/lib/kdoc/kdoc_files.py | 269 +++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+), 219 deletions(-)
 create mode 100755 scripts/lib/kdoc/kdoc_files.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 193a30fcfb7c..cd79b2c1b746 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -44,6 +44,7 @@ sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
 from kdoc_parser import KernelDoc, type_param
 from kdoc_re import Re
+from kdoc_files import KernelFiles
 
 function_pointer = Re(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
 
@@ -68,225 +69,6 @@ type_member = Re(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
 type_fallback = Re(r"\&([_\w]+)", cache=False)
 type_member_func = type_member + Re(r"\(\)", cache=False)
 
-class GlobSourceFiles:
-    """
-    Parse C source code file names and directories via an Interactor.
-
-    """
-
-    def __init__(self, srctree=None, valid_extensions=None):
-        """
-        Initialize valid extensions with a tuple.
-
-        If not defined, assume default C extensions (.c and .h)
-
-        It would be possible to use python's glob function, but it is
-        very slow, and it is not interactive. So, it would wait to read all
-        directories before actually do something.
-
-        So, let's use our own implementation.
-        """
-
-        if not valid_extensions:
-            self.extensions = (".c", ".h")
-        else:
-            self.extensions = valid_extensions
-
-        self.srctree = srctree
-
-    def _parse_dir(self, dirname):
-        """Internal function to parse files recursively"""
-
-        with os.scandir(dirname) as obj:
-            for entry in obj:
-                name = os.path.join(dirname, entry.name)
-
-                if entry.is_dir():
-                    yield from self._parse_dir(name)
-
-                if not entry.is_file():
-                    continue
-
-                basename = os.path.basename(name)
-
-                if not basename.endswith(self.extensions):
-                    continue
-
-                yield name
-
-    def parse_files(self, file_list, file_not_found_cb):
-        for fname in file_list:
-            if self.srctree:
-                f = os.path.join(self.srctree, fname)
-            else:
-                f = fname
-
-            if os.path.isdir(f):
-                yield from self._parse_dir(f)
-            elif os.path.isfile(f):
-                yield f
-            elif file_not_found_cb:
-                file_not_found_cb(fname)
-
-
-class KernelFiles():
-
-    def parse_file(self, fname):
-
-        doc = KernelDoc(self.config, fname)
-        doc.run()
-
-        return doc
-
-    def process_export_file(self, fname):
-        try:
-            with open(fname, "r", encoding="utf8",
-                      errors="backslashreplace") as fp:
-                for line in fp:
-                    KernelDoc.process_export(self.config.function_table, line)
-
-        except IOError:
-            print(f"Error: Cannot open fname {fname}", fname=sys.stderr)
-            self.config.errors += 1
-
-    def file_not_found_cb(self, fname):
-        self.config.log.error("Cannot find file %s", fname)
-        self.config.errors += 1
-
-    def __init__(self, files=None, verbose=False, out_style=None,
-                 werror=False, wreturn=False, wshort_desc=False,
-                 wcontents_before_sections=False,
-                 logger=None, modulename=None, export_file=None):
-        """Initialize startup variables and parse all files"""
-
-
-        if not verbose:
-            verbose = bool(os.environ.get("KBUILD_VERBOSE", 0))
-
-        if not modulename:
-            modulename = "Kernel API"
-
-        dt = datetime.now()
-        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
-            # use UTC TZ
-            to_zone = tz.gettz('UTC')
-            dt = dt.astimezone(to_zone)
-
-        if not werror:
-            kcflags = os.environ.get("KCFLAGS", None)
-            if kcflags:
-                match = re.search(r"(\s|^)-Werror(\s|$)/", kcflags)
-                if match:
-                    werror = True
-
-            # reading this variable is for backwards compat just in case
-            # someone was calling it with the variable from outside the
-            # kernel's build system
-            kdoc_werror = os.environ.get("KDOC_WERROR", None)
-            if kdoc_werror:
-                werror = kdoc_werror
-
-        # Set global config data used on all files
-        self.config = argparse.Namespace
-
-        self.config.verbose = verbose
-        self.config.werror = werror
-        self.config.wreturn = wreturn
-        self.config.wshort_desc = wshort_desc
-        self.config.wcontents_before_sections = wcontents_before_sections
-        self.config.modulename = modulename
-
-        self.config.function_table = set()
-        self.config.source_map = {}
-
-        if not logger:
-            self.config.log = logging.getLogger("kernel-doc")
-        else:
-            self.config.log = logger
-
-        self.config.kernel_version = os.environ.get("KERNELVERSION",
-                                                    "unknown kernel version'")
-        self.config.src_tree = os.environ.get("SRCTREE", None)
-
-        self.out_style = out_style
-        self.export_file = export_file
-
-        # Initialize internal variables
-
-        self.config.errors = 0
-        self.results = []
-
-        self.file_list = files
-        self.files = set()
-
-    def parse(self):
-        """
-        Parse all files
-        """
-
-        glob = GlobSourceFiles(srctree=self.config.src_tree)
-
-        # Let's use a set here to avoid duplicating files
-
-        for fname in glob.parse_files(self.file_list, self.file_not_found_cb):
-            if fname in self.files:
-                continue
-
-            self.files.add(fname)
-
-            res = self.parse_file(fname)
-            self.results.append((res.fname, res.entries))
-
-        if not self.files:
-            sys.exit(1)
-
-        # If a list of export files was provided, parse EXPORT_SYMBOL*
-        # from the ones not already parsed
-
-        if self.export_file:
-            files = self.files
-
-            glob = GlobSourceFiles(srctree=self.config.src_tree)
-
-            for fname in glob.parse_files(self.export_file,
-                                          self.file_not_found_cb):
-                if fname not in files:
-                    files.add(fname)
-
-                    self.process_export_file(fname)
-
-    def out_msg(self, fname, name, arg):
-        # TODO: filter out unwanted parts
-
-        return self.out_style.msg(fname, name, arg)
-
-    def msg(self, enable_lineno=False, export=False, internal=False,
-            symbol=None, nosymbol=None):
-
-        function_table = self.config.function_table
-
-        if symbol:
-            for s in symbol:
-                function_table.add(s)
-
-        # Output none mode: only warnings will be shown
-        if not self.out_style:
-            return
-
-        self.out_style.set_config(self.config)
-
-        self.out_style.set_filter(export, internal, symbol, nosymbol,
-                                  function_table, enable_lineno)
-
-        for fname, arg_tuple in self.results:
-            for name, arg in arg_tuple:
-                if self.out_msg(fname, name, arg):
-                    ln = arg.get("ln", 0)
-                    dtype = arg.get('type', "")
-
-                    self.config.log.warning("%s:%d Can't handle %s",
-                                            fname, ln, dtype)
-
 
 class OutputFormat:
     # output mode.
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
new file mode 100755
index 000000000000..76dd53611c08
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -0,0 +1,269 @@
+#!/usr/bin/env python3
+# pylint: disable=R0903,R0913,R0914,R0917
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+# TODO: implement warning filtering
+
+"""
+Parse lernel-doc tags on multiple kernel source files.
+"""
+
+import argparse
+import logging
+import os
+import re
+import sys
+from datetime import datetime
+
+from dateutil import tz
+
+from kdoc_parser import KernelDoc
+
+
+class GlobSourceFiles:
+    """
+    Parse C source code file names and directories via an Interactor.
+    """
+
+    def __init__(self, srctree=None, valid_extensions=None):
+        """
+        Initialize valid extensions with a tuple.
+
+        If not defined, assume default C extensions (.c and .h)
+
+        It would be possible to use python's glob function, but it is
+        very slow, and it is not interactive. So, it would wait to read all
+        directories before actually do something.
+
+        So, let's use our own implementation.
+        """
+
+        if not valid_extensions:
+            self.extensions = (".c", ".h")
+        else:
+            self.extensions = valid_extensions
+
+        self.srctree = srctree
+
+    def _parse_dir(self, dirname):
+        """Internal function to parse files recursively"""
+
+        with os.scandir(dirname) as obj:
+            for entry in obj:
+                name = os.path.join(dirname, entry.name)
+
+                if entry.is_dir():
+                    yield from self._parse_dir(name)
+
+                if not entry.is_file():
+                    continue
+
+                basename = os.path.basename(name)
+
+                if not basename.endswith(self.extensions):
+                    continue
+
+                yield name
+
+    def parse_files(self, file_list, file_not_found_cb):
+        """
+        Define an interator to parse all source files from file_list,
+        handling directories if any
+        """
+
+        for fname in file_list:
+            if self.srctree:
+                f = os.path.join(self.srctree, fname)
+            else:
+                f = fname
+
+            if os.path.isdir(f):
+                yield from self._parse_dir(f)
+            elif os.path.isfile(f):
+                yield f
+            elif file_not_found_cb:
+                file_not_found_cb(fname)
+
+
+class KernelFiles():
+    """
+    Parse lernel-doc tags on multiple kernel source files.
+    """
+
+    def parse_file(self, fname):
+        """
+        Parse a single Kernel source.
+        """
+
+        doc = KernelDoc(self.config, fname)
+        doc.run()
+
+        return doc
+
+    def process_export_file(self, fname):
+        """
+        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        """
+        try:
+            with open(fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+                for line in fp:
+                    KernelDoc.process_export(self.config.function_table, line)
+
+        except IOError:
+            print(f"Error: Cannot open fname {fname}", fname=sys.stderr)
+            self.config.errors += 1
+
+    def file_not_found_cb(self, fname):
+        """
+        Callback to warn if a file was not found.
+        """
+
+        self.config.log.error("Cannot find file %s", fname)
+        self.config.errors += 1
+
+    def __init__(self, files=None, verbose=False, out_style=None,
+                 werror=False, wreturn=False, wshort_desc=False,
+                 wcontents_before_sections=False,
+                 logger=None, modulename=None, export_file=None):
+        """
+        Initialize startup variables and parse all files
+        """
+
+        if not verbose:
+            verbose = bool(os.environ.get("KBUILD_VERBOSE", 0))
+
+        if not modulename:
+            modulename = "Kernel API"
+
+        dt = datetime.now()
+        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
+            # use UTC TZ
+            to_zone = tz.gettz('UTC')
+            dt = dt.astimezone(to_zone)
+
+        if not werror:
+            kcflags = os.environ.get("KCFLAGS", None)
+            if kcflags:
+                match = re.search(r"(\s|^)-Werror(\s|$)/", kcflags)
+                if match:
+                    werror = True
+
+            # reading this variable is for backwards compat just in case
+            # someone was calling it with the variable from outside the
+            # kernel's build system
+            kdoc_werror = os.environ.get("KDOC_WERROR", None)
+            if kdoc_werror:
+                werror = kdoc_werror
+
+        # Set global config data used on all files
+        self.config = argparse.Namespace
+
+        self.config.verbose = verbose
+        self.config.werror = werror
+        self.config.wreturn = wreturn
+        self.config.wshort_desc = wshort_desc
+        self.config.wcontents_before_sections = wcontents_before_sections
+        self.config.modulename = modulename
+
+        self.config.function_table = set()
+        self.config.source_map = {}
+
+        if not logger:
+            self.config.log = logging.getLogger("kernel-doc")
+        else:
+            self.config.log = logger
+
+        self.config.kernel_version = os.environ.get("KERNELVERSION",
+                                                    "unknown kernel version'")
+        self.config.src_tree = os.environ.get("SRCTREE", None)
+
+        self.out_style = out_style
+        self.export_file = export_file
+
+        # Initialize internal variables
+
+        self.config.errors = 0
+        self.results = []
+
+        self.file_list = files
+        self.files = set()
+
+    def parse(self):
+        """
+        Parse all files
+        """
+
+        glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+        # Let's use a set here to avoid duplicating files
+
+        for fname in glob.parse_files(self.file_list, self.file_not_found_cb):
+            if fname in self.files:
+                continue
+
+            self.files.add(fname)
+
+            res = self.parse_file(fname)
+            self.results.append((res.fname, res.entries))
+
+        if not self.files:
+            sys.exit(1)
+
+        # If a list of export files was provided, parse EXPORT_SYMBOL*
+        # from the ones not already parsed
+
+        if self.export_file:
+            files = self.files
+
+            glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+            for fname in glob.parse_files(self.export_file,
+                                          self.file_not_found_cb):
+                if fname not in files:
+                    files.add(fname)
+
+                    self.process_export_file(fname)
+
+    def out_msg(self, fname, name, arg):
+        """
+        Output messages from a file name using the output style filtering.
+
+        If output type was not handled by the syler, return False.
+        """
+
+        # NOTE: we can add rules here to filter out unwanted parts,
+        # although OutputFormat.msg already does that.
+
+        return self.out_style.msg(fname, name, arg)
+
+    def msg(self, enable_lineno=False, export=False, internal=False,
+            symbol=None, nosymbol=None):
+        """
+        Interacts over the kernel-doc results and output messages.
+        """
+
+        function_table = self.config.function_table
+
+        if symbol:
+            for s in symbol:
+                function_table.add(s)
+
+        # Output none mode: only warnings will be shown
+        if not self.out_style:
+            return
+
+        self.out_style.set_config(self.config)
+
+        self.out_style.set_filter(export, internal, symbol, nosymbol,
+                                  function_table, enable_lineno)
+
+        for fname, arg_tuple in self.results:
+            for name, arg in arg_tuple:
+                if self.out_msg(fname, name, arg):
+                    ln = arg.get("ln", 0)
+                    dtype = arg.get('type', "")
+
+                    self.config.log.warning("%s:%d Can't handle %s",
+                                            fname, ln, dtype)
-- 
2.48.1


