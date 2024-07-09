Return-Path: <linux-kernel+bounces-246006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D845292BC96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A2D282983
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56718FDC6;
	Tue,  9 Jul 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="WC7JYnMR"
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8C18C325
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534439; cv=none; b=JeB4RfeclzgFHs2CbLR4YpFEPJFcFTkfAktu8FqXluKK7f2C0hK8ZWP26nanqGW8IsqlnZeBWOBlqQeuiQWOfhfG/8aIq25XvFc9GgJFXYgyJxZ5NBSuVhgXsv+XT8cSQIdp84aSHFrxmfi1k7o8LHn9mKbQEIVjvI4JSthb3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534439; c=relaxed/simple;
	bh=lnNyC86d9TANmWEAIBMlAa8dQ7f6OUxUJH+CuRzBX0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rip+A4ytn6/XzJvkr+glfYn30CsaGO9Mv+4jLONC/6Z0vdYEhc0N6yWqOmQl0dVDX9HmuQ0QFB3J64rc/QGEV6lbpgtXf9he1923qzQJ9dV8PxwKf+/BAaSYQ+sReuMtO+DICMB9RBPszYhD6jiClkPC8Wlu9YtFIK8MDOS/Of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=WC7JYnMR; arc=none smtp.client-ip=17.58.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1720534437;
	bh=dpuHNKPiXoYW2Qf7JXMKDeaewNwns3Njdo1qRGv/CO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=WC7JYnMR2hxREmMXlxXsgvlIBTZQrEseLuVSNodVQD5iCr7r2CufV1kyQB9UXib8K
	 xMdvJkRLxuwVutMN3x5y+TOJOEJlTZRqM5FxBIRHSz1nMZflbVLOXg+HiCnAEOFM5g
	 yJMrrOqUUO3XIKyN6N2qAxzWcbBCMCNcYmJbkJHM0PNFJdjahWn2St2lkSYQjG871v
	 MJLYo4vMvucRDwNGDsrVUskvR4Q+8R4UMsv/I8YVFF4pcBC9Sy10/CmVpEqKhIhlNb
	 /R1pqiy27N+LsvKK1427BSbaP/OvJZOP6fH2SG5TPzWVzL6wxJX/gqT00Pw/oKqZsH
	 QxjLl4e/3Y/tw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 17AFD74037E;
	Tue,  9 Jul 2024 14:13:53 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 09 Jul 2024 22:13:11 +0800
Subject: [PATCH v2] driver core: Fix size calculation of symlink name for
 devlink_(add|remove)_symlinks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-devlink_fix-v2-1-22254f1138e1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHZFjWYC/22MQQ7CIBAAv9LsWQxQbNWT/zCNQVjsRgsKSjQNf
 xd79jiTzMyQMBIm2DczRMyUKPgKctWAGbW/ICNbGSSXive8Zxbzjfz15OjNuNOqs2gd7jZQi3v
 Eqpfbcag8UnqG+FnmWfzs/08WTLBOttqcVSuM3R4eLzLkzdqECYZSyhet/R21qAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <zijun_hu@icloud.com>, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: -LJo1SWCKClQke2zaU7QKM7Qx6ylLpKH
X-Proofpoint-ORIG-GUID: -LJo1SWCKClQke2zaU7QKM7Qx6ylLpKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=701 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407090092
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

devlink_(add|remove)_symlinks() kzalloc() memory to save symlink name
for both supplier and consumer, but do not explicitly take into account
consumer's prefix "consumer:", so cause wrong algorithm for calculating
memory size, fixed by taking into account consumer's prefix as well.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
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


