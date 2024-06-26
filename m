Return-Path: <linux-kernel+bounces-229881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86291757C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D30F1C21A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49AAD2FE;
	Wed, 26 Jun 2024 01:17:38 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013D647
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364658; cv=none; b=buHr5GMSvTySkbbNG+DwcIwBbjVsQhaM+8o7RJKOai6BcDVtu3z37gaval0Yb+/JfJvOmu+whMjpXA87a/6ELp8zUfxL5ggGtyOm0YhN3j1pls4/3BFFsIW5NEMeDS5exWImJXR/QWCXokCpwLodGe5+LPI4HFEmZLFIzqN+iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364658; c=relaxed/simple;
	bh=ILZTs2xb5HFxmU/WoOc9Jjay4Irnd6HuGZ0JlF46g7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iPykT2Mo8gZ80t9XbZPgQpaVx8sNo75xS2WtsyobtUUqv3xpYkr1KOq0pwpTzAGG6LDoraqbWn1udl9o/8ydaARtV+6FrW63/Iv+aC1m8SY+9bgnazTUXXt7EV43qEVX3hUlxvLtFUU8iLyI9e/ldiLAMubJKB/fBAVpQD9Cx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXXwMKbHtmqOfQEg--.45360S2;
	Wed, 26 Jun 2024 09:17:05 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/gma500: fix null pointer dereference in psb_intel_lvds_get_modes
Date: Wed, 26 Jun 2024 09:16:56 +0800
Message-Id: <20240626011656.2763368-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXXwMKbHtmqOfQEg--.45360S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1xZw1xKrW7WF1Utr4xWFg_yoWftrc_uF
	1rZr9rCFWDu3Z5Cr4xAw43ur1Ik3W0vF4kJw13KayfA34DWr15X34aqFy5XFyxZa47G3yD
	Jw129Fy8Zr4xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUU
	UU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In psb_intel_lvds_get_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/gma500/psb_intel_lvds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index 8486de230ec9..aa5bf2a8a319 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -504,6 +504,8 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return -ENOMEM;
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
-- 
2.25.1


