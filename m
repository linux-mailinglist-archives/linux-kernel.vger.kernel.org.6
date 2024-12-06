Return-Path: <linux-kernel+bounces-434176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFCE9E6299
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFE628383E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5013A86A;
	Fri,  6 Dec 2024 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pWbqZAPx"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8D1DFD1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446420; cv=none; b=dMZf41l8uGahwShyDoN/TTzgpGKP/en9tPkSv2pSLBW7Gj9TsXYMb23BIZDDEIs9ZZ2KezQ3ac5c3/7yJxLrRxCrO+dHM8x+tVg+GNxjjBD/hhXVvke8SLKDFXsE2lglqF7VRhh5X7iWqumd13q/8fLQICBbNAYW9lGvCyThEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446420; c=relaxed/simple;
	bh=FgwvHjDGIbQG/R/BNUFvSMUMH8Fj/yPF7XlOjRUkyNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKNfTJbVc5XmF7MTFI6Wcwekrrhv4PEWwO40KRcAgRazb+oC1+Y+h6xAYiuSHz+Gd+qfbP6Mo5nSEsMMe6YFInMA/mcm/g7F+/jZp/LNjOqK4WuTDFdrRWys9CiLqhU7rVj4BONfTxf6s1awW/BiVw4jBKdi7P4r0bGbVuXgWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pWbqZAPx; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446418;
	bh=3+suBHwqaJPwVuU9nWF9+bbade9Tamq+5YBxYiQbdDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=pWbqZAPxRYhijtofVz4kvariE1IES6fKMu8pshJJFQuAkdHlhBqQmMmz1uHqhcG0F
	 uiQMem94lNr2DcmjE+Yjlw71vsu1ZS3tOA7zR8loN5eZXxVTwsYJlTSndaTXeJcBrs
	 +xZ9NXM1pse+VdUbzBoH5oN4T/Ezn1AdptUkVYSefxkZbrp5dbzASkKHLUAq7Raq8V
	 IH7UQ+6f79gVv5ETySUhNrAhzANnGuanvhCr5/ywqSNUDT0LzaUBrLvhxolbnHHIaW
	 e9QmwbNoqgZg8ZAk2ZgYkUfvtRd6PTbv+KhYf+ZPiKDCJZ6UKdi5imBWNh5GOmE5b1
	 ozkh/82CSp26A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 11E45A02C3;
	Fri,  6 Dec 2024 00:53:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:31 +0800
Subject: [PATCH 05/10] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-5-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: K5CjjhjSYBHgKtGr_iDbQTSXbi0zQvw0
X-Proofpoint-ORIG-GUID: K5CjjhjSYBHgKtGr_iDbQTSXbi0zQvw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=978
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_device_uevent_modalias() saves MODALIAS value from offset
(@env->buflen - 1), so the available buffer size should be
(sizeof(@env->buf) - @env->buflen + 1), but it uses the wrong
size (sizeof(@env->buf) - @env->buflen).

Fix by using right size (sizeof(@env->buf) - @env->buflen + 1).

Fixes: dd27dcda37f0 ("of/device: merge of_device_uevent")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index edf3be1972658f6dc165f577da53b10c7eebc116..ee29c07c83b9e6abd9b1c7747dd341026bc79eb0 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -266,10 +266,10 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 		return -ENOMEM;
 
 	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
-			 sizeof(env->buf) - env->buflen);
+			 sizeof(env->buf) - env->buflen + 1);
 	if (sl < 0)
 		return sl;
-	if (sl >= (sizeof(env->buf) - env->buflen))
+	if (sl >= (sizeof(env->buf) - env->buflen + 1))
 		return -ENOMEM;
 	env->buflen += sl;
 

-- 
2.34.1


