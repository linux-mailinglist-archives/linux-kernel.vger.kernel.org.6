Return-Path: <linux-kernel+bounces-282103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FC94DFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DFE284A21
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462874E1C8;
	Sun, 11 Aug 2024 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="BYpsvIL6"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60055888
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343174; cv=none; b=Y4bMGnDIb5ZTBEL+/nTLiodBqoN5+f01CC6MfnrELE+EFrYCgbDermExRHyFOQoRC9XN+p852uKliWjbBLtPHRw+mroVUrR2BwLzoq0EvRr+a+UYpcsfKUDpbqVZJDR2/ZMZ9cTEs2qVHmzblnTVIYv4jt33Sz4/v1a/ZkdrjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343174; c=relaxed/simple;
	bh=r/5oGYk2H6Q2x/EMUnenuEHcX/fZPwHRlp7lM7c7U9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COaz0VPqqpPP4+loafneylI95oHOJLUIdeFjAfu/ViKhKsbW/elDQ2sWG2gGyCD1oQCqNCzpdN2dHwcJhYay/IpSFvAPny/6aH56WFvzePT2qLhg+dC4/pqUa9M4TRrdhLoRsU2Ha9cElx19hkUUkqPrwqysHNBXxdqYqcZpjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=BYpsvIL6; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343172;
	bh=JJN5rl9Xw4CgbDwY/3GK6xpyTBTQIxstbhW6CcltL2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=BYpsvIL6ioThyUSLrpZQdJhR4jatURX+mhS8QDUJaNZcBfwvWeBCRapnQ3Z4r4ypO
	 NwqfmC7HdgxYC0j+udaRtJbxTOPXQ7Ao+ctbfw9SzofBjIvUwS8NCAF1ctYMX/ldF+
	 PXAhizIdNsWcs7HBpOwX/UaRR9hciYtchgebJUmZeqB79Q2nfrETrkeHGbYQxqOdqe
	 Wsl8YMHIIrrh6aUGS9whA0TKENrKetO+Kmek1Qsd8QreWOTXZVtRGj8QsbK4zwhExc
	 6K5OG/6F/LzsG/tGpdZHlSrM1Y2QjhQJ+kKhG6eA5PUnnE0rtGUVclaB8K1ciYF8Qj
	 hty2merkjJCTg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 7AADC1349BB3;
	Sun, 11 Aug 2024 02:26:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:06 +0800
Subject: [PATCH 15/27] cxl/core/pci: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-15-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: v2Cu8FdPQIYMOJinywM_sSxsM5Br9DlD
X-Proofpoint-ORIG-GUID: v2Cu8FdPQIYMOJinywM_sSxsM5Br9DlD
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
dvsec_range_allowed() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/cxl/core/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..e1bc565d7801 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -283,9 +283,9 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 }
 
 /* require dvsec ranges to be covered by a locked platform window */
-static int dvsec_range_allowed(struct device *dev, void *arg)
+static int dvsec_range_allowed(struct device *dev, const void *arg)
 {
-	struct range *dev_range = arg;
+	const struct range *dev_range = arg;
 	struct cxl_decoder *cxld;
 
 	if (!is_root_decoder(dev))

-- 
2.34.1


