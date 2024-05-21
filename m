Return-Path: <linux-kernel+bounces-184961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C08CAE87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809112848CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1D77111;
	Tue, 21 May 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qc3s0X63";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FKbQfGhk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34833770F0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295717; cv=none; b=JJYazLC/XN7FMDBzp7JMToiPAn9AGjnyJGtg3Da8YYaYcljlZh95ftCW7iL0cacgdHYcsSCNDaI7DEVHivuaZEXUc43kveRCh/KcSVoGvPNlO2rOGg6kf6bQ/xBbJsGqFm+x4FlctJR2YqbRGjGeFhukJfBRuHBgF/nYk8ML97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295717; c=relaxed/simple;
	bh=kJPwlfNSt4lRbMzy2in8uS3czPJ6Spymu1LJUHyk+9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+MOsUPNcTB3yqD4KGgKwHxdHmbXBptGWQ3Y54+qshaZ9Dh8AC+mSo0qOkFX+L00dk1sq8wwvaBqASigtMv/GWbZufKQ/KxdYHqsZBIu4fuZgkpRjf8KtZBx5RMZCrAbGngCzCMCTMUTH5+V6ZjG6sVQBC3rYUxAx5B0u0srgIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qc3s0X63; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FKbQfGhk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7751222A0A;
	Tue, 21 May 2024 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716295714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKWV+AsBJjmDRa8bjqWRom+SbZLV0WLxFg7rfkNBR3Y=;
	b=qc3s0X637V/prCNm5tfNlWU8gicAYq4ROc9Scf8R0WetejpruCvwz8dKKp6L6wwfWVAegZ
	EdNmJ3+i2zw+M2HeeQ2qTsZe8k97OTfd9gv+0alnFhYPvaXIaqDeMYoWJl4IbpgR8yNd2N
	KwMKmgqSRznYnkTOfwekLdaMYeHZeUI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FKbQfGhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716295713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZKWV+AsBJjmDRa8bjqWRom+SbZLV0WLxFg7rfkNBR3Y=;
	b=FKbQfGhkXLBEa9IxXF0SYFPvBAq0DI9YgCNRbHAV9V30vvddusQ0UMw2K5flfZGyRmNLCv
	hE26In06PAX+QdgNf1+CG0+I7mzEbGzEJDNkHG9wzJq3kcxU4SnI8Tw34Z+bKUIbfXq9Wn
	x0zoYXOkFeW/b7Am6sIWUmXNUBOlWDI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4472513A1E;
	Tue, 21 May 2024 12:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XUh1DiGYTGbmOQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 21 May 2024 12:48:33 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/cpu: Consolidate identical branches
Date: Tue, 21 May 2024 15:48:32 +0300
Message-Id: <20240521124832.486390-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.03 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[54.33%];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7751222A0A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.03

It's pointless to have 2 identical branches one after the other, simply
collapse them in a single branch. No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 69265c0acaea..369037a166fd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1732,12 +1732,11 @@ static void generic_identify(struct cpuinfo_x86 *c)
 {
 	c->extended_cpuid_level = 0;
 
-	if (!have_cpuid_p())
+	if (!have_cpuid_p()) {
 		identify_cpu_without_cpuid(c);
-
-	/* cyrix could have cpuid enabled via c_identify()*/
-	if (!have_cpuid_p())
+		/* cyrix could have cpuid enabled via c_identify()*/
 		return;
+	}
 
 	cpu_detect(c);
 
-- 
2.34.1


