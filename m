Return-Path: <linux-kernel+bounces-444583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268239F0910
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5181697CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C11B415A;
	Fri, 13 Dec 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S90kxGFa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C/a+/jBB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S90kxGFa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C/a+/jBB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFF1B413D;
	Fri, 13 Dec 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084423; cv=none; b=ho2iPsz8CYWwvPOXe8td7q76QorZp72jwLopPfoMpWO0DZe7ginT4otU1ZSBR1GOycLmn5F4UAwUX1MYVbe/VbP7VzBxa4E9MUGf/XGjxmwLJtH2ajNP4swKNLY2aWPx1tvoVHl2ycfhCJ+fxwlr78LCb8KVvKB0kaf0Hm7e3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084423; c=relaxed/simple;
	bh=AwluwYoEo/LWU8DX/RRlt7eMziioOGAKxa3KLRsfQAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRslYV7zEFZoq8unTOIm4/r/hpwOleagwFOanC99M4eG2NZsJW80n4cSApHtOy3OUPO8XmYBESUia+6WJB24sgWFlRwYtVGhahpYu+e27rbbl6Ump3Me1lBzGeeuZrgtD4P6pMbFU/9KQCWzV/6slquTfqgmefgdAwomD3bawSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S90kxGFa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C/a+/jBB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S90kxGFa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C/a+/jBB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94ED71F450;
	Fri, 13 Dec 2024 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734084418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8QDugiJ/KSY9yKmQ+pVAhnv9kYxVPDhuH0MdQod650=;
	b=S90kxGFap8fiYclSa40tV3TsR+uTRfWfmld7jcT+QKsJcwUgvuLUnTNaoeeV0duHW5pQfZ
	9CtFSps6I3Tw0wkLDc7B2AOkBPH8ZGWRT2rgWnjTRKXiLzRLcsihDguq/DZ80uUZJA5vTI
	d/zNNhZxsRxJUVACwM/okpBkNHd1p7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734084418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8QDugiJ/KSY9yKmQ+pVAhnv9kYxVPDhuH0MdQod650=;
	b=C/a+/jBB5/0DfQc3jmKn1/ecu7CulK2OL4sE/k441ZqKr0iF79uX8+6y392zem6dNzpH5y
	9rqOjfOPGpgHBCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734084418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8QDugiJ/KSY9yKmQ+pVAhnv9kYxVPDhuH0MdQod650=;
	b=S90kxGFap8fiYclSa40tV3TsR+uTRfWfmld7jcT+QKsJcwUgvuLUnTNaoeeV0duHW5pQfZ
	9CtFSps6I3Tw0wkLDc7B2AOkBPH8ZGWRT2rgWnjTRKXiLzRLcsihDguq/DZ80uUZJA5vTI
	d/zNNhZxsRxJUVACwM/okpBkNHd1p7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734084418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=z8QDugiJ/KSY9yKmQ+pVAhnv9kYxVPDhuH0MdQod650=;
	b=C/a+/jBB5/0DfQc3jmKn1/ecu7CulK2OL4sE/k441ZqKr0iF79uX8+6y392zem6dNzpH5y
	9rqOjfOPGpgHBCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5654F137CF;
	Fri, 13 Dec 2024 10:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qm0GE0IHXGfpQgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 13 Dec 2024 10:06:58 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] platform/x86: dell-uart-backlight: Use blacklight power constant
Date: Fri, 13 Dec 2024 11:05:51 +0100
Message-ID: <20241213100647.200598-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.1
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The backlight subsystem has gotten its own power constants. Replace
FB_BLANK_UNBLANK with BACKLIGHT_POWER_ON.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index 6e5dc7e3674f..b1003c170ca1 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -159,7 +159,7 @@ static int dell_uart_set_bl_power(struct dell_uart_backlight *dell_bl, int power
 
 	set_power[0] = DELL_SOF(SET_CMD_LEN);
 	set_power[1] = CMD_SET_BL_POWER;
-	set_power[2] = (power == FB_BLANK_UNBLANK) ? 1 : 0;
+	set_power[2] = (power == BACKLIGHT_POWER_ON) ? 1 : 0;
 	set_power[3] = dell_uart_checksum(set_power, 3);
 
 	ret = dell_uart_bl_command(dell_bl, set_power, SET_CMD_LEN, resp, SET_RESP_LEN);
-- 
2.47.1


