Return-Path: <linux-kernel+bounces-282099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BE94DFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04AC2833A2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21644C77;
	Sun, 11 Aug 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EAJsCaQI"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F16446AF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343158; cv=none; b=CV95x2lV/2RysMr2JSWZx2X+BtPgpIf5wybqi1n0gR7S2WgA81UJOX/VK7EzCkM0fbEvzUmCQjJ3ySNAlypYoaxzVViPu1hGwZOqR43umwYZW4OilUkIxi8I1zoEctNzzJ0L5keoI4JkjcZ+SXvqhqQGT37lVTd8pksY/jiYiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343158; c=relaxed/simple;
	bh=sf0NJehlMStpdVVTg1pyLN4G/10LGh3fKDnzZpwQJZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltdgbsDfUeUQYxcoJOV4NX3HcV+SZSzFdGib2m56knhEI8BA1ed0Or0wFG2MZY1evmMeXMZ4eFg2oeVCO92cGP6AWV140LQDnNjiJOEwKI/h0jRb5Xkj1iqKrKFg9zLoF0j2xttZfOX+RzTBUFzpmORXJCqAk6Zekap9hllnj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EAJsCaQI; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343156;
	bh=elG2qmpRpz9gELoTpK1wIv4mQqpd80rruog75+elptM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=EAJsCaQIYSnNlaUvDK/fTOMAw1QZsOG1vx44flca6v7+KR1Arra7MZwxUnQglMBwi
	 kbR49cAjxJnmfQ0mDrZkzUKpIcK8SyJoYynT2l9lyPhAZewdBvLfbwAJ/Oe41fmrqV
	 HWprV5irb6QMOfsRGF8jpNf6x4jolpmvFSNpogDgFe+/7RU9veFv70cAqPaqhKfHKl
	 u4xwGigh6rhkxcuBbX43Kg+ZSZNbEM3NWip7kNU6HudctsbCVkXdMubfG+n50xQuhv
	 hv7O9rGDo2ulo/Unh5KYkszeyJdgXv2zzjDlG9UXpPmOj2trDBjtpTCrfQRv8GfWGx
	 xoc6wzs9Bp2YA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 72FA01349ACE;
	Sun, 11 Aug 2024 02:25:52 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:02 +0800
Subject: [PATCH 11/27] media: pci: mgb4: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-11-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: ZpGgEJa42I2nU2qtmWQbDHHPXu4kf50S
X-Proofpoint-ORIG-GUID: ZpGgEJa42I2nU2qtmWQbDHHPXu4kf50S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/media/pci/mgb4/mgb4_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_core.c b/drivers/media/pci/mgb4/mgb4_core.c
index ab4f07e2e560..4707ed1a8298 100644
--- a/drivers/media/pci/mgb4/mgb4_core.c
+++ b/drivers/media/pci/mgb4/mgb4_core.c
@@ -123,7 +123,7 @@ static const struct hwmon_chip_info temp_chip_info = {
 };
 #endif
 
-static int match_i2c_adap(struct device *dev, void *data)
+static int match_i2c_adap(struct device *dev, const void *data)
 {
 	return i2c_verify_adapter(dev) ? 1 : 0;
 }
@@ -139,7 +139,7 @@ static struct i2c_adapter *get_i2c_adap(struct platform_device *pdev)
 	return dev ? to_i2c_adapter(dev) : NULL;
 }
 
-static int match_spi_adap(struct device *dev, void *data)
+static int match_spi_adap(struct device *dev, const void *data)
 {
 	return to_spi_device(dev) ? 1 : 0;
 }

-- 
2.34.1


