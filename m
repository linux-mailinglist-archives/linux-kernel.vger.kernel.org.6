Return-Path: <linux-kernel+bounces-568523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AF3A696D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611D87ACECE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11B9205E36;
	Wed, 19 Mar 2025 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BJpsgfAN"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F748F6D;
	Wed, 19 Mar 2025 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406692; cv=none; b=VT1tvGXlmXc993vSoxmqYQJuEyWtJGfdXyShEHi1fyb5YErFXPP2ACojFCnRK4mH/B4EtmXhYs5Hhlzr/5B9R7rAE393IZXChhBVMZrm2pgoLE6GH5oITQ/M8PEDJkywLjoPFOxBLO6zSbb3qqhiRkciojLyl9uarhdgDUgrucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406692; c=relaxed/simple;
	bh=ACVIQ9OQrhXJ9gk8PvtoJNZU4Jlu/TifdE5dGysrEd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwXLp6Vo/+/NmF5Sgn1eVnLYYEOWfK1xjmwIcZM2hA4AmeA59puSWB2QbaooCfG965+1TAHIiZtE8/7gCvaihGwkChWwW1ig97OskCUU1o6hhdoQPp0dY6VuEzTvZEF1O8ctPj9NCj7y1KMH3FRKxKVTUeC+85VSM+SoLZuQ7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BJpsgfAN; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J7c9RL023977;
	Wed, 19 Mar 2025 12:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=xmoE+I2YZbGqgTvBcKW8CuwRTdBOPp4ZaILx/ca+7xw=; b=
	BJpsgfANwhCz7n+a/3rlW3iRcZyg0mIFUKJTwZyEz1lsme1W095LowIhwd1qsuSG
	kiM5lx+nlxNnJH8Ulq2+MGM5F9+fASTMYSVnH/UAZM9CqjLLWngqXoU15vHi8Rz8
	RwxlDpnxASCeCvKm+pl07Yfh1f23am0UIG5/zSpjtXNBOW14DDr1CmLu+/XQOZ8M
	XQVWaJZAJSsd1l8h6OawM5CG6sMoQNRwDDLIy6JNWFJ6pzl6VT2qZgDtNDap0YC+
	Hazffe3+gB/pNhDO+ZNdv2Nj8eAyFL/OZX7FxkDqSN8j6z9i2v3RsklwIRmM27oV
	cxxKVIvHDU3pjo4phZECFg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45dc0mtgjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:51:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 17:51:24 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 17:51:24 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2277682255E;
	Wed, 19 Mar 2025 17:51:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/3] ASoC: ops: Apply platform_max after deciding control type
Date: Wed, 19 Mar 2025 17:51:23 +0000
Message-ID: <20250319175123.3835849-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
References: <20250319175123.3835849-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: FMiaSyFS-xzObxSsxtMKG09c9pLn5x04
X-Proofpoint-ORIG-GUID: FMiaSyFS-xzObxSsxtMKG09c9pLn5x04
X-Authority-Analysis: v=2.4 cv=XY+JzJ55 c=1 sm=1 tr=0 ts=67db041e cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=NfW0dt3s_OP-V94RNuMA:9
X-Proofpoint-Spam-Reason: safe

It doesn't really make sense for the type of a control to change based
on the platform_max field. platform_max allows a specific system to
limit values of a control for safety but it seems reasonable the
control type should remain the same between different systems, even
if it is restricted down to just two values. Move the application of
platform_max to after control type determination in soc_info_volsw().

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v1.

 sound/soc/soc-ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 3ac5b3a62c812..8d4dd11c9aef1 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -172,9 +172,6 @@ static int soc_info_volsw(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_info *uinfo,
 			  struct soc_mixer_control *mc, int max)
 {
-	if (mc->platform_max && mc->platform_max < max)
-		max = mc->platform_max;
-
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
 	if (max == 1) {
@@ -185,6 +182,9 @@ static int soc_info_volsw(struct snd_kcontrol *kcontrol,
 			uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	}
 
+	if (mc->platform_max && mc->platform_max < max)
+		max = mc->platform_max;
+
 	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = max;
-- 
2.39.5


