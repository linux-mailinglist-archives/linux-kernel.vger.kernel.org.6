Return-Path: <linux-kernel+bounces-247448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967792CFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A5B2408B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A299197A83;
	Wed, 10 Jul 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MD1nD/08"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB397190059;
	Wed, 10 Jul 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607813; cv=none; b=YR/mLBBwcb0nIlzcCDth7ajylEVLpEE/XXA1I3DyPx6Hwv7pLaXWLLZefNHwYtQykdBaAcM+5M4cmrjjxLD21GxAbFyBjgSMA4rfzxkbvw6iriSF1OKU/JDl4oXHLZwThSRiDZf4zLaZOZA7mWS4zWZzKflDx3mIO/yGTa80UWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607813; c=relaxed/simple;
	bh=QHGT4+ppYO45q0achce4/jGU1ih4Zv0+l/JdKKksWI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkCaiW2oQ+znW60GIztl2Vt9ud8biQ6Z2GtAdW4nqsqjwOJoyjY/Qo5Pap52xJP2qd7hSRsrGM7xOjrPW8Ni/UuDmLPeQakBQhiipF12dWk/95PDFibRy/57NPK6m+/2uGLHiJxqZwsr6n5XZqBOfL1N3fUjMmVoRT90wGieI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MD1nD/08; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Go006601;
	Wed, 10 Jul 2024 05:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RbnIyx9NYEEds9ispHpQLOcYGwAry0EZT8xR+scgMwU=; b=
	MD1nD/08tqerfYbVwCwO/cinbrToQnyCcMGKaJinpriJHgd7OCO+GwGnVKr55Sq7
	QG7eAUXNJPqjgSN3AlWpL6dsSouZoRHfK4cd6lMicW4cKO9bvExHmXXaunwdH5Mr
	Y3ydNznlOhQvih5fUPgwKLMfzL+tZ/d7iuEhGrMkkd0NpFBf5RIWvGZRB6vrVSim
	OU5xkYHmWGk1TMo2cm81pltdMb1yBVgZT323XGoeE6lDxRgYbYHRDEJzvtb9bewa
	pjfrMXxpzX0aYYR5qKGSirvyxOGpJB7v37sSTaqvOr9qOROSYmfGzw2vTNnJbCD1
	RGHs6KODtar572dYx45lwg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8h0p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:36:45 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 11:36:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 11:36:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6CCB6820257;
	Wed, 10 Jul 2024 10:36:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2 2/4] firmware: cs_dsp: Make wmfw and bin filename arguments const char *
Date: Wed, 10 Jul 2024 11:36:38 +0100
Message-ID: <20240710103640.78197-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uECqc4ON5OqZnS7C_BoMiIgSE4KE2b-J
X-Proofpoint-GUID: uECqc4ON5OqZnS7C_BoMiIgSE4KE2b-J
X-Proofpoint-Spam-Reason: safe

The wmfw_filename and bin_filename strings passed into cs_dsp_power_up()
and cs_dsp_adsp1_power_up() should be const char *.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1
---
 drivers/firmware/cirrus/cs_dsp.c       | 8 ++++----
 include/linux/firmware/cirrus/cs_dsp.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index bf25107a98ee..1bc2e0b6d40b 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -2413,8 +2413,8 @@ EXPORT_SYMBOL_NS_GPL(cs_dsp_adsp1_init, FW_CS_DSP);
  * Return: Zero for success, a negative number on error.
  */
 int cs_dsp_adsp1_power_up(struct cs_dsp *dsp,
-			  const struct firmware *wmfw_firmware, char *wmfw_filename,
-			  const struct firmware *coeff_firmware, char *coeff_filename,
+			  const struct firmware *wmfw_firmware, const char *wmfw_filename,
+			  const struct firmware *coeff_firmware, const char *coeff_filename,
 			  const char *fw_name)
 {
 	unsigned int val;
@@ -2707,8 +2707,8 @@ static void cs_dsp_halo_stop_watchdog(struct cs_dsp *dsp)
  * Return: Zero for success, a negative number on error.
  */
 int cs_dsp_power_up(struct cs_dsp *dsp,
-		    const struct firmware *wmfw_firmware, char *wmfw_filename,
-		    const struct firmware *coeff_firmware, char *coeff_filename,
+		    const struct firmware *wmfw_firmware, const char *wmfw_filename,
+		    const struct firmware *coeff_firmware, const char *coeff_filename,
 		    const char *fw_name)
 {
 	int ret;
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 82687e07a7c2..8078dc377948 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -213,13 +213,13 @@ int cs_dsp_adsp2_init(struct cs_dsp *dsp);
 int cs_dsp_halo_init(struct cs_dsp *dsp);
 
 int cs_dsp_adsp1_power_up(struct cs_dsp *dsp,
-			  const struct firmware *wmfw_firmware, char *wmfw_filename,
-			  const struct firmware *coeff_firmware, char *coeff_filename,
+			  const struct firmware *wmfw_firmware, const char *wmfw_filename,
+			  const struct firmware *coeff_firmware, const char *coeff_filename,
 			  const char *fw_name);
 void cs_dsp_adsp1_power_down(struct cs_dsp *dsp);
 int cs_dsp_power_up(struct cs_dsp *dsp,
-		    const struct firmware *wmfw_firmware, char *wmfw_filename,
-		    const struct firmware *coeff_firmware, char *coeff_filename,
+		    const struct firmware *wmfw_firmware, const char *wmfw_filename,
+		    const struct firmware *coeff_firmware, const char *coeff_filename,
 		    const char *fw_name);
 void cs_dsp_power_down(struct cs_dsp *dsp);
 int cs_dsp_run(struct cs_dsp *dsp);
-- 
2.39.2


