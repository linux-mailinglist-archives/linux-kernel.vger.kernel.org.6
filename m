Return-Path: <linux-kernel+bounces-439452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71209EAF87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFCE188B503
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69448225415;
	Tue, 10 Dec 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rwQWO9kU"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2412253F0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829018; cv=none; b=L9349HG42TsFdeLZrn8WUsEKy8vim6c03E9TrKwuIizxRFGSeOcAmWzAZ9xxmTPIycLi/TlTzND7ggz3qDV+DAr6dqAzY8L2pwfpnFcd8wY6HkHT9WdnK4zyKQHqtHH13Of0wtfTqgO0HpSUCwAt86/9QrSuiWKPtwNAvE+XiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829018; c=relaxed/simple;
	bh=xYDp6sKG5fwtMcoHr7NUe/IdwwtM0oEDlKxrHHrm/rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV3MBJZ2jzsEQY+L/Az9pb/JM3YO6TAj1mZHrMfGWBdrHUfu+/FJmigRvrO+SuNVvUEz8pobjT8Ppxqg12XBVoGrHPnW46nMuIuralfHVpZ9exrHUQtBctbcqqQadY6v90t87pbMW94SiJRxjc/YhPnd9H1uIZylAmHrY1Ij/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rwQWO9kU; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733829014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EXnNWERxS630dnGYYdf2dN5o4wS6D1OTxPJtZ06w44w=;
	b=rwQWO9kUBm/TPiuqgh+9qGziWTSGUDBR9mDMGu2oMZVI0Fyrmtldsvjz8/x5AOQEeqoEcc
	7HymKv0JHj9OsJpKDvs1Veyo7LaqmzRAY7lBVtskzgoMhEeSYHUyASs405jw2KBw06M1jX
	Ybd4Vg8IT0apbuTgs3bcWNOPOTFXU1o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa/simdisk: Use str_write_read() helper in simdisk_transfer()
Date: Tue, 10 Dec 2024 12:09:33 +0100
Message-ID: <20241210110935.104919-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_write_read() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/xtensa/platforms/iss/simdisk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index d6d2b533a574..6ed009318d24 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/proc_fs.h>
@@ -75,7 +76,7 @@ static void simdisk_transfer(struct simdisk *dev, unsigned long sector,
 
 	if (offset > dev->size || dev->size - offset < nbytes) {
 		pr_notice("Beyond-end %s (%ld %ld)\n",
-				write ? "write" : "read", offset, nbytes);
+				str_write_read(write), offset, nbytes);
 		return;
 	}
 
-- 
2.47.1


