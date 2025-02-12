Return-Path: <linux-kernel+bounces-511313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D8A3294C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9693A4D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA321129C;
	Wed, 12 Feb 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IDloWwaP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDDD210F4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372216; cv=none; b=KZAj5KEeDz8KUiYQk2sMN9C0WZufsKZeHGHZqEsLL6x4BQr7rv4bsw8ynurLUdC9gFhYTZsJInc6KZQ/MgrPpFxGzBAw+pDYB4Od4Chy5mYGUS9isrvrlYHC1FYB8LOQGIlF8HDSMDxsyWkV7j7kbSnO1kQm/DGZjUsWqTjAEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372216; c=relaxed/simple;
	bh=VjE9mbKl9OnWT0ySTs7fj/5Evv6uFyb956WbNi6bAL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3wXqRXkm+OTeFz5zK8EWmLdBodnSK43CbqYxDZZQn5VdDgDhYOlv/N2WpU6GM8Nd0CtVgZNY0E2IROmOLNaSC1pqVVT0Jh28sFg/mlAGnBwi7M4KA9SfS11rezD5dPiUQlm+KOg65ZDmiILsn7mIfSsOEDorXuwn9LYryGbkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IDloWwaP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C37EA2F;
	Wed, 12 Feb 2025 15:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372128;
	bh=VjE9mbKl9OnWT0ySTs7fj/5Evv6uFyb956WbNi6bAL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDloWwaP/zRQ4wWJb5I8yauT0Jh+uJP244FniUmBEG48A0ZgggdSuyqlAN0v1TlIf
	 Yw63wthhy+2x4JHot9XqOVC139v8zyUODVgO9BHrptG5C+qhnb5g/mjnVvxamKtIER
	 EwkrU/W2FyaQoTjlCmINrqA+2Qf8PX7RVIHVSqO8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:05 +0200
Subject: [PATCH v3 01/11] drm/fourcc: Add warning for bad bpp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-1-90d0fe106995@ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
In-Reply-To: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VjE9mbKl9OnWT0ySTs7fj/5Evv6uFyb956WbNi6bAL8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLaoLvPPLk/mVLX6uRBDJ4JdhqSsuASwrZP9b
 mFFJPeq5JOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2qAAKCRD6PaqMvJYe
 9XIpD/4l+I20edPbx2nORFeqiEyG9CIgqm8A1uakiUKPVXy1Wh0X1XQ9+obe0VnoLA4NOTPawn3
 21OOOrbtaGYU3JXzR2eeOXV+erc7ZmzvolygdCPSXFqBAHE9rHm9At0ie+zhqZ+KYWqtDzjJWFJ
 EFbj9L5B1F/IUAohADcaqfsIe8pMA2eIJVJ3c3rwOtlN4ftIQkKR6OvYkT54uZttk0iMstpC0pg
 UqjzSTiv6rAuTdhmrx+8/KErEYCpr25TpV+atExvzEVlprdLT0l8DHWxwlZ5qBbVfhx1sKNGMkW
 LMa02qqxlWbk63bQShmU4mteGt9lqkIfGS4AelU5PSjankHi3Qee7RZavScwP47oS+w18VFsuKR
 xwne9mA18MM+AOKIn7vWGhxK4cvwfxBPwIf3DET2NXyr0ku3gu4ensddeulvXTOf4QTvoz88rQ+
 dFe/83KaimkU82p7tb4HiRg86v3RcUz/yWH5sPl5SF4ckZIY38Fq9MEQJBMT/Yj9BTeN1ubJG7z
 b6sBWxvSnwXdXdK6xgdMcVogy6ZVuankgvjCcqay37fn6UsMDUUxDxBu4Gn9x0JSJHWtcAmqFiD
 XQn4Mhinc919wC1SiC1d/w5yUeHknHMuOzaZdqmrTAMMmWHivRWg435OFLHXOnulvyyRnvRL/6H
 qpmoNg0Y6sWxeIg==
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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 3a94ca211f9c..1e9afbf6ef99 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -457,6 +457,13 @@ unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
 	if (!info || plane < 0 || plane >= info->num_planes)
 		return 0;
 
+	if (info->char_per_block[plane] * 8 %
+	    (drm_format_info_block_width(info, plane) *
+	     drm_format_info_block_height(info, plane))) {
+		pr_warn("unable to return an integer bpp\n");
+		return 0;
+	}
+
 	return info->char_per_block[plane] * 8 /
 	       (drm_format_info_block_width(info, plane) *
 		drm_format_info_block_height(info, plane));

-- 
2.43.0


