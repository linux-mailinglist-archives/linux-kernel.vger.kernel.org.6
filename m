Return-Path: <linux-kernel+bounces-409577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B789C8EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10ED1F21AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732C18C93B;
	Thu, 14 Nov 2024 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJqN0dOY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhN6g7by";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJqN0dOY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AhN6g7by"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8741C65
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599100; cv=none; b=bkEg8vHDQ55Tgpcks9GsGSBtQ/PmK4qQCetYQ0gv73pa/1y5aqB0rf8SlSxUajbz7O/9KqPoIwutE/SUnRYVHXsNr+K74N3tlax5V+1fWdIJuaru/ghNWKBG1eKybzvluYyMH3vaF42qaybV1yneidnNG9bpb++cXJU5fOV5lL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599100; c=relaxed/simple;
	bh=306d1NwteLBvyZE5wGW5gSWmyV7hlGKWGZVrlQHpEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqpajApHa0+HlGgF7CqQ6hN3+7bl0KQCA2j5/IllrUqlC2vbpWpdzIR+ffK1cvKj5hS03O37QDMNM4bCqP+/Pwgb4INz42yMhA2mSeMV91EKLMOOy63X/pa2XvCSDawKpe45o3V6Q/885+Hjl/J6ZpboUPccGOVLNCxLKfqJvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJqN0dOY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhN6g7by; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJqN0dOY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AhN6g7by; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9541F395;
	Thu, 14 Nov 2024 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731599096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hEaTFTPS7VTSPviuCZqEa/J5zdrMvi33ihFfVdd06hQ=;
	b=IJqN0dOYfQV/LHIndmzBQPkDJ1oA8TpQ9AVUIRjTCmSgLboQl3Ew9XUdZ3Ws9ae9tKIl74
	gjLLgDpaH41Tl28zghBKv9ZgzgvPnCyssQvST17qxuik2ZN82T3sop1zJ9TXmsp85DOT4D
	FcZSoPjtLI0UsUbjXybYgImvbc+C6N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731599096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hEaTFTPS7VTSPviuCZqEa/J5zdrMvi33ihFfVdd06hQ=;
	b=AhN6g7byLAzrYgH9f4jjBoa1ox2B3k3FPS1PAE/FiL3wcnf4Qmqt1jXn7Ltmciiq+RPxOr
	3WmsJhjwumxIfiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731599096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hEaTFTPS7VTSPviuCZqEa/J5zdrMvi33ihFfVdd06hQ=;
	b=IJqN0dOYfQV/LHIndmzBQPkDJ1oA8TpQ9AVUIRjTCmSgLboQl3Ew9XUdZ3Ws9ae9tKIl74
	gjLLgDpaH41Tl28zghBKv9ZgzgvPnCyssQvST17qxuik2ZN82T3sop1zJ9TXmsp85DOT4D
	FcZSoPjtLI0UsUbjXybYgImvbc+C6N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731599096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hEaTFTPS7VTSPviuCZqEa/J5zdrMvi33ihFfVdd06hQ=;
	b=AhN6g7byLAzrYgH9f4jjBoa1ox2B3k3FPS1PAE/FiL3wcnf4Qmqt1jXn7Ltmciiq+RPxOr
	3WmsJhjwumxIfiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DBA13794;
	Thu, 14 Nov 2024 15:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aR5MFvgaNmdhDwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Nov 2024 15:44:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-mtd@lists.infradead.org
Cc: Joern Engel <joern@lazybastard.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	Fabian Vogt <fvogt@suse.com>
Subject: [PATCH] mtd: phram: Add the kernel lock down check
Date: Thu, 14 Nov 2024 16:44:41 +0100
Message-ID: <20241114154442.25920-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The phram MTD driver may map any memory pages no matter whether it's
reserved or whatever used for systems, which basically allows user
bypassing the lock down.

Add the check and abort the probe if the kernel is locked down for
LOCKDOWN_DEV_MEM.

Reported-by: Fabian Vogt <fvogt@suse.com>
Suggested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/mtd/devices/phram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 1bf192f229d7..48abfb81ef66 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/security.h>
 
 struct phram_mtd_list {
 	struct mtd_info mtd;
@@ -410,6 +411,10 @@ static int __init init_phram(void)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_DEV_MEM);
+	if (ret)
+		return ret;
+
 	ret = platform_driver_register(&phram_driver);
 	if (ret)
 		return ret;
-- 
2.43.0


