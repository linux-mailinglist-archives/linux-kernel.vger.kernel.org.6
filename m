Return-Path: <linux-kernel+bounces-338036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC798528B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5379F280E43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2936615622E;
	Wed, 25 Sep 2024 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xHiGzQLD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PjwdHqoF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xHiGzQLD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PjwdHqoF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E211537AC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242597; cv=none; b=npE0rH9esw16GyPirKsoNbLDiwZ0Luls/FwiTFvConVJw5ZPKYnYv4J0JjM3xRoFimaCqovELpZIbpLhQCvpOOaN9o3HQ9CoQBz4wDIZn7ilF3H2lk4CsAlE2rtLyGP/gwCXlNDU58m4h61xlGj9kJ6kFhuQbcJJb4dUPD1KwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242597; c=relaxed/simple;
	bh=bAE66nT3MP0O4MwpXHlyXPxPQuTR1dP9n3i/h6bl0rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX5ev5DTb0kcCyqMhYLbvEck3jEuagFSipoE3ztQ7g3dZNJerg/C8NTvhb7x7WjrfRVvADI6BRWGoc/MkNFkGyDqgGi7Qacr8KXf7fNFSTdYgFF8c7oPb3W543ODQM0cwDGPrPJ5Ndz976LO/H+4iQrzrXyd6S5MO6Z3VtyEHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xHiGzQLD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PjwdHqoF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xHiGzQLD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PjwdHqoF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 395F621A6A;
	Wed, 25 Sep 2024 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+1KIOVKEQInYKPGDI1t7SxUOTRlcwDrGtA7ysyVBWk=;
	b=xHiGzQLD1YE3O0fU6kN5ijAUGIGSJdra2Erpx5B5wnorlm7Qt917o6ZqWzeMS6eA2sKI3X
	GqruhKrokdBa5gZK2JbDwATFzYuxk15szhAEyUPQhzfeKSxoc3BBjfCWoAC3ErzYQpbL95
	JANwmSSQnt2ea78OK5VnQef0StbaY4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+1KIOVKEQInYKPGDI1t7SxUOTRlcwDrGtA7ysyVBWk=;
	b=PjwdHqoFQ6hbJwy2ZOeeUDlpXnIdhDQKWvB661GKChNSGIm2OsIBHuLUfL5kc3L2iFWikh
	orsKmQ1IVGolrvAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xHiGzQLD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PjwdHqoF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+1KIOVKEQInYKPGDI1t7SxUOTRlcwDrGtA7ysyVBWk=;
	b=xHiGzQLD1YE3O0fU6kN5ijAUGIGSJdra2Erpx5B5wnorlm7Qt917o6ZqWzeMS6eA2sKI3X
	GqruhKrokdBa5gZK2JbDwATFzYuxk15szhAEyUPQhzfeKSxoc3BBjfCWoAC3ErzYQpbL95
	JANwmSSQnt2ea78OK5VnQef0StbaY4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+1KIOVKEQInYKPGDI1t7SxUOTRlcwDrGtA7ysyVBWk=;
	b=PjwdHqoFQ6hbJwy2ZOeeUDlpXnIdhDQKWvB661GKChNSGIm2OsIBHuLUfL5kc3L2iFWikh
	orsKmQ1IVGolrvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B399E13A66;
	Wed, 25 Sep 2024 05:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YXFEGmCh82a5UQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:36:32 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] softirq: use bit waits instead of var waits.
Date: Wed, 25 Sep 2024 15:31:44 +1000
Message-ID: <20240925053405.3960701-8-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925053405.3960701-1-neilb@suse.de>
References: <20240925053405.3960701-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 395F621A6A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The waiting in softirq.c is always waiting for a bit to be cleared.
This makes the bit wait functions seem more suitable.
By switching over we can rid of all explicit barriers.  We also use
wait_on_bit_lock() to avoid an explicit loop.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 kernel/softirq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e7840f88..b756d6b3fd09 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -748,10 +748,8 @@ EXPORT_SYMBOL(__tasklet_hi_schedule);
 
 static bool tasklet_clear_sched(struct tasklet_struct *t)
 {
-	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
-		wake_up_var(&t->state);
+	if (test_and_clear_wake_up_bit(TASKLET_STATE_SCHED, &t->state))
 		return true;
-	}
 
 	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
 		  t->use_callback ? "callback" : "func",
@@ -871,8 +869,7 @@ void tasklet_kill(struct tasklet_struct *t)
 	if (in_interrupt())
 		pr_notice("Attempt to kill tasklet from interrupt\n");
 
-	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
-		wait_var_event(&t->state, !test_bit(TASKLET_STATE_SCHED, &t->state));
+	wait_on_bit_lock(&t->state, TASKLET_STATE_SCHED, TASK_UNINTERRUPTIBLE);
 
 	tasklet_unlock_wait(t);
 	tasklet_clear_sched(t);
@@ -882,16 +879,13 @@ EXPORT_SYMBOL(tasklet_kill);
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 void tasklet_unlock(struct tasklet_struct *t)
 {
-	smp_mb__before_atomic();
-	clear_bit(TASKLET_STATE_RUN, &t->state);
-	smp_mb__after_atomic();
-	wake_up_var(&t->state);
+	clear_and_wake_up_bit(TASKLET_STATE_RUN, &t->state);
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock);
 
 void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	wait_var_event(&t->state, !test_bit(TASKLET_STATE_RUN, &t->state));
+	wait_on_bit(&t->state, TASKLET_STATE_RUN, TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(tasklet_unlock_wait);
 #endif
-- 
2.46.0


