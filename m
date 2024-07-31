Return-Path: <linux-kernel+bounces-269223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E5942F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5C91C23925
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC91BF30E;
	Wed, 31 Jul 2024 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HPXSd8eb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rcCvM3Ov";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HPXSd8eb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rcCvM3Ov"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E81B29B3;
	Wed, 31 Jul 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430360; cv=none; b=K9RD2SodO1DY6iYHayV6wbk8XuoBs2YgcRwrZEbAMvvgYEbLqvuSS9VRpGjdT6PJiwLxA9F9ZZ3nwV1H58uNoQIyR+3kNMyubdl5TLQttslaZX/q2gznURsmPm/06bVBG6N4vs1006FbhgbzHA9xCjNaepi35BIxVl2bHZJILME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430360; c=relaxed/simple;
	bh=ghIcj43pPmX/hrpOf6W2KGvuH1Kv6qQVduc+37OxUYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNPGgRHm9e2dbUVUWgzqPtz7ULer6goM/f6pSHvyZ/uPwWv3pYFF567u0ZcpXPydLXM/IiJi3btK/hITzUis8FnBsY36f+aVyLgRRGtFSCZp0MW8cXtQYRgNttE8eH6U+rM9GR1moQR8fN+yTLIR7sJX4boDozRqCJCtvGkX/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HPXSd8eb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rcCvM3Ov; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HPXSd8eb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rcCvM3Ov; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7617421B32;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B8vlYIUQ4JeRsr43JDhjtyxkNDxyQuUv2l0wh1KxQ8=;
	b=HPXSd8ebz020aZMYLWrJb6atB+L3w/LlP0zSPCFLw1LvLG/nsUKBRtOYgXrY2Mj6/kGj3E
	jwmbBen53RVjBxc541qT9i3BP9Aun4N3rxCwe8E1K7YR/H3T2OYyYk2+rdHi93/4r1kUuS
	bd3U1HPrj+3PIeywynXBCzrWwLeXsfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B8vlYIUQ4JeRsr43JDhjtyxkNDxyQuUv2l0wh1KxQ8=;
	b=rcCvM3Ovv6tUDzBjWdmu1CEDb2BTz6hvvyzlxEfweIzHqQdUsrpXJsRH4zLgbbBW3h6Evv
	rzPFGPzAA7OYDWAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HPXSd8eb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rcCvM3Ov
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B8vlYIUQ4JeRsr43JDhjtyxkNDxyQuUv2l0wh1KxQ8=;
	b=HPXSd8ebz020aZMYLWrJb6atB+L3w/LlP0zSPCFLw1LvLG/nsUKBRtOYgXrY2Mj6/kGj3E
	jwmbBen53RVjBxc541qT9i3BP9Aun4N3rxCwe8E1K7YR/H3T2OYyYk2+rdHi93/4r1kUuS
	bd3U1HPrj+3PIeywynXBCzrWwLeXsfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1B8vlYIUQ4JeRsr43JDhjtyxkNDxyQuUv2l0wh1KxQ8=;
	b=rcCvM3Ovv6tUDzBjWdmu1CEDb2BTz6hvvyzlxEfweIzHqQdUsrpXJsRH4zLgbbBW3h6Evv
	rzPFGPzAA7OYDWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 406BF13297;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wHJkDoozqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 06/10] platform/x86: eeepc-wmi: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:56 +0200
Message-ID: <20240731125220.1147348-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 7617421B32
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
 drivers/platform/x86/eeepc-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-wmi.c b/drivers/platform/x86/eeepc-wmi.c
index 32d9f0ba6be3..37edb9ae67b8 100644
--- a/drivers/platform/x86/eeepc-wmi.c
+++ b/drivers/platform/x86/eeepc-wmi.c
@@ -13,13 +13,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/backlight.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/dmi.h>
-#include <linux/fb.h>
 #include <linux/acpi.h>
 
 #include "asus-wmi.h"
@@ -192,7 +192,7 @@ static void eeepc_wmi_quirks(struct asus_wmi_driver *driver)
 
 	driver->quirks = quirks;
 	driver->quirks->wapf = -1;
-	driver->panel_power = FB_BLANK_UNBLANK;
+	driver->panel_power = BACKLIGHT_POWER_ON;
 }
 
 static struct asus_wmi_driver asus_wmi_driver = {
-- 
2.45.2


