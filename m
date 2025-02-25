Return-Path: <linux-kernel+bounces-531359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D605DA43F82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7D77ADF90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2896268689;
	Tue, 25 Feb 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iK9cS+Yv"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294B266B40
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486809; cv=none; b=HUJe0KuefG8ir7nx0J14HnRBgwV8a37ISjSiBQVFgNSRMen/el4ILFUlOfANR3HUiAzlPwadEGhDnINBDmntybZKimJvfU9QfSuWR18d6DJUuVTz2+CrD64CTQxsVwvUOd0LqAXHFw+DcUFffiFZOJw7GBNcYLdnVvnwk3fLa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486809; c=relaxed/simple;
	bh=oxeNg/3kTTYdWOP+m0MjbWQatWl1xtjweDH0uB/M8o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snisbc4723tsrMtKTJAVPP2waq6BcWv5OXt4kKaMjJulL03WjWMAjL4FTDPEm7bcSrvqw9OfDiOeIvyEWgZ7P+0S6k0Jy3orEua5pbws4z46SpFeXeKjnG1ezuh89TM9HietH8RHe3lH3+0Nl903bn9pdLMMM58wOOUuXAs/R8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iK9cS+Yv; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=tfkcqBi0ou5N+iPlIoNtZJvvEZ4xTbBbnOJsMG5xchk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=iK9cS+Yv3SeyUoWcFPENdzP+BUb/qiZOQ3e6yjJto3o2tW9q0Inf7gw1nwR6TiMl0
	 Y7N1lTA1bQniIn+rT3FnYxouFVUBGrgfVR8JqGkY5YhRsUIBap6Lp6JUsF7PfRXjZ5
	 KZfR8yUER992Zm6ykzRH/jaB8ertUDOhHg8WA4ym76ZXtpSVYUnw6JH7CoFhKwLJs1
	 9dM7PX7Zkab0iuwacWMdGyBOl22d2Rf1VY60MEr9FwtPxJrSPY2FNvg0smJykXwQzZ
	 PvbRJj3rkz/OAsaCjQ1Sf8hD9Dz66uG1F3W/Y0JK23p6E9niVHrQoEsblcf1EB8h+4
	 aYGklqoEKINSQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id ED3F168035B;
	Tue, 25 Feb 2025 12:33:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 25 Feb 2025 20:32:39 +0800
Subject: [PATCH RESEND 2/2] phy: core: Remove API devm_phy_destroy()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-remove-apis-v1-2-e49b4a1941fd@quicinc.com>
References: <20250225-remove-apis-v1-0-e49b4a1941fd@quicinc.com>
In-Reply-To: <20250225-remove-apis-v1-0-e49b4a1941fd@quicinc.com>
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: Nn6owD0_M8syBbjLW7GXmAtZeTfeyw_R
X-Proofpoint-GUID: Nn6owD0_M8syBbjLW7GXmAtZeTfeyw_R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250088
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API devm_phy_destroy() has not had callers since 2013-09-27
when it was introduced.

Remove the API.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 Documentation/driver-api/phy/phy.rst                    |  6 ++----
 Documentation/translations/zh_CN/driver-api/phy/phy.rst |  7 ++-----
 drivers/phy/phy-core.c                                  | 17 -----------------
 include/linux/phy/phy.h                                 |  5 -----
 4 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index be3687a2a11bbf84e6e5561b11931ea6db984434..cae03d8a4812b3c4cfca64272cc6b8f83a81d1c8 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -173,13 +173,11 @@ Destroying the PHY
 ==================
 
 When the driver that created the PHY is unloaded, it should destroy the PHY it
-created using one of the following 2 APIs::
+created using the following API::
 
 	void phy_destroy(struct phy *phy);
-	void devm_phy_destroy(struct device *dev, struct phy *phy);
 
-Both these APIs destroy the PHY and devm_phy_destroy destroys the devres
-associated with this PHY.
+The API destroys the PHY.
 
 PM Runtime
 ==========
diff --git a/Documentation/translations/zh_CN/driver-api/phy/phy.rst b/Documentation/translations/zh_CN/driver-api/phy/phy.rst
index 2d3f98deb92035c44fcb1ff0e3dc8543053140f6..37c23fcebf11f397d0dc502bbba11a74c525f085 100644
--- a/Documentation/translations/zh_CN/driver-api/phy/phy.rst
+++ b/Documentation/translations/zh_CN/driver-api/phy/phy.rst
@@ -164,14 +164,11 @@ PHY 关联的设备资源。
 销毁 PHY
 ========
 
-当创建 PHY 的驱动程序被卸载时，它应该使用以下 2 个 API 之一销毁其创
-建的 PHY::
+当创建 PHY 的驱动程序被卸载时，它应该使用以下 API 销毁其创建的 PHY::
 
 	void phy_destroy(struct phy *phy);
-	void devm_phy_destroy(struct device *dev, struct phy *phy);
 
-这两个 API 都会销毁 PHY，并且 devm_phy_destroy 会销毁与此 PHY 关
-联的 devres。
+这个 API 会销毁 PHY。
 
 PM Runtime
 ==========
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index dd6302dfd14d2ec060857fc019268096c33e37a2..8e0e11553e369e06f5ee4cdbb111b4ddb1b34e74 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1107,23 +1107,6 @@ void phy_destroy(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_destroy);
 
-/**
- * devm_phy_destroy() - destroy the PHY
- * @dev: device that wants to release this phy
- * @phy: the phy returned by devm_phy_get()
- *
- * destroys the devres associated with this phy and invokes phy_destroy
- * to destroy the phy.
- */
-void devm_phy_destroy(struct device *dev, struct phy *phy)
-{
-	int r;
-
-	r = devres_release(dev, devm_phy_consume, devm_phy_match, phy);
-	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
-}
-EXPORT_SYMBOL_GPL(devm_phy_destroy);
-
 /**
  * __of_phy_provider_register() - create/register phy provider with the framework
  * @dev: struct device of the phy provider
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 06037a7eefc4b0319008065d142c9f1caba2c74d..66eb664249ddaa6635bf80d8db115cb21473ceb8 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -278,7 +278,6 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
 			    const struct phy_ops *ops);
 void phy_destroy(struct phy *phy);
-void devm_phy_destroy(struct device *dev, struct phy *phy);
 struct phy_provider *__of_phy_provider_register(struct device *dev,
 	struct device_node *children, struct module *owner,
 	struct phy * (*of_xlate)(struct device *dev,
@@ -521,10 +520,6 @@ static inline void phy_destroy(struct phy *phy)
 {
 }
 
-static inline void devm_phy_destroy(struct device *dev, struct phy *phy)
-{
-}
-
 static inline struct phy_provider *__of_phy_provider_register(
 	struct device *dev, struct device_node *children, struct module *owner,
 	struct phy * (*of_xlate)(struct device *dev,

-- 
2.34.1


