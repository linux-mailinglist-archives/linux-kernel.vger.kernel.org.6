Return-Path: <linux-kernel+bounces-528516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E7A41880
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6C91896DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29942580F2;
	Mon, 24 Feb 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4muGANG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34224A07C;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=CZX60vt8pBFZfSvCwenp+J/mw5nuLwftHTRu76Zvm+m9DxK+TBUV8pSZ+Q6qMWVqnJ2R6Tr8XD9FeWZqL1yQHI06ebBhT3ZUS9+W+KbLdDq741dkoXOFbJVX9hruJ2c/bjsOvI1rV9gIT/tkCivtMyAUQLltJ0bb4Y5YeRtitoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=cgbg7nED/bJ/uBnZ2iDb/1x2SRXvvmDXvNCZuMR+Pis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F73Y15F1RdyIB6l6+Xtd03g+BHLatsqRDTOTHyBghsMN5gLp08mLQa0vAyrrTCA8WgiHdagL7mlL/Lq77rFo2FpspkcJS9OlaDEZ01c7P/XnT1s/8WEgjzH0YBDh+yaFo5T76p0eAqx94QpiePpNsxoN79dlsSe5jzBeNVtEETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4muGANG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767B6C4CEE8;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=cgbg7nED/bJ/uBnZ2iDb/1x2SRXvvmDXvNCZuMR+Pis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4muGANGC+6eAxs7YsqmhiQm/1Fdsp31mLBuKUKpr0iPfmw5ADIM/bHMBYPUyIaza
	 lkqplnqjVgih4Bq0YsZSEn9UTBEkRyLnR+ZDd/VtTpfE9pdt/PP0BN0ULYPfkodDVZ
	 pW3xb4u2vF1vqqbm4CzTMIg5oUglwTr9+CNKoejDqyu8Na4kZApCgqROgGRMYCbxTW
	 e3B+JsBGmv6FwaDKHvQvpqhoXNQoTcKLJiG85VXHxj4GrCb2yESe8AUBuA3bjGGjDY
	 tog2yhGv03C3FTlkb2upjK3bMr/9ASsQFT6lw0MyLqhVmr8sMeCebYYHavhOtsix8y
	 vjSAlQ7n24JDA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5N-2Ws9;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/39] scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
Date: Mon, 24 Feb 2025 10:08:36 +0100
Message-ID: <bda421e6fc54e8d863b681912907b1f4a15b805f.1740387599.git.mchehab+huawei@kernel.org>
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

- str.replace count was introduced only in Python 3.13;
- before Python 3.13, f-string dict arguments can't use the same
  delimiter of the main string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 8 ++++----
 scripts/lib/kdoc/kdoc_parser.py | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 97ec671e0b6e..df3c15bb1c10 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -645,16 +645,16 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        self.data += f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+        self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"{args['function']} \\- {args['purpose']}\n"
 
         self.data += ".SH SYNOPSIS\n"
         if args.get('functiontype', ''):
-            self.data += f'.B "{args['functiontype']}" {args['function']}' + "\n"
+            self.data += f'.B "{args["functiontype"]}" {args["function"]}' + "\n"
         else:
-            self.data += f'.B "{args['function']}' + "\n"
+            self.data += f'.B "{args["function"]}' + "\n"
 
         count = 0
         parenth = "("
@@ -695,7 +695,7 @@ class ManFormat(OutputFormat):
         sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
-        self.data += f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{args["module"]}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"enum {args['enum']} \\- {args['purpose']}\n"
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index a71145d531f2..51ac2d69a587 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1455,9 +1455,9 @@ class KernelDoc:
 
         r = Re(r'long\s+(sys_.*?),')
         if r.search(proto):
-            proto = proto.replace(',', '(', count=1)
+            proto = Re(',').sub('(', proto, count=1)
         elif is_void:
-            proto = proto.replace(')', '(void)', count=1)
+            proto = Re(r'\)').sub('(void)', proto, count=1)
 
         # Now delete all of the odd-numbered commas in the proto
         # so that argument types & names don't have a comma between them
-- 
2.48.1


