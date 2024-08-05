Return-Path: <linux-kernel+bounces-274543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586309479D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D71C2139A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523D1547D2;
	Mon,  5 Aug 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DX7aWo4f"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8414F9CC;
	Mon,  5 Aug 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853799; cv=none; b=ToxNeyUznRQIsVyTUREgMMtYMGpYITH5xNlYzipJngrvAhwR7CHImitIChMYYfNtottjSDMVHNVA7MSrd+n9bmPMK6S9/rFf7mSOe41u2p8UlavxArxkJmBwOdeM0fLz99Ntvwtf/XMsf36iC2LndUQsBsoNowB5VF2+X6HIAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853799; c=relaxed/simple;
	bh=34lKbWc8oLhiLYcDTgHZAE17ty1RjO2OwjzN3VvP6gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKqkrpX6flVXKpf7drJ4t++85b5AOS1EnJfvZoN6OgTEBsKKylAW5bB4SrIbG2Tz4Ltn3sY5occJxnTaN+gYeIY0ASQQLKMVjffKiBzh7pFEcmBJCjm/tfsUmZ6xv/g8x5xnAEsX1FUMxAACrDjSS8fhHtnt6Kvt9CRl0zcaOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DX7aWo4f; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47571BNK029909;
	Mon, 5 Aug 2024 05:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FNw6vv0s5msc0CKCtO00gDMzIXAb4kuva88RL1xu+1U=; b=
	DX7aWo4fVg9IQE1S2ZK44UAUTKOT9swzC40KAPIv/6vKvdS0wy7zhenF6OolrOJc
	2uyHPTeo25HXzlcQbT88R4yMISNcRhPucgXd9O5kdPxDPXo6BLIeUx/A/m3FVkzB
	DCER5WMZvrhFUe6WCKG/Y7iwvPlLy9YT2qFZyptLi0K3Q60jS/fXtO7rguoyzUqZ
	7FVbWmlm5LS+ehraADooND+bEfABLEnIA3iyVWo5+PrZlrEOFwhTWgvrvrTKt6TO
	LlE5Og4lDgInes/O5xudGeA7t2+phJteIALKsegZXZal9njq1wKSR+vd+ztJeE9p
	BlaaGg+nH4nwJxtauB4+TQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40sgyhsmt5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 05:27:41 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 11:27:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 5 Aug 2024 11:27:40 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 69173820241;
	Mon,  5 Aug 2024 10:27:40 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Add control_add callback and export wm_adsp_control_add()
Date: Mon, 5 Aug 2024 10:27:20 +0000
Message-ID: <20240805102721.30102-2-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805102721.30102-1-simont@opensource.cirrus.com>
References: <20240805102721.30102-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: h1A4EbJ4nuKHU7v8clfUjmwlE1SPaB35
X-Proofpoint-GUID: h1A4EbJ4nuKHU7v8clfUjmwlE1SPaB35
X-Proofpoint-Spam-Reason: safe

The callback allows codec drivers to affect how firmware coefficients
are added as controls.

For example a codec driver may selectively add controls by choosing to
call wm_adsp_control_add() based on some filter logic.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 17 ++++++++++++++---
 sound/soc/codecs/wm_adsp.h |  3 +++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9f8549b34e30..e69283195f36 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -583,7 +583,7 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 	kfree(kcontrol);
 }
 
-static int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
+int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
 {
 	struct wm_adsp *dsp = container_of(cs_ctl->dsp, struct wm_adsp, cs_dsp);
 	struct cs_dsp *cs_dsp = &dsp->cs_dsp;
@@ -658,6 +658,17 @@ static int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(wm_adsp_control_add);
+
+static int wm_adsp_control_add_cb(struct cs_dsp_coeff_ctl *cs_ctl)
+{
+	struct wm_adsp *dsp = container_of(cs_ctl->dsp, struct wm_adsp, cs_dsp);
+
+	if (dsp->control_add)
+		return (dsp->control_add)(dsp, cs_ctl);
+	else
+		return wm_adsp_control_add(cs_ctl);
+}
 
 static void wm_adsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
@@ -2072,12 +2083,12 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 EXPORT_SYMBOL_GPL(wm_halo_wdt_expire);
 
 static const struct cs_dsp_client_ops wm_adsp1_client_ops = {
-	.control_add = wm_adsp_control_add,
+	.control_add = wm_adsp_control_add_cb,
 	.control_remove = wm_adsp_control_remove,
 };
 
 static const struct cs_dsp_client_ops wm_adsp2_client_ops = {
-	.control_add = wm_adsp_control_add,
+	.control_add = wm_adsp_control_add_cb,
 	.control_remove = wm_adsp_control_remove,
 	.pre_run = wm_adsp_pre_run,
 	.post_run = wm_adsp_event_post_run,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index e53dfcf1f78f..edc5b02ae765 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -37,6 +37,7 @@ struct wm_adsp {
 	bool wmfw_optional;
 
 	struct work_struct boot_work;
+	int (*control_add)(struct wm_adsp *dsp, struct cs_dsp_coeff_ctl *cs_ctl);
 	int (*pre_run)(struct wm_adsp *dsp);
 
 	bool preloaded;
@@ -132,6 +133,8 @@ int wm_adsp_compr_pointer(struct snd_soc_component *component,
 int wm_adsp_compr_copy(struct snd_soc_component *component,
 		       struct snd_compr_stream *stream,
 		       char __user *buf, size_t count);
+
+int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl);
 int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name,  int type,
 		      unsigned int alg, void *buf, size_t len);
 int wm_adsp_read_ctl(struct wm_adsp *dsp, const char *name,  int type,
-- 
2.43.0


