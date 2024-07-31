Return-Path: <linux-kernel+bounces-269224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABA942F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA63D287CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4219E1B3F22;
	Wed, 31 Jul 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eUC/vWOH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5mxWDkk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eUC/vWOH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T5mxWDkk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FE1B3F16;
	Wed, 31 Jul 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430363; cv=none; b=bR7DnLLz3DNxDnl2rTv8wlYWZvBe0r+YME3yWxQ86TZZX4kdFaF5Q0FSMlR4t6Gj3ycII3glqxcibzLvtUxpSR3nkSJkqXrMoLwbcpDAn8q1kcIKvDbzTxR4xe6FD2p6E57LTHpr7s3GTjumLvLoBaAusfeZ7lipaiA+w3ujcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430363; c=relaxed/simple;
	bh=vfNHS5PHcSuxuJHkQW+2q1CH48UuXmX98oPYHSQnyU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGorEp1F7bymOPnw8t3/e+hYXH3zSk1J6WLS+sVonQ7IG8FXowKSgJYGYNV5TteQZ9zQV90m/DwvRc4JnbFWLkteK/b2YaYVq9vXV9iTvRdq5imsOYzhcrH0tM34Qsty3DllRSQI6Ei15kyEJFFGz4x+OI6uQr2/o81WyczMxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eUC/vWOH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5mxWDkk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eUC/vWOH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T5mxWDkk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7471F843;
	Wed, 31 Jul 2024 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDH8nnmcEGhDe5szori77w5r0bZHcPyn19ZUySO+pcs=;
	b=eUC/vWOH0PQPfsg4A+cMyK9jB/jHP70OZC+qEmbPQQnd+kqdahPG8r0jrAH2xONd4dqQT1
	o0UEYlYJbbysMrMkGm7JRUpqp5ZSPHW3CTTWK9owbbltvPN4Zv0iwb1ifAJd2JzqiBATNx
	XQa+tk/1MUyycPr9J38Ep24aRwqUR3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDH8nnmcEGhDe5szori77w5r0bZHcPyn19ZUySO+pcs=;
	b=T5mxWDkkDMICMV6h+mnVHVEg0+sYjk4Z2ZLHMxF2Yu4Jf6YHwzNKQH9YCd3Q7Sm7lUvK+K
	/tzzsxONajNlocBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="eUC/vWOH";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T5mxWDkk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDH8nnmcEGhDe5szori77w5r0bZHcPyn19ZUySO+pcs=;
	b=eUC/vWOH0PQPfsg4A+cMyK9jB/jHP70OZC+qEmbPQQnd+kqdahPG8r0jrAH2xONd4dqQT1
	o0UEYlYJbbysMrMkGm7JRUpqp5ZSPHW3CTTWK9owbbltvPN4Zv0iwb1ifAJd2JzqiBATNx
	XQa+tk/1MUyycPr9J38Ep24aRwqUR3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDH8nnmcEGhDe5szori77w5r0bZHcPyn19ZUySO+pcs=;
	b=T5mxWDkkDMICMV6h+mnVHVEg0+sYjk4Z2ZLHMxF2Yu4Jf6YHwzNKQH9YCd3Q7Sm7lUvK+K
	/tzzsxONajNlocBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA8D813AD8;
	Wed, 31 Jul 2024 12:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EIgCOIozqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/10] platform/x86: oaktrail: Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:59 +0200
Message-ID: <20240731125220.1147348-10-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 2C7471F843
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email,suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/oaktrail.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/oaktrail.c b/drivers/platform/x86/intel/oaktrail.c
index 217630f40c3f..265cef327b4f 100644
--- a/drivers/platform/x86/intel/oaktrail.c
+++ b/drivers/platform/x86/intel/oaktrail.c
@@ -28,7 +28,6 @@
 #include <linux/backlight.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
-#include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -250,7 +249,7 @@ static int oaktrail_backlight_init(void)
 	oaktrail_bl_device = bd;
 
 	bd->props.brightness = get_backlight_brightness(bd);
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(bd);
 
 	return 0;
-- 
2.45.2


