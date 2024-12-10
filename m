Return-Path: <linux-kernel+bounces-440316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E527C9EBBBB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3DE188A2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B76230273;
	Tue, 10 Dec 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVdkDVAp"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC723ED4A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865646; cv=none; b=IvgSq39UCzpoSD/IKY0+0iutIr69PgKhfZ3mTPaXMYFHEiA9hs9BsJpc37EfTPWJRAz/RlSwL4qNEWtMaPeF4RsZY00dp22dBmYN8spjX67HRjAjAAJUBnAFZnXSFDGhQOzR3vbkJ2KaSHAMiklw3lFA0eT6lKeCCeakbyngDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865646; c=relaxed/simple;
	bh=z//+dXPXufdDNeW/4mfGF70rTrKf1xncwdlSj5vCDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQKNujTQaurg655hkI74DjGCapYaU67bzcAamwnUwsCaluEP+lmv3mCpOHyqz5FtArkFVIiQmp/K2n7x0gqXqsEL5lLZ1qt9INkaiDj9jms6kSfHaTYmLq9sPn+06gRoyfyXue8X3daFVVcGlZHtZ76KrobV+pXZmC/FlgjEffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVdkDVAp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733865641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pf34OojONVP7LNB6ICjh3yc06WTmNpDfYvUhl/RPtw4=;
	b=MVdkDVApxaLai0rN0j7l81NBAOnxNZIPit2MeqnKmkMERxSYjtN6RIcVMzAD0F5RDMThu6
	qbcqeQfRcxiwyZfGdcaHNlpYbPi2MqFTsETP1rxIZXPLPFhwDzWXLzZiGiSAK09FK0EWHc
	QZxEz4uErRWxZmRn618eLxQyfQHsRIE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use str_on_off() helper in check_cache_coherency()
Date: Tue, 10 Dec 2024 22:20:07 +0100
Message-ID: <20241210212009.258990-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kernel/setup-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 6fa179448c33..f7d7a93f07fc 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -834,8 +834,8 @@ static int __init check_cache_coherency(void)
 	if (devtree_coherency != KERNEL_COHERENCY) {
 		printk(KERN_ERR
 			"kernel coherency:%s != device tree_coherency:%s\n",
-			KERNEL_COHERENCY ? "on" : "off",
-			devtree_coherency ? "on" : "off");
+			str_on_off(KERNEL_COHERENCY),
+			str_on_off(devtree_coherency));
 		BUG();
 	}
 
-- 
2.47.1


