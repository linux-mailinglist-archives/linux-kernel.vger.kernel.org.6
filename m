Return-Path: <linux-kernel+bounces-449226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF09F4C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A21897730
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060C1F706F;
	Tue, 17 Dec 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tFh43nMm"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518B1F6697
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440880; cv=none; b=rA7d62O4VVIGeKf0mRDxaMSeLvRwfoMk8RcbDS5ndKyW4glz9P0UUQL2It/dAod/W4Lqnlg0E+7DsdnpCeQOO68IALpGuhvMgGvBOhe30dPgh/V1ghukHXQm96ht2DJgsF3vsp+GyA1rv2iTlnS0T0scZXSmWRkRxws8DmYeR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440880; c=relaxed/simple;
	bh=hhxEV0PSOUDlgXbkxbGpMJBooUyQNe8CgBoY6/KKj6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKtgzt8VGYUnjWTNgCmOa8U1S7GtU+RXIXujeA1jZ9qGC1FTkRcDMY/HHVwytpWFVmm1WEd749M28rGbEeaX+m5xdwK2uE9tZ41HR1F37MZoBhJXCBcuqhaJrqgfQEsO/sYmyiXXe0Yg1tShdkiFv4mZJVUFfgxEwRh/8Ad6iBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tFh43nMm; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440878;
	bh=voAtwf0WkjLnq9xLBA6Vyr9IuEpPzAqCBFAvUL3PwiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=tFh43nMmV+NdMxAnc4CkQ1UTWvNJYiWtHdYdKzOgP9Cgp6Yyn6iyRxgjAC9TOzJ6x
	 jijktlBQHL56tH1x2nkwRqN8c6oECZ4TiBQppmGaWeoKpBrQMJ46iBEWpC0nlcWcLF
	 cDyoiQsHPcYyCV40NFLcLpN6suvkIgoig63A+r6buQxUcfmAkPAteUNcMt2HwCfCME
	 hwiLXC9jNeBWynoaT88FXoP6rDD+yGZVhz1TxLn3+zfX0CP+v3QlZ5Q6+QgVyUp7k4
	 wjYRrwhqvCQiek4fEgvSX+epnNpqj3uofz6x+Yi3XK58xEs3YlJnvo64Rbl6zmTVU1
	 /eauuKkB7eRbg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id B70379602F8;
	Tue, 17 Dec 2024 13:07:55 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:27 +0800
Subject: [PATCH v3 3/7] of: Make of_property_present() applicable to all
 kinds of property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-3-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: MPjhAigLLIVMa9QiJ-HN2NhYXLis75LI
X-Proofpoint-ORIG-GUID: MPjhAigLLIVMa9QiJ-HN2NhYXLis75LI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=767 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API of_property_present() invokes of_property_read_bool() to check if
a property is present or not, and that has 2 shortcomings shown below:

- That narrows down property scope applicable to of_property_present()
  from all kinds of property to only bool type.

- That is less logical since it says a property's presence is decided by
  its bool property value.

Fix by making of_property_read_bool() invoke of_property_present().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/of.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index d451c46132b01efe6d4e0b6cf83a3e2084bb3ec6..fe5d7b74c23b9701743f5debc3d030b765bc914f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1242,17 +1242,16 @@ static inline int of_property_read_string_index(const struct device_node *np,
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
 
@@ -1260,17 +1259,19 @@ static inline bool of_property_read_bool(const struct device_node *np,
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


