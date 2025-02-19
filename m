Return-Path: <linux-kernel+bounces-521698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9667A3C135
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E953AE25E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406E1EFF87;
	Wed, 19 Feb 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6P5eAMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DB1DED63;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973480; cv=none; b=Ue4DGvjsYM5owbl+G5WpaDs6LzboL8iLwgS/nHDNy3L9HBbueYPGHoaV5ciENlF3ArmCZzblVWW4jWlAzh/58YoOOMBOXoy+/OpHFBXRsaO4FqTq6YlI96//EQYhlks2Ne1Aj0cpplG1vBNYLZAClBy7RpjX3H6YIG3ipIOL4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973480; c=relaxed/simple;
	bh=7R366oYKmHOPpm8w8SRMstX38EO00rzyOjDKwrc/HvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCLHFxorVDkVxxrCFgZjzqJGpYYdWEHkxBxoQFucbdHktncPMkjAZZPNdS4ceRVDBmFS/xVjlm6IT8abMYvsrqs6wzyrahKgZtTXALA5Nnkrtm+2Gkeg9e9JHAPFdZUEg8vg01jlYpQ8AxytvG3hOtgTkJH7l8Aee9L1rDNd9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6P5eAMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB3C4CED6;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=7R366oYKmHOPpm8w8SRMstX38EO00rzyOjDKwrc/HvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6P5eAMgEhntbiTEVUOj/hhs4F3GyrUMl49CX5ax4h1XPzEwNoCTKvymaKMt+NSX2
	 Gzf9N5LIuHTomtvVCIRppzNkDgPsLGGiyft4HWrNbhsFTnjj+LiNCxxueAJBZuroqJ
	 gWv2Tx3hLGFq5VhzFsVXdAGLKGiM3tUw0wS/mRGi00NjJ+MnJR3I6atPOZBwsuxiNH
	 yei3iN/meR49MHNSF1Vj6DgUZqP7iUFcQJOsdhIxJNPpRS/kuUigetHmnh6likUC3M
	 9xJ9A44QJybbXG+xQdLfziwNBCxI0fBxXDL7CWW8LDW5ZSZjcbMHu91SzyQcyiwwrx
	 8zVW0WUeMVCLg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jV-11aI;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
Date: Wed, 19 Feb 2025 14:57:40 +0100
Message-ID: <35d0f26f8ab2845245b3c3b7817c1e3ab883f069.1739972906.git.mchehab+huawei@kernel.org>
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

The logic that handles KBUILD_BUILD_TIMESTAMP is wrong, and adds
a dependency of a third party module (dateutil).

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py  |  9 ---------
 scripts/lib/kdoc/kdoc_output.py | 28 +++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index a2417cafb1c8..19fe9c6f5352 100755
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -12,9 +12,6 @@ import logging
 import os
 import re
 import sys
-from datetime import datetime
-
-from dateutil import tz
 
 from kdoc_parser import KernelDoc
 from kdoc_output import OutputFormat
@@ -136,12 +133,6 @@ class KernelFiles():
         if out_style is None:
             out_style = OutputFormat()
 
-        dt = datetime.now()
-        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
-            # use UTC TZ
-            to_zone = tz.gettz('UTC')
-            dt = dt.astimezone(to_zone)
-
         if not werror:
             kcflags = os.environ.get("KCFLAGS", None)
             if kcflags:
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 13a74a687f89..166fcabbb4cf 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -18,8 +18,6 @@ import os
 import re
 from datetime import datetime
 
-from dateutil import tz
-
 from kdoc_parser import KernelDoc, type_param
 from kdoc_re import Re
 
@@ -584,6 +582,15 @@ class ManFormat(OutputFormat):
     )
     blankline = ""
 
+    date_formats = [
+        "%a %b %d %H:%M:%S %Z %Y",
+        "%a %b %d %H:%M:%S %Y",
+        "%Y-%m-%d",
+        "%b %d %Y",
+        "%B %d %Y",
+        "%m %d %Y",
+    ]
+
     def __init__(self, modulename):
         """
         Creates class variables.
@@ -595,11 +602,18 @@ class ManFormat(OutputFormat):
         super().__init__()
         self.modulename = modulename
 
-        dt = datetime.now()
-        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
-            # use UTC TZ
-            to_zone = tz.gettz('UTC')
-            dt = dt.astimezone(to_zone)
+        dt = None
+        tstamp = os.environ.get("KBUILD_BUILD_TIMESTAMP")
+        if tstamp:
+            for fmt in self.date_formats:
+                try:
+                    dt = datetime.strptime(tstamp, fmt)
+                    break
+                except ValueError:
+                    pass
+
+        if not dt:
+            dt = datetime.now()
 
         self.man_date = dt.strftime("%B %Y")
 
-- 
2.48.1


