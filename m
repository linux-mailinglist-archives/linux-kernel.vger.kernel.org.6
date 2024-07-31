Return-Path: <linux-kernel+bounces-269216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DC942F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB46EB2184C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448121B29D5;
	Wed, 31 Jul 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mUVL5jW9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ganxhMy6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mUVL5jW9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ganxhMy6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB81AB52C;
	Wed, 31 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430350; cv=none; b=RZkpJedzGSRz9JGmbglwj3tZx33ndevck59UH0ldWYFjzptB1zhJURPvuRtOjEc0jEHdsDLnjxWVhzwXIKaj4Hvb9TAYJ3Sba0kI1AXMBM3JrAlI3rBkFhla84ISDy0bVKxnH7qIRb1uHBSHdzT+mYBB7xYaq8HO0jEzIjUQtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430350; c=relaxed/simple;
	bh=c4ILxJdkLC0JQH5MeBVWnWFSAdXuqGgPGgLdTY8FUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV5haTGEEtSLsOylC/0DTf3l+RHKmk/3azIJMTx7AsGADZd/lVak1eHE1gz/BZPggntGV0NRwoxt07g8sdV6MEZy99EE+Vq5vPEumdoLRUeXAl24xe5f3o+iHt+8JGvzFEjIbAjiZPyrWNOsCkX0LQd6ZwH9fEKwu0ISM4LvDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mUVL5jW9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ganxhMy6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mUVL5jW9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ganxhMy6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD47B21B39;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ECnNI3+l+HcwDq4ybBu67coDLy18mYG/8XZbu1qeY=;
	b=mUVL5jW9KigXBqThXHSgkCF/xNFte/hn/ETBJ9qcDDXFgs0pIlF03hN3/D2R2BxNU9ACAB
	dIBsGE2fkJmxFTUndUycXOoAdxsfbozKnHqMb6jfgn2BSiDfhLWQXlqdMIETXBn4N17QPq
	WDr2hVhUKQiIg3WIcZkmb/3Bth3cWps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ECnNI3+l+HcwDq4ybBu67coDLy18mYG/8XZbu1qeY=;
	b=ganxhMy6ZoRR2FG5R92rask7UFcINuOdgVfm8E98zrSKeKEe5CFtjC842qBM3K2ZuQ6zqD
	6iAgDgjwUR4x1TBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mUVL5jW9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ganxhMy6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ECnNI3+l+HcwDq4ybBu67coDLy18mYG/8XZbu1qeY=;
	b=mUVL5jW9KigXBqThXHSgkCF/xNFte/hn/ETBJ9qcDDXFgs0pIlF03hN3/D2R2BxNU9ACAB
	dIBsGE2fkJmxFTUndUycXOoAdxsfbozKnHqMb6jfgn2BSiDfhLWQXlqdMIETXBn4N17QPq
	WDr2hVhUKQiIg3WIcZkmb/3Bth3cWps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51ECnNI3+l+HcwDq4ybBu67coDLy18mYG/8XZbu1qeY=;
	b=ganxhMy6ZoRR2FG5R92rask7UFcINuOdgVfm8E98zrSKeKEe5CFtjC842qBM3K2ZuQ6zqD
	6iAgDgjwUR4x1TBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DDF513AD8;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJ9SHYozqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Woithe <jwoithe@just42.net>
Subject: [PATCH 07/10] platform/x86: fujitsu-laptop: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:57 +0200
Message-ID: <20240731125220.1147348-8-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: AD47B21B39
X-Spam-Score: -5.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	DKIM_TRACE(0.00)[suse.de:+]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jonathan Woithe <jwoithe@just42.net>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 968fc91bd5e4..ae992ac1ab4a 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -43,7 +43,6 @@
 #include <linux/bitops.h>
 #include <linux/dmi.h>
 #include <linux/backlight.h>
-#include <linux/fb.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/kfifo.h>
@@ -356,7 +355,7 @@ static int bl_get_brightness(struct backlight_device *b)
 {
 	struct acpi_device *device = bl_get_data(b);
 
-	return b->props.power == FB_BLANK_POWERDOWN ? 0 : get_lcd_level(device);
+	return b->props.power == BACKLIGHT_POWER_OFF ? 0 : get_lcd_level(device);
 }
 
 static int bl_update_status(struct backlight_device *b)
@@ -364,7 +363,7 @@ static int bl_update_status(struct backlight_device *b)
 	struct acpi_device *device = bl_get_data(b);
 
 	if (fext) {
-		if (b->props.power == FB_BLANK_POWERDOWN)
+		if (b->props.power == BACKLIGHT_POWER_OFF)
 			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
 				       BACKLIGHT_PARAM_POWER, BACKLIGHT_OFF);
 		else
@@ -933,9 +932,9 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
 				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
-			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
+			fujitsu_bl->bl_device->props.power = BACKLIGHT_POWER_OFF;
 		else
-			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
+			fujitsu_bl->bl_device->props.power = BACKLIGHT_POWER_ON;
 	}
 
 	ret = acpi_fujitsu_laptop_input_setup(device);
-- 
2.45.2


