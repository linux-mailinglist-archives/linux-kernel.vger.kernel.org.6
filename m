Return-Path: <linux-kernel+bounces-360472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826EA999B83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D74285818
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC0322E;
	Fri, 11 Oct 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Av0JZc5u"
Received: from out187-22.us.a.mail.aliyun.com (out187-22.us.a.mail.aliyun.com [47.90.187.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414B1F9401
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619825; cv=none; b=tAFoFXIcc8JIkoh7gKQ415Jt6yXQeNpT2fyPLmm0PUVc5NHHNdHPhCWgayhEeXvxUQj2QDv1dmzDJxY5FgX78Irsb5IISZ7MGKFhQSWe4CqIb7qxoOROn1XeRCq+F1QsSybp65wkXSCiMJR0THFFgyBI5sPTzMrTYmHoQi2zN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619825; c=relaxed/simple;
	bh=H4AbiP3Ka6rFdbupztUl5i9FuHWB54gnrajmy+wHWew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oiU+X6w6BtCzG+xueKJCikhpYKzRfxvbvwVioFNESzdF5g7XYKyLOSt35dxDfqvZiyxAgD1KpugDGteOCW1NUpaVqaDI+Lo6X7ozf55mCwNapqJqCIBftkasL6sxf8ko3GbYO6AkkoDsusLM6uV0IUQnaP33dV3O4FnLdE3dDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Av0JZc5u; arc=none smtp.client-ip=47.90.187.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728619811; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WZ7paHUzaVY/odtQMce80h9D0+PTfQEqps5tmCXYmKg=;
	b=Av0JZc5u/E8i7ImYDeg/GN8+VHG9ptWvg821Fj58+uua4ewCWbv8Gb/TwQ6tXKR2k4gqvrdLyfyeKI+p6HpuViOSjRL+GDsPuXkZqnWjTkplq16VQKyXZtrMyzkcwbpkn58xKu3hbRnJrjKdKMOvIV4laf8QbsL+qowdIW73aSU=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ze33tvP_1728619490)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 12:04:54 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/9] um: Remove UML specific debug parameter
Date: Fri, 11 Oct 2024 12:04:33 +0800
Message-Id: <20241011040441.1586345-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
References: <20241011040441.1586345-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It does nothing but emit a warning when 'debug' is provided in the
kernel command line. It can be a bit annoying, as 'debug' is also a
valid kernel parameter to enable kernel debugging.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 38cbb41a64bc..6d755a37d5c4 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -167,19 +167,6 @@ __uml_setup("root=", uml_root_setup,
 "        root=/dev/ubd5\n\n"
 );
 
-static int __init no_skas_debug_setup(char *line, int *add)
-{
-	os_warn("'debug' is not necessary to gdb UML in skas mode - run\n");
-	os_warn("'gdb linux'\n");
-
-	return 0;
-}
-
-__uml_setup("debug", no_skas_debug_setup,
-"debug\n"
-"    this flag is not needed to run gdb on UML in skas mode\n\n"
-);
-
 static int __init uml_console_setup(char *line, int *add)
 {
 	have_console = 1;
-- 
2.34.1


