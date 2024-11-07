Return-Path: <linux-kernel+bounces-399207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBEF9BFC1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3D0B2285F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A56191F7A;
	Thu,  7 Nov 2024 01:59:45 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45247F4A;
	Thu,  7 Nov 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944785; cv=none; b=WglWeYWVrYICi9VA6bzSV57MEau5Kxn9wko6bGhIxwtK+ldA/Ty6i47QkID4QCaaPawPikCwEzf68xTeiTY6wipS1VuRbOUw7LnYzxcvlsrQ0ESAwYWIRUjsuFibJc0LxQhEL47rC3ZqJn/6IOGIr92NkKjeweROtqzx4Fozauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944785; c=relaxed/simple;
	bh=gF75NwQXvuqzlc8xFqKU9d+eCn3AU++kBtiobeRTiWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfUvtWXKuhODfJU60XpRyCCEss6InnsYNa70nbwhdlxu+QHEFvsHQcWQ+dDYaXWvj1lcLNkj7jZz2Budl6gsL8KdIQwSq/pX+6JgmnPe6l/MThn8l3Uyluetjs63XqD8csnRB9nbWcL/9hSF9VIWft+uvCijBNJZTzHwwhIl1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5672c1f0b79f-e27b1;
	Thu, 07 Nov 2024 09:59:39 +0800 (CST)
X-RM-TRANSID:2ee5672c1f0b79f-e27b1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3672c1f0aa48-4d18e;
	Thu, 07 Nov 2024 09:59:39 +0800 (CST)
X-RM-TRANSID:2ee3672c1f0aa48-4d18e
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: olivier.moysan@foss.st.com
Cc: arnaud.pouliquen@foss.st.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	luoyifan@cmss.chinamobile.com,
	perex@perex.cz,
	tiwai@suse.com
Subject: [PATCH] ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_div()
Date: Thu,  7 Nov 2024 09:59:36 +0800
Message-Id: <20241107015936.211902-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
References: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 7bc4a96b7..43fb1dcb9 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -317,7 +317,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
 	int div;
 
 	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
-	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
+	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
 		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
-- 
2.27.0




