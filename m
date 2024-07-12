Return-Path: <linux-kernel+bounces-250601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4092F9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF91284650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFFE16A940;
	Fri, 12 Jul 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hG7QApFm"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B441640B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785172; cv=none; b=SKvi6VUFEGaR/ynF65M1cT7hF1cvwrZLGpAhMEVMPdJMiMVD0bSkEQttypm6dBYJ5Nuoa5BGEwvhxkxDMwhRsSMPPjai0zrqcSBHzuHsMll2jmEq/BJFFB0LAyQo0S/ytQf6IQYH7MPcBirPmjPYxuPyk1SOaKtyV1HwqHLQxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785172; c=relaxed/simple;
	bh=iwpz2cJ6MASq82WXn4IytlPyAWih7fRpNA/6mCQB8RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NoBH+YFAQ3o5Hfu3K1UMgMRQ8A0zGO/kAHeg9+uiCaywcCGHN34SnYGPeAv8bWSlLgPMnsMfKDQopuRQaBmfZH8NkV21EGGFhYx93XUuvHq6gdzS1xf76b9hIqv7U1LIyjO1a1nVZVALfXxmVSEDq4sOqqnRDeAlqn8Tda8nJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hG7QApFm; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1720785170;
	bh=hX0tJuSw+yu1u66K7bCO1ykDcSzKls85CioMXdu+/I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=hG7QApFmp76GSX+FskKdOSLlHsCVcv3QwzVMeeFJ6KB+Io5bk+xSDe+2pzGLaHw7I
	 KZ59dZr0rNNxI9SpZIu6loldNGeAVMOCCtVpPm++yOokWXiHDW4Z2MeoLA1eZIGe0U
	 /ETuIb6Emlr6ttLI9OXDvE3F/zYOM/SEUHjm28bgVk0/bZu2bNEZgI5iUrhOKEyrpP
	 wr1zy6lM8m08hfeUPlyJ7GqWt5frljCqf+4myPrlkbSJJaldpHcPczGMvjZuzFVQsN
	 eXfAv21ho6+jJ8Qxous72ArGu29RhCrlNpb8X4Px3M58+P6PJBkX3vAiwH+PKcstHB
	 lr/LkhM/MnzWw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 74372180429;
	Fri, 12 Jul 2024 11:52:47 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 12 Jul 2024 19:52:31 +0800
Subject: [PATCH v3] driver core: Fix size calculation of symlink name for
 devlink_(add|remove)_symlinks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-devlink_fix-v3-1-fa1c5172ffc7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAP4YkWYC/22MSw7CIBQAr2JYi4EH/bnyHsaYCg/7olIFJZqmd
 5d2ZROXM8nMwCIGwsi2q4EFTBSp9xnUesVM1/ozcrKZGQjQohIVt5iu5C9HR28uXKtLi9ZhU7B
 c3ANmPd/2h8wdxWcfPvM8ycn+/yTJJS9BteaklTS23j1eZMibjelvbDol+K2bZQ25BoBCOylVj
 XJZj+P4BfDmCermAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <zijun_hu@icloud.com>, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: N513KqiiN7cRdmIei7ybAriJcjGLxmAN
X-Proofpoint-ORIG-GUID: N513KqiiN7cRdmIei7ybAriJcjGLxmAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=868 suspectscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407120073
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

devlink_(add|remove)_symlinks() kzalloc() memory to save symlink name
for both supplier and consumer, but do not explicitly take into account
consumer's prefix "consumer:", so cause disadvantages listed below:
1) it seems wrong for the algorithm to calculate memory size
2) readers maybe need to count characters one by one of both prefix
   strings to confirm calculated memory size
3) it is relatively easy to introduce new bug if either prefix string
   is modified in future
solved by taking into account consumer's prefix as well.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Correct commit message
- Link to v2: https://lore.kernel.org/r/20240709-devlink_fix-v2-1-22254f1138e1@quicinc.com

Changes in v2:
- Correct commit message and add inline comments
- Remove fix tag
- Link to v1: https://lore.kernel.org/r/20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com
---
 drivers/base/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..51209db7ff84 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -572,7 +572,11 @@ static int devlink_add_symlinks(struct device *dev)
 	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
 		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
 	len += strlen(":");
-	len += strlen("supplier:") + 1;
+	/*
+	 * we kzalloc() memory for symlink name of both supplier and
+	 * consumer, so explicitly take into account both prefix.
+	 */
+	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -623,7 +627,7 @@ static void devlink_remove_symlinks(struct device *dev)
 	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
 		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
 	len += strlen(":");
-	len += strlen("supplier:") + 1;
+	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf) {
 		WARN(1, "Unable to properly free device link symlinks!\n");

---
base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
change-id: 20240707-devlink_fix-0fa46dedfe95

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


