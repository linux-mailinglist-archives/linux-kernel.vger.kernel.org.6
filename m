Return-Path: <linux-kernel+bounces-354441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF3993D7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD66282EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4BD43165;
	Tue,  8 Oct 2024 03:30:29 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D602C6AF;
	Tue,  8 Oct 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358229; cv=none; b=cJiKCFHaHyTKutlEPURLSxW/K4Y0h2Eh4dK1YfBBA4KrG62HWqStF506zP0MKi3/rHs1stK5863UnH5RPlSjHidJUpkUyb0LSoxKAsW4EqtBCvsuoLLv/DN12EeN8EzlcIbtZSxDtUYsfPM/ZNGbwxbzYwt8vFXH8gB3SRbIskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358229; c=relaxed/simple;
	bh=d997jFGxlGWOoY4LHGRUky9LqCDtC4czUFochV4TnUc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=geyI9bn523hhVN9ugyX+CtkK/A/xqwLQ8LUtAuTNW48v6MON8uxLxGbS4Qfy95k3XtzL/8ObwhI4pNzApDD6rGqJa+fqWYSJusG0f45FSq/3JBzi4HbG0UiE8lt+9NxOzQuSpb/cIi0UEmHTre3b11u9x11DpEuFUfP79Y/HRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76704a750c29-dfc31;
	Tue, 08 Oct 2024 11:30:24 +0800 (CST)
X-RM-TRANSID:2ee76704a750c29-dfc31
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86704a74e212-835e8;
	Tue, 08 Oct 2024 11:30:24 +0800 (CST)
X-RM-TRANSID:2ee86704a74e212-835e8
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	zhujun2@cmss.chinamobile.com,
	k.kosik@outlook.com,
	xristos.thes@gmail.com,
	wangdicheng@kylinos.cn,
	kl@kl.wtf,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Sound:mixer:Remove unnecessary assignment of sprintf result in build_mixer_unit_ctl
Date: Mon,  7 Oct 2024 20:30:22 -0700
Message-Id: <20241008033022.11280-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Simplified code by removing redundant assignment of sprintf return value

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9945ae55b0d0..dea6cbd65667 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2224,7 +2224,8 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 		len = get_term_name(state->chip, iterm, kctl->id.name,
 				    sizeof(kctl->id.name), 0);
 	if (!len)
-		len = sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
+		sprintf(kctl->id.name, "Mixer Source %d", in_ch + 1);
+
 	append_ctl_name(kctl, " Volume");
 
 	usb_audio_dbg(state->chip, "[%d] MU [%s] ch = %d, val = %d/%d\n",
-- 
2.17.1




