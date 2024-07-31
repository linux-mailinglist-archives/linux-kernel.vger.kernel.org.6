Return-Path: <linux-kernel+bounces-269217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E74942F62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A69284FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476071B374F;
	Wed, 31 Jul 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZFTqNLc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Sy80TGD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZFTqNLc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Sy80TGD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B11B0127;
	Wed, 31 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430351; cv=none; b=IXer7VcfiEoNxGfYiU51qbWSeiCwB8EolhIiVSlX8NHYFnP8w4hWDZ/OhpquxjsWD8jZ6KLnAtybK6oS/ydVZbqL3nTMwp0nNtW3/6lDIm1GtmabCTDf6ArBXvPa3u6eOIgOgHtvsIaOQq0987DWZPNl6NGGWFOfW9NJ6tzY9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430351; c=relaxed/simple;
	bh=UhSHaC5781NiSFWgFHpkh00rePUIc1gcl6ytzGJhJ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5IGPVLEO5YABaKTm8fZzX5bI2lVVJ+7zbQNlWUQZG3Z1KXud2ynvoXs3JDF6pbncyFW+X0ARf8M+hd7Ek8TB2Ee3LR2oxHUCriD/hmacq8zQ1ziOK5WgjGNHYrmh5IVL6kcSMoA3PWrn/d9Imfyv1FhfMB8Uj/xR12or0HnrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZFTqNLc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Sy80TGD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZFTqNLc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Sy80TGD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3841F840;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlP/ZFCXOFkiIboAWN8+7O7xJ2U5dX/bxVwzuNygI/g=;
	b=2ZFTqNLcTGHoXmKWgMDBAxKRLnQTIrBiLzrPffMDloztNgikpeOxpNEcHoH5DkH/mHVhC/
	HcGst+4KQ3ETVZZS3K7lFjfGj8F1nbtN7ITefEvD5FbRCo+k2HAK6T/x3OGDEMdvJkOc1G
	r1C/Cu2mVMxmrbm3cfA2qr7J3rAHaBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlP/ZFCXOFkiIboAWN8+7O7xJ2U5dX/bxVwzuNygI/g=;
	b=0Sy80TGDK9q0yJoiGVg7eqrZ+FNyiB12CeWA1w9IWIcO6g9Vyh0/26urBmlK2C+bWmANSm
	xqQZX4hP+QLwwoBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2ZFTqNLc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Sy80TGD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlP/ZFCXOFkiIboAWN8+7O7xJ2U5dX/bxVwzuNygI/g=;
	b=2ZFTqNLcTGHoXmKWgMDBAxKRLnQTIrBiLzrPffMDloztNgikpeOxpNEcHoH5DkH/mHVhC/
	HcGst+4KQ3ETVZZS3K7lFjfGj8F1nbtN7ITefEvD5FbRCo+k2HAK6T/x3OGDEMdvJkOc1G
	r1C/Cu2mVMxmrbm3cfA2qr7J3rAHaBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlP/ZFCXOFkiIboAWN8+7O7xJ2U5dX/bxVwzuNygI/g=;
	b=0Sy80TGDK9q0yJoiGVg7eqrZ+FNyiB12CeWA1w9IWIcO6g9Vyh0/26urBmlK2C+bWmANSm
	xqQZX4hP+QLwwoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0603E13AD8;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KNM2AIozqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 05/10] platform/x86: eeepc-laptop: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:55 +0200
Message-ID: <20240731125220.1147348-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731125220.1147348-1-tzimmermann@suse.de>
References: <20240731125220.1147348-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com,ljones.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,intel.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 3A3841F840
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/eeepc-laptop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 447364bed249..03319a80e114 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/backlight.h>
-#include <linux/fb.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/slab.h>
@@ -1137,7 +1136,7 @@ static int eeepc_backlight_init(struct eeepc_laptop *eeepc)
 	}
 	eeepc->backlight_device = bd;
 	bd->props.brightness = read_brightness(bd);
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(bd);
 	return 0;
 }
-- 
2.45.2


