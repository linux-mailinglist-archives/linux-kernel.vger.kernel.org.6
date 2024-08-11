Return-Path: <linux-kernel+bounces-282092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25F894DFA4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3371F215B7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB325EEBB;
	Sun, 11 Aug 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qNFcy8DO"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4271C6B2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343130; cv=none; b=X2f4n3CELYp3YPBxW1a/8Sn2GOrN6DzJku9kpx3jY12S/IsS52n/1fW2lwYpl4orjUYqgdAlh0fqesfCVGWme9qOlCofrPVsvAe/f4+cEmn4BAi44kmJakAp9u80xUVkaiK2AO7gmWboIfK7+OqsfTYqEdJ3Bv+6dSOK1hzTJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343130; c=relaxed/simple;
	bh=dx0u9LriqQx5TBNwmhwckGUF8mJ+bX200IJxPTTSXrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD9j/qrmXG1bc3XPBFCAsC3/PLEp8XgzdWSYulZgp0FHXCyUpHsr+gVmHmZYtyeHcZ2FsXqJTuwrd5m0ibbYEHdST5GTrUE+y7WRV68ayeGY9uCiIeUlxCuTW9XhbMmben9MnM3R5AXMJbs4KVK1QHUxlydo/RS/NTU1IRF/XJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qNFcy8DO; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343128;
	bh=3FqHtc0xZhNMWQ1mpmnQ8iJP3jESmxhyTyiFEvXBvZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=qNFcy8DO5oIP96CVH0Bh3eJq8CpiXemgkPvVcDEwaV2+ID8YZa7HFSOiqtuUBxtMR
	 zSBAp8Psrosy1xfmyqZQC1t6PTy88MqPpjSA0GjEigbtZ8QlO4w9OlSUlCVoAp/52p
	 dasJNkWaizI9CjHF+g1aF9oS6Z8MnF/5leMq2z2MkarQpzvjO86q7bZZ1jSiUO2wCM
	 4YqBfdwy+BFjFX9WRkA4+IoOu1+x96SyM/Ltm8cA88/Yj0R40U/e/P1Y1E+ASqDe+e
	 EsLZLgfaax7+b2UUAr8vthq+V3mB/L0huk7zwSmvR+UrUq50gijiamJIrRyRSEByCR
	 fuer8fDyfKUIA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id D7ABB1349C1B;
	Sun, 11 Aug 2024 02:25:24 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:55 +0800
Subject: [PATCH 04/27] usb: typec: class: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-4-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: D4p7PmZl3hS6wlnXR0Lq1gMOgoDwK6IW
X-Proofpoint-ORIG-GUID: D4p7PmZl3hS6wlnXR0Lq1gMOgoDwK6IW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=994
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/usb/typec/class.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9262fcd4144f..eaaa51ffca04 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -222,10 +222,10 @@ static DEVICE_ATTR_RO(usb_power_delivery_revision);
 /* ------------------------------------------------------------------------- */
 /* Alternate Modes */
 
-static int altmode_match(struct device *dev, void *data)
+static int altmode_match(struct device *dev, const void *data)
 {
 	struct typec_altmode *adev = to_typec_altmode(dev);
-	struct typec_device_id *id = data;
+	const struct typec_device_id *id = data;
 
 	if (!is_typec_altmode(dev))
 		return 0;
@@ -1161,7 +1161,7 @@ const struct device_type typec_cable_dev_type = {
 	.release = typec_cable_release,
 };
 
-static int cable_match(struct device *dev, void *data)
+static int cable_match(struct device *dev, const void *data)
 {
 	return is_typec_cable(dev);
 }
@@ -1840,7 +1840,7 @@ const struct device_type typec_port_dev_type = {
 /* --------------------------------------- */
 /* Driver callbacks to report role updates */
 
-static int partner_match(struct device *dev, void *data)
+static int partner_match(struct device *dev, const void *data)
 {
 	return is_typec_partner(dev);
 }

-- 
2.34.1


