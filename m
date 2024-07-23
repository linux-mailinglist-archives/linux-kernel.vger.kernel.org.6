Return-Path: <linux-kernel+bounces-260119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CB93A34B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5861F233DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98C156F20;
	Tue, 23 Jul 2024 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="K0g7l6sq"
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD30155C90
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746586; cv=none; b=i8CGqp4uGXQjLRmmOIYL1KeyfreXMn0RaY7Z+/sral2UEi0++nHCZ+RF/n2FmIYrC3ufeN+aDE6b9XR/yo/It5Fjt3Gb5WpjSbGhVDZZ+O4xdo6+FnXLb90zANZGNsCwsk8pSMG86V9vrX4zS27z5mVagGHMcdXw1X7hBDhEsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746586; c=relaxed/simple;
	bh=Ity5SPhPYkwt0NIXqnT8nBIAURS+H9eMq5wiFgAKMvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TC2ZSuXvY22+ZTSU3hrLFBeSd5GnlJ4drzmEXBbfz6alpG5NQMp2MLr4hUSYkvii3RGo3zGTa6p46ZkJDcNYVFODfwOUNiXDB2shz468i5+cK3A6lB05MS7DKoiHbL4kxCGteAvsjG8zqJ4lAYFDFyleyHa4ts8nwbYH37ahdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=K0g7l6sq; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721746584;
	bh=6yhhCitx5LrEVkNAYln10FxRHBsFejDovxB05lLfkCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=K0g7l6sq0PvCoevbB5mk0FEo/FO/trbf4i/P1Uki7XnWtQPd3XI4YdQVsAjrfaZ1Y
	 rmpqdP7LRPRtGhdDIhbakaOP24AA/Y8BG+tYkJMD5dXykrSpGbxR8FnS5NT1E4raTQ
	 vcSVFxpX8nYpyqZJOjgFlh8VRG+nkXLD80tGLW1O74f26itEv73UxoUhNzP8Zvlpnt
	 gPDcr4ijXWHkDtDgY1HYVKu1djV6PV4f3AyV8U18hY5JvEOZMWtc+Ryq507pF5hvjZ
	 VvNyuQqBoZKeP1XE/QBH5u9EakyxbAXlfHJQFiacRu39RFMbMoWiqqgm1eonpsLzIe
	 kl9j1srM19DMg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id AA4C7802B4;
	Tue, 23 Jul 2024 14:55:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 23 Jul 2024 22:55:43 +0800
Subject: [PATCH] driver core: bus: Return -EIO instead of 0 when show/store
 invalid bus attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-bus_fix-v1-1-175f926805dc@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG/En2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3aTS4vi0zApdQ0sTgxSLVHPLVEsjJaDqgqJUoDDYpOjY2loALv0
 LjFkAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: FJmY4WfRlSTttXLjfkdigAkcj4N-eLtV
X-Proofpoint-GUID: FJmY4WfRlSTttXLjfkdigAkcj4N-eLtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_04,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407230105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Return -EIO instead of 0 when show/store invalid bus attribute as
class/device/driver/kobject attribute.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..e84522a90102 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,7 +152,7 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -164,7 +164,7 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);

---
base-commit: b57d5ffc3ab507d0e19fc8b90b19c76af43fb790
change-id: 20240723-bus_fix-1940d8e79e92

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


