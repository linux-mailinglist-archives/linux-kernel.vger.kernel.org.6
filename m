Return-Path: <linux-kernel+bounces-521109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF8A3B442
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EA11730B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46811E25E8;
	Wed, 19 Feb 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPdwBkfc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840B1DE2A1;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=lXbPFtRe9K8MCPJyLoJpcd9lXs97QIUy2TvOGUq9VBu9eC5zv5PaFMZTht5e6UV838QPA8lUUx6zCYx6dSnIWZNS4HGWErdH023ayTrWNpEeLQS7q8lKA/eiiO5jYCZuRS6POIVzW4CFsmGC1tcZWGWWv7M56LgHoXGkE3rglN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=AdyCuuoiDzM5JN3vT/qTkSEQUe1tw1eDWso5VHl1JSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KprVbCJDbDk9SWlGzJPBcyyFrs/vqv2EL/4+Q6o5gawp54uv1opSkQDbd8TyDeKUodGZOnfG7m4efDDgh7LtqJQv502rgF9A/yxSKeU+UtlVp9c+H/CA3uKrnwMDIb3g6sh2OvCrwdq7fbdvbHmy6skLCSWl7btTReX8NSkGVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPdwBkfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D478C4CEEE;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=AdyCuuoiDzM5JN3vT/qTkSEQUe1tw1eDWso5VHl1JSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPdwBkfcMGTjVLwOcNohEu549uigbIRfrM+HN6JWK/tSGFmrRxuw5WZBBTXaQUhFm
	 4kyqzjnI6fTGVaP7eZ/ZGjwnuxCWU+0NNQNWVQoM8/JthR9607FS5mYl/o1gJCJL25
	 YAHtjfHrPyXCX/pWWPII7NtWYRdlIAwXcy1rTxseRoYq91vKDHBKlSNBm98B0ccSQU
	 o3p1xejfG34SjGbEB1w0m4+V1ruGhY1/E5+hQFbmJ8ReWaKm8Fs8ttbFI1HXgYzH20
	 TnzhtCpg9DaXKLTVR92u8OGRSAs1eSTaou8VQjrr9D+EB5XaHvZk26DJR4iIB8tuip
	 /IpoJ+DT07HEQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5d-25L5;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/27] scripts/kernel-doc.py: fix handling of doc output check
Date: Wed, 19 Feb 2025 09:32:37 +0100
Message-ID: <bdbf1ba85d1509b468bc5641abbcf6856acca251.1739952783.git.mchehab+huawei@kernel.org>
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

The filtering logic was seeking for the DOC name to check for
symbols, but such data is stored only inside a section. Add it
to the output_declaration, as it is quicker/easier to check
the declaration name than to check inside each section.

While here, make sure that the output for both ReST and man
after filtering will be similar to what kernel-doc Perl
version does.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 29 ++++++++++++-----------------
 scripts/lib/kdoc/kdoc_parser.py |  3 ++-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index b9b39bc29463..6a392dad2e9d 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -121,13 +121,13 @@ class OutputFormat:
         if self.no_doc_sections:
             return False
 
+        if name in self.nosymbol:
+            return False
+
         if self.out_mode == self.OUTPUT_ALL:
             return True
 
         if self.out_mode == self.OUTPUT_INCLUDE:
-            if name in self.nosymbol:
-                return False
-
             if name in self.function_table:
                 return True
 
@@ -153,15 +153,6 @@ class OutputFormat:
 
         return False
 
-    def check_function(self, fname, name, args):
-        return True
-
-    def check_enum(self, fname, name, args):
-        return True
-
-    def check_typedef(self, fname, name, args):
-        return True
-
     def msg(self, fname, name, args):
         self.data = ""
 
@@ -305,7 +296,7 @@ class RestFormat(OutputFormat):
         for line in output.strip("\n").split("\n"):
             self.data += self.lineprefix + line + "\n"
 
-    def out_section(self, args, out_reference=False):
+    def out_section(self, args, out_docblock=False):
         """
         Outputs a block section.
 
@@ -324,7 +315,7 @@ class RestFormat(OutputFormat):
                 continue
 
             if not self.out_mode == self.OUTPUT_INCLUDE:
-                if out_reference:
+                if out_docblock:
                     self.data += f".. _{section}:\n\n"
 
                 if not self.symbol:
@@ -338,8 +329,7 @@ class RestFormat(OutputFormat):
     def out_doc(self, fname, name, args):
         if not self.check_doc(name):
             return
-
-        self.out_section(args, out_reference=True)
+        self.out_section(args, out_docblock=True)
 
     def out_function(self, fname, name, args):
 
@@ -582,8 +572,10 @@ class ManFormat(OutputFormat):
 
         for line in contents.strip("\n").split("\n"):
             line = Re(r"^\s*").sub("", line)
+            if not line:
+                continue
 
-            if line and line[0] == ".":
+            if line[0] == ".":
                 self.data += "\\&" + line + "\n"
             else:
                 self.data += line + "\n"
@@ -593,6 +585,9 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
+        if not self.check_doc(name):
+                return
+
         self.data += f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         for section in sectionlist:
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 633c95164b0c..116289622f2c 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1197,6 +1197,7 @@ class KernelDoc:
             else:
                 self.entry.section = doc_block.group(1)
 
+            self.entry.identifier = self.entry.section
             self.state = self.STATE_DOCBLOCK
             return
 
@@ -1627,7 +1628,7 @@ class KernelDoc:
 
         if doc_end.search(line):
             self.dump_section()
-            self.output_declaration("doc", None,
+            self.output_declaration("doc", self.entry.identifier,
                                     sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
-- 
2.48.1


