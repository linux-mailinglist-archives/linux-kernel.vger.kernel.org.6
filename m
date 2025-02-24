Return-Path: <linux-kernel+bounces-528501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28671A41873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5037916FFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA6253358;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwV4W9Ur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE224634F;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=dbdN20jMoJkAXPGheObRtlCiJiqGp+2kUoU3rpga0nBdgSc8FtUNBtfjKoMUZ+nR3nTixzXzeO4GJoH7heWQFG2ym/yEHw7e62al9dgRE0ab9e4ICMBeQ5FfV+MPp4sFMmK14ueLWuSt7PKwDJ63VP5KzTpftnLfo3HjIeNTKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=AdyCuuoiDzM5JN3vT/qTkSEQUe1tw1eDWso5VHl1JSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVP45RuKQHaeQlEj+IW25s5nw1NGwW46iMu0nBQlc0AFpts3yc2rl+rpkbEBH/23VjWmlqtQnekmP2hMpucnTC72v4Xu4NgRaVXHZGW5cYbfrGGmY3YIVHX2PoSO2nLhr68xpa+bHfeTXB16nrHJnas8A1SAqzGnfRf/X1Bq0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwV4W9Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279E2C4CEDD;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=AdyCuuoiDzM5JN3vT/qTkSEQUe1tw1eDWso5VHl1JSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwV4W9Ura7fETii+nwWIxwDXMTqsO74p7XU7Wi+FmVB7ECIIAsxb/bP7sMcrqWYvv
	 PFDih0KYAAYumhyg269+dHQwPQfOL+7REELMpoeXvuf/E9jOGDMhKgXiFM3imnrd2x
	 v3ND+/w2A4g3JDPUrtacGwuElUMUyf1Uzb/hPYLJiwTEwCJU2Af8tdimf7H2BPFCHh
	 mD2suKdUd8GJjLqvSK3slvcs/sriixjkJiNUzImpHgt0G+NnVibOc2Cu0Zv9BKlpLr
	 M7KfD1LqPz7dCDU1wG1IQ4l3xEwRB9SPEZYO78dI0sE5xyaUVcmlnP/g7L/n0TA35a
	 iyl+p7bLqLsUQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p4m-1Wtb;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/39] scripts/kernel-doc.py: fix handling of doc output check
Date: Mon, 24 Feb 2025 10:08:27 +0100
Message-ID: <0bc4f5860a633f177dbbafb0f42da601ad4935c3.1740387599.git.mchehab+huawei@kernel.org>
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


