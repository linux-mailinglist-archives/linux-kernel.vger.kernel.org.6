Return-Path: <linux-kernel+bounces-303048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B296069A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D800F1F23066
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D619EEDB;
	Tue, 27 Aug 2024 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f/UHflwO"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186519E7E4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752922; cv=none; b=FNgqmgQiUsBPZsaL7KZHepVMX4j2h6hyYfJuIvC4zvKMrny3HTOl7hqZ9BiIy5Gdn/NVHCIxCD4dmKaU1vj04m4nmeNkhNY/Fr5nh5fTzufGXEqZB9u8upKeHU8Q03bWqUY56LMXPraLeVA1WeG3b626N0WCsdKqTXkWQv4sIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752922; c=relaxed/simple;
	bh=eon9nKAT8aprMkogaxLTrCwGM6rlkI2aZ3rSwA+swpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6d0FBf8ikMvhty4PzHoLngI1hz0nJOU8SuSwJBnmN/V62Lsarh0PgN7XaNPG+PUkcS2axxRVJcUKA0cRyZN8sjbmt33G0RUYIF63dCsINv7YgS0+nWFW2V2ryJQGEsN9aoUKJqh10WrfhAquBGzew8IQWgGoYVhUcNxKQ5ukJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f/UHflwO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7667C1C0002;
	Tue, 27 Aug 2024 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724752919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXbrQYbwu05I9QcdP0EOzRyW3VmbUgQZEfA/b5hJq/c=;
	b=f/UHflwOwNjX3GLS9YGAaiQzzbpHgXjZD2iKJxHwfggRH236UQ+HPVCJrjoFw5d3ryrdYt
	UGfDhaQg72qAQ7eepZub2VOUG+P/qmD8NNgVlad7B9nZ9HO0iCxTHp8RbDuhso7J7XGXhj
	MEErdzUe0CdmiOdZiw8lQaGFhLzQMsV+pTU4duPycmHj0YciJsl468heZGR/7vFU4xG0fp
	tT9X0z5qV1s2nNx2dI4NZebpldrhYxYF3Pt3Ng1p6HRx6mMd/i7duXlUm4Kk1hhE68D7nl
	DFwitAm/TWZc4jnvRYXatENvxI/Op82NoK64JJKrqu+BUmzurHxuGrhgMPhn2w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 27 Aug 2024 11:57:41 +0200
Subject: [PATCH v2 6/6] drm/vkms: Add missing check for CRTC initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-google-vkms-managed-v2-6-f41104553aeb@bootlin.com>
References: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
In-Reply-To: <20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eon9nKAT8aprMkogaxLTrCwGM6rlkI2aZ3rSwA+swpU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmzaQPRDVNlHwwkHSIsyM3580wfuLwKuybATZ3e
 f1fTFkk8FaJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZs2kDwAKCRAgrS7GWxAs
 4q3VD/9O53/2TSWKz6e2kcpm9dLhofqv1w+m5klIZ8QHKUHuTMyrKFAtsz1h8R4ElpWZXr1sXAc
 ncPE46mxY559k5KaL+fEwK9mtU9XRbD6OczzCmiRCTCU0BJKCDa/KMJgd6F63ITacdZF5JcuFkR
 Xv9M1hgHh92mTXp+XdZwTKOoVsDMWtXIJW9xYQp9cLTd4kfAkkzqaK3D6/0Ql+9sPN8oPHSkZfs
 /0NDi55NfeUllmYA9I+EeKjqp25WxLxmbj+JrWgmVjZ9aVYXvfmazK3bnMXWIEMDG6pj8+Uexf+
 qVjJ4JqtmYOlDsKGWdWUz91jgWQH3Z1pI5wg6XvKAI12bL1p3+2t0T2np0+LyrdqxJr4phgT2SA
 jtgP6gKCABQaoE9Eqmfn0YSGqjQ+O2esSfx5+xUb6bCFDY5LB/bBpyJbrJ1244ZHVN9FPxvukb5
 NraOGZ+CTOFSx6mbdC1clO6qfIKgzwqQ7SARti31N+crDKbzvHlfdjmp/U9m2AvlOzQc1bwrgUZ
 ZgUou1GjYGxQGxAmKCay9KupgL/3FoKFL6CJ5x11dwoN9GNjvXz+3kxtbHyaSDFJN62TtEmpNwS
 /0Kih70wh2BRmK81LRVMjhj5k6oHVuwbr3Ge7Ra+TnoBg+w8S7kSm9g0CTIrBgehCCskkoQ5SdH
 qC3+Dhf6xAYwRDA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

CRTC initialization call drm_mode_crtc_set_gamma_size without the proper
checks, introduce this check.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ff55099c86ce..39802c928bdf 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -293,7 +293,12 @@ struct vkms_crtc *vkms_crtc_init(struct vkms_device *vkmsdev, struct drm_plane *
 	}
 	drm_crtc_helper_add(&vkms_crtc->base, &vkms_crtc_helper_funcs);
 
-	drm_mode_crtc_set_gamma_size(&vkms_crtc->base, VKMS_LUT_SIZE);
+	ret = drm_mode_crtc_set_gamma_size(&vkms_crtc->base, VKMS_LUT_SIZE);
+	if (ret) {
+		DRM_DEV_ERROR(vkmsdev->drm.dev, "Failed to set gamma size\n");
+		return ERR_PTR(ret);
+	}
+
 	drm_crtc_enable_color_mgmt(&vkms_crtc->base, 0, false, VKMS_LUT_SIZE);
 
 	spin_lock_init(&vkms_crtc->lock);

-- 
2.44.2


