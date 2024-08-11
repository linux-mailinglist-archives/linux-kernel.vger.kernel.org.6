Return-Path: <linux-kernel+bounces-282090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C694DFA2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530941F2168F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C54BA47;
	Sun, 11 Aug 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lF72Ia4r"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC7171BB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343121; cv=none; b=RAlUpR3WCweUiS1WQgwpq0yUT5XRYv1uJO7TvEN+YoV4zrhVQT1+d6+nKoiuJTrukhG3k/SO7sDqxy2nCbayuJZGJSrJR3uldCXmX/SmDjQ0eq6cU5ZcBff1QMaBt2LhODlTe85LJVI0tAu9HA/QBmEczqe8aWDvheM+ZvFj7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343121; c=relaxed/simple;
	bh=/gYbUyI5Xfd7lT6SCs/zp0dgkVfciTfPBV1gPYkbdrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUoJEjPk6A0S2W54V0SCL47sBxlN0ww7/56NOVTN1IdPl4h77R+ch/BLWOMKN2N+ifHQsLNHTsuaP+Pixcn+ViLi94mJakF0PTxYjYMMGNPEiUTkZVOCxLFHMZyV9uuMwRYfRNEHh6dwQmolMBk7dvChJ4zkFMSQaFbzKYEXjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lF72Ia4r; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343120;
	bh=XK0bPK4BlaMn6bfQnvooV4LqoyBxlBzyAy4Rjir5uEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=lF72Ia4rwHSZzBw59bHJd6PdxqLLieAZgKILeZ3RJqMAK/F/cO+GpbV+PthCcdnGM
	 uEq1riauPOpNK1i2CzZg5suLdURo/We1KOiaKJl/+uxHDsMTNJ/eUtHsjefGYDMDcf
	 aPXBsZ4mLgBBjuQcQP+YdkPHkx0vT2Ixs6ne02QZbz7KnMyWx1aZovvtJEHYuXRtdp
	 xEf/LLRFFkyZS2URLv5/k5cX1MAk2QSTPETyXgoqdvNeuiFA9hJL1W5s5UViy4KGzT
	 oKQIUUB9pPbd+rSADS79IlxLWTcNOBkSn4AZB7/AEXtDDYMiQ9ByCIsxZGx0kZIgS6
	 DaJ1aN0EQCr2Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id BF0831349C0A;
	Sun, 11 Aug 2024 02:25:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:53 +0800
Subject: [PATCH 02/27] Bluetooth: hci_sysfs: Make device_find_child()'s
 match function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-2-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: cNqqWYwqHMq1Js7WY-wQzsgTwn5NqL_5
X-Proofpoint-ORIG-GUID: cNqqWYwqHMq1Js7WY-wQzsgTwn5NqL_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=946
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make __match_tty()
as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 367e32fe30eb..36642813d2db 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -26,7 +26,7 @@ static const struct device_type bt_link = {
  * is down, and sysfs doesn't support move zombie device,
  * so we should move the device before conn device is destroyed.
  */
-static int __match_tty(struct device *dev, void *data)
+static int __match_tty(struct device *dev, const void *data)
 {
 	return !strncmp(dev_name(dev), "rfcomm", 6);
 }

-- 
2.34.1


