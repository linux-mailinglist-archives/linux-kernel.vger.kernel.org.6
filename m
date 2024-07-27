Return-Path: <linux-kernel+bounces-263979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B593DD78
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 08:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D511F23B73
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302941BDD0;
	Sat, 27 Jul 2024 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FeuFz9G1"
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B941B86E0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722060536; cv=none; b=SvrpwOkRopv4pAHTrnKi4Tb2OKTLY8OB4TLOiW0OQMCamqtEiqC6sTHk1pEAqVHeRWsr1kGvQf/PycoO/5TgWvSGk/4lCmix/6vOqgCoGsOrjYjBF84+zR1z/ttLb+hZFhTRv+Ok1FcaKrL31ITESfeNshxL9Vc30phhrTuXmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722060536; c=relaxed/simple;
	bh=huv63ZmmuwphOK8/zWcY3ypjqrBCmEZX/IGYQ1Y/ifY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ilWAFqnWVsBEMBHd+ILlJYYMT43tqgpGQZv09GUFpC65+NQDQJY6/Y1JH6s1rAG0Mt2j8oLMDlRNQHKFwBJQO5Y2O5SytxeJm7e6haE/CEfE3iiLrvcP21j0SyGiHm3y2eQQLqqeIrCtIdLSANi+Cc2Loswz0goF1uGwKddEqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FeuFz9G1; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722060533;
	bh=y3Iwxz3osm/lv9z5nAuzzQETnzt40X0j259hiuyoxKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=FeuFz9G12R8UQTLnWHWQ93woJqOGSwb+ttw35lOgwbkKLwIztfuFZFzhgELaV1pXU
	 jiSY3Brd/82tEuClSyxeOirqcanM3CvUkb/Gn/3RCES5uDPREElsI/UqlaOLRMjc9+
	 bo48az6xSHmG7DDS1NFfMR4x+MNHrZuGIoV25lFYkmZT+nMUr3jJ1MmhJCpuLEi300
	 ufuptRwdxxfQp/7zODEd4dfhc959jYmkx0aD80ibFCY/L+ppipFq2Bk6sc1lL0dmnF
	 8ZqcBop1QravOIJtW3/x0qHGqpYxX/SM2kDQ8wrggbnwJJDacw7EwJ84E0OQtq3i1B
	 Vypqc58S80nNQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 54848DC0194;
	Sat, 27 Jul 2024 06:08:48 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 27 Jul 2024 14:08:34 +0800
Subject: [PATCH] driver core: bus: Add simple error handling for
 buses_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-buses_init-v1-1-e863295a2c0e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOGOpGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNz3aTS4tTi+My8zBLd5BTLNHMzS1PD1DRLJaCGgqLUtMwKsGHRsbW
 1ACMxUfxcAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: ja9IaSrFNI5wN0582Z3Mh1r3X2gxQx9S
X-Proofpoint-ORIG-GUID: ja9IaSrFNI5wN0582Z3Mh1r3X2gxQx9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_03,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=940
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407270035
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Add simple error handling for buses_init() since it is easy to do.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..e7d7a94fba4e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1385,8 +1385,13 @@ int __init buses_init(void)
 		return -ENOMEM;
 
 	system_kset = kset_create_and_add("system", NULL, &devices_kset->kobj);
-	if (!system_kset)
+	if (!system_kset) {
+		/* Do error handling here as devices_init() do */
+		kset_unregister(bus_kset);
+		bus_kset = NULL;
+		pr_err("%s: failed to create and add kset 'bus'\n", __func__);
 		return -ENOMEM;
+	}
 
 	return 0;
 }

---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240727-buses_init-cd9f76951ef9

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


