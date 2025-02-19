Return-Path: <linux-kernel+bounces-521700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF113A3C133
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E783AFE10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762F1EFFA7;
	Wed, 19 Feb 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htesH/wF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EE1EA7F0;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973480; cv=none; b=Pw8ex1qvoRY40BIZ21F5d5NDVOKogHLQAToC6gTC0yA6wwpcX2ntYxNSj1BDKNk7qMdhaHqFbSLMEolWpU0+Fs5AtF89avTG2GK4OMB3+Ijf8hwI0q40TF5sYs8FyOyri3LLu6EFFKww3IQWO64i2OkvHWbWvN+CCKBMOXLDB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973480; c=relaxed/simple;
	bh=4i9tMFsRvYQf8CGO56ooCSwnWGYo0A/a2tTzIVmQWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2eMOxYwiOHKTYbHigCTin20E8ZnJaR35QgSJavhf90R9LfFf5E1k2QGohgNPvJjfDVX1K7W644CawyoD8cmCkLJbtm7ZRHyILgTcEQn0ojKkHJL2F/SbevL+vrhKAT2iD74Q5IKigPd+82u9hFStRQ/N0vgCnxgx6KcPUUs6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htesH/wF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90750C4CED1;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=4i9tMFsRvYQf8CGO56ooCSwnWGYo0A/a2tTzIVmQWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htesH/wFcMgCM7lbllXD5H23KE4fKWmk4hgZgcto/aU4FTsHZIr3eKaJ4CJYwbXrc
	 1H1uqv47+ZIXWW9F6htG4p07ARQ5GdMzFH4nO1l9D8TWi1n6ooK4wO5m4NXMZnwz3s
	 v8Qk7TzMqe5Y1+op+6rLH5S4FyyVnH5K2Feb3cCfAMjGU2m9qvHFMtImyh/hSALKD5
	 oq3vEKFkfOZ7lAnE7+e2F/F4TSFh58NkOKLuVCXhiigsZQuUEv0OA7JNJjZEGnpt0m
	 wW50EVQYnB3/G5qL02PlBhfoibNeS9DK4+kTF3A9LZk3g1EJ5uN7UaM/0sNsX9iURx
	 jMmd4qmh8CKiw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jR-0uVR;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] scripts/kernel-doc.py: move modulename to man class
Date: Wed, 19 Feb 2025 14:57:39 +0100
Message-ID: <138c24649a378ff5ff5fd6c05dfc1cf83e21bc07.1739972906.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972906.git.mchehab+huawei@kernel.org>
References: <cover.1739972906.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Only man output requires a modulename. Move its definition
to the man class.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py           |  6 +++---
 scripts/lib/kdoc/kdoc_files.py  |  6 +-----
 scripts/lib/kdoc/kdoc_output.py | 12 ++++++------
 scripts/lib/kdoc/kdoc_parser.py |  9 +--------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index daae2b4f3307..064106c18d8b 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -111,6 +111,7 @@ def main():
                         help="Enable debug messages")
 
     parser.add_argument("-M", "-modulename", "--modulename",
+                        default="Kernel API",
                         help="Allow setting a module name at the output.")
 
     parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
@@ -198,7 +199,7 @@ def main():
     logger.addHandler(handler)
 
     if args.man:
-        out_style = ManFormat()
+        out_style = ManFormat(modulename=args.modulename)
     elif args.none:
         out_style = None
     else:
@@ -207,8 +208,7 @@ def main():
     kfiles = KernelFiles(verbose=args.verbose,
                          out_style=out_style, werror=args.werror,
                          wreturn=args.wreturn, wshort_desc=args.wshort_desc,
-                         wcontents_before_sections=args.wcontents_before_sections,
-                         modulename=args.modulename)
+                         wcontents_before_sections=args.wcontents_before_sections)
 
     kfiles.parse(args.files, export_file=args.export_file)
 
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index e1ed2f6dae94..a2417cafb1c8 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -125,7 +125,7 @@ class KernelFiles():
     def __init__(self, verbose=False, out_style=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
-                 logger=None, modulename=None):
+                 logger=None):
         """
         Initialize startup variables and parse all files
         """
@@ -133,9 +133,6 @@ class KernelFiles():
         if not verbose:
             verbose = bool(os.environ.get("KBUILD_VERBOSE", 0))
 
-        if not modulename:
-            modulename = "Kernel API"
-
         if out_style is None:
             out_style = OutputFormat()
 
@@ -167,7 +164,6 @@ class KernelFiles():
         self.config.wreturn = wreturn
         self.config.wshort_desc = wshort_desc
         self.config.wcontents_before_sections = wcontents_before_sections
-        self.config.modulename = modulename
 
         self.config.function_table = set()
         self.config.source_map = {}
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index df3c15bb1c10..13a74a687f89 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -584,7 +584,7 @@ class ManFormat(OutputFormat):
     )
     blankline = ""
 
-    def __init__(self):
+    def __init__(self, modulename):
         """
         Creates class variables.
 
@@ -593,6 +593,7 @@ class ManFormat(OutputFormat):
         """
 
         super().__init__()
+        self.modulename = modulename
 
         dt = datetime.now()
         if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
@@ -624,14 +625,13 @@ class ManFormat(OutputFormat):
                 self.data += line + "\n"
 
     def out_doc(self, fname, name, args):
-        module = args.get('module')
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
         if not self.check_doc(name, args):
             return
 
-        self.data += f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         for section in sectionlist:
             self.data += f'.SH "{section}"' + "\n"
@@ -695,7 +695,7 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        self.data += f'.TH "{args["module"]}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"enum {args['enum']} \\- {args['purpose']}\n"
@@ -725,7 +725,7 @@ class ManFormat(OutputFormat):
             self.output_highlight(sections[section])
 
     def out_typedef(self, fname, name, args):
-        module = args.get('module')
+        module = self.modulename
         typedef = args.get('typedef')
         purpose = args.get('purpose')
         sectionlist = args.get('sectionlist', [])
@@ -741,7 +741,7 @@ class ManFormat(OutputFormat):
             self.output_highlight(sections.get(section))
 
     def out_struct(self, fname, name, args):
-        module = args.get('module')
+        module = self.modulename
         struct_type = args.get('type')
         struct_name = args.get('struct')
         purpose = args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 51ac2d69a587..0c0fa10b942b 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -801,7 +801,6 @@ class KernelDoc:
 
         self.output_declaration(decl_type, declaration_name,
                                 struct=declaration_name,
-                                module=self.entry.modulename,
                                 definition=declaration,
                                 parameterlist=self.entry.parameterlist,
                                 parameterdescs=self.entry.parameterdescs,
@@ -879,7 +878,6 @@ class KernelDoc:
 
         self.output_declaration('enum', declaration_name,
                                 enum=declaration_name,
-                                module=self.config.modulename,
                                 parameterlist=self.entry.parameterlist,
                                 parameterdescs=self.entry.parameterdescs,
                                 parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
@@ -1051,7 +1049,6 @@ class KernelDoc:
             self.output_declaration(decl_type, declaration_name,
                                     function=declaration_name,
                                     typedef=True,
-                                    module=self.config.modulename,
                                     functiontype=return_type,
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
@@ -1066,7 +1063,6 @@ class KernelDoc:
             self.output_declaration(decl_type, declaration_name,
                                     function=declaration_name,
                                     typedef=False,
-                                    module=self.config.modulename,
                                     functiontype=return_type,
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
@@ -1113,7 +1109,6 @@ class KernelDoc:
             self.output_declaration(decl_type, declaration_name,
                                     function=declaration_name,
                                     typedef=True,
-                                    module=self.entry.modulename,
                                     functiontype=return_type,
                                     parameterlist=self.entry.parameterlist,
                                     parameterdescs=self.entry.parameterdescs,
@@ -1141,7 +1136,6 @@ class KernelDoc:
 
             self.output_declaration('typedef', declaration_name,
                                     typedef=declaration_name,
-                                    module=self.entry.modulename,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
@@ -1630,8 +1624,7 @@ class KernelDoc:
             self.output_declaration("doc", self.entry.identifier,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
-                                    section_start_lines=self.entry.section_start_lines,
-                                    module=self.config.modulename)
+                                    section_start_lines=self.entry.section_start_lines)
             self.reset_state(ln)
 
         elif doc_content.search(line):
-- 
2.48.1


