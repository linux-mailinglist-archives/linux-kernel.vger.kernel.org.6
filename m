Return-Path: <linux-kernel+bounces-558199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27152A5E2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2037ADE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD925A348;
	Wed, 12 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XagLCaY0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD188253341;
	Wed, 12 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800158; cv=none; b=lpVKWQBKYbHZBNp8nyPx68/yAo03W4zayOtPYNvUXBIfeMqt1Q63BUwMPLJZ1FDhtjHizvwWk5iE6xugKSZqySAXURpyNzWjwD7gXCQ8iZZvOtg4ikmjbivx/ZTOoGmdri6DnQ8doP5fXTxTuyYjTRRr12kIjWbSrqEePd3GwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800158; c=relaxed/simple;
	bh=5Oo01rmDlAoT6mOFYkbLjljTCcDTWUotBuVKfslAj+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5AHlB+9f9xMQl8piJpkKkOE+xqBdm9mu7hvFQ3/f4YqL/MjkrWpgY+F6uWbz2IBPPdTuus8lW3MvERP8fMcaLNxwVwged2R01EI3rNwsHayzaKi2SFrHK97u7sSuDNoBTEHdij1aLWtRqdjgY2FLA1rdjSrFKyT3TsMHnu2FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XagLCaY0; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6FZHO029588;
	Wed, 12 Mar 2025 12:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ZtZXJUeWzPvxa5dDLoTqFf9k3G3N9DEsgRtGy4x75XI=; b=
	XagLCaY0MQ4klDZ+1ByHgY9ccUeQHu1Wlug+VFbi1I6zoHctPpaNy1Uj0k9WnLW3
	uM/sKi13bbSeEg0NeWN3zzvtMjV4c1w9De8T+SnlIS+tZW1SwgCQWRIYikFFZnxM
	DZIbboqhjxX4u54hObXanRcz67xhsc4Y4Uu/dGU2BW+Hpb9gP48OeZ3LVqFN4yRj
	FQ30nULTCCgD9ErUGumQ3qRGpF8ASsKfPdKoisdHencao4zxy1kg7tDhlGeyCx0s
	HmXVOL9/R9TkbafYT9+BSgQ1Jo9vuAhaLfSVe+6KK8AkRQ/Ra7lG96u0GbWMzJlj
	3o65QxZDGR8cPTXH0BZ+0A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 41F9682255E;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/6] ASoC: SDCA: Allow naming of imp def controls
Date: Wed, 12 Mar 2025 17:22:02 +0000
Message-ID: <20250312172205.4152686-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
References: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oUIwU0fg_-Hwp82AlnexESmrBXCRJep_
X-Proofpoint-GUID: oUIwU0fg_-Hwp82AlnexESmrBXCRJep_
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2bf cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=wLSajK7kGcz6UTwv5sUA:9
X-Proofpoint-Spam-Reason: safe

Implementation defined controls will not be present in the large list of
known controls for SDCA. The driver should not return an error for these,
because it is perfectly legal to have implementation defined controls.
Update the handling to instead generate a generic name.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sdca/sdca_functions.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 4ee98d8fe89ed..1e36dd20d7abf 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -241,7 +241,8 @@ static int find_sdca_init_table(struct device *dev,
 	return 0;
 }
 
-static const char *find_sdca_control_label(const struct sdca_entity *entity,
+static const char *find_sdca_control_label(struct device *dev,
+					   const struct sdca_entity *entity,
 					   const struct sdca_control *control)
 {
 	switch (SDCA_CTL_TYPE(entity->type, control->sel)) {
@@ -530,7 +531,7 @@ static const char *find_sdca_control_label(const struct sdca_entity *entity,
 	case SDCA_CTL_TYPE_S(ENTITY_0, DEVICE_SDCA_VERSION):
 		return SDCA_CTL_DEVICE_SDCA_VERSION_NAME;
 	default:
-		return NULL;
+		return devm_kasprintf(dev, GFP_KERNEL, "Imp-Def %#x", control->sel);
 	}
 }
 
@@ -739,12 +740,9 @@ static int find_sdca_entity_control(struct device *dev, struct sdca_entity *enti
 	if (!ret)
 		control->interrupt_position = tmp;
 
-	control->label = find_sdca_control_label(entity, control);
-	if (!control->label) {
-		dev_err(dev, "%s: control %#x: name not found\n",
-			entity->label, control->sel);
-		return -EINVAL;
-	}
+	control->label = find_sdca_control_label(dev, entity, control);
+	if (!control->label)
+		return -ENOMEM;
 
 	control->nbits = find_sdca_control_bits(entity, control);
 
-- 
2.39.5


