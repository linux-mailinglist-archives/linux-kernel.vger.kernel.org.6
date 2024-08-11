Return-Path: <linux-kernel+bounces-282106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1894DFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6ED3B21A62
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C487770EB;
	Sun, 11 Aug 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xoIR48xA"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C58F48
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343187; cv=none; b=U7sC2mXqtq/dkk11xpreKDzG3ZkHsXZjeMokCZ3VrWa56nnQIaenIKX8U1w0r10VxgJyUxSaPDkGf1pfTHn3DL2Bd4oOfJlrAZGK5G4MmQjrCL5kNKpacV8gtAyfDSb50EsgOkdNbhGC2GoIdiGtkPqVpKsmiWEssPb3Pn+p8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343187; c=relaxed/simple;
	bh=BriN3yR+9MIH3QB/WMzn3tVl4FUZeQ3YSaFvB4qz7Ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sw+jUXjR1BCVNm7hfj8GqLLzZq6qBcRGZUz5M5Gfx6QTekLD7zEDGacw1YGZVPNGIYeXtMefcDIXnmVi4SLH96Vmvq+R/xcwSL05JOkNGumNS9sGi+VD9KForos6ztEeSzfI5w+cKXB41okkNXhrpIrG5bvV926Zo7tXFbUbudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xoIR48xA; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343184;
	bh=2/NupyIrANJr/Co8Eiqzx2QIPv6EbbC2V7V1sBhvbVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=xoIR48xAHwqYOPCf9a2x9QFr5xtMwsyqIm7bRwvqARvi9V/svDw2FwK+CRuwQ12JO
	 LgMIaJe2wJxhxGa1sAy0plgGvm/I9dJKPfc3cPjM6IUfDl4B4onP0G1j+cEU+FBExY
	 41Aib3NZAz28TvZYWN99Wl3LsmSQSSl1yfLknGyL0hYDCZPwgmp/nWLqBAWZnUmFtO
	 z3/y0REd/6Gxg3nXGoZjza2EPjOQ4WEClzmpGd9YY7S4d7AHGSeSyTNDuM0M6L1p1u
	 Y8yDayzNmK4WFQO4+NAskvCO3i7mEnOdpmD13RYiwz3RpyFAypu0EeUDIQaFXXHkcs
	 eb7MBndNDUkbA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 96D021349C0A;
	Sun, 11 Aug 2024 02:26:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:09 +0800
Subject: [PATCH 18/27] block: sunvdc: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-18-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 2arTWcDn8sAgDf49MjsQg3zJbpkRJZhE
X-Proofpoint-ORIG-GUID: 2arTWcDn8sAgDf49MjsQg3zJbpkRJZhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
vdc_device_probed() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/block/sunvdc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 2d38331ee667..5e0759c8d459 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -918,16 +918,16 @@ struct vdc_check_port_data {
 	char	*type;
 };
 
-static int vdc_device_probed(struct device *dev, void *arg)
+static int vdc_device_probed(struct device *dev, const void *arg)
 {
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct vdc_check_port_data *port_data;
+	const struct vdc_check_port_data *port_data;
 
-	port_data = (struct vdc_check_port_data *)arg;
+	port_data = (const struct vdc_check_port_data *)arg;
 
 	if ((vdev->dev_no == port_data->dev_no) &&
 	    (!(strcmp((char *)&vdev->type, port_data->type))) &&
-		dev_get_drvdata(dev)) {
+	    dev_get_drvdata(dev)) {
 		/* This device has already been configured
 		 * by vdc_port_probe()
 		 */

-- 
2.34.1


