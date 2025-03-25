Return-Path: <linux-kernel+bounces-574951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184FA6EBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0941895376
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6B194A59;
	Tue, 25 Mar 2025 08:47:23 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D1481B6;
	Tue, 25 Mar 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892443; cv=none; b=Q3ux+Y/6moKQX51gBCrCGWhdOgdLapTy9o2GWmg/dMcXT469OCC+5M4z2C0JGOE53T/J81jt0IIaZUzBlw2GQ/KgezcVptx/A3dxp7/vqtO//i3jsUpVqPHU4eu/devv15fSGZu2MT7y+yWXl9Qp8i0EWOI3Ff1FCpL6ONOoAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892443; c=relaxed/simple;
	bh=9fXQ7OLrIwmyKrFG9EsUSvhJbHHhomXNiCW6EUBSm0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SOKqId7vZl+2mlxEBFreO6B4PG9gs+/Up11mPTuWqgfZHZy0dH+R9rE74fjQrhmWdXmVlHlDGjYb9nexcZsz7y7weTVLwERnI5XC5ugQK39nGFrJ4MWyyxQILIkEdi94GDqvoLW5d/+Grm/Li8B/Y/I7Hi22ICvTy1GF/8Y3HzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAA3cAiMbeJnwA1JAQ--.35438S2;
	Tue, 25 Mar 2025 16:47:08 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ALSA: hda: cs35l56: Remove unnecessary NULL check before release_firmware()
Date: Tue, 25 Mar 2025 16:46:39 +0800
Message-Id: <20250325084639.801054-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3cAiMbeJnwA1JAQ--.35438S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18ZF4ktr4xXry8JFy8Grg_yoWfArX_u3
	4vkr1UGFy8t3yDXw17Zr13ZryrG398WryfGrnFyayUXF97Gw4Sqr1Uua90va48W3yxKFyf
	AF18A3yDC3s8XjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbo7K3UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

release_firmware() checks for NULL pointers internally.
Remove unneeded NULL check for fmw here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/pci/hda/cs35l56_hda.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 4ef7878e8fd4..235d22049aa9 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -546,12 +546,10 @@ static void cs35l56_hda_release_firmware_files(const struct firmware *wmfw_firmw
 					       const struct firmware *coeff_firmware,
 					       char *coeff_filename)
 {
-	if (wmfw_firmware)
-		release_firmware(wmfw_firmware);
+	release_firmware(wmfw_firmware);
 	kfree(wmfw_filename);
 
-	if (coeff_firmware)
-		release_firmware(coeff_firmware);
+	release_firmware(coeff_firmware);
 	kfree(coeff_filename);
 }
 
-- 
2.25.1


