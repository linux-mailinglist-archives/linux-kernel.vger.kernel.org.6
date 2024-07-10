Return-Path: <linux-kernel+bounces-247451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464092CF92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A9D1F21B51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB3198A0E;
	Wed, 10 Jul 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l+gbOCs4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C64197A91;
	Wed, 10 Jul 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607816; cv=none; b=OXlkp8t+p0aqVp7kMeF8FfOBWvq3sfwlKCPOzlq96V/P5BHuJYGobG84QPDgsPtTCU6p+scRuzute2RjuMtbFKfca01ouLyEhcNddij9ZGgtDLrm1RfEp5PZmLI1K8OQ1LF9aFt2UH5dtuHbSVfsNJHv7l/23mepgKObVHHpmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607816; c=relaxed/simple;
	bh=mzgC7Iflzc1BlOGQq+JGPHCe1nBZjTuOzsMPE1uQueE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6KvvXwMtqMuJbFnmm7FsO9tt3kjQLoUKoWj/6wm0YGebMlolMIuvXgKLIlYvqOUUU47XZx8r+JdbgWoGDVDeZbz2qVDnbon02+NHQBLfixW6IkiBGTl3LrmcTe5QZiNaWJH9pS/M8TuUoZVCHonU+lXwIhIusPkqQe+66ptMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l+gbOCs4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Gq006601;
	Wed, 10 Jul 2024 05:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=748w9BISOBmfWOXmvCHF0/7TRcQPumgRgnCu07iWs58=; b=
	l+gbOCs4bv0qv/Edmu6cDB+1sNBHgBcJpYXIJ47V4Gz/EyP3MsRNUR5rGIIg2X2i
	W+SuSuGvUSTAR29YZoCjZr3zsx56lA1DkHxj3BR842HH8t/qyBLfPYMFJxEbRzZ4
	WeOgz5mDu0w6ORBci1rC7EPZG4z0lKP97spVDJfO4xpSxwxZCYpQ9AaSXlwTji7X
	F+Pi0WquV6+0t+XhYdd/hFEAMZokG1eczpznmuQrILxhZpeQ6sUQqBdvVcD45i5G
	oVFNYFdv4qXSEibgKbwE4ykFCDh5OcuZ9B0loGF3Kx+wCpf7GC1dHk0/f4VnST/O
	KfMyhQg/tD4j8ldfZMcZJQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8h0p-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:36:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 11:36:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 11:36:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 867E8820259;
	Wed, 10 Jul 2024 10:36:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2 4/4] firmware: cs_dsp: Rename fw_ver to wmfw_ver
Date: Wed, 10 Jul 2024 11:36:40 +0100
Message-ID: <20240710103640.78197-5-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: _iLuBainntKiVg-9qkx4_4uaoQM5j5xA
X-Proofpoint-GUID: _iLuBainntKiVg-9qkx4_4uaoQM5j5xA
X-Proofpoint-Spam-Reason: safe

Rename the confusingly named struct member fw_ver to wmfw_ver. It
contains the wmfw format version of the loaded wmfw file.

This commit also contains an update to wm_adsp for the new name.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V1:
Rebased onto the new commit #3. This removes a single-line change
from this commit. The rest of this commit is the same as V1.
---
 drivers/firmware/cirrus/cs_dsp.c       | 20 ++++++++++----------
 include/linux/firmware/cirrus/cs_dsp.h |  2 +-
 sound/soc/codecs/wm_adsp.c             |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index cce81a3f68f9..a7b56eff086f 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1051,7 +1051,7 @@ static int cs_dsp_create_control(struct cs_dsp *dsp,
 
 	ctl->fw_name = dsp->fw_name;
 	ctl->alg_region = *alg_region;
-	if (subname && dsp->fw_ver >= 2) {
+	if (subname && dsp->wmfw_ver >= 2) {
 		ctl->subname_len = subname_len;
 		ctl->subname = kasprintf(GFP_KERNEL, "%.*s", subname_len, subname);
 		if (!ctl->subname) {
@@ -1178,7 +1178,7 @@ static int cs_dsp_coeff_parse_alg(struct cs_dsp *dsp,
 
 	raw = (const struct wmfw_adsp_alg_data *)region->data;
 
-	switch (dsp->fw_ver) {
+	switch (dsp->wmfw_ver) {
 	case 0:
 	case 1:
 		if (sizeof(*raw) > data_len)
@@ -1255,7 +1255,7 @@ static int cs_dsp_coeff_parse_coeff(struct cs_dsp *dsp,
 	blk->offset = le16_to_cpu(raw->hdr.offset);
 	blk->mem_type = le16_to_cpu(raw->hdr.type);
 
-	switch (dsp->fw_ver) {
+	switch (dsp->wmfw_ver) {
 	case 0:
 	case 1:
 		if (sizeof(*raw) > (data_len - pos))
@@ -1502,7 +1502,7 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		goto out_fw;
 	}
 
-	dsp->fw_ver = header->ver;
+	dsp->wmfw_ver = header->ver;
 
 	if (header->core != dsp->type) {
 		cs_dsp_err(dsp, "%s: invalid core %d != %d\n",
@@ -1782,7 +1782,7 @@ static struct cs_dsp_alg_region *cs_dsp_create_region(struct cs_dsp *dsp,
 
 	list_add_tail(&alg_region->list, &dsp->alg_regions);
 
-	if (dsp->fw_ver > 0)
+	if (dsp->wmfw_ver > 0)
 		cs_dsp_ctl_fixup_base(dsp, alg_region);
 
 	return alg_region;
@@ -1905,7 +1905,7 @@ static int cs_dsp_adsp1_setup_algs(struct cs_dsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (dsp->fw_ver == 0) {
+		if (dsp->wmfw_ver == 0) {
 			if (i + 1 < n_algs) {
 				len = be32_to_cpu(adsp1_alg[i + 1].dm);
 				len -= be32_to_cpu(adsp1_alg[i].dm);
@@ -1927,7 +1927,7 @@ static int cs_dsp_adsp1_setup_algs(struct cs_dsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (dsp->fw_ver == 0) {
+		if (dsp->wmfw_ver == 0) {
 			if (i + 1 < n_algs) {
 				len = be32_to_cpu(adsp1_alg[i + 1].zm);
 				len -= be32_to_cpu(adsp1_alg[i].zm);
@@ -2018,7 +2018,7 @@ static int cs_dsp_adsp2_setup_algs(struct cs_dsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (dsp->fw_ver == 0) {
+		if (dsp->wmfw_ver == 0) {
 			if (i + 1 < n_algs) {
 				len = be32_to_cpu(adsp2_alg[i + 1].xm);
 				len -= be32_to_cpu(adsp2_alg[i].xm);
@@ -2040,7 +2040,7 @@ static int cs_dsp_adsp2_setup_algs(struct cs_dsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (dsp->fw_ver == 0) {
+		if (dsp->wmfw_ver == 0) {
 			if (i + 1 < n_algs) {
 				len = be32_to_cpu(adsp2_alg[i + 1].ym);
 				len -= be32_to_cpu(adsp2_alg[i].ym);
@@ -2062,7 +2062,7 @@ static int cs_dsp_adsp2_setup_algs(struct cs_dsp *dsp)
 			ret = PTR_ERR(alg_region);
 			goto out;
 		}
-		if (dsp->fw_ver == 0) {
+		if (dsp->wmfw_ver == 0) {
 			if (i + 1 < n_algs) {
 				len = be32_to_cpu(adsp2_alg[i + 1].zm);
 				len -= be32_to_cpu(adsp2_alg[i].zm);
diff --git a/include/linux/firmware/cirrus/cs_dsp.h b/include/linux/firmware/cirrus/cs_dsp.h
index 8078dc377948..2e649810169f 100644
--- a/include/linux/firmware/cirrus/cs_dsp.h
+++ b/include/linux/firmware/cirrus/cs_dsp.h
@@ -167,7 +167,7 @@ struct cs_dsp {
 	const struct cs_dsp_region *mem;
 	int num_mems;
 
-	int fw_ver;
+	int wmfw_ver;
 
 	bool booted;
 	bool running;
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 68d2d6444533..9f8549b34e30 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -601,7 +601,7 @@ static int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
 		return -EINVAL;
 	}
 
-	switch (cs_dsp->fw_ver) {
+	switch (cs_dsp->wmfw_ver) {
 	case 0:
 	case 1:
 		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
-- 
2.39.2


