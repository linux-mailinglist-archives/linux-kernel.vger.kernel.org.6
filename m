Return-Path: <linux-kernel+bounces-287689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7592952B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FA91F21119
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4819DF69;
	Thu, 15 Aug 2024 08:57:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE4017A932;
	Thu, 15 Aug 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712224; cv=none; b=nYB3KIouoaQ5eMHBHOCXtqsROeMdf0yR1UcI8DvDgRawrYKPrnkfGk9+N+fds2GjD3CzwsETR47zWnJYkpP07BPio0f2Oc53yjMYHODGo2bZ0Xw9TszNbz4PUNPUsTaHf5QM/iihHESk1MuwvaszabBZ71g2m3MEpRMR8u4+vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712224; c=relaxed/simple;
	bh=TjjSoIy4dECBRAWeAlnUcga0CRRquP2poJdfv7k/cQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSfNndDNGf/SKTYVG+VIkYrHuzUE4RK4QmUhzqQxJu1mBwOB+7txFq3mRBxs21lwef2gbWF+vNTWfuc7th504iuUsEXUxTBO+8j8/mJdMXCE3cT7QcQVF1jsi2854xKwzsbdjFmMKzHfm9KX0kWF03yMddnjkxowrmsS3JpsI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WkzQT5n8nzQpnV;
	Thu, 15 Aug 2024 16:52:17 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36EFE180106;
	Thu, 15 Aug 2024 16:56:53 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 16:56:52 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
CC: <AjitKumar.Pandey@amd.com>, <Syed.SabaKareem@amd.com>,
	<alpernebiyasak@gmail.com>, <liuyuntao12@huawei.com>, <posteuca@mutex.one>,
	<tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>,
	<lgirdwood@gmail.com>
Subject: [PATCH] ASoC: amd: acp: fix module autoloading
Date: Thu, 15 Aug 2024 08:49:23 +0000
Message-ID: <20240815084923.756476-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from platform_device_id table.

Fixes: 9d8a7be88b336 ("ASoC: amd: acp: Add legacy sound card support for Chrome audio")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index 47c3b5f167f5..0d529e32e552 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -227,6 +227,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.pm = &snd_soc_pm_ops,
-- 
2.34.1


