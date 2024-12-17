Return-Path: <linux-kernel+bounces-449227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6CD9F4BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C06164371
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44981F7082;
	Tue, 17 Dec 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CCYir3uY"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337B1F7080
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440884; cv=none; b=aKLb0GpR7cJSLD/BtRYe6BK61F0TNMKGMhwaGm6UBLilOwLO2Wy8X4mSl9Qo7M6efiwv04GuFraK0MN3UTsPTZVbMgzsOZnQW1jsVIyUuPEPq11UZ+paWkHpJ1D6qoKRPtrI2t0QntXdaDbR0/B1DQ6o6BUCH5NrfcPztpylJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440884; c=relaxed/simple;
	bh=80kccgYvnj9G84Nx3IR+WA53NzpjDh/0RaEOK5puNy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkRdJXeM+rom9042Qb36vzG7AJGmEE07EgPzZpr+TiNgBz5UkM65qbtMjx/5Xt6Sp3+ytrPrTH13LhsqvLy0b1rEU0b1N8KfdCRB1qPDyVQV2brNcjEUKu6r0g6kO07QFK8Yywv5f0hTKWR/7Yz/fk7v2etSXcgOhQyXCmj/MbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CCYir3uY; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440882;
	bh=lMZVZTNsgFOCxTCYXq6jCFsMl6EKNzODNeFIS1bvHJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=CCYir3uYmXczp6PJO7Nuqq7dUcOhXSDKEMvDXNs4queIizGHQGfNBJn8VBoPZP7vU
	 NjX3IqCw4qHjoWig28bhGbFXtSYhW+E+M2UU+cQ5Fc92dcl17hOTc2BYztB8bwU6zr
	 AyjHkLrLKGQ6xBxuK/qYcqxBTUvoOcWIWmYDCTsqmQvxBp7FJmo9+kSfYgD3HCTeLX
	 E1ysgZHFMEMZA3Glmin5Z3GnfaJptBNkX/dTcdP27ywUhJVoh6qzbSW4FWtQWryvfE
	 YSN5WSJ7DuMGWgoVEYgg0vRJ3etGSJ74D0LlYss6wn4ddnCuFmhCuvXT1/OGTQDp8h
	 9Jefb2E6IAjMA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 69495960149;
	Tue, 17 Dec 2024 13:07:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:28 +0800
Subject: [PATCH v3 4/7] of: property: Use of_property_present() for
 of_fwnode_property_present()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-4-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: kufwwEZd3X6wKqziTvihiCvdPK2IIf84
X-Proofpoint-ORIG-GUID: kufwwEZd3X6wKqziTvihiCvdPK2IIf84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Use of_property_present() instead of of_property_read_bool() for
of_fwnode_property_present() since the former is more applicable
obviously.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Hi Rob,

i pick up this change again after some considerations as below:

1) of_property_present() is more suitable than of_property_read_bool()
   here, deprecated API is not main reason.

2) it does not conflict with your job which warns when use
   of_property_read_bool() for non-bool property.
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 519bf9229e613906547b57d8c68e7b8558eff327..dca1a3ebccae1093b2b11f51e8e692bca854d0e3 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -966,7 +966,7 @@ of_fwnode_device_get_dma_attr(const struct fwnode_handle *fwnode)
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
-	return of_property_read_bool(to_of_node(fwnode), propname);
+	return of_property_present(to_of_node(fwnode), propname);
 }
 
 static int of_fwnode_property_read_int_array(const struct fwnode_handle *fwnode,

-- 
2.34.1


