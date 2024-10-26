Return-Path: <linux-kernel+bounces-383272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAE9B1950
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7275B1C20C13
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29F7346F;
	Sat, 26 Oct 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHWbps+i"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429812E4A
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957250; cv=none; b=DrxI7MB1CNWMwwZP2ElxH865FkGpT+Bi/VeyQAm0EP0Xy8/blDgY4FRrEijJyCHcutGzgTVOmT4Yglu/HPONqXLrZqu4YWdCbeT+WB6n9EfxbmXi4puZBID+5WXheJvzj6XJC4/uyZbjcs80hYAcO24oGDZZGHiRW1cybx+nck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957250; c=relaxed/simple;
	bh=GNe4ye1OQX4/Qxf85U1tzqSg08WRHucFzaUMbYTBExo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHJsvctdHKn04qCWpIZBLM89iqfzolwNzhmkQfmv3xHjJ1gmuwiFzWfMKuqT5ka2uZEWJLcH4C24q/m4TLKWQSr+ks8mGYp9qXZZFfcx+MEmp8TW6a85/w0EXsKUXYh0e6zenq3rBwbPsij7a8XpUxnmv37VBIW5pX3a3IM9CoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHWbps+i; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729957245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FUIkWdRccPpqO/GUqcg5hwSzpVQR8KrcEnsH22oLSTc=;
	b=cHWbps+ieajT1HObjNWhT2exO6iDprPy3L6G4qC5qUehnyqrPE6smFGUuY180HGnyHS0YW
	BS2CIPTiseFC6squaAIYHTqJRCQUB2KKWbHs/XCsutbVvV9oWBB/lHp5SYvA+FLb/1SKkC
	OBUv0vgHC5lYKIA/o8xuKk2l6LI2FwA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] genirq/irqdesc: Use str_enabled_disabled() helper in wakeup_show()
Date: Sat, 26 Oct 2024 17:40:29 +0200
Message-ID: <20241026154029.158977-2-thorsten.blum@linux.dev>
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
 kernel/irq/irqdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1dee88ba0ae4..a135b2ce886f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -15,6 +15,7 @@
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
+#include <linux/string_choices.h>
 
 #include "internals.h"
 
@@ -299,7 +300,7 @@ static ssize_t wakeup_show(struct kobject *kobj,
 
 	raw_spin_lock_irq(&desc->lock);
 	ret = sprintf(buf, "%s\n",
-		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+		      str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
-- 
2.47.0


