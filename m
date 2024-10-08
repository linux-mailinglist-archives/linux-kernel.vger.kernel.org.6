Return-Path: <linux-kernel+bounces-354434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62219993D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174FF1F22AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946CA376E0;
	Tue,  8 Oct 2024 03:19:55 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1022611;
	Tue,  8 Oct 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357595; cv=none; b=qPAnTXiI2vO9IXg1I501dXM/60xkLYN3oi41wesQ4Sinn31Liy7KckS+ErejlslzQXjWfOucP0sJzgyEOCljprV+vShKfR0YSjJaZgiZ/hnzbsXb4/YlJwvHrXMFLlhNipAAfJGk86hc2cFOS++6b/nvWyjBH6JvVSDc37giGaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357595; c=relaxed/simple;
	bh=CMtoxgNnYZaWKsGPMC4Y5KmG18rguda+kw6ufkxXmbk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q5D3fScIkBELoDLOJa4Uej4WZ5cPAl2wUnNSXPLZJ+JcsvQVZ4hhJonRgzSw5l3YZJyqh9UoDV1if5NGHQVNRV/k5UEQvJeqBa6TnEPYolV5cJEVmhzFg1U63iYrJWwapczK8AxAoqnMsnKRHUqzI6orGwad4bFwTQLnz9SDrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76704a4d5981-df989;
	Tue, 08 Oct 2024 11:19:49 +0800 (CST)
X-RM-TRANSID:2ee76704a4d5981-df989
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36704a4d44c4-89013;
	Tue, 08 Oct 2024 11:19:49 +0800 (CST)
X-RM-TRANSID:2ee36704a4d44c4-89013
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: g@b4.vu,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] Sound:mixer_scarlett2:Add error check after retrieving PEQ filter values
Date: Mon,  7 Oct 2024 20:19:47 -0700
Message-Id: <20241008031947.10906-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add error check after retrieving PEQ filter values in scarlett2_update_filter_values
that ensure function returns error if PEQ filter value retrieval fails

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 sound/usb/mixer_scarlett2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 1150cf104985..1b864a9621ba 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -5614,6 +5614,9 @@ static int scarlett2_update_filter_values(struct usb_mixer_interface *mixer)
 			SCARLETT2_BIQUAD_COEFFS,
 		peq_flt_values);
 
+	if (err < 0)
+		return err;
+
 	for (i = 0, dst_idx = 0; i < info->dsp_input_count; i++) {
 		src_idx = i *
 			  info->peq_flt_total_count *
-- 
2.17.1




