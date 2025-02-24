Return-Path: <linux-kernel+bounces-528527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2DA41896
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8758189A723
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319B25D532;
	Mon, 24 Feb 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag3s7dYs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0E24BC1D;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=Ev79LJIRkfBXMKg/nM6MK+e+O7OZgYxrw545a0AFYCd/yT27KEJDv4zt0uuGB0KgYD64GEc3IHJDKg7tOR6HlhnBHe39HAvATGS0X6EZEz6p5eHYVjoUc/N9qoQP38JJus/j9zUxQV6ZJfsqhQdpXOZ1MYlzJ3YF158TSGZEdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=+EJ3SDteq48iBweClenCe9Dykw6QAlbaFdmLf8wgy00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbOlpqnSL4J5BBiEbydHV/77rjL71nXwXDMvGgXhw321LuvMVpLRL+XeRnUtdI3GRd/elo2LN6cgiWR4Tf3oJkgKsFCIWBNk9wakwhgZbXXrJo4eslS9qFF9i5QXkUvdPJTikkC5uAyib/mArcafzxzIHtSkAWnsFJtM0kNkh4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag3s7dYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BFDC2BCF4;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388144;
	bh=+EJ3SDteq48iBweClenCe9Dykw6QAlbaFdmLf8wgy00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ag3s7dYsXuag7uuTCvZ0n71LLyCTe5B6By8OwSe30B7t9bzlfPXt8QEuIgIN5Bxia
	 3rIkQ8I5sgdjPSPWExFflttj75o5JNcfo3eCkwxo1vVCruGKqXvM5FiJMUvSu4kpmW
	 ELztUYy+s7mNKNo/bcPid2cqOSMpeEacptZZ+r9iGJQyfUfStpJBbiT8XIgmOvp9Mr
	 BBoUBmldA1cdCjXPxt8t94TfHp3+PwQ0+0Ir0wnXZPWdYgywgio7EWUI1zE+67tOG6
	 Bt+EYv43uk+H/usL+yYd3vOsRXnH0WoEnmXEmC/R7V4FFA/JOy44dxEl5pFRXZ6nMA
	 fXEuHy1EWoQsg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5v-3QD2;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/39] scripts/kernel_doc.py: better handle exported symbols
Date: Mon, 24 Feb 2025 10:08:44 +0100
Message-ID: <8578e6ff3a639ca82dfd7300609391edcbc64889.1740387599.git.mchehab+huawei@kernel.org>
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

Change the logic which detects internal/external symbols in a way
that we can re-use it when calling via Sphinx extension.

While here, remove an unused self.config var and let it clearer
that self.config variables are read-only. This helps to allow
handling multiple times in parallel if ever needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           |   2 +-
 scripts/lib/kdoc/kdoc_files.py  | 142 +++++++++++++++++---------------
 scripts/lib/kdoc/kdoc_output.py |   9 +-
 scripts/lib/kdoc/kdoc_parser.py |  52 ++++++++++--
 4 files changed, 125 insertions(+), 80 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 5e1e1839438c..eb308c938717 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -212,7 +212,7 @@ def main():
 
     for t in kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
                         internal=args.internal, symbol=args.symbol,
-                        nosymbol=args.nosymbol,
+                        nosymbol=args.nosymbol, export_file=args.export_file,
                         no_doc_sections=args.no_doc_sections):
         msg = t[1]
         if msg:
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 8935a8603b44..6da93febdb01 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -67,6 +67,9 @@ class GlobSourceFiles:
         handling directories if any
         """
 
+        if not file_list:
+            return
+
         for fname in file_list:
             if self.srctree:
                 f = os.path.join(self.srctree, fname)
@@ -83,40 +86,70 @@ class GlobSourceFiles:
 
 class KernelFiles():
     """
-    Parse lernel-doc tags on multiple kernel source files.
+    Parse kernel-doc tags on multiple kernel source files.
+
+    There are two type of parsers defined here:
+        - self.parse_file(): parses both kernel-doc markups and
+          EXPORT_SYMBOL* macros;
+        - self.process_export_file(): parses only EXPORT_SYMBOL* macros.
     """
 
+    def warning(self, msg):
+        """Ancillary routine to output a warning and increment error count"""
+
+        self.config.log.warning(msg)
+        self.errors += 1
+
+    def error(self, msg):
+        """Ancillary routine to output an error and increment error count"""
+
+        self.config.log.error(msg)
+        self.errors += 1
+
     def parse_file(self, fname):
         """
         Parse a single Kernel source.
         """
 
+        # Prevent parsing the same file twice if results are cached
+        if fname in self.files:
+            return
+
         doc = KernelDoc(self.config, fname)
-        doc.run()
+        export_table, entries = doc.parse_kdoc()
 
-        return doc.entries
+        self.export_table[fname] = export_table
+
+        self.files.add(fname)
+        self.export_files.add(fname)      # parse_kdoc() already check exports
+
+        self.results[fname] = entries
 
     def process_export_file(self, fname):
         """
         Parses EXPORT_SYMBOL* macros from a single Kernel source file.
         """
-        try:
-            with open(fname, "r", encoding="utf8",
-                      errors="backslashreplace") as fp:
-                for line in fp:
-                    KernelDoc.process_export(self.config.function_table, line)
-
-        except IOError:
-            self.config.log.error("Error: Cannot open fname %s", fname)
-            self.config.errors += 1
+
+        # Prevent parsing the same file twice if results are cached
+        if fname in self.export_files:
+            return
+
+        doc = KernelDoc(self.config, fname)
+        export_table = doc.parse_export()
+
+        if not export_table:
+            self.error(f"Error: Cannot check EXPORT_SYMBOL* on {fname}")
+            export_table = set()
+
+        self.export_table[fname] = export_table
+        self.export_files.add(fname)
 
     def file_not_found_cb(self, fname):
         """
         Callback to warn if a file was not found.
         """
 
-        self.config.log.error("Cannot find file %s", fname)
-        self.config.errors += 1
+        self.error(f"Cannot find file {fname}")
 
     def __init__(self, verbose=False, out_style=None,
                  werror=False, wreturn=False, wshort_desc=False,
@@ -146,7 +179,9 @@ class KernelFiles():
             if kdoc_werror:
                 werror = kdoc_werror
 
-        # Set global config data used on all files
+        # Some variables are global to the parser logic as a whole as they are
+        # used to send control configuration to KernelDoc class. As such,
+        # those variables are read-only inside the KernelDoc.
         self.config = argparse.Namespace
 
         self.config.verbose = verbose
@@ -155,27 +190,25 @@ class KernelFiles():
         self.config.wshort_desc = wshort_desc
         self.config.wcontents_before_sections = wcontents_before_sections
 
-        self.config.function_table = set()
-        self.config.source_map = {}
-
         if not logger:
             self.config.log = logging.getLogger("kernel-doc")
         else:
             self.config.log = logger
 
-        self.config.kernel_version = os.environ.get("KERNELVERSION",
-                                                    "unknown kernel version'")
+        self.config.warning = self.warning
+
         self.config.src_tree = os.environ.get("SRCTREE", None)
 
+        # Initialize variables that are internal to KernelFiles
+
         self.out_style = out_style
 
-        # Initialize internal variables
-
-        self.config.errors = 0
+        self.errors = 0
         self.results = {}
 
         self.files = set()
         self.export_files = set()
+        self.export_table = {}
 
     def parse(self, file_list, export_file=None):
         """
@@ -184,28 +217,11 @@ class KernelFiles():
 
         glob = GlobSourceFiles(srctree=self.config.src_tree)
 
-        # Prevent parsing the same file twice to speedup parsing and
-        # avoid reporting errors multiple times
-
         for fname in glob.parse_files(file_list, self.file_not_found_cb):
-            if fname not in self.files:
-                self.results[fname] = self.parse_file(fname)
-                self.files.add(fname)
-
-        # If a list of export files was provided, parse EXPORT_SYMBOL*
-        # from files that weren't fully parsed
-
-        if not export_file:
-            return
-
-        self.export_files |= self.files
-
-        glob = GlobSourceFiles(srctree=self.config.src_tree)
+            self.parse_file(fname)
 
         for fname in glob.parse_files(export_file, self.file_not_found_cb):
-            if fname not in self.export_files:
-                self.process_export_file(fname)
-                self.export_files.add(fname)
+            self.process_export_file(fname)
 
     def out_msg(self, fname, name, arg):
         """
@@ -222,32 +238,35 @@ class KernelFiles():
 
     def msg(self, enable_lineno=False, export=False, internal=False,
             symbol=None, nosymbol=None, no_doc_sections=False,
-            filenames=None):
+            filenames=None, export_file=None):
         """
         Interacts over the kernel-doc results and output messages,
         returning kernel-doc markups on each interaction
         """
 
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
         self.out_style.set_config(self.config)
 
-        self.out_style.set_filter(export, internal, symbol, nosymbol,
-                                  function_table, enable_lineno,
-                                  no_doc_sections)
-
         if not filenames:
             filenames = sorted(self.results.keys())
 
         for fname in filenames:
+            function_table = set()
+
+            if internal or export:
+                if not export_file:
+                    export_file = [fname]
+
+                for f in export_file:
+                    function_table |= self.export_table[f]
+
+            if symbol:
+                for s in symbol:
+                    function_table.add(s)
+
+            self.out_style.set_filter(export, internal, symbol, nosymbol,
+                                      function_table, enable_lineno,
+                                      no_doc_sections)
+
             msg = ""
             for name, arg in self.results[fname]:
                 msg += self.out_msg(fname, name, arg)
@@ -260,12 +279,3 @@ class KernelFiles():
                                             fname, ln, dtype)
             if msg:
                 yield fname, msg
-
-    @property
-    def errors(self):
-        """
-        Return a count of the number of warnings found, including
-        the ones displayed while interacting over self.msg.
-        """
-
-        return self.config.errors
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 487068753b53..c07ca749a82f 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -68,7 +68,7 @@ class OutputFormat:
         self.enable_lineno = None
         self.nosymbol = {}
         self.symbol = None
-        self.function_table = set()
+        self.function_table = None
         self.config = None
         self.no_doc_sections = False
 
@@ -93,10 +93,10 @@ class OutputFormat:
 
         self.enable_lineno = enable_lineno
         self.no_doc_sections = no_doc_sections
+        self.function_table = function_table
 
         if symbol:
             self.out_mode = self.OUTPUT_INCLUDE
-            function_table = symbol
         elif export:
             self.out_mode = self.OUTPUT_EXPORTED
         elif internal:
@@ -107,8 +107,6 @@ class OutputFormat:
         if nosymbol:
             self.nosymbol = set(nosymbol)
 
-        if function_table:
-            self.function_table = function_table
 
     def highlight_block(self, block):
         """
@@ -128,8 +126,7 @@ class OutputFormat:
         warnings = args.get('warnings', [])
 
         for log_msg in warnings:
-            self.config.log.warning(log_msg)
-            self.config.errors += 1
+            self.config.warning(log_msg)
 
     def check_doc(self, name, args):
         """Check if DOC should be output"""
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index cf4bf7cedcbc..7c8fdb469676 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1132,21 +1132,25 @@ class KernelDoc:
         self.emit_warning(ln, "error: Cannot parse typedef!")
 
     @staticmethod
-    def process_export(function_table, line):
+    def process_export(function_set, line):
         """
         process EXPORT_SYMBOL* tags
 
-        This method is called both internally and externally, so, it
-        doesn't use self.
+        This method doesn't use any variable from the class, so declare it
+        with a staticmethod decorator.
         """
 
+        # Note: it accepts only one EXPORT_SYMBOL* per line, as having
+        # multiple export lines would violate Kernel coding style.
+
         if export_symbol.search(line):
             symbol = export_symbol.group(2)
-            function_table.add(symbol)
+            function_set.add(symbol)
+            return
 
         if export_symbol_ns.search(line):
             symbol = export_symbol_ns.group(2)
-            function_table.add(symbol)
+            function_set.add(symbol)
 
     def process_normal(self, ln, line):
         """
@@ -1616,17 +1620,39 @@ class KernelDoc:
         elif doc_content.search(line):
             self.entry.contents += doc_content.group(1) + "\n"
 
-    def run(self):
+    def parse_export(self):
+        """
+        Parses EXPORT_SYMBOL* macros from a single Kernel source file.
+        """
+
+        export_table = set()
+
+        try:
+            with open(self.fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+
+                for line in fp:
+                    self.process_export(export_table, line)
+
+        except IOError:
+            return None
+
+        return export_table
+
+    def parse_kdoc(self):
         """
         Open and process each line of a C source file.
-        he parsing is controlled via a state machine, and the line is passed
+        The parsing is controlled via a state machine, and the line is passed
         to a different process function depending on the state. The process
         function may update the state as needed.
+
+        Besides parsing kernel-doc tags, it also parses export symbols.
         """
 
         cont = False
         prev = ""
         prev_ln = None
+        export_table = set()
 
         try:
             with open(self.fname, "r", encoding="utf8",
@@ -1658,6 +1684,16 @@ class KernelDoc:
                                           self.st_inline_name[self.inline_doc_state],
                                           line)
 
+                    # This is an optimization over the original script.
+                    # There, when export_file was used for the same file,
+                    # it was read twice. Here, we use the already-existing
+                    # loop to parse exported symbols as well.
+                    #
+                    # TODO: It should be noticed that not all states are
+                    # needed here. On a future cleanup, process export only
+                    # at the states that aren't handling comment markups.
+                    self.process_export(export_table, line)
+
                     # Hand this line to the appropriate state handler
                     if self.state == self.STATE_NORMAL:
                         self.process_normal(ln, line)
@@ -1674,3 +1710,5 @@ class KernelDoc:
                         self.process_docblock(ln, line)
         except OSError:
             self.config.log.error(f"Error: Cannot open file {self.fname}")
+
+        return export_table, self.entries
-- 
2.48.1


