Return-Path: <linux-kernel+bounces-528524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44229A4188C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E5B18961B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555E25A32E;
	Mon, 24 Feb 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN+i1Vkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045D24BBF7;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=C4kuJiO3UDkCmSIkEQ21xQRR2wcMykTmHWP7MuKuPwqjm0SGaUYk1uqQe+9XSLEcbUfMVyErEWyzXHy199KCIPIfI7SDbKNPjD8AcR+nQJUTTGFLsFP+pdpRngsTdxGEEcMPKpLqVBbPDYumFU0DPZasjK1wDk7ORsU1e+GYWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=eT42PMb7NLIYUy+TPfhbrtIZmR9In4PQ32hCJ1qwQcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9FfP7Qyyhf8H1hZZ8pt1WEV/4FLQ32/mCFdHHjQs3WhAFlAGtI1nwCo0XKXEdKeUI7nYrX01Uyfz8CBmzOQA7sKw/OTecatCWVcUd4utSDqT0aPA0hpKLT7pk7pDkHEs1oLhmIcOhUZtLuNH/AkgWcIfx70Ddpe9GWTNC3fy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN+i1Vkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A197DC4CEEC;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=eT42PMb7NLIYUy+TPfhbrtIZmR9In4PQ32hCJ1qwQcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EN+i1Vkqf8dNxWk55wQuKMixRCxBwXjO1eYvgWzToAqoFqaWa9a/MhWCnRgpgl+JR
	 rNYTQwyDhJgQvI4Z1I8yRw234yiw8unXvy/Y4peeOheNBXsVedjT4inn4mk0HrHsRM
	 uFUclJK8LQLbfUS8XNCoqmcfKDTGY5wrovx6rB2QZl1++VVJArzei2EA3PQ+2uNVyd
	 yVOVDTpOFa4B0wzF+8vsKagc/XRCb/yznKmt/NnhRcL0AsQSFfCaLKlRTnZ/o4lRwX
	 FpGiqHDXmUjYYCFzXpvqy6kQomh4OcycYhFtraZp8nPfdHV63kkSt/lPLZ2GyygKXs
	 8AxsLi9/QN5zQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5r-3J3e;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/39] scripts/lib/kdoc/kdoc_files.py: allow filtering output per fname
Date: Mon, 24 Feb 2025 10:08:43 +0100
Message-ID: <89c8d2f9f3afc56cde2132bc073cbc71b5ad64c1.1740387599.git.mchehab+huawei@kernel.org>
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

For kerneldoc Sphinx extension, it is useful to display
parsed results only from a single file. Change the logic at
KernelFiles.msg() to allow such usage.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index fc14bd6f9863..8935a8603b44 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -94,7 +94,7 @@ class KernelFiles():
         doc = KernelDoc(self.config, fname)
         doc.run()
 
-        return doc
+        return doc.entries
 
     def process_export_file(self, fname):
         """
@@ -172,7 +172,7 @@ class KernelFiles():
         # Initialize internal variables
 
         self.config.errors = 0
-        self.results = []
+        self.results = {}
 
         self.files = set()
         self.export_files = set()
@@ -188,13 +188,9 @@ class KernelFiles():
         # avoid reporting errors multiple times
 
         for fname in glob.parse_files(file_list, self.file_not_found_cb):
-            if fname in self.files:
-                continue
-
-            res = self.parse_file(fname)
-
-            self.results.append((res.fname, res.entries))
-            self.files.add(fname)
+            if fname not in self.files:
+                self.results[fname] = self.parse_file(fname)
+                self.files.add(fname)
 
         # If a list of export files was provided, parse EXPORT_SYMBOL*
         # from files that weren't fully parsed
@@ -225,7 +221,8 @@ class KernelFiles():
         return self.out_style.msg(fname, name, arg)
 
     def msg(self, enable_lineno=False, export=False, internal=False,
-            symbol=None, nosymbol=None, no_doc_sections=False):
+            symbol=None, nosymbol=None, no_doc_sections=False,
+            filenames=None):
         """
         Interacts over the kernel-doc results and output messages,
         returning kernel-doc markups on each interaction
@@ -247,9 +244,12 @@ class KernelFiles():
                                   function_table, enable_lineno,
                                   no_doc_sections)
 
-        for fname, arg_tuple in self.results:
+        if not filenames:
+            filenames = sorted(self.results.keys())
+
+        for fname in filenames:
             msg = ""
-            for name, arg in arg_tuple:
+            for name, arg in self.results[fname]:
                 msg += self.out_msg(fname, name, arg)
 
                 if msg is None:
-- 
2.48.1


