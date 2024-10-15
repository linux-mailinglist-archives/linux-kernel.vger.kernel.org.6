Return-Path: <linux-kernel+bounces-365704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D825B99E6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981022857D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB251EABB9;
	Tue, 15 Oct 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ckihEln9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/yTipE7A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bjcLGGiD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xv9x39BY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4BA1A76DA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992773; cv=none; b=iimjwALrOsi/IW+000vfsjqE4Gu0NH3MnlYkXjE9J51YLMidYjsiJxgakmrKBY0e76FrPsmorNyqq0diUGSlp6wktrSX3ZxvLXDy9p2reUZh0+h9OtVYvWdK+/Sv0GVanOtGF8SPw2NHmELxjM7XdqZJucM3udPU7e3AgjT2bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992773; c=relaxed/simple;
	bh=/qnWkA0CvlIuHa/z4BVfrlavEzaOcZtS6b1CrscLaGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZzVvdDjhkk0vAjPFX8XrowZPkW4xiByMJlZyhwDCQvZ12in3aaosDpLG+TROVjvfqZVE6PBcIPUX5HMt1vxrty/ZXzPwtV8qzBuFAj1/3TxVWXoluJynUiy4j+ZBmikKudl38jZGNHNrvQNh+Bo6xIk2270JsjxqWpd4j97rP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ckihEln9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yTipE7A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bjcLGGiD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xv9x39BY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABACD21D71;
	Tue, 15 Oct 2024 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728992769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gfEBtmo4TCPrtgth6d1f69eciAkX+msz2/H6gdDKdQ4=;
	b=ckihEln9upHZuoEmtd1Tr6bHhjifQcsBBLfOexoNbR1M/Ip7GL6DwuvtJ5S5iAObAGGjYZ
	DX41497A5c8J53/vDtObkSzy19KEMstyCAEGOna+qm6BK3YBxwEtMp/J+A8KBRbXWo88WP
	35KffSO4tU0X2+L648yQHHpE7DE9A/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728992769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gfEBtmo4TCPrtgth6d1f69eciAkX+msz2/H6gdDKdQ4=;
	b=/yTipE7AplHdMvPbmNiznJVlkKFbhoDoqw8TeDGh8UNH5XUWBl4yrMdhsDL48jXaw0dmOK
	h/eEK3p2mHZEyZAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bjcLGGiD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xv9x39BY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728992768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gfEBtmo4TCPrtgth6d1f69eciAkX+msz2/H6gdDKdQ4=;
	b=bjcLGGiD5Uick0aoYDSOFZ2ccPqIbUJb7ZZhQie4zDNApiEZAbGh+F/4I8laP9Dllr2wC3
	65N6VYPKqD2LFO3r84kBSmoya5N9gsN6nAeLADlz3Eq3tyh/2jWbKRz2ikKTyQayc8urlM
	Rco4WG3YeGZFhd/FKRV1u9LM60KbYw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728992768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gfEBtmo4TCPrtgth6d1f69eciAkX+msz2/H6gdDKdQ4=;
	b=xv9x39BYf/ZDcCFUjIvS/25qx5OjMLMqLsck4ZirdtTxnT0fqOhbdeMVaj7+/6mUMC1vjt
	IDf0TOuQFROJ76Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A80E13A53;
	Tue, 15 Oct 2024 11:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1eY1EABWDmeUTwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Tue, 15 Oct 2024 11:46:08 +0000
Date: Tue, 15 Oct 2024 13:46:06 +0200
From: Jean Delvare <jdelvare@suse.de>
To: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard  
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
  <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Doug Anderson 
 <dianders@chromium.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3] drm/display: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20241015134606.5b87093e@endymion.delvare>
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
X-Rspamd-Queue-Id: ABACD21D71
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,chromium.org,huawei.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,endymion.delvare:mid,ffwll.ch:email,suse.de:dkim,suse.de:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

To avoid reintroducing the randconfig bug originally fixed by commit
876271118aa4 ("drm/display: Fix build error without CONFIG_OF"),
DRM_MSM which selects DRM_DISPLAY_DP_HELPER must explicitly depend
on OF. This is consistent with what all other DRM drivers are doing.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
For regular builds, this is a no-op, as OF is always enabled on
ARCH_QCOM and SOC_IMX5. So this change only affects test builds. As
explained before, allowing test builds only when OF is enabled
improves the quality of these test builds, as the result is then
closer to how the code is built on its intended targets.

Changes in v3:
* Rebase on top of kernel v6.11.
Changes in v2:
* Let DRM_MSM depend on OF so that random test builds won't break.

 drivers/gpu/drm/display/Kconfig |    2 +-
 drivers/gpu/drm/msm/Kconfig     |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-6.11.orig/drivers/gpu/drm/display/Kconfig
+++ linux-6.11/drivers/gpu/drm/display/Kconfig
@@ -3,7 +3,7 @@
 config DRM_DISPLAY_DP_AUX_BUS
 	tristate
 	depends on DRM
-	depends on OF || COMPILE_TEST
+	depends on OF
 
 config DRM_DISPLAY_HELPER
 	tristate
--- linux-6.11.orig/drivers/gpu/drm/msm/Kconfig
+++ linux-6.11/drivers/gpu/drm/msm/Kconfig
@@ -6,6 +6,7 @@ config DRM_MSM
 	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on IOMMU_SUPPORT
+	depends on OF
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	depends on QCOM_OCMEM || QCOM_OCMEM=n
 	depends on QCOM_LLCC || QCOM_LLCC=n


-- 
Jean Delvare
SUSE L3 Support

