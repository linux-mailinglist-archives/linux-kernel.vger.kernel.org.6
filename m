Return-Path: <linux-kernel+bounces-282093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8694DFA6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C281C20C68
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D71FBE8;
	Sun, 11 Aug 2024 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ktDeSlqm"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24103208A9
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343134; cv=none; b=NWj9//EvsrWjswVKPWM5qZf9wdg+kSF3mNfGERNBCUbWAnMqEYGoZfMUd/8lS1mpT0Lz/IxwE3oLZ0DQM+eXF0gw9psds+ii78ygwP5gBQd4RSgvfsnOsc3aeoLweffnRP/AXp5IlBpQpxug6gKvzJ/ZPrpBSOeVler87EI8MW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343134; c=relaxed/simple;
	bh=o7xI9NE01Mw3fyy1uV6fVnml1Yp4NoDlaIZW/yYCoXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8AgmgBoWPilPTvWNdyCJdXLVfVbUXQwtpJ11iCOfTJmIBhgMJYHuO0tfPkDty87wZYgk685PmmVaJ517wuhYf4h5koYC3SAIoW33lbe57mbao7Z4q1vImmAlpUpEziW3FJ+rOJSlSFgVRD0GHQfNsaR3smtwEvL1YagUsrRSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ktDeSlqm; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343132;
	bh=Kepp7T28Cyhs8u4vOvaJ/2Ogjqt0jlOBm+U7CEf6vR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=ktDeSlqm+GbYgHJnNigTGstna93eohIydp/d4vVvwS3pl7mMeUWC3IaPIOqfbZhe1
	 aPqPLYGejKgOWWM15GnIYBbe8ujnU7xOnsE43RIcgLw9v+f+xalyuKYFX99sCWHw9F
	 0f1AultV+qDkUOdaz1iviOmB3lPYM4awcr6d8FZlwWzkrxczES7rPZV9vgCfWJSejf
	 0QHBhSiP7d+XIBhOEnOEExmp+O1Rj2B2BNFCQDs6pvN1KojpcFwKBXtxTC7A4sdfFo
	 dvyTobxK0frvFnDFNumNxTJr8tU4rVi80uSOd0RAOD5aDh9/gdRJSxbexszqI9PPso
	 kzmNcAhqQgLxA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id EFE9F1349C28;
	Sun, 11 Aug 2024 02:25:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:56 +0800
Subject: [PATCH 05/27] gpio: sim: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-5-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 3WhF-8r1zRqiWpM_O8x_Odq4m4ANx0jL
X-Proofpoint-ORIG-GUID: 3WhF-8r1zRqiWpM_O8x_Odq4m4ANx0jL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=889
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
gpio_sim_dev_match_fwnode() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index dcca1d7f173e..39af176eaa3c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -413,7 +413,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
 	return devm_add_action_or_reset(dev, gpio_sim_sysfs_remove, chip);
 }
 
-static int gpio_sim_dev_match_fwnode(struct device *dev, void *data)
+static int gpio_sim_dev_match_fwnode(struct device *dev, const void *data)
 {
 	return device_match_fwnode(dev, data);
 }

-- 
2.34.1


