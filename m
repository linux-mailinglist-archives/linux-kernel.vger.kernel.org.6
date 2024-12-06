Return-Path: <linux-kernel+bounces-434910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D39E6CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD45165C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E31FC0F6;
	Fri,  6 Dec 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WshrjyWF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DDA155C94;
	Fri,  6 Dec 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482688; cv=none; b=jwWjho+cMxz9QstjvW4+/GbO1u3Wa2qqeWMU56qKWkH2g4AnU+oa5tgMj29D7bgWxMyEHmkCrKxA0Hmug2jpVHTaDaxUVbgtk1oCUX1Vha9FOeQ5B5oOw2jyEwZJYmSdVdBk+Qhl0iky/lmTjEMiffCOW2r/whqXQ7KVohPbxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482688; c=relaxed/simple;
	bh=v6kyc1i3SuTZvC4nieWiq0GNXtwkIvYMeml68Vhjgnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JweOV1qrTSSjW5lRnmuSYs2FratLbQgevx1xPF28RDmdGH5itn43inROFnkE0WuXveK820iMXbM/pVHdvSeHKm20B1Gy+IHo57Mph3Sw5TLpIgmzw9U+2j0U/m3ryEmHxuJ1l7wbq8EJmg+sBcmUu0eiLo9opQRW+HdgKu3fdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WshrjyWF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B63bf0t012353;
	Fri, 6 Dec 2024 04:57:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=3umCSMyiQYvQvu6S
	NzA7dpiB28Hwzv3v+BntoK8JoEM=; b=WshrjyWFULGBFpuUXE7x3ZWJQ9AmsBbN
	ygCkt7qxhN9V9qtgiiRM9TYMFytjHm22q3isI4J7wq7bRb8cfVye5TWujFI0dr8E
	l+Oy1p0uutl2PoRjxYOM8Fp9ZUs+f5zQu0guT16NTCj5dFCX8aGpxwIFsBpr/exA
	Ulj+7eP6Ykk+EnVmW5HPjwzCMoZF5gXESEnPlhBXMkRuBXmZE+XuAHE3sltG1Wv0
	kue+9dy+9TGoasBVPwPo5EvmiCI85R/FiDPrqMfRMENISxPpWpLjDCkHhBi9QhRH
	9Sv0Hs3kQLhBTt2gPqmqowe07hHmf7U1xMq8ANtNx16tone5RHVzYg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381023ruy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 04:57:59 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Fri, 6 Dec
 2024 10:57:57 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Fri, 6 Dec 2024 10:57:57 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1714F820248;
	Fri,  6 Dec 2024 10:57:57 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()
Date: Fri, 6 Dec 2024 10:57:57 +0000
Message-ID: <20241206105757.718750-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YmLTGcjI8ycBP1KZuNiLeSkEGi2vY-1p
X-Proofpoint-ORIG-GUID: YmLTGcjI8ycBP1KZuNiLeSkEGi2vY-1p
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Commit 5d7e328e20b3 ("ASoC: cs35l56: Revert support for dual-ownership
of ASP registers")
replaced cs35l56_force_sync_asp1_registers_from_cache() with a dummy
implementation so that the HDA driver would continue to build.

Remove the calls from HDA and remove the stub function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h     | 6 ------
 sound/pci/hda/cs35l56_hda.c | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 94e8185c4795..3dc7a1551ac3 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -271,12 +271,6 @@ struct cs35l56_base {
 	struct gpio_desc *reset_gpio;
 };
 
-/* Temporary to avoid a build break with the HDA driver */
-static inline int cs35l56_force_sync_asp1_registers_from_cache(struct cs35l56_base *cs35l56_base)
-{
-	return 0;
-}
-
 static inline bool cs35l56_is_otp_register(unsigned int reg)
 {
 	return (reg >> 16) == 3;
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index e3ac0e23ae32..7baf3b506eef 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -151,10 +151,6 @@ static int cs35l56_hda_runtime_resume(struct device *dev)
 		}
 	}
 
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -1059,9 +1055,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
-	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
-	if (ret)
-		goto dsp_err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
@@ -1087,7 +1080,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 pm_err:
 	pm_runtime_disable(cs35l56->base.dev);
-dsp_err:
 	cs_dsp_remove(&cs35l56->cs_dsp);
 err:
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
-- 
2.39.5


