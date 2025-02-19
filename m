Return-Path: <linux-kernel+bounces-521695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A867AA3C113
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384D9168FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF71EDA15;
	Wed, 19 Feb 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukUbGMKm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA01DEFE1;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973479; cv=none; b=E7bJrqUNI0BUq9dN42jhRMmK/ce1MbYPq6cpSlSJ2i/Pb1IUribqCnBxkqgV4PDPEMcVAoBSoRs/ZfZw6QR/LRY35uZrmlu7boHFGSK18ablPVd4rvwBANkcGtKENjdoqbcpl3V5GShDW8JLezJgT+977mwatCbCZl2wXDAo0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973479; c=relaxed/simple;
	bh=cgbg7nED/bJ/uBnZ2iDb/1x2SRXvvmDXvNCZuMR+Pis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7S6EEN16/GnGFvVwiqx98xLGkIm1cyCw4e5z6Xb/aBRT9IlAYtgRrsqMFUd38mXGN+q4lOg37/5PVQnB6ZkJwedaT1F45QKftcmvW2rkegeBIR7eA5U24sm4ickuhuSD5aumY0ERRWH2MlGlCtaKHhhJC31Pa1cPX4z0eXZAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukUbGMKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FFEC4CEE7;
	Wed, 19 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973479;
	bh=cgbg7nED/bJ/uBnZ2iDb/1x2SRXvvmDXvNCZuMR+Pis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukUbGMKmoQcbgWLlfZhrWNaW54CJCQmzdWBqPVrzk07C0RCcVxU6OXm4/FkE4sw5S
	 8mS+Xsf/tLj+0HiBp8lGd8jQZRRZuzunpefYNgXo7jb50CEZ8oLO2ZpYVxMbGXU6RK
	 6iPZ3vd/U3Km3UOOhq2hMa+cyNU5mveXSIypcXAHC+iEd+YODc30kvFFyGQkbRCRbn
	 ZCYgjgxdgrH380UDwuMt16VkLJVypLM2vQ+/4OSMY6B+hQgooHX6/UcjqGPNIwrCY7
	 AVgQxA9gHQa3pbny3mvw29aBdzbO+Rot17rVu/EADvjI9b3wW+pOPcT4pRcYGXjZ3X
	 lbEgbHvo891tQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkkaL-0000000H1jN-0njG;
	Wed, 19 Feb 2025 14:57:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] scripts/lib/kdoc/kdoc_parser.py: fix Python compat with < v3.13
Date: Wed, 19 Feb 2025 14:57:38 +0100
Message-ID: <34593958dab76d805b388bda8d10737cfecb7845.1739972906.git.mchehab+huawei@kernel.org>
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


