Return-Path: <linux-kernel+bounces-531628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C047A442DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B127A3C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2B26A1B9;
	Tue, 25 Feb 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BdfXwWQg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BdfXwWQg"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E61267B9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494039; cv=none; b=Ih8DqCGCmlLTJqfQzbT5Why+Q+uswXw0ya+K3SG7qoBBmQB3HemZMDUiK6dRHAlrIzVDmR3U05OagO+nfFubxRkeDMoeUOJLWKgeG4Y3eda1EYt5Y0u8F/N/T8ZCQ2A9VEbbS3P1oOG6kcxYD3cNVHqoljH+W26kea0qxsBQi/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494039; c=relaxed/simple;
	bh=y/7H7svuQhmEhNFttv1mv2/KR3wQrbEIXhadF/7FapY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVgYlryh+jmUPFvjwopMGOhCd+27lPFivZcUDbLCtwnAw4PL2rTpXPZWoBmOg/ote/sZ9pHujrBkIW8sSWI8wQc472rWeQaK6EoXu8mdVzqElSt8q0CSNUHOHhMAiNHCR+kDvyMwPMcyt2pzJHbq8gEZAI0jBPQkyp/xZpC5GsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BdfXwWQg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BdfXwWQg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FA5421114;
	Tue, 25 Feb 2025 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740494034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6+bz9Vw3AFnrTxdhG7VUTZozdaE5vtXI0uRnfm0qD3M=;
	b=BdfXwWQgoSsum+BlXiV0CrgfPXru0ztALbI7wZ8Q9oR6K+Su0MPSUlsKkL/+T4qqb2DIN4
	9oKSiucC7bgj4ueTSpJWLRjKciB1ZryfztiSFOe6/i68ZCy0+YxcHDrzmKN5NLO1IdoVBC
	QjDgDJ2kPEzAFGegtuWLh8DHZhdPuko=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740494034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6+bz9Vw3AFnrTxdhG7VUTZozdaE5vtXI0uRnfm0qD3M=;
	b=BdfXwWQgoSsum+BlXiV0CrgfPXru0ztALbI7wZ8Q9oR6K+Su0MPSUlsKkL/+T4qqb2DIN4
	9oKSiucC7bgj4ueTSpJWLRjKciB1ZryfztiSFOe6/i68ZCy0+YxcHDrzmKN5NLO1IdoVBC
	QjDgDJ2kPEzAFGegtuWLh8DHZhdPuko=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF1B513888;
	Tue, 25 Feb 2025 14:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LHTN9HUvWfcFQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Tue, 25 Feb 2025 14:33:53 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-edac@vger.kernel.org
Cc: bp@alien8.de,
	qiuxu.zhuo@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3] x86/mce/inject: Remove call to mce_notify_irq()
Date: Tue, 25 Feb 2025 16:33:48 +0200
Message-ID: <20250225143348.268469-1-nik.borisov@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The call to mce_notify_irq() has been there since the initial version of
the soft inject mce machinery, introduced in ea149b36c7f5 ("x86,
mce: add basic error injection infrastructure"). At that time it was
functional since injecting an MCE resulted in the following call chain:

    raise_mce()
      ->machine_check_poll()
          ->mce_log() - sets notfiy_user_bit
    ->mce_notify_user() (current mce_notify_irq) consumed the bit and called the
    usermode helper.

However, with the introduction of 011d82611172 ("RAS: Add a Corrected Errors Collector")
the code got moved around and the usermode helper began to be called
via the early notifier (mce_first_notifier()) rendering the call in
raise_local() defunct as the mce_need_notify bit (ex notify_user) is
only being set from the early notifier.

Remove the noop call and make mce_notify_irq static. No functional
changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/mce.h       |  2 --
 arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
 arch/x86/kernel/cpu/mce/inject.c |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index eb2db07ef39c..6c77c03139f7 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -296,8 +296,6 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-bool mce_notify_irq(void);
-
 DECLARE_PER_CPU(struct mce, injectm);
 
 /* Disable CMCI/polling for MCA bank claimed by firmware */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..1f14c3308b6b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -584,6 +584,28 @@ bool mce_is_correctable(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_correctable);
 
+/*
+ * Notify the user(s) about new machine check events.
+ * Can be called from interrupt context, but not from machine check/NMI
+ * context.
+ */
+static bool mce_notify_irq(void)
+{
+	/* Not more than two messages every minute */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
+
+	if (test_and_clear_bit(0, &mce_need_notify)) {
+		mce_work_trigger();
+
+		if (__ratelimit(&ratelimit))
+			pr_info(HW_ERR "Machine check events logged\n");
+
+		return true;
+	}
+
+	return false;
+}
+
 static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
@@ -1773,28 +1795,6 @@ static void mce_timer_delete_all(void)
 		del_timer_sync(&per_cpu(mce_timer, cpu));
 }
 
-/*
- * Notify the user(s) about new machine check events.
- * Can be called from interrupt context, but not from machine check/NMI
- * context.
- */
-bool mce_notify_irq(void)
-{
-	/* Not more than two messages every minute */
-	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
-
-	if (test_and_clear_bit(0, &mce_need_notify)) {
-		mce_work_trigger();
-
-		if (__ratelimit(&ratelimit))
-			pr_info(HW_ERR "Machine check events logged\n");
-
-		return true;
-	}
-	return false;
-}
-EXPORT_SYMBOL_GPL(mce_notify_irq);
-
 static void __mcheck_cpu_mce_banks_init(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 313fe682db33..06e3cf7229ce 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -229,7 +229,6 @@ static int raise_local(void)
 	} else if (m->status) {
 		pr_info("Starting machine check poll CPU %d\n", cpu);
 		raise_poll(m);
-		mce_notify_irq();
 		pr_info("Machine check poll done on CPU %d\n", cpu);
 	} else
 		m->finished = 0;
-- 
2.43.0


