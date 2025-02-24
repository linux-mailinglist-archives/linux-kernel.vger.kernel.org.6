Return-Path: <linux-kernel+bounces-528496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426AA41871
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801743B06A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299F252904;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4XWhXqB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600724503A;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=GaRdVbf5On3Uic7TNHf2xvjK0iZQHfcejZUh5h7Xt8vN1bztPDPJ9dsw7WbBBBtF/De0E0qk2BZPJ+YP/yRHrS7sM9axBv9yQ7nLimXQLHn+dusf/X1ZfOJT4XtE8HEOPPmXWJxZ0gt0VDmuY3trF7IcSf/BHbp1WM9XMRiY+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=lpGcciKaov3Y13LlsgFK4uZcLIWPLc8PIxEf/5bFm3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WifcTYk7jy6R478p9Gtg8nf1Ef/zwY8ycV5IKBKN9sItAg01GC25qSYQHN0eTVH7KfVbxTAs9Rs89wy/tCcHIlrPkFGCSfQILvIISy4ldhQOlwQ4fHnbwQwRTP5jHy0HZyaX99Td3tKbFIk4MEw66arZQWjmaeUbbxiHUS9rNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4XWhXqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC0C4CEF2;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=lpGcciKaov3Y13LlsgFK4uZcLIWPLc8PIxEf/5bFm3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4XWhXqBtMDQRmkQZKsQMsdrXlQ+NW2QUaT7k+r0EqZ5kEZ/JkHuEq1jCCKFbN6SU
	 xe1Xy+Sgdl61JrdQBliaqCk2KphAexH8x674UWQvpXIT7mwwz6t+D1P4o4RgQXnNCG
	 XjIXYxcnjBTr2kiycyR0Irq0HXiyzqqECF1mT+vMHrpru5+D+9IEsoM1SozccMP3SV
	 UvGl9g9ddwxCLbn4hkdOmIci91zxu1nsEBtj1wVSPuq6EUQY0M6FDrwH1QgUxr9nZ5
	 o53othZ0DRVaq55V9LPOk7q0ONClfaG1IUSfoWcZ5x7XMmCvTXpaA8o1/cMVXkUvGe
	 FcOOLQWoWbF1Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p44-0GIa;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/39] scripts/kernel-doc.py: output warnings the same way as kerneldoc
Date: Mon, 24 Feb 2025 10:08:16 +0100
Message-ID: <1ee48bdad5030aebe5c2442d805ac6ca922a86d1.1740387599.git.mchehab+huawei@kernel.org>
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

Add a formatter to logging to produce outputs in a similar way
to kernel-doc. This should help making it more compatible with
existing scripts.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index 5cf5ed63f215..8bc0470d3720 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -2640,6 +2640,11 @@ neither here nor at the original Perl script.
 """
 
 
+class MsgFormatter(logging.Formatter):
+    def format(self, record):
+        record.levelname = record.levelname.capitalize()
+        return logging.Formatter.format(self, record)
+
 def main():
     """Main program"""
 
@@ -2724,10 +2729,19 @@ def main():
         args.wshort_desc = True
         args.wcontents_before_sections = True
 
+    logger = logging.getLogger()
+
     if not args.debug:
-        level = logging.INFO
+        logger.setLevel(logging.INFO)
     else:
-        level = logging.DEBUG
+        logger.setLevel(logging.DEBUG)
+
+    formatter = MsgFormatter('%(levelname)s: %(message)s')
+
+    handler = logging.StreamHandler()
+    handler.setFormatter(formatter)
+
+    logger.addHandler(handler)
 
     if args.man:
         out_style = ManFormat()
@@ -2736,8 +2750,6 @@ def main():
     else:
         out_style = RestFormat()
 
-    logging.basicConfig(level=level, format="%(levelname)s: %(message)s")
-
     kfiles = KernelFiles(files=args.files, verbose=args.verbose,
                          out_style=out_style, werror=args.werror,
                          wreturn=args.wreturn, wshort_desc=args.wshort_desc,
-- 
2.48.1


