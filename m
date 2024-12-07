Return-Path: <linux-kernel+bounces-436156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC8E9E81E8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ABD18837F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C37C153835;
	Sat,  7 Dec 2024 20:18:57 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3B22C6FE;
	Sat,  7 Dec 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733602737; cv=none; b=ZSj2i5dsPY68Trcs6lXSFNpxKqfVuDmg5VkMyl3040hA67laZPoIh8sOKckFUC1octBQWCrIHvcgD5F8rEgXiTG5esdRd9S0GsJeMEun6MjA7A80AYhDyzrCEX2WDew5lrxxwHzopNRMDIG8yPtz5QSh8A71SRq7VwJdQ22knSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733602737; c=relaxed/simple;
	bh=JHuz/t5cOekx5YUiprLoAzT3UnVH6DhvowlOhLU/eYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nJCzhtYagw4V2QqV29q5SubHcMm3AUT4TqPZSFwFULlFcB4T4bttE/E2054WFbISR07bz2f1DfnbGmDpPDQRWZm4/AQnzq8yd6zemV+nZT00Tnhlf5P4JcNtcFtSqJBIYlAmz1kJgoCpPRDGHjLPt6zKWzQlEDLQnvD210dJq7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 11D8F2338D;
	Sat,  7 Dec 2024 23:18:47 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org
Subject: [PATCH] ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model
Date: Sat,  7 Dec 2024 23:18:36 +0300
Message-Id: <20241207201836.6879-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces the alc2xx-fixup-headset-mic model to simplify enabling
headset microphones on ALC2XX codecs.

Many recent configurations, as well as older systems that lacked this
fix for a long time, leave headset microphones inactive by default.
This addition provides a flexible workaround using the existing
ALC2XX_FIXUP_HEADSET_MIC quirk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f2686a4577d7c0..ed0146e2563695 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11200,6 +11200,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.33.8


