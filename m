Return-Path: <linux-kernel+bounces-449229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7659F4BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2157A165B51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5D1F7564;
	Tue, 17 Dec 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="V53Jrg/a"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A71F7563
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440887; cv=none; b=p/d+cGUvkFIQaQ5Mah3xSKfTGGG5/JHpwJkmzMKzbEzJvem+WMkeGbeNE3NVJcURzoBR7uSpGYMm8Q0n6JjxqLoYzBod4dVRoymkBxsfZCMkPaBIvnNLUtg4SC/3vlEWTDMwGU4zUJ2mMAUTuwAnADZ0+52zRzPn8odMBITdjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440887; c=relaxed/simple;
	bh=bc6lzGgIEQ1cBkFQ7KiFXTLCSQur3IQsBxM4lNEjjT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cm03Z9SlM5hFjA6dZoK3tmQjWjFctOlP5n7DiHdlzXy9iS0cb2hMZ48x2dvcKwDe4g3MJ0TXf86/tCTBYfn77z5HTWq57r0KEdVVfhH+brcJvRKxrHjrLY61sxaWvKw30u7SLuCZknNjAbEmSVPB7Z+ffAy4wEUd2JW3YfzGLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=V53Jrg/a; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440885;
	bh=2a/BC8NRIh0uh85HCJfRd8BdlVkBEXk7Aqyv3gynJAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=V53Jrg/aeAa0HlOtSv9z2RsRHoTPGet8tbXoLXbrCu3AHt1eMcQrI2AQEfBx7N8fz
	 ZGoTpJDzKPU8/HWG/APiksj6I8OuwGc0UU8YVAFfF4q9ZezUMYetpFCMNAQGvXh6Cr
	 QVezyrul/+eY5xKYzSo1qSlmHLcls7BMJBlit6V4GeczOEfcCj75L2bm08L3q8HJbX
	 qbsIRWurkVPMtG+8KUjDgop+JdBDw/v45/IUiPBRDvLTafNEpCmdkkJmykxeMhVA1v
	 t0ntFqxHSKjePdP1xyW8KssG6Vfx64h4ACnfkClggQ2Opj0eJ90Mw4T8bOCh7UJh9l
	 nuybc4Ygvtqeg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 279C296002A;
	Tue, 17 Dec 2024 13:08:02 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:29 +0800
Subject: [PATCH v3 5/7] of: Fix available buffer size calculating error in
 API of_device_uevent_modalias()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-5-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: N3u2fkR6Wp0ERaXHwutVCmYvLhrtt6p7
X-Proofpoint-ORIG-GUID: N3u2fkR6Wp0ERaXHwutVCmYvLhrtt6p7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
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


