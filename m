Return-Path: <linux-kernel+bounces-574955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB19A6EBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC541893603
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F81A0BCF;
	Tue, 25 Mar 2025 08:50:03 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BC19539F;
	Tue, 25 Mar 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892603; cv=none; b=lWZS125hIpGzqICtAfiWE6cwxRRuHJJLXHwBtSSy1HCTFjptkG857of8IxmhFjelFx0BKirLGzBS14rswqW5CenNCA6OHP1WikwuElvIagBQrKeM59+sN+d75MUpTN/tgVW5eEAL9xW5/3w/sggsX+n1b97lZmT65L6mq9AliZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892603; c=relaxed/simple;
	bh=FfUABFV3Rho9t3XDs2Bwqr8KWC+RMXbPAWjmd5zovqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SNE83Qfk1PGZ15H83ExEpP/Ov61pSbTAgy7N1hXyGer1J86/FI44vvrI8Is6mJpLN7ae0WOURFQw6LqIUkbjoCLV8IjxOPP2yP3cnDKpos1mAXvuZQNsQIPOjn0p2Ey706lYrtCZ18A7q9qTz4LRLd+qYd29IeuNwttvvf3Ub/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABHhg4wbuJnzkdJAQ--.5332S2;
	Tue, 25 Mar 2025 16:49:53 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ALSA: hda: tas2781-i2c: Remove unnecessary NULL check before release_firmware()
Date: Tue, 25 Mar 2025 16:49:39 +0800
Message-Id: <20250325084939.801117-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHhg4wbuJnzkdJAQ--.5332S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18ZF4ktr4xXry8Cry7Awb_yoW3CFc_CF
	s5Gr1kWF18X39rZa13AF1Y9ryfXasrZ34xXr1fKFWUJa97ta1Fg34UCF1DuFW5urW8ArnI
	9r1DAFyDAryqgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUgAwsUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

release_firmware() checks for NULL pointers internally.
Remove unneeded NULL check for fmw here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/pci/hda/tas2781_hda_i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 50c5e5f26589..9ed49b0dbe6b 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -753,8 +753,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 
 out:
 	mutex_unlock(&tas_hda->priv->codec_lock);
-	if (fmw)
-		release_firmware(fmw);
+	release_firmware(fmw);
 	pm_runtime_mark_last_busy(tas_hda->dev);
 	pm_runtime_put_autosuspend(tas_hda->dev);
 }
-- 
2.25.1


