Return-Path: <linux-kernel+bounces-521102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCBA3B42B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A17A367E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E411DF260;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pocYnLOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832921D6DB1;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=DlfPWahJZLtgapmj4NTWkSKS1y5djnfrVcehUYDhqIsFanqQo2s8sI+stwXYuIH2cEMTsJyx11jdIWWFhQFVt9jTcT4Al26a/xMwQaYkMNH5+6cJewpEL7hVcwSNCSIA7scujU8TuTt8g9VNkpPopHMlWgYJatBX1tSpf0emsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=g3yjKUYPJng0/MFnsVcxoDKnYWevbS21H1bMLGz3lcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrepDbew+aI4sL8WRc8YJ6vTWOymavLI397x38AeB/biG93VWLJa3mzttl76q7IorIDUHa/CQBvgSSJAOOd+j99ELJ5fZBITdhknfb2gl3NYNZmAT7RHEl7NNC9zwWgywgAF7wSnD2Wx1tgj9qG24uWRz0TG2zWzoWqNR8+3FT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pocYnLOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351A9C4CEFC;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=g3yjKUYPJng0/MFnsVcxoDKnYWevbS21H1bMLGz3lcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pocYnLOhrSNnAbRY//C4qPP93xioq+v0SfxjfF/Ra+E+vYPx6tReflGH46n1XO14Z
	 qtPFMfhiA9fdtfwZ99X0nlaCPM11queFP5k67f2SeGRA5QDU+WD7fKH3FlGQwYLXJf
	 PbNyTeJZzzBTPN8KocKUh1M2sdIzN0cbRBUD7179O5neDdxew26ysYSkVhYb1ngz97
	 x8fCqdNDi3bmavaXoTO2viLGAVo1E2fghEGPrKWZ9a5vMwLIh3gMEnEYxmz0QEbmt8
	 KTr1ScQdthVgSJf26FiCUDmYwQNwH2CsKXf7VPlFSacHijCHCa9i2vYkeTMViKM7KC
	 u41zIorP7f9+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4z-0vWf;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/27] scripts/kernel-doc.py: better handle empty sections
Date: Wed, 19 Feb 2025 09:32:27 +0100
Message-ID: <2de0e2ced74c8d57810b83c5efc9e8e1555f0a63.1739952783.git.mchehab+huawei@kernel.org>
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

While doing the conversion, we opted to skip empty sections
(description, return), but this makes harder to see the differences
between kernel-doc (Perl) and kernel-doc.py.

Also, the logic doesn't always work properly. So, change the
way this is done by adding an extra step to remove such
sections, doing it only for Return and Description.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 8bc0470d3720..886256e87692 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -242,6 +242,19 @@ class KernelDoc:
         name = self.entry.section
         contents = self.entry.contents
 
+        # TODO: we can prevent dumping empty sections here with:
+        #
+        #    if self.entry.contents.strip("\n"):
+        #       if start_new:
+        #           self.entry.section = self.section_default
+        #           self.entry.contents = ""
+        #
+        #        return
+        #
+        # But, as we want to be producing the same output of the
+        # venerable kernel-doc Perl tool, let's just output everything,
+        # at least for now
+
         if type_param.match(name):
             name = type_param.group(1)
 
@@ -298,6 +311,19 @@ class KernelDoc:
 
         args["type"] = dtype
 
+        # TODO: use colletions.OrderedDict
+
+        sections = args.get('sections', {})
+        sectionlist = args.get('sectionlist', [])
+
+        # Drop empty sections
+        # TODO: improve it to emit warnings
+        for section in [ "Description", "Return" ]:
+            if section in sectionlist:
+                if not sections[section].rstrip():
+                    del sections[section]
+                    sectionlist.remove(section)
+
         self.entries.append((name, args))
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
@@ -401,7 +427,7 @@ class KernelDoc:
         # to ignore "[blah" in a parameter string.
 
         self.entry.parameterlist.append(param)
-        org_arg = Re(r'\s\s+').sub(' ', org_arg, count=1)
+        org_arg = Re(r'\s\s+').sub(' ', org_arg)
         self.entry.parametertypes[param] = org_arg
 
     def save_struct_actual(self, actual):
@@ -1309,8 +1335,7 @@ class KernelDoc:
             return
 
         if doc_end.search(line):
-            if self.entry.contents.strip("\n"):
-                self.dump_section()
+            self.dump_section()
 
             # Look for doc_com + <text> + doc_end:
             r = Re(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
-- 
2.48.1


