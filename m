Return-Path: <linux-kernel+bounces-338021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583B998527C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042351F20F09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437FB14A62F;
	Wed, 25 Sep 2024 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IfEcE97H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c9BDKYbU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IfEcE97H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c9BDKYbU"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F05155732
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242477; cv=none; b=Q1a7WoJ3P8OReGqEs20sh5HwkOmmOfcw439GaYfmBaIfjCCeWWhuP+/BNWLcNb4XHSQuvH0hQQBlZF32uqKNe6AScO4yjBHH8u43Xj5OK9ezDdcjdFfaLGFo9y5Y6Rs2kMvVWRDl/d0xHyaRe8lkUuxBp7v1gjnc7tLQLZ/hzx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242477; c=relaxed/simple;
	bh=r3sxpMMlRKaoiiDUtmPbRteoeqVWw1zcEr5ctVzUO9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go6S+ZNaphcTBAdhqMMfuud1nJtJcXz98GYwipX7lhy+6r/6qoQAVBeYz22x+WOHcqeO9NY9MEtucJoH3S0goJVORod3M5Gs//1YoMAYIbOCvvC32wb4SVxCtmVZYE5eZ3nMa5AHp1uoEijGlIQYmlDLvKXPNGjWB47FoD8DUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IfEcE97H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c9BDKYbU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IfEcE97H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c9BDKYbU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF82A1FD30;
	Wed, 25 Sep 2024 05:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jto+WAjJOCZLH4emYxzPTw5OFHfbNqohY3iXFmMl6WU=;
	b=IfEcE97HG/d6WokmYODXmSPcjTCWNLQWIbxBJfszRzDii0jtZy+M8aTexOx4zIzaPOER+h
	9Qm3Qhz4FypVWrifsZHvmKJ/C+kb5h/8brz1gbEpYxHXbws0dM8EXmflBIqLKQmfvtgRiS
	PLLUG7Zq4J1/jky236s85NtOjkyHfI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jto+WAjJOCZLH4emYxzPTw5OFHfbNqohY3iXFmMl6WU=;
	b=c9BDKYbUGH/I1eP3oxKJaf6FV/3gZbPO4RUnlAtcggXCajbvY5guA9jqmo9Je53VUdV88z
	2yIaSWfuaYbGqNBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727242467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jto+WAjJOCZLH4emYxzPTw5OFHfbNqohY3iXFmMl6WU=;
	b=IfEcE97HG/d6WokmYODXmSPcjTCWNLQWIbxBJfszRzDii0jtZy+M8aTexOx4zIzaPOER+h
	9Qm3Qhz4FypVWrifsZHvmKJ/C+kb5h/8brz1gbEpYxHXbws0dM8EXmflBIqLKQmfvtgRiS
	PLLUG7Zq4J1/jky236s85NtOjkyHfI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727242467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jto+WAjJOCZLH4emYxzPTw5OFHfbNqohY3iXFmMl6WU=;
	b=c9BDKYbUGH/I1eP3oxKJaf6FV/3gZbPO4RUnlAtcggXCajbvY5guA9jqmo9Je53VUdV88z
	2yIaSWfuaYbGqNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A5C413A66;
	Wed, 25 Sep 2024 05:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1KOAOKg82YiUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 05:34:26 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] block: change wait on bd_claiming to use a var_waitqueue, not a bit_waitqueue
Date: Wed, 25 Sep 2024 15:24:04 +1000
Message-ID: <20240925053118.3956520-2-neilb@suse.de>
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

bd_prepare_to_claim() waits for a var to change, not for a bit to be
cleared.
So change from bit_waitqueue() to __var_waitqueue() and correspondingly
use wake_up_var().
This will allow a future patch which change the "bit" function to expect
an "unsigned long *" instead of "void *".

Signed-off-by: NeilBrown <neilb@suse.de>
---
 block/bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 33f9c4605e3a..738e3c8457e7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -555,7 +555,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 
 	/* if claiming is already in progress, wait for it to finish */
 	if (whole->bd_claiming) {
-		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
+		wait_queue_head_t *wq = __var_waitqueue(&whole->bd_claiming);
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
@@ -578,7 +578,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
-	wake_up_bit(&whole->bd_claiming, 0);
+	wake_up_var(&whole->bd_claiming);
 }
 
 /**
-- 
2.46.0


