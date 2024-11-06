Return-Path: <linux-kernel+bounces-397391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084319BDB68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F5D1C22C92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A618B463;
	Wed,  6 Nov 2024 01:47:12 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A205C33F3;
	Wed,  6 Nov 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857632; cv=none; b=a7W0W9rULinOkX8KEZY32yPffMACFH0R3iYN2U7P0uj+4DqLqFMYh+jXrPS9BKsV9RcGsEj2Q5Nj7fK+xh0i0zw9V4i3kKKlPCOFTDcLoNpDVVE+YYkYRVZPtVRPMIih2C19FCD6cBj8nB3XzZMI7Q504qaKemxaXE9f5f2d+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857632; c=relaxed/simple;
	bh=Jmh7hAfq7x6IE02zgauPXYpMKfE0SlyqAJ49inRowtg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOub5SvFpCfrNgNlP9dMtqNG0wDLTtFOVCGUSQQzYaaoIOizW4QriMGMylyNaMrZP2RANdKY/QC6fRRP1i+NBV3Ou5+Qvx8ctGrhhzchixcGJKuILDTLfNj2rAMBgFbcuyAucbN6J7DDJ5zko+eIwG1WmN6pMNyR5sQy47+hNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2672aca905fa-0f612;
	Wed, 06 Nov 2024 09:46:58 +0800 (CST)
X-RM-TRANSID:2ee2672aca905fa-0f612
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1672aca907d5-09b81;
	Wed, 06 Nov 2024 09:46:58 +0800 (CST)
X-RM-TRANSID:2ee1672aca907d5-09b81
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ASoC: stm: Prevent potential division by zero in stm32_sai_mclk_round_rate()
Date: Wed,  6 Nov 2024 09:46:54 +0800
Message-Id: <20241106014654.206860-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation (*prate / div) is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 7bc4a96b7..2570daa3e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -378,8 +378,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.27.0




