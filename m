Return-Path: <linux-kernel+bounces-269724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D654894362D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DD81C22CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72DE16D4F3;
	Wed, 31 Jul 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMJQxx4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951616D4DE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453236; cv=none; b=K8zM9f9kfIHimTPHmALiJc45FBawsD5OaL/bsWh8ZfKfNdan44tHKXFQKwnTvXQyXTGuo0S2Io9WWA/bx8aQoTPyCr8PMyhP67wU7GXpH7xDki4m+0a8VEhmyKuCwPa7vn6Ix7Hl781R8MR7p+vbKSEIQR8lKjZSPKkmvOw/wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453236; c=relaxed/simple;
	bh=djLPLocy6MLVjm+zg05FaGvKSYzkkXVwiDCrgEChu10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWqRxzxYXATwuogngvY1rwGh1jKENQYrD3r3sADqxOk/hK3vjj1D/kmYHC5XgqQJFqg1kHCJDwiNAd8WqoGaH7uE/5AkarKnHRmoTPvwMGqLieCeQLTjQvFi8qmIIAUNPfSX8Ck75aS+RmpNnW9WUStkSnv6pFE5N4LafYapsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMJQxx4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C788C4AF09;
	Wed, 31 Jul 2024 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453235;
	bh=djLPLocy6MLVjm+zg05FaGvKSYzkkXVwiDCrgEChu10=;
	h=From:To:Cc:Subject:Date:From;
	b=NMJQxx4MQIdc+TJKKO0c/QrnzxkfjL1nbi+usYJz4sSneBQaqQdhRHN8oG9qw22d+
	 x/vjWXYqs+O5W9fH5QobrAJMP6AikrSt8ec1Ghym0MMufePELFv+GCTlHoKFq6hmoA
	 CnleINtoO3o7qoKpeb73tt/33h6pDetDEWv6eIPIpAdtv8VYPjnXkR1hs8mjyeFQ1a
	 NZo52FSvRt+wqzornTyK3RwfGFZvYBjPFPKvLgHWMzh2FFOJ8DR2gFqxdGPj2gayOq
	 M4JNmMU+JFhfxytzib8CeldhwLzfnse0A0FkVVOliUeCleHoR5Me9zUx+lvNFB2GoP
	 lkMV8DRsNcWBA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: vc4: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:50 -0600
Message-ID: <20240731191312.1710417-12-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d57c4a5948c8..049de06460d5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2211,7 +2211,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	struct platform_device *codec_pdev;
 	const __be32 *addr;
-	int index, len;
+	int index;
 	int ret;
 
 	/*
@@ -2234,7 +2234,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	BUILD_BUG_ON(offsetof(struct vc4_hdmi_audio, card) != 0);
 	BUILD_BUG_ON(offsetof(struct vc4_hdmi, audio) != 0);
 
-	if (!of_find_property(dev->of_node, "dmas", &len) || !len) {
+	if (!of_property_present(dev->of_node, "dmas")) {
 		dev_warn(dev,
 			 "'dmas' DT property is missing or empty, no HDMI audio\n");
 		return 0;
-- 
2.43.0


