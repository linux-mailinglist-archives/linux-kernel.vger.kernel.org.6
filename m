Return-Path: <linux-kernel+bounces-331350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F597ABA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CA8B2A232
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297C61292CE;
	Tue, 17 Sep 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="r6TyB+kX"
Received: from mr85p00im-ztdg06021801.me.com (mr85p00im-ztdg06021801.me.com [17.58.23.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425332A8D7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555793; cv=none; b=qLAlORoySf4/L/1PUB4k3Z8EdRDAov7gadgIEH6rK+UHg/wGj/I4bichdnc8UyhwTbxbbJdlpOV/sN46EnzZA3QFPkjIAFxxi4wotoVttZU5V7TsuL2MFvC5rAFwnP57fVRZaOSbYcsNPuHCOX9uBDkdizB/3i8DGs7Np7/p9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555793; c=relaxed/simple;
	bh=knFmOYm9hkMjUkH3BOatbKDsPSAcETMO+LbJHXofFMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JC4Ju30mqLHzvOqwLusdBm5njEUZ/kSX9Zoeo4M9VBQq34DtauxB6txz7P05e+AA2ZmtQ2DjTQkfy4qK4ifnXDl+JjxCTZSm+AEKy/cWFNYNVF+Vw8qSl3PQ11ngus+RA/bgSQmwYM4rUEiYzDxTr3zxaJjlCBjKzhvFs95mn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=r6TyB+kX; arc=none smtp.client-ip=17.58.23.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726555791;
	bh=fNnMYv/kZ49mqrYLLfzCvUnhd1Kw9lBOAp5+TK5Ptto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=r6TyB+kXAspDj3/4ia1TQW7i1D+wWJuVX3OwTiC8f5BLQQI8gpZXEBMSLaOoA+y/K
	 1chg2Ng3pA6qAzkCb25jgxhzq/qstJgblFkGOItj+Q0EvWlHlYUho+bmgvalludfjL
	 BfkGV9hbg8wfL+PEl5k03HfDMoKot4Ye9tXfLEK+/DhO5pok6V5g97vmaEJJucCO6d
	 LTnN5cgZgx9AWnCAP9tlEt+rJayO1BjNDod/foRRciX/zqZbmwM0hqN8TRd85Hbzxy
	 fxE2df+ZrBVkO6eJsuoOXeBuYMQPfGY4W78jsRWX8nx1V0UcRD6Ew/qdj0nUWqXNNB
	 sZOncRxe3pPpA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021801.me.com (Postfix) with ESMTPSA id B1C00D0001D;
	Tue, 17 Sep 2024 06:49:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Sep 2024 14:49:34 +0800
Subject: [PATCH v2] driver core: bus: Remove an impossible error handling
 path in bus_add_driver()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAH0m6WYC/32NQQ7CIBBFr9LMWkynaYl15T1MQxAGOwvBgiWah
 ruLPYDL95L//gaJIlOCc7NBpMyJg6/QHRows/Z3EmwrQ9d2fTviIG5rUtpaZSNnisrxW7ihP/V
 IUstRQx0+I1W9R69T5ZnTK8TP/pHxZ//mMgoUhgbj0EkpW7wsKxv25mjCA6ZSyheL2H0YtgAAA
 A==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 8dsY4tbfwZs6Vi3k0HEiLOhaVWOGyDV4
X-Proofpoint-GUID: 8dsY4tbfwZs6Vi3k0HEiLOhaVWOGyDV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409170050
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For the following function call chain:
API driver_register() -> bus_add_driver() -> driver_attach()

There is an error handling path for driver_attach() returning non-zero
or failure in bus_add_driver(), remove it with below reasons:

- It is impossible for driver_attach() to have failure in bus_add_driver()
  For int driver_attach(const struct device_driver *drv), the only factor
  which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
  the factor has been excluded by bus_add_driver() before calling it.

- driver_attach() is irrelevant with driver_register(), so the former's
  result should not also have an impact on the later.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Remove the error handling path instead of WARN_ON() it.
- Correct title and commit message
- Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
---
 drivers/base/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..54ff92aece92 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
 	if (sp->drivers_autoprobe) {
 		error = driver_attach(drv);
 		if (error)
-			goto out_del_list;
+			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
+				__func__, drv->name, sp->bus->name);
 	}
 	error = module_add_driver(drv->owner, drv);
 	if (error) {
@@ -708,7 +709,6 @@ int bus_add_driver(struct device_driver *drv)
 
 out_detach:
 	driver_detach(drv);
-out_del_list:
 	klist_del(&priv->knode_bus);
 out_unregister:
 	kobject_put(&priv->kobj);

---
base-commit: 6a36d828bdef0e02b1e6c12e2160f5b83be6aab5
change-id: 20240915-bus_add_driver_fix-f54841e6a69a

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


