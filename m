Return-Path: <linux-kernel+bounces-255312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9DC933ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3968283027
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F618132F;
	Wed, 17 Jul 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HNb3qLVb"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CB180A6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227825; cv=none; b=aVy62R3GhU0QT8+2n6DpOFk2NqQ2slUoyt0kN1Mf9l1NmJIQuf+Q1jG+WqirvI47v9G7b1xljdrbxKxLctZHQK46aasgpYUk1q2xn/StDjBBXqhYEL/cHBZsJliEVt8TXpSZiAc7VBD+ItGmBJfnlR2iEM/vLG15odUIphrPeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227825; c=relaxed/simple;
	bh=kOC7dain/Ecn19fnYCSA1BsvxNkv4qPBuYHtr6kGdec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mcxuPSAyct77c2sjbZpsK7RempYfMhqiYQwmCZZzJO07dtqeUJ6TnWXWNAKJ51ofz1iphu6e2QQf6C6rv93KFsxkxgUh6rHtkKamzX0JjkCJiNkBPL5L6dxeuKEbBrDPhUWW4Aa8uc1UVvMbrU4GF6BpADTSNvdKy8wqz6UvqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HNb3qLVb; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1721227824;
	bh=IlittNRrWIwg+J1ede5MGTyPJ8aU7D2MA3P6IZLCUTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=HNb3qLVbZg6jhrJp2/p5LBUiiiFk1/thCt+zgP1wFVK2sji5TllVBfRa483mngGS0
	 IoFifzn0hkttQPQ2B1OYbDgyCcAtk/QeIeo8byENgrNbPLipOReu4wrCiW0vAz2y5W
	 JSkMxP9Pg5USlgzhrIrrZQSb6a5uuNDcCSQywsD1ITXLbXlI/1z4ZRW+VhLs6lFyif
	 L9NC0yQ5OpNGWL3KSBwt7S8aXhYk7WAGkM2QyhjLeu008u3uFm1HVVXuDmPc5WA3dG
	 RB6uVHY2DhSuDFH7haDlSNmg3vKwBUhr8frDW+nm58JKQwsb0AT0MzCvkekAFEpcM1
	 fNwNZdk0B53qQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 98CB218055D;
	Wed, 17 Jul 2024 14:50:20 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 17 Jul 2024 22:50:05 +0800
Subject: [PATCH] driver core: Fix error handling in driver API
 device_rename()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-device_rename_fix-v1-1-54d85024518f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABzal2YC/x2MwQqAIBAFfyX2nGBiGP1KRIi+ag9ZKEQQ/ntLx
 3nMm5cKMqPQ2LyUcXPhMwl0bUNh92mD4ihMRhurXedUFClgyUj+wLLyoxCw6sG6waIn+V0ZMv/
 Naa71A8iGJH5jAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Benjamin Thery <benjamin.thery@bull.net>, 
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: pObZy8LU45do_ik5wl5xDhsv4mPjPFbg
X-Proofpoint-ORIG-GUID: pObZy8LU45do_ik5wl5xDhsv4mPjPFbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407170114
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Call failure of device_rename(@dev, @new_name) maybe unexpectedly change
link name within @dev's class directory to @new_name, fixed by correcting
error handling for the API.

Fixes: f349cf34731c ("driver core: Implement ns directory support for device classes.")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..a05b7186cf33 100644
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
@@ -4537,17 +4539,20 @@ int device_rename(struct device *dev, const char *new_name)
 		}
 
 		error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
-					     new_name, kobject_namespace(kobj));
-		subsys_put(sp);
+				new_name, kobject_namespace(kobj));
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
+				old_device_name, kobject_namespace(kobj));
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


