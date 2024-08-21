Return-Path: <linux-kernel+bounces-295530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0262959C56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE13B274A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2CA192D66;
	Wed, 21 Aug 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gAvlw9BX"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C5155307;
	Wed, 21 Aug 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244568; cv=none; b=Ulw+KOsVsebNne1xHBNaEZzn1iLMwLCseh+S0sR4/NW6VU9RXfE/YO+CNUDmRVm6Qb2j7eFFIvsK8u67WDtSD0cSAWI2vg8lgbRtBDD97i5OcJwSkwJ7I5tzCMfJY+fOpaIELXlCVFHUSVOTRL6RKkvJe1hUVTQLeCnYFxBrM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244568; c=relaxed/simple;
	bh=/g7wB6KJHKrqvckrQ+bphQKwSQ6oJSSLHnGBIiridyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr7ZXPxwd+ZKnw0aOkFuBSp/gegQwlkdStH+PLdUq1ZvclmpyJOMbzoJYnWKLWicfV55ckkCIScL5XWu3LgzbHEOWMFUSvwMggDZjilKUa+SjEaUi52+La+tiZZFGgJn3BihR16fEgRUCXfqj0rMwzWrBLRg3DETuJWVDnxGtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gAvlw9BX; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4wSmw001676;
	Wed, 21 Aug 2024 07:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=tSj3VTqPomVqX2Nm
	MJZqv8H96KwFx707q/hr67byfZk=; b=gAvlw9BX2A5H5ATZ5svobENSGWmL8pAT
	Q6nY7YDmdZn1r94yYLIXWRQr1XwPJGxAE5HA2ChHD002s6zHK7Mko4KVxCED3lHq
	a803kvkbkMzWV2T0bD+7PEHy97guB1Gbp0lqM+MsInmhPQxsAPfh7XpkMiH9aNvK
	VEQFecxPxDFvltez6nlPyj48MhCHsKtGYNea58lRaWKkc9o+HEoRhzmuIMFCtiyf
	x6rRU0/CLaZyd2Oy2dfSnAtPt8sqqSvR04HNgfViBytuLwH5OdgZc24toQauAI97
	sJxs6UyYrK0TpAICp1OEFRkrAYtELefffysjUO/zuF7RzO//AcEYcQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hva7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 07:47:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 13:47:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 21 Aug 2024 13:47:20 +0100
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3AEB8820244;
	Wed, 21 Aug 2024 12:47:20 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Don't use the device index as a calibration index
Date: Wed, 21 Aug 2024 12:47:11 +0000
Message-ID: <20240821124711.44325-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XpTfHEsreoR-UM6zSziS3wbMqT7atTem
X-Proofpoint-ORIG-GUID: XpTfHEsreoR-UM6zSziS3wbMqT7atTem
X-Proofpoint-Spam-Reason: safe

The HDA driver cannot assume that the order that the devices are
specified in the cirrus,dev-index matches the order of calibration
entries.

Only a calibration entry with a matching silicon id will be used.

Fixes: cfa43aaa7948 ("ALSA: hda: cs35l56: Apply amp calibration from EFI data")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index a9dfd62637cf..e3ac0e23ae32 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1003,7 +1003,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 		goto err;
 	}
 
-	cs35l56->base.cal_index = cs35l56->index;
+	cs35l56->base.cal_index = -1;
 
 	cs35l56_init_cs_dsp(&cs35l56->base, &cs35l56->cs_dsp);
 	cs35l56->cs_dsp.client_ops = &cs35l56_hda_client_ops;
-- 
2.43.0


