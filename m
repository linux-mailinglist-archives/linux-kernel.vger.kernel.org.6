Return-Path: <linux-kernel+bounces-417769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCB9D58E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007301F22E71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828316133C;
	Fri, 22 Nov 2024 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nicho1as.wang header.i=me@nicho1as.wang header.b="Lu9CpxVg"
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689932309A3;
	Fri, 22 Nov 2024 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250726; cv=fail; b=q6V2tmORxJv9R7nIphjYv+sRhu9M67//oOnr/IFwmBz32dZJDm4Rt7+LopSQhShBhZhcusFVAZtsqro2cDK8OPq0unecJG9MFj2F4grFY+9Afi8wY8NmE8m75hi46ORFLWE24DBWoVm3we80TVADmmf7xzLYWP17/rh81LmH/5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250726; c=relaxed/simple;
	bh=JUcA1bOHvmnjxCTM53VB17ECRxLFSgxf9W89YDNqZq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8W0ECl7nPw2ftWkuKDCINBIQZS4tzAffYuZKrRS8i7WJRpBWlJcSwKz/JbkIHfpyPb1XQ2UqrxbjlzXO26/ONk17VTW/D7wL2/5wPDGhuzVd3Vgu+m4MUb1sVz/SsSfsEVvOsiIg5xE1Gb5Yr6w7xm0OnKb5aYi9F/87leC84g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nicho1as.wang; spf=pass smtp.mailfrom=nicho1as.wang; dkim=pass (1024-bit key) header.d=nicho1as.wang header.i=me@nicho1as.wang header.b=Lu9CpxVg; arc=fail smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nicho1as.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nicho1as.wang
ARC-Seal: i=1; a=rsa-sha256; t=1732250710; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MQePpJv34rjDABlajgoPa4g3Vyh99KtXy+QQUm9/ZAQdCtUOBmxaI8kmAS2KMTpXTlktoS1k3ashr/pDsPTgMA3N+OlXQTIGO64rTHe9XxhevTPCx9eUEmAArxnktLcoX/4H9ZidCsd//3FGpGyiWNd3o9dLG2owD6RZ8fboq6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732250710; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:Message-Id:Reply-To:To; 
	bh=l6oCEtHqP/NOgK6DqPuGbdGaj2Iw5tZNALBVL95StJ4=; 
	b=HU4IJeCy5yMNr1hdn6jtHq11rlsVGNjx/YFPTJ/sprZwgm7H5789fhWgBSrruXO4MC9CUiP17iLNtIO40UCsDtH2MYjEj7ECWYG7BOgNo7gAX79bN+MLHQF0v1mhNtnIzAOBTAMND+Nu5ZBnKnYwpW2G30EdlWtESHXGxLUmN50=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=nicho1as.wang;
	spf=pass  smtp.mailfrom=me@nicho1as.wang;
	dmarc=pass header.from=<me@nicho1as.wang>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732250710;
	s=zoho; d=nicho1as.wang; i=me@nicho1as.wang;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l6oCEtHqP/NOgK6DqPuGbdGaj2Iw5tZNALBVL95StJ4=;
	b=Lu9CpxVgN2RcigGNm3PulZzQYJZgeXLSr79v0BV6pFkHOcGj6lupMLHPlKQvSqaN
	19D79isPQ/3P+HPTbQWEIO9CD/8U5Ew7HqH2yJCfN2nG4zyEHDoBqQiypZc4NGcUD0x
	N8l/neB7yV1J6+sI/zqIgkakMOQsxn4XqImoEypM=
Received: by mx.zohomail.com with SMTPS id 1732250707256147.57707776680536;
	Thu, 21 Nov 2024 20:45:07 -0800 (PST)
From: Nicholas Wang <me@nicho1as.wang>
To: 
Cc: Nicholas Wang <me@nicho1as.wang>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Support HP Elite Dragonfly 13.5 inch G4
Date: Thu, 21 Nov 2024 22:44:25 -0600
Message-ID: <20241122044435.28061-1-me@nicho1as.wang>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This laptop needs to be supported via the configuration table.

Signed-off-by: Nicholas Wang <me@nicho1as.wang>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 61d231483..c97b8f808 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -52,6 +52,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "103C8A30", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8A31", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8A6E", 4, EXTERNAL, { CS35L41_LEFT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_RIGHT }, 0, -1, -1, 0, 0, 0 },
+	{ "103C8B63", 4, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, -1, -1, 0, 0, 0 },
 	{ "103C8BB3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8BB4", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8BDD", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
@@ -467,6 +468,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "103C8A30", generic_dsd_config },
 	{ "CSC3551", "103C8A31", generic_dsd_config },
 	{ "CSC3551", "103C8A6E", generic_dsd_config },
+	{ "CSC3551", "103C8B63", generic_dsd_config },
 	{ "CSC3551", "103C8BB3", generic_dsd_config },
 	{ "CSC3551", "103C8BB4", generic_dsd_config },
 	{ "CSC3551", "103C8BDD", generic_dsd_config },
-- 
2.47.0


