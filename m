Return-Path: <linux-kernel+bounces-282821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19394E8FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9321C2182A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245516BE16;
	Mon, 12 Aug 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="f/GZTBtK"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CC74C14
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452916; cv=none; b=LUQFKQBpSRstWNUsFyZFVzKBxNqSM2U/YVe+fx4LkazjsFqcDVE/EKA7ZVh00lBmBUVI48D1q6Ubmakgkeh83DPh6kNTspTGaIHyBdpCE+XS2FtaiV/2M4r/T2Ff1RtyVXD3iLFl8NM8YMkXDukb2ISVO6uv+Ua6RpGgnk9h7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452916; c=relaxed/simple;
	bh=U2xzaysom7aggwNAgqQ4tbOTx6Vj6CldEEI4Twwh5kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spYioyv/lnrPKHSMnKSNDkwgvilS5Di5ffAhoQsmrzPkVPYlNRVfbUhMOVr/x1//0bnEM+lrbup/70oxZ5VXAJeKbytBnUBqWUZURz05GcfoMN1gSB1wDmY7oBAgKgUViKcmUibTkSD4ZS3PQ9GludU1FgEPkE+dbrUQWr12ydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=f/GZTBtK; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 17320 invoked by uid 990); 12 Aug 2024 08:55:09 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 10:55:08 +0200
From: Florian Rommel <mail@florommel.de>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: [PATCH] kgdbts: fix hw_access_break_test
Date: Mon, 12 Aug 2024 10:54:59 +0200
Message-ID: <20240812085459.291741-1-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.998197) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.598197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=U2xzaysom7aggwNAgqQ4tbOTx6Vj6CldEEI4Twwh5kA=;
	b=f/GZTBtKx8fKpeZpOmH3VDWt4ZZOWTfNNz77oPV7I3KGPFg3FOxX//BswJY12X9wpP2Q/5btGX
	CGGBIntfumlcApFZwoIdl2pV+km8FrAjU5I27wK1YPuuIyaEAUp4UWFj3VxETl6UfyhjlVPfhwN9
	Pxom3lf5rKr3fkN93yX7mkDPedQ5NpttPtcpZLS6D1aSuL723ijrjhTr4wV1tYY7mHEodCw6fYkQ
	6h7y9qD9RRki9mWvfiehPdW6qnCQTQ8gz2KlNNCZ57ndpljzMxFvw/7/yY+c9cRNrXyx0mePFnYk
	Px33vDGlkqxeA2AJI3n+EPMBXuMdmuH6FLOkicbUTR2Mjy0pvgK094dySYevapWndSkkNqpDp+4A
	hijYDzqVUIDAV9mF9HhLM64Re/+uYGIyzXh5i6BqiqjucRLUcL6O2GhcTw5GHlwX4+IihFgI7B/0
	/XytifEyKhhKfW7WUItH/uz45L5nSXTMcvW7k4xEWwIKJRlRnLeWxJ1TFbGxBuvEvMrX6SZMrkLI
	YwtYlNY63CO7b2uamtUpiy46JfqcnBMVwGFABdbCIelzjpcfKJojU0pbaFMkwNVmvikrv9uqgWx1
	i8qM6DU9OInhOUg7q2t6LfA45FEYOl6sjxuKm2TEJBBcVTDF08RUoFN5VCI3sI6ZTRZU1Qo1bgtw
	s=

The test for access watchpoints (hw_access_break_test) was broken
(always failed) because the compiler optimized out the write to the
static helper variable (hw_break_val2), as it is never read anywhere.
This resulted in the target variable (hw_break_val) not being accessed
and thus the breakpoint not being triggered.

Remove the helper variable (hw_break_val2), and use READ_ONCE to force
reading the target variable (hw_break_val).

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 drivers/misc/kgdbts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 88b91ad8e541..0cf31164b470 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -95,6 +95,7 @@
 #include <linux/kallsyms.h>
 
 #include <asm/sections.h>
+#include <asm/rwonce.h>
 
 #define v1printk(a...) do {		\
 	if (verbose)			\
@@ -126,7 +127,6 @@ static int final_ack;
 static int force_hwbrks;
 static int hwbreaks_ok;
 static int hw_break_val;
-static int hw_break_val2;
 static int cont_instead_of_sstep;
 static unsigned long cont_thread_id;
 static unsigned long sstep_thread_id;
@@ -284,7 +284,7 @@ static void hw_rem_access_break(char *arg)
 
 static void hw_break_val_access(void)
 {
-	hw_break_val2 = hw_break_val;
+	READ_ONCE(hw_break_val);
 }
 
 static void hw_break_val_write(void)
-- 
2.46.0


