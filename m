Return-Path: <linux-kernel+bounces-338027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6B985282
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E502E1F23F55
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E0154BFB;
	Wed, 25 Sep 2024 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saYCNXRZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3vGIEw3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="saYCNXRZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H3vGIEw3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59661B85D1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242525; cv=none; b=LN1nd1jZFsB8BhQSvECWUlzDAW1Q2lPnAcSForMiM0XrSIMy49eRpOrwFCjaWibMJehmXfTt8LvbBI4XqQKFHScs1s+83tKMhQRqYzfchzDb5DpChRnjSEgJYhJoRoh48+XH2+kBCRT8OV037Xji/ivxDPyrNCCZ8Ci05mMDMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242525; c=relaxed/simple;
	bh=ES55q1qO4ScgIBk1GsInz47oQLLXboIg+8vX743mNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoepK7tdN8gubadkT4UvatHwYnTrCECfveI0DmZceZa0K8085LkvL97IsuUfCPqa2Y+/oHMnVOx+xt/2ge1CGhoan925S7OeFyxb0tv6+wLcnW9PddjK7updc/CEVY7941tKf5HY24nZYazKWsSjFVznDPYHWXmFC8e9ziTv36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saYCNXRZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3vGIEw3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=saYCNXRZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H3vGIEw3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B81B121A6A;
	Wed, 25 Sep 2024 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=saYCNXRZvvMQUrvsOBScAwR8ofkxxpBVkreRQNU4rTUfF4FJeBIwdZlb9BEYEonEM/ruPm
	SOdlVutQ0pfTk2sRMJf36RmPwvarL9CpmMazjz1us/UI09IBha2QI1F62IfctqrCgF7Pxe
	L2yTR87LuAYfBua/RxKfaLTzFVvT/hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=H3vGIEw3xkcELjcRKbDwcae/XjvIdV+8FDwpGH+X56cMQphpC839AAizGsAu9o2HmVJNb6
	baW4Wqqr+1mMuzDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=saYCNXRZvvMQUrvsOBScAwR8ofkxxpBVkreRQNU4rTUfF4FJeBIwdZlb9BEYEonEM/ruPm
	SOdlVutQ0pfTk2sRMJf36RmPwvarL9CpmMazjz1us/UI09IBha2QI1F62IfctqrCgF7Pxe
	L2yTR87LuAYfBua/RxKfaLTzFVvT/hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242521;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtTb28IU1JK+M/CDCe9gHZ0UxDCFT041G0Qqg0/6YrU=;
	b=H3vGIEw3xkcELjcRKbDwcae/XjvIdV+8FDwpGH+X56cMQphpC839AAizGsAu9o2HmVJNb6
	baW4Wqqr+1mMuzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E08313A66;
	Wed, 25 Sep 2024 05:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHApOReh82ZlUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:35:19 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] sched: add wait_var_event_io()
Date: Wed, 25 Sep 2024 15:24:10 +1000
Message-ID: <20240925053118.3956520-8-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925053118.3956520-1-neilb@suse.de>
References: <20240925053118.3956520-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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


