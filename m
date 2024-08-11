Return-Path: <linux-kernel+bounces-282114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8C94DFBB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89DE1F212FC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B651422CE;
	Sun, 11 Aug 2024 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="B1i18ia9"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA11422B4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343218; cv=none; b=GO/NkqgLx1NMidnIuZHOFjOhnb0rqk8EKJGTgHpCYaAR7I+v28TVBzLKEgyvvtOXIC3QHKdi1P+YlcEdlGSslkm8LNdyOd7rRkRrSpmd6vIfJW5Xgz/pdurTAHT3VlPbpNrT0b5YRHgzhK2Z/Tt1EQ4YQlqCpunSwduKiGPwWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343218; c=relaxed/simple;
	bh=U/1KeSEJ1o2NIaUuPL0nzGye+nXJSZZoH+OZvBaNRVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDt/3knhizTTf58FAP6AK0fcmCnhebbTbQnoBDg4cWGh/Hm8EfKcIgOoy2MXYe9mvaT/VTw0vaQPgsgGvOSGXoLN10MPisjvvK5njkKERQgSU0qz1+iWNGIc8v7tdcA3YeuYwZRUcCBzv588Bt8mGttoAv77UPv54m0mJoWX2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=B1i18ia9; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343217;
	bh=pEhtX+3HMRz67HYx5ENhmWRr249rHe9pn/7BosYTo4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=B1i18ia96+Rl8hvZ1BCCrYr2JsrTVgke/EhvhwoVVjCSqRAuJa5vGmfzDK2sMlNbR
	 cSDaNWjV05akcbYcGBbeX5Qx8IxNZpjbzq7VNYEbAf3p0lc02ksQgMiBAC7ujXB52D
	 9EonPZLznPHYrsyC9QeifuxKY3VQ+83RkUF4+QQYIjuy1z4kcPVaa9yuBPMqVtCZIH
	 QaOPDlgjFFdUJ4OHJvSHvxIhIv2M56mK6uy0ia6p1eO1RHpgvTx+vTl4fgEOojca0H
	 tdIVdOb7QlWvP+/m3AgxRK8SogxDKgfBkR/6/0xQscgNEiJG4td75SFxaV9abvNKoZ
	 31308+bez2DEg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id BD5101349C0A;
	Sun, 11 Aug 2024 02:26:53 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:17 +0800
Subject: [PATCH 26/27] net: dsa: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-26-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 5RWGq73DgIiCZGocwi8Ya5bqJtlBxyDy
X-Proofpoint-ORIG-GUID: 5RWGq73DgIiCZGocwi8Ya5bqJtlBxyDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=878
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
dev_is_class() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/dsa/dsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..a12b35f34c73 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1367,7 +1367,7 @@ static int dsa_switch_parse_of(struct dsa_switch *ds, struct device_node *dn)
 	return dsa_switch_parse_ports_of(ds, dn);
 }
 
-static int dev_is_class(struct device *dev, void *class)
+static int dev_is_class(struct device *dev, const void *class)
 {
 	if (dev->class != NULL && !strcmp(dev->class->name, class))
 		return 1;

-- 
2.34.1


