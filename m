Return-Path: <linux-kernel+bounces-184960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6BF8CAE86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CD1C2168F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F45775804;
	Tue, 21 May 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LHk3Hm4F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LHk3Hm4F"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1576025
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295714; cv=none; b=bWULZZcqTGbeFT3kMLaSqEraY72U1MQTrigTHIqqNBof4aLqwfxo6GMxHxcsUlSPL5j2KRu/FtB28ESUBqEmNzP2XQ5Z8lG7r+BUCWTQCybXCLgOPh+ZaXtMOLFsMt4s4RbkeGXvdtJmwwkd3C9DsQwpCMkzKh5VOH+QvhxXeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295714; c=relaxed/simple;
	bh=Py+M3XrqzrDyPlIZZVyLd3EN6zx+JbcMiKGql8fVV2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dQAOSJBeDJZcQRh5xNeqvNDZnn8ASUvcte/xACxWtIu7ItIbx0sCAvjHSUJMeitKLUkmhptSxGqepkED2aX4xvMLp+z6qPoIwentC8Xc1gwtYW5hvanPOw/rtY8RYj54LCNlGk/4FVZbVG5IQSNbcLoV/+/pugJ85+xvlSBMdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LHk3Hm4F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LHk3Hm4F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D30652232C;
	Tue, 21 May 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716295704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sth60PATYndDQxclI4sfKvazGosAbA4q70N4pfN4ONI=;
	b=LHk3Hm4FJ0VqjUJ9hYY4D+1QDKto7WhtH/DyxrP3qdCcVbcXOWt1M4UN77MYOg3G+tQWo7
	aeh7X1ROWPs853PpIuxrHdHXq6q3VgDMswKTBpULQ9UnsMkwY/Lv8LGSiX7hu5oGVl3Fl2
	+qt7o1alUCXX32ttn7xq1uHYCRHGuSs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716295704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sth60PATYndDQxclI4sfKvazGosAbA4q70N4pfN4ONI=;
	b=LHk3Hm4FJ0VqjUJ9hYY4D+1QDKto7WhtH/DyxrP3qdCcVbcXOWt1M4UN77MYOg3G+tQWo7
	aeh7X1ROWPs853PpIuxrHdHXq6q3VgDMswKTBpULQ9UnsMkwY/Lv8LGSiX7hu5oGVl3Fl2
	+qt7o1alUCXX32ttn7xq1uHYCRHGuSs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E6ED13A1E;
	Tue, 21 May 2024 12:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s/d2JBiYTGZrNwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 21 May 2024 12:48:24 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/cpu: Move identify_cpu_without_cpuid() into main branch
Date: Tue, 21 May 2024 15:48:23 +0300
Message-Id: <20240521124823.486372-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.19 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.01)[48.81%];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.19
X-Spam-Flag: NO

No point in duplicating if (!have_cpuid_p()) check. Simply move
identify_cpu_without_cpuid() into the else branch. No functional
changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2b170da84f97..69265c0acaea 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1578,9 +1578,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
 	c->extended_cpuid_level = 0;
 
-	if (!have_cpuid_p())
-		identify_cpu_without_cpuid(c);
-
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
 		cpu_detect(c);
@@ -1601,6 +1598,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
 	} else {
+		identify_cpu_without_cpuid(c);
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
 		cpu_init_topology(c);
-- 
2.34.1


