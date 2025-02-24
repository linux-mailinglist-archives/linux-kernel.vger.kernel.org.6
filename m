Return-Path: <linux-kernel+bounces-528526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE028A41894
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6491899CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1525C6F4;
	Mon, 24 Feb 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRI2W4iy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C224BC17;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=ph785kG3PWY65bUIjDlAbYalv7QP1MlRUZt7pwGN0RwrUoQZ5mQWatduwUvATAL6ac7Xu+QxZTjC+RmAViqG6I99O5l3RJApvjAqaq5jHS/jtl7ZihDHfd6/ncnQVZ1uCp0sAjaGdQAHhhSlRO9AIR1l7GHDOAuOxf6LKCECtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=Y6ml/YtNkV6raER5boYfRIgmGo0cwmvZzsMQsLjY99A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFarKa0qMePx+B2vq8P0A6hG8A6hvPFagDUkldkg5bDlvGSuPLhY1l+QLCNjj2iCbr+8vR1s49f7fENhXZQp+ZxO6ZjxYrEewxEQdNsxrntdriZSK1nU0TaZTDfbJSoykTfjQANjNagXvlU/iQpAQfp8FERHbjNkt9i6akPX6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRI2W4iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA46C4AF0C;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=Y6ml/YtNkV6raER5boYfRIgmGo0cwmvZzsMQsLjY99A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRI2W4iyC77qHKENraoY4/pLd7Q9/QvbbVA4ErJmAKlMhfhIUCqqBrjsDQk0sBlNL
	 3lzzKVZG2gAEHieMbf7Rrn9qMypfEQJtATqb0cS1WIoWfhjWxD3QksLDiy8oHKNm2Y
	 FLwPM6evbsR0l07retZRhVUZmYTjgA7E1XIDxvPpo2KJXhrW84oYLbpFbgMSYOgrk0
	 3MUqHx8FCS705oW5esuCdyDFMn1ywFx8vZrbS7wsxObIbdt7WI2B9peeFD+ErZiChG
	 Dmp+H2C+m2DqjXFu0KCQ/2I7RB+prpmoDvjg8E7vrdCcMZK4AzrHcnGi7cp7IYKQMN
	 Yg30Dr0uKIjGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5z-3XLo;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/39] docs: sphinx: kerneldoc: Use python class if available
Date: Mon, 24 Feb 2025 10:08:45 +0100
Message-ID: <db15ed19cdfc6b2b57e9957ea78d62fde66944c0.1740387599.git.mchehab+huawei@kernel.org>
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

Better integrate with the new kernel-doc tool by calling the
Python classes directly if KERNELDOC=scripts/kernel-doc.py.

This way, warnings won't be duplicated anymore, as files
will be parsed only once.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kerneldoc.py | 137 +++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 12 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 344789ed9ea2..0758d49ee07c 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -41,7 +41,15 @@ import sphinx
 from sphinx.util.docutils import switch_source_input
 from sphinx.util import logging
 
+srctree = os.path.abspath(os.environ["srctree"])
+sys.path.insert(0, os.path.join(srctree, "scripts/lib/kdoc"))
+
+from kdoc_files import KernelFiles
+from kdoc_output import RestFormat
+
 __version__  = '1.0'
+kfiles = None
+logger = logging.getLogger('kerneldoc')
 
 def cmd_str(cmd):
     """
@@ -79,14 +87,30 @@ class KernelDocDirective(Directive):
         'functions': directives.unchanged,
     }
     has_content = False
-    logger = logging.getLogger('kerneldoc')
     verbose = 0
 
-    def run(self):
+    parse_args = {}
+    msg_args = {}
+
+    def handle_args(self):
+
         env = self.state.document.settings.env
         cmd = [env.config.kerneldoc_bin, '-rst', '-enable-lineno']
 
         filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
+
+        # Arguments used by KernelFiles.parse() function
+        self.parse_args["file_list"] = [filename]
+        self.parse_args["export_file"] = []
+
+        # Arguments used by KernelFiles.msg() function
+        self.msg_args["enable_lineno"] = True
+        self.msg_args["export"] = False
+        self.msg_args["internal"] = False
+        self.msg_args["symbol"] = []
+        self.msg_args["nosymbol"] = []
+        self.msg_args["no_doc_sections"] = False
+
         export_file_patterns = []
 
         verbose = os.environ.get("V")
@@ -99,7 +123,8 @@ class KernelDocDirective(Directive):
         # Tell sphinx of the dependency
         env.note_dependency(os.path.abspath(filename))
 
-        tab_width = self.options.get('tab-width', self.state.document.settings.tab_width)
+        self.tab_width = self.options.get('tab-width',
+                                          self.state.document.settings.tab_width)
 
         # 'function' is an alias of 'identifiers'
         if 'functions' in self.options:
@@ -109,11 +134,15 @@ class KernelDocDirective(Directive):
         if 'export' in self.options:
             cmd += ['-export']
             export_file_patterns = str(self.options.get('export')).split()
+            self.msg_args["export"] = True
         elif 'internal' in self.options:
             cmd += ['-internal']
+            self.msg_args["internal"] = True
             export_file_patterns = str(self.options.get('internal')).split()
         elif 'doc' in self.options:
-            cmd += ['-function', str(self.options.get('doc'))]
+            i = str(self.options.get('doc'))
+            cmd += ['-function', i]
+            self.msg_args["symbol"].append(i)
         elif 'identifiers' in self.options:
             identifiers = self.options.get('identifiers').split()
             if identifiers:
@@ -123,8 +152,10 @@ class KernelDocDirective(Directive):
                         continue
 
                     cmd += ['-function', i]
+                    self.msg_args["symbol"].append(i)
             else:
                 cmd += ['-no-doc-sections']
+                self.msg_args["no_doc_sections"] = True
 
         if 'no-identifiers' in self.options:
             no_identifiers = self.options.get('no-identifiers').split()
@@ -135,6 +166,7 @@ class KernelDocDirective(Directive):
                         continue
 
                     cmd += ['-nosymbol', i]
+                    self.msg_args["nosymbol"].append(i)
 
         for pattern in export_file_patterns:
             pattern = pattern.rstrip("\\").strip()
@@ -144,14 +176,32 @@ class KernelDocDirective(Directive):
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
                 env.note_dependency(os.path.abspath(f))
                 cmd += ['-export-file', f]
+                self.parse_args["export_file"].append(f)
+
+            # As parse is cached, we need to pass the export_file again,
+            # to let the msg filter to do the right thing
+
+            self.msg_args["export_file"] = self.parse_args["export_file"]
+
 
         cmd += [filename]
 
+        return cmd
+
+    def run_cmd(self):
+        """
+        Execute an external kernel-doc command.
+        """
+        global logger
+
+        env = self.state.document.settings.env
+        cmd = self.handle_args()
+
         if self.verbose >= 1:
             print(cmd_str(cmd))
 
         try:
-            self.logger.verbose("calling kernel-doc '%s'" % (" ".join(cmd)))
+            logger.verbose("calling kernel-doc '%s'" % (" ".join(cmd)))
 
             p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
             out, err = p.communicate()
@@ -161,13 +211,34 @@ class KernelDocDirective(Directive):
             if p.returncode != 0:
                 sys.stderr.write(err)
 
-                self.logger.warning("kernel-doc '%s' failed with return code %d"
+                logger.warning("kernel-doc '%s' failed with return code %d"
                                     % (" ".join(cmd), p.returncode))
                 return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
             elif env.config.kerneldoc_verbosity > 0:
                 sys.stderr.write(err)
 
-            lines = statemachine.string2lines(out, tab_width, convert_whitespace=True)
+        except Exception as e:  # pylint: disable=W0703
+            logger.warning("kernel-doc '%s' processing failed with: %s" %
+                                (" ".join(cmd), str(e)))
+            return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
+
+        node = nodes.section()
+
+        filename = env.config.kerneldoc_srctree + '/' + self.arguments[0]
+        self.parse_msg(filename, node, out, cmd)
+        return node.children
+
+    def parse_msg(self, filename, node, out, cmd):
+        """
+        Handles a kernel-doc output for a given file
+        """
+
+        global logger
+        env = self.state.document.settings.env
+
+        try:
+            lines = statemachine.string2lines(out, self.tab_width,
+                                              convert_whitespace=True)
             result = ViewList()
 
             lineoffset = 0;
@@ -183,20 +254,60 @@ class KernelDocDirective(Directive):
                     result.append(line, doc + ": " + filename, lineoffset)
                     lineoffset += 1
 
-            node = nodes.section()
             self.do_parse(result, node)
 
-            return node.children
-
         except Exception as e:  # pylint: disable=W0703
-            self.logger.warning("kernel-doc '%s' processing failed with: %s" %
-                                (" ".join(cmd), str(e)))
+            logger.warning("kernel-doc '%s' processing failed with: %s" %
+                                (cmd_str(cmd), str(e)))
             return [nodes.error(None, nodes.paragraph(text = "kernel-doc missing"))]
 
+    def run_kdoc(self, kfiles):
+        """
+        Execute kernel-doc classes directly instead of running as a separate
+        command.
+        """
+
+        cmd = self.handle_args()
+        env = self.state.document.settings.env
+
+        node = nodes.section()
+
+        kfiles.parse(**self.parse_args)
+        filenames = self.parse_args["file_list"]
+
+        for filename, out in kfiles.msg(**self.msg_args, filenames=filenames):
+            if self.verbose >= 1:
+                print(cmd_str(cmd))
+
+            self.parse_msg(filename, node, out, cmd)
+
+        return node.children
+
+    def run(self):
+        global kfiles
+
+        if kfiles:
+            return self.run_kdoc(kfiles)
+        else:
+            return self.run_cmd()
+
     def do_parse(self, result, node):
         with switch_source_input(self.state, result):
             self.state.nested_parse(result, 0, node, match_titles=1)
 
+def setup_kfiles(app):
+    global kfiles
+
+    kerneldoc_bin = app.env.config.kerneldoc_bin
+
+    if kerneldoc_bin and kerneldoc_bin.endswith("kernel-doc.py"):
+        print("Using Python kernel-doc")
+        out_style = RestFormat()
+        kfiles = KernelFiles(out_style=out_style, logger=logger)
+    else:
+        print(f"Using {kerneldoc_bin}")
+
+
 def setup(app):
     app.add_config_value('kerneldoc_bin', None, 'env')
     app.add_config_value('kerneldoc_srctree', None, 'env')
@@ -204,6 +315,8 @@ def setup(app):
 
     app.add_directive('kernel-doc', KernelDocDirective)
 
+    app.connect('builder-inited', setup_kfiles)
+
     return dict(
         version = __version__,
         parallel_read_safe = True,
-- 
2.48.1


