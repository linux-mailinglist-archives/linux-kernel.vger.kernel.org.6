Return-Path: <linux-kernel+bounces-269220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0E942F67
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C110D1F2C45A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F931BE244;
	Wed, 31 Jul 2024 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s1GItmfr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="36rhW0kG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a14SWDtC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u6CXRY4+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614A1B29D8;
	Wed, 31 Jul 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430354; cv=none; b=HGgh6aMn/s9ge0UV0Jm0soHVL77iMzFKvBKyYY6jDsi/cRU/9xRrYdSnFcNbZm9jzZlWZgV/FZilTQxjM9jkLCRpBGaq89u4VpbbooPeko9zQlIgZJqmH95VMuqriHQ1gf6uVYHTROyESRjt6jCuc6OTypFVTmj1CSAhKEsn0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430354; c=relaxed/simple;
	bh=bH3ylJcdtyYRK9glPloVDBV3LmVwKvy7Npprsi3adOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoVnrccZbO9FYZsF/Lzactw3hpiyURW+YpZxlZPiqg3mZxLCsPyoIIpVnknRU8watO73C1DsdccVE8DTN0yam9XCEPpEIt+HBxSPffxk1+QpZgZRIRYdQYRqpa5Fj9WXe7Jy9JCdSEGiKIiIWpxtcgAlZ9v7AyPNp1pHsKAfaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=s1GItmfr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=36rhW0kG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a14SWDtC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u6CXRY4+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3BA91F842;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr4kNUHbHzQ5DNSNEJzaf/1/iyjztVySrxxNivspKc0=;
	b=s1GItmfr7WZYPGtvefrFJ/vQCcngCjydFmtUuFFRBkDxsFcsc9bprREIn3NKa/D1hcZxI4
	gjpRZ6kDzv6oMQ+tJHnuLw80w/4z3XZxA8NxLtiA+dY/oXUwEBA3SSoAkshoIeV5bVFBZD
	GZzSOQF2ammwoXIDYOsqTeeBeHGOqBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr4kNUHbHzQ5DNSNEJzaf/1/iyjztVySrxxNivspKc0=;
	b=36rhW0kGAlwG1akHlPEx2cMhRj+gpa4vcKADlWaKm8fX4BYCJyaqrc+HTFPb0gIl2pw/t+
	MJ8J0Rm8wI1MjkDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr4kNUHbHzQ5DNSNEJzaf/1/iyjztVySrxxNivspKc0=;
	b=a14SWDtCqB5uYiELrtmKsQ4yIpK9XEkdlAs2lUiY4IDLTSYWmv9pEmZX6JzcX3WAKwUmRk
	tv0K699aDUvJMRY2rqERV1mV08iiVgKklECldM+qyTwptDFIbJUxX4npHXGjQlZM+eJp/l
	ZDk66ehpTJ3sw7qRr2bZWTdD0izB+Qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr4kNUHbHzQ5DNSNEJzaf/1/iyjztVySrxxNivspKc0=;
	b=u6CXRY4+zywJgxZ+yBo1/SQR7qY/dLwqIhKF1YSOODpQ4xVT52Ur5DJ5dUNZHGbVIwGH1C
	E8nmeLEg1HHSFCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B453C13297;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Gu9KoozqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ike Panhc <ike.pan@canonical.com>
Subject: [PATCH 08/10] platform/x86: ideapad-laptop: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:58 +0200
Message-ID: <20240731125220.1147348-9-tzimmermann@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.10

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ike Panhc <ike.pan@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/ideapad-laptop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1ace711f7442..8270925db03f 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -17,7 +17,6 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
-#include <linux/fb.h>
 #include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -1256,7 +1255,7 @@ static int ideapad_backlight_update_status(struct backlight_device *blightdev)
 		return err;
 
 	err = write_ec_cmd(priv->adev->handle, VPCCMD_W_BL_POWER,
-			   blightdev->props.power != FB_BLANK_POWERDOWN);
+			   blightdev->props.power != BACKLIGHT_POWER_OFF);
 	if (err)
 		return err;
 
@@ -1306,7 +1305,7 @@ static int ideapad_backlight_init(struct ideapad_private *priv)
 
 	priv->blightdev = blightdev;
 	blightdev->props.brightness = now;
-	blightdev->props.power = power ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	blightdev->props.power = power ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
 
 	backlight_update_status(blightdev);
 
@@ -1330,7 +1329,7 @@ static void ideapad_backlight_notify_power(struct ideapad_private *priv)
 	if (read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &power))
 		return;
 
-	blightdev->props.power = power ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	blightdev->props.power = power ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
 }
 
 static void ideapad_backlight_notify_brightness(struct ideapad_private *priv)
-- 
2.45.2


