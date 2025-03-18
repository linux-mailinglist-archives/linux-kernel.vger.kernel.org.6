Return-Path: <linux-kernel+bounces-566616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A80A67A89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148803A98FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D8211A27;
	Tue, 18 Mar 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="guEyKsCM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B307212B0C;
	Tue, 18 Mar 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318112; cv=none; b=TiUYcZHVUp7JVTiQDADxdbV8Kqy01u4Lcwa4D03EFLsm5IFRUwTguWrN1el/vcAhcz8kUOaawAjs7HGc9DQmsfGHTXuXe/D3m6cXUcHvh8hMpSNBHhwSeBmbYCyc5E1pio4bl82yiG471C/tytxR9YTigD631y74t7W3l3JgQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318112; c=relaxed/simple;
	bh=y1QlTKpzzCpYIdv8KPOsbVq7bjI/1Y+E0XoteRNBf30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8JPgJ408uED2KPmJGkXHSy1OwJxWPZMVDLkZmlbc+kRHrTo7/dRF9onMvwcofw5GxL6Ubm64ziSgFLSxibhwlsjKokT69ZPQOLjgwHUVMgpkKALVaR1lsLSu/2ChO7lEZbFRazWW1/v6ck9Fljwmgq9wZiy6/gwk6VVInopyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=guEyKsCM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I1uEKH028771;
	Tue, 18 Mar 2025 12:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Xqmuylb0d3/CW4C+pAv3nW6YEtYD9eyr3GKueEx0+kw=; b=
	guEyKsCMkG6aOW4a0LL76xn0IUN/ALsaPA9pAD4g1EAQoZZow9EuCAs4Ketdsy57
	JHpOC9PHiDhCoELZG7AysTLci3+RL+xmj2zanf6tsz2RELA9CFlhw6PYtLpodshr
	fExQaeG7UcHJtx56tLVtyTLFLgcS1+vc2o2dwZDXIcZ0dQApe9We7SaIILipiDeT
	QM1IvJcq24UmpyaanKmlCq6ahqt7X/cnyFHzYR2asrQ2RG4abVvK3K+DOF4WC14F
	2viLp0GMK7fIllplCTWqhMAsZIiemU4IwDbjrn6yt3NAy6Gg1no5c0kiKb1lW5EM
	lLPPRDx/cbPjtxmx/3SYHw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45d5yh879w-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 12:15:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 17:14:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:14:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B75E1822563;
	Tue, 18 Mar 2025 17:14:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 08/15] ASoC: ops: Remove snd_soc_info_volsw_range()
Date: Tue, 18 Mar 2025 17:14:52 +0000
Message-ID: <20250318171459.3203730-9-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GrhC+l1C c=1 sm=1 tr=0 ts=67d9aa16 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=JNlzxmLKuJj_l6QoI-8A:9
X-Proofpoint-GUID: oN-JiqWMKy0ZZwLPRx1R_vt6ldjY_fdF
X-Proofpoint-ORIG-GUID: oN-JiqWMKy0ZZwLPRx1R_vt6ldjY_fdF
X-Proofpoint-Spam-Reason: safe

The only difference between snd_soc_info_volsw() and
snd_soc_info_volsw_range() is that the later will not force a 2
value control to be of type integer if the name ends in "Volume".

The kernel currently contains no users of snd_soc_info_volsw_range()
that would return a boolean control with this code, so the risk is
quite low and it seems appropriate that it should contain volume
control detection. So remove snd_soc_info_volsw_range() and point its
users at snd_soc_info_volsw().

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/soc.h             | 12 +++++------
 sound/pci/hda/tas2781_hda_i2c.c |  2 +-
 sound/pci/hda/tas2781_hda_spi.c |  2 +-
 sound/soc/soc-ops.c             | 36 +++------------------------------
 sound/soc/soc-topology.c        |  2 +-
 5 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d73fe26de1669..b310f2c599f87 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -65,7 +65,7 @@ struct platform_device;
 	.private_value = SOC_SINGLE_VALUE(reg, shift, 0, max, invert, 0) }
 #define SOC_SINGLE_RANGE(xname, xreg, xshift, xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.info = snd_soc_info_volsw_range, .get = snd_soc_get_volsw_range, \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw_range, \
 	.put = snd_soc_put_volsw_range, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
@@ -90,7 +90,7 @@ struct platform_device;
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
@@ -116,7 +116,7 @@ struct platform_device;
 #define SOC_DOUBLE_R_RANGE(xname, reg_left, reg_right, xshift, xmin, \
 			   xmax, xinvert)		\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
@@ -164,7 +164,7 @@ struct platform_device;
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
@@ -266,7 +266,7 @@ struct platform_device;
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmin, xmax, xinvert, 0) }
 #define SOC_DOUBLE_EXT_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert,\
@@ -569,8 +569,6 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
 int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index be9a90f643ebb..50c5e5f265895 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -45,7 +45,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .rreg = xreg, .shift = xshift, \
diff --git a/sound/pci/hda/tas2781_hda_spi.c b/sound/pci/hda/tas2781_hda_spi.c
index 00676cbb2c8e4..399f2e4c3b62b 100644
--- a/sound/pci/hda/tas2781_hda_spi.c
+++ b/sound/pci/hda/tas2781_hda_spi.c
@@ -52,7 +52,7 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 		SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p = (tlv_array), \
-	.info = snd_soc_info_volsw_range, \
+	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) { \
 		.reg = xreg, .rreg = xreg, \
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 888afdd23f84e..1b52ba12df8df 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -169,12 +169,12 @@ static int soc_mixer_sx_mask(struct soc_mixer_control *mc)
 }
 
 /**
- * snd_soc_info_volsw - single mixer info callback
+ * snd_soc_info_volsw - single mixer info callback with range.
  * @kcontrol: mixer control
  * @uinfo: control element information
  *
- * Callback to provide information about a single mixer control, or a double
- * mixer control that spans 2 registers.
+ * Callback to provide information, with a range, about a single mixer control,
+ * or a double mixer control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -450,36 +450,6 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
 
-/**
- * snd_soc_info_volsw_range - single mixer info callback with range.
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information, within a range, about a single
- * mixer control.
- *
- * returns 0 for success.
- */
-int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
-			     struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int max;
-
-	max = mc->max - mc->min;
-	if (mc->platform_max && mc->platform_max < max)
-		max = mc->platform_max;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_volsw_range);
-
 /**
  * snd_soc_put_volsw_range - single mixer put value callback with range.
  * @kcontrol: mixer control
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 2b86cc3311f76..9cbddfbbc556b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -132,7 +132,7 @@ static const struct snd_soc_tplg_kcontrol_ops io_ops[] = {
 	{SND_SOC_TPLG_CTL_BYTES, snd_soc_bytes_get,
 		snd_soc_bytes_put, snd_soc_bytes_info},
 	{SND_SOC_TPLG_CTL_RANGE, snd_soc_get_volsw_range,
-		snd_soc_put_volsw_range, snd_soc_info_volsw_range},
+		snd_soc_put_volsw_range, snd_soc_info_volsw},
 	{SND_SOC_TPLG_CTL_VOLSW_XR_SX, snd_soc_get_xr_sx,
 		snd_soc_put_xr_sx, snd_soc_info_xr_sx},
 	{SND_SOC_TPLG_CTL_STROBE, snd_soc_get_strobe,
-- 
2.39.5


