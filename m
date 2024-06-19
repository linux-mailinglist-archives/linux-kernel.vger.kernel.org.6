Return-Path: <linux-kernel+bounces-221452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925890F3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FE81F21A80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC5152181;
	Wed, 19 Jun 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Oib80RlP"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E41848;
	Wed, 19 Jun 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813776; cv=none; b=VPmpina1SFjBanPDURi1BCd4XZAc/q7quZdBmcMIfXSPfX0kiAyX65r428k3kv+AKpi00KEFSamq0UKQr+y9dkOUcklU6Gd2oQc2ROObRvQvwwI8nQMorLQwSaEvoUXMVFCZK9NHh+FW3vXwNyMyaDzkI3ghsKruPOZLFHMG3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813776; c=relaxed/simple;
	bh=/9gD+/Wc/CC9JjUtsx/lTRqi4Fvhs7dJ20+T6SyU8U0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ynzm1N1Y8504GdR5Iz8T7iHN2AQsoPPvlUw6LBIlkUPX2nahLLxm3b82+VWoN9HV6LNLHEAuGjRGVci/ynxiHko0vZzyAbMZyMuHtspbDzj6ei66f1SJuVLIeOsPrWlhZ8/jKaGFZp2OJXpMEQmyQjJ//pCAdHsFsWvj32wPNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Oib80RlP; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JC1CF2003623;
	Wed, 19 Jun 2024 11:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=x23EWGEyKjOe0Qc/
	jXb6Ajz+1je5uzQF9+45zSHX5fU=; b=Oib80RlPiMNrYeMEpd65hbYzqkqNAudH
	DsmRuUHqG7NYxotgH7foni8SVc5nBoMMSV/dphvmrvWEqKzax56FqKPMtFDleHJC
	+jv1/tb5pPtcW865dKAjUMDTMQ6K8r9BCufjfXh8ysAQCRxUrbuWnyyf6uQ+oAu0
	ByCV58GEUM4KxBFW1gEn389gR1Qq9j9rg/Lq6R8wTUsfpwlqWdfWQLjXLnnyCMoG
	sl9KvOWMvrLgAHTlsGIwPoYfdWSA06rA9+bcf63HMi/tpsyz6HIDTGipX3KAX23T
	Ue1KdtRakb+U/g4mYSTxbA9tkiT6rPMaJ3Fg3WeRt+60MLm2b3oCeg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yujb10wmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 11:16:09 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 17:16:08 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 19 Jun 2024 17:16:08 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CCB10820248;
	Wed, 19 Jun 2024 16:16:07 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Wed, 19 Jun 2024 17:16:02 +0100
Message-ID: <20240619161602.117452-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fwyS61R64BqESImpx5UxA0PTRM1INHs3
X-Proofpoint-GUID: fwyS61R64BqESImpx5UxA0PTRM1INHs3
X-Proofpoint-Spam-Reason: safe

The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
serial multi-instantiate driver which starts multiple Linux device
instances from a single ACPI Device() node.

As serial multi-instantiate is not an optional part of the system add it
as a dependency in Kconfig so that it is not overlooked.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 1252632f0ffa..731f4e99bc75 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -162,6 +162,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	select SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
@@ -178,6 +179,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	select SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
-- 
2.34.1


