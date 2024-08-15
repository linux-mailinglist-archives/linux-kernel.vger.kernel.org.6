Return-Path: <linux-kernel+bounces-287735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A65952C08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894EB2853FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17171C3780;
	Thu, 15 Aug 2024 09:20:49 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA51C0DD1;
	Thu, 15 Aug 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713649; cv=none; b=SZ4gf0C60NH/seHrzsM1cOtFJ31H7a1rxDA2HCLB1On3CyBwgHRguQ4ey2gDF6wXikK240c57shh6/lMmYKZGdSjfld5VsW83o0uoDdNoAvj5nQ+UcGGzTKypt+/bz1KLSTX5JB0Ru8FDcDSJLYt8EPgaDH83/t2sm+rEC0qqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713649; c=relaxed/simple;
	bh=ST6a5vH7w+QtanmK1XPyD0jNi92XCM4P5LKwPcEWtbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7FH6VetskDTDXUge141YmfxjjPqlPaMmbLgZpn7AAvrXl6XwDkdCbIxZv8+pYdeNis1mHeWLSObOd8tnn6R84uIXcJE4+iArbUeam7hNd1+brU/3qpWh+KAFnkw9u4HZyIzfpUzQJ0yasuuZjo/PmZrUFpPxCRU16dFryJerxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wkzxy49FgzQppJ;
	Thu, 15 Aug 2024 17:16:06 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 043A61800A5;
	Thu, 15 Aug 2024 17:20:42 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 17:20:41 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>
CC: <tanureal@opensource.cirrus.com>, <tiwai@suse.com>, <perex@perex.cz>,
	<rf@opensource.cirrus.com>, <david.rhodes@cirrus.com>,
	<liuyuntao12@huawei.com>
Subject: [PATCH] ALSA: hda: cs35l41: fix module autoloading
Date: Thu, 15 Aug 2024 09:13:12 +0000
Message-ID: <20240815091312.757139-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from spi_device_id table.

Fixes: 7b2f3eb492dac ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 sound/pci/hda/cs35l41_hda_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index b76c0dfd5fef..f8c356ad0d34 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -38,6 +38,7 @@ static const struct spi_device_id cs35l41_hda_spi_id[] = {
 	{ "cs35l41-hda", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, cs35l41_hda_spi_id);
 
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{ "CSC3551", 0 },
-- 
2.34.1


