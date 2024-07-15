Return-Path: <linux-kernel+bounces-252036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AACAB930D62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D61F213C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23217EF04;
	Mon, 15 Jul 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PErVAzpo"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935A8825
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721019537; cv=none; b=X1lGJ1tayN0fiJngAysgZKy/LU3eNha2dK54Le5hOgoXJEQ3UmKEBSKjyuY1hKhHGgV5nCfW55wUPloKcpAvyLoWJvK5oGMFT0b4d+sa7mOhf1ktTv5jzs98NPBJacWwaHeyFPRtvOaylEMNK4cHmIUysEcMrSaaEExtirKFjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721019537; c=relaxed/simple;
	bh=PEJgU0vTE3HAgDg7vEJO247t/ka+IN/E8XB4unbYT0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WY72qDJROg4hPavyxKYMNu9xsLwY3/A8TAna+iMJCH9MPlQH1fPtqvcg6VExV0WsYoLWSNMOnh2plXzPFb6VKuUL5ipsOVzhECjuz+xc5lH4w+4VRGr7YrI81XDp8ikmgkM7lUGqtFG2H2vxGZr0F+I5L28zOoE7Llv28zk0Cj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PErVAzpo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Philip Mueller <philm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721019532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WQXVb7k5eYZNCeNAVV3C1d6cf65+tYZkEMxdXBXGZNI=;
	b=PErVAzpoRkd9GjqRuPqllHhq6RLISRBDso1NeTcfgQIEv9e2siRy8pDTx1eQFXqpQNDnr9
	pj/xpZvMLHo7rydIMggHoK5idvYE1M/JCy08p5vaqYIUoygDpvqEXHI5ToZfecnwJ03Xuk
	9jy9AyQ4R8BtDA/MJR7P83B6gzujwJnNj+Z8/RpA8fGRUWhBo+a9ItkB0h2oDPUqEL9EH5
	V9qNB2cCVK3FsyH1s7+OSGdO+PCtwTTsnhlWKeFnzmFfnLVBG4SvBkS6Aff0JsnA5reJ+4
	cR+VzGu656ZuiJ/1IyG0HlgcNHATn5gXr3e55/mQxVApgBRc3YoBHBN/IcBVnw==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Cc: Philip Mueller <philm@manjaro.org>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon, 15 Jul 2024 11:57:49 +0700
Message-ID: <20240715045818.1019979-1-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming Handheld.

Signed-off-by: Philip Mueller <philm@manjaro.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3860a8ce1e2d..903f4bfea7e8 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.45.2


