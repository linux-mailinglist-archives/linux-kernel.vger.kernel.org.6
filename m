Return-Path: <linux-kernel+bounces-322277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCE9726A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A571C23696
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E951139CFA;
	Tue, 10 Sep 2024 01:33:18 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB742A81;
	Tue, 10 Sep 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931998; cv=none; b=FPjCLqnEDaC9DLzheAnv4CYBcX3ra6OoYgtyGLK+jasK7KT6i832Hmpn0Qwx/6zkMyMV5XNG29R9fuHjFAhx6mmyq75P1CchFLudAm9WHdKuwzzHpPCaeChXqgBtanR4GxqIQzzZmC4qMz7Kpv3P0I/IOnVZ7LMm94PGPrFy7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931998; c=relaxed/simple;
	bh=E6aVe/li53WmGDulVa3KCliMqCgC2Vag7E/p3hL6aFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrkDaQvKRP7u5Dayjai8tvlZZRztQoL7afKdr3cHRYEBFkiYhb4bNne2ci9I2u6DjwNXkzvkFhHSjG3lHRl6iyTiLP5TcW3pzdzIaeb0n0UezRLHkETN269jNdJGk5lXhFdFeHAS97v+eOqKVJpVQOokGmLKSAPtVCfUuCHmmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666dfa1d4efe-de7c0;
	Tue, 10 Sep 2024 09:33:09 +0800 (CST)
X-RM-TRANSID:2ee666dfa1d4efe-de7c0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566dfa1d0997-6c03d;
	Tue, 10 Sep 2024 09:33:09 +0800 (CST)
X-RM-TRANSID:2ee566dfa1d0997-6c03d
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2] ASoC: soc-ac97: Fix the incorrect description
Date: Tue, 10 Sep 2024 09:33:03 +0800
Message-Id: <20240910013303.2044-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function snd_soc_alloc_ac97_component &
snd_soc_new_ac97_component, the error return is
ERR_PTR, so fix the incorrect description.

Fixes: 47e039413cac ("ASoC: Add support for allocating AC'97 device before registering it")
Fixes: 7361fbeaeaab ("ASoC: ac97: Add support for resetting device before registration")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
- change the right fixes tag.
---
 sound/soc/soc-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index 4e4fe29ad..079e4ff5a 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -168,7 +168,7 @@ static void snd_soc_ac97_free_gpio(struct snd_ac97 *ac97)
  * it. The caller is responsible to either call device_add(&ac97->dev) to
  * register the device, or to call put_device(&ac97->dev) to free the device.
  *
- * Returns: A snd_ac97 device or a PTR_ERR in case of an error.
+ * Returns: A snd_ac97 device or an ERR_PTR in case of an error.
  */
 struct snd_ac97 *snd_soc_alloc_ac97_component(struct snd_soc_component *component)
 {
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(snd_soc_alloc_ac97_component);
  * the device and check if it matches the expected ID. If it doesn't match an
  * error will be returned and device will not be registered.
  *
- * Returns: A PTR_ERR() on failure or a valid snd_ac97 struct on success.
+ * Returns: An ERR_PTR on failure or a valid snd_ac97 struct on success.
  */
 struct snd_ac97 *snd_soc_new_ac97_component(struct snd_soc_component *component,
 	unsigned int id, unsigned int id_mask)
-- 
2.33.0




