Return-Path: <linux-kernel+bounces-521100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6925A3B43A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CE176874
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEF41DF25E;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLuEhCTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490F1D47A2;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=nacHvk1YJGbFtiR42hKxAxbA61m2QPaHMs6CqEMfhZCeMjjc9RT5YpEfUOEd020+2dRJl2XF7v1R35UwhNhYj0ZC8DoMHa55u65CYMwCpB0TXDPwbuwhqj3WD5Qlk6YHx2OVlGDFltwlEkS+YCv2fi5xOjykoTP1D7Kj4b7ohEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=lpGcciKaov3Y13LlsgFK4uZcLIWPLc8PIxEf/5bFm3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g59qH3jLSGKqJJvU7KJfQkvukIihlaQtTVHiw3FlG0POhMnGvnSZPQ9xDtIuIKhMWVw6j5xcZ+L0rK/WAV0DnSzJiK+XAHL35I0LHPZ8kG8BOl9NOZz3MdW8e/0+r3dAm1z4dybChoeg5TOLOtsFxK9es+0FWToe7TrT0f4x14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLuEhCTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B566C4AF09;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=lpGcciKaov3Y13LlsgFK4uZcLIWPLc8PIxEf/5bFm3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLuEhCTUybix+m2Y9LwAyWRufBCiM+8Y1cLOCgDRRY8P6AWTCxJG3LSZVjVscaP/u
	 w9krR0tO/34P332mfixPuCHGzzzeSTnzpb3eUt5FmOrocIuWxr6aV4EoPe3jxBKqxR
	 PKk2/lJpUjFhRf1Y8Qrwzl7wtBiZ1fETzj3g0f/HqZ4+0JGs+PKzjXrhk/7FI68nOB
	 /wm/1votpgBXitPuT6s5yqK4/XK0FKSFjVtODTnFoPwfEKtoh9hYHvGrRfqKXgce5A
	 HwNElk2v/o0FMvmUxSoi9+tfMc8BqmgI8BefFEXnoWz1Lap+/L7jADSj5N3zTOT1yb
	 gMmDlvaJnJCBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4v-0oY1;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/27] scripts/kernel-doc.py: output warnings the same way as kerneldoc
Date: Wed, 19 Feb 2025 09:32:26 +0100
Message-ID: <5152600de87339a70576f952cba67a84131003c0.1739952783.git.mchehab+huawei@kernel.org>
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


