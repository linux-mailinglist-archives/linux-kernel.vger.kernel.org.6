Return-Path: <linux-kernel+bounces-217871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D389C90B56D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D8281F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C436613C9C4;
	Mon, 17 Jun 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c1wQm9Zg"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06613C81B;
	Mon, 17 Jun 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639003; cv=none; b=aSWEY5D7QehlBOn9k9nqfzn/UATEMvAgMCNWB5BQCygqu7w6RY5iAi6tkcb6/Q6Vng3TaDUMTKIsiLOaoVPFvQaPqAvm7HnNAIBmiGhqEfraOvWTF2QkeM9a4J66wlouTjx1ZLua7tpVBvWXz0cSmzwHNYJupeQKVgxFQbjRekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639003; c=relaxed/simple;
	bh=tyHcTilPJBf1ZtldFADW7DKJj5yP1ToJmKxXcIXtfGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+gzDsbp69c8Vo1Tk2TIBqmxnAXVUlEO0d+BBgGz0G2q4TBxK0wtGPNq8i2wIGb8LOEITlI9oBy8dna+gwMt8b9TQYUQIUkOQKL/M6e9VkpSQLYAv1322xfJ26c1TvYsi+HI56TtknFq10ts1oZHYIWRVRvNH5mMDiTNBWG6jYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c1wQm9Zg; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HFYCxr023861;
	Mon, 17 Jun 2024 10:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=+0kLEE8LRxxWUa9qJB+cByKX7sWs5TP2HYGpu4CAWoU=; b=
	c1wQm9Zg6EjxE9qqAvFNsIgn5Km+kTZXGXdbxMFEFQdCbG0vlqUDrAHmcFGGAXxb
	PvvHojW9v5myiud4UXgdMUoqvjunzxlIlYbY0NR1JIuW9Vl3ECpxwuHjjiD0nOGj
	v0c5w9aZzgkdkexVYYFwaPPW1znUKDV1ud5Sd9mw1wjSdFHBnoycl+p7x2YHkCQG
	e0eyWS1Rkea3uEQendG+JXrJw9YTqIDYYOmT9jg8uMcEgjZ7SiZ628xCMykPGOnL
	xxBxI7/Ltl5GBVYqvPdCr+/pcAbibQNEcYKO4fGRSfK7RnpNzDhJ44Pz9Ek8NEQv
	xRf8xIfC5jN7xhmIcJ0v2g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjt0f9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 10:43:12 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 16:42:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 16:42:56 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 76BCF820248;
	Mon, 17 Jun 2024 15:42:56 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 4/4] ALSA: hda: hda_component: Protect shared data with a mutex
Date: Mon, 17 Jun 2024 16:41:05 +0100
Message-ID: <20240617154105.108635-5-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617154105.108635-1-simont@opensource.cirrus.com>
References: <20240617154105.108635-1-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: K9_oMiZr5njMk6d17qAkcmiyUtnTHuVe
X-Proofpoint-ORIG-GUID: K9_oMiZr5njMk6d17qAkcmiyUtnTHuVe
X-Proofpoint-Spam-Reason: safe

The hda_component contains information shared from the amp drivers to
the codec that can be altered (for example as the driver unloads). Guard
the update and use of these to prevent use of stale data.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/hda_component.c | 13 ++++++++++++-
 sound/pci/hda/hda_component.h |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index 1a9950b76866..7b19cb38b4e0 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -21,11 +21,13 @@ void hda_component_acpi_device_notify(struct hda_component_parent *parent,
 	struct hda_component *comp;
 	int i;
 
+	mutex_lock(&parent->mutex);
 	for (i = 0; i < ARRAY_SIZE(parent->comps); i++) {
 		comp = hda_component_from_index(parent, i);
 		if (comp->dev && comp->acpi_notify)
 			comp->acpi_notify(acpi_device_handle(comp->adev), event, comp->dev);
 	}
+	mutex_unlock(&parent->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(hda_component_acpi_device_notify, SND_HDA_SCODEC_COMPONENT);
 
@@ -87,6 +89,7 @@ void hda_component_manager_playback_hook(struct hda_component_parent *parent, in
 	struct hda_component *comp;
 	int i;
 
+	mutex_lock(&parent->mutex);
 	for (i = 0; i < ARRAY_SIZE(parent->comps); i++) {
 		comp = hda_component_from_index(parent, i);
 		if (comp->dev && comp->pre_playback_hook)
@@ -102,6 +105,7 @@ void hda_component_manager_playback_hook(struct hda_component_parent *parent, in
 		if (comp->dev && comp->post_playback_hook)
 			comp->post_playback_hook(comp->dev, action);
 	}
+	mutex_unlock(&parent->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(hda_component_manager_playback_hook, SND_HDA_SCODEC_COMPONENT);
 
@@ -134,11 +138,18 @@ static int hda_comp_match_dev_name(struct device *dev, void *data)
 int hda_component_manager_bind(struct hda_codec *cdc,
 			       struct hda_component_parent *parent)
 {
+	int ret;
+
 	/* Init shared and component specific data */
 	memset(parent, 0, sizeof(*parent));
+	mutex_init(&parent->mutex);
 	parent->codec = cdc;
 
-	return component_bind_all(hda_codec_dev(cdc), parent);
+	mutex_lock(&parent->mutex);
+	ret = component_bind_all(hda_codec_dev(cdc), parent);
+	mutex_unlock(&parent->mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(hda_component_manager_bind, SND_HDA_SCODEC_COMPONENT);
 
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index dd4dabeae9ee..9f786608144c 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -11,6 +11,7 @@
 
 #include <linux/acpi.h>
 #include <linux/component.h>
+#include <linux/mutex.h>
 #include <sound/hda_codec.h>
 
 #define HDA_MAX_COMPONENTS	4
@@ -28,6 +29,7 @@ struct hda_component {
 };
 
 struct hda_component_parent {
+	struct mutex mutex;
 	struct hda_codec *codec;
 	struct hda_component comps[HDA_MAX_COMPONENTS];
 };
@@ -93,7 +95,9 @@ static inline struct hda_component *hda_component_from_index(struct hda_componen
 static inline void hda_component_manager_unbind(struct hda_codec *cdc,
 						struct hda_component_parent *parent)
 {
+	mutex_lock(&parent->mutex);
 	component_unbind_all(hda_codec_dev(cdc), parent);
+	mutex_unlock(&parent->mutex);
 }
 
 #endif /* ifndef __HDA_COMPONENT_H__ */
-- 
2.34.1


