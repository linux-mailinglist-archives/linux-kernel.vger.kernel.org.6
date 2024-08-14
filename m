Return-Path: <linux-kernel+bounces-286421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6261951ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8161C2159D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515C1B0111;
	Wed, 14 Aug 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpQ1vpEy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B21B0106
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638119; cv=none; b=nV0ZfZii0OXyUV+/DkFV2KSqh2TX5XpKrtBeCm/mk8TxYK357dkf7nHIzv6bUwEcJVPOwG86TBWQMzxirhtcwlmLx2jvK5jgBDQEeyErZhwIH42WiFBnTbmvwhdyEFu/vBUQfFB+lF0oGCXLxHwo05lMuKgHNz1PN4edbsmkdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638119; c=relaxed/simple;
	bh=oc7pCqgTDJhaq2i36boZtpB4yaoA7PKtJV+APNsDq0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iFaNmGn3VsJ/4OAI8ebl3a71WpIabgQ1wfi7ZyrcF9zH+Zd9N50T2bly8uP8Jkp4kqZntrGJc+KvzG8WcSHLOUXjADOlm/elRV6LD2BOvJEGh7b+svbYgQMNPAX9qNv2L2Sl5vZ4XIfH8l22gUBUztnqqEGnVUKBAPvqarjgVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PpQ1vpEy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47ECKrOt096773;
	Wed, 14 Aug 2024 07:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723638053;
	bh=EqkHqqKAoc8Djpm1ZElzO9BtZimR5uXL+u0mCRMQBbU=;
	h=From:To:CC:Subject:Date;
	b=PpQ1vpEyIo586XmYMoCfXjUUPEYiiYtnvGO889Pf3vinjOp+boBKNGL1n+Ec55jnf
	 6kuWLF5y/RpCIc0wsEdkAIMYy8Fsd1x/NxnVEEumiR0dkXFAM65YwSkYE3Yb2aH/ML
	 SfXR8JYyibjUydB7RtbY2l5WuuzX4J9ETp+xfnhs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47ECKr29030477
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 07:20:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 07:20:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 07:20:53 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47ECKlf7049558;
	Wed, 14 Aug 2024 07:20:48 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13564923607@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <cameron.berkenpas@gmail.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>, <robinchen@ti.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda: tas2563: mark const variables as __maybe_unused
Date: Wed, 14 Aug 2024 20:20:42 +0800
Message-ID: <20240814122043.1731-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Baojun Xu <baojun.xu@ti.com>

An earlier patch changed the DECLARE_TLV_DB_SCALE declaration, but
now there are additional static const variables that cause
the same build warnings:

In file included from sound/pci/hda/tas2781_hda_i2c.c:23:
include/sound/tas2563-tlv.h:21:28: error: 'tas2563_dvc_table' defined but not used [-Werror=unused-const-variable=]
   21 | static const unsigned char tas2563_dvc_table[][4] = {
      |                            ^~~~~~~~~~~~~~~~~                                 ^~~~~~~~~~~~~~~

Mark it as unused as well.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
---
 include/sound/tas2563-tlv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/tas2563-tlv.h b/include/sound/tas2563-tlv.h
index faa3e194f73b..bb269b21f460 100644
--- a/include/sound/tas2563-tlv.h
+++ b/include/sound/tas2563-tlv.h
@@ -18,7 +18,7 @@
 static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
 
 /* pow(10, db/20) * pow(2,30) */
-static const unsigned char tas2563_dvc_table[][4] = {
+static const __maybe_unused unsigned char tas2563_dvc_table[][4] = {
 	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */
 	{ 0X00, 0X00, 0X03, 0XBC }, /* -121.0db */
 	{ 0X00, 0X00, 0X03, 0XF5 }, /* -120.5db */
-- 
2.43.0


