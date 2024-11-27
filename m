Return-Path: <linux-kernel+bounces-423086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2639DA29B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B936284234
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8CA1494B2;
	Wed, 27 Nov 2024 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nBFNE2dQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lb76Io7I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nBFNE2dQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lb76Io7I"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD813C816;
	Wed, 27 Nov 2024 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690947; cv=none; b=fLPfEfKSOOn8es9rmMPRAsJjGTGeWLE/mOTXSeOJQ529fLgSAeyJB+b4q9x6/5fwWn7womSD8eo++rBHmFxPuTMmYN76LMxSG4V7azMLbGj9nnb3t5NtUx8luVtUXK6EwOCJrLKttJpcAcvkEPnp+2FCfa/wYRkiSrmlytj2KoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690947; c=relaxed/simple;
	bh=tBdwJh1bAjzIZwJi91WvrO7popJui2WKIfsctkQQq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvoHQDUdPlbrFWqCPgizFmFqlsCb1oh46mnGD28WkL0vmAShWSYDjbb9qlYfWz4aL6nQYU5McCQXZ7+N6WJoV2el9hfnZXlqtAHTMRAof88mYqcOFRE/PblGbIjbkuWLHuhoTwhDhBeZI0m46Mk8N5/3oOrxgG6n+s0HdEZzxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nBFNE2dQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lb76Io7I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nBFNE2dQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lb76Io7I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF7F921170;
	Wed, 27 Nov 2024 07:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732690937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7RlmuC5WUFWN4qy7M9QrTnbddh2DJgMtYBWj1yYsQI0=;
	b=nBFNE2dQpg3/aXjiUaLCrjjwg6NTgO4Cc2OayKRhIGdIB6UZwY0UBHKXvE2tO7aMQjo+XP
	rkFPgfDT1ly1OfCl8PpPqyH8Oz2kgsmGtEyytHr6x8pIh0Mx6SvkI4bzgh/6zZtQtc6hBe
	VvYIMJ2KqGltXtWrlZIGkDfIKO81nAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732690937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7RlmuC5WUFWN4qy7M9QrTnbddh2DJgMtYBWj1yYsQI0=;
	b=lb76Io7IbouD/TOF97Y6DKoOhdwyP0hgzCUJY+go+cleSBbE41hNhY3tiX37FBp6lSFvuT
	otkj/POecA907cDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nBFNE2dQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lb76Io7I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732690937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7RlmuC5WUFWN4qy7M9QrTnbddh2DJgMtYBWj1yYsQI0=;
	b=nBFNE2dQpg3/aXjiUaLCrjjwg6NTgO4Cc2OayKRhIGdIB6UZwY0UBHKXvE2tO7aMQjo+XP
	rkFPgfDT1ly1OfCl8PpPqyH8Oz2kgsmGtEyytHr6x8pIh0Mx6SvkI4bzgh/6zZtQtc6hBe
	VvYIMJ2KqGltXtWrlZIGkDfIKO81nAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732690937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7RlmuC5WUFWN4qy7M9QrTnbddh2DJgMtYBWj1yYsQI0=;
	b=lb76Io7IbouD/TOF97Y6DKoOhdwyP0hgzCUJY+go+cleSBbE41hNhY3tiX37FBp6lSFvuT
	otkj/POecA907cDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98E8213941;
	Wed, 27 Nov 2024 07:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hm4IJPnDRmcEEQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 Nov 2024 07:02:17 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: midi2: Fix interpretation of is_midi1 bits
Date: Wed, 27 Nov 2024 08:02:11 +0100
Message-ID: <20241127070213.8232-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF7F921170
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The UMP Function Block info m1.0 field (represented by is_midi1 sysfs
entry) is an enumeration from 0 to 2, while the midi2 gadget driver
incorrectly copies it to the corresponding snd_ump_block_info.flags
bits as-is.  This made the wrong bit flags set when m1.0 = 2.

This patch corrects the wrong interpretation of is_midi1 bits.

Fixes: 29ee7a4dddd5 ("usb: gadget: midi2: Add configfs support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/f_midi2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 8285df9ed6fd..8c9d0074db58 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1593,7 +1593,11 @@ static int f_midi2_create_card(struct f_midi2 *midi2)
 			fb->info.midi_ci_version = b->midi_ci_version;
 			fb->info.ui_hint = reverse_dir(b->ui_hint);
 			fb->info.sysex8_streams = b->sysex8_streams;
-			fb->info.flags |= b->is_midi1;
+			if (b->is_midi1 < 2)
+				fb->info.flags |= b->is_midi1;
+			else
+				fb->info.flags |= SNDRV_UMP_BLOCK_IS_MIDI1 |
+					SNDRV_UMP_BLOCK_IS_LOWSPEED;
 			strscpy(fb->info.name, ump_fb_name(b),
 				sizeof(fb->info.name));
 		}
-- 
2.43.0


