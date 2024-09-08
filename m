Return-Path: <linux-kernel+bounces-320456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C6970AA5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AC62814FF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DC317AE1D;
	Sun,  8 Sep 2024 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MV/Cn2Dj"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A017ADF8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838711; cv=none; b=byjDtwgQ/gXAbnCQRaRuIPELN9/i5OcKfwOu+SAPt1344bODrl8lbcPXJJOmSG0xvFp9vfAybddMQ/nICzEW+LTAKzLGJcUCQuUyh5VZjd9ZpoD0z7ouuf2i25bTWwTViKFvr2e8iwEQ1Q4E/FBvcnHyMO38nqPaz4kSC8+kEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838711; c=relaxed/simple;
	bh=Nza0r+2p2M53NFDlmSkbHUa/Z7sbfus/SdT6XtKcS8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6pXx9g1adne1YzXrlRKDXiObKWfJ+9mLuUirqMXG2GxU/H7fGvdyatkDq1w8up6QiAkODNTW0dYehDulEawQKXWAEDTYR7pmbbskhOnGRgPCiRvyZzKQaqqkoD4i5x1u0vFSYOnCN7MPnvTD1828oUVFJvGtrWpJCC1H7RJlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MV/Cn2Dj; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725838709;
	bh=R9weT10wr6KOl+Ic84Yt0g+UTCntOnJiS6nbyYbZDpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=MV/Cn2DjLfIyy15UjIeE0UErNmSp/nOYr/rwN3IbiKqMIU63rYS0SYTi0z9lXE0nQ
	 JfTA4DWz1YeiuGbUDxsVaj8EalPXTvvmdvyjZ+fCmtZbGPQ99t49O+PLCszhE0CsFu
	 0kn38BVJCVt7cRmp4Mx6lK0YZu6UBJZG8k8XBDf0KlVxWQ4CZx5a/b+fYsQvm4n0Xj
	 hXLSO7krCxI8BXEidb/t8SgoQUmCPTjLKfTkKssW3GxqOlJsI2X2t9dyx6y4e3AKa9
	 eiDfMUJ6EFgyHdZ1GDD+ycgq3tcOVT66i3lgiR+oh93LSxDqHH7/qF9W9K/D4+rbJz
	 hJCWnaOHWPLQw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 063B96E0075;
	Sun,  8 Sep 2024 23:38:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Sep 2024 07:37:33 +0800
Subject: [PATCH RFC 2/3] amba: bus: Move empty @amba_proxy_drv's definition
 to the front
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_amba-v1-2-4658eed26906@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
In-Reply-To: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Isaac Manjarres <isaacmanjarres@google.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: Otwz0-HFEKdwUYgprpPvUxRh7smtFmli
X-Proofpoint-ORIG-GUID: Otwz0-HFEKdwUYgprpPvUxRh7smtFmli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080205
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Move empty @amba_proxy_drv's definition to the front in preparation for
referring to it without forward declaration.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/amba/bus.c | 72 +++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index cc3c57f83798..033d626aff46 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -205,6 +205,42 @@ static int amba_read_periphid(struct amba_device *dev)
 	return ret;
 }
 
+static int amba_proxy_probe(struct amba_device *adev,
+			    const struct amba_id *id)
+{
+	WARN(1, "Stub driver should never match any device.\n");
+	return -ENODEV;
+}
+
+static const struct amba_id amba_stub_drv_ids[] = {
+	{ 0, 0 },
+};
+
+static struct amba_driver amba_proxy_drv = {
+	.drv = {
+		.name = "amba-proxy",
+	},
+	.probe = amba_proxy_probe,
+	.id_table = amba_stub_drv_ids,
+};
+
+static int __init amba_stub_drv_init(void)
+{
+	if (!IS_ENABLED(CONFIG_MODULES))
+		return 0;
+
+	/*
+	 * The amba_match() function will get called only if there is at least
+	 * one amba driver registered. If all amba drivers are modules and are
+	 * only loaded based on uevents, then we'll hit a chicken-and-egg
+	 * situation where amba_match() is waiting on drivers and drivers are
+	 * waiting on amba_match(). So, register a stub driver to make sure
+	 * amba_match() is called even if no amba driver has been registered.
+	 */
+	return __amba_driver_register(&amba_proxy_drv, NULL);
+}
+late_initcall_sync(amba_stub_drv_init);
+
 static int amba_match(struct device *dev, const struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
@@ -456,42 +492,6 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
-static int amba_proxy_probe(struct amba_device *adev,
-			    const struct amba_id *id)
-{
-	WARN(1, "Stub driver should never match any device.\n");
-	return -ENODEV;
-}
-
-static const struct amba_id amba_stub_drv_ids[] = {
-	{ 0, 0 },
-};
-
-static struct amba_driver amba_proxy_drv = {
-	.drv = {
-		.name = "amba-proxy",
-	},
-	.probe = amba_proxy_probe,
-	.id_table = amba_stub_drv_ids,
-};
-
-static int __init amba_stub_drv_init(void)
-{
-	if (!IS_ENABLED(CONFIG_MODULES))
-		return 0;
-
-	/*
-	 * The amba_match() function will get called only if there is at least
-	 * one amba driver registered. If all amba drivers are modules and are
-	 * only loaded based on uevents, then we'll hit a chicken-and-egg
-	 * situation where amba_match() is waiting on drivers and drivers are
-	 * waiting on amba_match(). So, register a stub driver to make sure
-	 * amba_match() is called even if no amba driver has been registered.
-	 */
-	return __amba_driver_register(&amba_proxy_drv, NULL);
-}
-late_initcall_sync(amba_stub_drv_init);
-
 /**
  *	__amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure

-- 
2.34.1


