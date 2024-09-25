Return-Path: <linux-kernel+bounces-338033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC86985288
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362682813A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF530155C95;
	Wed, 25 Sep 2024 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sK34K4wU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ugTZHIFa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ig5IGE5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TP3Qf3Lg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073115747D
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242576; cv=none; b=ZJo0AMDz/7L4MzQFp0KXKKvWy+4aNiYa+SDvL1RLyxpMxTzlvuimvMY6gO+ZHMN3gbj990uoi1gMwxhfghodBJLyddW1Q/azFroV5yYV2zl6lwRqGEszXhbQxN7j+sGbt0yrH66d6ZgF8+d7jmlnhnorudPLDO8B9nNzOTgQjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242576; c=relaxed/simple;
	bh=d06xgWgkQbMZwtnKU5C5cXUH1HsFJbDXxFWLbHzTy1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3Dd8TmYnlbRd+nIsUED7+nm91NI2/43wqM3IfFvR0EMhmqnU9Q7dzzJcYjs92R+jqXoIdtp6U4h20kyCnXTfNH8wiHQzc4HzoJigNKYbntejYclS7MbFCwQ2Eulw0LRs+70IhnF0bUzDELE4peNQaTU2TDYMnf4ocWem90BQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sK34K4wU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ugTZHIFa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1ig5IGE5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TP3Qf3Lg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B57321A6A;
	Wed, 25 Sep 2024 05:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqEuJGyXxJQ9CYo6juFxRH005TpzRgjAm+F33eybZko=;
	b=sK34K4wUS2Y7hOlPrBEfUAWRJQl5J6P7Sm7kURQwq5nw3IwntnwEO3oGZ2jwHz1KS84sxO
	PZsW2xAWvMJfbTrQicURJWKrzeB0sdYR+D/NnPu0vPsNO1ooLk2DFWOPkUlCYXTDF+y1WQ
	S9kwPo+XAs4G5ACrgssIxtZyuSOJzVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqEuJGyXxJQ9CYo6juFxRH005TpzRgjAm+F33eybZko=;
	b=ugTZHIFa0axJNUlufpIDGPbe7i7ByFk2QzphemU11XRPkMFPNXz+TWP2WvhgHcccjKcsIU
	3Y2r4wEjor7YL+BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1ig5IGE5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TP3Qf3Lg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqEuJGyXxJQ9CYo6juFxRH005TpzRgjAm+F33eybZko=;
	b=1ig5IGE5HGuwn8zw9Fs7bP9Fu0tQQvk1jJC5xgwQFKKPJKAvFjhjA/XTIGo5tinssNotzX
	mEYLe7EMlwDhsAkMxkkN8T7oQIQwfqbr20A0BHCgHgMjASJ9fJpn6mLpbihCIUPXYAKlr5
	rRcRqWNqGXjAb1L5S8x9hw60fAWCqB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqEuJGyXxJQ9CYo6juFxRH005TpzRgjAm+F33eybZko=;
	b=TP3Qf3Lg7Uzyogn45YaL5sKKYbI9h24GL5DJ6RQ2D52n4cBFTKe4CvqHnZGUvf384QpX7j
	kkfF2WmOGeY4+sAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11EE913A66;
	Wed, 25 Sep 2024 05:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rUlbLkmh82ajUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:36:09 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] sched: Add test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()
Date: Wed, 25 Sep 2024 15:31:41 +1000
Message-ID: <20240925053405.3960701-5-neilb@suse.de>
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
X-Rspamd-Queue-Id: 8B57321A6A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There are common patterns in the kernel of using test_and_clear_bit()
before wake_up_bit(), and atomic_dec_and_test() before wake_up_var().

These combinations don't need extra barriers but sometimes include them
unnecessarily.

To help avoid the unnecessary barriers and to help discourage the
general use of wake_up_bit/var (which is a fragile interface) introduce
two combined functions which implement these patterns.

Also add store_release_wake_up() which supports the task of simply
setting a non-atomic variable and sending a wakeup.  This pattern
requires barriers which are often omitted.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 06ec99b90bf3..0272629b590a 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -419,4 +419,64 @@ static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 	wake_up_bit(word, bit);
 }
 
+/**
+ * test_and_clear_wake_up_bit - clear a bit if it was set: wake up anyone waiting on that bit
+ * @bit: the bit of the word being waited on
+ * @word: the address of memory containing that bit
+ *
+ * If the bit is set and can be atomically cleared, any tasks waiting in
+ * wait_on_bit() or similar will be woken.  This call has the same
+ * complete ordering semantics as test_and_clear_bit().  Any changes to
+ * memory made before this call are guaranteed to be visible after the
+ * corresponding wait_on_bit() completes.
+ *
+ * Returns %true if the bit was successfully set and the wake up was sent.
+ */
+static inline bool test_and_clear_wake_up_bit(int bit, unsigned long *word)
+{
+	if (!test_and_clear_bit(bit, word))
+		return false;
+	/* no extra barrier required */
+	wake_up_bit(word, bit);
+	return true;
+}
+
+/**
+ * atomic_dec_and_wake_up - decrement an atomic_t and if zero, wake up waiters
+ * @var: the variable to dec and test
+ *
+ * Decrements the atomic variable and if it reaches zero, send a wake_up to any
+ * processes waiting on the variable.
+ *
+ * This function has the same complete ordering semantics as atomic_dec_and_test.
+ *
+ * Returns %true is the variable reaches zero and the wake up was sent.
+ */
+
+static inline bool atomic_dec_and_wake_up(atomic_t *var)
+{
+	if (!atomic_dec_and_test(var))
+		return false;
+	/* No extra barrier required */
+	wake_up_var(var);
+	return true;
+}
+
+/**
+ * store_release_wake_up - update a variable and send a wake_up
+ * @var: the address of the variable to be updated and woken
+ * @val: the value to store in the variable.
+ *
+ * Store the given value in the variable send a wake up to any tasks
+ * waiting on the variable.  All necessary barriers are included to ensure
+ * the task calling wait_var_event() sees the new value and all values
+ * written to memory before this call.
+ */
+#define store_release_wake_up(var, val)					\
+do {									\
+	smp_store_release(var, val);					\
+	smp_mb();							\
+	wake_up_var(var);						\
+} while (0)
+
 #endif /* _LINUX_WAIT_BIT_H */
-- 
2.46.0


