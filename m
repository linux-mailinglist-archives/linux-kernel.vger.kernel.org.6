Return-Path: <linux-kernel+bounces-528507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E189CA4187B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6CD17131D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B58257AC2;
	Mon, 24 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYNoedzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961624A059;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=MYtJQunr1t7dEeIepsG21znRQLbo7T98Fu3E0vX6snpyXcy0lzKb9Py9Hnz9vz6gfzxIPRpJpk8QsFnrlIp3c4tnJOJ6xxGeOJ6YQDdUKtqbbhz7mScqShSxy4MpsBefAXJ1avIxSU89wo57Wc8RYyjunKbVwmio4DsvLFUufPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=visFeBdmwWEXGD09mdOdO30j7sy6oK5qUh63NaeMIjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXVVLS40twCGnjFj1qYnSQam2AiT7OxHO4gUNp7CFksnw+jjSLkoUyRBTPZ/Yw5qfhhF3IXashddFRzRg612XvOBTOHgYYJP28Gbm5ga26NHEzCg8doa+D4PIVWcN00QsZnQiIM3+re0kpxI9Yq/aj9H5lmzHihtB+1mVNQPrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYNoedzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAF1C4CEF0;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=visFeBdmwWEXGD09mdOdO30j7sy6oK5qUh63NaeMIjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYNoedzrk4yrV8BKWtMh6MleKLHnYVN+RvNQjy643BNEae3Jxrr6d6ScSfdmtY/oR
	 Lp6qEOtUAI9Hi87Ms0G4YI8Tn9K82cUaQv1T1GzZoUC641o31tT1A7FQ+rR6lil4na
	 BQ8CQdC8QzF9YshTHKm4ocSLfDgoPzJ1ina35cn8a6xa2qqHBlLWi1dlpOSGtwHpuW
	 02AnxSFYndaazymwY5Jjn3XJEB/NNhUY+II5bi0PsIc/hMfh95gaUxWpE8aLzh2UFO
	 iEK9sa3aFx783TXoczEHSr+fl6Kla2K3/E/AqiE4NDfU3zXDr9IRrJkV9kSBAlM1RH
	 M9/QTfHeSCHKg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p52-1yTx;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/39] docs: sphinx: kerneldoc: verbose kernel-doc command if V=1
Date: Mon, 24 Feb 2025 10:08:31 +0100
Message-ID: <299b7351d1f395031c79521cf3503e47baa1d4a1.1740387599.git.mchehab+huawei@kernel.org>
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

It is useful to know what kernel-doc command was used during
document build time, as it allows one to check the output the same
way as Sphinx extension does.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 39ddae6ae7dd..d206eb2be10a 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -43,6 +43,29 @@ from sphinx.util import logging
 
 __version__  = '1.0'
 
+def cmd_str(cmd):
+    """
+    Helper function to output a command line that can be used to produce
+    the same records via command line. Helpful to debug troubles at the
+    script.
+    """
+
+    cmd_line = ""
+
+    for w in cmd:
+        if w == "" or " " in w:
+            esc_cmd = "'" + w + "'"
+        else:
+            esc_cmd = w
+
+        if cmd_line:
+            cmd_line += " " + esc_cmd
+            continue
+        else:
+            cmd_line = esc_cmd
+
+    return cmd_line
+
 class KernelDocDirective(Directive):
     """Extract kernel-doc comments from the specified file"""
     required_argument = 1
@@ -57,6 +80,7 @@ class KernelDocDirective(Directive):
     }
     has_content = False
     logger = logging.getLogger('kerneldoc')
+    verbose = 0
 
     def run(self):
         env = self.state.document.settings.env
@@ -65,6 +89,13 @@ class KernelDocDirective(Directive):
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
         export_file_patterns = []
 
+        verbose = os.environ.get("V")
+        if verbose:
+            try:
+                self.verbose = int(verbose)
+            except ValueError:
+                pass
+
         # Tell sphinx of the dependency
         env.note_dependency(os.path.abspath(filename))
 
@@ -104,6 +135,9 @@ class KernelDocDirective(Directive):
 
         cmd += [filename]
 
+        if self.verbose >= 1:
+            print(cmd_str(cmd))
+
         try:
             self.logger.verbose("calling kernel-doc '%s'" % (" ".join(cmd)))
 
-- 
2.48.1


