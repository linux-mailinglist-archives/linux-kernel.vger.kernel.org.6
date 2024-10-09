Return-Path: <linux-kernel+bounces-356389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B4996055
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE6282349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41CF17BB0C;
	Wed,  9 Oct 2024 07:09:54 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326317A584;
	Wed,  9 Oct 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457794; cv=none; b=ThsRtcNAdpVBAOKCEAcx75AHG53oLU2kWAYuhhT2YWwbiLQF6/DYR78kZ5DOlkA5arGVoRBb1Z6bty8I2PiVc/Aa6YcmfXEU2sg3m15hPH865b9MaluKlYl8f8/HAdodDlziCAU+r6LiinrwptFSRIhmXD4zhDNt23aqAVArWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457794; c=relaxed/simple;
	bh=GXhah2Tt/c9Sm5S7ElbdIJybcrICXCQMzokQtUOsYSY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KeTvc/r65UFxblMp8//TvbRp9igskOYnpvFg1A8PQ2NoxBufV5JcFx7Ko9w7CYuRZvJNWHWlMQ8S3qtmI+57OHz4pEwJK799+4S+HzKa3i3Li9kdp4Extm/G8Kx70rfi2ksQxQxZ12sgxAh4Tp3JlSVTYgtqNORahGFYvi1g0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee567062c39dac-eadb9;
	Wed, 09 Oct 2024 15:09:49 +0800 (CST)
X-RM-TRANSID:2ee567062c39dac-eadb9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee267062c39593-e4770;
	Wed, 09 Oct 2024 15:09:48 +0800 (CST)
X-RM-TRANSID:2ee267062c39593-e4770
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	kl@kl.wtf,
	zhujun2@cmss.chinamobile.com,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Use snprintf instead of sprintf in build_mixer_unit_ctl
Date: Wed,  9 Oct 2024 00:09:44 -0700
Message-Id: <20241009070944.6937-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Simplified code by removing redundant assignment of sprintf return value
and improved safety by replacing sprintf with snprintf.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9945ae55b0d0..b6c3d2ee416e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2224,7 +2224,8 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 		len = get_term_name(state->chip, iterm, kctl->id.name,
 				    sizeof(kctl->id.name), 0);
 	if (!len)
-		len = sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
+		snprintf(kctl->id.name, sizeof(kctl->id.name), "Mixer Source %d", in_ch + 1);
+
 	append_ctl_name(kctl, " Volume");
 
 	usb_audio_dbg(state->chip, "[%d] MU [%s] ch = %d, val = %d/%d\n",
-- 
2.17.1




