Return-Path: <linux-kernel+bounces-577025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED6A71775
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43D4176227
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8F91F426C;
	Wed, 26 Mar 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="loFlaOpS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF151F417D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995417; cv=none; b=LcHYckHp+snnlm3gPO9cTr/QN61KbKYKk/2u4isw/SVBYxPJZa4nP1gNuIBTN2tMjchoyAyVWBNZx22FKJ6dJNNxEx45b9vwE2/Uz2vG8hgfZ5JWt0ezjkntL0juda0RDfWVBd9yp2OPngazbiLZ9wyji79F+Ut0m3osx++90VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995417; c=relaxed/simple;
	bh=oFm4U0hkZjYLWnEJeFMKYjlk7egwcLGFKCoUSOTzMSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q3B7ORjKQwPl4GjFxzyvz+kdF18vGi5z7vwrpNLwWbw0qmzTMI5C5ZEzVYQHQfwIrMw0Ws7a5u18s7roP2564a/bUF+4sWpByQnBZJAMw5R4smn4kRW7h653nK9AL1jDK+EWaZYgXvwUxnZF1nRUspWr01fykvi7vYVQXd9gNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=loFlaOpS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7D1FA57;
	Wed, 26 Mar 2025 14:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995298;
	bh=oFm4U0hkZjYLWnEJeFMKYjlk7egwcLGFKCoUSOTzMSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loFlaOpSHXOIfkLHMiTp3pdPZtMRlGyEB9+OTGbJq36Yo6Q27gTsb4K7q6zZ3M3yQ
	 eiHVOojyCF47fxt/HJwoS+qzJFieWgnH84D6sqlS4M0+5ecoGIKH4wuacBfOM8vdGQ
	 H4L21cO3qSiCWNYcMvhUEnV+s4/LauCyqRhQjzvk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:53 +0200
Subject: [PATCH v4 10/11] drm: xlnx: zynqmp: Add support for X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-10-322a300c6d72@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=oFm4U0hkZjYLWnEJeFMKYjlk7egwcLGFKCoUSOTzMSo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//Dis0L4uQRt67L4P2Qc6MhWqd7lhV/jzhvR
 sHl9RUreaGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wwAKCRD6PaqMvJYe
 9WPOD/42/uhBYTjLB+c6OwGMl9PEeXPllE5b/M6xr6cut6fEWSE3OOMpJxPdZU0gVaXy1JND/Tg
 AfWAAXNMX9oed7VtBx5tmWlzRZBZAJ0fpo0Dkr7vNYq3DqcBtvoXSEzpChs0H9Ak8uezBSQXJzP
 yMo58+ab4qdyak5zjbxFKuy9f/ltofwWSTpAQfi4F0coGleM3oyIEIibcjV94G63J3TajGOqsuY
 hBA0sopkfh70UIgxE5Zi9JkLz1wz9ply8pziDfVc0VDdHH8/VNaQEW5S3Zr0zzQ8UJF0Kas0n1H
 3Q3pCZIAqSOUNX1E4phi8G+A0QiRkHx8ZNldxtq3JOI85Vloyf9WdXvG+uZRI0xDMzqdAS6lqgn
 2OS6D/zay9zmNTc5/nG8tMwrolUQIFxicGDM08j/15Mr9ig0s3Adzm3vF5xHfmOoaQiFw8yHKHT
 moxsWwZUuVxXD/3yAMmAurU79czTpt9jc8PpJN0dE9ZVUnpWk60MB9tluBACrDoGa1e7IARVIP9
 gvZSBuwTMA6P3nMayh5H+zYE0M/vfH5GCcisvc36lwIoKDFd7gMj/e19goNXoI2YfK58r4oCZkR
 NioIgz5ZvSQKqKoz7lyZQVT96XFeN+2OhO0l/8D+w2GlRDo4RtTjirCiyLZQ2DNslN+xaXM0gEu
 ZiYS1ObRywAVzwg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for X403 format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index ae8b4073edf6..ce685dfbf31f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -317,6 +317,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_X403,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


