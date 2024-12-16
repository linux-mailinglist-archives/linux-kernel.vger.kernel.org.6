Return-Path: <linux-kernel+bounces-446652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145969F2795
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC7F163E60
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8078442A9B;
	Mon, 16 Dec 2024 00:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bcDO002/"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B6E433B1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309686; cv=none; b=K65IijcLu7g4juTj2yoIiqNQdP5eE0fOOBuhY+ErRG8bM2gA9gFQAXVK74iWFtIH7XXD/N7pbpCJwqCZ2H3j7zciBGku4ysksx/6TuOPbcbPg+w2MmPulO61yg7NYtDUio/PP1ZYPWLAmR/34Hy2m/FWFEn0qXlGFgGnId/yIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309686; c=relaxed/simple;
	bh=SsxIe7B8Ubifh8yxK4TNdpGpDInnToF21ZEilh+Nrlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtdlUFrzsDVetiOgXPVSpBs7/smZqi05arVqv6xERQK5F4IMZeFznh8aAltkR+2r/bnIvz+1n6kfhOINTM8A/ADWkjQKIbAC8wy5ptYyTP8KML21+RJYGS9xKKNh/Cxtsg3qTfT0UZ4xabwbS8fc13MFx5fFEetlhdN+B9Anzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bcDO002/; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309685;
	bh=skHmLwNtPEPyB8SzViTBhLp6k6+TIgi9ScSYe4Bfhms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=bcDO002/ZMap/j5xp+inXucALxs9JebnMRwDuOV6gS+5ycMPAr+w6bPiSlhQilEh6
	 XB2UXgufVYcSrrKnlCBDQzvC1M5vd5bAU9+gKfHgcrj/AH9505IAm56EwXbXl+h01w
	 SECGGPz3KsciPGVpmyLNJWVN9gyzTDnqq9XGy72UKnEZQ51gcTcwc7wDlsF7lHz3Om
	 9/4LXgINqar6cMyAo5JosImZ9AGO55j8Xq6/UPgWS6YxmwkHSia9UprLBx9Ff0K3uD
	 o6XQMPSCWnFEP3cN6DuZ8FIZ2A6qCA1nXdNsgeIltOp/92MRk7bj+vtr9VNycloFX/
	 JKSG9E4OLqOjg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 64B8FD0028A;
	Mon, 16 Dec 2024 00:41:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:43 +0800
Subject: [PATCH v2 4/7] of: Exchange implementation between
 of_property_present() and of_property_read_bool()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-4-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: KkO7ASRbB1myZ90BDPATCssXqKJrUehG
X-Proofpoint-ORIG-GUID: KkO7ASRbB1myZ90BDPATCssXqKJrUehG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=848 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_property_present() is to check if a property is present or not,
and it should be applicable for all kinds of property, but it calls
of_property_read_bool() to implement the function, so narrows its
property scope to only bool type.

Fix by exchanging implementation, namely, changing call chain from:
of_property_present() -> of_property_read_bool() -> of_find_property()
to :
of_property_read_bool() -> of_property_present() -> of_find_property()
which looks more logical as well.

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


