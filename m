Return-Path: <linux-kernel+bounces-528525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91861A41895
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9883B5566
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E525B669;
	Mon, 24 Feb 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms3OBXsq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236A24BBFC;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=OiTGVb9O6rkfIPd6wSQBhGWWVBwufMkk5KCv19WP7DRFc95EIyP1u64zRuZaLxNecYfw2a7IoUMJRLgDtP1+2R6z1/kfVwAUiqKh0LqFJTM0HK/bgh+vbEtRwE3katYHybLlrSd3PtgsG4KxWzY6b9EGaOPDNaVD7njT2crHbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=4i9tMFsRvYQf8CGO56ooCSwnWGYo0A/a2tTzIVmQWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCcxY3sHq+k6qZC/JmYmv5zeFP9wBtiYtlOqoKzUHU2lCGcFjESnbPmN5yyG1nBOnDWtsnq9Qt0GlL5qiPC31O2VfZXvXvUe/q6/tH6x2GMAoU8lYrPm32dUSsaXq6NIpBdxQPb3AZ7AsCGEDBRYR4LaFfrgNDBiyAEGkmBWN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms3OBXsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFB0C4CEF9;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=4i9tMFsRvYQf8CGO56ooCSwnWGYo0A/a2tTzIVmQWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ms3OBXsqm2yisM/rJhvonJ1uqy3UA5V+Dicp/c47x5pE11GmIp/b/Ycws+BTedQzb
	 k8u61FIA8ScasigdqiWTJFvdKBRpjzy7ImvDVo0xNmCrn0NBPiLCA9Z9vjApeQE69z
	 aj7giQ5NrcZcyp4hfYm58jV2uLjlty0lVnmTw5eMaHowlz6eXppdYwVG/m8sFWzUNM
	 1HT/+1pK/bEGDpP8tNHZAjTXJlz+ZW7eVgLCIukbM3yhVUVxU8m3H3yWLE76h8rtH/
	 s1PBU5ARD+XceaVeAKsusoLGGBI0JWXsTUurpM/fqsD56G+14mQ4JDrfe84x9i/INF
	 7YQmkjJsOveCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5S-2dft;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/39] scripts/kernel-doc.py: move modulename to man class
Date: Mon, 24 Feb 2025 10:08:37 +0100
Message-ID: <096291e4eaddd666de7a6178d340f575d60ed9d9.1740387599.git.mchehab+huawei@kernel.org>
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


