Return-Path: <linux-kernel+bounces-528505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391CA41877
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873D7174403
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0A2566C7;
	Mon, 24 Feb 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB5y2++5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF824A04F;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=a6cUdcRUpkRP0XQ99nYYln9bTwf7pUjoNilXGRUj8lGbZQ2QdlNWdjHxL/UXTR6YkBr7t09+sfPFbMjaY4z8AafSbNVgSRMvHUVBPmUk67NNR120/ITGcMDURHd7d094bky3vrwjcvv55+OoNgHHRKs13mumohWMOKMXFWMtwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=f3hhbbpUGqP6w/O5kQrl+GO4MbXaX4mT/0fXNELBwgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbcNDnwPqdphLkudKh4ohvdfyjIAYQ+aC0FTs7FhK6s1ZffYUd0qSmxgBVGcoZxP8W4vHDK0Y05NEu7rHAWBmnAUVikYE37aYUvNimGpKFQ/toAK2mfiRS7aVmfQX+HNjs5fTx5Cte1dygm+/Xwv1jhXPc5MDahM/ofJeY438rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB5y2++5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EFBC19424;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=f3hhbbpUGqP6w/O5kQrl+GO4MbXaX4mT/0fXNELBwgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YB5y2++5kEkhN3MH3+2K+mEfRgleCCW9kWxGhma3hQUC0VZ/gL9Kox4f/CKtMhEIh
	 alzztNiReSngs4HEIkE6PUyIF0Bxjtrc4LnfroxsvDuGBul2/NlbV2st7NNK3QyX3+
	 E6MG2ZPxgrtpYec13cIC6dyYoayAH1uqE92peuQhsh45RcSpfTi/zXFGxIib1e7VPH
	 eJprxVZj/1xNIBU1g7d4p87zu9S//C24QqibIov2hyqoyE0iXjDZHJX9ljpL0xTmAz
	 Y8WOEvxOiel3YkGPcbbj9xkPGzXMid2FKF/+Hk8R3vvy4ysCGItAES82CONedw9vbF
	 zGP0yGMItyclg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4u-1kit;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/39] scripts/kernel-doc.py: postpone warnings to the output plugin
Date: Mon, 24 Feb 2025 10:08:29 +0100
Message-ID: <a2493aa1d6567c05133fc13ea620244230eccac1.1740387599.git.mchehab+huawei@kernel.org>
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

We don't want to have warnings displayed for symbols that
weren't output. So, postpone warnings print to the output
plugin, where symbol output is validated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 24 +++++++++++++++----
 scripts/lib/kdoc/kdoc_parser.py | 41 ++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index ca21cd856be4..7aeaec884545 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -115,7 +115,16 @@ class OutputFormat:
 
         return block
 
-    def check_doc(self, name):
+    def out_warnings(self, args):
+        warnings = args.get('warnings', [])
+
+        for warning, log_msg in warnings:
+            if warning:
+                self.config.log.warning(log_msg)
+            else:
+                self.config.log.info(log_msg)
+
+    def check_doc(self, name, args):
         """Check if DOC should be output"""
 
         if self.no_doc_sections:
@@ -125,19 +134,22 @@ class OutputFormat:
             return False
 
         if self.out_mode == self.OUTPUT_ALL:
+            self.out_warnings(args)
             return True
 
         if self.out_mode == self.OUTPUT_INCLUDE:
             if name in self.function_table:
+                self.out_warnings(args)
                 return True
 
         return False
 
-    def check_declaration(self, dtype, name):
+    def check_declaration(self, dtype, name, args):
         if name in self.nosymbol:
             return False
 
         if self.out_mode == self.OUTPUT_ALL:
+            self.out_warnings(args)
             return True
 
         if self.out_mode in [self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED]:
@@ -146,9 +158,11 @@ class OutputFormat:
 
         if self.out_mode == self.OUTPUT_INTERNAL:
             if dtype != "function":
+                self.out_warnings(args)
                 return True
 
             if name not in self.function_table:
+                self.out_warnings(args)
                 return True
 
         return False
@@ -162,7 +176,7 @@ class OutputFormat:
             self.out_doc(fname, name, args)
             return self.data
 
-        if not self.check_declaration(dtype, name):
+        if not self.check_declaration(dtype, name, args):
             return self.data
 
         if dtype == "function":
@@ -327,7 +341,7 @@ class RestFormat(OutputFormat):
         self.data += "\n"
 
     def out_doc(self, fname, name, args):
-        if not self.check_doc(name):
+        if not self.check_doc(name, args):
             return
         self.out_section(args, out_docblock=True)
 
@@ -585,7 +599,7 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        if not self.check_doc(name):
+        if not self.check_doc(name, args):
                 return
 
         self.data += f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX' + "\n"
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 116289622f2c..a71145d531f2 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -130,23 +130,23 @@ class KernelDoc:
         # Place all potential outputs into an array
         self.entries = []
 
-    def show_warnings(self, dtype, declaration_name):  # pylint: disable=W0613
-        """
-        Allow filtering out warnings
-        """
-
-        # TODO: implement it
-
-        return True
-
     # TODO: rename to emit_message
     def emit_warning(self, ln, msg, warning=True):
         """Emit a message"""
 
+        log_msg = f"{self.fname}:{ln} {msg}"
+
+        if self.entry:
+            # Delegate warning output to output logic, as this way it
+            # will report warnings/info only for symbols that are output
+
+            self.entry.warnings.append((warning, log_msg))
+            return
+
         if warning:
-            self.config.log.warning("%s:%d %s", self.fname, ln, msg)
+            self.config.log.warning(log_msg)
         else:
-            self.config.log.info("%s:%d %s", self.fname, ln, msg)
+            self.config.log.info(log_msg)
 
     def dump_section(self, start_new=True):
         """
@@ -220,10 +220,9 @@ class KernelDoc:
         # For now, we're keeping the same name of the function just to make
         # easier to compare the source code of both scripts
 
-        if "declaration_start_line" not in args:
-            args["declaration_start_line"] = self.entry.declaration_start_line
-
+        args["declaration_start_line"] = self.entry.declaration_start_line
         args["type"] = dtype
+        args["warnings"] = self.entry.warnings
 
         # TODO: use colletions.OrderedDict
 
@@ -256,6 +255,8 @@ class KernelDoc:
         self.entry.struct_actual = ""
         self.entry.prototype = ""
 
+        self.entry.warnings = []
+
         self.entry.parameterlist = []
         self.entry.parameterdescs = {}
         self.entry.parametertypes = {}
@@ -327,7 +328,7 @@ class KernelDoc:
         if param not in self.entry.parameterdescs and not param.startswith("#"):
             self.entry.parameterdescs[param] = self.undescribed
 
-            if self.show_warnings(dtype, declaration_name) and "." not in param:
+            if "." not in param:
                 if decl_type == 'function':
                     dname = f"{decl_type} parameter"
                 else:
@@ -867,16 +868,14 @@ class KernelDoc:
             self.entry.parameterlist.append(arg)
             if arg not in self.entry.parameterdescs:
                 self.entry.parameterdescs[arg] = self.undescribed
-                if self.show_warnings("enum", declaration_name):
-                    self.emit_warning(ln,
-                                      f"Enum value '{arg}' not described in enum '{declaration_name}'")
+                self.emit_warning(ln,
+                                  f"Enum value '{arg}' not described in enum '{declaration_name}'")
             member_set.add(arg)
 
         for k in self.entry.parameterdescs:
             if k not in member_set:
-                if self.show_warnings("enum", declaration_name):
-                    self.emit_warning(ln,
-                                      f"Excess enum value '%{k}' description in '{declaration_name}'")
+                self.emit_warning(ln,
+                                  f"Excess enum value '%{k}' description in '{declaration_name}'")
 
         self.output_declaration('enum', declaration_name,
                                 enum=declaration_name,
-- 
2.48.1


