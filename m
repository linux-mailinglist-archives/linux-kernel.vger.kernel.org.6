Return-Path: <linux-kernel+bounces-269215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E2942F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F7EB212B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912381B29C2;
	Wed, 31 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUa06B68";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZx7Jqj6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUa06B68";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZx7Jqj6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0131EB36;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430349; cv=none; b=nKgIvDRUmV9EA9B2DSpR8LduI3RoBsZpjZtNaS7uci5c4MJsvMesp6GoTqUE1KFk9yiWiNHXjI1vBTxAfxBZa5OvdoR3srazr+EXCheebmxwL4CXmFikQVQ/P5Cy78NLOel0jMtwSpp+9eF48l6bV1ri2dxW0XqNZIH6DfHsNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430349; c=relaxed/simple;
	bh=PokQl5XPxaOIJBEsp/c0pT7ZRUdcsXb7+YUuEcyeCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEDM26I4Hf5WHmsyo5GNSdnTH8PuBNOwkktuaeDQv9ZYBy4c4QD0d58wyJRkmocGFXVlNdvUJcDzJ8u1GcETgMrB1ELOZObi7wAPwO0dOoeJrn7n2Jxu1KF9xRuZBZsngNKm5a1nuyfizMn3I9LCHqdKtqvamAwXA9Mop2FN+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUa06B68; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZx7Jqj6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUa06B68; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZx7Jqj6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7884921AA8;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NW1bKh8Pj9QK8QeM3EWnuOi+JRgFVluEIBDWmCdhTE=;
	b=NUa06B68K+D9KxpqIjmNdP34DOBoDfc3B9cUtamSW8LBARPjOazJ/ngDAh7tRQNcUguA+b
	mv51be0FZZzDfMdB25xDBFsmYiqiB7bUOkjBw8txcMc9OReBPaeSPv6SFvALeXTnsbjIDA
	xK9g4rGYM3RDbjV0CYLDGLzbXt/fAng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NW1bKh8Pj9QK8QeM3EWnuOi+JRgFVluEIBDWmCdhTE=;
	b=QZx7Jqj6NyWtT2Bvj6TgbRa2sXF1uWT33Vbnme3AFWY0V1/07FHMBZtVpkpG9ZTBuVFxDV
	IloFOpDUd2KYStBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NW1bKh8Pj9QK8QeM3EWnuOi+JRgFVluEIBDWmCdhTE=;
	b=NUa06B68K+D9KxpqIjmNdP34DOBoDfc3B9cUtamSW8LBARPjOazJ/ngDAh7tRQNcUguA+b
	mv51be0FZZzDfMdB25xDBFsmYiqiB7bUOkjBw8txcMc9OReBPaeSPv6SFvALeXTnsbjIDA
	xK9g4rGYM3RDbjV0CYLDGLzbXt/fAng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NW1bKh8Pj9QK8QeM3EWnuOi+JRgFVluEIBDWmCdhTE=;
	b=QZx7Jqj6NyWtT2Bvj6TgbRa2sXF1uWT33Vbnme3AFWY0V1/07FHMBZtVpkpG9ZTBuVFxDV
	IloFOpDUd2KYStBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4093B13297;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKlmDokzqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 02/10] platform/x86: asus-laptop: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:52 +0200
Message-ID: <20240731125220.1147348-3-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com,ljones.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.60

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-laptop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index ccb33d034e2a..9d7e6b712abf 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -28,7 +28,6 @@
 #include <linux/err.h>
 #include <linux/proc_fs.h>
 #include <linux/backlight.h>
-#include <linux/fb.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
@@ -818,7 +817,7 @@ static int asus_backlight_init(struct asus_laptop *asus)
 
 	asus->backlight_device = bd;
 	bd->props.brightness = asus_read_brightness(bd);
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(bd);
 	return 0;
 }
-- 
2.45.2


