Return-Path: <linux-kernel+bounces-521108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77CA3B443
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE143B01B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E81E231D;
	Wed, 19 Feb 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfzoMqXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9C1DBB3A;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=eRBtuhJFFxiravDheqt4fOQWAknJi8gPP0YmnaQqjwn6c9n02bagVhFKEj06gcvMFr606lNWjwPQjK4fO5s3TvU1PEyt/bSEtj3ZimywJ5AF6DOnQBLweUoxDq/Dn/FcmeNfa0MmIfvxz8JJoDIlXi8//vvxWsDu9Oq1K802+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=06ZoIn6KWo8lW7Vli577BGyd08sXznBzolIIOLad8Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFgLu3zmqMowMKsyhKYqNvKJ9msQvKoz94jvQgv+969Wd80Qm+OM7cClmkllAI6vDEJPEIwE4Nh6z/NAVC7TUZMmUJyYkNMDaZ1W7kzw/Ead9TgWHLZ/ptBUrqo+F3KktgJk7Bw7kXwmMhF5R/sMOYsr6PuK7DqgZhrxYJ9p/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfzoMqXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53572C116C6;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=06ZoIn6KWo8lW7Vli577BGyd08sXznBzolIIOLad8Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfzoMqXzWl5RMPzeRGbajkpt71oeiDO5OEu1VnuHsUzSvmL5vhYio77WO4tQY7Stj
	 5ib1HFdR4eCTHtiqOXgMxeSzu+uFD7x821JJFerpqTbp0NVM3XWr7+Dd2of30ZWcrW
	 Ns0rx2DgKajr/P1IrIpi+Psr0+iN7wNoTpRqJb3fTlSn+olKW1rmwM3J+FqHGFGeKn
	 LbmSI97Tb5BPwNxXUua4k87Qrb9GvNU1PpENIefiFoH/XDk/Bu9c9WFugGZ2Wemuy6
	 rEatxO6tij93gD1JLFGJLMZO+3T1j8U/+Z4KN94fsB2k9cu0zofdYoPM+Y8kfRGxK1
	 u0OWdj9Dc/JJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5Z-1yYk;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/27] scripts/kernel-doc.py: fix line number output
Date: Wed, 19 Feb 2025 09:32:36 +0100
Message-ID: <eba44ab196fe7934f124b44af533d8429d3436cf.1739952783.git.mchehab+huawei@kernel.org>
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

With the Pyhton version, the actual output happens after parsing,
from records stored at self.entries.

Ensure that line numbers will be properly stored there and
that they'll produce the desired results at the ReST output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 13 +++++++------
 scripts/lib/kdoc/kdoc_parser.py | 21 +++++++++++++++++----
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 8729dc58e13c..b9b39bc29463 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -254,7 +254,8 @@ class RestFormat(OutputFormat):
     def print_lineno(self, ln):
         """Outputs a line number"""
 
-        if self.enable_lineno and ln:
+        if self.enable_lineno and ln is not None:
+            ln += 1
             self.data += f".. LINENO {ln}\n"
 
     def output_highlight(self, args):
@@ -357,7 +358,7 @@ class RestFormat(OutputFormat):
         parameterdescs = args.get('parameterdescs', {})
         parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
 
-        ln = args.get('ln', 0)
+        ln = args.get('declaration_start_line', 0)
 
         count = 0
         for parameter in parameterlist:
@@ -374,11 +375,11 @@ class RestFormat(OutputFormat):
         if not func_macro:
             signature += ")"
 
+        self.print_lineno(ln)
         if args.get('typedef') or not args.get('functiontype'):
             self.data += f".. c:macro:: {args['function']}\n\n"
 
             if args.get('typedef'):
-                self.print_lineno(ln)
                 self.data += "   **Typedef**: "
                 self.lineprefix = ""
                 self.output_highlight(args.get('purpose', ""))
@@ -433,7 +434,7 @@ class RestFormat(OutputFormat):
         name = args.get('enum', '')
         parameterlist = args.get('parameterlist', [])
         parameterdescs = args.get('parameterdescs', {})
-        ln = args.get('ln', 0)
+        ln = args.get('declaration_start_line', 0)
 
         self.data += f"\n\n.. c:enum:: {name}\n\n"
 
@@ -463,7 +464,7 @@ class RestFormat(OutputFormat):
 
         oldprefix = self.lineprefix
         name = args.get('typedef', '')
-        ln = args.get('ln', 0)
+        ln = args.get('declaration_start_line', 0)
 
         self.data += f"\n\n.. c:type:: {name}\n\n"
 
@@ -483,7 +484,7 @@ class RestFormat(OutputFormat):
         purpose = args.get('purpose', "")
         declaration = args.get('definition', "")
         dtype = args.get('type', "struct")
-        ln = args.get('ln', 0)
+        ln = args.get('declaration_start_line', 0)
 
         parameterlist = args.get('parameterlist', [])
         parameterdescs = args.get('parameterdescs', {})
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 6d6395e32093..633c95164b0c 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -275,7 +275,7 @@ class KernelDoc:
         self.entry.brcount = 0
 
         self.entry.in_doc_sect = False
-        self.entry.declaration_start_line = ln
+        self.entry.declaration_start_line = ln + 1
 
     def push_parameter(self, ln, decl_type, param, dtype,
                        org_arg, declaration_name):
@@ -805,8 +805,10 @@ class KernelDoc:
                                 parameterlist=self.entry.parameterlist,
                                 parameterdescs=self.entry.parameterdescs,
                                 parametertypes=self.entry.parametertypes,
+                                parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                 sectionlist=self.entry.sectionlist,
                                 sections=self.entry.sections,
+                                section_start_lines=self.entry.section_start_lines,
                                 purpose=self.entry.declaration_purpose)
 
     def dump_enum(self, ln, proto):
@@ -881,8 +883,10 @@ class KernelDoc:
                                 module=self.config.modulename,
                                 parameterlist=self.entry.parameterlist,
                                 parameterdescs=self.entry.parameterdescs,
+                                parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                 sectionlist=self.entry.sectionlist,
                                 sections=self.entry.sections,
+                                section_start_lines=self.entry.section_start_lines,
                                 purpose=self.entry.declaration_purpose)
 
     def dump_declaration(self, ln, prototype):
@@ -1053,8 +1057,10 @@ class KernelDoc:
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
+                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
+                                    section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose,
                                     func_macro=func_macro)
         else:
@@ -1066,8 +1072,10 @@ class KernelDoc:
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
+                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
+                                    section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose,
                                     func_macro=func_macro)
 
@@ -1111,8 +1119,10 @@ class KernelDoc:
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
+                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
+                                    section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose)
             return
 
@@ -1135,6 +1145,7 @@ class KernelDoc:
                                     module=self.entry.modulename,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
+                                    section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose)
             return
 
@@ -1167,7 +1178,7 @@ class KernelDoc:
             return
 
         # start a new entry
-        self.reset_state(ln + 1)
+        self.reset_state(ln)
         self.entry.in_doc_sect = False
 
         # next line is always the function name
@@ -1280,7 +1291,7 @@ class KernelDoc:
             if r.match(line):
                 self.dump_section()
                 self.entry.section = self.section_default
-                self.entry.new_start_line = line
+                self.entry.new_start_line = ln
                 self.entry.contents = ""
 
         if doc_sect.search(line):
@@ -1618,7 +1629,9 @@ class KernelDoc:
             self.dump_section()
             self.output_declaration("doc", None,
                                     sectionlist=self.entry.sectionlist,
-                                    sections=self.entry.sections, module=self.config.modulename)
+                                    sections=self.entry.sections,
+                                    section_start_lines=self.entry.section_start_lines,
+                                    module=self.config.modulename)
             self.reset_state(ln)
 
         elif doc_content.search(line):
-- 
2.48.1


