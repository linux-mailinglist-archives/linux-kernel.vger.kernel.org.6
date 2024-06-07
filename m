Return-Path: <linux-kernel+bounces-205596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C08FFDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442DE1F24034
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AA15B0F3;
	Fri,  7 Jun 2024 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fhIEYSm6"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E54E15A863
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748777; cv=none; b=e4nEoAVUTIIGaUd3jf8zr7Qc5tMPvyPNmb8SQC7AicdSdHbgzAWvtK5I5SetciLaJgqLDoe+CY76sTecsyPwhgtuAcVKcHRbbkmKbafqRdkyBnuEIM2FNdtKEra4liarcujWbz8ZOsca232s3x3r0zqK20zHM+Ga5zcdy4qrLtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748777; c=relaxed/simple;
	bh=6RYn8Ak83TO778TRb6ww3Lrzb+/vIQANG6vEzYSNBU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJkp+YX5OPnBg8wZg3mTKJq9juKKu6dtGUObrhfWZSQR2m/tQ0wOMFJs/pA4D+19saAoen51ewnsMYPEY5P/ZMizaOFm+teAOqDv8d/X8MlGMj99sVFs+wZ95F0JEy1sSpA0IsFw/owumM0qwmsSQkA9/C0YaqJb4Z1guR7b5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fhIEYSm6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sakari.ailus@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717748771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ORHnZa81MTx79wWzMdPXEmgkK3/n9+FWj6CNynHAa7A=;
	b=fhIEYSm6XJiVQ/oi4DVYTdIFml931HDUrr7Ti04GWauP8jXhgzYx68/moxavLp0q+dcKSJ
	fAgBag2bNI2yB0m21NBk+xPpzBWm+6aSaq4pUy587D4svrXClPqc5pU03Qm0d9434FnMjN
	P7U9NZB7jZAyo8E8uFdFAIf4RWO2Cv8=
X-Envelope-To: bingbu.cao@intel.com
X-Envelope-To: tian.shu.qiu@intel.com
X-Envelope-To: mchehab@kernel.org
X-Envelope-To: hverkuil-cisco@xs4all.nl
X-Envelope-To: linux-media@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gehao@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	tian.shu.qiu@intel.com,
	mchehab@kernel.org
Cc: hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] media: intel/ipu6: Fix a null pointer dereference in ipu6_isys_query_stream_by_source
Date: Fri,  7 Jun 2024 16:25:42 +0800
Message-Id: <20240607082542.380166-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

stream is NULL when source is less than 0 in
ipu6_isys_query_stream_by_source. It's a null
pointer dereference.

Actually, this should be isys->adev->auxdev.dev.

Fixes: 3c1dfb5a69cf ("media: intel/ipu6: input system video nodes and buffer queues")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/media/pci/intel/ipu6/ipu6-isys-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
index c8a33e1e910c..06090cc0a476 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-video.c
@@ -943,7 +943,7 @@ ipu6_isys_query_stream_by_source(struct ipu6_isys *isys, int source, u8 vc)
 		return NULL;
 
 	if (source < 0) {
-		dev_err(&stream->isys->adev->auxdev.dev,
+		dev_err(&isys->adev->auxdev.dev,
 			"query stream with invalid port number\n");
 		return NULL;
 	}
-- 
2.25.1


