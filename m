Return-Path: <linux-kernel+bounces-269222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A682942F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147BD1C237BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD641BE875;
	Wed, 31 Jul 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ujy/MoQw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHuHDC9E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ujy/MoQw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHuHDC9E"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7D1B3748;
	Wed, 31 Jul 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430357; cv=none; b=Wg0iISSWnLwUE5C5jtSkTdRmzA2EVIzjeNDZiRN2+B7Kaj+csC4oJhHtD5Rdzdvi0ByHvnTvgnAseLPGEHwdeREWmYwKHdN88UzetePCeF947k6zInxIAnw/3yMY+y8BDV7QNwU2ax4C4ZkwjFTRgEovEcC7f3Ia4v1cz2O+j1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430357; c=relaxed/simple;
	bh=gecRab97xdIQjGLDS/dPk+7Td0sq611oMBXCRh5sflE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddsVuMDRWnq8tWLcP518fxeGk8BmjftiojhFlRK8mrHp7m68/IayTgdMhM1+rIt2OvNffzxe5QIOz0HN3Natm30sdsJkuEMqEMomZR/p9sx+SgoRTtugpsl9cgNgwPkIqvFHeZblIN9CZXZqrxA685P0zjJqm8ER499gK53AkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ujy/MoQw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHuHDC9E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ujy/MoQw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHuHDC9E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3C0621AEA;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPJSV2OiyVR33EaM00O4ZfycCar5OaIUtMqXpZ69k/I=;
	b=ujy/MoQwJFylg5zbPC/Jn+6ZkljjATaz+EhKX0PospAPge347NgXvYC3ZDq+obfkwddUbq
	jNm4UK+MEhlUirAdgerysijg/rmeDsP0qmbyBRWUJ8el+x0EZJG4/1DR1aqU0Z0eWjgR0w
	xbTZ95PIWVeJ1z5Wv3RQTxSdmxn8g+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPJSV2OiyVR33EaM00O4ZfycCar5OaIUtMqXpZ69k/I=;
	b=FHuHDC9ELs1jSYG1zYOU02amuqnRk1qI9AgBGZG1ivvKXfXIY6WAxw/eCwWJWAy6w/Svgd
	SYKevdGWFranHLBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ujy/MoQw";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FHuHDC9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPJSV2OiyVR33EaM00O4ZfycCar5OaIUtMqXpZ69k/I=;
	b=ujy/MoQwJFylg5zbPC/Jn+6ZkljjATaz+EhKX0PospAPge347NgXvYC3ZDq+obfkwddUbq
	jNm4UK+MEhlUirAdgerysijg/rmeDsP0qmbyBRWUJ8el+x0EZJG4/1DR1aqU0Z0eWjgR0w
	xbTZ95PIWVeJ1z5Wv3RQTxSdmxn8g+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPJSV2OiyVR33EaM00O4ZfycCar5OaIUtMqXpZ69k/I=;
	b=FHuHDC9ELs1jSYG1zYOU02amuqnRk1qI9AgBGZG1ivvKXfXIY6WAxw/eCwWJWAy6w/Svgd
	SYKevdGWFranHLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD96313297;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AAv/LIkzqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 04/10] platform/x86: asus-wmi: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:54 +0200
Message-ID: <20240731125220.1147348-5-tzimmermann@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F3C0621AEA
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc735931f97b..39fa651fc9a2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -18,7 +18,6 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
-#include <linux/fb.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
@@ -3860,7 +3859,7 @@ static int read_backlight_power(struct asus_wmi *asus)
 	if (ret < 0)
 		return ret;
 
-	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	return ret ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
 }
 
 static int read_brightness_max(struct asus_wmi *asus)
@@ -3919,7 +3918,7 @@ static int update_bl_status(struct backlight_device *bd)
 
 	power = read_backlight_power(asus);
 	if (power != -ENODEV && bd->props.power != power) {
-		ctrl_param = !!(bd->props.power == FB_BLANK_UNBLANK);
+		ctrl_param = !!(bd->props.power == BACKLIGHT_POWER_ON);
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT,
 					    ctrl_param, NULL);
 		if (asus->driver->quirks->store_backlight_power)
@@ -3978,7 +3977,7 @@ static int asus_wmi_backlight_init(struct asus_wmi *asus)
 
 	power = read_backlight_power(asus);
 	if (power == -ENODEV)
-		power = FB_BLANK_UNBLANK;
+		power = BACKLIGHT_POWER_ON;
 	else if (power < 0)
 		return power;
 
@@ -4036,7 +4035,7 @@ static int read_screenpad_backlight_power(struct asus_wmi *asus)
 	if (ret < 0)
 		return ret;
 	/* 1 == powered */
-	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	return ret ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
 }
 
 static int read_screenpad_brightness(struct backlight_device *bd)
@@ -4049,7 +4048,7 @@ static int read_screenpad_brightness(struct backlight_device *bd)
 	if (err < 0)
 		return err;
 	/* The device brightness can only be read if powered, so return stored */
-	if (err == FB_BLANK_POWERDOWN)
+	if (err == BACKLIGHT_POWER_OFF)
 		return asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
 
 	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
@@ -4070,7 +4069,7 @@ static int update_screenpad_bl_status(struct backlight_device *bd)
 		return power;
 
 	if (bd->props.power != power) {
-		if (power != FB_BLANK_UNBLANK) {
+		if (power != BACKLIGHT_POWER_ON) {
 			/* Only brightness > 0 can power it back on */
 			ctrl_param = asus->driver->screenpad_brightness - ASUS_SCREENPAD_BRIGHT_MIN;
 			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
@@ -4078,7 +4077,7 @@ static int update_screenpad_bl_status(struct backlight_device *bd)
 		} else {
 			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
 		}
-	} else if (power == FB_BLANK_UNBLANK) {
+	} else if (power == BACKLIGHT_POWER_ON) {
 		/* Only set brightness if powered on or we get invalid/unsync state */
 		ctrl_param = bd->props.brightness + ASUS_SCREENPAD_BRIGHT_MIN;
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
@@ -4108,7 +4107,7 @@ static int asus_screenpad_init(struct asus_wmi *asus)
 	if (power < 0)
 		return power;
 
-	if (power != FB_BLANK_POWERDOWN) {
+	if (power != BACKLIGHT_POWER_OFF) {
 		err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
 		if (err < 0)
 			return err;
-- 
2.45.2


