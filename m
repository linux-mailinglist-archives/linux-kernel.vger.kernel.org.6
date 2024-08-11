Return-Path: <linux-kernel+bounces-282109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F375094DFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60A9285E0F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22FFC11;
	Sun, 11 Aug 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GuKG/6Bt"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267E136356
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343198; cv=none; b=F6ed6kdSNyRSlH5u+twEMDjt4Inpp2fGX6/xlQLJPG5iFr47mlhbCvpRLOWv9iLIJtHcvscLzjQYM46amTb2Kft/kC2ihXypjdFXoG9SrMkNVAo6xP/3R4H0dVhQxsNJoNqoAtKHUvvarB5DlmXx5nvCegmaM1rq7ad/7fHp1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343198; c=relaxed/simple;
	bh=mb0G+HxQJk+l/aHdHhQpWZNhlcMibvvbfrKlauNb2K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BY5Kfp6I+3tZlXaGz+Lz9RjpQikxvj34XNvhrsRTlaSgnS7OEFdIGKh7PaEM6GIro/LJumkGWxrerl5D4S+EygtnCX025pEbri4Ax7J0o4e7rWbH0bfcEOOXykuwBwxeNMqwat1ivnIkGCBjotWSCeDcpVSKBEhtRzJr0QZoCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GuKG/6Bt; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343197;
	bh=+g4mBQkh6MupbiFQliEfsoT2AQmY4nsPj0uMiqacrdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=GuKG/6BtxEPrOGWTwFM6B2t0CnG6qStOrXg5sOuWVr46fiD1MGz76VIka+CRnIKI6
	 V7qnw3ar1y1bLtCN8S79mwEkqDetOqQ3ZEcqW7AwnBdS9H1GrBiZxQXJLvde3Rg4tt
	 fXKtfCft+SkFPW+2RqgDWPHPl3y1lnu1hSzbSUk7Vg8yRKOJqCNfsILN11n8mOVjC0
	 TX/tNAyxZJsUa0CQmJvCZ9I9u/q+sc85mQgcMkIKG90agE9HJS03zcLYy4KSQnbXcr
	 +Q6rq4TK+OZY9SYCHcECyh29vLqJBEcHyvmupnZA+MqXiXdhjaW78dIEUEyqqupY/W
	 bN2vVdd/jzNuA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id B3B3E1349C23;
	Sun, 11 Aug 2024 02:26:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:12 +0800
Subject: [PATCH 21/27] drm/mediatek: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-21-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: ltfSFt4LptI7cz7TU7K8zVHhR7uGWk4R
X-Proofpoint-ORIG-GUID: ltfSFt4LptI7cz7TU7K8zVHhR7uGWk4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=899
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
mtk_drm_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index ae5c6ec24a1e..341c33443e46 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -357,7 +357,7 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
 
-static int mtk_drm_match(struct device *dev, void *data)
+static int mtk_drm_match(struct device *dev, const void *data)
 {
 	if (!strncmp(dev_name(dev), "mediatek-drm", sizeof("mediatek-drm") - 1))
 		return true;

-- 
2.34.1


