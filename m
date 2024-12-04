Return-Path: <linux-kernel+bounces-430862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2009E36A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CC2281157
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35231AB53A;
	Wed,  4 Dec 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P4AHUURp"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2119D886
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304698; cv=none; b=CfnpQWC0Ilb6A3pNDsB13eRBeXyUw5BYuHfPtLEIV+TVAqA/AaAbqRW0E1wE1+tL6KqsIBO3rVOVWKzMgXgWuCgdnxEb3A68XHS3XZhIlFzuRpYkZReVcR5yjfzZeiF/SX0vx8HPHV5bp3zFFaM5x0YxMtUcpmb326Dzf8PSYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304698; c=relaxed/simple;
	bh=yyEyn4rhIqdMmRak4lQf+pKYkr0S+P4y5/aRt0CjZDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0iKzwaqMPC6QxNqQM3PmoI4hO6GgaMZw73vcXSjxA4tYhDXbnH3Cki+hDIanfXtRKfJPtX1PimBoaDsfHQ8faOfeKyegirHNPL15WflyL0Jfj2OzlSQBuNlrZ0RQL5jh5Af1H0IpTz6JBwjgDI69Zq3qIKrB3LyB8xVcFnHAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=P4AHUURp; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 091189FC;
	Wed,  4 Dec 2024 10:31:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304666;
	bh=yyEyn4rhIqdMmRak4lQf+pKYkr0S+P4y5/aRt0CjZDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P4AHUURpDLAXSpjWAH/xWCkloWXEG8soupjlwQI8Tk8+0cpc3wbf38WNwT2LL5UYE
	 3mEXc0DTqMq3B0zioUXapCPGmO+BGNktreRyt37OyVInCD97pVqJObj0PUIJ6rj1kI
	 sQmXDkvQoddlIJkMTmWNn48+r3SkYZaCleQ0nnpo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:01 +0200
Subject: [PATCH 01/10] drm/fourcc: Add warning for bad bpp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-1-0bf2c5147db1@ideasonboard.com>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
In-Reply-To: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=yyEyn4rhIqdMmRak4lQf+pKYkr0S+P4y5/aRt0CjZDo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFwjuDalmviB58VM3aWIBl9mLEZF4MBEs2ty
 FCH354qfrOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcAAKCRD6PaqMvJYe
 9TI8D/9epVIOmQ6mUczxxULoiWYF/+qqqE6uduUiFg9hjNn00T05QWqLOgU3AGXXj4cf2/FQAwu
 YZ3dXzeYwzRxeZK3AkMdF6GbHO8kId1C2kj+HONkTnF0avbPtPb15SXCs4N/xubiCNbNjozMVQQ
 xoE8XtmSQVe5vQ6GVa0AiqZHT82V9eWlqIIC3utxzWrDAKF38GnJoh0KNP0L9sy7t8/92xlQqni
 lw+zlmHZG/HtmkzECYrvmkWdaAOWNcNmkvtofJTcy3jjLHhgEGb5Q02U5yRoxXtO7OYkiAbSyRX
 /78KfP3YGhDWH+QjQaZYao1TF/P4pzZyKNFi4BmpnFve6YtRkuXZ8dZIXD6O44Tahq5BDrOdJV+
 hp3U+lOc0bVkTzX2Slb9qSeK9n0Sk20wtlJWLgA4C7ikH/dVGj/VBP6qGcKF659sqlDVJbPWNjy
 v41sViFqjtxdvTAYN68NwOgQqVo/1+R6pbPNPeXU3JZ+vLIvSx1SIVCDpb08x6NgWQmcUch7tmM
 z3DxSTnt1oUN9nppSnpV1NIbDZeWQAccf6CHSMs5Tszc3M1pbsqck7R7QusCtxruGXkY9tUd9wR
 8NLauOvprqRHCiNDzHbXAIm8a/6kRRaO/6ROPh+Zy1oxWkM+QqA2dqu1Bla6CrX+NncCm208FY6
 xgK8OilUnNLKPlA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

drm_format_info_bpp() cannot be used for formats which do not have an
integer bits-per-pixel. Handle wrong calls by printing a warning and
returning 0.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_fourcc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 193cf8ed7912..e84c4ed6928c 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -429,6 +429,13 @@ unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
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


