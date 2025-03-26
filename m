Return-Path: <linux-kernel+bounces-577016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE790A7175F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A46173ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBD1E7C24;
	Wed, 26 Mar 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ovZtR2a/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816D15FA7B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995402; cv=none; b=COGXNKVh0M+ITDbycc1vgSDjj1sqXjAAFSMWOMfYgjAJN901LnqSN5ZB9i2Lch2+oV3D3S2609kbrQbOBZXqVCJzcDaucIetCtld+FiQLmhIcUGok5Q5Vh9yOtVYJfJ+fi10dS8JinD3PPldcqNf+uWuGAOzpFGcFjNSv0e+Ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995402; c=relaxed/simple;
	bh=rnb9O5ga+vC0Au9mvXeMxO85sgNKSlUDQVe/FRuj+pw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTAhRahT5/Lr1iwGmC7Oycdcsn1MM90EAOQEOYJCc7PLul/dy3iMQHSxCCzy/+jjOFRgjMpjSNrdvLzrC1wJPYfWyRJABDhCqFSWuWoF8UzNCTx1R7UamrwJY2+en6dvB19vJ5GMXwOKqAN0GHt1nvOma4JkThWuLo4jw9UnAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ovZtR2a/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B146A99F;
	Wed, 26 Mar 2025 14:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995290;
	bh=rnb9O5ga+vC0Au9mvXeMxO85sgNKSlUDQVe/FRuj+pw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ovZtR2a/ZtjS+P/tBryQlDX2uBR6qpPsG4EqKUbJwM5WkXYz+dX9n/WiwJYlzs2Su
	 Sxm7/Z6dS+E9/0x0aAbBkAasC1FY2gGBKg2uU65q69m0evvZGK1+iYb/JHAIGi5+61
	 sp4I8XvvOn7O57f9O9hIvmlzv4GczHgQRldreRIM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:44 +0200
Subject: [PATCH v4 01/11] drm/fourcc: Add warning for bad bpp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-1-322a300c6d72@ideasonboard.com>
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
In-Reply-To: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=rnb9O5ga+vC0Au9mvXeMxO85sgNKSlUDQVe/FRuj+pw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//A6V10zj9xebzMdauH1U9z/DSfJoRltXRwP
 8qPPHaNVfCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wAAKCRD6PaqMvJYe
 9UpgEACtmWp6yWajbM571pCC9OqhLJWmaAGCHktwn+ik1RRI08C/HriGIK1ZEpa4aorA6mILQ6S
 X2JaKKYacaq/GpTTLesowL4YWmEgZZZDETPBEIctTuZWowHXQy9XjxvF0ssMJH321fTUBgKh1ac
 yrwXbiCjI4O0jTNKWx+fvEPZDB4QjLlPnbtBq09VMuxoi5Ddi8rhXTEAoQE8H4DAXseGwfWkHE/
 rlS2J6EiJFW7t82wLqGPxWYvFP9KKm2XGZjaaOfZzHfbDqyMOewit5BuGYgjOfidpD6WKrteJR/
 +TYg0nEy5KCcPlovtcQ0zJ/sJvttJ443ND6TPUdKppkTXXMZK7wjQsOB1WHbAO6NuJhZ3Ku4M/I
 77y/ZQD2tGZVg6h9KvwtOswpIHtMWy2WX7FVQqpE19e4dKz/Q6NEuUnXa5qty9AJ/Q3opHwUUsG
 hb3E3fE/d963yH57NESyWDz1dgQsR/ZZa9irO3Grjt7xREPM5GggJs3FFrhpOFdXzTJ2NvvTclB
 Y2mtI8S4k/EbUDTPgPNk4vMrRSztRCnu8E7GmbU/wxzQ5oq4uFF4AWlfhPeK1EuFgWc7B3lRnPg
 pkgkmoYae5+nyjLpMGKkQLo8cC04qN7uBoMi+tkF2W7kNtK9B6keyXuLeZHVKwuxOY7LioVJBV3
 FNxcurkQSWZBnIQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

drm_format_info_bpp() cannot be used for formats which do not have an
integer bits-per-pixel in a pixel block.

E.g. DRM_FORMAT_XV15's (not yet in upstream) plane 0 has three 10-bit
pixels (Y components), and two padding bits, in a 4 byte block. That is
10.666... bits per pixel when considering the whole 4 byte block, which
is what drm_format_info_bpp() does. Thus a driver that supports such
formats cannot use drm_format_info_bpp(),

It is a driver bug if this happens, but so handle wrong calls by
printing a warning and returning 0.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 3a94ca211f9c..2f5781f5dcda 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -454,12 +454,20 @@ EXPORT_SYMBOL(drm_format_info_block_height);
  */
 unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
 {
+	unsigned int block_size;
+
 	if (!info || plane < 0 || plane >= info->num_planes)
 		return 0;
 
-	return info->char_per_block[plane] * 8 /
-	       (drm_format_info_block_width(info, plane) *
-		drm_format_info_block_height(info, plane));
+	block_size = drm_format_info_block_width(info, plane) *
+		     drm_format_info_block_height(info, plane);
+
+	if (info->char_per_block[plane] * 8 % block_size) {
+		pr_warn("unable to return an integer bpp\n");
+		return 0;
+	}
+
+	return info->char_per_block[plane] * 8 / block_size;
 }
 EXPORT_SYMBOL(drm_format_info_bpp);
 

-- 
2.43.0


