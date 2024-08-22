Return-Path: <linux-kernel+bounces-297267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54995B527
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9529C281485
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17CF1C9448;
	Thu, 22 Aug 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QFd0fYVd"
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE51E4B0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330375; cv=none; b=GcZ9kiK840hFyZkWMicZ9W4JIy1OqTH+1kCYZx2HQxS8qPL6vyWhyd4PEjwfC+EPuCpUueizSPJQTP8KLRt+m7iLkMynoJQQMkvSdMegOvbgK9EKei0AqwdgCKuz7pzx2PFgGsIO5YF0okEys0nbAm7rBeRXOW5vH2gptbb1P5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330375; c=relaxed/simple;
	bh=RynHmN2gMeG5hZNxID/wz5S8aWNuTqYGkCl8h1k0Qp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MfrZb+Sj20R7bKGoiNQfSkgZHODOjqhGhmeVrlGSFT0vu9+kD4AOnMuCLsnbfc0GfJga2+7l/Oo50IABVX5ZmnLGsALE2OulI/hhpWdUmWTTGVwOqFMxtAd9mw2jSGpyzfdPLmyuoaNc5ekvL2ialhhaIaKl/Voqr6e621ftBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QFd0fYVd; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724330373;
	bh=JJKwLyyBkIJTTeomI04tY7FZXyk74JgnS4B7BHaoTn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=QFd0fYVdbfKaEZd3X6TFL9OCSOvADCDzkpFYwkR4Cb4YlyAlJzwN0HjoaIRyIEF7n
	 Rf/EjUNM5hwiAFOxXTrWI8AyA6PJeTfRIVqZTAy2Fur23qjbVeW8lyx+TpiG4rWVhH
	 DZu6tje6ny4r9kcbtuo0Wzxm1XpgNZ6Z3ydz5QMBkKbzmrf1x60UTtpG6OgOonBXgE
	 RuLDu+/uTmzpGrsaLs9lAobEI/pYIZLBEKMoPtaMnLoif62qRpToiawQljeooxQLTR
	 Gs/W5EikMU+VdYoOIeAdiVdQKskyBpangPi3ZFkz4CoqbYoyNLMWRg/H56gMEtcZ+n
	 iNHbdf2SFASpA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id D0EB72C0469;
	Thu, 22 Aug 2024 12:39:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 22 Aug 2024 20:38:35 +0800
Subject: [PATCH] driver core: class: Check namespace relevant parameters in
 class_register()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-class_fix-v1-1-2a6d38ba913a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEoxx2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0NL3eScxOLi+LTMCl3jROPEFCNz8zSTFCMloPqColSgMNis6NjaWgD
 u1ZLhWwAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: yXwXl9UK3zmUZfejmnTViZh2NHAH6YUH
X-Proofpoint-ORIG-GUID: yXwXl9UK3zmUZfejmnTViZh2NHAH6YUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_06,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408220094
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Device class has two namespace relevant fields which are usually
associated by the following usage:

struct class {
	...
	const struct kobj_ns_type_operations *ns_type;
	const void *(*namespace)(const struct device *dev);
	...
}
if (dev->class && dev->class->ns_type)
	dev->class->namespace(dev);

(1) The usage looks weird since it checks @ns_type but calls namespace()
(2) The usage implies both fields have dependency but their dependency
    is not currently enforced yet.

It is found for all existing class definitions that the other filed is
also assigned once one is assigned in current kernel tree.

Fixed by enforcing above existing dependency that both fields are required
for a device class to support namespace via parameter checks.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/class.c | 11 +++++++++++
 drivers/base/core.c  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 7b38fdf8e1d7..49612609de80 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -183,6 +183,17 @@ int class_register(const struct class *cls)
 
 	pr_debug("device class '%s': registering\n", cls->name);
 
+	if (cls->ns_type && !cls->namespace) {
+		pr_err("%s: class '%s' does not have namespace\n",
+		       __func__, cls->name);
+		return -EINVAL;
+	}
+	if (!cls->ns_type && cls->namespace) {
+		pr_err("%s: class '%s' does not have ns_type\n",
+		       __func__, cls->name);
+		return -EINVAL;
+	}
+
 	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6d3897492285..2f616423959f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2595,7 +2595,7 @@ static const void *device_namespace(const struct kobject *kobj)
 	const struct device *dev = kobj_to_dev(kobj);
 	const void *ns = NULL;
 
-	if (dev->class && dev->class->ns_type)
+	if (dev->class && dev->class->namespace)
 		ns = dev->class->namespace(dev);
 
 	return ns;

---
base-commit: 18ec12c97b39ff6aa15beb8d2b25d15cd44b87d8
change-id: 20240819-class_fix-3a3ad277f4d2

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


