Return-Path: <linux-kernel+bounces-356428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372999960EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6906B1C23CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0917DFEB;
	Wed,  9 Oct 2024 07:32:22 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355236D;
	Wed,  9 Oct 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459142; cv=none; b=uKkdv3sX2G29JyoQ+IytuaIpY70g/Oy9gKIR/JvB3Xv6QGGQIz7hzG8bbYLr16rVOQ2uJbc64k4YJ1sXkZAIBPqE6S30BELAFDFZMCzWSY5JycHpH6f031P1+kxA72oP0KwFoLR6Ir1tHEXrI2cex546KsjksAMAIizyzI6mf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459142; c=relaxed/simple;
	bh=CMtoxgNnYZaWKsGPMC4Y5KmG18rguda+kw6ufkxXmbk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NZE4Z6PJH49sVORRjpWwRWoHRMR0R5cL764xy0F+gRq5doTDlSGsTlJi/n1AQrZyOLMOEAi/HiGQY14edOUKOV6ok3D0bvSjOiM3QMEIzURUOKPDo0rLdDzYUzOqGbq7Ewu1sfV5MzGnadr/sB89ZFeLt8+DbPMey0KFL6nrZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86706317d387-263c4;
	Wed, 09 Oct 2024 15:32:14 +0800 (CST)
X-RM-TRANSID:2ee86706317d387-263c4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56706317cb0a-de461;
	Wed, 09 Oct 2024 15:32:13 +0800 (CST)
X-RM-TRANSID:2ee56706317cb0a-de461
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: tiwai@suse.com
Cc: g@b4.vu,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] ALSA: scarlett2: Add error check after retrieving PEQ filter values
Date: Wed,  9 Oct 2024 00:32:11 -0700
Message-Id: <20241009073211.7266-1-zhujun2@cmss.chinamobile.com>
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




