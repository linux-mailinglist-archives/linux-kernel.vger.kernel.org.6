Return-Path: <linux-kernel+bounces-301116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091795EC88
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4279D281BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1C145B01;
	Mon, 26 Aug 2024 08:57:42 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3B13D532;
	Mon, 26 Aug 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662661; cv=none; b=RHUMfSjgdPjN4W8T+Z5TWGO+YrhSQRfc3gzdivAZPlkjMxJmGqEXKyd1AV3rOzItwhCap4YucascyUby2m9RIqO7fjeIRe2tT+/cCPPV3R4TX16qzQDXITOuac3ReCnXalN60EdUVN47C1LlrMHX01P8sR5sFhjH3uNUHiA1iZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662661; c=relaxed/simple;
	bh=z1HFNNdFqZGfGNDw6EeA7y8hXdBijGmmkHWO4/tSfe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVCfok830YvKiWNfyXQvLrBcsJrdj0xkFZ3WM96kD28S6Jp2yYT+arXiUi3gpmawnaezYwpgR/hdgQAcU3RGUvYTmjVZXu2jw7nptziBXrVLG9vYUIbsAlZdKe+YVkh1MP920nyrxEZ2tfSRfmT7RgvAw+5KKw3fgYf4LUA3P2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wsl1L6bxLz1S8ww;
	Mon, 26 Aug 2024 16:57:26 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 296BC140120;
	Mon, 26 Aug 2024 16:57:36 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 16:57:35 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <cezary.rojewski@intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<kai.vehmanen@linux.intel.com>, <liaochen4@huawei.com>,
	<u.kleine-koenig@pengutronix.de>, <andy.shevchenko@gmail.com>,
	<kuninori.morimoto.gx@renesas.com>, <robh@kernel.org>
Subject: [PATCH -next 4/4] ASoC: fix module autoloading
Date: Mon, 26 Aug 2024 08:49:24 +0000
Message-ID: <20240826084924.368387-5-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826084924.368387-1-liaochen4@huawei.com>
References: <20240826084924.368387-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 sound/soc/codecs/chv3-codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/chv3-codec.c b/sound/soc/codecs/chv3-codec.c
index ab99effa6874..40020500b1fe 100644
--- a/sound/soc/codecs/chv3-codec.c
+++ b/sound/soc/codecs/chv3-codec.c
@@ -26,6 +26,7 @@ static const struct of_device_id chv3_codec_of_match[] = {
 	{ .compatible = "google,chv3-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, chv3_codec_of_match);
 
 static struct platform_driver chv3_codec_platform_driver = {
 	.driver = {
-- 
2.34.1


