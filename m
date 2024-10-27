Return-Path: <linux-kernel+bounces-383859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60109B2104
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD8A1F21347
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B117C7C4;
	Sun, 27 Oct 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWijFkqO"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7A18EBF
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067781; cv=none; b=KwTdjqYqxq1yTW/bAB38aOB5loXb7ty880cZrsJIEVnCfp+kaCGAwA2eggFJld4KNYDPy2BdLIgE5TK07QmgK84qLCo8dI9g+NMaCPkcG43J872++N1MThOos7lFHxumLapJ6qQt3mXmScLnQSuRuzFoNyTDiA8JTMyZv4bWlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067781; c=relaxed/simple;
	bh=8UfyyG6xJDonQ5Rv58iuez+wmMcZych5O+POYTdUYqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sq9RK6Mln3D/8e/BvuCt/gKWXggsRxCMyjGBV5sy9zf1ja6TwnUmBv2Lm5WqKuTZi5vjpfLYpt4JMl6/y/dj6zLySICwm4elix/RhlB1TNMhuXWn30043c6wlZuVHZe7RgypgrNwp7rrMgQSa25KRUxQ947fd5ee1cP93vx64p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWijFkqO; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730067776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sPyEMx1Cix540CPR4LmCJqBqTR/s1Cf9zBXVuWCkKvk=;
	b=uWijFkqOZALURJnEJ7HQegQOrIjy+GesZoYx1yOWz7w+grl4V1xgKtyXecoxmxUJ9eFyHq
	A3Hc36K4eBydTZWlw2KBSzRq8lTK9diYYz3aSG7xcPGa3fvrfj1s8mVYIJOeiGZgoStUMo
	/105F4irNL20nzTkjomy+oHQAAva+0c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Rob Herring <robh@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use str_enabled_disabled() helper function
Date: Sun, 27 Oct 2024 23:22:17 +0100
Message-ID: <20241027222219.1173-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/secure_boot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 9e0efb657f39..3a28795b4ed8 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -5,6 +5,7 @@
  */
 #include <linux/types.h>
 #include <linux/of.h>
+#include <linux/string_choices.h>
 #include <asm/secure_boot.h>
 
 static struct device_node *get_ppc_fw_sb_node(void)
@@ -38,7 +39,7 @@ bool is_ppc_secureboot_enabled(void)
 	of_node_put(node);
 
 out:
-	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
+	pr_info("Secure boot mode %s\n", str_enabled_disabled(enabled));
 
 	return enabled;
 }
@@ -62,7 +63,7 @@ bool is_ppc_trustedboot_enabled(void)
 	of_node_put(node);
 
 out:
-	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
+	pr_info("Trusted boot mode %s\n", str_enabled_disabled(enabled));
 
 	return enabled;
 }
-- 
2.47.0


