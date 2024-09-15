Return-Path: <linux-kernel+bounces-329814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA0979651
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C4D1F21CEE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85401C5781;
	Sun, 15 Sep 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xFJCeFEQ"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF91C3F04
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726395768; cv=none; b=thW1dvpDexQpqziIhdi8v3BLYvbhJ87UMK0+fWIfnYwEg5YfeSDckz+tXstN0XifeshI2XS+m4q/8Ry68mrxUtJORf4j2O6fdDQ7dyBLW8qB/CBGB6mEAlGiZJ1dQa8OymokJnBpHKF+c210ti9kJHUV77KcDzAG23dBS74L/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726395768; c=relaxed/simple;
	bh=+sJ0OrOXEgq7UI90bI0L4SlpgPEuxyy549UiGQ1rin8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AQzHlgU51zl3ZNAgU3s29rfEraJJZs77PLOcHkYKuxUIURR59Hj4bZQy7bvmfYH+g7OlSS8VKyJbPrQLEFTBGfyWbCxYcbT5bpIsClOb2GFpTNclxxNHS8Z9augRBBfOUVLGzFy/ITg53XZFq3czo0H3C2oK5QVE6J4Zqq4CNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xFJCeFEQ; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726395766;
	bh=oqAbZan6+77LyKCuKfYZkKy/ichudtq0Dz6GZTeGKQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=xFJCeFEQjmAXQ45k1NDWOgEvA+62eLBLw2mXaYijBvWDtkAUIzjindg9+6xjBnGSD
	 jyCTXGDOU+hvHnSRV6fXv9yIiA7XnJc5DoQklTweymi6NT4d3MA5EenLPokyHGe+Bk
	 F0IQE7hN+Ii6st6/bUhjjMPlwTsFnwEs4MmnV/bmzjZ2WnihdW8eSo8sfHrCVTpa2h
	 Ymmr+1WFG+0+vH4q1O/AKvQTfbyQF6aXbZi6GeozpG46kBRYtQC1walxK66G7S/+b1
	 O3M5EBZbOwuZX7z1P1saThK2qEweYt9+xXNk7Pt3h9x3SQ7EiaTJ+jCdV1uFk1827z
	 2yjQDdB4u8U1A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 6DF68D00528;
	Sun, 15 Sep 2024 10:22:42 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 15 Sep 2024 18:22:05 +0800
Subject: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEy15mYC/x2MQQqAIBAAvxJ7TlCxqL4SIZZr7cViJQnCvycdZ
 2DmhYRMmGBqXmDMlOiMFVTbwHa4uKMgXxm01EaOqhPrnazz3nqmjGwDPSJ0ZjAKe9ePDmp4MVb
 9T+ellA9jM3FzZAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: DpUu_JG1696Z0XYJeMucXl7eswEAXmPI
X-Proofpoint-ORIG-GUID: DpUu_JG1696Z0XYJeMucXl7eswEAXmPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_02,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409150078
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

driver_attach() called by bus_add_driver() always returns 0, so its
corresponding error path will never happen, hence mark the impossible
error path with WARN_ON() to remind readers to disregard it.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..59a48edda267 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -673,7 +673,7 @@ int bus_add_driver(struct device_driver *drv)
 	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
 	if (sp->drivers_autoprobe) {
 		error = driver_attach(drv);
-		if (error)
+		if (WARN_ON(error))
 			goto out_del_list;
 	}
 	error = module_add_driver(drv->owner, drv);

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240915-bus_add_driver_fix-f54841e6a69a

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


