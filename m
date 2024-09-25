Return-Path: <linux-kernel+bounces-338035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B672B98528A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88FC1C20F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78914F9E9;
	Wed, 25 Sep 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I2WkscET";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uaivScma";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I2WkscET";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uaivScma"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA8154BEB
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242588; cv=none; b=B8EvVV+Ba24hSazS/w1d6lMWFBcX7tj+OKEqPhO3/LB35ICaPUExIU908UhjZv6ieYbmHQJOP7baEoFL8toQFUM5ISjq3M6VI43VFzk62tD2c3WNhS//jHBhYd9VOmpGGKiKFiVXzdbdd6A/yJ/Jv9dhORjx9NnffozxJxuS3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242588; c=relaxed/simple;
	bh=ES55q1qO4ScgIBk1GsInz47oQLLXboIg+8vX743mNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0U6lk6b07/eSIwKHTH0a4dEK3Q5tEavyk5oxoYlEGqN2+P75PDT/ohjZzrtRyUnxpDuRsSWOVC05AmECIvb+eg95vcIJwpdmS6PILHzvYWf1HhUd8G0pZQeYj/WTq/oBYnCQdBij+JA2dhyWUI8JKewbhpulQAQxTNSNAS7+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I2WkscET; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uaivScma; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I2WkscET; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uaivScma; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 559001FD30;
	Wed, 25 Sep 2024 05:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=I2WkscET4X8Ses6TQhpoq03eizR/BwbQzOjtnEw1k0/mVgzDP9/QUfIpievysibByqhVCV
	3FDd0fjOH9a5RXTWOvGltNV5396BoAPHWnVClhhNkiUUzLbdamWTG5k9A92xRq3MYn2qrJ
	rVk+eM7tSM8Xw7xn4vOA4BuIRHJOFoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=uaivScmazF/vY1c24g6iLhfKSJyibzNlzhBQvGR8m10MgH7r0iON3N08ggSl3FEbTjBmlj
	GyBKdFx0DigtEXBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=I2WkscET4X8Ses6TQhpoq03eizR/BwbQzOjtnEw1k0/mVgzDP9/QUfIpievysibByqhVCV
	3FDd0fjOH9a5RXTWOvGltNV5396BoAPHWnVClhhNkiUUzLbdamWTG5k9A92xRq3MYn2qrJ
	rVk+eM7tSM8Xw7xn4vOA4BuIRHJOFoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=uaivScmazF/vY1c24g6iLhfKSJyibzNlzhBQvGR8m10MgH7r0iON3N08ggSl3FEbTjBmlj
	GyBKdFx0DigtEXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA56613A66;
	Wed, 25 Sep 2024 05:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oWiYH1eh82awUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:36:23 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] sched: add wait_var_event_io()
Date: Wed, 25 Sep 2024 15:31:43 +1000
Message-ID: <20240925053405.3960701-7-neilb@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

It is not currently possible to wait wait_var_event for an io_schedule()
style wait.  This patch adds wait_var_event_io() for that purpose.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 6aea10efca3d..6346e26fbfd1 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -281,6 +281,9 @@ __out:	__ret;								\
 #define __wait_var_event(var, condition)				\
 	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			  schedule())
+#define __wait_var_event_io(var, condition)				\
+	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			  io_schedule())
 
 /**
  * wait_var_event - wait for a variable to be updated and notified
@@ -306,6 +309,34 @@ do {									\
 	__wait_var_event(var, condition);				\
 } while (0)
 
+/**
+ * wait_var_event_io - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for an IO related @condition to be true, only re-checking when a
+ * wake up is received for the given @var (an arbitrary kernel address
+ * which need not be directly related to the given condition, but
+ * usually is).
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the given address.
+ *
+ * This is similar to wait_var_event(), but calls io_schedule() instead
+ * of schedule().
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
+#define wait_var_event_io(var, condition)				\
+do {									\
+	might_sleep();							\
+	if (condition)							\
+		break;							\
+	__wait_var_event_io(var, condition);				\
+} while (0)
+
 #define __wait_var_event_killable(var, condition)			\
 	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
 			  schedule())
-- 
2.46.0


