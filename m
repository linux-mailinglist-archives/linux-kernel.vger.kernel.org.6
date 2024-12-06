Return-Path: <linux-kernel+bounces-434179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F889E629F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ECA1884221
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC8126C04;
	Fri,  6 Dec 2024 00:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ckdP6A42"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D4126C0A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446441; cv=none; b=QPaU/WJ0TdCxp8hMOhVL0D0lm5MBSWjNQRtKZLWzIirhK6Lgq+vINUrH2z5JM8wo20L0IZvZMWQ3WUAZpkVBtKMSvmZEIm7RpC9yyYcu4kiTQtNirTiPRTuwQU6PrAE1/eXwGoxYLSHW6xwcX5yGIlmpKuElVm8ssxiqMLS7M/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446441; c=relaxed/simple;
	bh=Ve3n7niyMk1tbFP7EFflEAAnysU9QzXXKxfUINvS3wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFSoHanlf1cobEd7PtyfIuLQR14AfapP4oe4U7dN8Yecm6N8bUl0Q5hSB4Y9UjleL7zboswQhicWGEkqk2J62qRO7qXNdIC2T/UOftbMYVGXxywvyH/H+cuf3CZsdntbKe9V/vO61V3Tjlp/UJrodtQ+wEiTLaqRq8WNdjRh068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ckdP6A42; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446439;
	bh=ZlEoJI341ZSEvnqS6oDGrnWUpLJKotzXqO9H+UmL4dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=ckdP6A421aaBj/IIvvr5OxHE1DOGGumkgD2MQrttU+nUS76oaXVBQCDBEJo4iKDMZ
	 jpMD/hZmld5ybRG27CyiTN85poZL9ECHeXMwKKqVYKP/3SznpvQ+QalKJXUG1TamrB
	 Qs0nbhxRl5o4kaSh09Sk1JneWVEaNMymZxOwnkdNE3zGA7kjqvi6/H+KQofFUtPjGU
	 JEbQvBIBl2fTGzOoDnsAgmjaSuy5VuJZKktRjSrXdljBAEoZ4Dxhc81WsMtPaOnD6p
	 cYKHawZAhU73n8kgP+g4CA1Y4mOUmjwW+B2JY9xMseErO7fr7dzMm9iuaN3a0FA3DZ
	 RUs64ekbmjRow==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 0ECA9A0287;
	Fri,  6 Dec 2024 00:53:52 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:34 +0800
Subject: [PATCH 08/10] of: Swap implementation between
 of_property_present() and of_property_read_bool()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-8-dc28ed56bec3@quicinc.com>
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
X-Proofpoint-GUID: PXcWkQ90dxDs5MfUk7htivn02RgapTAS
X-Proofpoint-ORIG-GUID: PXcWkQ90dxDs5MfUk7htivn02RgapTAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=857
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_property_present() is exactly same as of_property_read_bool().

Swap their implementation to make them more logical as shown below:
find property -> property is present or not -> boolean property value.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/of.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index f921786cb8ac782286ed5ff4425a35668204d050..7b0da8d352dffd8b872998903282119b6164a5bc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1243,17 +1243,16 @@ static inline int of_property_read_string_index(const struct device_node *np,
 }
 
 /**
- * of_property_read_bool - Find a property
- * @np:		device node from which the property value is to be read.
+ * of_property_present - Test if a property is present in a node
+ * @np:		device node to search for the property.
  * @propname:	name of the property to be searched.
  *
- * Search for a boolean property in a device node. Usage on non-boolean
- * property types is deprecated.
+ * Test for a property present in a device node.
  *
  * Return: true if the property exists false otherwise.
  */
-static inline bool of_property_read_bool(const struct device_node *np,
-					 const char *propname)
+static inline bool of_property_present(const struct device_node *np,
+				       const char *propname)
 {
 	const struct property *prop = of_find_property(np, propname, NULL);
 
@@ -1261,17 +1260,19 @@ static inline bool of_property_read_bool(const struct device_node *np,
 }
 
 /**
- * of_property_present - Test if a property is present in a node
- * @np:		device node to search for the property.
+ * of_property_read_bool - Find a property
+ * @np:		device node from which the property value is to be read.
  * @propname:	name of the property to be searched.
  *
- * Test for a property present in a device node.
+ * Search for a boolean property in a device node. Usage on non-boolean
+ * property types is deprecated.
  *
  * Return: true if the property exists false otherwise.
  */
-static inline bool of_property_present(const struct device_node *np, const char *propname)
+static inline bool of_property_read_bool(const struct device_node *np,
+					 const char *propname)
 {
-	return of_property_read_bool(np, propname);
+	return of_property_present(np, propname);
 }
 
 /**

-- 
2.34.1


