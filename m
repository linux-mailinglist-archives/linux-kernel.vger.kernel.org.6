Return-Path: <linux-kernel+bounces-226580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C958E914093
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2BF1F23A16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555D523A;
	Mon, 24 Jun 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QOZAyQex"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184513C28
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196894; cv=none; b=k787710dcCfZMKfBiXypMvygduBYbH5ZL1S/8zmmKegA5NnFSzUWEdCuzJZHI1EUw1phUsgdwUdsSgA8XXCg+doimaWxo4XVLPykTKPpDDgwQjmZoHbXzlscHzeXa8Gwr2FzMKFiMjIW5w2oADTKYkpoC2HmW4QXHyfgppn1RPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196894; c=relaxed/simple;
	bh=NndsitpSTsm3dS2jqJlAkF6vHl5zfdq/fvk5Tbz8BWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=to+5y/8yIcFczLd3rZLBccR/4j4GRD96h7XmdxrDbzNoFTGSKeWtBdXwdsVAb6gOUMDh0AGzaCVNwo2BC+nw8i0nvSzBj8PuRWg5IxagTbO4j5gwCIm/jolNBlfu1x77vovsHM9cEGxRdiCWzhHJtoHYfv+GmAT4jT+/rTCqju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QOZAyQex; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719196884; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/xgdevl4TYnHfGR8fctsT0v4UfOOmmnya9bKIxDS7gw=;
	b=QOZAyQexw+fRX+OQOj255xEP45jcEEntFqAxUYKlt3+oL2cBy7o0ItcvjNc04HV3ery9me2ydgtSSWEU5zfhGjNfV+HrXAxXk+hwgnkmNqauNiir03oQ0usz/jbK7mgh9mQtpO7VRGt5P88TDo9eSSff9Ewocu+1MKavKAoYy1Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W90yZxq_1719196874;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W90yZxq_1719196874)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 10:41:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: yannick.fertre@foss.st.com
Cc: raphael.gallais-pou@foss.st.com,
	philippe.cornu@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/stm: ltdc: Remove unused function plane_to_ltdc
Date: Mon, 24 Jun 2024 10:41:13 +0800
Message-Id: <20240624024113.54850-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the ltdc.c file, but not called
anywhere, so delete the unused function.

drivers/gpu/drm/stm/ltdc.c:494:35: warning: unused function 'encoder_to_ltdc'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9403
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/stm/ltdc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae4962..3f280155e25c 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -491,11 +491,6 @@ static inline struct ltdc_device *plane_to_ltdc(struct drm_plane *plane)
 	return (struct ltdc_device *)plane->dev->dev_private;
 }
 
-static inline struct ltdc_device *encoder_to_ltdc(struct drm_encoder *enc)
-{
-	return (struct ltdc_device *)enc->dev->dev_private;
-}
-
 static inline enum ltdc_pix_fmt to_ltdc_pixelformat(u32 drm_fmt)
 {
 	enum ltdc_pix_fmt pf;
-- 
2.20.1.7.g153144c


