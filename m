Return-Path: <linux-kernel+bounces-220105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5C90DCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387DC2851C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94016DC1B;
	Tue, 18 Jun 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HXO0CXhA"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B615ECFD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740040; cv=none; b=Y3qNlvH0vAa5P9AcCkvyfpXX6KCSW5HnZRjrUfabSNg6j5Z/r4GhkrUu8fYHTmA9bfeg/qUbsoRZpSvshlmDtGmCzu2PW0VNNEG+qhoz5QpIsGml+lzsXyIQLbr4BWNrFLjA5IUm0Y22YcKIeRfsGLDVQKaT6CXukr6sX/tKBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740040; c=relaxed/simple;
	bh=ebV/XqmTJBV2qr6WY+LpZiNUBYoPi3SbUHc7dUlxhlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp6JaYPefGuco80rBcx+V93DreisOiYlqUbisvWM2Vfm10ZciasDYWLC7tnKGBwvSa8/wg/uQ3hKer1Db6BYF5nH9R2KKrhEJ1uu6V8HhpT+eblVn5Te7QkNibxFCse3DtMHsgTXGEUD3QqkjD4Sc0phyOLTDNeD50mwvTE03Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HXO0CXhA; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718740021; bh=XP+PQQpBG4wSocp1mSz4RzoXp8YVq7y4W8nQ4GpBj2g=;
 b=HXO0CXhAa9Ny8vvBFFYE3H06AAAp2Cp0AcxaogMXz6bkwrpTRDrX6yGgY+KRlK5hW3ne7jMot
 Lsjv0H6WXD/HHY8kvtWW5Qv2CH2n0s/PBbN5BG4F2mUXRqiOirCHbgHutjulTpJr35gosuAE6Im
 tw8HNNmcCIU4FcUP8V7l3c5lyFtg6Vw4VNMQQ3Kcn2FW+kzHssqUfns1dqOSFBDKiPVS0ueweSp
 DncomTCi7kK/ESwxDFapxd9Bn378GYi/K0re52FUJfsBuSgoyFfOWdwCa4JUXopKyVAo3+2SJmM
 gVxJmmbqnAe6eXaHn0/PQVf4RvMF4Ta1gtG067oNQ8sQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Alex Bee <knaerzche@gmail.com>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Detlev Casanova
 <detlev.casanova@collabora.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 01/10] media: v4l2-common: Add helpers to calculate bytesperline and sizeimage
Date: Tue, 18 Jun 2024 19:46:25 +0000
Message-ID: <20240618194647.742037-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618194647.742037-1-jonas@kwiboo.se>
References: <20240618194647.742037-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6671e43264ade33c90059f78

Add helper functions to calculate plane bytesperline and sizeimage,
these new helpers consider bpp div, block width and height when
calculating plane bytesperline and sizeimage.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
---
v5:
- Collect t-b tags

v4:
- No change

v3:
- Consider bpp_div in calculation

 drivers/media/v4l2-core/v4l2-common.c | 78 +++++++++++++--------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 4165c815faef..9f749384a4f5 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -355,6 +355,34 @@ static inline unsigned int v4l2_format_block_height(const struct v4l2_format_inf
 	return info->block_h[plane];
 }
 
+static inline unsigned int v4l2_format_plane_width(const struct v4l2_format_info *info, int plane,
+						   unsigned int width)
+{
+	unsigned int hdiv = plane ? info->hdiv : 1;
+	unsigned int aligned_width =
+		ALIGN(width, v4l2_format_block_width(info, plane));
+
+	return DIV_ROUND_UP(aligned_width, hdiv) *
+	       info->bpp[plane] / info->bpp_div[plane];
+}
+
+static inline unsigned int v4l2_format_plane_height(const struct v4l2_format_info *info, int plane,
+						    unsigned int height)
+{
+	unsigned int vdiv = plane ? info->vdiv : 1;
+	unsigned int aligned_height =
+		ALIGN(height, v4l2_format_block_height(info, plane));
+
+	return DIV_ROUND_UP(aligned_height, vdiv);
+}
+
+static inline unsigned int v4l2_format_plane_size(const struct v4l2_format_info *info, int plane,
+						  unsigned int width, unsigned int height)
+{
+	return v4l2_format_plane_width(info, plane, width) *
+	       v4l2_format_plane_height(info, plane, height);
+}
+
 void v4l2_apply_frmsize_constraints(u32 *width, u32 *height,
 				    const struct v4l2_frmsize_stepwise *frmsize)
 {
@@ -390,37 +418,19 @@ int v4l2_fill_pixfmt_mp(struct v4l2_pix_format_mplane *pixfmt,
 
 	if (info->mem_planes == 1) {
 		plane = &pixfmt->plane_fmt[0];
-		plane->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
+		plane->bytesperline = v4l2_format_plane_width(info, 0, width);
 		plane->sizeimage = 0;
 
-		for (i = 0; i < info->comp_planes; i++) {
-			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-			unsigned int aligned_width;
-			unsigned int aligned_height;
-
-			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
-			plane->sizeimage += info->bpp[i] *
-				DIV_ROUND_UP(aligned_width, hdiv) *
-				DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
-		}
+		for (i = 0; i < info->comp_planes; i++)
+			plane->sizeimage +=
+				v4l2_format_plane_size(info, i, width, height);
 	} else {
 		for (i = 0; i < info->comp_planes; i++) {
-			unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-			unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-			unsigned int aligned_width;
-			unsigned int aligned_height;
-
-			aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-			aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
 			plane = &pixfmt->plane_fmt[i];
 			plane->bytesperline =
-				info->bpp[i] * DIV_ROUND_UP(aligned_width, hdiv) / info->bpp_div[i];
-			plane->sizeimage =
-				plane->bytesperline * DIV_ROUND_UP(aligned_height, vdiv);
+				v4l2_format_plane_width(info, i, width);
+			plane->sizeimage = plane->bytesperline *
+				v4l2_format_plane_height(info, i, height);
 		}
 	}
 	return 0;
@@ -444,22 +454,12 @@ int v4l2_fill_pixfmt(struct v4l2_pix_format *pixfmt, u32 pixelformat,
 	pixfmt->width = width;
 	pixfmt->height = height;
 	pixfmt->pixelformat = pixelformat;
-	pixfmt->bytesperline = ALIGN(width, v4l2_format_block_width(info, 0)) * info->bpp[0] / info->bpp_div[0];
+	pixfmt->bytesperline = v4l2_format_plane_width(info, 0, width);
 	pixfmt->sizeimage = 0;
 
-	for (i = 0; i < info->comp_planes; i++) {
-		unsigned int hdiv = (i == 0) ? 1 : info->hdiv;
-		unsigned int vdiv = (i == 0) ? 1 : info->vdiv;
-		unsigned int aligned_width;
-		unsigned int aligned_height;
-
-		aligned_width = ALIGN(width, v4l2_format_block_width(info, i));
-		aligned_height = ALIGN(height, v4l2_format_block_height(info, i));
-
-		pixfmt->sizeimage += info->bpp[i] *
-			DIV_ROUND_UP(aligned_width, hdiv) *
-			DIV_ROUND_UP(aligned_height, vdiv) / info->bpp_div[i];
-	}
+	for (i = 0; i < info->comp_planes; i++)
+		pixfmt->sizeimage +=
+			v4l2_format_plane_size(info, i, width, height);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(v4l2_fill_pixfmt);
-- 
2.45.2


