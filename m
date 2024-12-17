Return-Path: <linux-kernel+bounces-449303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20D9F4CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20FD16AA55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27091F4E46;
	Tue, 17 Dec 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PCBT5E8z"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506801F4730;
	Tue, 17 Dec 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443987; cv=none; b=LGJiNdk7YOvFuPshq6SA+p1w+5pedQt+/mvwooK1Nx3L5mC6cae4pIrepvzATJ2N2NQSSivszwppOdgwYNRWX+0u/um4326OF8ej/GHNvm7DSVUYw/kxW00uM3UysZJKTuZIAVNrgaO2h9Ml8TZaD/c2yjIlG9rGRbMfBoImxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443987; c=relaxed/simple;
	bh=7j/FYf7383tCwH6Mf4vV315X9ULfYhI7RbBRJN2rrYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIjRf5UN6eZ5T6vyf63CqiGiV4FWrEKrbvFo6rXaqaW2J1wo2Oj9Cz95NI9+B5FwDJ4L35KcqoKc2z+O3dBqKXgfN1z6Mlb8EMc5L/u5brZUlUYeoByKaqys3RwfvitA863RVkxqIX4c4mABMGxWustR04qWbqbtnwVv36+FMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PCBT5E8z; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Fb0011049;
	Tue, 17 Dec 2024 07:59:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=gvN9p/AizdWPlznoYDKMQvQa9OCYMZHrxyTnfL1ddJY=; b=
	PCBT5E8zqr+s98WUuO2+1vN0NNPMKjr7v7X7I+UjAvtC3heN8hCN2K0FAqmJm5KX
	C/lz4bdHmWzF0r6g0MVwSQgBBY5GzBKny7ZqDa6vHgUl72qeiIkDJQzOVM7ExKeq
	0YEbNoTNE80hMl84mYZIlL4T5aY96kWwKgYAZlnqaI/qv0eBa3iMK9k44v4GKpit
	9E2myWN/hN20ZkqiAQMSMle0GIv/WLyCb0XpnKCOXeI/6Jrg+BFYhXqHX0dIr93N
	e3ooOcCAdkeGlmdvrSrQaEMbnGiCflkWBnEkunfFsEvaoEId4EkDuEQe/OUMMKZF
	ZUoknR5TGOJ92DG/dA8WEw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D166B822543;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/5] soundwire: SDCA: Add additional SDCA address macros
Date: Tue, 17 Dec 2024 13:59:17 +0000
Message-ID: <20241217135921.3572496-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
References: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xdhaCCGisR76JCL2U-HJcLLUidE-ZfDl
X-Proofpoint-ORIG-GUID: xdhaCCGisR76JCL2U-HJcLLUidE-ZfDl
X-Proofpoint-Spam-Reason: safe

Compliment the existing macro to construct an SDCA control address
with macros to extract the constituent parts, and validation of such
an address. Also update the masks for the original macro to use
GENMASK to make mental comparisons with the included comment on the
address format easier.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/soundwire/sdw_registers.h | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 658b10fa5b20..0a5939285583 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -4,6 +4,9 @@
 #ifndef __SDW_REGISTERS_H
 #define __SDW_REGISTERS_H
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
 /*
  * SDW registers as defined by MIPI 1.2 Spec
  */
@@ -329,16 +332,27 @@
  *	2:0		Control Number[2:0]
  */
 
-#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
-						 (((fun) & 0x7) << 22) |	\
-						 (((ent) & 0x40) << 15) |	\
-						 (((ent) & 0x3f) << 7) |	\
-						 (((ctl) & 0x30) << 15) |	\
-						 (((ctl) & 0x0f) << 3) |	\
-						 (((ch) & 0x38) << 12) |	\
-						 ((ch) & 0x07))
+#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |				\
+						 (((fun) & GENMASK(2, 0)) << 22) |	\
+						 (((ent) & BIT(6)) << 15) |		\
+						 (((ent) & GENMASK(5, 0)) << 7) |	\
+						 (((ctl) & GENMASK(5, 4)) << 15) |	\
+						 (((ctl) & GENMASK(3, 0)) << 3) |	\
+						 (((ch) & GENMASK(5, 3)) << 12) |	\
+						 ((ch) & GENMASK(2, 0)))
+
+#define SDW_SDCA_CTL_FUNC(reg) FIELD_GET(GENMASK(24, 22), (reg))
+#define SDW_SDCA_CTL_ENT(reg) ((FIELD_GET(BIT(21), (reg)) << 6) | \
+				FIELD_GET(GENMASK(12, 7), (reg)))
+#define SDW_SDCA_CTL_CSEL(reg) ((FIELD_GET(GENMASK(20, 19), (reg)) << 4) | \
+				 FIELD_GET(GENMASK(6, 3), (reg)))
+#define SDW_SDCA_CTL_CNUM(reg) ((FIELD_GET(GENMASK(17, 15), (reg)) << 3) | \
+				 FIELD_GET(GENMASK(2, 0), (reg)))
 
 #define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
 #define SDW_SDCA_NEXT_CTL(reg)			((reg) | BIT(14))
 
+/* Check the reserved and fixed bits in address */
+#define SDW_SDCA_VALID_CTL(reg) (((reg) & (GENMASK(31, 25) | BIT(18) | BIT(13))) == BIT(30))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.39.5


