Return-Path: <linux-kernel+bounces-446653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E149F2797
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF527A1476
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9E5588E;
	Mon, 16 Dec 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ks3TG7R6"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4555896
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309691; cv=none; b=gCSsEw7FGo+0bF9fVmwrCXBDyainsKki60LFy6xicYbuhM0EbP9UJ/ZtHzKwO0d8zr77sxMDz6shCPkj+7+yaddyvQWcR5ThWs02/kzxqytsxuDpHDcSACGdFn+dIWXKn26sSrfCZA38HCoR8kByP5K7G0Zh+L7KWJnSzogQ3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309691; c=relaxed/simple;
	bh=bc6lzGgIEQ1cBkFQ7KiFXTLCSQur3IQsBxM4lNEjjT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3/29IOYLMmsOIENV6/77XMqFeX1W3aIm+7RfFUON5WCIhGYi3TICu1NZq1gJP0HVmrXXH+xDIe3EInX3d1AbtMf19ntkrvztA/uZX0TZw4fhRXNvgO86a90Tw2TVNxLREg2V5Egujqe5aIkOmMaI6xzKdLWNp74UF/OnoYKvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ks3TG7R6; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309689;
	bh=2a/BC8NRIh0uh85HCJfRd8BdlVkBEXk7Aqyv3gynJAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Ks3TG7R6ZfDkLmx0+3HcuV8JTnhIN+XzZrRD/4AYl+0jXYZFp2dQpBOP3itsQfSTi
	 RFTK2+W0ZrnjsfsQC5QlKcHcJmNRhkluHc1ORxKACFpuGxABCfYp4NgUOw2fKuugCi
	 j9AT/XMhtJy5gn9Qe0i8ShItRpu3k+T7GzJO3PIYFj23p+f0eRL3WHg4nfz5BaA6dD
	 fMrD4iwA6fdtSuXaUKHUGtiSMisZRs44PiQpiHf7ibsQ3sdf1ZJiNUSe+Tn/eqU5Tr
	 xhtSlPw+onaACfS0iw2HBTSRzOwjjtTAEcwPAeYsfmiNOEs7FYo9aQQLz8P1jL8jud
	 Bass6e6eH1KCw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id D2B51D002CC;
	Mon, 16 Dec 2024 00:41:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:44 +0800
Subject: [PATCH v2 5/7] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-5-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 9VUYbPiFtn5lGPtNOWA3onl0jZx4Gp1U
X-Proofpoint-ORIG-GUID: 9VUYbPiFtn5lGPtNOWA3onl0jZx4Gp1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_device_uevent_modalias() saves MODALIAS value from offset
(@env->buflen - 1), so the available buffer size should be
(sizeof(@env->buf) - @env->buflen + 1), but it uses the wrong
size (sizeof(@env->buf) - @env->buflen).

Fix by using size of space from char '\0' inclusive which ends "MODALIAS=".

Fixes: dd27dcda37f0 ("of/device: merge of_device_uevent")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/device.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index edf3be1972658f6dc165f577da53b10c7eebc116..f24c19e7aba8e01656f503ae328a4e08aab5a5f3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -257,6 +257,7 @@ EXPORT_SYMBOL_GPL(of_device_uevent);
 int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
 	int sl;
+	int pos;
 
 	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
 		return -ENODEV;
@@ -265,13 +266,18 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	if (add_uevent_var(env, "MODALIAS="))
 		return -ENOMEM;
 
-	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
-			 sizeof(env->buf) - env->buflen);
+	/*
+	 * @env->buflen is pointing to the char after '\0' now
+	 * override the '\0' to save MODALIAS value.
+	 */
+	pos = env->buflen - 1;
+	sl = of_modalias(dev->of_node, &env->buf[pos],
+			 sizeof(env->buf) - pos);
 	if (sl < 0)
 		return sl;
-	if (sl >= (sizeof(env->buf) - env->buflen))
+	if (sl >= (sizeof(env->buf) - pos))
 		return -ENOMEM;
-	env->buflen += sl;
+	env->buflen = pos + sl + 1;
 
 	return 0;
 }

-- 
2.34.1


