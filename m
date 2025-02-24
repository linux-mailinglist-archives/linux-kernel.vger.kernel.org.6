Return-Path: <linux-kernel+bounces-528519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E6A4188A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364B83ADCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E92586C2;
	Mon, 24 Feb 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSJPSms3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBA24BBE9;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=i9x4wqtlF0tO+0q+FGZSeRgTKB4rGQyTi/q3IOef3OOhXjsNi4yipTLn0jsfAhidKOH45bEDQEknvLzGONZE4DETBcdTFhmRebnpFvVzXv1To5MxBXmbMFEb1u3yPlXtcukKqTYDaGfugOXBHrlk0+xidWz7sBT5YxmmfZJcrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=7R366oYKmHOPpm8w8SRMstX38EO00rzyOjDKwrc/HvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nklvPXcZqQLZp5WmF6cRgmlGwwH5Exb9u3hDMD6VgUN6cgBNrMqKMtbpZwmaMHLNI0rvP1qk8tdd6ykksZYgAsjFpGlBWTpM3HVkMiSvVFPBeCRibbV2U/qZUvGddel91QvOV2jKizShVjgSbZRkBzyy6ElXT5ZILW4t1nnmX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSJPSms3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E09C2BCB9;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=7R366oYKmHOPpm8w8SRMstX38EO00rzyOjDKwrc/HvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSJPSms3Ep2i557KE8/hclS9V7fRG56iKieWL8elcnDGR0cY/XiNgbtKbefz4PcKG
	 l48Rz4GU3chECWP/oFb2TBpF7RU3zAv6fQ70G3x6iXFb2r81GwGkuO48d6sEEQxfhK
	 95HI2cigsEcFUnyhhxwsIQJ8PILP/gs6FMj7xzVflyBtYaFPRan7+iCA5FaV3wUjR3
	 FQy2MuampgGzkf1XXSyYlyx+kbZxhnTEdWMxukoxWgFno72a2FdPwI8vtdvDjr0jV5
	 wFS5DRfvplT+VgUCvXRiJ6hV5+qjYjVlUIi65WKCujzV4vI8HBQGbECCz3JN+iG5mI
	 y/tKhj08I95zg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5W-2kh5;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/39] scripts/kernel-doc.py: properly handle KBUILD_BUILD_TIMESTAMP
Date: Mon, 24 Feb 2025 10:08:38 +0100
Message-ID: <8a8b63cfbb14a98d8bd1790d502b73162079789e.1740387599.git.mchehab+huawei@kernel.org>
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


