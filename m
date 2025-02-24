Return-Path: <linux-kernel+bounces-528520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBDA41887
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0C8188858B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449B2586D4;
	Mon, 24 Feb 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FphbtCHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EC324BBEF;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=QYdE2N08Fum2N4kqqaWSqH+S2BNLAndxe2G0M4fSMxT8wFgPTqz0nm3evbxEu6yikUv/MFfS02viBxSrdoYkuO7nRK+MVjYoDzLBkkTZwFohTHiXbw7SutwCs8VQO4Z24Qw+UMR1joO85XJv8UOZnoXnkELnGiL08JrdRtlzWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=kkF62LinWQ1IkT47CUMzLT2NmYxiRtevRju9Af+8QaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhE6OcmE3CSAtUCGPQT+WUVvJe0ja601Hqtlm29k1C0tIDeE0bgXF3wyjV8OdE3wIziASVk1VAr3s5A380Ein1KnfaHx4aGwS4WpezcQ6V3GuP+X+VEef1aw++5Rb2eYsVOW/XApZ4czXcTVAXFl/eSN+HRtva57lA08/4CVvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FphbtCHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9320EC4CEFC;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=kkF62LinWQ1IkT47CUMzLT2NmYxiRtevRju9Af+8QaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FphbtCHMhvRpx5D3dDodEX/9NpLXJwgF2caoxEwWxh10p5F5E3hQTrYk1xdlw9565
	 HFZZOEA0SGuFY88tf7lgueWzRuWS4Kx15rsFcV88WaNg1Zv2Mmq3vBFKdV/4XC9Upu
	 Ko2SREcTrrcMV8hlEe9yu4qZ7xX1FEX3QKjIMANgTSVPChmf6jB5R/SwqlbwIdpSoI
	 q74TMzWeCmglOGf1/CLOt59pXotDDaDMBsbzVS2VUbowBm9ZnXhyFcL1KpJwY+XRy9
	 kkqo79aKdJSRUOHMA/XxTnGY/dHO71kmjRgaH5I81U/XaF7NM+Y7MRn8t15vKKjVbY
	 8ZlWn2eZjmM1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5f-2ySh;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/39] scripts/kernel-doc.py: Properly handle Werror and exit codes
Date: Mon, 24 Feb 2025 10:08:40 +0100
Message-ID: <4d1cb32e557b82a53d91219494e2f019d5c26000.1740387599.git.mchehab+huawei@kernel.org>
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

The original kernel-doc script has a logic to return warnings
as errors, and to report the number of warnings found, if in
verbose mode.

Implement it to be fully compatible with the original script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           | 18 ++++++++++++++++--
 scripts/lib/kdoc/kdoc_files.py  | 11 ++++++++++-
 scripts/lib/kdoc/kdoc_output.py |  8 +++-----
 scripts/lib/kdoc/kdoc_parser.py | 15 ++++++---------
 4 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 064106c18d8b..7683fb4ffc59 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -3,8 +3,6 @@
 # Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
 # SPDX-License-Identifier: GPL-2.0
 
-# TODO: implement warning filtering
-
 """
 kernel_doc
 ==========
@@ -220,6 +218,22 @@ def main():
         if msg:
             print(msg)
 
+    error_count = kfiles.errors
+    if not error_count:
+        sys.exit(0)
+
+    if args.werror:
+        print(f"{error_count} warnings as errors")
+        sys.exit(error_count)
+
+    if args.verbose:
+        print(f"{error_count} errors")
+
+    if args.none:
+        sys.exit(0)
+
+    sys.exit(error_count)
+
 
 # Call main method
 if __name__ == "__main__":
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 19fe9c6f5352..e130e5e32806 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -108,7 +108,7 @@ class KernelFiles():
                     KernelDoc.process_export(self.config.function_table, line)
 
         except IOError:
-            print(f"Error: Cannot open fname {fname}", fname=sys.stderr)
+            self.config.log.error("Error: Cannot open fname %s", fname)
             self.config.errors += 1
 
     def file_not_found_cb(self, fname):
@@ -261,3 +261,12 @@ class KernelFiles():
                                             fname, ln, dtype)
             if msg:
                 yield fname, msg
+
+    @property
+    def errors(self):
+        """
+        Return a count of the number of warnings found, including
+        the ones displayed while interacting over self.msg.
+        """
+
+        return self.config.errors
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 166fcabbb4cf..d0cb7f511f87 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -127,11 +127,9 @@ class OutputFormat:
 
         warnings = args.get('warnings', [])
 
-        for warning, log_msg in warnings:
-            if warning:
-                self.config.log.warning(log_msg)
-            else:
-                self.config.log.info(log_msg)
+        for log_msg in warnings:
+            self.config.log.warning(log_msg)
+            self.config.errors += 1
 
     def check_doc(self, name, args):
         """Check if DOC should be output"""
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index feac699a3893..6cebc32e18f2 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -136,17 +136,18 @@ class KernelDoc:
 
         log_msg = f"{self.fname}:{ln} {msg}"
 
+        if not warning:
+            self.config.log.info(log_msg)
+            return
+
         if self.entry:
             # Delegate warning output to output logic, as this way it
             # will report warnings/info only for symbols that are output
 
-            self.entry.warnings.append((warning, log_msg))
+            self.entry.warnings.append(log_msg)
             return
 
-        if warning:
-            self.config.log.warning(log_msg)
-        else:
-            self.config.log.info(log_msg)
+        self.config.log.warning(log_msg)
 
     def dump_section(self, start_new=True):
         """
@@ -568,7 +569,6 @@ class KernelDoc:
 
         if not members:
             self.emit_warning(ln, f"{proto} error: Cannot parse struct or union!")
-            self.config.errors += 1
             return
 
         if self.entry.identifier != declaration_name:
@@ -841,7 +841,6 @@ class KernelDoc:
 
         if not members:
             self.emit_warning(ln, f"{proto}: error: Cannot parse enum!")
-            self.config.errors += 1
             return
 
         if self.entry.identifier != declaration_name:
@@ -1143,7 +1142,6 @@ class KernelDoc:
             return
 
         self.emit_warning(ln, "error: Cannot parse typedef!")
-        self.config.errors += 1
 
     @staticmethod
     def process_export(function_table, line):
@@ -1692,4 +1690,3 @@ class KernelDoc:
                         self.process_docblock(ln, line)
         except OSError:
             self.config.log.error(f"Error: Cannot open file {self.fname}")
-            self.config.errors += 1
-- 
2.48.1


