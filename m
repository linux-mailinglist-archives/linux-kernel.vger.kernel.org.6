Return-Path: <linux-kernel+bounces-246092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D120692BD7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7901C22768
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2A19D882;
	Tue,  9 Jul 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dZ7IMZhu"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3019CCFA;
	Tue,  9 Jul 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536740; cv=none; b=tDesweTkVuJHeIzSIWGI5kD80V1fzA1QKqYUvf42zdseCZ77WTK3wIEpxV4XYB9K6L1Am13Jz5dQRhJiDz6gsru4hyO5n/8QWq7RZ8BH2mI+KzgFvPn1SXl/UJTLsSB0L7wsigG2c6cCudJe+QXkBZD9u026teLqiIi/iJLVXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536740; c=relaxed/simple;
	bh=tmoNt8lach5F6zb9655OIEWPDXlhgi1uPzdrFNMZQ30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lg/c6vg38GvYWdzl2zsdCOsVlcXdCpYMOIsbfTU/NKXu7COi2BdZBRXrXllZ8iM4S80UcW5kOkZmfRQS+kvDC27ov0IbD39+/PlirovxgDxJcmVWsUQqVhyh148selI0rjGvzYCe7NDAnnq/6T/9SP52+7kEfS33tOB5dnMK6ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dZ7IMZhu; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699TeIb016166;
	Tue, 9 Jul 2024 09:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=b0qMF/w47wG0eNUeosr0AcPTRrVfH6R7v97UI4wqM2o=; b=
	dZ7IMZhuwY15O2DvSnvEzW9QA2xhsXCpOSHwR+YlZPylnVKBZNmzpGQubqVTMxJz
	IGIgQM/LgtZc1BXlTSy89iuKMVsgTjXdZZQ8Sr985cBkoT4V7XJQuVxxwIfByEvV
	AOrPwbze36+soaoE5rC8JD2/eYUyr0Tp6dMYSdrvHWEYYIe5cvzNPkL0lJVvJl+u
	BkDz8CSqECFrDTtwEQ6AvQJlgO5COr6oAIJeyn0dTzIDcu1Ypo/PB1cck3hlHfRW
	41Anv2TvwTrFCBdt/pGdk98Gok1uOGCacZUEr4T55l0jBl19Ysw6m3TGFUe84xkZ
	wsDu4O4yLXbdKcg8Non2RQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axtqje-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:52:00 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 15:51:57 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 0B9C6820257;
	Tue,  9 Jul 2024 14:51:57 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 2/4] firmware: cs_dsp: Make wmfw and bin filename arguments const char *
Date: Tue, 9 Jul 2024 15:51:54 +0100
Message-ID: <20240709145156.268074-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709145156.268074-1-rf@opensource.cirrus.com>
References: <20240709145156.268074-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: icj7LZgcHbbRVzl8W7yuhZETv5xS6Vdl
X-Proofpoint-GUID: icj7LZgcHbbRVzl8W7yuhZETv5xS6Vdl
X-Proofpoint-Spam-Reason: safe

The wmfw_filename and bin_filename strings passed into cs_dsp_power_up()
and cs_dsp_adsp1_power_up() should be const char *.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
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


