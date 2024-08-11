Return-Path: <linux-kernel+bounces-282089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E494DFA1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395011C20B26
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895FEAE7;
	Sun, 11 Aug 2024 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pLgGU+Ae"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4203EEBA
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343117; cv=none; b=shGEvwVR9Tkhm3BFdz8mKI+a3KHBGzpy1isFzSoYLX8ndMthD8sAzrycuOmW9wjpXoMVFRIAhK7xzVnL2ZSzGNdYh2ueMpC2bVyu/yjAtOZTCJfpj0tM0YfoZobaTKZabmogIbD4jow/8tt51yc4lCxGGYGDfjN/1j8rLCYjkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343117; c=relaxed/simple;
	bh=PbWxkk4EsobTyjiBJI/bksmBM2kNIYXncyMd1A0yeBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eooOBWI4w1ApAnRoIsGSZjySxf2OWoPFk+ezJRygKoLuqVPoR/x5IiIgHgB+U8YLeiiC81SbbXm1pfvQJGGkzdewE7xMD46AJAaR43AeeIYBjyP7FyatgxKwzn2eKZOpw9Bor4HEDKwe7FrLXuDuYE5No91ZCo20Vla2mwC4MvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pLgGU+Ae; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343116;
	bh=bmLRxO/h3QnM13AJLhu8R63THlN/FkfHruQjlaYVMzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=pLgGU+Ae39+oE77dAwUZ2ELSMu/y3CyM3aSC+7L+mYA0uBWzy97C3go3vBB2/DaUH
	 s7h0M9aq663gEqFwPMfg6Af+1tzFwR3xEMmm5ARRrrRg0e7MDOwf66sVOEGRINT263
	 SlDAGEU7ESckr+23gcmLSU0AGhFWZ3ZK9fzGsDpFoeuyMJcLwhholcN1bRPejg3VOW
	 0W093xkjPUKsI5vbJJa/gPLXrFaP0Wqyzmkd55Lkf4UqMfNgV5f6kK9v38HaNJjBYm
	 SwIqbQ0Mo2PeMRQYPzeCPYqJDxVPS3m7ovEGtMFwJ394eeHqGvY1qVCw5LBZNm4RRE
	 YDP5/M0FlFM3Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id AF0981349C23;
	Sun, 11 Aug 2024 02:25:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:52 +0800
Subject: [PATCH 01/27] driver core: Constify driver API device_find_child()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: Fa20o5PiSaKcemgJaRg3lycCUBDGzMFF
X-Proofpoint-ORIG-GUID: Fa20o5PiSaKcemgJaRg3lycCUBDGzMFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Constify the following driver API:
struct device *device_find_child(struct device *dev, void *data,
		int (*match)(struct device *dev, void *data));
to
struct device *device_find_child(struct device *dev, const void *data,
                                 device_match_t match);
typedef int (*device_match_t)(struct device *dev, const void *data);
Since it should not modify caller's match data @*data.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c    | 11 +++--------
 include/linux/device.h |  4 ++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3f3ebdb5aa0b..f152e0f8fb03 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4062,8 +4062,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
  *
  * NOTE: you will need to drop the reference with put_device() after use.
  */
-struct device *device_find_child(struct device *parent, void *data,
-				 int (*match)(struct device *dev, void *data))
+struct device *device_find_child(struct device *parent, const void *data,
+				 device_match_t match)
 {
 	struct klist_iter i;
 	struct device *child;
@@ -4108,11 +4108,6 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
-static int match_any(struct device *dev, void *unused)
-{
-	return 1;
-}
-
 /**
  * device_find_any_child - device iterator for locating a child device, if any.
  * @parent: parent struct device
@@ -4124,7 +4119,7 @@ static int match_any(struct device *dev, void *unused)
  */
 struct device *device_find_any_child(struct device *parent)
 {
-	return device_find_child(parent, NULL, match_any);
+	return device_find_child(parent, NULL, device_match_any);
 }
 EXPORT_SYMBOL_GPL(device_find_any_child);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b2423fca3d45..76f10bdbb4ea 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1073,8 +1073,8 @@ int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
 				  int (*fn)(struct device *dev, void *data));
-struct device *device_find_child(struct device *dev, void *data,
-				 int (*match)(struct device *dev, void *data));
+struct device *device_find_child(struct device *dev, const void *data,
+				 device_match_t match);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
 struct device *device_find_any_child(struct device *parent);

-- 
2.34.1


