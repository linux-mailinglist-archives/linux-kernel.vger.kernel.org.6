Return-Path: <linux-kernel+bounces-430868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C009E36B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380E7280F83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E261B21AB;
	Wed,  4 Dec 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hZCffjL1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446D1B0F2F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304707; cv=none; b=Au2KuXMY1E3s+APeKWNtKHTNHoq2MCGiTzKGIs99HdqSYapAgr9w5QeaMF0flu1e795sAsCYI4s5L6zeiZvZrlERlO0/HKCLqlkHNXrlXjxfmczZEIq22OrJsZx8XyJaU9U1JNSqyBtHUkae1EgB9ee92NP/x3Gv0U30w1rDZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304707; c=relaxed/simple;
	bh=3lV+l32vg2JpWZEq7vy7NUNpO/y6nBsRUh7Y4B6/+ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMDksJf8LZ5zK4QbzJ8oj12tDeamHzpx92mkUSxqIN4dpeWaudOZvigkwNm54QGji7kpiuqPU2Pvl5xmAVCIQ0pXoUISKDBYJxGNt3rzMUJ70OoKAAw1NH1KeEtSqmh5WyOEqOmcIvG2D79BYoU2Cp5D0165bYEBKqs40KmdVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hZCffjL1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 03527191D;
	Wed,  4 Dec 2024 10:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304671;
	bh=3lV+l32vg2JpWZEq7vy7NUNpO/y6nBsRUh7Y4B6/+ho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hZCffjL17efrhE31XcvGHz/zF4lxvQy6/t4T7uOmwErvEgyhCmHUfXIKR4erT+emb
	 gV7cHOvHipDHn2/ronbTjJfCIMYmyMuU6ThdTIe027j1pifcE8E97t2w7RbKYJDeJn
	 LseGz6WcV/9yKd3xlb6ei/TmtiMZKCGZst3ulZv0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:07 +0200
Subject: [PATCH 07/10] drm: xlnx: zynqmp: Add support for XV15 & XV20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-7-0bf2c5147db1@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=936;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3lV+l32vg2JpWZEq7vy7NUNpO/y6nBsRUh7Y4B6/+ho=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFzjIte6iQJAwvU70HmuJG4CLSFQXDQ7PflQ
 LjDIRZ+McqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcwAKCRD6PaqMvJYe
 9Ym4EACofxnUMNc2FyeEumCCakl0p5SAvqleYke9a+UAr3s2faA6SnucTFcG6cNwqOOHuHqwWAx
 a5zLZPUq7MqEb2a1gZ2YxQiF4/UfWqKUH5/rj/WTwoeCgSs41VrDUWbNYljYRpk5TcN2JbQKM1v
 HEa/Q7LANLrOuy5mbomCCPxIvTqCyiW71spixx3VzcSuRiaPdFd6pwN0Yv6FIXpzA4dvomn5jQv
 h4godXykGa7q2nehS4tOCLX3fRhZ8Ji+63koTpvaOihiljnTzEBqVKecX9QlYWUZw70jZ9V9/jT
 36RC6D56hkGEalOfedPHlwZsPyeZ2h9icpLZC0Y8z65Yz4inMigZ0pB79Es7l0f5fAetPN3OiUF
 Kj+68mE1bGn3ZPkg86li9Y/depPts1yyiM8Gd6/4/sv6tHK4NF/Xd3Ttswtsc6KjkjrbxTfyO6F
 QFbVElrEMA70YTiAiQUQTI4JIe6qy9La8V/7DCaovp0Fq+u/dKIOKpwjHb/R4UxtODR9agF/ZJN
 C7cBZAbYkefjDfOs84rBBaz88iQK1XJMVB1azYJpIUZFMIxgWuiE8Q8CIP2yuYkMl4NnevKsYYG
 vsv1rjPwqcFlcVhPyF2uK9DKLBIa1PvUx06inUT2bpl2v4NK9Bwu9Tb9bV7EAAYy4kNyx7sR3Vc
 gjg/ZHe+xxv2aag==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XV15 & XV20 formats.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 57221575cbd6..3998754e367e 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -299,6 +299,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420,
 		.swap		= true,
 		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV15,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV20,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


