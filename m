Return-Path: <linux-kernel+bounces-180311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F349E8C6CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD080281D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F415AADE;
	Wed, 15 May 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="C3WezpJK"
Received: from st43p00im-zteg10072001.me.com (st43p00im-zteg10072001.me.com [17.58.63.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC73BBF6
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800820; cv=none; b=SRd6tQ64rKj1MQw2mchRyjnrWJ4ltwFyk4B5dNpaWf99/jPXQeSK0moI8PCTG49ONwlHi+HBHJUj0GExkMwtsHSMdUg7qXnko6PGaz7YWaB1suUbYyKTqr16Pp7HtqIaaUIZAx36/dI2ONI8Ro+BXnVoOcRZICntFKESLKHKZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800820; c=relaxed/simple;
	bh=Prmzm/RN0BcYmaIiUK8WwBAZ7FwXUveOP6CKkBYomkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CHdwZLo2ZT3UuhkIn9jG0ulXF+TQhbwqcY5aOvC7svaKQavKal0I7OdY10yrA3V8JvIp3YwmI2gRK/624JF0NIyz94vcPJSsUPxzseYNrjsSNi5x+L5hzuUd478YrSV90vSYdnL21YFFHJU0Puipg1vfi8nq3t6jBhEyVz5ZF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=C3WezpJK; arc=none smtp.client-ip=17.58.63.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1715800817;
	bh=gChLto0wuBmBkw+d7DrIrxrJwuCOppo9zmpl1lXbdD8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=C3WezpJKXYp1V0bqCt0aNOoC9wj6JqDMqgkHD2VNIDZqvy8Gr/TCb8nbCjit+fuKm
	 /TwfGTCWMRiTjQ17PreSa4pM1mez7aOngR/ayALjbaZCCNs4rdk/EpuqX6Fs6Ln7J5
	 TILmtLomiH0OOtiysvqoBvY4nhFTowJVHYZGqP0oSskL09d1JhuRUCWkUrJQSQYl6t
	 3EYO2A3LNnFLcQK+nBrfeJwM0VpNOGa4hrcPcwdFZPdqU1RuQpJxJQ6rYsarwVWgQ4
	 ChLsLfywXTN1416GoGw2gZO7zvKza3Jsi1xqkVnpPIXDrbYvEeJIcz/1hk3BugMbvx
	 uveFWbFI/kWyg==
Received: from kendalls-iMac.lan (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id 72CEF120E52;
	Wed, 15 May 2024 19:20:17 +0000 (UTC)
From: Kendall Smith <kendallsm2@icloud.com>
To: amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Kendall Smith <kendallsm2@icloud.com>
Subject: [PATCH] drm/radeon: initialize atom DIG backlight for iMac12,1 and iMac12,2 with Radeon 6750M
Date: Wed, 15 May 2024 15:20:09 -0400
Message-Id: <20240515192009.14362-1-kendallsm2@icloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vg2uwT33525UOzvB4dxOGeO5YaER4aZP
X-Proofpoint-ORIG-GUID: vg2uwT33525UOzvB4dxOGeO5YaER4aZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_12,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405150138
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

If a Radeon 6750M GPU from an iMac12,1 is installed into an iMac 12,2, there is no backlight device initialized during boot. Everything else is functional, but the display brightness cannot be controlled. There are no directories present in /sys/class/backlight after booting. A simple one line modification to an if statement fixes this issue by initializing the radeon backlight device for an iMac12,2 as well if it has a 6750M. After the patch, brightness can be controlled and radeon_bl0 is present in /sys/class/backlight. This was tested by compiling the latest kernel with and without the patch.

Signed-off-by: Kendall Smith <kendallsm2@icloud.com>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 2bff0d9e20f5..7b11674f5d45 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -201,7 +201,7 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	 */
 	if ((rdev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
 	    (rdev->pdev->device == 0x6741) &&
-	    !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
+	    !(dmi_match(DMI_PRODUCT_NAME, "iMac12,1") || dmi_match(DMI_PRODUCT_NAME, "iMac12,2")))
 		return;
 
 	if (!radeon_encoder->enc_priv)
-- 
2.34.1


