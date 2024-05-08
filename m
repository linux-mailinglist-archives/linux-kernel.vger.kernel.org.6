Return-Path: <linux-kernel+bounces-173041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA28BFAA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A2E285D95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22080BF2;
	Wed,  8 May 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KPtJyn8K"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CE8063C;
	Wed,  8 May 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162901; cv=none; b=XLpfuuMN9NXugaEb1yMifITtXzStIG/YOKuSLIlmcK8rB6onHe4yaEYjF+aW9z0ehcSzO354saj24d1TmM8VQVwMP7zzXdOvVuGvnMX0ZP1SRNrBnjAE4G0bA/gsSbLybDp82fkxbmL9W8WK2LEWSQi7DtNBd1/lotdHBmCMqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162901; c=relaxed/simple;
	bh=TPptcfmWefb6Dwpc7wioI/LAUBpw0qGUXV0LNVjXWEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDf0fM5Q+fBdOW3AMk3JHTr31WJyJzd1NmX7lM2A15krSEerU1mu9PjuC62T5Xz/1CNfFONdUB/05tOEKwrzsRc4V1VPJNAK75Rbk2SY7BwPwyitqqxy2SXu/EADN29beUzOAUxOlMd9mpXzw7WK1nNjZaZW3opx330NOQiYz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KPtJyn8K; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44870QlG029375;
	Wed, 8 May 2024 05:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=N
	J7EXhSoGpVKvEWs1UdcCOfYFkLfSO0USCWaoNX8CHA=; b=KPtJyn8KFqYdCPlvZ
	1SYaEXdrErwCc3x1yxlFtMHcrTAsf8ZD/24p+Mx+uVkmtqmfhXjwcOAsBCMbvcFN
	QtSxF+ovD2auZtD89uYft7HO57N25L4NpogRDpMhV0VmJ1y97Iq25fcifiug2IB6
	IvYiZ0LUX/ljzDK71M10Oc8hGCHtgWK245b/YHT8FjWwuWN9RIDfnFGYp1FWkH8m
	L9hbyqhHslqKhdplza8g2Hww8pGj4b3Gwru0Sazm5+vAUfEeoR4S8H5O+CMxb2kw
	BUkrV5zmj34qM/B1xBYDUZI58/ALEfhf9vKaBxPH1U7dk+Xmfr7ujU1U8WGI0Fys
	+VPTg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xysherp5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 05:08:14 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 11:08:12 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 8 May 2024 11:08:12 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E47BF820244;
	Wed,  8 May 2024 10:08:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH] ALSA: hda: cs35l56: Fix lifetime of cs_dsp instance
Date: Wed, 8 May 2024 11:08:11 +0100
Message-ID: <20240508100811.49514-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ClisYTMZ6HFqvrv3HKI_oxKb6ovp3v7g
X-Proofpoint-ORIG-GUID: ClisYTMZ6HFqvrv3HKI_oxKb6ovp3v7g
X-Proofpoint-Spam-Reason: safe

The cs_dsp instance is initialized in the driver probe() so it
should be freed in the driver remove(). Also fix a missing call
to cs_dsp_remove() in the error path of cs35l56_hda_common_probe().

The call to cs_dsp_remove() was being done in the component unbind
callback cs35l56_hda_unbind(). This meant that if the driver was
unbound and then re-bound it would be using an uninitialized cs_dsp
instance.

It is best to initialize the cs_dsp instance in probe() so that it
can return an error if it fails. The component binding API doesn't
have any error handling so there's no way to handle a failure if
cs_dsp was initialized in the bind.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 558c1f38fe97..11b0570ff56d 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -732,8 +732,6 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
 
-	cs_dsp_remove(&cs35l56->cs_dsp);
-
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
@@ -1035,7 +1033,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
 	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
 	if (ret)
-		goto err;
+		goto dsp_err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
@@ -1061,6 +1059,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 pm_err:
 	pm_runtime_disable(cs35l56->base.dev);
+dsp_err:
+	cs_dsp_remove(&cs35l56->cs_dsp);
 err:
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 
@@ -1078,6 +1078,8 @@ void cs35l56_hda_remove(struct device *dev)
 
 	component_del(cs35l56->base.dev, &cs35l56_hda_comp_ops);
 
+	cs_dsp_remove(&cs35l56->cs_dsp);
+
 	kfree(cs35l56->system_name);
 	pm_runtime_put_noidle(cs35l56->base.dev);
 
-- 
2.39.2


