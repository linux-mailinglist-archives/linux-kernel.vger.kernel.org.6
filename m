Return-Path: <linux-kernel+bounces-184338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B588CA5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8401F226DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237628C13;
	Tue, 21 May 2024 01:12:43 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADB7F;
	Tue, 21 May 2024 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253962; cv=none; b=RRTN+rxopU2IXBX/WwEL7UqiCNEeWK+XDeiMlGNZa6bQhPClNKKnLvYgox6H/LTcMH0lKj6oHOvBtoqoLOW3X2efXjEH0zw27ydfMTbgcDFUV83FZgdK0rvUMTYESji1oVuXhhmPJeeEq/eWetjOHmfwUjnVovaRLYY/18AZfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253962; c=relaxed/simple;
	bh=mUJ68N6msczBB9C/8LlQHDYjFu+UJe5YHP1HFLKiZyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nC0p42FF/Qn2BqcTqaevU33RmSku0DjBi5mXkbVqrg3hk4Ly/0F3v7AJ4w+35Sc7M5qHU8XbLYV9xyGwil96Se6rSbaQrOEb+/DxTpHdtXapxd4lgicMexJh3ZTEflNnGhZbLg28enErC95Qe5fgI1TMC3DXiHiDFmvHghryqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABXXhoe80tmEMlyBg--.49483S2;
	Tue, 21 May 2024 09:04:30 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ALSA: scarlett2: Prevent leaking urb
Date: Tue, 21 May 2024 09:03:52 +0800
Message-Id: <20240521010352.1082164-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXXhoe80tmEMlyBg--.49483S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr43XryUAw4UCw45Ar45GFg_yoWfXwc_Wa
	yI9w1DAF1DWrnIkry5CrWSvF40kwnrAF18uFsI9397tF9Fq34rtw1Iqrn8CF1xZFs5JF4D
	Xrn7Z343try29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVWkMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUFVyIUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

In scarlett2_init_notify() if kmalloc() fails the allocated urb should
be released.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/usb/mixer_scarlett2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 1150cf104985..4cad6b2a0292 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -8637,9 +8637,10 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 		return -ENOMEM;
 
 	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
-	if (!transfer_buffer)
+	if (!transfer_buffer) {
+		usb_free_urb(mixer->urb);
 		return -ENOMEM;
-
+	}
 	usb_fill_int_urb(mixer->urb, dev, pipe,
 			 transfer_buffer, private->wMaxPacketSize,
 			 scarlett2_notify, mixer, private->bInterval);
-- 
2.25.1


