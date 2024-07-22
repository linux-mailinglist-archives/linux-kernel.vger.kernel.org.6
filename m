Return-Path: <linux-kernel+bounces-259081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709869390F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269A21F21D31
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F716E861;
	Mon, 22 Jul 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Rcowjz1w"
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513416D4E1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659729; cv=none; b=gsPmVqyTdb9wZEbg3E3mOyTAzvppAjPQ1MU/iUMTZ3elWJyF7I6c+IhRaWftVxDCDkN/n6xqLH5XuoMyHyr4TvkIbVc5yR9ZzVSV5TXpMzK0iKuJr/iIMNaDbTGts6moi5nr2RQJ+oijCFfdW78lVYzH/oD45m3H60XnRxUY2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659729; c=relaxed/simple;
	bh=xefDGqOQAqO7Yi5lBoIn41Rzji/Mt+946t4qEowwIMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EijorVVi0gX+bIjNihX7H/jeCf1k4Kn2NnBQtARcUKGy6OaGvogYawy3GJqyHOxZiXT2tQKBetFrDz7rNHDwDLL4X9TXUyNz/f36/id7VTWFLvEi9HSEmI6nOYcv0Jn0Zn/96IYIwxSjSgd6wETQI4ldssuCmJLAddtp90IbxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Rcowjz1w; arc=none smtp.client-ip=17.58.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721659727;
	bh=KrbdP1OrZDT/YnyhSacOPP/oXArKUX8UAJe22d5tEl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Rcowjz1wlzGZhY4q8RE+Rz9oF2cOIZbtgalQisTBSD0cK2jrlS09k66NNN3jSy+0Q
	 J+jB3cQElmApIcXd3QL/uTbZcHwPAtRWeuxkdxPBItJmWCs0Ht/SrqTZTSw/8kXnQi
	 fhJNATy8vK6v/BZ2AbTRf9DnfJpULLQCPnHZUD4oVAEOrhUYmGk4lthROaI1svO8rx
	 lgvvnokuBBL1QNzEivURpltm0LqeQO1E97A2NXyqIibMa/SjZy0lbo6m/hLcod2I3O
	 KX6pdw7oU0LQxld+EleKU2o8enzh7D+cVym/5eRurmJ8iGZy89nucjfbXegNAcDeoa
	 D2eM07hJbRuJw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id 1AAB9500503;
	Mon, 22 Jul 2024 14:48:42 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 22 Jul 2024 22:48:10 +0800
Subject: [PATCH v2] driver core: Fix error handling in driver API
 device_rename()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-device_rename_fix-v2-1-77de1a6c6495@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAClxnmYC/32NTQ6CMBBGr0JmbQ1t2tC48h6GEDIMMgtabbHRk
 N7dkQO4fC/fzw6ZElOGS7NDosKZYxAwpwZwGcOdFE/CYFpj2053apIQ0pAojCsNM78VIc2tt52
 35EB6j0Sij81bL7xw3mL6HBdF/+y/taKVVs5O3knGaT9fny9GDnjGuEJfa/0CBGputLQAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Benjamin Thery <benjamin.thery@bull.net>, 
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: VrvBZqh6UseigqkP5Jkla0AtkGOFQvSm
X-Proofpoint-ORIG-GUID: VrvBZqh6UseigqkP5Jkla0AtkGOFQvSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407220112
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For class-device, device_rename() failure maybe cause unexpected link name
within its class folder as explained below:

/sys/class/.../old_name -> /sys/devices/.../old_name
device_rename(..., new_name) and failed
/sys/class/.../new_name -> /sys/devices/.../old_name

Fixed by undoing renaming link if renaming kobject failed.

Fixes: f349cf34731c ("driver core: Implement ns directory support for device classes.")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct commit message and indentation
- Link to v1: https://lore.kernel.org/r/20240717-device_rename_fix-v1-1-54d85024518f@quicinc.com
---
 drivers/base/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..b335e239a633 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4512,9 +4512,11 @@ EXPORT_SYMBOL_GPL(device_destroy);
  */
 int device_rename(struct device *dev, const char *new_name)
 {
+	struct subsys_private *sp = NULL;
 	struct kobject *kobj = &dev->kobj;
 	char *old_device_name = NULL;
 	int error;
+	bool is_link_renamed = false;
 
 	dev = get_device(dev);
 	if (!dev)
@@ -4529,7 +4531,7 @@ int device_rename(struct device *dev, const char *new_name)
 	}
 
 	if (dev->class) {
-		struct subsys_private *sp = class_to_subsys(dev->class);
+		sp = class_to_subsys(dev->class);
 
 		if (!sp) {
 			error = -EINVAL;
@@ -4538,16 +4540,19 @@ int device_rename(struct device *dev, const char *new_name)
 
 		error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
 					     new_name, kobject_namespace(kobj));
-		subsys_put(sp);
 		if (error)
 			goto out;
+
+		is_link_renamed = true;
 	}
 
 	error = kobject_rename(kobj, new_name);
-	if (error)
-		goto out;
-
 out:
+	if (error && is_link_renamed)
+		sysfs_rename_link_ns(&sp->subsys.kobj, kobj, new_name,
+				     old_device_name, kobject_namespace(kobj));
+	subsys_put(sp);
+
 	put_device(dev);
 
 	kfree(old_device_name);

---
base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
change-id: 20240717-device_rename_fix-ecef084784e5

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


