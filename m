Return-Path: <linux-kernel+bounces-216910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580290A866
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D35B282ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067B18FDBE;
	Mon, 17 Jun 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hw+iaBtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QimoLRLy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Hw+iaBtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QimoLRLy"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04817F5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613039; cv=none; b=esKMAoKAEByTzYC4xqBpGWxCHfIGbhDKP8RBDYSQzYooRL/rTEPNeBu6/AR5F0EjksTZie1N0X2XiQmbq7ZQY9lKg8xvQhN5pGjVbeosIxoAjsL11tZyMmwZtDqc60zozlN8QG1yLoS77bIEpamy73sXDi3V2aDrab8K/G8+l/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613039; c=relaxed/simple;
	bh=1LNsmQc7NXUuFP/h48AkNN7eRiCkM9c96u25oB44mNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QS+IYzIpXNhE2o+1W0/I++P/H++aOfxxkBS+z6BJNEaK07Drqq9kefDzmbzO4vP8p/7dih0mWM5vOmoGrNSEt9uZBFiZWtBSylYEw5lM5ZmbtHFIuDrxtDrW1JoIgrLZ8VUL8qNjZEQVAZ9G6uO8K0lcxSntZ1cV+8k4RTacEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hw+iaBtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QimoLRLy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Hw+iaBtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QimoLRLy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3F9337EAD;
	Mon, 17 Jun 2024 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Md9g0asLDnj+AHyCYfJadRa5eb/PGecnuWMEsojTL4=;
	b=Hw+iaBtmpUSyZ+5FRiCE8llN/nruA0g2GE4O1JhGt1wT7booNI8+50VByEWVWSlLjOe2lb
	ZV969Fa56zm4wFGydI+4l9Ojl9wUJIZbM2tm2FKI7rMb96S0yI6cUm6b+HTS0QpDieofmB
	CFYAdqv1OxSx4mxojYRN5Ub3pB/OJO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Md9g0asLDnj+AHyCYfJadRa5eb/PGecnuWMEsojTL4=;
	b=QimoLRLyUT8HI/drFsV/cNjisBaAKcMsY9Xv4GYPL6th803/vgRpt9lokh2wjL2Yyml9Kc
	zxz9vr3rPfhnohAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Hw+iaBtm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QimoLRLy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718613035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Md9g0asLDnj+AHyCYfJadRa5eb/PGecnuWMEsojTL4=;
	b=Hw+iaBtmpUSyZ+5FRiCE8llN/nruA0g2GE4O1JhGt1wT7booNI8+50VByEWVWSlLjOe2lb
	ZV969Fa56zm4wFGydI+4l9Ojl9wUJIZbM2tm2FKI7rMb96S0yI6cUm6b+HTS0QpDieofmB
	CFYAdqv1OxSx4mxojYRN5Ub3pB/OJO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718613035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Md9g0asLDnj+AHyCYfJadRa5eb/PGecnuWMEsojTL4=;
	b=QimoLRLyUT8HI/drFsV/cNjisBaAKcMsY9Xv4GYPL6th803/vgRpt9lokh2wjL2Yyml9Kc
	zxz9vr3rPfhnohAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C0B8139AB;
	Mon, 17 Jun 2024 08:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +NITFyr0b2ZwYgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 17 Jun 2024 08:30:34 +0000
Date: Mon, 17 Jun 2024 10:30:30 +0200
From: Jean Delvare <jdelvare@suse.de>
To: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20240617103018.515f0bf1@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.65 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	BAYES_HAM(-1.14)[88.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,linux-foundation.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A3F9337EAD
X-Spam-Flag: NO
X-Spam-Score: -4.65
X-Spam-Level: 

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
Already sent on: 2022-11-21, 2023-01-27, 2023-12-02

This is one of the only 3 remaining occurrences of this deprecated
construct.

Who can pick this patch and get it upstream?

 drivers/gpu/drm/display/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.6.orig/drivers/gpu/drm/display/Kconfig
+++ linux-6.6/drivers/gpu/drm/display/Kconfig
@@ -3,7 +3,7 @@
 config DRM_DP_AUX_BUS
 	tristate
 	depends on DRM
-	depends on OF || COMPILE_TEST
+	depends on OF
 
 config DRM_DISPLAY_HELPER
 	tristate


-- 
Jean Delvare
SUSE L3 Support

