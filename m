Return-Path: <linux-kernel+bounces-530142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57748A42F98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E91899FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C791EBFE6;
	Mon, 24 Feb 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BbnVatbb"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E61C8630
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434200; cv=none; b=oSjXyrOvrHmSUzy3huWeE9CDV+5p152pChkYExeHuecNXSGdY3DprQCXzr4C658XgYPmEEr+C/VyDMK+ytQNI2AWkgun/a4F+sTY9pVym/GCuEIvcoDd1Hmc1g+/Pi//tESne24hUtycaVdl4+8s3nPSWgrPQL+cw8/4BaRMRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434200; c=relaxed/simple;
	bh=GUhgL6hS//UQepLQQDcUz5xENrHigAyZeokfv/kaliU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rg7MHu2q3uiEv3JBQXWv2iDLxd10sI4+p3+N98X7JrEB2jiPz/TDmLRrSXauqLoBiYwE1TRiregLyqjI9NF0Wun7LrPPY4G7wHbnC4Fh5SQWolJ+5jtkEsLzGOI7SR61RRzq2IkE0l72n5T8V7Ny5dvruykoug6KNG4msU647Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BbnVatbb; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740434197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rE+rorFgyeXZ3jXULEAJWqUQ+FDPOU0lGoqzwNbi0Hg=;
	b=BbnVatbbD75pCJ5aXM9CE4hD8I/VZ3Bq4IEAOG/fRm4EWsRqqK2dx+xXp6xMzwcTx/2aBE
	QJVXcVMlrDyD6KF/9vof3tvAgaJ5MqS6lPPtbxcKdwkP7zlvhfstLpft2dpbWcltkSwpy4
	naK89UHgiI2gwyaPVS//qs4R3ZxJWcw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH]  MIPS: Loongson2ef: Replace deprecated strncpy() with strscpy()
Date: Mon, 24 Feb 2025 22:54:50 +0100
Message-ID: <20250224215451.195727-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/mips/loongson2ef/common/machtype.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/loongson2ef/common/machtype.c b/arch/mips/loongson2ef/common/machtype.c
index 82f6de49f20f..e635e66d2e6c 100644
--- a/arch/mips/loongson2ef/common/machtype.c
+++ b/arch/mips/loongson2ef/common/machtype.c
@@ -48,8 +48,7 @@ void __init prom_init_machtype(void)
 		return;
 	}
 	p += strlen("machtype=");
-	strncpy(str, p, MACHTYPE_LEN);
-	str[MACHTYPE_LEN] = '\0';
+	strscpy(str, p);
 	p = strstr(str, " ");
 	if (p)
 		*p = '\0';
-- 
2.48.1


