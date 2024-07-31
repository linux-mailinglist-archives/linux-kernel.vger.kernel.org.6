Return-Path: <linux-kernel+bounces-269218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAF942F63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCED1C23A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC61B3F01;
	Wed, 31 Jul 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cmVLZ+Y2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XiAVsI5B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cmVLZ+Y2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XiAVsI5B"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16B1AE871;
	Wed, 31 Jul 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430351; cv=none; b=HAQnRPUtHfCmzGDO2pzt33/Moevb7OmEaNiKZvBkJyVQl+WhjWtsemWBNQiIp82RhLjIXQz/b20iylyUxM2lkOn1irb5QVsKUqr4A/yhzBI75ee9ji8Ga/k8++6BxbV0RemL4mYtNZsQtZVl5BTtR50erQJS21eesIEZHzM3jKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430351; c=relaxed/simple;
	bh=DgbWxqmnBXEzBmqKi2gftEds/huIZ6OxoeUCH93UYNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saHxSM0EfZL2LPzTUn7e0yM377y1yLjM6ZbtkBQvATNiDtw1KvTOg7LYM2Fg/PwnRvtOLGfyKDlRt79vhwa+dxNQypIw8iAqN9lceoqzPswfvWzIuQsuMcmbWF4TlQ+A/r5XfOE/xkEaPaxJa51TKV5gdeEChmMFinFbP9bA4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cmVLZ+Y2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XiAVsI5B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cmVLZ+Y2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XiAVsI5B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46EAF1F82F;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFvgYG/vl6QJ5OWWiFKDnv9Tc/EKs1VY/3kOXuUzDU=;
	b=cmVLZ+Y27uZQ0FyqE/pujUE3/7Tq3DAZ2GP9gIKYteb1YzXpkWzLJFhIwDhTrAcTJsRpZ4
	XHtnlebGqa7IbWKfoiXp7g2xQp9yHJJA9g8LmPlvbM1FglV/E3fDL1UXfTw8BiHg1nNAA3
	jAb5zHyRie7KJo416TUOW8Pu+yBqpGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFvgYG/vl6QJ5OWWiFKDnv9Tc/EKs1VY/3kOXuUzDU=;
	b=XiAVsI5B4aIcnhJbVZ96nlyuYV2qVNseE7kqYJOHyPh/2hjivWufdke6lQjin0innD6VJU
	64c7daeuQJBlF7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722430345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFvgYG/vl6QJ5OWWiFKDnv9Tc/EKs1VY/3kOXuUzDU=;
	b=cmVLZ+Y27uZQ0FyqE/pujUE3/7Tq3DAZ2GP9gIKYteb1YzXpkWzLJFhIwDhTrAcTJsRpZ4
	XHtnlebGqa7IbWKfoiXp7g2xQp9yHJJA9g8LmPlvbM1FglV/E3fDL1UXfTw8BiHg1nNAA3
	jAb5zHyRie7KJo416TUOW8Pu+yBqpGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722430345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiFvgYG/vl6QJ5OWWiFKDnv9Tc/EKs1VY/3kOXuUzDU=;
	b=XiAVsI5B4aIcnhJbVZ96nlyuYV2qVNseE7kqYJOHyPh/2hjivWufdke6lQjin0innD6VJU
	64c7daeuQJBlF7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09A9D13AD8;
	Wed, 31 Jul 2024 12:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONgMAYkzqmYzVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 31 Jul 2024 12:52:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 01/10] platform/x86: acer-wmi:  Use backlight power constants
Date: Wed, 31 Jul 2024 14:50:51 +0200
Message-ID: <20240731125220.1147348-2-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

Replace FB_BLANK_ constants with their counterparts from the
backlight subsystem. The values are identical, so there's no
change in functionality or semantics.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/acer-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 38c932df6446..349169d050c5 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
@@ -1685,7 +1684,7 @@ static int acer_backlight_init(struct device *dev)
 
 	acer_backlight_device = bd;
 
-	bd->props.power = FB_BLANK_UNBLANK;
+	bd->props.power = BACKLIGHT_POWER_ON;
 	bd->props.brightness = read_brightness(bd);
 	backlight_update_status(bd);
 	return 0;
-- 
2.45.2


