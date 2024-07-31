Return-Path: <linux-kernel+bounces-268424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CC942487
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2119228524D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F916426;
	Wed, 31 Jul 2024 02:39:03 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FC14F70;
	Wed, 31 Jul 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393543; cv=none; b=MLXFGCfJa32ZFbA2BvFsD3ZRXvG+v5ZqVun/7yc+JEY1Ak1/VP0IeI+2BMiX6mKMe8OBGDQHJ0gSWtbaXWM4xaPy6HjTl+i51iXtxb9/wFqJHtjSFCqepAU3USSFzDWAA+pygIIcqAewFy8CnGKTKJZMN14Si4L23gvZ7wffJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393543; c=relaxed/simple;
	bh=u5QbBOsv0qQWNCKCfryxh7VHTlVZB5DaCf9udjhHYmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q39FJ/gmvk4WJnnPhpSU7fml72SLY8DdVS0b81H3zU9uKbdm9nci4753K6jS1hJSY/yT8X0WvBJCD1QjHC/BWdtPUv3Sl1yaUvbT6bLQtTG6ra5Eripvw7AJHY1HShaEJric1L27scEt6oqhA6JFPv/Os1vax1xkK/QfM261bLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WYblY1pqTzQnMR;
	Wed, 31 Jul 2024 10:34:33 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D2C50180101;
	Wed, 31 Jul 2024 10:38:51 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 10:38:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jonathan.downing@nautel.com>, <piotr.wojtaszczyk@timesys.com>,
	<vz@mleia.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: fsl: lpc3xxx-i2s: Remove set but not used variable 'savedbitclkrate'
Date: Wed, 31 Jul 2024 10:29:49 +0800
Message-ID: <20240731022949.135016-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

The variable savedbitclkrate is assigned and never used, so can be removed.

sound/soc/fsl/lpc3xxx-i2s.c:42:13: warning: variable ‘savedbitclkrate’ set but not used [-Wunused-but-set-variable]

Fixes: 0959de657a10 ("ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/lpc3xxx-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
index af995ca081a3..62ef624d6dd4 100644
--- a/sound/soc/fsl/lpc3xxx-i2s.c
+++ b/sound/soc/fsl/lpc3xxx-i2s.c
@@ -39,7 +39,7 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clky, int freq, int xbytes, u3
 {
 	u32 i2srate;
 	u32 idxx, idyy;
-	u32 savedbitclkrate, diff, trate, baseclk;
+	u32 diff, trate, baseclk;
 
 	/* Adjust rate for sample size (bits) and 2 channels and offset for
 	 * divider in clock output
@@ -53,14 +53,12 @@ static void __lpc3xxx_find_clkdiv(u32 *clkx, u32 *clky, int freq, int xbytes, u3
 
 	/* Find the best divider */
 	*clkx = *clky = 0;
-	savedbitclkrate = 0;
 	diff = ~0;
 	for (idxx = 1; idxx < 0xFF; idxx++) {
 		for (idyy = 1; idyy < 0xFF; idyy++) {
 			trate = (baseclk * idxx) / idyy;
 			if (abs(trate - i2srate) < diff) {
 				diff = abs(trate - i2srate);
-				savedbitclkrate = trate;
 				*clkx = idxx;
 				*clky = idyy;
 			}
-- 
2.34.1


