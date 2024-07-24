Return-Path: <linux-kernel+bounces-261042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3DF93B21D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3B5B2293D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0A158D83;
	Wed, 24 Jul 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CYsEk1Nc"
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FB156677
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829335; cv=none; b=l14zaQkZX9a8UiZeMXJEkJ2FnC2mT6FHgETWc1i21/46EcpH/AmVHmsIGfMK/8M3pfhZToFUwvPf+4HLcRVnAuSk8kC2XpH7HaHifGzp6KTkX2kQDpe/PaJLh3MqN0MTsnyUjMHku/E21PcZT1R8UE6/xVDhQ1g0bs4LF7x9/TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829335; c=relaxed/simple;
	bh=5tjvNKEx/widHD/qMNCUEeOcddoq9QmrMSVVtSgHKwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iEcH3y+LGzx1Nt1VFcyH2Kew/MtQRqhteGLO1Pm+TpOU03WUoMB+LD2J4zBsBCnKHZ312UblnmiMn+/onK9ThNJu8PZyose38vPiMuoL7WEF2dNxH+3EBb2ZrijNPKube5Aer24J6q58v7auorz52eietm3z3XAjfs3AQGIm9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CYsEk1Nc; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721829333;
	bh=8SY/PmnOq3MTqa5D0IZNCJ7b5b06L3GO1QcJ7L5gyx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=CYsEk1NcmHW5MixGYygoQ8H0aYqIe6inW3HanAYKAxyEzzZoUp84rvwjqzGV3LvK0
	 UKZxH35GLua+1pB1e8GyvZfaHUnlFPw6oNZZN4V/X6Qu0PcCj6hK9gmuM5OVN5MiZV
	 v0TnrzElsx4D9ZUKilchpoyjNMQ+zI2mwpMn7JdOtcIaHmU5mIhRUkfosw7ely5RHm
	 ZOv7rgBsNAUgmNcDydWD1OCLT9QIDgKo1k846o/YqrGncRE6fvadDbEb1EgItkkN+R
	 Po9UB+97cq5NJ7LqpIyZkETUT/wJXmdNk7kx11TrnYAqZu5oWe8wAKJXUT3vsu6GAm
	 pVMp8ik9lLQKg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 8CC002C029A;
	Wed, 24 Jul 2024 13:55:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 24 Jul 2024 21:54:48 +0800
Subject: [PATCH v2] driver core: bus: Return -EIO instead of 0 when
 show/store invalid bus attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-bus_fix-v2-1-5adbafc698fb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKcHoWYC/2WMQQ7CIBBFr9LMWgxgK8WV9zCNUZjaWQgKlmga7
 u7Yrfmr9/LzFsiYCDMcmgUSFsoUA4PeNOCmS7ihIM8MWupWGr0T1zmfR3oLZVvpezQWrQZ+PxK
 yXkungXmi/Irps4aL+tn/RlGCZ7rR6n0vO++Oz5kcBbd18Q5DrfULegzTwaAAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: jV0euJ6D3_QB__hK3Itx6GFSG3gRgWyJ
X-Proofpoint-ORIG-GUID: jV0euJ6D3_QB__hK3Itx6GFSG3gRgWyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407240102
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Return -EIO instead of 0 for below erroneous bus attribute operations:
 - read a bus attribute without show().
 - write a bus attribute without store().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct commit messages and add inline comments
- The following commit have similar change
  Commit: 4a0c20bf8c0f ("[PATCH] sysfs: (driver/base) if show/store is missing return -EIO")
- Link to v1: https://lore.kernel.org/r/20240723-bus_fix-v1-1-175f926805dc@quicinc.com
---
 drivers/base/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..e5073fa82b95 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -152,7 +152,8 @@ static ssize_t bus_attr_show(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for reading a bus attribute without show() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->show)
 		ret = bus_attr->show(subsys_priv->bus, buf);
@@ -164,7 +165,8 @@ static ssize_t bus_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct bus_attribute *bus_attr = to_bus_attr(attr);
 	struct subsys_private *subsys_priv = to_subsys_private(kobj);
-	ssize_t ret = 0;
+	/* return -EIO for writing a bus attribute without store() */
+	ssize_t ret = -EIO;
 
 	if (bus_attr->store)
 		ret = bus_attr->store(subsys_priv->bus, buf, count);

---
base-commit: b57d5ffc3ab507d0e19fc8b90b19c76af43fb790
change-id: 20240723-bus_fix-1940d8e79e92

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


