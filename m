Return-Path: <linux-kernel+bounces-196734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8249E8D60B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFF1286E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA04157480;
	Fri, 31 May 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fYSedm1/"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F24745E7;
	Fri, 31 May 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154850; cv=none; b=mNiXF3ug3NZ/Wetvfvaw8Q0X/9EgXlcZdaoP/ZAXckZ044ZREQvhHa6/36BcEy7AEtJqijjWdYLRfsZBJYegIZYKJzBCVtna72OMbd5Cazm3gY96T+XIv8azdD5ZeL/salDp8N+YlFFK4h/OXqS+XyCF2RM45BXWpbNU1dNyYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154850; c=relaxed/simple;
	bh=ir4kvqus4+b9A6TsrDobyBFHj6/X6jwrEM/lRyMJYGE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=edu7GlaqKdblKZ8MyEWb6Qrzderp4O/ld5421Pn0eqJLvFCllFYWmvkwXFjgC9YbKIblCOjYBMVRHWG/+20WWCbomI8ejpw2oh+3l0aZh2u4PZXNfIzLmt2WDAURCxnZoEmOAInv81miXlukt8x8But42OLTxxcXXENSyZAXntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fYSedm1/; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V6vAHn004232;
	Fri, 31 May 2024 06:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=uqUvYOPYn4wZFfXt
	U6r/PgcMGfsmSJF3lS2+gb15emQ=; b=fYSedm1/p2UvZjvMBhJ6DMJb07bq0Ork
	iTixbRh21i5VmEyYK5GzLhMwrx+caF+pbf7BO2YMZUb5jx1SNMMvUnvAJfnjEt1s
	d2cvvTiZ+I4C8KG01CSdkHfPMC0BRf9OJPHRKogNQTDcDs/Hpx1enA1nVZGoE6TQ
	qaO5K7/H0uIi94UYzsPIw6wrUzbLjXsf96j10hm7I3k+EJxkitZjV2ZPYTTH/5qB
	9dUz54SMG4SuKR9BIOi5HRyd/+0joIQELHwblsny2rk+eHEfMATn5Ea8uWON4oJ2
	EmDGCgIX89lZtW0NeE+KpINf2Cq21nbFDLzjE+ERHa0tiZhuUJH/Rg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ybdcwwqa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 06:27:21 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 12:27:19 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 12:27:19 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C5B9B820249;
	Fri, 31 May 2024 11:27:18 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Fix lifecycle of codec pointer
Date: Fri, 31 May 2024 12:27:16 +0100
Message-ID: <20240531112716.25323-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8-xrWWee19RIF5fSr4rUExGKLCpecmYY
X-Proofpoint-ORIG-GUID: 8-xrWWee19RIF5fSr4rUExGKLCpecmYY
X-Proofpoint-Spam-Reason: safe

The codec should be cleared when the amp driver is unbound and when
resuming it should be tested to prevent loading firmware into the device
and ALSA in a partially configured system state.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 11b0570ff56d..0923e2589f5f 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -735,6 +735,8 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
+	cs35l56->codec = NULL;
+
 	dev_dbg(cs35l56->base.dev, "Unbound\n");
 }
 
@@ -840,6 +842,9 @@ static int cs35l56_hda_system_resume(struct device *dev)
 
 	cs35l56->suspended = false;
 
+	if (!cs35l56->codec)
+		return 0;
+
 	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret > 0) {
-- 
2.34.1


