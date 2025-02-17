Return-Path: <linux-kernel+bounces-517758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 411BBA3854B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AD6188E22C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D221D3F4;
	Mon, 17 Feb 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YxrmzJhO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046321CA07;
	Mon, 17 Feb 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800938; cv=none; b=KrmGyUHdn+ssbvxzOwkeoDvfSuP5GJbxD3i/7QoA+EOjPiTqQXk0A9xE8qjxK2lYjYNjQ4P6fXJgYmqXGsvOD8v690Fc0bcuIA9i+3UeVmDgoEVh8xVk+3RaXVYkkyHJ2TvYn0SnZnCSLka+O1M1ohbtg9L9AIlC0fHLsj2/Gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800938; c=relaxed/simple;
	bh=9vgloSa3Vd9OdC6UhcZ4UgFC32u1Ukmdre3LQ+St0uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADuRZRL5bBT17aZkRWwrDYqdDrutMFntJG2wfbfEkDjW4l4PveTqfxWQdOn7dI/zMVQnTjMGBd2TFA+hxa/QLdK6olmSw+YSKUmzujrDnRKHNRgQTGj++S+8qwG5+tJvDaYx3hosBNOHYN8oyipwbqoKy+wR4WxD5tAauALKUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YxrmzJhO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HCcKM1008975;
	Mon, 17 Feb 2025 08:02:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=6puuLeKxWyXy3jwD4IO5Rzl47Ex+h1cy6nZQ2HKYBhg=; b=
	YxrmzJhOWh3qD4dA6TZe8KJRCIyirDWWtUIaGzHXKvGTnGxWffhrf6RMByo0t9TT
	5yT3bPexmRJpH/E+/SbM+dWkYYJxnspRGyAt25sdRnpv3mE14e8P67jBI6iolJJs
	8Xb5dh1/+CjipSioL8crlZtlHh9yPpxX2X2Dnp8rXEavk/i1GdytunpipiPWA6y9
	bt54lHaUrxnVpuEYuTBakuVbvbUqU2TOMPuPdoclt7S0HHmNqgySDGvJ1AP+Mo6R
	ddGwMSgL7da7OlQI2KrZ41Qal8+V7Ur1V67gE8dogcWB5JJMoOj3IdNr20QPyUp0
	4yNXaeyvcfmsUBEQpB2yBg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18x31-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 08:02:01 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 14:01:59 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 14:01:59 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C3671822563;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 1/4] regcache: Add support for sorting defaults arrays
Date: Mon, 17 Feb 2025 14:01:56 +0000
Message-ID: <20250217140159.2288784-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
References: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2E_Q-FXb_KihsFeQdGR262NJv8rviXPh
X-Proofpoint-ORIG-GUID: 2E_Q-FXb_KihsFeQdGR262NJv8rviXPh
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b3415a cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=ARAoAZWLIMcJkYGXL3wA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

The defaults array in regcache must be sorted into ascending register
address order, because binary search is used to locate values in
the array. Add a helper to sort the register defaults array which
can be useful for systems that dynamically create a defaults array
based on external information.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regcache.c | 31 +++++++++++++++++++++++++++++++
 include/linux/regmap.h         |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index b1f8508c3966..f7fcf2de1301 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -21,6 +21,37 @@ static const struct regcache_ops *cache_types[] = {
 	&regcache_flat_ops,
 };
 
+static int regcache_defaults_cmp(const void *a, const void *b)
+{
+	const struct reg_default *x = a;
+	const struct reg_default *y = b;
+
+	if (x->reg > y->reg)
+		return 1;
+	else if (x->reg < y->reg)
+		return -1;
+	else
+		return 0;
+}
+
+static void regcache_defaults_swap(void *a, void *b, int size)
+{
+	struct reg_default *x = a;
+	struct reg_default *y = b;
+	struct reg_default tmp;
+
+	tmp = *x;
+	*x = *y;
+	*y = tmp;
+}
+
+void regcache_sort_defaults(struct reg_default *defaults, unsigned int ndefaults)
+{
+	sort(defaults, ndefaults, sizeof(*defaults),
+	     regcache_defaults_cmp, regcache_defaults_swap);
+}
+EXPORT_SYMBOL_GPL(regcache_sort_defaults);
+
 static int regcache_hw_init(struct regmap *map)
 {
 	int i, j;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 3a96d068915f..d17c5ea3d55d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1352,6 +1352,7 @@ bool regmap_can_raw_write(struct regmap *map);
 size_t regmap_get_raw_read_max(struct regmap *map);
 size_t regmap_get_raw_write_max(struct regmap *map);
 
+void regcache_sort_defaults(struct reg_default *defaults, unsigned int ndefaults);
 int regcache_sync(struct regmap *map);
 int regcache_sync_region(struct regmap *map, unsigned int min,
 			 unsigned int max);
@@ -2043,6 +2044,12 @@ static inline bool regmap_might_sleep(struct regmap *map)
 	return true;
 }
 
+static inline void regcache_sort_defaults(struct reg_default *defaults,
+					  unsigned int ndefaults)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+}
+
 static inline int regcache_sync(struct regmap *map)
 {
 	WARN_ONCE(1, "regmap API is disabled");
-- 
2.39.5


