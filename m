Return-Path: <linux-kernel+bounces-191671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6E8D1270
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9581D1F221A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1913FEE;
	Tue, 28 May 2024 03:09:25 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097C10A3E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865764; cv=none; b=hpLX9t5qS/+aM2CiydYFdKXsarGuIVnSC1SAdwMVM+6IE/YgyOzCckGU7EUAlclBWsF2kNCDJt6Bgha+J8Eqn3cB/EAu5ZGlJp3dkG1WjSS0wyD8GmA4lFp04RLjdSWClvM3s88vVjAKj2AawNPetsw55eH0XDT8tM4hUgvVYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865764; c=relaxed/simple;
	bh=jZ4nm2tq08j6x7UOKHDDf9E1M3TFeJumzt55PcVdq/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qP6oG6bBo8RnkT5oDcrkkJRjZYBVsIM6hiA0nBgiihSptbaYL0eCRXsFc2vBD9Q/Ysh73JHFI/egAC3sqW9epNOs7IPYp6ostTavpaQP4WT4roKXHrVnjDoasMjXLj7EOdqreT0rFTePCDuyjGsOv2Z2ulQm/EExZCpXFgkPT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACnrRHESlVmaI7cBw--.37955S2;
	Tue, 28 May 2024 11:08:53 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sre@kernel.org,
	michael.riesch@wolfvision.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/panel: sitronix-st7789v: Add check for of_drm_get_panel_orientation
Date: Tue, 28 May 2024 11:08:32 +0800
Message-Id: <20240528030832.2529471-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnrRHESlVmaI7cBw--.37955S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1xCF1xJr48CFW7uF4rXwb_yoWkXrX_C3
	WUZF9rXr90kryv9rnrZa15XF92vFs5uF4v9w18KasrCF15G3ZrZay0gry5Z3y8X3WUC3s8
	Jan5ZFWakF47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JU-miiUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of of_drm_get_panel_orientation() and
return the error if it fails in order to catch the error.

Fixes: b27c0f6d208d ("drm/panel: sitronix-st7789v: add panel orientation support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 88e80fe98112..8b15e225bf37 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -643,7 +643,9 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	ret = of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
 
 	drm_panel_add(&ctx->panel);
 
-- 
2.25.1


