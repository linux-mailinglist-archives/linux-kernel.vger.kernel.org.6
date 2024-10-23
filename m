Return-Path: <linux-kernel+bounces-377831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9F9AC761
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341B2281F65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201B19F409;
	Wed, 23 Oct 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nulMYJ0d"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD919F118;
	Wed, 23 Oct 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678017; cv=none; b=R/rkwsy0bfaKzMQBhEy9/4mS+8KiPS2DSaJWLLUbI4AnF+PyHGgC2r1Zh9pNlIb61FmW4pVu/oZ10894h4DL7CGQWTrjcTzUSmRg+T4FJE+qEEPIQ8bXXHm1VuAH2dgshRR07f+R4bHyKtjSntd+uWa/hH65asTxIMzuoIQNg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678017; c=relaxed/simple;
	bh=XbBMJkJhB1zkwTuFd0Aug1qziRqya3ZuGlxa7PN53bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umYd7I49mhs7PImWrNG/xQssQmZjpSQRRKcoD3Tq+Wqoc6/LzeavvYFJ3uRF7beOmjajjUfeGRSD3zac2Cr8C8cRdaf4y2UmXh15/xyAD8xZy2IaPs178sr9IZZ8IpVkp7KxJS6/XtWXiejkz31nkJ/RJBhClUoEGi0T2D6HCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nulMYJ0d; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N3SS3W032296;
	Wed, 23 Oct 2024 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=wyFIK78EH884MA8M
	dFyktjKGL0/jZebUjv7VZIPbTbQ=; b=nulMYJ0d4nMacifU0zraKeUvtT/+90/L
	18rIg42NpwK0sRHmzKY5IogVy/Bw7ZGX5haOvX3IgXHOFq9OTP6udgtnwZprhGj3
	VKLwax8NQjvtwdDrcF+r64hIcSdURK5BXgZt3ftb9hFEna1kU1uCY67uCclnw59h
	DadYJFLvP+BiPy8q1Jp690NxI9F/77vandHeM2oFUJOLudKsm3MmPMiZKRvSXhK2
	onZSWPdiaHIqNsXCQDV6zJWERDYF6AQU5AjSwBTCQlfK8UYjwAopezXGysbQIOHN
	R7gdyBt7V5m2c3gAsjL4knKSJPHYVH87Tx6q2CvjvrIXCcre5GsGkQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jcnpr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 05:06:40 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 11:06:38 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 11:06:38 +0100
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 266F1822562;
	Wed, 23 Oct 2024 10:06:38 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Maciej
 Strozek" <mstrozek@opensource.cirrus.com>
Subject: [PATCH] mfd: cs42l43: Prepare support for updated bios patch
Date: Wed, 23 Oct 2024 11:06:34 +0100
Message-ID: <20241023100636.28511-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: edif8Zo5Jtpt4iYgC-7rGZcS2asxr5yt
X-Proofpoint-ORIG-GUID: edif8Zo5Jtpt4iYgC-7rGZcS2asxr5yt
X-Proofpoint-Spam-Reason: safe

Newer bios patch firmware versions now require use of the shadow register
interface, which was previously only required by the full firmware, update
the check accordingly.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 3b4efb294471..35a633457a93 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -48,6 +48,7 @@

 #define CS42L43_MCU_SUPPORTED_REV		0x2105
 #define CS42L43_MCU_SHADOW_REGS_REQUIRED_REV	0x2200
+#define CS42L43_BIOS_SHADOW_REGS_REQUIRED_REV	0x1002
 #define CS42L43_MCU_SUPPORTED_BIOS_REV		0x0001

 #define CS42L43_VDDP_DELAY_US			50
@@ -773,7 +774,8 @@ static int cs42l43_mcu_update_step(struct cs42l43 *cs42l43)
 	 * Later versions of the firmwware require the driver to access some
 	 * features through a set of shadow registers.
 	 */
-	shadow = mcu_rev >= CS42L43_MCU_SHADOW_REGS_REQUIRED_REV;
+	shadow = (mcu_rev >= CS42L43_MCU_SHADOW_REGS_REQUIRED_REV) ||
+		 (bios_rev >= CS42L43_BIOS_SHADOW_REGS_REQUIRED_REV);

 	ret = regmap_read(cs42l43->regmap, CS42L43_BOOT_CONTROL, &secure_cfg);
 	if (ret) {
--
2.34.1


