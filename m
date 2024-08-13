Return-Path: <linux-kernel+bounces-284631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73895034C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2EAB27A52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE81990C6;
	Tue, 13 Aug 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XcPbjLUu"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B61990C0;
	Tue, 13 Aug 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547284; cv=none; b=RjO0byuF96336vDHmXTZGqX0DsTxR26Pt2I134kbe/kFcnSf6swUUFNI/H2GNbChO4Ksz+iMylGXk/ulArSN40wZ/UzVTXi8962pNVU1v+lx2FkNbXmdwRUTDT01kw953uFrDmkluyhMK+urII3ZdEx01SbT9ipDTu7VV9nntr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547284; c=relaxed/simple;
	bh=XJ/KPDgCVWELMuO8veti2O2voiZLmpnEbpnJ1fVPoSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOAYqRCd+Y8f2F4xZ+FO7aNDSBpQLtc7QzohwKAcSceLP5aBqnDgQ7sRnEe50hCgSh0iLuZf4SoFOBK5KS7Z9A2o+PbFKc7o/viQ9e6X8qEz+Rdcrp4QUeR6pXlj2nfyo8k+tRgSnD3nhrG0zoMqXCWDea5x1cCtw4Sctla5/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XcPbjLUu; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D2TvTP023256;
	Tue, 13 Aug 2024 06:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=flIsohz418B7fxP3
	DsCMNcDk7DLGfOnPZ1GVd/PWGk8=; b=XcPbjLUuotgO2BZ+9A5AwDv3p9wLQ7Es
	hMvn81w+ioKxfK421KdhC45c4rTQVMMTfiaMApKwIgSe23QAflaxtg68spAZR/88
	56MjBZE5B+YNEPh1Iuqrg9ynjPrzp2KQMC/vJCca7gqJgWInneubPYL0haRdFUWl
	X83GSggL6KqTXrxAEWsSgjIIUWYhz/jYbjgUM7bUtpwc+mKLwjz/JBufcbmBYCRr
	8LZ/HOcGUOXrD7DwQEmYj0yy4FPi/5trL8Rci6kvbN89u+KorLAtESiqSmxoV3D9
	M1M4JQ+52nP/Wyjk08du81T4U9vq4ak4vngK/1OmsASUc3cG3oSWoQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwk45s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 06:07:55 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 12:07:53 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 13 Aug 2024 12:07:52 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.68.170])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AB159820241;
	Tue, 13 Aug 2024 11:07:52 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Remove redundant call to hda_cs_dsp_control_remove()
Date: Tue, 13 Aug 2024 12:07:50 +0100
Message-ID: <20240813110750.2814-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6sfEIip0XTXCNRzzw4nuM_L8IRJ59QDT
X-Proofpoint-GUID: 6sfEIip0XTXCNRzzw4nuM_L8IRJ59QDT
X-Proofpoint-Spam-Reason: safe

The driver doesn't create any ALSA controls for firmware controls, so it
shouldn't be calling hda_cs_dsp_control_remove().

commit 34e1b1bb7324 ("ALSA: hda: cs35l56: Stop creating ALSA controls for
firmware coefficients") removed the call to hda_cs_dsp_add_controls() but
didn't remove the call for destroying those controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 34e1b1bb7324 ("ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients")
---
 sound/pci/hda/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 31cc92bac89a..a9dfd62637cf 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -413,7 +413,7 @@ static void cs35l56_hda_remove_controls(struct cs35l56_hda *cs35l56)
 }
 
 static const struct cs_dsp_client_ops cs35l56_hda_client_ops = {
-	.control_remove = hda_cs_dsp_control_remove,
+	/* cs_dsp requires the client to provide this even if it is empty */
 };
 
 static int cs35l56_hda_request_firmware_file(struct cs35l56_hda *cs35l56,
-- 
2.39.2


