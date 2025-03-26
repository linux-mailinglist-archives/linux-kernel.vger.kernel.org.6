Return-Path: <linux-kernel+bounces-577026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAAA71773
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BF13BDCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A831F4299;
	Wed, 26 Mar 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EfwIHjRQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BC1F4193
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995418; cv=none; b=Ajbnfx1VLB7doYQrz3zCROreTzWQNf6NtRjCQFBFD+bmWh87z4ZiJxa2oAumMQ8Ph+f1DW4Ee8/TVjCnNnDEBQpd5eSkM3PmqrsMwZTQFv9foSxKFlek+uLZXAZKuBnyg78ya2mYi2y0gaUjdNKjMfH8ScIkGfXHAIRjuatO008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995418; c=relaxed/simple;
	bh=slBT5ASGlHlLYRfFHdYzBrpOFjHVj6vIx9ezqvhm0zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2IqzsnZEg08DDcZJtz1Ty2Fqk0M0UohI1haIwWAVaDkqp3WZuiun0Aq2wyollGVALWof9ntzGda2YenuEo9h0Mb6l98ahSGRlZmpA4L+poG6p554GLYKJ/AJT1wtTc9ZF1iU0Jo9ieV12UvecmGwge3xmtBy5VvzAno5N954iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=EfwIHjRQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AE2E1963;
	Wed, 26 Mar 2025 14:21:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995299;
	bh=slBT5ASGlHlLYRfFHdYzBrpOFjHVj6vIx9ezqvhm0zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EfwIHjRQVLubJCVoeMMp3KoFoKUUhiKhawQtKOditfHbhDXfv0f7z+Y8C4fzubz3s
	 5R+7hWkPYIh5iDBk4aZbqPBZjlZg9ffj6hmiPzEhfg4vMX7lcn9Txh59KBmO0moakN
	 a3XsJQlLP1fpQ3lZ3bj39MLg3m0hRL6vW8Gz81RU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:54 +0200
Subject: [PATCH v4 11/11] drm: xlnx: zynqmp: Add support for XVUY2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-11-322a300c6d72@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=781;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=slBT5ASGlHlLYRfFHdYzBrpOFjHVj6vIx9ezqvhm0zk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//DsRCMB1WLCta1estzXkjXoSWER8pSvhQMe
 KB37gD3tzOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wwAKCRD6PaqMvJYe
 9YjgD/4176gMq72C0vNw+apzQNHJlqYV3VbqPh3TMJ/E+F3SJ8igO26yenPGmMC6YL1NwmI8sD1
 VCRJ7Bzr/G0MG+FbqmU0eUeUGlJCwoixtjCTtiRW+fyoNYRJs+cVKJLrK4WAiylri44RPu138eD
 jh4ZFaS8Is9jAU3Qj1n5TwZsAhVof+4jWjqpX72+98iTUTklWo+Xwnz9b74qdwQ3rApzKAhX4aM
 hk3T/wJ4sDRFMrVimMG6TBrMvKQ0BRIQ+/cql6IxNwx9liLQbAtTL05IDTnydTNFqTad6YKKBhf
 RVRtykBfQzVP6z0gF/klnlVyGASfx1mIG8DoCfNINcCSC9k0PTGg7C6KI04V6y2W8/FxW4lOQWm
 LC9yedg2gVmS3AJPvkWtzdBog5DHf0GUZOW+A93385F/T9C7PvrjJRIcdw2dJe8WSL+eufWCul8
 kQYYvNeerHKWd+eUja/xUTQlbQ5AH4gs80zzdbfQ7xOIG3i0k68taatYwl1/MWrnyloAvSzs/yO
 lYCha1+wkeM7CnR6bM3dFzwkA2XE1n73A0/s1/dmZOfo1gb4HY2tDv0kStCfk0XrWM+ZvT3vAsx
 nsyBMKs5r1FoP5nPUPqpBcl8uqABtsYKzFu9wSDluGctgS9gSB56vV72Fgyw/MtJq9CknEbXLMI
 nQ0kBNBUuV7BMSw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XVUY2101010 format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index ce685dfbf31f..79f58e06f38f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -322,6 +322,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XVUY2101010,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YUV444_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


