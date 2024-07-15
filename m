Return-Path: <linux-kernel+bounces-252035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A5930D61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D32DB20DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1971750;
	Mon, 15 Jul 2024 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oQV8wSic"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6D28FA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018953; cv=none; b=f/XewoL2niLgdbN1gJ8lA6Abc9TmDWVdqJmWgj/VMdLwqTa8rszDKNnKdyRFT6fCU9jGcRhhqf5PZuEltP2DeSf/ySnAkx8Fk2I7HPIj5NJ9ZOMkA15Il6rvEJBnagh/8XS1kleZGcfRNrfOlu4GBWy49zWUikP8mecucPv987A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018953; c=relaxed/simple;
	bh=sXTnAJiwk4iBl2q/sPOtHVsRDDql2giolR2QX9BCWvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rk9Yc799vVUdZAOammdHEjd2spwiFSGRE/L0xG8Q2kulDTgnWbTN/msMlI0Kjr9snAW2RtMH7NrJ3z5lEr8a7iYSJBmBI0rWIfdkRA8Ig46dS491cEPzqi1kQbVqWfYsycXxZOv4xnqsJg9dpF/FcmyRbxL1fzITHDlmh+E/voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oQV8wSic; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Philip Mueller <philm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721018948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tu3bdPp74SouXC/JHc8HX7zh1cMP9A8QlRZCc1+ISs8=;
	b=oQV8wSicLz7erXNijxghV2AO3pWwADA7H62+HKPr9xog5Iz2KqYVa2if0p23GQRHDUNbED
	kWECjXHQJI/1DeuhHMI6iM4/ODNPjqvhlRqB5Hn5MvDD+pXYnodQ7b1MJVfesg0N45PFnU
	XssEQ9UYXDhFnGi9uXVU1OE6HY5VGBeeJ4uw+MHoMqvSkmqzLMS2aSy2VF5/9B5XgCJx2i
	fkI3PtOsThFTEUEPf8YVBYlr0wYUA0dkzw08IVvjZV1DRoVqJnR70/YKrFDwVghMJ9zgMS
	CHz9hSq8UMQz7dzeW+7PEe9jBrsT+tAhRAkPxcmwrQi+JeBVyyPAhaXYC2i9mg==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Cc: Philip Mueller <philm@manjaro.org>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for OrangePi Neo This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming Handheld.
Date: Mon, 15 Jul 2024 11:48:30 +0700
Message-ID: <20240715044850.1018856-1-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

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


