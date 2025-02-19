Return-Path: <linux-kernel+bounces-521117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AEA3B446
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E5B3B0CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE821AF0C8;
	Wed, 19 Feb 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHE4clH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AA1DE3A7;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953973; cv=none; b=ZlP40/fKUd2RSQ2g+NqXK0tMeIXnoX8vvHBYB9KuBfmFP+M+4uIB1HiNC1+CDfxSNNaqgISDzR+jBbdCpmcLJRp87ETiw7x/z66XsaGZHdm1FMapdshRcrH36sU8V33bimCvIEL8wu18s7v1HV5zL+NpgdyyUFqtO8aiBanvh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953973; c=relaxed/simple;
	bh=visFeBdmwWEXGD09mdOdO30j7sy6oK5qUh63NaeMIjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hho270Ftm3EkP4IUI7Nbobp5e+6IDlRR95/dCqi51NWaHTygyEsKbsLawpkEiavCl+gusaHWaKnIOM6sxDfEPk5cuhPE2ljpkIlvDE1rmceMDrWcJAweQxhgUaqFySw+L8EIYN4jrwIvb8Kp0nS5ckajSclY6sWK3djm9WnV844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHE4clH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A053DC2BCB4;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=visFeBdmwWEXGD09mdOdO30j7sy6oK5qUh63NaeMIjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbHE4clHSD3016HjRq0ep1cKrf+kilXVk26nNJ5USFIAnEgE/bhd6umy5uhWpunZu
	 KEKQS9Ef3sBED1doregIU8M3LmoK7SMtC2DUcKwu5kN9HJR7CJ76/Y16xuu+9+RYg3
	 DCOIosWmFIAX367boDRkj1QmFuQQIDd2jKOwdK9yaEYBWrnwbi2PHydTWSOx5dLQL/
	 lEVoWF38Fmsj6LrEklz9Y4nJShwMOO4PhgluUMWMBQA3mHVAIMg3njOQ+5TnMXO2Js
	 +PNVQCgXNlVEqv9Jw3GzvmLIHjJGR95wyjcJQFxJe7gjty6c2Z+/i5OQOfNFSQfNnX
	 p8Nmo6RJho+RQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv5t-2WX3;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 25/27] docs: sphinx: kerneldoc: verbose kernel-doc command if V=1
Date: Wed, 19 Feb 2025 09:32:41 +0100
Message-ID: <6d7af20038b540c30d53e2b214f1985b57a4e26f.1739952783.git.mchehab+huawei@kernel.org>
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


