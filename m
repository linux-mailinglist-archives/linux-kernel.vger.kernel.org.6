Return-Path: <linux-kernel+bounces-528494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F3A41872
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295681743C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F92528FB;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/3bMDI1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E1245039;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=CEXG2lDYWizWXpifM9JYMo5Cc8iXYzuQaPznmsnvxFukT8SPS5SIr6nbOqpz2mdAEZgEKn8UaELg+M01D4TQtx5sBJ+NSRyv4Ni8d0q84Y5SJ+3Nm2+XWmnHkG4WtNPOB83sM/J+SwstLTJyjMk0SEAr9dsPxN6gUM+se5RR/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=g3yjKUYPJng0/MFnsVcxoDKnYWevbS21H1bMLGz3lcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fe87NIVi3pOB6xZGFWK1G0XcO6BoJCldXHnil215OywwF0A0G9HxMcET1dFg1H0wvpFYEP5ytlZWNnqZKcVo16paSwIKP+nO+GJCyPWqomtGRt60zRiXOvGPNXVCJDVzg7FMhbK4WZWuwjUfKIxgXg4NgTQcSl5/sA2i/1RdiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/3bMDI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F7AC4AF09;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=g3yjKUYPJng0/MFnsVcxoDKnYWevbS21H1bMLGz3lcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/3bMDI1lwgqp6ZprTksJ5lTicEc+aV3eqlJ0aGAk6W1wvHcUpojedbSZ1wHv/sNr
	 ZgJ7gcOqGA2fXxU0kOG8Bzy3E04ivqPv+5RkeMvGsbvkrNMPiko/ngSp6R3YRsAeSZ
	 8hWNFo6jR7INl+hSh279x9KJeALqSmq1eQMONNdkJjBPvd0iIhDmBHz6CpYA/VThfZ
	 dWKIQkKjRabYvw+avP5SQ19BEHwO30jIrpdrRRvlAgqnw59PCODNT20bJyhWPa1UFS
	 9r5HUmh6JwP5Ec2G5ey02EyDq6rHRQYs1yIR928N+/F2zpHL4nX/aLz3T9czj+vb55
	 tta8Wh8uhWkwg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p48-0NA9;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/39] scripts/kernel-doc.py: better handle empty sections
Date: Mon, 24 Feb 2025 10:08:17 +0100
Message-ID: <af68c1894255eb9cd3591fd1019577ea80652877.1740387599.git.mchehab+huawei@kernel.org>
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


