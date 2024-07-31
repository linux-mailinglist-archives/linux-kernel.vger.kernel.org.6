Return-Path: <linux-kernel+bounces-269214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA5942F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9B81C238D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8C1B29AE;
	Wed, 31 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTpJjOK6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P8lm4ZGY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTpJjOK6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P8lm4ZGY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F51B143B;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430349; cv=none; b=T9RN+/ZQwen/hs8avNUrj+yH5uqHNsa2P0dnJkK6RCs41PEgB9nriOXXEAhUyY1S9TOYp0iQZvPFKAtfTqaO5phHcrLDLWYKD8RUJuTh0FQRUp+32j2HWRYWJlUPsbrrVizgRXuGTUKLpfTWO8q/WHx279xJjKKVjWbF9j9oIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430349; c=relaxed/simple;
	bh=3sprWo5PLLLBC1DmizsUiKGYzESy7qKO2V6j4+lhcQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlXpkdPInpp0NxqvJg1OOCYv11Wk2a9uLKdhVDJJTuhuY82bZ51yfIDl4ybr2zc10pHzDf1KVSMPvnhTi1KtlXPsRR1hL7+IxPiScmhtqbZiV2JeB03SR/2piXAt/mlMG+K9LgAy8eFhiQsIa7+K7wJAzVEWbc1cmz3GKw25WHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTpJjOK6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P8lm4ZGY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTpJjOK6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P8lm4ZGY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B72E21F833;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXwza+8UyFrONHHMLRuZEHjhjmBqC8saf1oKEiib1ew=;
	b=sTpJjOK6ILGQu8bhckPk1fH34s7jI3R/zKjvD/7MuBtCxlYXmpzN37QJ9AKKp5q/xicvvg
	8ZzWA/B7oYLt5OKRMy5NX1i1YlmYptydC+0es1061r/4Llm9G8vZzg9X5mHDKo7Z13Ycvd
	1RCOQebtS8nFFWgdXP/8ULyU0wOwE2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXwza+8UyFrONHHMLRuZEHjhjmBqC8saf1oKEiib1ew=;
	b=P8lm4ZGYEXtMxR2P07ZJ1AjsZ/Mx+Oj0bToIyeRggPTia2sCkgACIZUtFogSRI1m8VNjWJ
	vSkpl0ii7275R/BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXwza+8UyFrONHHMLRuZEHjhjmBqC8saf1oKEiib1ew=;
	b=sTpJjOK6ILGQu8bhckPk1fH34s7jI3R/zKjvD/7MuBtCxlYXmpzN37QJ9AKKp5q/xicvvg
	8ZzWA/B7oYLt5OKRMy5NX1i1YlmYptydC+0es1061r/4Llm9G8vZzg9X5mHDKo7Z13Ycvd
	1RCOQebtS8nFFWgdXP/8ULyU0wOwE2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXwza+8UyFrONHHMLRuZEHjhjmBqC8saf1oKEiib1ew=;
	b=P8lm4ZGYEXtMxR2P07ZJ1AjsZ/Mx+Oj0bToIyeRggPTia2sCkgACIZUtFogSRI1m8VNjWJ
	vSkpl0ii7275R/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EB2913AD8;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMaXHYkzqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 03/10] platform/x86: asus-nb-wmi: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:53 +0200
Message-ID: <20240731125220.1147348-4-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com,ljones.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
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
 drivers/platform/x86/asus-nb-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fceffe2082ec..e20e241bda98 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -7,12 +7,12 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/backlight.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
-#include <linux/fb.h>
 #include <linux/dmi.h>
 #include <linux/i8042.h>
 
@@ -525,7 +525,7 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 	dmi_check_system(asus_quirks);
 
 	driver->quirks = quirks;
-	driver->panel_power = FB_BLANK_UNBLANK;
+	driver->panel_power = BACKLIGHT_POWER_ON;
 
 	/* overwrite the wapf setting if the wapf paramater is specified */
 	if (wapf != -1)
-- 
2.45.2


